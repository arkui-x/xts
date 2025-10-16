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
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import Want from '@ohos.app.ability.Want';
import { getEnumCount } from './utils';

let delegator: abilityDelegatorRegistry.AbilityDelegator = abilityDelegatorRegistry.getAbilityDelegator()
const bundleName = abilityDelegatorRegistry.getArguments().bundleName;

export default function graphicsDrawingTest() {
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
    })
    beforeEach(async () => {
    })
    afterEach(async () => {
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_0100
     * @tc.name      : testPathIsClosedNormal0001
     * @tc.desc      : testPathIsClosedNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathIsClosedNormal0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPathIsClosedNormal0001';

      try {
        let path: drawing.Path = new drawing.Path();
        let close = path.isClosed();
        expect(close).assertEqual(false);

        path.moveTo(0, 0);
        path.lineTo(0, 100);
        path.lineTo(200, 350);
        close = path.isClosed();
        expect(close).assertEqual(false);

        path.close();
        close = path.isClosed();
        expect(close).assertEqual(true);

      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_0200
     * @tc.name      : testPathIsClosedMultipleCalls0002
     * @tc.desc      : testPathIsClosedMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathIsClosedMultipleCalls0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathIsClosedMultipleCalls0002';
      const path = new drawing.Path();

      try {
        for (let i = 0; i < 20; i += 1) {
          let close = path.isClosed();
          expect(close).assertEqual(false);
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_0300
     * @tc.name      : testPathOffsetNormal0003
     * @tc.desc      : testPathOffsetNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathOffsetNormal0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathOffsetNormal0003';
      const maxVal = Number.MAX_VALUE;

      try {
        const path = new drawing.Path();
        path.offset(200, 200);

        path.moveTo(200, 200);
        path.lineTo(300, 300);
        path.offset(200, 200);

        path.offset(100.1, 100.1);

        path.offset(-200, 200);

        path.offset(200, -200);

        path.offset(maxVal, maxVal);

        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_0400
     * @tc.name      : testPathOffsetToNull0004
     * @tc.desc      : testPathOffsetToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathOffsetToNull0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathOffsetToNull0004';
      const path = new drawing.Path();
      const dst = new drawing.Path();

      try {
        path.offset(null, 200);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.offset(200, null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.offset(undefined, 200);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.offset(200, undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_0500
     * @tc.name      : testPathOffsetMultipleCalls0005
     * @tc.desc      : testPathOffsetMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathOffsetMultipleCalls0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathOffsetMultipleCalls0005';
      try {
        for (let i = 0; i < 20; i += 1) {
          const path = new drawing.Path();
          path.offset(Math.random(), Math.random());
        }
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_0600
     * @tc.name      : testPathIsRectNormal0006
     * @tc.desc      : testPathIsRectNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathIsRectNormal0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPathIsRectNormal0006';
      let path = new drawing.Path();
      try {
        let isRect = path.isRect(null);
        console.info(msg + `path isRect success`);
        expect(isRect).assertEqual(false);
      } catch (e) {
        console.info(msg + `path isRect error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      let rect: common2D.Rect = { left : 0, top : 0, right : 100, bottom : 100 };
      path.moveTo(100, 100)
      path.lineTo(100, 300);
      path.lineTo(300, 300);
      try {
        let isRect2 = path.isRect(rect);
        console.info(msg + `path isRect2 success`);
        expect(isRect2).assertEqual(false);
      } catch (e) {
        console.info(msg + `path isRect2 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      path.lineTo(300, 100);
      path.close();
      try {
        let isRect3 = path.isRect(rect);
        console.info(msg + `path isRect3 success`);
        expect(isRect3).assertEqual(true);
      } catch (e) {
        console.info(msg + `path isRect3 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      rect = { left : 0, top : 125, right : 100, bottom : 225 };
      path.reset()
      let rect11: common2D.Rect = {
        left: 200,
        top: 500,
        right: 400,
        bottom: 700
      };
      let roundRec11: drawing.RoundRect = new drawing.RoundRect(rect11, 20, 20);
      path.addRoundRect(roundRec11);
      try {
        let isRect4 = path.isRect(rect);
        console.info(msg + `path isRect4 success`);
        expect(isRect4).assertEqual(false);
      } catch (e) {
        console.info(msg + `path isRect4 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      rect = { left : 200, top : 125, right : 500, bottom : 425 };
      path.reset()
      roundRec11 = new drawing.RoundRect(rect11, 0, 0);
      path.addRoundRect(roundRec11);
      try {
        let isRect5 = path.isRect(rect);
        console.info(msg + `path isRect5 success`);
        expect(isRect5).assertEqual(true);
      } catch (e) {
        console.info(msg + `path isRect5 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_0700
     * @tc.name      : testPathIsRectMultipleCalls0007
     * @tc.desc      : testPathIsRectMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathIsRectMultipleCalls0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathIsRectMultipleCalls0007';
      let path = new drawing.Path();
      let rect: common2D.Rect = { left : 0, top : 125, right : 100, bottom : 225 };
      path.addRect(rect);
      for (let i = 0; i < 20; i += 1) {
        try {
          let isRect = path.isRect(rect);
          console.info(msg + `path isRect success step: ` + i);
          console.info(msg + 'isRect : ', isRect + 'step: ' + i);
          expect(isRect).assertEqual(true);
        } catch (e) {
          console.info(msg + `path isRect error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_0800
     * @tc.name      : testPathIsRectToNull0008
     * @tc.desc      : testPathIsRectToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathIsRectToNull0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathIsRectToNull0008';
      let path = new drawing.Path();
      try {
        path.isRect(undefined);
        console.info(msg + `path isRect success `);
        expect().assertFail()
      } catch (e) {
        // console.info(msg + `path isRect error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_0900
     * @tc.name      : testPathResetNormal0009
     * @tc.desc      : testPathResetNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathResetNormal0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPathResetNormal0009';
      try {
        let path = new drawing.Path();
        path.reset();
        console.info(msg + 'reset successed');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_1000
     * @tc.name      : testPathResetMultipleCalls0010
     * @tc.desc      : testPathResetMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathResetMultipleCalls0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathResetMultipleCalls0010';
      let path = new drawing.Path();
      try {
        for (let index = 0; index < 20; index++) {
          path.cubicTo(10, 10, 10, 10, 15, 15);
          path.reset();
        }
        path.close()
        console.info(msg + 'reset successed');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }

      try {
        path.cubicTo(10, 10, 10, 10, 15, 15);
        for (let index = 0; index < 20; index++) {
          path.reset();
        }
        path.close()
        console.info(msg + 'reset successed');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_1100
     * @tc.name      : testPathRewindNormal0011
     * @tc.desc      : testPathRewindNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathRewindNormal0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPathRewindNormal0011';
      let path = new drawing.Path();
      try {
        path.rewind();
        console.info(msg + `path rewind  success`);
        let empty = path.isEmpty();
        console.info(msg + 'empty : ', empty);
        expect(empty).assertEqual(true);
      } catch (e) {
        console.info(msg + `path rewind 1 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      path.moveTo(100, 100)
      path.lineTo(100, 300);
      path.lineTo(300, 300);
      try {
        path.rewind();
        console.info(msg + `path 2 rewind  success`);
        let empty2 = path.isEmpty();
        console.info(msg + 'empty2 : ', empty2);
        expect(empty2).assertEqual(true);
      } catch (e) {
        console.info(msg + `path rewind 2 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_1200
     * @tc.name      : testPathRewindMultipleCalls0012
     * @tc.desc      : testPathRewindMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathRewindMultipleCalls0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathRewindMultipleCalls0012';
      let path = new drawing.Path();
      for (let i = 0; i < 20; i += 1) {
        try {
          path.rewind()
          console.info(msg + `path rewind success step: ` + i);
          let empty = path.isEmpty();
          console.info(msg + 'empty : ', empty + 'step: ' + i);
          expect(empty).assertEqual(true);
        } catch (e) {
          console.info(msg + `path rewind error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_1300
     * @tc.name      : testPathIsEmptyNormal0013
     * @tc.desc      : testPathIsEmptyNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathIsEmptyNormal0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPathIsEmptyNormal0013';
      let path = new drawing.Path();
      try {
        let empty = path.isEmpty();
        console.info(msg + `path isEmpty success`);
        console.info(msg + 'empty : ', empty);
        expect(empty).assertEqual(true);
      } catch (e) {
        console.info(msg + `path isEmpty error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      path.moveTo(100, 100)
      path.lineTo(100, 300);
      path.lineTo(300, 300);
      try {
        let empty2 = path.isEmpty();
        console.info(msg + `path empty2 success`);
        console.info(msg + 'empty2 : ', empty2);
        expect(empty2).assertEqual(false);
      } catch (e) {
        console.info(msg + `path empty2 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      try {
        path.rewind()
        let empty3 = path.isEmpty();
        console.info(msg + `path empty3 success`);
        console.info(msg + 'empty3 : ', empty3);
        expect(empty3).assertEqual(true);
      } catch (e) {
        console.info(msg + `path empty3 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
      path.moveTo(100, 100)
      path.lineTo(100, 300);
      path.lineTo(300, 300);
      path.close()
      try {
        let empty4 = path.isEmpty();
        console.info(msg + `path empty4 success`);
        console.info(msg + 'empty4 : ', empty4);
        expect(empty4).assertEqual(false);
      } catch (e) {
        console.info(msg + `path empty4 error. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_1400
     * @tc.name      : testPathIsEmptyMultipleCalls0014
     * @tc.desc      : testPathIsEmptyMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathIsEmptyMultipleCalls0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathIsEmptyMultipleCalls0014';
      let path = new drawing.Path();
      for (let i = 0; i < 20; i += 1) {
        try {
          let empty = path.isEmpty();
          console.info(msg + `path isEmpty success step: ` + i);
          console.info(msg + 'empty : ', empty + 'step: ' + i);
          expect(empty).assertEqual(true);
        } catch (e) {
          console.info(msg + `path isEmpty error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_1500
     * @tc.name      : testPathGetLengthNormal0015
     * @tc.desc      : testPathGetLengthNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathGetLengthNormal0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPathGetLengthNormal0015';

      try {
        let path = new drawing.Path();
        let len = path.getLength(false);
        expect(len).assertEqual(0);

        path.moveTo(0, 0);
        path.arcTo(20, 20, 180, 180, 180, 90);
        len = path.getLength(false);
        expect(len).assertEqual(227.4411163330078);

        len = path.getLength(true);
        expect(len).assertEqual(329.4215087890625);

        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_1600
     * @tc.name      : testPathGetLengthMultipleCalls0016
     * @tc.desc      : testPathGetLengthMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathGetLengthMultipleCalls0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathGetLengthMultipleCalls0016';

      try {
        let path = new drawing.Path();
        for (let i = 0; i < 20; i += 1) {
          let len = path.getLength(true);
          expect(len).assertEqual(0);
        }

        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_1700
     * @tc.name      : testPathGetLengthToNull0017
     * @tc.desc      : testPathGetLengthToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathGetLengthToNull0017', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathGetLengthToNull0017';

      try {
        let path = new drawing.Path();
        path.getLength(null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        let path = new drawing.Path();
        path.getLength(undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_1800
     * @tc.name      : testPathGetPositionAndTangentNormal0018
     * @tc.desc      : testPathGetPositionAndTangentNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathGetPositionAndTangentNormal0018', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathGetPositionAndTangentNormal0018';

      try {
        let path = new drawing.Path();
        let distance = path.getPositionAndTangent(false, 100, {
          x: 20, y: 20
        }, {
          x: 200, y: 200
        });
        expect(distance).assertEqual(false);
        path.moveTo(0, 0);
        path.lineTo(100, 100);
        distance = path.getPositionAndTangent(true, 30.1, {
          x: 20.1, y: 20.1
        }, {
          x: 200.1, y: 200.1
        });
        expect(distance).assertEqual(true);
        distance = path.getPositionAndTangent(true, 80, {
          x: -20.1, y: -20.1
        }, {
          x: 200.1, y: 200.1
        });
        expect(distance).assertEqual(true);
        distance = path.getPositionAndTangent(true, 100, {
          x: 200.1, y: 200.1
        }, {
          x: -200.1, y: -200.1
        })
        expect(distance).assertEqual(true);
        distance = path.getPositionAndTangent(true, -1, {
          x: 200.1, y: 200.1
        }, {
          x: 600.1, y: 600.1
        })
        expect(distance).assertEqual(true);
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_1900
     * @tc.name      : testPathGetPositionAndTangentMultipleCalls0019
     * @tc.desc      : testPathGetPositionAndTangentMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathGetPositionAndTangentMultipleCalls0019', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathGetPositionAndTangentMultipleCalls0019';

      try {
        let path = new drawing.Path();
        for (let i = 0; i < 20; i += 1) {
          let distance = path.getPositionAndTangent(false, 100, {
            x: 20, y: 20
          }, {
            x: 200, y: 200
          });
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_2000
     * @tc.name      : testPathGetPositionAndTangentToNull0020
     * @tc.desc      : testPathGetPositionAndTangentToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathGetPositionAndTangentToNull0020', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathGetPositionAndTangentToNull0020';
      const path = new drawing.Path();

      try {
        path.getPositionAndTangent(null, 100, {
          x: 20, y: 20
        }, {
          x: 200, y: 200
        });
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.getPositionAndTangent(false, null, {
          x: 20, y: 20
        }, {
          x: 200, y: 200
        });
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.getPositionAndTangent(false, 100, null, {
          x: 200, y: 200
        });
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.getPositionAndTangent(false, 100, {
          x: 20, y: 20
        }, null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.getPositionAndTangent(undefined, 100, {
          x: 20, y: 20
        }, {
          x: 200, y: 200
        });
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.getPositionAndTangent(false, undefined, {
          x: 20, y: 20
        }, {
          x: 200, y: 200
        });
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.getPositionAndTangent(false, 100, undefined, {
          x: 200, y: 200
        });
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.getPositionAndTangent(false, 100, {
          x: 20, y: 20
        }, undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_2100
     * @tc.name      : testPathGetSegmentNormal0021
     * @tc.desc      : testPathGetSegmentNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathGetSegmentNormal0021', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPathGetSegmentNormal0021';
      let path = new drawing.Path();
      try {
        path.moveTo(0, 0);
        path.lineTo(0, 700);
        path.lineTo(700, 0);
        console.info(msg + 'lineTo successes');
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail();
      }
      let dstPath: drawing.Path = new drawing.Path();
      try {
        let result: boolean;
        result = path.getSegment(true, 10.0, 20.0, true, dstPath)
        console.info(msg + " getSegment-----result:  "+ path.getSegment(true, 10.0, 20.0, true, dstPath));
        expect(result).assertEqual(true);
      } catch (e) {
        console.info(msg + `test getSegment . errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_2200
     * @tc.name      : testPathGetSegmentAbnormal0022
     * @tc.desc      : testPathGetSegmentAbnormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathGetSegmentAbnormal0022', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathGetSegmentAbnormal0022';
      let path = new drawing.Path();
      try {
        path.moveTo(0, 0);
        path.lineTo(0, 700);
        path.lineTo(700, 0);
        console.info(msg + 'lineTo successes');
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect().assertFail();
      }
      let dstPath: drawing.Path = new drawing.Path();
      try {
        path.getSegment(true, 10.0, 20.0, true, undefined)
        console.info(msg + `test getSegment error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test getSegment . errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_2300
     * @tc.name      : testPathGetMatrixNormal0023
     * @tc.desc      : testPathGetMatrixNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathGetMatrixNormal0023', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPathGetMatrixNormal0023';

      try {
        const path = new drawing.Path();
        let matrix: drawing.Matrix;
        let flag: boolean;
        for (let i = 0; i < getEnumCount(drawing.PathMeasureMatrixFlags); i += 1) {
          matrix = new drawing.Matrix();
          let flag = path.getMatrix(false, 10, matrix, i);
          console.log("wzh901" + flag)
          expect(flag).assertFalse();
        }

        for (let i = 0; i < getEnumCount(drawing.PathMeasureMatrixFlags); i += 1) {
          matrix = new drawing.Matrix();
          let flag = path.getMatrix(true, 10.1, matrix, i);
          console.log("wzh908" + flag)
          expect(flag).assertFalse();
        }

        matrix = new drawing.Matrix();
        path.moveTo(0, 0);
        path.lineTo(100, 0);
        path.lineTo(100, 100);
        flag = path.getMatrix(false, 150, matrix, drawing.PathMeasureMatrixFlags.GET_POSITION_MATRIX);
        expect(flag).assertTrue();
        let flag2: boolean;
        flag2 = path.getMatrix(false, 150, matrix, drawing.PathMeasureMatrixFlags.GET_TANGENT_MATRIX);
        expect(flag2).assertTrue();
        let flag3: boolean;
        flag3 = path.getMatrix(false, 150, matrix, drawing.PathMeasureMatrixFlags.GET_POSITION_AND_TANGENT_MATRIX);
        expect(flag3).assertTrue();

        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_2400
     * @tc.name      : testPathGetMatrixMultipleCalls0024
     * @tc.desc      : testPathGetMatrixMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathGetMatrixMultipleCalls0024', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathGetMatrixMultipleCalls0024';
      const path = new drawing.Path();

      try {
        for (let i = 0; i < 20; i += 1) {
          const e = Math.floor(Math.random() * getEnumCount(drawing.PathMeasureMatrixFlags))
          const matrix = new drawing.Matrix()
          path.getMatrix(false, Math.random(), matrix, e)
        }
        console.info(msg + 'reset successes');
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_2500
     * @tc.name      : testPathGetMatrixToNull0025
     * @tc.desc      : testPathGetMatrixToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathGetMatrixToNull0025', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathGetMatrixToNull0025';
      const path = new drawing.Path();
      const matrix = new drawing.Matrix();

      try {
        path.getMatrix(null, 10, matrix, drawing.PathMeasureMatrixFlags.GET_POSITION_MATRIX);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.getMatrix(false, null, matrix, drawing.PathMeasureMatrixFlags.GET_POSITION_MATRIX);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.getMatrix(false, 10, null, drawing.PathMeasureMatrixFlags.GET_POSITION_MATRIX);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.getMatrix(false, 10, matrix, null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.getMatrix(undefined, 10, matrix, drawing.PathMeasureMatrixFlags.GET_POSITION_MATRIX);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.getMatrix(false, undefined, matrix, drawing.PathMeasureMatrixFlags.GET_POSITION_MATRIX);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.getMatrix(false, 10, undefined, drawing.PathMeasureMatrixFlags.GET_POSITION_MATRIX);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.getMatrix(false, 10, matrix, undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_2600
     * @tc.name      : testPathGetMatrixAbnormal0026
     * @tc.desc      : testPathGetMatrixAbnormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathGetMatrixAbnormal0026', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathGetMatrixAbnormal0026';
      const path = new drawing.Path();
      const matrix = new drawing.Matrix();

      try {
        path.getMatrix(false, 10, matrix, 10);
        console.info(msg + 'reset successes');
        expect().assertFail()
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_2700
     * @tc.name      : testPathBuildFromSVGStringNormal0027
     * @tc.desc      : testPathBuildFromSVGStringNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathBuildFromSVGStringNormal0027', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathBuildFromSVGStringNormal0027';
      const path = new drawing.Path();

      try {
        path.buildFromSvgString('');
        let svgStr: string = "M150 100 L75 300 L225 300 Z";
        let flag = path.buildFromSvgString(svgStr);
        expect(flag).assertTrue();

        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_2800
     * @tc.name      : testPathBuildFromSVGStringMultipleCalls0028
     * @tc.desc      : testPathBuildFromSVGStringMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathBuildFromSVGStringMultipleCalls0028', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathBuildFromSVGStringMultipleCalls0028';
      const path = new drawing.Path();

      try {
        for (let i = 0; i < 20; i += 1) {
          let svgStr: string = "M150 100 L75 300 L225 300 Z";
          let flag = path.buildFromSvgString(svgStr);
          expect(flag).assertTrue();
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_2900
     * @tc.name      : testPathBuildFromSVGStringToNull0029
     * @tc.desc      : testPathBuildFromSVGStringToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathBuildFromSVGStringToNull0029', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathBuildFromSVGStringToNull0029';
      const path = new drawing.Path();

      try {
        path.buildFromSvgString(null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        path.buildFromSvgString(undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_3000
     * @tc.name      : testPathApproximateNormal0030
     * @tc.desc      : testPathApproximateNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathApproximateNormal0030', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPathApproximateNormal0030';
      let path: drawing.Path = new drawing.Path();
      try {
        path.moveTo(100, 100);
        path.lineTo(500, 500);
        let points: number[] = path.approximate(0.5);
        console.info(msg + 'approximate successes');
        expect(points != null || points != undefined).assertTrue()
      } catch (e) {
        console.info(msg + `approximate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let points2: number[] = path.approximate(0);
        console.info(msg + 'approximate points2 successes');
        expect(points2 != null || points2 != undefined).assertTrue()
      } catch (e) {
        console.info(msg + `approximate points2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let points3: number[] = path.approximate(1);
        console.info(msg + 'approximate points3 successes');
        expect(points3 != null || points3 != undefined).assertTrue()
      } catch (e) {
        console.info(msg + `approximate points3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      path.reset();
      path.addCircle(100, 200, 50, drawing.PathDirection.CLOCKWISE);
      try {
        let points4: number[] = path.approximate(0.5);
        console.info(msg + 'approximate points4 successes');
        expect(points4 != null || points4 != undefined).assertTrue()
      } catch (e) {
        console.info(msg + `approximate points4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      path.lineTo(500, 500);
      path.cubicTo(100, 100, 80, 150, 300, 150);
      path.conicTo(200, 400, 100, 200, 0);
      try {
        let points5: number[] = path.approximate(0.88);
        console.info(msg + 'approximate points5 successes');
        expect(points5 != null || points5 != undefined).assertTrue()
      } catch (e) {
        console.info(msg + `approximate points5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_3100
     * @tc.name      : testPathApproximateToNull0031
     * @tc.desc      : testPathApproximateToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathApproximateToNull0031', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathApproximateToNull0031';
      let path: drawing.Path = new drawing.Path();
      path.moveTo(100, 100);
      path.lineTo(500, 500);
      try {
        path.approximate(null);
        console.info(msg + `approximate null successes`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `approximate null errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        path.approximate(undefined);
        console.info(msg + `approximate undefined successes`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `approximate undefined  errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_3200
     * @tc.name      : testPathApproximateMultipleCalls0032
     * @tc.desc      : testPathApproximateMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level2
     */
    it('testPathApproximateMultipleCalls0032', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      let msg = 'testPathApproximateMultipleCalls0032';
      let path: drawing.Path = new drawing.Path();
      path.moveTo(100, 100);
      path.lineTo(500, 500);
      try {
        for (let i = 0; i < 20; i += 1) {
          path.approximate(Math.random() * 1);
          console.info(msg + 'reset successes step is ' + i);
        }
      } catch (e) {
        console.info(msg + `reset errorCode is:  ${e.code} + errormsg is: ${e.message} `);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_3300
     * @tc.name      : testPathApproximateAbnormal0033
     * @tc.desc      : testPathApproximateAbnormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathApproximateAbnormal0033', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathApproximateAbnormal0033';
      let path: drawing.Path = new drawing.Path();
      try {
        path.approximate(-0.99999);
        console.info(msg + `approximate -0.99999 successes`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `approximate -0.99999 errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(25900001);
      }
      try {
        path.approximate(-1.1);
        console.info(msg + `approximate -1.1 successes`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `approximate -1.1 errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(25900001);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_3400
     * @tc.name      : testPathInterpolateNormal0034
     * @tc.desc      : testPathInterpolateNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathInterpolateNormal0034', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPathInterpolateNormal0034';
      let path: drawing.Path = new drawing.Path();
      path.moveTo(50, 50);
      path.lineTo(100, 100);
      path.lineTo(200, 200);
      let other: drawing.Path = new drawing.Path();
      other.moveTo(80, 80);
      other.lineTo(300, 300);
      let interpolatedPath: drawing.Path = new drawing.Path();
      console.info(msg + 'interpolatedPath successes');
      expect(interpolatedPath != null || interpolatedPath != undefined).assertTrue()
      try {
        interpolatedPath.moveTo(80, 80);
        interpolatedPath.lineTo(300, 300);
        let result = path.interpolate(other, 0.0, interpolatedPath);
        console.info(msg + 'interpolate successes');
        expect(result).assertEqual(false)
        // expect(interpolatedPath != null || interpolatedPath != undefined).assertTrue()
      } catch (e) {
        console.info(msg + `interpolate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        other.lineTo(400, 400);
        let result2 = path.interpolate(other, 0.0, interpolatedPath);
        console.info(msg + 'interpolate 2 successes');
        expect(result2).assertEqual(true)
        // expect(interpolatedPath != null || interpolatedPath != undefined).assertTrue()
      } catch (e) {
        console.info(msg + `interpolate 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let result3 = path.interpolate(other,1, interpolatedPath);
        console.info(msg + 'interpolate 3 successes');
        expect(result3).assertEqual(true)
        // expect(interpolatedPath != null || interpolatedPath != undefined).assertTrue()
      } catch (e) {
        console.info(msg + `interpolate 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let result4 = path.interpolate(other, 0.8, interpolatedPath);
        console.info(msg + 'interpolate 4 successes');
        expect(result4).assertEqual(true)
        // expect(interpolatedPath != null || interpolatedPath != undefined).assertTrue()
      } catch (e) {
        console.info(msg + `interpolate 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let result5 = path.interpolate(path, 0.8, interpolatedPath);
        console.info(msg + 'interpolate 5 successes');
        expect(result5).assertEqual(true)
        // expect(interpolatedPath != null || interpolatedPath != undefined).assertTrue()
      } catch (e) {
        console.info(msg + `interpolate 5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_3500
     * @tc.name      : testPathInterpolateToNull0035
     * @tc.desc      : testPathInterpolateToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathInterpolateToNull0035', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathInterpolateToNull0035';
      let path: drawing.Path = new drawing.Path();
      let other: drawing.Path = new drawing.Path();
      let interpolatedPath: drawing.Path = new drawing.Path();
      path.moveTo(100, 100);
      path.lineTo(500, 500);
      try {
        path.interpolate(null, 0.0, interpolatedPath);
        console.info(msg + `interpolate 1 successes`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `interpolate 1 errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        path.interpolate(undefined, 0.0, interpolatedPath);
        console.info(msg + `interpolate 2 successes`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `interpolate 2 errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        path.interpolate(other, null, interpolatedPath);
        console.info(msg + `interpolate 3 successes`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `interpolate 3 errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        path.interpolate(other, undefined, interpolatedPath);
        console.info(msg + `interpolate 4 successes`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `interpolate 4 errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        path.interpolate(other, 0.0, null);
        console.info(msg + `interpolate 5 successes`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `interpolate 5 errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        path.interpolate(other, 0.0, undefined);
        console.info(msg + `interpolate 6 successes`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `interpolate 6 errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_3600
     * @tc.name      : testPathInterpolateMultipleCalls0036
     * @tc.desc      : testPathInterpolateMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathInterpolateMultipleCalls0036', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathInterpolateMultipleCalls0036';
      try {
        for (let i = 0; i < 20; i += 1) {
          let path: drawing.Path = new drawing.Path();
          path.moveTo(Math.random() *60, Math.random() *60);
          path.lineTo(Math.random() *50, Math.random() *50);
          let other: drawing.Path = new drawing.Path();
          other.moveTo(Math.random() *100, Math.random() *50);
          other.lineTo(Math.random() *50, Math.random() *20);
          let interpolatedPath: drawing.Path = new drawing.Path();
          let result = path.interpolate(other,Math.random() *1, interpolatedPath);
          console.info(msg + 'interpolate success step is ' + i);
          console.info(msg + 'interpolate success result is ' + result);
          expect(result).assertEqual(true);
        }
      } catch (e) {
        console.info(msg + `interpolate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_3700
     * @tc.name      : testPathInterpolateAbnormal0037
     * @tc.desc      : testPathInterpolateAbnormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathInterpolateAbnormal0037', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathInterpolateAbnormal0037';
      let path: drawing.Path = new drawing.Path();
      let other: drawing.Path = new drawing.Path();
      let interpolatedPath: drawing.Path = new drawing.Path();
      try {
        path.interpolate(other,-0.99999, interpolatedPath);
        console.info(msg + `interpolate -0.99999 successes`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `interpolate -0.99999 errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(25900001);
      }
      try {
        path.interpolate(other,1.1, interpolatedPath);
        console.info(msg + `interpolate 1.1 successes`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `interpolate 1.1 errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(25900001);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_3800
     * @tc.name      : testPathIsInterpolateNormal0038
     * @tc.desc      : testPathIsInterpolateNormal
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testPathIsInterpolateNormal0038', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testPathIsInterpolateNormal0038';
      let path: drawing.Path = new drawing.Path();
      path.moveTo(0, 0);
      path.lineTo(100, 100);
      let other: drawing.Path = new drawing.Path();
      other.moveTo(0, 1);
      other.lineTo(200, 200);
      try {
        let result =path.isInterpolate(other);
        console.info(msg + 'isInterpolate successes');
        expect(result).assertEqual(true)
      } catch (e) {
        console.info(msg + `isInterpolate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        other.lineTo(400, 400);
        let result2 =path.isInterpolate(other);
        console.info(msg + 'isInterpolate 2 successes');
        expect(result2).assertEqual(false)
      } catch (e) {
        console.info(msg + `isInterpolate 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        path.lineTo(100, 100);
        let result3 =path.isInterpolate(other);
        console.info(msg + 'isInterpolate 3 successes');
        expect(result3).assertEqual(true)
      } catch (e) {
        console.info(msg + `isInterpolate 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        other.lineTo(600, 600);
        other.quadTo(10, 15, 10, 10);
        path.cubicTo(100, 100, 80, 150, 300, 150);
        let result4 =path.isInterpolate(other);
        console.info(msg + 'isInterpolate 4 successes');
        expect(result4).assertEqual(false)
      } catch (e) {
        console.info(msg + `isInterpolate 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_3900
     * @tc.name      : testPathIsInterpolateToNull0039
     * @tc.desc      : testPathIsInterpolateToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathIsInterpolateToNull0039', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathIsInterpolateToNull0039';
      let path: drawing.Path = new drawing.Path();
      try {
        path.isInterpolate(null)
        console.info(msg + `isInterpolate 1 successes`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `isInterpolate 1 errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        path.isInterpolate(undefined);
        console.info(msg + `isInterpolate 2 successes`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `isInterpolate 2 errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_PATH_4000
     * @tc.name      : testPathIsInterpolateMultipleCalls0040
     * @tc.desc      : testPathIsInterpolateMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testPathIsInterpolateMultipleCalls0040', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testPathIsInterpolateMultipleCalls0040';
      try {
        for (let i = 0; i < 20; i += 1) {
          let path: drawing.Path = new drawing.Path();
          path.moveTo(Math.random() *60, Math.random() *60);
          path.lineTo(Math.random() *50, Math.random() *50);
          let other: drawing.Path = new drawing.Path();
          other.moveTo(Math.random() *100, Math.random() *50);
          other.lineTo(Math.random() *50, Math.random() *20);
          let result = path.isInterpolate(other);
          console.info(msg + 'isInterpolate success step is ' + i);
          console.info(msg + 'isInterpolate success result is ' + result);
          expect(result).assertEqual(true);
        }
      } catch (e) {
        console.info(msg + `isInterpolate errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_4100
     * @tc.name      : testCanvasDrawRectNormal0041
     * @tc.desc      : testCanvasDrawRectNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawRectNormal0041', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawRectNormal0041';
      try {
        let canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        let left = 0;
        let right = 0;
        let top = 0;
        let bottom = 0;
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255, red: 255, green: 0, blue: 0
        });
        canvas.attachPen(pen);
        canvas.drawRect({
          left: 0, right: 0, top: 10, bottom: 10
        });
        canvas.drawRect(
          left=0, right= 0, top= 10, bottom= 10
        );
        canvas.drawRect({
          left: 100.32, right: 100.5, top: 400.2, bottom: 400.3
        });
        canvas.drawRect(
          left= 100.32, right= 100.5, top= 400.2, bottom= 400.3
        );
        canvas.drawRect({
          left: 0, right: 0, top: 0, bottom: 100
        });
        canvas.drawRect(
          left= 0, right= 0, top= 0, bottom= 100
        );
        canvas.drawRect({
          left: 0, right: 100, top: 100, bottom: 100
        });
        canvas.drawRect(
          left= 0, right= 100, top= 100, bottom= 100
        );
        canvas.drawRect({
          left: 100, right: 100, top: 100, bottom: 100
        });
        canvas.drawRect(
          left= 100, right= 100, top= 100, bottom= 100
        );
        canvas.drawRect({
          left: -100, right: 100, top: -100, bottom: 100
        });
        canvas.drawRect(
          left= -100, right= 100, top= -100, bottom= 100
        );
        canvas.drawRect({
          left: 100, right: -100, top: 100, bottom: -100
        });
        canvas.drawRect(
          left= 100, right= -100, top= 100, bottom= -100
        );
        canvas.drawRect({
          left: 200, right: 100, top: 200, bottom: 100
        });
        canvas.drawRect(
          left= 200, right= 100, top= 200, bottom= 100
        );
        canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_4200
     * @tc.name      : testCanvasDrawRectNull0042
     * @tc.desc      : testCanvasDrawRectNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawRectNull0042', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawRectNull0042';
      let left = 0;
      let right = 0;
      let top = 0;
      let bottom = 0;
      let canvas = new drawing.Canvas(pixel);
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255, red: 255, green: 0, blue: 0
        });
        canvas.attachPen(pen);
        canvas.drawRect(null);
        canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255, red: 255, green: 0, blue: 0
        });
        canvas.attachPen(pen);
        canvas.drawRect(undefined);
        canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255, red: 255, green: 0, blue: 0
        });
        canvas.attachPen(pen);
        canvas.drawRect({
          left: null, right: 0, top: 10, bottom: 10
        });
        canvas.drawRect(
          left= null, right= 0, top= 10, bottom= 10
        );
        canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255, red: 255, green: 0, blue: 0
        });
        canvas.attachPen(pen);
        canvas.drawRect({
          left: 0, right: null, top: 10, bottom: 10
        });
        canvas.drawRect(
          left= 0, right= null, top= 10, bottom= 10
        );
        canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255, red: 255, green: 0, blue: 0
        });
        canvas.attachPen(pen);
        canvas.drawRect({
          left: 0, right: 100, top: null, bottom: 10
        });
        canvas.drawRect(
          left= 0, right= 100, top= null, bottom= 10
        );
        canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255, red: 255, green: 0, blue: 0
        });
        canvas.attachPen(pen);
        canvas.drawRect({
          left: 0, right: 100, top: 10, bottom: null
        });
        canvas.drawRect(
          left= 0, right= 100, top= 10, bottom= null
        );
        canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255, red: 255, green: 0, blue: 0
        });
        canvas.attachPen(pen);
        canvas.drawRect({
          left: undefined, right: 0, top: 10, bottom: 10
        });
        canvas.drawRect(
          left= undefined, right= 0, top= 10, bottom= 10
        );
        canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255, red: 255, green: 0, blue: 0
        });
        canvas.attachPen(pen);
        canvas.drawRect({
          left: 0, right: undefined, top: 10, bottom: 10
        });
        canvas.drawRect(
          left= 0, right= undefined, top= 10, bottom= 10
        );
        canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255, red: 255, green: 0, blue: 0
        });
        canvas.attachPen(pen);
        canvas.drawRect({
          left: 0, right: 100, top: undefined, bottom: 10
        });
        canvas.drawRect(
          left= 0, right= 100, top= undefined, bottom= 10
        );
        canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255, red: 255, green: 0, blue: 0
        });
        canvas.attachPen(pen);
        canvas.drawRect({
          left: 0, right: 100, top: 10, bottom: undefined
        });
        canvas.drawRect(
          left= 0, right= 100, top= 10, bottom= undefined
        );
        canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_4300
     * @tc.name      : testCanvasDrawRectMultipleCalls0043
     * @tc.desc      : testCanvasDrawRectMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawRectMultipleCalls0043', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawRectMultipleCalls0043';
      let left = 0;
      let right = 0;
      let top = 0;
      let bottom = 0;
      try {
        let canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255, red: 255, green: 0, blue: 0
        });
        canvas.attachPen(pen);
        for (let index = 0; index < 20; index++) {
          canvas.drawRect({
            left: Math.random() * Number.MAX_VALUE, right: Math.random() * Number.MAX_VALUE, top: Math.random() * Number.MAX_VALUE, bottom: Math.random() * Number.MAX_VALUE
          });
          canvas.drawRect(
            left= Math.random() * Number.MAX_VALUE, right= Math.random() * Number.MAX_VALUE, top= Math.random() * Number.MAX_VALUE, bottom= Math.random() * Number.MAX_VALUE
          );
        }
        canvas.detachPen();
        console.info(msg + 'drawRect successed');
      } catch (e) {
        console.info(msg + `drawRect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_4400
     * @tc.name      : testCanvasDrawRoundRectNormal0044
     * @tc.desc      : testCanvasDrawRoundRectNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawRoundRectNormal0044', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawRoundRectNormal0044';
      const canvas = new drawing.Canvas(pixel);

      try {
        let rectOne: common2D.Rect = {
          left: 10, top: 100, right: 200, bottom: 300
        };
        let roundRect = new drawing.RoundRect(rectOne, 10, 10);
        canvas.drawRoundRect(roundRect);
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_4500
     * @tc.name      : testCanvasDrawRoundRectMultipleCalls0045
     * @tc.desc      : testCanvasDrawRoundRectMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawRoundRectMultipleCalls0045', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawRoundRectMultipleCalls0045';
      const canvas = new drawing.Canvas(pixel);

      try {
        for (let i = 0; i < 20; i += 1) {
          let rectOne: common2D.Rect = {
            left: 10 * Math.random(), top: 100 * Math.random(), right: 200 * Math.random(), bottom: 300 * Math.random()
          };
          let roundRect = new drawing.RoundRect(rectOne, 10, 10);
          canvas.drawRoundRect(roundRect);
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_4600
     * @tc.name      : testCanvasDrawRoundRectToNull0046
     * @tc.desc      : testCanvasDrawRoundRectToNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawRoundRectToNull0046', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawRoundRectToNull0046';
      const canvas = new drawing.Canvas(pixel);

      try {
        canvas.drawRoundRect(null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawRoundRect(undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_4700
     * @tc.name      : testCanvadrawNestedRoundRectNormal0047
     * @tc.desc      : testCanvadrawNestedRoundRectNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvadrawNestedRoundRectNormal0047', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvadrawNestedRoundRectNormal0047';
      const canvas = new drawing.Canvas(pixel);

      try {
        let rect1: common2D.Rect = {
          left: 10, top: 100, right: 200, bottom: 300
        };
        let rect2: common2D.Rect = {
          left: 20, top: 100, right: 200, bottom: 300
        };
        let outRoundRect = new drawing.RoundRect(rect1, 10, 10);
        let inRoundRect = new drawing.RoundRect(rect1, 10, 10);

        canvas.drawNestedRoundRect(outRoundRect, inRoundRect);
        // roundrect相等

        inRoundRect = new drawing.RoundRect(rect2, 10, 10);
        canvas.drawNestedRoundRect(outRoundRect, inRoundRect);
        // roundrect不相等

        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_4800
     * @tc.name      : testCanvadrawNestedRoundRectMultipleCalls0048
     * @tc.desc      : testCanvadrawNestedRoundRectMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvadrawNestedRoundRectMultipleCalls0048', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvadrawNestedRoundRectMultipleCalls0048';
      const canvas = new drawing.Canvas(pixel);

      try {
        for (let i = 0; i < 20; i += 1) {
          let rect1: common2D.Rect = {
            left: 10, top: 100, right: 200, bottom: 300
          };
          let rect2: common2D.Rect = {
            left: 20, top: 100, right: 200, bottom: 300
          };
          let outRoundRect = new drawing.RoundRect(rect1, 10, 10);
          let inRoundRect = new drawing.RoundRect(rect2, 10, 10);
          canvas.drawNestedRoundRect(outRoundRect, inRoundRect);
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_4900
     * @tc.name      : testCanvadrawNestedRoundRectToNull0049
     * @tc.desc      : testCanvadrawNestedRoundRectToNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvadrawNestedRoundRectToNull0049', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvadrawNestedRoundRectToNull0049';
      const canvas = new drawing.Canvas(pixel);

      let rect1: common2D.Rect = {
        left: 10, top: 100, right: 200, bottom: 300
      };
      let rect2: common2D.Rect = {
        left: 20, top: 100, right: 200, bottom: 300
      };
      let outRoundRect = new drawing.RoundRect(rect1, 10, 10);
      let inRoundRect = new drawing.RoundRect(rect2, 10, 10);

      try {
        canvas.drawNestedRoundRect(null, inRoundRect);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawNestedRoundRect(undefined, inRoundRect);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawNestedRoundRect(outRoundRect, null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawNestedRoundRect(outRoundRect, undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_5000
     * @tc.name      : testCanvasDrawBackgroundNormal0050
     * @tc.desc      : testCanvasDrawBackgroundNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawBackgroundNormal0050', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawBackgroundNormal0050';
      const canvas = new drawing.Canvas(pixel);

      try {
        const brush = new drawing.Brush();
        canvas.drawBackground(brush);
        brush.setColor({
          alpha: 255, red: 255, green: 0, blue: 0
        });
        canvas.drawBackground(brush);

        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_5100
     * @tc.name      : testAAAA0051
     * @tc.desc      : testAAAA
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testAAAA0051', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testAAAA0051';
      const canvas = new drawing.Canvas(pixel);

      try {
        for (let i = 0; i < 20; i += 1) {
          const brush = new drawing.Brush();
          brush.setColor({
            red: 256 * Math.random(),
            green: 256 * Math.random(),
            blue: 256 * Math.random(),
            alpha: 256 * Math.random()
          })
          canvas.drawBackground(brush)
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_5200
     * @tc.name      : testCanvasDrawBackgroundToNull0052
     * @tc.desc      : testCanvasDrawBackgroundToNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawBackgroundToNull0052', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawBackgroundToNull0052';
      const canvas = new drawing.Canvas(pixel);

      try {
        canvas.drawBackground(null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawBackground(undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_5300
     * @tc.name      : testCanvasDrawShadowNormal0053
     * @tc.desc      : testCanvasDrawShadowNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawShadowNormal0053', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawShadowNormal0053';
      const canvas = new drawing.Canvas(pixel);
      const path = new drawing.Path();

      try {
        for (let i = 0; i < getEnumCount(drawing.ShadowFlag); i += 1) {
          canvas.drawShadow(path, {
            x: 100, y: 80, z: 80
          }, {
            x: 200, y: 10, z: 40
          }, 30, {
            alpha: 0xFF, red: 0, green: 0, blue: 0xFF
          }, {
            alpha: 0xFF, red: 0xFF, green: 0, blue: 0
          }, i);
          // shadowFlag枚举值覆盖验证
        }
        canvas.drawShadow(path, {
          x: 100.1, y: 80.1, z: 80.1
        }, {
          x: 200.1, y: 10.1, z: 40.1
        }, 30.1, {
          alpha: 0x00, red: 0, green: 0, blue: 0x00
        }, {
          alpha: 0xFF, red: 0xFF, green: 0xFF, blue: 0xFF
        }, drawing.ShadowFlag.ALL);

        canvas.drawShadow(path, {
          x: 100, y: 80, z: 80
        }, {
          x: 200, y: 10, z: 40
        }, -1, {
          alpha: 0xFF, red: 0, green: 0, blue: 0xFF
        }, {
          alpha: 0xFF, red: 0xFF, green: 0, blue: 0
        }, drawing.ShadowFlag.ALL);
        canvas.drawShadow(path, {
          x: 100, y: 80, z: 80
        }, {
          x: 200, y: 10, z: 40
        }, 0, {
          alpha: 0xFF, red: 0, green: 0, blue: 0xFF
        }, {
          alpha: 0xFF, red: 0xFF, green: 0, blue: 0
        }, drawing.ShadowFlag.ALL);

        canvas.drawShadow(path, {
          x: -100, y: -80, z: 80
        }, {
          x: 200, y: 10, z: -40
        }, 100, {
          alpha: 0xFF, red: 0, green: 0, blue: 0xFF
        }, {
          alpha: 0xFF, red: 0xFF, green: 0, blue: 0
        }, drawing.ShadowFlag.ALL);

        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_5400
     * @tc.name      : testCanvasDrawShadowMultipleCalls0054
     * @tc.desc      : testCanvasDrawShadowMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawShadowMultipleCalls0054', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawShadowMultipleCalls0054';
      const canvas = new drawing.Canvas(pixel);
      const path = new drawing.Path();

      try {
        for (let i = 0; i < 20; i += 1) {
          const e = Math.floor(Math.random() * getEnumCount(drawing.ShadowFlag))
          canvas.drawShadow(path, {
            x: Math.random(), y: Math.random(), z: Math.random()
          }, {
            x: Math.random(), y: Math.random(), z: Math.random()
          }, Math.random(), {
            alpha: 0xFF, red: 0, green: 0, blue: 0xFF
          }, {
            alpha: 0xFF, red: 0xFF, green: 0, blue: 0
          }, e);
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_5500
     * @tc.name      : testCanvasDrawShadowToNull0055
     * @tc.desc      : testCanvasDrawShadowToNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawShadowToNull0055', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawShadowToNull0055';
      const canvas = new drawing.Canvas(pixel);
      const path = new drawing.Path();
      const shadowFlag = 0

      try {
        canvas.drawShadow(null, {
          x: 100, y: 80, z: 80
        }, {
          x: 200, y: 10, z: 40
        }, 30, {
          alpha: 0xFF, red: 0, green: 0, blue: 0xFF
        }, {
          alpha: 0xFF, red: 0xFF, green: 0, blue: 0
        }, shadowFlag);
        console.info(msg + `test error`);
        // expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawShadow(path, null, {
          x: 200, y: 10, z: 40
        }, 30, {
          alpha: 0xFF, red: 0, green: 0, blue: 0xFF
        }, {
          alpha: 0xFF, red: 0xFF, green: 0, blue: 0
        }, shadowFlag);
        console.info(msg + `test error`);
        // expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawShadow(path, {
          x: 100, y: 80, z: 80
        }, null, 30, {
          alpha: 0xFF, red: 0, green: 0, blue: 0xFF
        }, {
          alpha: 0xFF, red: 0xFF, green: 0, blue: 0
        }, shadowFlag);
        console.info(msg + `test error`);
        // expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawShadow(path, {
          x: 100, y: 80, z: 80
        }, {
          x: 200, y: 10, z: 40
        }, null, {
          alpha: 0xFF, red: 0, green: 0, blue: 0xFF
        }, {
          alpha: 0xFF, red: 0xFF, green: 0, blue: 0
        }, shadowFlag);
        console.info(msg + `test error`);
        // expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawShadow(path, {
          x: 100, y: 80, z: 80
        }, {
          x: 200, y: 10, z: 40
        }, 30, null, {
          alpha: 0xFF, red: 0xFF, green: 0, blue: 0
        }, shadowFlag);
        console.info(msg + `test error`);
        // expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawShadow(path, {
          x: 100, y: 80, z: 80
        }, {
          x: 200, y: 10, z: 40
        }, 30, {
          alpha: 0xFF, red: 0, green: 0, blue: 0xFF
        }, null, shadowFlag);
        console.info(msg + `test error`);
        // expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawShadow(path, {
          x: 100, y: 80, z: 80
        }, {
          x: 200, y: 10, z: 40
        }, 30, {
          alpha: 0xFF, red: 0, green: 0, blue: 0xFF
        }, {
          alpha: 0xFF, red: 0xFF, green: 0, blue: 0
        }, null);
        console.info(msg + `test error`);
        // expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawShadow(undefined, {
          x: 100, y: 80, z: 80
        }, {
          x: 200, y: 10, z: 40
        }, 30, {
          alpha: 0xFF, red: 0, green: 0, blue: 0xFF
        }, {
          alpha: 0xFF, red: 0xFF, green: 0, blue: 0
        }, shadowFlag);
        console.info(msg + `test error`);
        // expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawShadow(path, undefined, {
          x: 200, y: 10, z: 40
        }, 30, {
          alpha: 0xFF, red: 0, green: 0, blue: 0xFF
        }, {
          alpha: 0xFF, red: 0xFF, green: 0, blue: 0
        }, shadowFlag);
        console.info(msg + `test error`);
        // expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawShadow(path, {
          x: 100, y: 80, z: 80
        }, undefined, 30, {
          alpha: 0xFF, red: 0, green: 0, blue: 0xFF
        }, {
          alpha: 0xFF, red: 0xFF, green: 0, blue: 0
        }, shadowFlag);
        console.info(msg + `test error`);
        // expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawShadow(path, {
          x: 100, y: 80, z: 80
        }, {
          x: 200, y: 10, z: 40
        }, undefined, {
          alpha: 0xFF, red: 0, green: 0, blue: 0xFF
        }, {
          alpha: 0xFF, red: 0xFF, green: 0, blue: 0
        }, shadowFlag);
        console.info(msg + `test error`);
        // expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawShadow(path, {
          x: 100, y: 80, z: 80
        }, {
          x: 200, y: 10, z: 40
        }, 30, undefined, {
          alpha: 0xFF, red: 0xFF, green: 0, blue: 0
        }, shadowFlag);
        console.info(msg + `test error`);
        // expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawShadow(path, {
          x: 100, y: 80, z: 80
        }, {
          x: 200, y: 10, z: 40
        }, 30, {
          alpha: 0xFF, red: 0, green: 0, blue: 0xFF
        }, undefined, shadowFlag);
        console.info(msg + `test error`);
        // expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawShadow(path, {
          x: 100, y: 80, z: 80
        }, {
          x: 200, y: 10, z: 40
        }, 30, {
          alpha: 0xFF, red: 0, green: 0, blue: 0xFF
        }, {
          alpha: 0xFF, red: 0xFF, green: 0, blue: 0
        }, undefined);
        console.info(msg + `test error`);
        // expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawShadow(path, {
          x: 100, y: 80, z: 80
        }, {
          x: 200, y: 10, z: 40
        }, 30, {
          alpha: null, red: 0, green: 0, blue: 0xFF
        }, {
          alpha: 0xFF, red: 0xFF, green: 0, blue: 0
        }, shadowFlag);
        console.info(msg + `test error`);
        // expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawShadow(path, {
          x: 100, y: 80, z: 80
        }, {
          x: 200, y: 10, z: 40
        }, 30, {
          alpha: 0xFF, red: undefined, green: 0, blue: 0xFF
        }, {
          alpha: 0xFF, red: 0xFF, green: 0, blue: 0
        }, shadowFlag);
        console.info(msg + `test error`);
        // expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawShadow(path, {
          x: 100, y: 80, z: 80
        }, {
          x: 200, y: 10, z: 40
        }, 30, {
          alpha: 0xFF, red: 0, green: 0, blue: 0xFF
        }, {
          alpha: 0xFF, red: 0xFF, green: null, blue: 0
        }, shadowFlag);
        console.info(msg + `test error`);
        // expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawShadow(path, {
          x: 100, y: 80, z: 80
        }, {
          x: 200, y: 10, z: 40
        }, 30, {
          alpha: 0xFF, red: 0, green: 0, blue: 0xFF
        }, {
          alpha: 0xFF, red: 0xFF, green: 0, blue: undefined
        }, shadowFlag);
        console.info(msg + `test error`);
        // expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_5600
     * @tc.name      : testCanvasDrawCircleNormal0056
     * @tc.desc      : testCanvasDrawCircleNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawCircleNormal0056', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawCircleNormal0056';
      let canvas = new drawing.Canvas(pixel);
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255, red: 255, green: 0, blue: 0
        });
        canvas.attachPen(pen);
        canvas.drawCircle(10, 10, 100);
        canvas.drawCircle(10.1, 10.1, 100.1);
        canvas.detachPen();
        console.info(msg + 'drawCircle successed');
      } catch (e) {
        console.info(msg + `drawCircle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_5700
     * @tc.name      : testCanvasDrawCircleNull0057
     * @tc.desc      : testCanvasDrawCircleNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawCircleNull0057', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawCircleNull0057';
      let canvas = new drawing.Canvas(pixel);
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255, red: 255, green: 0, blue: 0
        });
        canvas.attachPen(pen);
        canvas.drawCircle(null, 10, 100);
        canvas.detachPen();
        console.info(msg + 'drawCircle successed');
      } catch (e) {
        console.info(msg + `drawCircle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        pixel
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255, red: 255, green: 0, blue: 0
        });
        canvas.attachPen(pen);
        canvas.drawCircle(10, null, 100);
        canvas.detachPen();
        console.info(msg + 'drawCircle successed');
      } catch (e) {
        console.info(msg + `drawCircle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255, red: 255, green: 0, blue: 0
        });
        canvas.attachPen(pen);
        canvas.drawCircle(10, 10, null);
        canvas.detachPen();
        console.info(msg + 'drawCircle successed');
      } catch (e) {
        console.info(msg + `drawCircle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255, red: 255, green: 0, blue: 0
        });
        canvas.attachPen(pen);
        canvas.drawCircle(undefined, 10, 100);
        canvas.detachPen();
        console.info(msg + 'drawCircle successed');
      } catch (e) {
        console.info(msg + `drawCircle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255, red: 255, green: 0, blue: 0
        });
        canvas.attachPen(pen);
        canvas.drawCircle(10, undefined, 100);
        canvas.detachPen();
        console.info(msg + 'drawCircle successed');
      } catch (e) {
        console.info(msg + `drawCircle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255, red: 255, green: 0, blue: 0
        });
        canvas.attachPen(pen);
        canvas.drawCircle(10, 10, undefined);
        canvas.detachPen();
        console.info(msg + 'drawCircle successed');
      } catch (e) {
        console.info(msg + `drawCircle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_5800
     * @tc.name      : testCanvasDrawCircleMultipleCalls0058
     * @tc.desc      : testCanvasDrawCircleMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawCircleMultipleCalls0058', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawCircleMultipleCalls0058';
      try {
        let canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({
          alpha: 255, red: 255, green: 0, blue: 0
        });
        canvas.attachPen(pen);
        for (let index = 0; index < 20; index++) {
          canvas.drawCircle(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
        }
        canvas.detachPen();
        console.info(msg + 'drawCircle successed');
      } catch (e) {
        console.info(msg + `drawCircle errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_5900
     * @tc.name      : testCanvasDrawImageNormal0059
     * @tc.desc      : testCanvasDrawImageNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawImageNormal0059', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawImageNormal0059';
      try {
        let canvas = new drawing.Canvas(pixel);
        canvas.drawImage(pixel, 100, 100);
        canvas.drawImage(pixel, 100.2, 100.2);
        canvas.drawImage(pixel, 100, 100, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST));
        canvas.drawImage(pixel, 100.2, 100.2, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_LINEAR));
        canvas.drawImage(pixel, -100.2, -100, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_LINEAR));
        console.info(msg + 'drawImage successed');
      } catch (e) {
        console.info(msg + `drawImage errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_6000
     * @tc.name      : testCanvasDrawImageNull0060
     * @tc.desc      : testCanvasDrawImageNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawImageNull0060', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawImageNull0060';
      let canvas = new drawing.Canvas(pixel);
      try {
        canvas.drawImage(null, 100, 100);
        console.info(msg + 'drawImage successed');
      } catch (e) {
        console.info(msg + `drawImage errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImage(pixel, null, 100);
        console.info(msg + 'drawImage successed');
      } catch (e) {
        console.info(msg + `drawImage errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImage(pixel, 100, null);
        console.info(msg + 'drawImage successed');
      } catch (e) {
        console.info(msg + `drawImage errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImage(pixel, 100, 100, null);
        console.info(msg + 'drawImage successed');
      } catch (e) {
        console.info(msg + `drawImage errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImage(undefined, 100, 100);
        console.info(msg + 'drawImage successed');
      } catch (e) {
        console.info(msg + `drawImage errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImage(pixel, undefined, 100);
        console.info(msg + 'drawImage successed');
      } catch (e) {
        console.info(msg + `drawImage errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImage(pixel, 100, undefined);
        console.info(msg + 'drawImage successed');
      } catch (e) {
        console.info(msg + `drawImage errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImage(pixel, 100, 100, undefined);
        console.info(msg + 'drawImage successed');
      } catch (e) {
        console.info(msg + `drawImage errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_6100
     * @tc.name      : testCanvasDrawImageMultipleCalls0061
     * @tc.desc      : testCanvasDrawImageMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawImageMultipleCalls0061', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawImageMultipleCalls0061';
      try {
        let canvas = new drawing.Canvas(pixel);
        const randomEnum = Math.floor(Math.random() * (getEnumCount(drawing.FilterMode)));
        canvas.drawImage(pixel, Math.random() * 200, Math.random() * 200, new drawing.SamplingOptions(randomEnum));
        console.info(msg + 'drawImage successed');
      } catch (e) {
        console.info(msg + `drawImage errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_6200
     * @tc.name      : testCanvasDrawImageLatticeNormal0062
     * @tc.desc      : testCanvasDrawImageLatticeNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawImageLatticeNormal0062', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawImageLatticeNormal0062';
      let canvas = new drawing.Canvas(pixel);
      let fXDivs: Array<number> = [80, 150];
      let fYDivs: Array<number> = [80, 150];
      let fXCount = 2
      let fYCount = 2
      let lattice = drawing.Lattice.createImageLattice(fXDivs, fYDivs, fXCount, fYCount, null, null, null);
      let dst: common2D.Rect = { left: 0, top: 0, right: 200, bottom: 200 };
      try {
        canvas.drawImageLattice(pixel, lattice, dst, drawing.FilterMode.FILTER_MODE_NEAREST);
      } catch (e) {
        console.info(msg + `drawImageLattice 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      let fXDivs1: Array<number> = [310, 320, 340, 360, 400];
      let fYDivs1: Array<number> = [310, 320, 340, 360, 400];
      fXCount = 5;
      fYCount = 5;
      lattice = drawing.Lattice.createImageLattice(fXDivs1, fYDivs1, fXCount, fYCount, null, null, null);
      dst = { left: 225, top:0, right: 425, bottom: 200 };
      try {
        canvas.drawImageLattice(pixel, lattice, dst, drawing.FilterMode.FILTER_MODE_LINEAR);
      } catch (e) {
        console.info(msg + `drawImageLattice 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      let bound1: common2D.Rect = {
        left: 700,
        right: 800,
        top: 700,
        bottom: 800
      };
      let fXDivs2: Array<number> = [200, 400];
      let fYDivs2: Array<number> = [200, 400];
      fXCount = 2;
      fYCount = 2;
      lattice = drawing.Lattice.createImageLattice(fXDivs2, fYDivs2, fXCount, fYCount, bound1, null, null);
      dst = { left: 450, top:0, right: 650, bottom: 200 };
      try {
        canvas.drawImageLattice(pixel, lattice, dst, drawing.FilterMode.FILTER_MODE_LINEAR);
      } catch (e) {
        console.info(msg + `drawImageLattice 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      dst = { left: 10.2, top: 550.1, right: 300.1, bottom: 850.1 };
      try {
        canvas.drawImageLattice(pixel, lattice, dst, drawing.FilterMode.FILTER_MODE_LINEAR);
      } catch (e) {
        console.info(msg + `drawImageLattice 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }

      dst = { left: -10, top: -60, right: 300000, bottom: 300000 };
      try {
        canvas.drawImageLattice(pixel, lattice, dst, drawing.FilterMode.FILTER_MODE_LINEAR);
      } catch (e) {
        console.info(msg + `drawImageLattice 5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_6300
     * @tc.name      : testCanvasDrawImageLatticeNull0063
     * @tc.desc      : testCanvasDrawImageLatticeNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawImageLatticeNull0063', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawImageLatticeNull0063';
      let canvas = new drawing.Canvas(pixel);
      let xDivs: Array<number> = [80, 160, 320, 560];
      let yDivs: Array<number> = [80, 160, 320, 560];
      let xCount = 4;
      let yCount = 4;
      let lattice = drawing.Lattice.createImageLattice(xDivs, yDivs, xCount, yCount, null, null, null);
      let dst: common2D.Rect = { left: 0, top: 0, right: 200, bottom: 200 };
      try {
        canvas.drawImageLattice(null, lattice, dst, drawing.FilterMode.FILTER_MODE_NEAREST);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawImageLattice 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImageLattice(undefined, lattice, dst, drawing.FilterMode.FILTER_MODE_NEAREST);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawImageLattice 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImageLattice(pixel, null, dst, drawing.FilterMode.FILTER_MODE_NEAREST);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawImageLattice 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImageLattice(pixel, undefined, dst, drawing.FilterMode.FILTER_MODE_NEAREST);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawImageLattice 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImageLattice(pixel, lattice, null, drawing.FilterMode.FILTER_MODE_NEAREST);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawImageLattice 5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImageLattice(pixel, lattice, undefined, drawing.FilterMode.FILTER_MODE_NEAREST);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawImageLattice 6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImageLattice(pixel, lattice, dst, null);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawImageLattice 7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImageLattice(pixel, lattice, dst, undefined);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawImageLattice 8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_6400
     * @tc.name      : testCanvasDrawImageLatticeMultipleCalls0064
     * @tc.desc      : testCanvasDrawImageLatticeMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level2
     */
    it('testCanvasDrawImageLatticeMultipleCalls0064', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      let msg = 'testCanvasDrawImageLatticeMultipleCalls0064';
      const path = new drawing.Path();
      let canvas = new drawing.Canvas(pixel);
      for(let i = 0; i < 20; i++) {
        let xDivs: Array<number> = [80, 160, 320, 560];
        let yDivs: Array<number> = [80, 160, 320, 560];
        let xCount = 4;
        let yCount = 4;
        let lattice = drawing.Lattice.createImageLattice(xDivs, yDivs, xCount, yCount, null, null, null);
        let dst: common2D.Rect = { left: 0+ i * 0.01, top: 0+ i * 0.01, right: 200+ i * 0.01, bottom: 200+ i * 0.01 };
        try {
          canvas.drawImageLattice(pixel, lattice, dst, drawing.FilterMode.FILTER_MODE_LINEAR);
        } catch (e) {
          console.info(msg + `drawImageLattice 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_6500
     * @tc.name      : testCanvasDrawImageLatticeMax0065
     * @tc.desc      : testCanvasDrawImageLatticeMax
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level2
     */
    it('testCanvasDrawImageLatticeMax0065', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL2, () => {
      let msg = 'testCanvasDrawImageLatticeMax0065';
      const path = new drawing.Path();
      let canvas = new drawing.Canvas(pixel);
      let xDivs: Array<number> = [80, 160, 320, 560];
      let yDivs: Array<number> = [80, 160, 320, 560];
      let xCount = 4;
      let yCount = 4;
      let lattice = drawing.Lattice.createImageLattice(xDivs, yDivs, xCount, yCount, null, null, null);
      let dst: common2D.Rect = {
        left: Number.MAX_VALUE, top: Number.MAX_VALUE, right: Number.MAX_VALUE + 100, bottom: Number.MAX_VALUE + 100
      };
      try {
        canvas.drawImageLattice(pixel, lattice, dst, drawing.FilterMode.FILTER_MODE_NEAREST);
      } catch (e) {
        console.info(msg + `drawImageLattice 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      dst = {
        left: -Number.MAX_VALUE, top: -Number.MAX_VALUE, right: Number.MAX_VALUE + 100, bottom: Number.MAX_VALUE + 100
      };
      try {
        canvas.drawImageLattice(pixel, lattice, dst, drawing.FilterMode.FILTER_MODE_NEAREST);
      } catch (e) {
        console.info(msg + `drawImageLattice 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_6600
     * @tc.name      : testCanvasDrawImageNineNormal0066
     * @tc.desc      : testCanvasDrawImageNineNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level1
     */
    it('testCanvasDrawImageNineNormal0066', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      let msg = 'testCanvasDrawImageNineNormal0066';
      let canvas = new drawing.Canvas(pixel);
      let center: common2D.Rect = { left: 100, top: 100, right: 900, bottom: 1500 };
      let dst: common2D.Rect = { left: -50, top: -50, right: 2000, bottom: 1600 };
      try {
        canvas.drawImageNine(pixel, center, dst, drawing.FilterMode.FILTER_MODE_NEAREST);
      } catch (e) {
        console.info(msg + `drawImageNine 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      center = { left: -100, top: -100, right: 50, bottom: 100 };
      dst = { left: 0, top: 0, right: 200, bottom: 200 };
      try {
        canvas.drawImageNine(pixel, center, dst, drawing.FilterMode.FILTER_MODE_LINEAR);
      } catch (e) {
        console.info(msg + `drawImageNine 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      center = { left: 200, top: 200, right: 100000, bottom: 100000 };
      dst = { left: 0, top: 0, right: 200, bottom: 200 };
      try {
        canvas.drawImageNine(pixel, center, dst, drawing.FilterMode.FILTER_MODE_LINEAR);
      } catch (e) {
        console.info(msg + `drawImageNine 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      center = { left: 100, top: 100, right: 200, bottom: 200 };
      dst = { left: 0, top: 0, right: 800, bottom: 800 };
      try {
        canvas.drawImageNine(pixel, center, dst, drawing.FilterMode.FILTER_MODE_NEAREST);
      } catch (e) {
        console.info(msg + `drawImageNine 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      center = { left: 10.1, top: 10.1, right: 300.1, bottom: 300.1 };
      dst = { left: 0, top: 0, right: 50.1, bottom: 50.1 };
      try {
        canvas.drawImageNine(pixel, center, dst, drawing.FilterMode.FILTER_MODE_LINEAR);
      } catch (e) {
        console.info(msg + `drawImageNine 5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_6700
     * @tc.name      : testCanvasDrawImageNineNull0067
     * @tc.desc      : testCanvasDrawImageNineNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawImageNineNull0067', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawImageNineNull0067';
      let canvas = new drawing.Canvas(pixel);
      let center: common2D.Rect = { left: 100, top: 100, right: 900, bottom: 1500 };
      let dst: common2D.Rect = { left: -50, top: -50, right: 2000, bottom: 1600 };
      try {
        canvas.drawImageNine(null, center, dst, drawing.FilterMode.FILTER_MODE_NEAREST);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawImageNine 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImageNine(undefined, center, dst, drawing.FilterMode.FILTER_MODE_NEAREST);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawImageNine 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImageNine(pixel, null, dst, drawing.FilterMode.FILTER_MODE_LINEAR);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawImageNine 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImageNine(pixel, undefined, dst, drawing.FilterMode.FILTER_MODE_NEAREST);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawImageNine 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImageNine(pixel, center, null, drawing.FilterMode.FILTER_MODE_LINEAR);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawImageNine 5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImageNine(pixel, center, undefined, drawing.FilterMode.FILTER_MODE_LINEAR);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawImageNine 6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImageNine(pixel, center, dst, null);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawImageNine 7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImageNine(pixel, center, dst, undefined);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawImageNine 8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_6800
     * @tc.name      : testCanvasDrawImageNineMultipleCalls0068
     * @tc.desc      : testCanvasDrawImageNineMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawImageNineMultipleCalls0068', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawImageNineMultipleCalls0068';
      const path = new drawing.Path();
      let canvas = new drawing.Canvas(pixel);
      for(let i = 0; i < 20; i++) {
        let center: common2D.Rect = { left: 100 + i * 0.01, top: 100 + i * 0.01, right: 900 + i * 0.01, bottom: 1500 + i * 0.01 };
        let dst: common2D.Rect = { left: -50 + i * 0.01, top: -50 + i * 0.01, right: 2000 + i * 0.01, bottom: 1600 + i * 0.01 };
        try {
          canvas.drawImageNine(pixel, center, dst, drawing.FilterMode.FILTER_MODE_LINEAR);
        } catch (e) {
          console.info(msg + `drawImageNine ${i} errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_6900
     * @tc.name      : testCanvasDrawImageNineMax0069
     * @tc.desc      : testCanvasDrawImageNineMax
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawImageNineMax0069', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawImageNineMax0069';
      const path = new drawing.Path();
      let canvas = new drawing.Canvas(pixel);
      let center: common2D.Rect = {
        left: Number.MAX_VALUE, top: Number.MAX_VALUE, right: Number.MAX_VALUE + 100, bottom: Number.MAX_VALUE + 100
      };
      let dst: common2D.Rect = { left: -50 , top: -50 , right: 2000 , bottom: 1600};
      try {
        canvas.drawImageNine(pixel, center, dst, drawing.FilterMode.FILTER_MODE_LINEAR);
      } catch (e) {
        console.info(msg + `drawImageNine 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      center = {
        left: -Number.MAX_VALUE, top: -Number.MAX_VALUE, right: Number.MAX_VALUE + 100, bottom: Number.MAX_VALUE + 100
      };
      try {
        canvas.drawImageNine(pixel, center, dst, drawing.FilterMode.FILTER_MODE_LINEAR);
      } catch (e) {
        console.info(msg + `drawImageNine 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      center = { left: -50 , top: -50 , right: 2000 , bottom: 1600};
      dst = {
        left: Number.MAX_VALUE, top: Number.MAX_VALUE, right: Number.MAX_VALUE + 100, bottom: Number.MAX_VALUE + 100
      };
      try {
        canvas.drawImageNine(pixel, center, dst, drawing.FilterMode.FILTER_MODE_LINEAR);
      } catch (e) {
        console.info(msg + `drawImageNine 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      dst = {
        left: -Number.MAX_VALUE, top: -Number.MAX_VALUE, right: Number.MAX_VALUE + 100, bottom: Number.MAX_VALUE + 100
      };
      try {
        canvas.drawImageNine(pixel, center, dst, drawing.FilterMode.FILTER_MODE_LINEAR);
      } catch (e) {
        console.info(msg + `drawImageNine 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_7000
     * @tc.name      : testCanvasDrawImageRectNormal0070
     * @tc.desc      : testCanvasDrawImageRectNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawImageRectNormal0070', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawImageRectNormal0070';
      const canvas = new drawing.Canvas(pixel);
      const maxVal = Number.MAX_VALUE;

      try {
        canvas.drawImageRect(pixelMap, {
          left: 0, top: 0, right: 600, bottom: 600
        });
        canvas.drawImageRect(pixelMap, {
          left: 100.1, top: 10.10, right: 900.1, bottom: 900.1
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST));
        canvas.drawImageRect(pixelMap, {
          left: -200, top: -200, right: 1000, bottom: 1000
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_LINEAR));
        canvas.drawImageRect(pixelMap, {
          left: 200, top: 200, right: -1000, bottom: -1000
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_LINEAR));
        canvas.drawImageRect(pixelMap, {
          left: maxVal, top: maxVal, right: maxVal, bottom: maxVal
        });
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_7100
     * @tc.name      : testCanvasDrawImageRectMultipleCalls0071
     * @tc.desc      : testCanvasDrawImageRectMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawImageRectMultipleCalls0071', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawImageRectMultipleCalls0071';
      const canvas = new drawing.Canvas(pixel);
      try {
        for (let i = 0; i < 20; i += 1) {
          const randomEnum = Math.floor(getEnumCount(drawing.FilterMode) * Math.random())
          canvas.drawImageRect(pixelMap, {
            left: Math.random(), top: Math.random(), right: Math.random(), bottom: Math.random()
          }, new drawing.SamplingOptions(randomEnum));
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_7200
     * @tc.name      : testCanvasDrawImageRectToNull0072
     * @tc.desc      : testCanvasDrawImageRectToNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawImageRectToNull0072', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawImageRectToNull0072';
      const canvas = new drawing.Canvas(pixel);

      try {
        canvas.drawImageRect(null, {
          left: 0, top: 0, right: 600, bottom: 600
        });
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRect(pixelMap, null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRect(pixelMap, {
          left: 0, top: 0, right: 600, bottom: 600
        }, null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRect(undefined, {
          left: 0, top: 0, right: 600, bottom: 600
        });
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRect(pixelMap, undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRect(pixelMap, {
          left: 0, top: 0, right: 600, bottom: 600
        }, undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_7300
     * @tc.name      : testCanvasDrawImageRectAbnormal0073
     * @tc.desc      : testCanvasDrawImageRectAbnormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawImageRectAbnormal0073', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawImageRectAbnormal0073';
      const canvas = new drawing.Canvas(pixel);

      try {
        canvas.drawImageRect(pixelMap, {
          left: 0, top: 0, right: 600, bottom: 600
        }, 10);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_7400
     * @tc.name      : testCanvasDrawImageRectWithSrcNormal0074
     * @tc.desc      : testCanvasDrawImageRectWithSrcNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawImageRectWithSrcNormal0074', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawImageRectWithSrcNormal0074';
      const canvas = new drawing.Canvas(pixel);
      const maxVal = Number.MAX_VALUE;
      try {
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 0, top: 0, right: 600, bottom: 600
        }, {
          left: 0, top: 0, right: 600, bottom: 600
        });
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100.1, top: 100.2, right: 700.1, bottom: 700.2
        }, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST));

        for (let i = 0; i < getEnumCount(drawing.FilterMode); i += 1) {
          for (let j = 0; j < getEnumCount(drawing.SrcRectConstraint); j += 1) {
            canvas.drawImageRectWithSrc(pixelMap, {
              left: 100, top: 100.2, right: 700, bottom: 700.2
            }, {
              left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
            }, new drawing.SamplingOptions(i), j);
            //枚举值samplingOptions和constraint交叉遍历验证
          }
        }
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 0, top: 0, right: -600, bottom: -600
        }, {
          left: -100, top: -100, right: 600, bottom: 600
        });
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100, top: 100, right: 100, bottom: 600
        }, {
          left: -100, top: -100, right: -100, bottom: 700
        });
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100, top: 100, right: 100, bottom: 100
        }, {
          left: 700, top: 700, right: 700, bottom: 700
        });
        canvas.drawImageRectWithSrc(pixelMap, {
          left: maxVal, top: maxVal, right: maxVal, bottom: maxVal
        }, {
          left: maxVal, top: maxVal, right: maxVal, bottom: maxVal
        });

        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_7500
     * @tc.name      : testCanvasDrawImageRectWithSrcMultipleCalls0075
     * @tc.desc      : testCanvasDrawImageRectWithSrcMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawImageRectWithSrcMultipleCalls0075', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawImageRectWithSrcMultipleCalls0075';
      const canvas = new drawing.Canvas(pixel);
      try {
        for (let i = 0; i < 20; i += 1) {
          const e1 = Math.floor(Math.random() * getEnumCount(drawing.SamplingOptions))
          const e2 = Math.floor(Math.random() * getEnumCount(drawing.SrcRectConstraint))
          canvas.drawImageRectWithSrc(pixelMap, {
            left: Math.random(), top: Math.random(), right: Math.random(), bottom: Math.random()
          }, {
            left: Math.random(), top: Math.random(), right: Math.random(), bottom: Math.random()
          }, new drawing.SamplingOptions(e1), e2);
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_7600
     * @tc.name      : testCanvasDrawImageRectWithSrcToNull0076
     * @tc.desc      : testCanvasDrawImageRectWithSrcToNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawImageRectWithSrcToNull0076', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawImageRectWithSrcToNull0076';
      const canvas = new drawing.Canvas(pixel);

      try {
        canvas.drawImageRectWithSrc(null, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), drawing.SrcRectConstraint.STRICT);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImageRectWithSrc(null, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), drawing.SrcRectConstraint.FAST);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRectWithSrc(pixelMap, null, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), drawing.SrcRectConstraint.STRICT);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImageRectWithSrc(pixelMap, null, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), drawing.SrcRectConstraint.FAST);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, null, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), drawing.SrcRectConstraint.STRICT);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, null, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), drawing.SrcRectConstraint.FAST);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, null, drawing.SrcRectConstraint.STRICT);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, null, drawing.SrcRectConstraint.FAST);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRectWithSrc(undefined, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), drawing.SrcRectConstraint.STRICT);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRectWithSrc(pixelMap, undefined, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), drawing.SrcRectConstraint.STRICT);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, undefined, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), drawing.SrcRectConstraint.STRICT);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, undefined, drawing.SrcRectConstraint.STRICT);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_7700
     * @tc.name      : testCanvasDrawImageRectWithSrcAbnormal0077
     * @tc.desc      : testCanvasDrawImageRectWithSrcAbnormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawImageRectWithSrcAbnormal0077', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawImageRectWithSrcAbnormal0077';
      const canvas = new drawing.Canvas(pixel);

      try {
        canvas.drawImageRectWithSrc(pixelMap, {
          left: 100, top: 100.2, right: 700, bottom: 700.2
        }, {
          left: 200.1, top: 200.2, right: 800.1, bottom: 800.1
        }, new drawing.SamplingOptions(drawing.FilterMode.FILTER_MODE_NEAREST), 10);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_7800
     * @tc.name      : testCanvasDrawColorNormal0078
     * @tc.desc      : testCanvasDrawColorNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawColorNormal0078', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawColorNormal0078';
      let canvas = new drawing.Canvas(pixel);
      let alpha = 0x00
      let red = 0x00
      let green = 0x00
      let blue = 0x00
      try {
        canvas.drawColor({ alpha: 0xFF, red: 0xFF, green: 0xFF, blue: 0xFF}, drawing.BlendMode.CLEAR);
        canvas.drawColor({ alpha: 0x00, red: 0x00, green: 0x00, blue: 0x00}, drawing.BlendMode.CLEAR);
        canvas.drawColor(alpha= 0x00, red= 0x00, green= 0x00, blue= 0x00, drawing.BlendMode.CLEAR);
        canvas.drawColor(255, drawing.BlendMode.CLEAR);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.CLEAR);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.SRC);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.DST);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.SRC_OVER);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.DST_OVER);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.SRC_IN);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.DST_IN);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.SRC_OUT);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.DST_OUT);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.SRC_ATOP);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.DST_ATOP);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.XOR);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.PLUS);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.MODULATE);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.SCREEN);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.OVERLAY);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.DARKEN);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.LIGHTEN);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.COLOR_DODGE);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.COLOR_BURN);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.HARD_LIGHT);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.SOFT_LIGHT);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.DIFFERENCE);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.EXCLUSION);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.MULTIPLY);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.HUE);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.SATURATION);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.COLOR);
        canvas.drawColor({ alpha: 0xFF, red: 0xE0, green: 0x10, blue: 0xFF}, drawing.BlendMode.LUMINOSITY);
        console.info(msg + 'drawColor successed');
      } catch (e) {
        console.info(msg + `drawColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_7900
     * @tc.name      : testCanvasDrawColorNull0079
     * @tc.desc      : testCanvasDrawColorNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawColorNull0079', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawColorNull0079';
      let canvas = new drawing.Canvas(pixel);
      try {
        canvas.drawColor(null, drawing.BlendMode.CLEAR);
        console.info(msg + 'drawColor successed');
      } catch (e) {
        console.info(msg + `drawColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawColor(undefined, drawing.BlendMode.CLEAR);
        console.info(msg + 'drawColor successed');
      } catch (e) {
        console.info(msg + `drawColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawColor({ alpha: 0x00, red: 0x00, green: 0x00, blue: 0x00}, undefined);
        console.info(msg + 'drawColor successed');
      } catch (e) {
        console.info(msg + `drawColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_8000
     * @tc.name      : testCanvasDrawColorMultipleCalls0080
     * @tc.desc      : testCanvasDrawColorMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawColorMultipleCalls0080', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawColorMultipleCalls0080';
      try {
        let canvas = new drawing.Canvas(pixel);
        for (let index = 0; index < 20; index++) {
          const randomEnum = Math.floor(Math.random() * (getEnumCount(drawing.BlendMode)));
          canvas.drawColor({
            alpha: Math.random() * 255, red: Math.random() * 255, green: Math.random() * 255, blue: Math.random() * 255}, randomEnum);
        }
        console.info(msg + 'drawColor successed');
      } catch (e) {
        console.info(msg + `drawColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_8100
     * @tc.name      : testCanvasDrawColorBoundaryValue0081
     * @tc.desc      : testCanvasDrawColorBoundaryValue
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawColorBoundaryValue0081', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawColorBoundaryValue0081';
      let canvas = new drawing.Canvas(pixel);
      try {
        canvas.drawColor({ alpha: -1, red: 0xFF, green: 0xFF, blue: 0xFF}, drawing.BlendMode.CLEAR);
        console.info(msg + 'drawColor successed');
      } catch (e) {
        console.info(msg + `drawColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawColor({ alpha: 0xFF, red: -1, green: 0xFF, blue: 0xFF}, drawing.BlendMode.CLEAR);
        console.info(msg + 'drawColor successed');
      } catch (e) {
        console.info(msg + `drawColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawColor({ alpha: 0xFF, red: 0xFF, green: -1, blue: 0xFF}, drawing.BlendMode.CLEAR);
        console.info(msg + 'drawColor successed');
      } catch (e) {
        console.info(msg + `drawColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawColor({ alpha: 0xFF, red: 0xFF, green: 0xFF, blue: -1}, drawing.BlendMode.CLEAR);
        console.info(msg + 'drawColor successed');
      } catch (e) {
        console.info(msg + `drawColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawColor({ alpha: 256, red: 0xFF, green: 0xFF, blue: 0xFF}, drawing.BlendMode.CLEAR);
        console.info(msg + 'drawColor successed');
      } catch (e) {
        console.info(msg + `drawColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawColor({ alpha: 0xFF, red: 256, green: 0xFF, blue: 0xFF}, drawing.BlendMode.CLEAR);
        console.info(msg + 'drawColor successed');
      } catch (e) {
        console.info(msg + `drawColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawColor({ alpha: 0xFF, red: 0xFF, green: 256, blue: 0xFF}, drawing.BlendMode.CLEAR);
        console.info(msg + 'drawColor successed');
      } catch (e) {
        console.info(msg + `drawColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawColor({ alpha: 0xFF, red: 0xFF, green: 0xFF, blue: 256}, drawing.BlendMode.CLEAR);
        console.info(msg + 'drawColor successed');
      } catch (e) {
        console.info(msg + `drawColor errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_8200
     * @tc.name      : testCanvasDrawOvalNormal0082
     * @tc.desc      : testCanvasDrawOvalNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawOvalNormal0082', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawOvalNormal0082';
      const canvas = new drawing.Canvas(pixel);
      const maxVal = Number.MAX_VALUE;

      try {
        canvas.drawOval({
          left: 100, right: 400, top: 50, bottom: 200
        });
        canvas.drawOval({
          left: 100.1, right: 400.1, top: 50.1, bottom: 200.1
        });
        canvas.drawOval({
          left: -100, right: 400, top: -50, bottom: 200
        });
        canvas.drawOval({
          left: 100, right: -400, top: 50, bottom: -200
        });
        canvas.drawOval({
          left: 100, right: 100, top: 100, bottom: 200
        });
        canvas.drawOval({
          left: 100, right: 100, top: 100, bottom: 100
        });
        canvas.drawOval({
          left: maxVal, right: maxVal, top: maxVal, bottom: maxVal
        });
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_8300
     * @tc.name      : testCanvasDrawOvalMultipleCalls0083
     * @tc.desc      : testCanvasDrawOvalMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawOvalMultipleCalls0083', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawOvalMultipleCalls0083';
      const canvas = new drawing.Canvas(pixel);
      try {
        for (let i = 0; i < 20; i += 1) {
          canvas.drawOval({
            left: Math.random(), right: Math.random(), top: Math.random(), bottom: Math.random()
          });
        }

        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_8400
     * @tc.name      : testCanvasDrawOvalToNull0084
     * @tc.desc      : testCanvasDrawOvalToNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawOvalToNull0084', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawOvalToNull0084';
      const canvas = new drawing.Canvas(pixel);

      try {
        canvas.drawOval(null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawOval(undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawOval({
          left: null, right: 400, top: 50, bottom: 200
        });
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawOval({
          left: 100, right: null, top: 50, bottom: 200
        });
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawOval({
          left: 100, right: 400, top: null, bottom: 200
        });
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawOval({
          left: 100, right: 400, top: 50, bottom: null
        });
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawOval({
          left: undefined, right: 400, top: 50, bottom: 200
        });
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawOval({
          left: 100, right: undefined, top: 50, bottom: 200
        });
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawOval({
          left: 100, right: 400, top: undefined, bottom: 200
        });
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawOval({
          left: 100, right: 400, top: 50, bottom: undefined
        });
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_8500
     * @tc.name      : testCanvasDrawArcNormal0085
     * @tc.desc      : testCanvasDrawArcNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawArcNormal0085', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawArcNormal0085';
      const canvas = new drawing.Canvas(pixel);
      const maxVal = Number.MAX_VALUE;
      try {
        canvas.drawArc({
          left: 100, right: 400, top: 50, bottom: 200
        }, 90, 180);
        canvas.drawArc({
          left: 100.1, right: 400.1, top: 50.1, bottom: 200.1
        }, 450, 450);
        canvas.drawArc({
          left: -100, right: 400, top: -50, bottom: 200
        }, -90, -90);
        canvas.drawArc({
          left: 100, right: -400, top: 50, bottom: -200
        }, 90, 180);
        canvas.drawArc({
          left: 100, right: 100, top: 100, bottom: 200
        }, -90, 180);
        canvas.drawArc({
          left: 100, right: 100, top: 100, bottom: 100
        }, 90, -180);
        canvas.drawArc({
          left: maxVal, right: maxVal, top: maxVal, bottom: maxVal
        }, 90, 180);
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_8600
     * @tc.name      : testCanvasDrawArcMultipleCalls0086
     * @tc.desc      : testCanvasDrawArcMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawArcMultipleCalls0086', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawArcMultipleCalls0086';
      const canvas = new drawing.Canvas(pixel);
      try {
        for (let i = 0; i < 20; i += 1) {
          canvas.drawArc({
            left: Math.random(), right: Math.random(), top: Math.random(), bottom: Math.random()
          }, 90, 180);
        }
        console.info(msg + 'test successes');
      } catch (e) {
        console.info(msg + `test errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_8700
     * @tc.name      : testCanvasDrawArcToNull0087
     * @tc.desc      : testCanvasDrawArcToNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawArcToNull0087', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawArcToNull0087';
      const canvas = new drawing.Canvas(pixel);

      try {
        canvas.drawArc(null, 90, 180);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawArc(undefined, 90, 180);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawArc({
          left: null, right: 400, top: 50, bottom: 200
        }, 90, 180);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawArc({
          left: 100, right: null, top: 50, bottom: 200
        }, 90, 180);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawArc({
          left: 100, right: 400, top: null, bottom: 200
        }, 90, 180);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawArc({
          left: 100, right: 400, top: 50, bottom: null
        }, 90, 180);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawArc({
          left: undefined, right: 400, top: 50, bottom: 200
        }, 90, 180);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawArc({
          left: 100, right: undefined, top: 50, bottom: 200
        }, 90, 180);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawArc({
          left: 100, right: 400, top: undefined, bottom: 200
        }, 90, 180);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawArc({
          left: 100, right: 400, top: 50, bottom: undefined
        }, 90, 180);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawArc({
          left: 100, right: 400, top: 50, bottom: 200
        }, null, 180);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawArc({
          left: 100, right: 400, top: 50, bottom: 200
        }, 90, null);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawArc({
          left: 100, right: 400, top: 50, bottom: 200
        }, undefined, 180);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

      try {
        canvas.drawArc({
          left: 100, right: 400, top: 50, bottom: 200
        }, 90, undefined);
        console.info(msg + `test error`);
        expect().assertFail()
      } catch (e) {
        console.info(msg + `test successes. errorCode is: ${e.code} + errormsg is: ${e.message}}`);
        expect(e.code).assertEqual(401);
      }

    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_8800
     * @tc.name      : testCanvasDrawArcWithCenterNormal0088
     * @tc.desc      : testCanvasDrawArcWithCenterNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawArcWithCenterNormal0088', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawArcWithCenterNormal0088';
      let canvas = new drawing.Canvas(pixel);
      let rect: common2D.Rect = {
        left: 100, top: 20, right: 120, bottom: 120
      };
      try {
        canvas.drawArcWithCenter(rect, 80, 280, true);
      } catch (e) {
        console.info(msg + `quickRejectPath 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      rect = {
        left: 100, top: 20, right: 300, bottom: 120
      };
      try {
        canvas.drawArcWithCenter(rect, 0, 100, true);
      } catch (e) {
        console.info(msg + `drawArcWithCenter 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      rect = {
        left: 350, top: 20, right: 450, bottom: 120
      };
      try {
        canvas.drawArcWithCenter(rect, 80, 280, false);
      } catch (e) {
        console.info(msg + `drawArcWithCenter 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      rect = {
        left: 425, top: 20, right: 525, bottom: 120
      };
      try {
        canvas.drawArcWithCenter(rect, 0, 0, true);
      } catch (e) {
        console.info(msg + `drawArcWithCenter 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        canvas.drawArcWithCenter(rect, 0, 0, false);
      } catch (e) {
        console.info(msg + `drawArcWithCenter 5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        canvas.drawArcWithCenter(rect, 0, -90, true);
      } catch (e) {
        console.info(msg + `drawArcWithCenter 6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        canvas.drawArcWithCenter(rect, 0, 90, false);
      } catch (e) {
        console.info(msg + `drawArcWithCenter 7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        canvas.drawArcWithCenter(rect, 0, 360, false);
      } catch (e) {
        console.info(msg + `drawArcWithCenter 8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        canvas.drawArcWithCenter(rect, -90, 0, true);
      } catch (e) {
        console.info(msg + `drawArcWithCenter 9 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        canvas.drawArcWithCenter(rect, 360, 0, true);
      } catch (e) {
        console.info(msg + `drawArcWithCenter 10 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        canvas.drawArcWithCenter(rect, -90, -200, false);
      } catch (e) {
        console.info(msg + `drawArcWithCenter 11 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        canvas.drawArcWithCenter(rect, 90, 200, true);
      } catch (e) {
        console.info(msg + `drawArcWithCenter 12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        canvas.drawArcWithCenter(rect, 0, 380, true);
      } catch (e) {
        console.info(msg + `drawArcWithCenter 13 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        canvas.drawArcWithCenter(rect, 380, 60, false);
      } catch (e) {
        console.info(msg + `drawArcWithCenter 14 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      try {
        canvas.drawArcWithCenter(rect, 10000, 10000, true);
      } catch (e) {
        console.info(msg + `drawArcWithCenter 14 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_8900
     * @tc.name      : testCanvasDrawArcWithCenterNull0089
     * @tc.desc      : testCanvasDrawArcWithCenterNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level4
     */
    it('testCanvasDrawArcWithCenterNull0089', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL4, () => {
      let msg = 'testCanvasDrawArcWithCenterNull0089';
      let canvas = new drawing.Canvas(pixel);
      let rect: common2D.Rect = {
        left: 20,
        top: 20,
        right: 120,
        bottom: 120
      };
      try {
        canvas.drawArcWithCenter(null, 380, 60, false);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawArcWithCenter 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawArcWithCenter(undefined, 380, 60, false);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawArcWithCenter 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawArcWithCenter(rect, null, 60, true);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawArcWithCenter 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawArcWithCenter(rect, undefined, 60, true);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawArcWithCenter 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawArcWithCenter(rect, 380, null, true);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawArcWithCenter 5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawArcWithCenter(rect, 380, undefined, true);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawArcWithCenter 6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawArcWithCenter(rect, 380, 60, null);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawArcWithCenter 7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        canvas.drawArcWithCenter(rect, 380, 60, undefined);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `drawArcWithCenter 8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_9000
     * @tc.name      : testCanvasDrawArcWithCenterMultipleCalls0090
     * @tc.desc      : testCanvasDrawArcWithCenterMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawArcWithCenterMultipleCalls0090', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawArcWithCenterMultipleCalls0090';
      const path = new drawing.Path();
      let canvas = new drawing.Canvas(pixel);
      for(let i = 0; i < 20; i++) {
        let rect: common2D.Rect = {
          left: 100 + i * 0.01, top: 100 + i * 0.01, right: 300 + i * 0.01, bottom: 300 + i * 0.01
        };
        try {
          canvas.drawArcWithCenter(rect, 0, 180, true);
        } catch (e) {
          console.info(msg + `drawArcWithCenter ${i} errorCode is:  ${e.code} + errormsg is: ${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_9100
     * @tc.name      : testCanvasDrawArcWithCenterMax0091
     * @tc.desc      : testCanvasDrawArcWithCenterMax
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawArcWithCenterMax0091', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawArcWithCenterMax0091';
      const path = new drawing.Path();
      let canvas = new drawing.Canvas(pixel);
      let rect: common2D.Rect = {
        left: Number.MAX_VALUE, top: Number.MAX_VALUE, right: Number.MAX_VALUE + 100, bottom: Number.MAX_VALUE + 100
      };
      try {
        canvas.drawArcWithCenter(rect, 0, 180, true);
      } catch (e) {
        console.info(msg + `drawArcWithCenter 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
      rect = {
        left: -Number.MAX_VALUE, top: -Number.MAX_VALUE, right: Number.MAX_VALUE + 100, bottom: Number.MAX_VALUE + 100
      };
      try {
        canvas.drawArcWithCenter(rect, 0, 180, true);
      } catch (e) {
        console.info(msg + `drawArcWithCenter 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_9200
     * @tc.name      : testCanvasDrawPointsNormal0092
     * @tc.desc      : testCanvasDrawPointsNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawPointsNormal0092', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawPointsNormal0092';
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_9300
     * @tc.name      : testCanvasDrawPointsMultipleCalls0093
     * @tc.desc      : testCanvasDrawPointsMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawPointsMultipleCalls0093', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawPointsMultipleCalls0093';
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_9400
     * @tc.name      : testCanvasDrawPointsToNull0094
     * @tc.desc      : testCanvasDrawPointsToNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawPointsToNull0094', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawPointsToNull0094';
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_9500
     * @tc.name      : testCanvasDrawPointsAbnormal0095
     * @tc.desc      : testCanvasDrawPointsAbnormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawPointsAbnormal0095', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawPointsAbnormal0095';
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
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_9600
     * @tc.name      : testCanvasDrawPointNormal0096
     * @tc.desc      : testCanvasDrawPointNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawPointNormal0096', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawPointNormal0096';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.drawPoint(10, 10);
        canvas.drawPoint(10.1, 10.1);
        canvas.drawPoint(-10, -10);
        canvas.detachPen();
        console.info(msg + 'drawPoint successed');
      } catch (e) {
        console.info(msg + `drawPoint errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_9700
     * @tc.name      : testCanvasDrawPointNull0097
     * @tc.desc      : testCanvasDrawPointNull
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawPointNull0097', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawPointNull0097';
      const canvas = new drawing.Canvas(pixel);
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.drawPoint(undefined, 10);
        canvas.detachPen();
        console.info(msg + 'drawPoint successed');
      } catch (e) {
        console.info(msg + `drawPoint errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.drawPoint(10, undefined);
        canvas.detachPen();
        console.info(msg + 'drawPoint successed');
      } catch (e) {
        console.info(msg + `drawPoint errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.drawPoint(null, 10);
        canvas.detachPen();
        console.info(msg + 'drawPoint successed');
      } catch (e) {
        console.info(msg + `drawPoint errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        canvas.drawPoint(10, null);
        canvas.detachPen();
        console.info(msg + 'drawPoint successed');
      } catch (e) {
        console.info(msg + `drawPoint errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_9800
     * @tc.name      : testCanvasDrawPointMultipleCalls0098
     * @tc.desc      : testCanvasDrawPointMultipleCalls
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testCanvasDrawPointMultipleCalls0098', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testCanvasDrawPointMultipleCalls0098';
      try {
        const canvas = new drawing.Canvas(pixel);
        const pen = new drawing.Pen();
        pen.setStrokeWidth(5);
        pen.setColor({alpha: 255, red: 255, green: 0, blue: 0});
        canvas.attachPen(pen);
        for (let index = 0; index < 20; index++) {
          canvas.drawPoint(Math.random() * Number.MAX_VALUE, Math.random() * Number.MAX_VALUE);
        }
        canvas.detachPen();
        console.info(msg + 'drawPoint successed');
      } catch (e) {
        console.info(msg + `drawPoint errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_BASIC_GRAPHICS_SPECIAL_API_TS_DRAWING_CANVAS_9900
     * @tc.name      : testCanvasDrawPathNormal0099
     * @tc.desc      : testCanvasDrawPathNormal
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level0
     */
    it('testCanvasDrawPathNormal0099', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, () => {
      let msg = 'testCanvasDrawPathNormal0099';
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
        canvas.drawPath(path);
        canvas.detachPen();
        console.info(msg + 'drawPath successed');
      } catch (e) {
        console.info(msg + `drawPath errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail();
      }
    })
  })
}
