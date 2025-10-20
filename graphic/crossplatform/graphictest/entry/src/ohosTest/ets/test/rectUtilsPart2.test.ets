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
import common2D from '@ohos.graphics.common2D';

export default function rectUtilsTestPart2() {
  describe('DrawingTsRectUtilsTest', () => {
    beforeAll(async () => {
    })
    beforeEach(() => {
    })
    afterEach(() => {
    })
    afterAll(() => {
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_MAKEEMPTY_0100
     * @tc.name      : testMakeEmpty0001
     * @tc.desc      : Test for testRectUtilsMakeEmptyNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testMakeEmpty0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let msg = 'testRectUtilsMakeEmptyNormal';
      try {
        let rect = drawing.RectUtils.makeEmpty();
        console.info(msg + ' RectUtils makeEmpty successed rect: ' + JSON.stringify(rect));
        expect(rect.left).assertEqual(0);
        expect(rect.top).assertEqual(0);
        expect(rect.right).assertEqual(0);
        expect(rect.bottom).assertEqual(0);
      } catch (e) {
        console.info(msg + ` RectUtils makeEmpty errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_MAKEEMPTY_0200
     * @tc.name      : testMakeEmpty0002
     * @tc.desc      : testRectUtilsMakeEmptyMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testMakeEmpty0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsMakeEmptyMultipleCalls';
      for (let i = 0; i < 20; i += 1) {
        try {
          let rect = drawing.RectUtils.makeEmpty();
          console.info(msg + `RectUtils makeEmpty success step: ` + i);
          console.info(msg + `RectUtils makeEmpty success rect: ` + JSON.stringify(rect));
          expect(rect.left).assertEqual(0);
          expect(rect.top).assertEqual(0);
          expect(rect.right).assertEqual(0);
          expect(rect.bottom).assertEqual(0);
        } catch (e) {
          console.info(msg +
            `RectUtils makeEmpty error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_MAKELTRB_0300
     * @tc.name      : testMakeLtrb0003
     * @tc.desc      : Test for testRectUtilsMakeLtrbNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testMakeLtrb0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let msg = 'testRectUtilsMakeLtrbNormal';
      try {
        let rect = drawing.RectUtils.makeLtrb(10, 20, 20, 20);
        console.info(msg + ' RectUtils makeEmpty successed rect: ' + JSON.stringify(rect));
        expect(rect.left).assertEqual(10);
        expect(rect.top).assertEqual(20);
        expect(rect.right).assertEqual(20);
        expect(rect.bottom).assertEqual(20);
      } catch (e) {
        console.info(msg + ` RectUtils makeEmpty rect errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let rect2 = drawing.RectUtils.makeLtrb(10, 10, 10, 20);
        console.info(msg + ' RectUtils makeEmpty successed rect2: ' + JSON.stringify(rect2));
        expect(rect2.left).assertEqual(10);
        expect(rect2.top).assertEqual(10);
        expect(rect2.right).assertEqual(10);
        expect(rect2.bottom).assertEqual(20);
      } catch (e) {
        console.info(msg + ` RectUtils makeEmpty rect2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let rect3 = drawing.RectUtils.makeLtrb(10, 10, 10, 10);
        console.info(msg + ' RectUtils makeEmpty successed rect3: ' + JSON.stringify(rect3));
        expect(rect3.left).assertEqual(10);
        expect(rect3.top).assertEqual(10);
        expect(rect3.right).assertEqual(10);
        expect(rect3.bottom).assertEqual(10);
      } catch (e) {
        console.info(msg + ` RectUtils makeEmpty rect3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let rect4 = drawing.RectUtils.makeLtrb(0, 10.2632, 100.25474, 100.2884);
        console.info(msg + ' RectUtils makeEmpty successed rect4: ' + JSON.stringify(rect4));
        expect(rect4.left).assertEqual(0);
        expect(rect4.top).assertEqual(10.2632);
        expect(rect4.right).assertEqual(100.25474);
        expect(rect4.bottom).assertEqual(100.2884);
      } catch (e) {
        console.info(msg + ` RectUtils makeEmpty rect4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let rect5 = drawing.RectUtils.makeLtrb(-100, -100.98788, 100.20, 100);
        console.info(msg + ' RectUtils makeEmpty successed rect5: ' + JSON.stringify(rect5));
        expect(rect5.left).assertEqual(-100);
        expect(rect5.top).assertEqual(-100.98788);
        expect(rect5.right).assertEqual(100.20);
        expect(rect5.bottom).assertEqual(100);
      } catch (e) {
        console.info(msg + ` RectUtils makeEmpty rect5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let rect6 = drawing.RectUtils.makeLtrb(80000, 80000.25, 0, -20000);
        console.info(msg + ' RectUtils makeEmpty successed rect6: ' + JSON.stringify(rect6));
        expect(rect6.left).assertEqual(80000);
        expect(rect6.top).assertEqual(80000.25);
        expect(rect6.right).assertEqual(0);
        expect(rect6.bottom).assertEqual(-20000);
      } catch (e) {
        console.info(msg + ` RectUtils makeEmpty rect6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let rect7 = drawing.RectUtils.makeLtrb(Number.MIN_VALUE, Number.MIN_VALUE, Number.MAX_VALUE, Number.MAX_VALUE);
        console.info(msg + ' RectUtils makeEmpty successed rect7: ' + JSON.stringify(rect7));
      } catch (e) {
        console.info(msg + ` RectUtils makeEmpty rect7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_MAKELTRB_0400
     * @tc.name      : testMakeLtrb0004
     * @tc.desc      : testRectUtilsMakeLtrbMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testMakeLtrb0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsMakeLtrbMultipleCalls';
      for (let i = 0; i < 20; i += 1) {
        try {
          let rect = drawing.RectUtils.makeLtrb(Math.random() * 10, Math.random() * 20, Math.random() * 100,
            Math.random() * 200);
          console.info(msg + `RectUtils.makeLtrb success step: ` + i);
          console.info(msg + `RectUtils.makeLtrb success rect: ` + JSON.stringify(rect));
        } catch (e) {
          console.info(msg +`RectUtils.makeLtrb error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_MAKELTRB_0500
     * @tc.name      : testMakeLtrb0005
     * @tc.desc      : testRectUtilsMakeLtrbNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testMakeLtrb0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsMakeLtrbNull';
      try {
        let rect = drawing.RectUtils.makeLtrb(null, 100, 200, 200);
        console.info(msg + `RectUtils makeLtrb rect successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils makeLtrb rect failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let rect2 = drawing.RectUtils.makeLtrb(undefined, 100, 200, 200);
        console.info(msg + `RectUtils makeLtrb rect2 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils makeLtrb rect2 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let rect3 = drawing.RectUtils.makeLtrb(100, null, 200, 200);
        console.info(msg + `RectUtils makeLtrb rect3 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils makeLtrb rect3 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let rect4 = drawing.RectUtils.makeLtrb(100, undefined, 200, 200);
        console.info(msg + `RectUtils makeLtrb rect4 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils makeLtrb rect4 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let rect5 = drawing.RectUtils.makeLtrb(100, 100, null, 200);
        console.info(msg + `RectUtils makeLtrb rect5 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils makeLtrb rect5 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let rect6 = drawing.RectUtils.makeLtrb(100, 100, undefined, 200);
        console.info(msg + `RectUtils makeLtrb rect6 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils makeLtrb rect6 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let rect7 = drawing.RectUtils.makeLtrb(100, 100, 200, null);
        console.info(msg + `RectUtils makeLtrb rect7 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils makeLtrb rect7 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let rect8 = drawing.RectUtils.makeLtrb(100, 100, 200, undefined);
        console.info(msg + `RectUtils makeLtrb rect8 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils makeLtrb rect8 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_MAKECOPY_0600
     * @tc.name      : testMakeCopy0006
     * @tc.desc      : Test for testRectUtilsMakeCopyNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testMakeCopy0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let msg = 'testRectUtilsMakeCopyNormal';
      let rect = drawing.RectUtils.makeEmpty();
      try {
        let rect2 = drawing.RectUtils.makeCopy(rect);
        console.info(msg + ' RectUtils makeCopy successed rect2: ' + JSON.stringify(rect2));
        expect(rect2.left).assertEqual(0);
        expect(rect2.top).assertEqual(0);
        expect(rect2.right).assertEqual(0);
        expect(rect2.bottom).assertEqual(0);
      } catch (e) {
        console.info(msg + ` RectUtils makeCopy rect2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = {
        left: 0,
        right: 0,
        top: 0,
        bottom: 0
      };
      try {
        let rect3 = drawing.RectUtils.makeCopy(rect);
        console.info(msg + ' RectUtils makeCopy successed rect3: ' + JSON.stringify(rect3));
        expect(rect3.left).assertEqual(0);
        expect(rect3.top).assertEqual(0);
        expect(rect3.right).assertEqual(0);
        expect(rect3.bottom).assertEqual(0);
      } catch (e) {
        console.info(msg + ` RectUtils makeCopy rect3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 20, 20, 20);
      try {
        let rect4 = drawing.RectUtils.makeCopy(rect);
        console.info(msg + ' RectUtils makeCopy successed rect4: ' + JSON.stringify(rect4));
        expect(rect4.left).assertEqual(10);
        expect(rect4.top).assertEqual(20);
        expect(rect4.right).assertEqual(20);
        expect(rect4.bottom).assertEqual(20);
      } catch (e) {
        console.info(msg + ` RectUtils makeCopy rect4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 20);
      try {
        let rect5 = drawing.RectUtils.makeCopy(rect);
        console.info(msg + ' RectUtils makeCopy successed rect5: ' + JSON.stringify(rect5));
        expect(rect5.left).assertEqual(10);
        expect(rect5.top).assertEqual(10);
        expect(rect5.right).assertEqual(10);
        expect(rect5.bottom).assertEqual(20);
      } catch (e) {
        console.info(msg + ` RectUtils makeCopy rect5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 10);
      try {
        let rect6 = drawing.RectUtils.makeCopy(rect);
        console.info(msg + ' RectUtils makeCopy successed rect6: ' + JSON.stringify(rect6));
        expect(rect6.left).assertEqual(10);
        expect(rect6.top).assertEqual(10);
        expect(rect6.right).assertEqual(10);
        expect(rect6.bottom).assertEqual(10);
      } catch (e) {
        console.info(msg + ` RectUtils makeCopy rect6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 10.2632, 100.25474, 100.2884);
      try {
        let rect7 = drawing.RectUtils.makeCopy(rect);
        console.info(msg + ' RectUtils makeCopy successed rect7: ' + JSON.stringify(rect7));
        expect(rect7.left).assertEqual(0);
        expect(rect7.top).assertEqual(10.2632);
        expect(rect7.right).assertEqual(100.25474);
        expect(rect7.bottom).assertEqual(100.2884);
      } catch (e) {
        console.info(msg + ` RectUtils makeCopy rect7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(-100, -100.98788, 100.20, 100);
      try {
        let rect8 = drawing.RectUtils.makeCopy(rect);
        console.info(msg + ' RectUtils makeCopy successed rect8: ' + JSON.stringify(rect8));
        expect(rect8.left).assertEqual(-100);
        expect(rect8.top).assertEqual(-100.98788);
        expect(rect8.right).assertEqual(100.20);
        expect(rect8.bottom).assertEqual(100);
      } catch (e) {
        console.info(msg + ` RectUtils makeCopy rect8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(80000, 80000.25, 0, -20000);
      try {
        let rect9 = drawing.RectUtils.makeCopy(rect);
        console.info(msg + ' RectUtils makeCopy successed rect9: ' + JSON.stringify(rect9));
        expect(rect9.left).assertEqual(80000);
        expect(rect9.top).assertEqual(80000.25);
        expect(rect9.right).assertEqual(0);
        expect(rect9.bottom).assertEqual(-20000);
      } catch (e) {
        console.info(msg + ` RectUtils makeCopy rect9 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = {
        left: 0,
        right: 100,
        top: 125,
        bottom: 225
      };
      try {
        let rect10 = drawing.RectUtils.makeCopy(rect);
        console.info(msg + ' RectUtils makeCopy successed rect10: ' + JSON.stringify(rect10));
        expect(rect10.left).assertEqual(0);
        expect(rect10.top).assertEqual(125);
        expect(rect10.right).assertEqual(100);
        expect(rect10.bottom).assertEqual(225);
      } catch (e) {
        console.info(msg + ` RectUtils makeCopy rect10 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(Number.MIN_VALUE, Number.MIN_VALUE, Number.MAX_VALUE, Number.MAX_VALUE);
      try {
        let rect11 = drawing.RectUtils.makeCopy(rect);
        console.info(msg + ' RectUtils makeCopy successed rect11: ' + JSON.stringify(rect11));
        expect(rect11 != null || rect11 != undefined).assertTrue();
      } catch (e) {
        console.info(msg + ` RectUtils makeCopy rect11 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_MAKECOPY_0700
     * @tc.name      : testMakeCopy0007
     * @tc.desc      : testRectUtilsMakeCopyMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testMakeCopy0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsMakeCopyMultipleCalls';
      let rect = drawing.RectUtils.makeEmpty();
      let rect2 = drawing.RectUtils.makeEmpty();
      for (let i = 0; i < 20; i += 1) {
        try {
          rect2 = {
            left: 0,
            right: 100,
            top: 0,
            bottom: 100
          };
          rect = {
            left: 0,
            right: 0,
            top: 0,
            bottom: 0
          };
          rect2 = drawing.RectUtils.makeCopy(rect);
          console.info(msg + `RectUtils.makeCopy success step: ` + i);
          console.info(msg + `RectUtils.makeCopy success rect2: ` + JSON.stringify(rect2));
          expect(rect2.left).assertEqual(0);
          expect(rect2.top).assertEqual(0);
          expect(rect2.right).assertEqual(0);
          expect(rect2.bottom).assertEqual(0);
        } catch (e) {
          console.info(msg +
            `RectUtils.makeCopy error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_MAKECOPY_0800
     * @tc.name      : testMakeCopy0008
     * @tc.desc      : testRectUtilsMakeCopyNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testMakeCopy0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsMakeCopyNull';
      try {
        let rect = drawing.RectUtils.makeCopy(null);
        console.info(msg + `RectUtils makeCopy rect successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils makeCopy rect failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let rect2 = drawing.RectUtils.makeCopy(undefined);
        console.info(msg + `RectUtils makeCopy rect2 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils makeCopy rect2 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_GETWIDTH_0900
     * @tc.name      : testGetWidth0009
     * @tc.desc      : Test for testRectUtilsGetWidthNormal.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testGetWidth0009', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      let msg = 'testRectUtilsGetWidth_Normal';
      let rect = drawing.RectUtils.makeEmpty()
      try {
        rect = drawing.RectUtils.makeEmpty();
        let width = drawing.RectUtils.getWidth(rect);
        console.info(`${msg} - Empty rect width: ${width}`);
        expect(width).assertEqual(0);
      } catch (e) {
        console.error(`${msg} - Empty rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(100, 200, 200, 200);
        let width = drawing.RectUtils.getWidth(rect);
        console.info(`${msg} - Integer rect width: ${width}`);
        expect(width).assertEqual(100);
      } catch (e) {
        console.error(`${msg} - Integer rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(100, 100, 100, 200);
        let width = drawing.RectUtils.getWidth(rect);
        console.info(`${msg} - Equal L/R rect width: ${width}`);
        expect(width).assertEqual(0);
      } catch (e) {
        console.error(`${msg} - Equal L/R rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(0, 10.2632, 100.25474, 100.2884);
        let width = drawing.RectUtils.getWidth(rect);
        console.info(`${msg} - Float rect width: ${width}`);
        expect(width).assertEqual(100.2547378540039);
      } catch (e) {
        console.error(`${msg} - Float rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(-100, -100.98788, 100.20, 100);
        let width = drawing.RectUtils.getWidth(rect);
        console.info(`${msg} - Negative rect width: ${width}`);
        expect(width).assertEqual(200.1999969482422);
      } catch (e) {
        console.error(`${msg} - Negative rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(80000, 80000.25, 0, -20000);
        let width = drawing.RectUtils.getWidth(rect);
        console.info(`${msg} - L>R rect width: ${width}`);
        expect(width).assertEqual(-80000);
      } catch (e) {
        console.error(`${msg} - L>R rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE + 1, Number.MAX_VALUE + 1);
        let width = drawing.RectUtils.getWidth(rect);
        console.info(`${msg} - Max value rect width: ${width}`);
      } catch (e) {
        console.error(`${msg} - Max value rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_GETWIDTH_1000
     * @tc.name      : testGetWidth0010
     * @tc.desc      : Test for testRectUtilsGetWidthMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testGetWidth0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsGetWidth_MultipleCalls';
      let loopTimes = 20;

      for (let i = 0; i < loopTimes; i++) {
        try {
          let rect = drawing.RectUtils.makeLtrb(100, 100, 200, 200);
          let width = drawing.RectUtils.getWidth(rect);
          console.info(`${msg} - Step ${i}: width=${width}`);
          expect(width).assertEqual(100);
        } catch (e) {
          console.error(`${msg} - Step ${i} error: code=${e.code}, msg=${e.message}`);
          expect().assertFail();
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_GETWIDTH_1100
     * @tc.name      : testGetWidth0011
     * @tc.desc      : Test for testRectUtilsGetWidthAbnormal.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testGetWidth0011', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsGetWidth_Abnormal';

      try {
        drawing.RectUtils.getWidth(null);
        console.error(`${msg} - Null input should throw error, but not`);
        expect().assertFail();
      } catch (e) {
        console.info(`${msg} - Null input error: code=${e.code}, msg=${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.RectUtils.getWidth(undefined);
        console.error(`${msg} - Undefined input should throw error, but not`);
        expect().assertFail();
      } catch (e) {
        console.info(`${msg} - Undefined input error: code=${e.code}, msg=${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_GETHEIGHT_1200
     * @tc.name      : testGetHeight0012
     * @tc.desc      : Test for testRectUtilsGetHeightNormal.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testGetHeight0012', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      let msg = 'testRectUtilsGetHeight_Normal';
      let rect = drawing.RectUtils.makeEmpty()

      try {
        rect = drawing.RectUtils.makeEmpty();
        let height = drawing.RectUtils.getHeight(rect);
        console.info(`${msg} - Empty rect height: ${height}`);
        expect(height).assertEqual(0);
      } catch (e) {
        console.error(`${msg} - Empty rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(100, 200, 200, 200);
        let height = drawing.RectUtils.getHeight(rect);
        console.info(`${msg} - Equal T/B rect height: ${height}`);
        expect(height).assertEqual(0);
      } catch (e) {
        console.error(`${msg} - Equal T/B rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(100, 100, 100, 200);
        let height = drawing.RectUtils.getHeight(rect);
        console.info(`${msg} - Integer rect height: ${height}`);
        expect(height).assertEqual(100);
      } catch (e) {
        console.error(`${msg} - Integer rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(0, 10.2632, 100.25474, 100.2884);
        let height = drawing.RectUtils.getHeight(rect);
        console.info(`${msg} - Float rect height: ${height}`);
        expect(height).assertEqual(90.02519989013672);
      } catch (e) {
        console.error(`${msg} - Float rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(-100, -100.98788, 100.20, 100);
        let height = drawing.RectUtils.getHeight(rect);
        console.info(`${msg} - Negative rect height: ${height}`);
        expect(height).assertEqual(200.98788452148438);
      } catch (e) {
        console.error(`${msg} - Negative rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(80000, 80000.25, 0, -20000);
        let height = drawing.RectUtils.getHeight(rect);
        console.info(`${msg} - T>B rect height: ${height}`);
        expect(height).assertEqual(-100000.25);
      } catch (e) {
        console.error(`${msg} - T>B rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE + 1, Number.MAX_VALUE + 1);
        let height = drawing.RectUtils.getHeight(rect);
        console.info(`${msg} - Max value rect height: ${height}`);
      } catch (e) {
        console.error(`${msg} - Max value rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_GETHEIGHT_1300
     * @tc.name      : testGetHeight0013
     * @tc.desc      : Test for testRectUtilsGetHeightMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testGetHeight0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsGetHeight_MultipleCalls';
      let loopTimes = 20;

      for (let i = 0; i < loopTimes; i++) {
        try {
          let rect = drawing.RectUtils.makeLtrb(100, 100, 200, 200);
          let height = drawing.RectUtils.getHeight(rect);
          console.info(`${msg} - Step ${i}: getHeight success, height=${height}`);
          expect(height).assertEqual(100);
        } catch (e) {
          console.error(`${msg} - Step ${i} failed: getHeight error. Error code=${e.code}, Error message=${e.message}`);
          expect().assertFail(`${msg} - Multiple calls failed at step ${i}, error: ${e.message}`);
        }
      }
      console.info(`${msg} - All ${loopTimes} rounds of getHeight calls completed successfully, stability verified`);
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_GETHEIGHT_1400
     * @tc.name      : testGetHeight0014
     * @tc.desc      : Test for testRectUtilsGetHeightNull.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testGetHeight0014', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsGetHeight_Abnormal';

      try {
        drawing.RectUtils.getHeight(null);
        console.error(`${msg} - Input null: Expected error but no exception thrown`);
        expect().assertFail(`${msg} - Null input validation failed (no error)`);
      } catch (e) {
        console.info(`${msg} - Input null: Caught expected error. Code=${e.code}, Message=${e.message}`);
        expect(e.code).assertEqual(401, `${msg} - Null input error code mismatch (expected 401)`);
      }

      try {
        drawing.RectUtils.getHeight(undefined);
        console.error(`${msg} - Input undefined: Expected error but no exception thrown`);
        expect().assertFail(`${msg} - Undefined input validation failed (no error)`);
      } catch (e) {
        console.info(`${msg} - Input undefined: Caught expected error. Code=${e.code}, Message=${e.message}`);
        expect(e.code).assertEqual(401, `${msg} - Undefined input error code mismatch (expected 401)`);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_CENTERX_1500
     * @tc.name      : testCenterX0015
     * @tc.desc      : Test for testRectUtilsCenterXNormal.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testCenterX0015', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      let msg = 'testRectUtilsCenterX_Normal';
      let rect = drawing.RectUtils.makeEmpty()

      try {
        rect = drawing.RectUtils.makeEmpty();
        let x = drawing.RectUtils.centerX(rect);
        console.info(`${msg} - Empty rect: centerX=${x}`);
        expect(x).assertEqual(0);
      } catch (e) {
        console.error(`${msg} - Empty rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(100, 200, 200, 200);
        let x2 = drawing.RectUtils.centerX(rect);
        console.info(`${msg} - Integer rect: centerX=${x2}`);
        expect(x2).assertEqual(150);
      } catch (e) {
        console.error(`${msg} - Integer rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(100, 100, 100, 200);
        let x3 = drawing.RectUtils.centerX(rect);
        console.info(`${msg} - Equal L/R rect: centerX=${x3}`);
        expect(x3).assertEqual(100);
      } catch (e) {
        console.error(`${msg} - Equal L/R rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(0, 10.2632, 100.25474, 100.2884);
        let x4 = drawing.RectUtils.centerX(rect);
        console.info(`${msg} - Float rect: centerX=${x4}`);
        expect(x4).assertEqual(50.12737);
      } catch (e) {
        console.error(`${msg} - Float rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(-100, -100.98788, 100.20, 100);
        let x5 = drawing.RectUtils.centerX(rect);
        console.info(`${msg} - Negative rect: centerX=${x5}`);
        expect(x5).assertEqual(0.10000000000000142);
      } catch (e) {
        console.error(`${msg} - Negative rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(80000, 80000.25, 0, -20000);
        let x6 = drawing.RectUtils.centerX(rect);
        console.info(`${msg} - L>R rect: centerX=${x6}`);
        expect(x6).assertEqual(40000);
      } catch (e) {
        console.error(`${msg} - L>R rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = { left: 0, right: 100, top: 125, bottom: 225 };
        let x7 = drawing.RectUtils.centerX(rect);
        console.info(`${msg} - Custom rect: centerX=${x7}`);
        expect(x7).assertEqual(50);
      } catch (e) {
        console.error(`${msg} - Custom rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE + 1, Number.MAX_VALUE + 1);
        let x8 = drawing.RectUtils.centerX(rect);
        console.info(`${msg} - Max value rect: centerX=${x8}`);
      } catch (e) {
        console.error(`${msg} - Max value rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_CENTERX_1600
     * @tc.name      : testCenterX0016
     * @tc.desc      : Test for testRectUtilsCenterXMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testCenterX0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsCenterX_MultipleCalls';
      let loopTimes = 20;

      for (let i = 0; i < loopTimes; i++) {
        try {
          let rect = drawing.RectUtils.makeLtrb(100, 100, 200, 200);
          let x = drawing.RectUtils.centerX(rect);
          console.info(`${msg} - Step ${i}: centerX=${x}`);
          expect(x).assertEqual(150);
        } catch (e) {
          console.error(`${msg} - Step ${i} error: code=${e.code}, msg=${e.message}`);
          expect().assertFail(`${msg} - Failed at step ${i}`);
        }
      }
      console.info(`${msg} - All ${loopTimes} rounds completed successfully`);
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_CENTERX_1700
     * @tc.name      : testCenterX0017
     * @tc.desc      : Test for testRectUtilsCenterXAbnormal.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testCenterX0017', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsCenterX_Abnormal';

      try {
        drawing.RectUtils.centerX(null);
        console.error(`${msg} - Null input: No exception thrown (expected error)`);
        expect().assertFail();
      } catch (e) {
        console.info(`${msg} - Null input: code=${e.code}, msg=${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.RectUtils.centerX(undefined);
        console.error(`${msg} - Undefined input: No exception thrown (expected error)`);
        expect().assertFail();
      } catch (e) {
        console.info(`${msg} - Undefined input: code=${e.code}, msg=${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_CENTERY_1800
     * @tc.name      : testCenterY0018
     * @tc.desc      : Test for testRectUtilsCenterYNormal.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testCenterY0018', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      let msg = 'testRectUtilsCenterY_Normal';
      let rect = drawing.RectUtils.makeEmpty()

      try {
        rect = drawing.RectUtils.makeEmpty();
        let y = drawing.RectUtils.centerY(rect);
        console.info(`${msg} - Empty rect: centerY=${y}`);
        expect(y).assertEqual(0);
      } catch (e) {
        console.error(`${msg} - Empty rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(100, 200, 200, 200);
        let y2 = drawing.RectUtils.centerY(rect);
        console.info(`${msg} - Equal T/B rect: centerY=${y2}`);
        expect(y2).assertEqual(200);
      } catch (e) {
        console.error(`${msg} - Equal T/B rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(100, 100, 100, 200);
        let y3 = drawing.RectUtils.centerY(rect);
        console.info(`${msg} - Integer rect: centerY=${y3}`);
        expect(y3).assertEqual(150);
      } catch (e) {
        console.error(`${msg} - Integer rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(10, 10, 10, 10);
        let y4 = drawing.RectUtils.centerY(rect);
        console.info(`${msg} - Min rect: centerY=${y4}`);
        expect(y4).assertEqual(10);
      } catch (e) {
        console.error(`${msg} - Min rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(0, 10.2632, 100.25474, 100.2884);
        let y5 = drawing.RectUtils.centerY(rect);
        console.info(`${msg} - Float rect: centerY=${y5}`);
        expect(y5).assertEqual(55.2758);
      } catch (e) {
        console.error(`${msg} - Float rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(-100, -100.98788, 100.20, 100);
        let y6 = drawing.RectUtils.centerY(rect);
        console.info(`${msg} - Negative rect: centerY=${y6}`);
        expect(y6).assertEqual(-0.49394000000000204);
      } catch (e) {
        console.error(`${msg} - Negative rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(80000, 80000.25, 0, -20000);
        let y7 = drawing.RectUtils.centerY(rect);
        console.info(`${msg} - T>B rect: centerY=${y7}`);
        expect(y7).assertEqual(30000.125);
      } catch (e) {
        console.error(`${msg} - T>B rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = { left: 0, right: 100, top: 125, bottom: 225 };
        let y8 = drawing.RectUtils.centerY(rect);
        console.info(`${msg} - Custom rect: centerY=${y8}`);
        expect(y8).assertEqual(175);
      } catch (e) {
        console.error(`${msg} - Custom rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }

      try {
        rect = drawing.RectUtils.makeLtrb(Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE + 1, Number.MAX_VALUE + 1);
        let y9 = drawing.RectUtils.centerY(rect);
        console.info(`${msg} - Max value rect: centerY=${y9}`);
      } catch (e) {
        console.error(`${msg} - Max value rect error: code=${e.code}, msg=${e.message}`);
        expect().assertFail();
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_CENTERY_1900
     * @tc.name      : testCenterY0019
     * @tc.desc      : Test for testRectUtilsCenterYMultipleCalls.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testCenterY0019', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsCenterY_MultipleCalls';
      let loopTimes = 20;

      for (let i = 0; i < loopTimes; i++) {
        try {
          let rect = drawing.RectUtils.makeLtrb(100, 100, 200, 200);
          let y = drawing.RectUtils.centerY(rect);
          console.info(`${msg} - Step ${i}: centerY=${y}`);
          expect(y).assertEqual(150);
        } catch (e) {
          console.error(`${msg} - Step ${i} error: code=${e.code}, msg=${e.message}`);
          expect().assertFail(`${msg} - Failed at step ${i}`);
        }
      }
      console.info(`${msg} - All ${loopTimes} rounds completed successfully`);
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_CENTERY_2000
     * @tc.name      : testCenterY0020
     * @tc.desc      : Test for testRectUtilsCenterYAbnormal.
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testCenterY0020', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsCenterY_Abnormal';

      try {
        drawing.RectUtils.centerY(null);
        console.error(`${msg} - Null input: No exception thrown (expected error)`);
        expect().assertFail();
      } catch (e) {
        console.info(`${msg} - Null input: code=${e.code}, msg=${e.message}`);
        expect(e.code).assertEqual(401);
      }

      try {
        drawing.RectUtils.centerY(undefined);
        console.error(`${msg} - Undefined input: No exception thrown (expected error)`);
        expect().assertFail();
      } catch (e) {
        console.info(`${msg} - Undefined input: code=${e.code}, msg=${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_CONTAINS_2100
     * @tc.name      : testContains0021
     * @tc.desc      : Test for testRectUtilsContains1Normal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testContains0021', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let msg = 'testRectUtilsContains1Normal';
      let rect = drawing.RectUtils.makeEmpty();
      let rect2 = drawing.RectUtils.makeCopy(rect);
      try {
        let isContains = drawing.RectUtils.contains(rect2, rect);
        console.info(msg + ' RectUtils contains successed isContains: ' + isContains);
        expect(isContains).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = {
        left: 0,
        right: 0,
        top: 0,
        bottom: 0
      };
      rect = {
        left: 0,
        right: 0,
        top: 0,
        bottom: 0
      };
      try {
        let isContains2 = drawing.RectUtils.contains(rect2, rect);
        console.info(msg + ' RectUtils contains successed isContains2: ' + isContains2);
        expect(isContains2).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 20, 20, 20);
      rect2 = {
        left: 10,
        right: 20,
        top: 20,
        bottom: 20
      };
      try {
        let isContains3 = drawing.RectUtils.contains(rect2, rect);
        console.info(msg + ' RectUtils contains successed isContains3: ' + isContains3);
        expect(isContains3).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 20);
      try {
        let isContains4 = drawing.RectUtils.contains(rect2, rect);
        console.info(msg + ' RectUtils contains successed isContains4: ' + isContains4);
        expect(isContains4).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 10);
      rect2 = drawing.RectUtils.makeCopy(rect);
      try {
        let isContains5 = drawing.RectUtils.contains(rect2, rect);
        console.info(msg + ' RectUtils contains successed isContains5: ' + isContains5);
        expect(isContains5).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      try {
        let isContains6 = drawing.RectUtils.contains(rect, rect2);
        console.info(msg + ' RectUtils contains successed isContains6: ' + isContains6);
        expect(isContains6).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = {
        left: 0,
        right: 100,
        top: 0,
        bottom: 100
      };
      try {
        let isContains7 = drawing.RectUtils.contains(rect, rect2);
        console.info(msg + ' RectUtils contains successed isContains7: ' + isContains7);
        expect(isContains7).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = drawing.RectUtils.makeLtrb(0, 0, 20, 20);
      try {
        let isContains8 = drawing.RectUtils.contains(rect, rect2);
        console.info(msg + ' RectUtils contains successed isContains8: ' + isContains8);
        expect(isContains8).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = drawing.RectUtils.makeLtrb(20, 20, 80, 80);
      try {
        let isContains9 = drawing.RectUtils.contains(rect, rect2);
        console.info(msg + ' RectUtils contains successed isContains9: ' + isContains9);
        expect(isContains9).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains9 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = drawing.RectUtils.makeLtrb(-1, -1, 101, 101);
      try {
        let isContains10 = drawing.RectUtils.contains(rect, rect2);
        console.info(msg + ' RectUtils contains successed isContains10: ' + isContains10);
        expect(isContains10).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains10 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 10.2632, 100.25474, 100.2884);
      rect2 = drawing.RectUtils.makeCopy(rect);
      try {
        let isContains11 = drawing.RectUtils.contains(rect, rect2);
        console.info(msg + ' RectUtils contains successed isContains11: ' + isContains11);
        expect(isContains11).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains11 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = drawing.RectUtils.makeLtrb(0, 10, 100, 100.6884);
      try {
        let isContains12 = drawing.RectUtils.contains(rect, rect2);
        console.info(msg + ' RectUtils contains successed isContains12: ' + isContains12);
        expect(isContains12).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = {
        left: 0.9512,
        right: 100.1,
        top: 10.4632,
        bottom: 100.1
      };
      try {
        let isContains13 = drawing.RectUtils.contains(rect, rect2);
        console.info(msg + ' RectUtils contains successed isContains13: ' + isContains13);
        expect(isContains13).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains13 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(-100, -100.98788, 100.20, 100);
      rect2 = drawing.RectUtils.makeLtrb(-100, -100.98788, 100.20, 100);
      try {
        let isContains14 = drawing.RectUtils.contains(rect, rect2);
        console.info(msg + ' RectUtils contains successed isContains14: ' + isContains14);
        expect(isContains14).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains14 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = {
        left: -100.36,
        right: 100.3,
        top: -101,
        bottom: 100.1
      };
      try {
        let isContains15 = drawing.RectUtils.contains(rect, rect2);
        console.info(msg + ' RectUtils contains successed isContains15: ' + isContains15);
        expect(isContains15).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains15 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = {
        left: -100,
        right: 100,
        top: -99,
        bottom: 100
      };
      try {
        let isContains16 = drawing.RectUtils.contains(rect, rect2);
        console.info(msg + ' RectUtils contains successed isContains16: ' + isContains16);
        expect(isContains16).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains16 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(100, 100.25, -100, -100);
      rect2 = drawing.RectUtils.makeCopy(rect);
      try {
        let isContains17 = drawing.RectUtils.contains(rect, rect2);
        console.info(msg + ' RectUtils contains successed isContains17: ' + isContains17);
        expect(isContains17).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains17 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = {
        left: -100.5,
        right: 100.3,
        top: -100.5,
        bottom: 100.3
      };
      try {
        let isContains18 = drawing.RectUtils.contains(rect, rect2);
        console.info(msg + ' RectUtils contains successed isContains18: ' + isContains18);
        expect(isContains18).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains18 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = {
        left: 10,
        right: 100,
        top: 10,
        bottom: 100
      };
      try {
        let isContains19 = drawing.RectUtils.contains(rect, rect2);
        console.info(msg + ' RectUtils contains successed isContains19: ' + isContains19);
        expect(isContains19).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains19 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = {
        left: 90,
        right: -50,
        top: 90,
        bottom: -50
      };
      try {
        let isContains20 = drawing.RectUtils.contains(rect, rect2);
        console.info(msg + ' RectUtils contains successed isContains20: ' + isContains20);
        expect(isContains20).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains20 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = {
        left: Number.MAX_VALUE,
        right: Number.MAX_VALUE + 1,
        top: Number.MAX_VALUE,
        bottom: Number.MAX_VALUE + 1
      };
      try {
        let isContains21 = drawing.RectUtils.contains(rect, rect2);
        console.info(msg + ' RectUtils contains successed isContains21: ' + isContains21);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains21 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_CONTAINS_2200
     * @tc.name      : testContains0022
     * @tc.desc      : testRectUtilsContains1MultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testContains0022', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsContains1MultipleCalls';
      for (let i = 0; i < 20; i += 1) {
        try {
          let rect = drawing.RectUtils.makeLtrb(10, 10, 20, 20);
          let rect2 = drawing.RectUtils.makeLtrb(0, 0, 40, 40);
          let isContains = drawing.RectUtils.contains(rect2, rect);
          console.info(msg + `RectUtils.makeLtrb success step: ` + i);
          console.info(msg + ' RectUtils contains successed isContains: ' + isContains);
          expect(isContains).assertEqual(true);
        } catch (e) {
          console.info(msg +
            `RectUtils contains isContains error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_CONTAINS_2300
     * @tc.name      : testContains0023
     * @tc.desc      : testRectUtilsContains1Null
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testContains0023', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsContains1Null';
      let rect = drawing.RectUtils.makeLtrb(10, 10, 20, 20);
      let rect2 = drawing.RectUtils.makeLtrb(0, 0, 40, 40);
      try {
        let isContains = drawing.RectUtils.contains(null, rect);
        console.info(msg + `RectUtils contains isContains successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg +
          `RectUtils contains isContains failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let isContains2 = drawing.RectUtils.contains(undefined, rect);
        console.info(msg + `RectUtils contains isContains2 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg +
          `RectUtils contains isContains2 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let isContains3 = drawing.RectUtils.contains(rect2, null);
        console.info(msg + `RectUtils contains isContains3 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg +
          `RectUtils contains isContains3 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let isContains4 = drawing.RectUtils.contains(rect2, undefined);
        console.info(msg + `RectUtils contains isContains4 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg +
          `RectUtils contains isContains4 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_CONTAINS_2400
     * @tc.name      : testContains0024
     * @tc.desc      : Test for testRectUtilsContains2Normal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testContains0024', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let msg = 'testRectUtilsContains2Normal';
      let rect = drawing.RectUtils.makeEmpty();
      rect = {
        left: 0,
        right: 0,
        top: 0,
        bottom: 0
      };
      try {
        let isContains = drawing.RectUtils.contains(rect, 0, 0, 0, 0);
        console.info(msg + ' RectUtils contains successed isContains: ' + isContains);
        expect(isContains).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 20, 20, 20);
      try {
        let isContains2 = drawing.RectUtils.contains(rect, 10, 20, 20, 20);
        console.info(msg + ' RectUtils contains successed isContains2: ' + isContains2);
        expect(isContains2).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 20);
      try {
        let isContains3 = drawing.RectUtils.contains(rect, 10, 10, 10, 20);
        console.info(msg + ' RectUtils contains successed isContains3: ' + isContains3);
        expect(isContains3).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 10);
      try {
        let isContains4 = drawing.RectUtils.contains(rect, 10, 10, 10, 10);
        console.info(msg + ' RectUtils contains successed isContains4: ' + isContains4);
        expect(isContains4).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      try {
        let isContains5 = drawing.RectUtils.contains(rect, 10, 10, 10, 10);
        console.info(msg + ' RectUtils contains successed isContains5: ' + isContains5);
        expect(isContains5).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let isContains6 = drawing.RectUtils.contains(rect, 0, 0, 100, 100);
        console.info(msg + ' RectUtils contains successed isContains6: ' + isContains6);
        expect(isContains6).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let isContains7 = drawing.RectUtils.contains(rect, 0, 0, 20, 20);
        console.info(msg + ' RectUtils contains successed isContains7: ' + isContains7);
        expect(isContains7).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let isContains8 = drawing.RectUtils.contains(rect, 20, 20, 80, 80);
        console.info(msg + ' RectUtils contains successed isContains8: ' + isContains8);
        expect(isContains8).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let isContains9 = drawing.RectUtils.contains(rect, -1, -1, 101, 101);
        console.info(msg + ' RectUtils contains successed isContains9: ' + isContains9);
        expect(isContains9).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains9 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 10.2632, 100.25474, 100.2884);
      try {
        let isContains10 = drawing.RectUtils.contains(rect, 0, 10.2632, 100.25474, 100.2884);
        console.info(msg + ' RectUtils contains successed isContains10: ' + isContains10);
        expect(isContains10).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains10 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let isContains11 = drawing.RectUtils.contains(rect, 0, 10, 100, 100.6884);
        console.info(msg + ' RectUtils contains successed isContains11: ' + isContains11);
        expect(isContains11).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains11 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let isContains12 = drawing.RectUtils.contains(rect, 0.9512, 10.4632, 100.1, 100.1);
        console.info(msg + ' RectUtils contains successed isContains12: ' + isContains12);
        expect(isContains12).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(-100, -100.98788, 100.20, 100);
      try {
        let isContains13 = drawing.RectUtils.contains(rect, -100, -100.98788, 100.20, 100);
        console.info(msg + ' RectUtils contains successed isContains13: ' + isContains13);
        expect(isContains13).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains13 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let isContains14 = drawing.RectUtils.contains(rect, -100.36, -101, 100.3, 100.1);
        console.info(msg + ' RectUtils contains successed isContains14: ' + isContains14);
        expect(isContains14).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains14 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let isContains15 = drawing.RectUtils.contains(rect, -100, -99, 100, 100);
        console.info(msg + ' RectUtils contains successed isContains15: ' + isContains15);
        expect(isContains15).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains15 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(100, 100.25, -100, -100);
      try {
        let isContains16 = drawing.RectUtils.contains(rect, 100, 100.25, -100, -100);
        console.info(msg + ' RectUtils contains successed isContains16: ' + isContains16);
        expect(isContains16).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains16 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let isContains17 = drawing.RectUtils.contains(rect, -100.5, -100.5, 100.3, 100.3);
        console.info(msg + ' RectUtils contains successed isContains17: ' + isContains17);
        expect(isContains17).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains17 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let isContains18 = drawing.RectUtils.contains(rect, 10, 10, 100, 100);
        console.info(msg + ' RectUtils contains successed isContains18: ' + isContains18);
        expect(isContains18).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains18 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let isContains19 = drawing.RectUtils.contains(rect, 90, 90, -50, -50);
        console.info(msg + ' RectUtils contains successed isContains19: ' + isContains19);
        expect(isContains19).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains19 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = {
        left: Number.MAX_VALUE,
        right: Number.MAX_VALUE + 1,
        top: Number.MAX_VALUE,
        bottom: Number.MAX_VALUE + 1
      };
      try {
        let isContains20 =
          drawing.RectUtils.contains(rect, Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE + 1, Number.MAX_VALUE);
        console.info(msg + ' RectUtils contains successed isContains20: ' + isContains20);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains20 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_CONTAINS_2500
     * @tc.name      : testContains0025
     * @tc.desc      : testRectUtilsContains2MultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testContains0025', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsContains2MultipleCalls';
      for (let i = 0; i < 20; i += 1) {
        try {
          let rect2 = drawing.RectUtils.makeLtrb(0, 0, 40, 40);
          let isContains = drawing.RectUtils.contains(rect2, 10, 10, 20, 20);
          console.info(msg + `RectUtils.makeLtrb success step: ` + i);
          console.info(msg + ' RectUtils contains successed isContains: ' + isContains);
          expect(isContains).assertEqual(true);
        } catch (e) {
          console.info(msg +
            `RectUtils contains isContains error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_CONTAINS_2600
     * @tc.name      : testContains0026
     * @tc.desc      : testRectUtilsContains2Null
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 3
     */
    it('testContains0026', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsContains2Null';
      let rect = drawing.RectUtils.makeLtrb(10, 10, 20, 20);
      try {
        let isContains = drawing.RectUtils.contains(rect, null, 10, 20, 20);
        console.info(msg + `RectUtils contains isContains successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg +
          `RectUtils contains isContains failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let isContains2 = drawing.RectUtils.contains(rect, undefined, 10, 20, 20);
        console.info(msg + `RectUtils contains isContains2 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg +
          `RectUtils contains isContains2 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let isContains3 = drawing.RectUtils.contains(rect, 10, null, 20, 20);
        console.info(msg + `RectUtils contains isContains3 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg +
          `RectUtils contains isContains3 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let isContains4 = drawing.RectUtils.contains(rect, 10, undefined, 20, 20);
        console.info(msg + `RectUtils contains isContains4 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg +
          `RectUtils contains isContains4 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let isContains5 = drawing.RectUtils.contains(rect, 10, 10, null, 20);
        console.info(msg + `RectUtils contains isContains5 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg +
          `RectUtils contains isContains5 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let isContains6 = drawing.RectUtils.contains(rect, 10, 10, undefined, 20);
        console.info(msg + `RectUtils contains isContains6 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg +
          `RectUtils contains isContains6 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let isContains7 = drawing.RectUtils.contains(rect, 10, 10, 20, null);
        console.info(msg + `RectUtils contains isContains7 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg +
          `RectUtils contains isContains7 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let isContains8 = drawing.RectUtils.contains(rect, 10, 10, 20, undefined);
        console.info(msg + `RectUtils contains isContains8 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg +
          `RectUtils contains isContains8 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_CONTAINS_2700
     * @tc.name      : testContains0027
     * @tc.desc      : Test for testRectUtilsContains3Normal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testContains0027', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let msg = 'testRectUtilsContains3Normal';
      let rect = drawing.RectUtils.makeEmpty();
      rect = {
        left: 0,
        right: 0,
        top: 0,
        bottom: 0
      };
      try {
        let isContains = drawing.RectUtils.contains(rect, 0, 0);
        console.info(msg + ' RectUtils contains successed isContains: ' + isContains);
        expect(isContains).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 20, 20, 20);
      try {
        let isContains2 = drawing.RectUtils.contains(rect, 10, 20);
        console.info(msg + ' RectUtils contains successed isContains2: ' + isContains2);
        expect(isContains2).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 20);
      try {
        let isContains3 = drawing.RectUtils.contains(rect, 10, 15);
        console.info(msg + ' RectUtils contains successed isContains3: ' + isContains3);
        expect(isContains3).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 10);
      try {
        let isContains4 = drawing.RectUtils.contains(rect, 10, 10);
        console.info(msg + ' RectUtils contains successed isContains4: ' + isContains4);
        expect(isContains4).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      try {
        let isContains5 = drawing.RectUtils.contains(rect, 10, 10);
        console.info(msg + ' RectUtils contains successed isContains5: ' + isContains5);
        expect(isContains5).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let isContains6 = drawing.RectUtils.contains(rect, 0, 50);
        console.info(msg + ' RectUtils contains successed isContains6: ' + isContains6);
        expect(isContains6).assertEqual(true);
        let isContains01 = drawing.RectUtils.contains(rect, 50, 0);
        console.info(msg + ' RectUtils contains successed isContains01: ' + isContains01);
        expect(isContains01).assertEqual(true);
        let isContains02 = drawing.RectUtils.contains(rect, 50, 100);
        console.info(msg + ' RectUtils contains successed isContains02: ' + isContains02);
        expect(isContains02).assertEqual(false);
        let isContains03 = drawing.RectUtils.contains(rect, 100, 50);
        console.info(msg + ' RectUtils contains successed isContains03: ' + isContains03);
        expect(isContains03).assertEqual(false);
        let isContains04 = drawing.RectUtils.contains(rect, 0, 0);
        console.info(msg + ' RectUtils contains successed isContains04: ' + isContains04);
        expect(isContains04).assertEqual(true);
        let isContains05 = drawing.RectUtils.contains(rect, 100, 0);
        console.info(msg + ' RectUtils contains successed isContains05: ' + isContains05);
        expect(isContains05).assertEqual(false);
        let isContains06 = drawing.RectUtils.contains(rect, 0, 100);
        console.info(msg + ' RectUtils contains successed isContains06: ' + isContains06);
        expect(isContains06).assertEqual(false);
        let isContains07 = drawing.RectUtils.contains(rect, 100, 100);
        console.info(msg + ' RectUtils contains successed isContains07: ' + isContains07);
        expect(isContains07).assertEqual(false);
      } catch (e) {
        console.info(msg +
          ` RectUtils contains isContains6 together errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let isContains7 = drawing.RectUtils.contains(rect, -1, 0);
        console.info(msg + ' RectUtils contains successed isContains7: ' + isContains7);
        expect(isContains7).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let isContains8 = drawing.RectUtils.contains(rect, 100, 101);
        console.info(msg + ' RectUtils contains successed isContains8: ' + isContains8);
        expect(isContains8).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 10.2632, 100.25474, 100.2884);
      try {
        let isContains9 = drawing.RectUtils.contains(rect, 100.25474, 100.2884);
        console.info(msg + ' RectUtils contains successed isContains9: ' + isContains9);
        expect(isContains9).assertEqual(false);
        let isContains001 = drawing.RectUtils.contains(rect, 50, 10.2632);
        console.info(msg + ' RectUtils contains successed isContains001: ' + isContains001);
        expect(isContains001).assertEqual(true);
        let isContains002 = drawing.RectUtils.contains(rect, 50.2632, 50.2632);
        console.info(msg + ' RectUtils contains successed isContains002: ' + isContains002);
        expect(isContains002).assertEqual(true);
        let isContains003 = drawing.RectUtils.contains(rect, 100, 50);
        console.info(msg + ' RectUtils contains successed isContains003: ' + isContains003);
        expect(isContains003).assertEqual(true);
      } catch (e) {
        console.info(msg +
          ` RectUtils contains isContains9 together errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 10.2632, 100.25474, 100.2884);
      try {
        let isContains10 = drawing.RectUtils.contains(rect, 0, 0);
        console.info(msg + ' RectUtils contains successed isContains10: ' + isContains10);
        expect(isContains10).assertEqual(false);
        let isContains0001 = drawing.RectUtils.contains(rect, 0, 0);
        console.info(msg + ' RectUtils contains successed isContains0001: ' + isContains0001);
        expect(isContains0001).assertEqual(false);
      } catch (e) {
        console.info(msg +
          ` RectUtils contains isContains10 together errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(-100, -100.98788, 100.20, 100);
      try {
        let isContains11 = drawing.RectUtils.contains(rect, -100, -100.98788);
        console.info(msg + ' RectUtils contains successed isContains11: ' + isContains11);
        expect(isContains11).assertEqual(true);
        let isContains11_1 = drawing.RectUtils.contains(rect, 100.20, 100);
        console.info(msg + ' RectUtils contains successed isContains11_1: ' + isContains11_1);
        expect(isContains11_1).assertEqual(false);
        let isContains11_2 = drawing.RectUtils.contains(rect, 50, 50.55);
        console.info(msg + ' RectUtils contains successed isContains11_2: ' + isContains11_2);
        expect(isContains11_2).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains11 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let isContains12 = drawing.RectUtils.contains(rect, -100.33, -100.999999);
        console.info(msg + ' RectUtils contains successed isContains12: ' + isContains12);
        expect(isContains12).assertEqual(false);
        let isContains12_1 = drawing.RectUtils.contains(rect, 100.3, 100.1111);
        console.info(msg + ' RectUtils contains successed isContains12_1: ' + isContains12_1);
        expect(isContains12_1).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(100, 100.25, -100, -100);
      try {
        let isContains13 = drawing.RectUtils.contains(rect, 100, 100.25);
        console.info(msg + ' RectUtils contains successed isContains13: ' + isContains13);
        expect(isContains13).assertEqual(false);
        let isContains13_1 = drawing.RectUtils.contains(rect, -100, -100);
        console.info(msg + ' RectUtils contains successed isContains13_1: ' + isContains13_1);
        expect(isContains13_1).assertEqual(false);
        let isContains13_2 = drawing.RectUtils.contains(rect, -100, 50);
        console.info(msg + ' RectUtils contains successed isContains13_2: ' + isContains13_2);
        expect(isContains13_2).assertEqual(false);
        let isContains13_3 = drawing.RectUtils.contains(rect, 0, 0);
        console.info(msg + ' RectUtils contains successed isContains13_3: ' + isContains13_3);
        expect(isContains13_3).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains13 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        let isContains14 = drawing.RectUtils.contains(rect, 100.1, 100.1);
        console.info(msg + ' RectUtils contains successed isContains14: ' + isContains14);
        expect(isContains14).assertEqual(false);
        let isContains14_1 = drawing.RectUtils.contains(rect, 100.1, 100.1);
        console.info(msg + ' RectUtils contains successed isContains14_1: ' + isContains14_1);
        expect(isContains14_1).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains14 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = {
        left: Number.MAX_VALUE,
        right: Number.MAX_VALUE + 1,
        top: Number.MAX_VALUE,
        bottom: Number.MAX_VALUE + 1
      };
      try {
        let isContains15 = drawing.RectUtils.contains(rect, Number.MAX_VALUE, Number.MAX_VALUE);
        console.info(msg + ' RectUtils contains successed isContains15: ' + isContains15);
      } catch (e) {
        console.info(msg + ` RectUtils contains isContains15 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_CONTAINS_2800
     * @tc.name      : testContains0028
     * @tc.desc      : testRectUtilsContains3MultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testContains0028', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsContains3MultipleCalls';
      for (let i = 0; i < 20; i += 1) {
        try {
          let rect2 = drawing.RectUtils.makeLtrb(0, 0, 40, 40);
          let isContains = drawing.RectUtils.contains(rect2, 10, 10);
          console.info(msg + `RectUtils.makeLtrb success step: ` + i);
          console.info(msg + ' RectUtils contains successed isContains: ' + isContains);
          expect(isContains).assertEqual(true);
        } catch (e) {
          console.info(msg +
            `RectUtils contains isContains error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_CONTAINS_2900
     * @tc.name      : testContains0029
     * @tc.desc      : testRectUtilsContains3Null
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 4
     */
    it('testContains0029', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, () => {
      let msg = 'testRectUtilsContains3Null';
      let rect2 = drawing.RectUtils.makeLtrb(0, 0, 40, 40);
      try {
        let isContains = drawing.RectUtils.contains(null, 10, 10);
        console.info(msg + `RectUtils contains isContains successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg +
          `RectUtils contains isContains failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let isContains2 = drawing.RectUtils.contains(undefined, 10, 10);
        console.info(msg + `RectUtils contains isContains2 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg +
          `RectUtils contains isContains2 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let isContains3 = drawing.RectUtils.contains(rect2, null, 10);
        console.info(msg + `RectUtils contains isContains3 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg +
          `RectUtils contains isContains3 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let isContains4 = drawing.RectUtils.contains(rect2, undefined, 10);
        console.info(msg + `RectUtils contains isContains4 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg +
          `RectUtils contains isContains4 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let isContains5 = drawing.RectUtils.contains(rect2, 10, null);
        console.info(msg + `RectUtils contains isContains5 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg +
          `RectUtils contains isContains5 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let isContains6 = drawing.RectUtils.contains(rect2, 10, undefined);
        console.info(msg + `RectUtils contains isContains6 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg +
          `RectUtils contains isContains6 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_INSET_3000
     * @tc.name      : testInset0030
     * @tc.desc      : Test for testRectUtilsInsetNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testInsert0030', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let msg = 'testRectUtilsInsetNormal';
      let rect = drawing.RectUtils.makeEmpty();
      rect = {
        left: 0,
        right: 0,
        top: 0,
        bottom: 0
      };
      try {
        drawing.RectUtils.inset(rect, -10, -10, -10, -10);
        console.info(msg + ' RectUtils inset 1 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == -10 && rect.top == -10 && rect.right == 10 && rect.bottom == 10).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils inset 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeEmpty();
      try {
        drawing.RectUtils.inset(rect, 10, 10, 0, 20);
        console.info(msg + ' RectUtils inset 2 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 10 && rect.top == 10 && rect.right == 0 && rect.bottom == -20).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils inset 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        drawing.RectUtils.inset(rect, 5.244, 3.521, -30.17, 0);
        console.info(msg + ' RectUtils inset 3 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 15.244 && rect.top == 13.521 && rect.right == 30.17 && rect.bottom == -20)
          .assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils inset 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 20, 20, 20);
      try {
        drawing.RectUtils.inset(rect, -5, -1, -30.17, -15);
        console.info(msg + ' RectUtils inset 4 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 5 && rect.top == 19 && rect.right == 50.17 && rect.bottom == 35).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils inset 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        drawing.RectUtils.inset(rect, 10, 10.25, 1.25, 3.254);
        console.info(msg + ' RectUtils inset 5 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 15 && rect.top == 29.25 && rect.right == 48.92 && rect.bottom == 31.746).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils inset 5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 20);
      try {
        drawing.RectUtils.inset(rect, 5, 5, -5, 5);
        console.info(msg + ' RectUtils inset 6 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 15 && rect.top == 15 && rect.right == 15 && rect.bottom == 15).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils inset 6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        drawing.RectUtils.inset(rect, -6, -10, 5, -5);
        console.info(msg + ' RectUtils inset 7 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 9 && rect.top == 5 && rect.right == 10 && rect.bottom == 20).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils inset 7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 10);
      try {
        drawing.RectUtils.inset(rect, 30, 50, 5, 5);
        console.info(msg + ' RectUtils inset 8 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 40 && rect.top == 60 && rect.right == 5 && rect.bottom == 5).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils inset 8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        drawing.RectUtils.inset(rect, -10.26, 5.35, -30.255, -900000.22);
        console.info(msg + ' RectUtils inset 9 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 29.740000000000002 && rect.top == 65.35 && rect.right == 35.254999999999995 &&
          rect.bottom == 900005.22).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils inset 9 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      try {
        drawing.RectUtils.inset(rect, 0, 5.35, 30.255, 20.35);
        console.info(msg + ' RectUtils inset 10 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 5.35 && rect.right == 69.745 && rect.bottom == 79.65).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils inset 10 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        drawing.RectUtils.inset(rect, -6, -5.35, 10, 9.65);
        console.info(msg + ' RectUtils inset 11 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == -6 && rect.top == 0 && rect.right == 59.745000000000005 && rect.bottom == 70)
          .assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils inset 11 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 10.2632, 100.25474, 100.2884);
      try {
        drawing.RectUtils.inset(rect, -6, 1, 20.25474, 20);
        console.info(msg + ' RectUtils inset 12 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == -6 && rect.top == 11.2632 && rect.right == 80 && rect.bottom == 80.2884).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils inset 12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(-100, -100.98788, 100.20, 100);
      try {
        drawing.RectUtils.inset(rect, 10, 20, 30, 30.25);
        console.info(msg + ' RectUtils inset 13 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == -90 && rect.top == -80.98788 && rect.right == 70.2 && rect.bottom == 69.75)
          .assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils inset 13 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(100, 100.25, -100, -100);
      try {
        drawing.RectUtils.inset(rect, 300, 300, -400, -400.25);
        console.info(msg + ' RectUtils inset 14 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 400 && rect.top == 400.25 && rect.right == 300 && rect.bottom == 300.25).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils inset 14 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE + 1, Number.MAX_VALUE + 1);
      try {
        drawing.RectUtils.inset(rect, Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE + 1, Number.MAX_VALUE + 1);
        console.info(msg + ' RectUtils inset 15 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils inset 15 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_INSET_3100
     * @tc.name      : testInset0031
     * @tc.desc      : testRectUtilsInsetMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testInset0031', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsInsetMultipleCalls';
      let rect = drawing.RectUtils.makeLtrb(0, 0, 400, 400);
      for (let i = 0; i < 20; i += 1) {
        try {
          drawing.RectUtils.inset(rect, Math.random() * 100, Math.random() * 200, Math.random() * 100,
            Math.random() * 200);
          console.info(msg + `RectUtils.inset success step: ` + i);
          console.info(msg + ' RectUtils inset successed rect: ' + rect);
        } catch (e) {
          console.info(msg + `RectUtils inset error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_INSET_3200
     * @tc.name      : testInset0032
     * @tc.desc      : testRectUtilsInsetNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 4
     */
    it('testInset0032', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, () => {
      let msg = 'testRectUtilsInsetNull';
      let rect = drawing.RectUtils.makeLtrb(0, 0, 400, 400);
      try {
        drawing.RectUtils.inset(null, 10, 10, 20, 20);
        console.info(msg + `RectUtils inset 1 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils inset 1 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.inset(undefined, 10, 10, 20, 20);
        console.info(msg + `RectUtils inset 2 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils inset 2 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.inset(rect, null, 10, 20, 20);
        console.info(msg + `RectUtils inset 3 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils inset 3 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.inset(rect, undefined, 10, 20, 20);
        console.info(msg + `RectUtils inset 4 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils inset 4 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.inset(rect, 10, null, 20, 20);
        console.info(msg + `RectUtils inset 5 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils inset 5 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.inset(rect, 10, undefined, 20, 20);
        console.info(msg + `RectUtils inset 6 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils inset 6 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.inset(rect, 10, 10, null, 20);
        console.info(msg + `RectUtils inset 7 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils inset 7 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.inset(rect, 10, 10, undefined, 20);
        console.info(msg + `RectUtils inset 8 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils inset 8 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.inset(rect, 10, 10, 20, null);
        console.info(msg + `RectUtils inset 9 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils inset 9 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.inset(rect, 10, 10, 20, undefined);
        console.info(msg + `RectUtils inset 10 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils inset 10 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_INTERSECT_3300
     * @tc.name      : testIntersect0033
     * @tc.desc      : Test for testRectUtilsIntersectNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testIntersect0033', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let msg = 'testRectUtilsIntersectNormal';
      let rect = drawing.RectUtils.makeEmpty();
      let rect2 = drawing.RectUtils.makeCopy(rect);
      try {
        let isIntersect = drawing.RectUtils.intersect(rect, rect2);
        console.info(msg + ' RectUtils intersect 1 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 0 && rect.bottom == 0).assertEqual(true);
        expect(isIntersect).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils intersect 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = {
        left: 100,
        right: 100,
        top: 200,
        bottom: 200
      };
      rect = {
        left: 0,
        right: 0,
        top: 0,
        bottom: 0
      };
      try {
        let isIntersect2 = drawing.RectUtils.intersect(rect, rect2);
        console.info(msg + ' RectUtils intersect isIntersect2 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 0 && rect.bottom == 0).assertEqual(true);
        expect(isIntersect2).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils intersect isIntersect2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = {
        left: 100,
        right: 100,
        top: 200,
        bottom: 200
      };
      rect = {
        left: 0,
        right: 0,
        top: 0,
        bottom: 0
      };
      try {
        let isIntersect3 = drawing.RectUtils.intersect(rect, rect2);
        console.info(msg + ' RectUtils intersect isIntersect3 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 0 && rect.bottom == 0).assertEqual(true);
        expect(isIntersect3).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils intersect isIntersect3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 20, 20, 20);
      rect2 = {
        left: 15,
        right: 18,
        top: 20,
        bottom: 20
      };
      try {
        let isIntersect4 = drawing.RectUtils.intersect(rect, rect2);
        console.info(msg + ' RectUtils intersect isIntersect4 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 10 && rect.top == 20 && rect.right == 20 && rect.bottom == 20).assertEqual(true);
        expect(isIntersect4).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils intersect isIntersect4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 20);
      rect2 = drawing.RectUtils.makeLtrb(10, 0, 10, 15);
      try {
        let isIntersect5 = drawing.RectUtils.intersect(rect, rect2);
        console.info(msg + ' RectUtils intersect isIntersect5 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 10 && rect.top == 10 && rect.right == 10 && rect.bottom == 20).assertEqual(true);
        expect(isIntersect5).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils intersect isIntersect5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 10);
      rect2 = drawing.RectUtils.makeCopy(rect);
      try {
        let isIntersect6 = drawing.RectUtils.intersect(rect, rect2);
        console.info(msg + ' RectUtils intersect isIntersect6 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 10 && rect.top == 10 && rect.right == 10 && rect.bottom == 10).assertEqual(true);
        expect(isIntersect6).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils intersect isIntersect6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      try {
        let isIntersect7 = drawing.RectUtils.intersect(rect, rect2);
        console.info(msg + ' RectUtils intersect isIntersect7 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 100 && rect.bottom == 100).assertEqual(true);
        expect(isIntersect7).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils intersect isIntersect7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = {
        left: 0,
        right: 100,
        top: 0,
        bottom: 100
      };
      try {
        let isIntersect8 = drawing.RectUtils.intersect(rect, rect2);
        console.info(msg + ' RectUtils intersect isIntersect8 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 100 && rect.bottom == 100).assertEqual(true);
        expect(isIntersect8).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils intersect isIntersect8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = drawing.RectUtils.makeLtrb(10, 10, 20, 20);
      try {
        let isIntersect9 = drawing.RectUtils.intersect(rect, rect2);
        console.info(msg + ' RectUtils intersect isIntersect9 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 10 && rect.top == 10 && rect.right == 20 && rect.bottom == 20).assertEqual(true);
        expect(isIntersect9).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils intersect isIntersect9 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      rect2 = drawing.RectUtils.makeLtrb(0, 0, 90, 90);
      try {
        let isIntersect10 = drawing.RectUtils.intersect(rect, rect2);
        console.info(msg + ' RectUtils intersect isIntersect10 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 90 && rect.bottom == 90).assertEqual(true);
        expect(isIntersect10).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils intersect isIntersect10 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 60.365, 60.28);
      rect2 = drawing.RectUtils.makeLtrb(-1, -1, 101.36, 101.36);
      try {
        let isIntersect11 = drawing.RectUtils.intersect(rect, rect2);
        console.info(msg + ' RectUtils intersect isIntersect11 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 10 && rect.top == 10 && rect.right == 60.3650016784668 && rect.bottom == 60.279998779296875)
          .assertEqual(true);
        expect(isIntersect11).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils intersect isIntersect11 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 101.36, 101.36);
      try {
        let isIntersect12 = drawing.RectUtils.intersect(rect, rect2);
        console.info(msg + ' RectUtils intersect isIntersect12 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 101.36000061035156 && rect.bottom == 101.36000061035156)
          .assertEqual(true);
        expect(isIntersect12).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils intersect isIntersect12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      rect2 = drawing.RectUtils.makeLtrb(50, 50, 150, 150);
      try {
        let isIntersect13 = drawing.RectUtils.intersect(rect, rect2);
        console.info(msg + ' RectUtils intersect isIntersect13 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 50 && rect.top == 50 && rect.right == 100 && rect.bottom == 100).assertEqual(true);
        expect(isIntersect13).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils intersect isIntersect13 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(50, 50, 150, 150);
      rect2 = drawing.RectUtils.makeLtrb(0, 75, 200, 125);
      try {
        let isIntersect14 = drawing.RectUtils.intersect(rect, rect2);
        console.info(msg + ' RectUtils intersect isIntersect14 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 50 && rect.top == 75 && rect.right == 150 && rect.bottom == 125).assertEqual(true);
        expect(isIntersect14).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils intersect isIntersect14 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      rect2 = drawing.RectUtils.makeLtrb(100, 50, 200, 150);
      try {
        let isIntersect15 = drawing.RectUtils.intersect(rect, rect2);
        console.info(msg + ' RectUtils intersect isIntersect15 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 100 && rect.bottom == 100).assertEqual(true);
        expect(isIntersect15).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils intersect isIntersect15 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = drawing.RectUtils.makeLtrb(100, 100, 200, 200);
      try {
        let isIntersect16 = drawing.RectUtils.intersect(rect, rect2);
        console.info(msg + ' RectUtils intersect isIntersect16 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 100 && rect.bottom == 100).assertEqual(true);
        expect(isIntersect16).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils intersect isIntersect16 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = drawing.RectUtils.makeLtrb(200, 200, 300, 300);
      try {
        let isIntersect17 = drawing.RectUtils.intersect(rect, rect2);
        console.info(msg + ' RectUtils intersect isIntersect17 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 100 && rect.bottom == 100).assertEqual(true);
        expect(isIntersect17).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils intersect isIntersect17 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 10.2632, 100.25474, 100.2884);
      rect2 = drawing.RectUtils.makeLtrb(0, 10, 100, 100.6884);
      try {
        let isIntersect18 = drawing.RectUtils.intersect(rect, rect2);
        console.info(msg + ' RectUtils intersect isIntersect18 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 10.263199806213379 && rect.right == 100 &&
          rect.bottom == 100.28839874267578).assertEqual(true);
        expect(isIntersect18).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils intersect isIntersect18 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE + 1, Number.MAX_VALUE + 1);
      rect2 =
        drawing.RectUtils.makeLtrb(Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE + 1, Number.MAX_VALUE + 1);
      try {
        let isIntersect19 = drawing.RectUtils.intersect(rect, rect2);
        console.info(msg + ' RectUtils intersect isIntersect19 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils intersect isIntersect19 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_INTERSECT_3400
     * @tc.name      : testIntersect0034
     * @tc.desc      : testRectUtilsIntersectMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testIntersect0034', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsIntersectMultipleCalls';
      let rect = drawing.RectUtils.makeLtrb(10, 10, 20, 20);
      let rect2 = drawing.RectUtils.makeLtrb(0, 0, 40, 40);
      for (let i = 0; i < 20; i += 1) {
        try {
          let isIntersect = drawing.RectUtils.intersect(rect, rect2);
          console.info(msg + `RectUtils.intersect success step: ` + i);
          expect(isIntersect).assertEqual(true);
        } catch (e) {
          console.info(msg +
            `RectUtils intersect error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_INTERSECT_3500
     * @tc.name      : testIntersect0035
     * @tc.desc      : testRectUtilsIntersectNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 4
     */
    it('testIntersect0035', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, () => {
      let msg = 'testRectUtilsIntersectNull';
      let rect = drawing.RectUtils.makeLtrb(10, 10, 20, 20);
      let rect2 = drawing.RectUtils.makeLtrb(0, 0, 40, 40);
      try {
        let isIntersect = drawing.RectUtils.intersect(null, rect2);
        console.info(msg + `RectUtils intersect 1 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils intersect 1 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.intersect(undefined, rect2);
        console.info(msg + `RectUtils intersect 2 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils intersect 2 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.intersect(rect, null);
        console.info(msg + `RectUtils intersect 3 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils intersect 3 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.intersect(rect, undefined);
        console.info(msg + `RectUtils intersect 4 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils intersect 4 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_ISINTERSECT_3600
     * @tc.name      : testIsIntersect0036
     * @tc.desc      : Test for testRectUtilsIsIntersectNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testIsIntersect0036', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let msg = 'testRectUtilsIsIntersectNormal';
      let rect = drawing.RectUtils.makeEmpty();
      let rect2 = drawing.RectUtils.makeCopy(rect);
      try {
        let isIntersect = drawing.RectUtils.isIntersect(rect, rect2);
        console.info(msg + ' RectUtils isIntersect 1 successed rect: ' + JSON.stringify(rect));
        expect(isIntersect).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils isIntersect 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = {
        left: 100,
        right: 100,
        top: 200,
        bottom: 200
      };
      rect = {
        left: 0,
        right: 0,
        top: 0,
        bottom: 0
      };
      try {
        let isIntersect2 = drawing.RectUtils.isIntersect(rect, rect2);
        console.info(msg + ' RectUtils isIntersect isIntersect2 successed rect: ' + JSON.stringify(rect));
        expect(isIntersect2).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils isIntersect isIntersect2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = {
        left: 100,
        right: 100,
        top: 200,
        bottom: 200
      };
      rect = {
        left: 0,
        right: 0,
        top: 0,
        bottom: 0
      };
      try {
        let isIntersect3 = drawing.RectUtils.isIntersect(rect, rect2);
        console.info(msg + ' RectUtils isIntersect isIntersect3 successed rect: ' + JSON.stringify(rect));
        expect(isIntersect3).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils isIntersect isIntersect3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 20, 20, 20);
      rect2 = {
        left: 15,
        right: 18,
        top: 20,
        bottom: 20
      };
      try {
        let isIntersect4 = drawing.RectUtils.isIntersect(rect, rect2);
        console.info(msg + ' RectUtils isIntersect isIntersect4 successed rect: ' + JSON.stringify(rect));
        expect(isIntersect4).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils isIntersect isIntersect4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 20);
      rect2 = drawing.RectUtils.makeLtrb(10, 0, 10, 15);
      try {
        let isIntersect5 = drawing.RectUtils.isIntersect(rect, rect2);
        console.info(msg + ' RectUtils isIntersect isIntersect5 successed rect: ' + JSON.stringify(rect));
        expect(isIntersect5).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils isIntersect isIntersect5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 10);
      rect2 = drawing.RectUtils.makeCopy(rect);
      try {
        let isIntersect6 = drawing.RectUtils.isIntersect(rect, rect2);
        console.info(msg + ' RectUtils isIntersect isIntersect6 successed rect: ' + JSON.stringify(rect));
        expect(isIntersect6).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils isIntersect isIntersect6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      try {
        let isIntersect7 = drawing.RectUtils.isIntersect(rect, rect2);
        console.info(msg + ' RectUtils isIntersect isIntersect7 successed rect: ' + JSON.stringify(rect));
        expect(isIntersect7).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils isIntersect isIntersect7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = {
        left: 0,
        right: 100,
        top: 0,
        bottom: 100
      };
      try {
        let isIntersect8 = drawing.RectUtils.isIntersect(rect, rect2);
        console.info(msg + ' RectUtils isIntersect isIntersect8 successed rect: ' + JSON.stringify(rect));
        expect(isIntersect8).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils isIntersect isIntersect8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = drawing.RectUtils.makeLtrb(10, 10, 20, 20);
      try {
        let isIntersect9 = drawing.RectUtils.isIntersect(rect, rect2);
        console.info(msg + ' RectUtils isIntersect isIntersect9 successed rect: ' + JSON.stringify(rect));
        expect(isIntersect9).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils isIntersect isIntersect9 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      rect2 = drawing.RectUtils.makeLtrb(0, 0, 90, 90);
      try {
        let isIntersect10 = drawing.RectUtils.isIntersect(rect, rect2);
        console.info(msg + ' RectUtils isIntersect isIntersect10 successed rect: ' + JSON.stringify(rect));
        expect(isIntersect10).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils isIntersect isIntersect10 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 60.365, 60.28);
      rect2 = drawing.RectUtils.makeLtrb(-1, -1, 101.36, 101.36);
      try {
        let isIntersect11 = drawing.RectUtils.isIntersect(rect, rect2);
        console.info(msg + ' RectUtils isIntersect isIntersect11 successed rect: ' + JSON.stringify(rect));
        expect(isIntersect11).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils isIntersect isIntersect11 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 101.36, 101.36);
      try {
        let isIntersect12 = drawing.RectUtils.isIntersect(rect, rect2);
        console.info(msg + ' RectUtils isIntersect isIntersect12 successed rect: ' + JSON.stringify(rect));
        expect(isIntersect12).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils isIntersect isIntersect12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      rect2 = drawing.RectUtils.makeLtrb(50, 50, 150, 150);
      try {
        let isIntersect13 = drawing.RectUtils.isIntersect(rect, rect2);
        console.info(msg + ' RectUtils isIntersect isIntersect13 successed rect: ' + JSON.stringify(rect));
        expect(isIntersect13).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils isIntersect isIntersect13 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(50, 50, 150, 150);
      rect2 = drawing.RectUtils.makeLtrb(0, 75, 200, 125);
      try {
        let isIntersect14 = drawing.RectUtils.isIntersect(rect, rect2);
        console.info(msg + ' RectUtils isIntersect isIntersect14 successed rect: ' + JSON.stringify(rect));
        expect(isIntersect14).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils isIntersect isIntersect14 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      rect2 = drawing.RectUtils.makeLtrb(100, 50, 200, 150);
      try {
        let isIntersect15 = drawing.RectUtils.isIntersect(rect, rect2);
        console.info(msg + ' RectUtils isIntersect isIntersect15 successed rect: ' + JSON.stringify(rect));
        expect(isIntersect15).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils isIntersect isIntersect15 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = drawing.RectUtils.makeLtrb(100, 100, 200, 200);
      try {
        let isIntersect16 = drawing.RectUtils.isIntersect(rect, rect2);
        console.info(msg + ' RectUtils isIntersect isIntersect16 successed rect: ' + JSON.stringify(rect));
        expect(isIntersect16).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils isIntersect isIntersect16 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = drawing.RectUtils.makeLtrb(200, 200, 300, 300);
      try {
        let isIntersect17 = drawing.RectUtils.isIntersect(rect, rect2);
        console.info(msg + ' RectUtils isIntersect isIntersect17 successed rect: ' + JSON.stringify(rect));
        expect(isIntersect17).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils isIntersect isIntersect17 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 10.2632, 100.25474, 100.2884);
      rect2 = drawing.RectUtils.makeLtrb(0, 10, 100, 100.6884);
      try {
        let isIntersect18 = drawing.RectUtils.isIntersect(rect, rect2);
        console.info(msg + ' RectUtils isIntersect isIntersect18 successed rect: ' + JSON.stringify(rect));
        expect(isIntersect18).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils isIntersect isIntersect18 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE + 1, Number.MAX_VALUE + 1);
      rect2 =
        drawing.RectUtils.makeLtrb(Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE + 1, Number.MAX_VALUE + 1);
      try {
        let isIntersect19 = drawing.RectUtils.isIntersect(rect, rect2);
        console.info(msg + ' RectUtils isIntersect isIntersect19 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils isIntersect isIntersect19 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_ISINTERSECT_3700
     * @tc.name      : testIsIntersect0037
     * @tc.desc      : testRectUtilsIsIntersectMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testIsIntersect0037', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsIsIntersectMultipleCalls';
      let rect = drawing.RectUtils.makeLtrb(10, 10, 20, 20);
      let rect2 = drawing.RectUtils.makeLtrb(0, 0, 40, 40);
      for (let i = 0; i < 20; i += 1) {
        try {
          let isIntersect = drawing.RectUtils.isIntersect(rect, rect2);
          console.info(msg + `RectUtils.isIntersect success step: ` + i);
          expect(isIntersect).assertEqual(true);
        } catch (e) {
          console.info(msg +
            `RectUtils isIntersect error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_ISINTERSECT_3800
     * @tc.name      : testIsIntersect0038
     * @tc.desc      : testRectUtilsIsIntersectNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 4
     */
    it('testIsIntersect0038', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, () => {
      let msg = 'testRectUtilsIsIntersectNull';
      let rect = drawing.RectUtils.makeLtrb(10, 10, 20, 20);
      let rect2 = drawing.RectUtils.makeLtrb(0, 0, 40, 40);
      try {
        let isIntersect = drawing.RectUtils.isIntersect(null, rect2);
        console.info(msg + `RectUtils isIntersect 1 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils isIntersect 1 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.isIntersect(undefined, rect2);
        console.info(msg + `RectUtils isIntersect 2 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils isIntersect 2 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.isIntersect(rect, null);
        console.info(msg + `RectUtils isIntersect 3 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils isIntersect 3 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.isIntersect(rect, undefined);
        console.info(msg + `RectUtils isIntersect 4 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils isIntersect 4 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_UNION_3900
     * @tc.name      : testUnion0039
     * @tc.desc      : Test for testRectUtilsUnionNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testUnion0039', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let msg = 'testRectUtilsUnionNormal';
      let rect = drawing.RectUtils.makeEmpty();
      let rect2 = drawing.RectUtils.makeEmpty();
      rect2 = {
        left: 100,
        right: 200,
        top: 100,
        bottom: 200
      };
      try {
        drawing.RectUtils.union(rect, rect2);
        console.info(msg + ' RectUtils union 1 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 100 && rect.top == 100 && rect.right == 200 && rect.bottom == 200).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils union 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = {
        left: 100,
        right: 100,
        top: 200,
        bottom: 200
      };
      rect = {
        left: 0,
        right: 0,
        top: 0,
        bottom: 0
      };
      try {
        drawing.RectUtils.union(rect, rect2);
        console.info(msg + ' RectUtils union 2 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 0 && rect.bottom == 0).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils union 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 20, 20, 20);
      rect2 = {
        left: 15,
        right: 18,
        top: 20,
        bottom: 20
      };
      try {
        drawing.RectUtils.union(rect, rect2);
        console.info(msg + ' RectUtils union 3 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 10 && rect.top == 20 && rect.right == 20 && rect.bottom == 20).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils union 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 20);
      rect2 = drawing.RectUtils.makeLtrb(10, 0, 10, 15);
      try {
        drawing.RectUtils.union(rect, rect2);
        console.info(msg + ' RectUtils union 4 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 10 && rect.top == 10 && rect.right == 10 && rect.bottom == 20).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils union 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 10);
      rect2 = drawing.RectUtils.makeCopy(rect);
      try {
        drawing.RectUtils.union(rect, rect2);
        console.info(msg + ' RectUtils union 5 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 10 && rect.top == 10 && rect.right == 10 && rect.bottom == 10).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils union 5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      try {
        drawing.RectUtils.union(rect, rect2);
        console.info(msg + ' RectUtils union 6 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 100 && rect.bottom == 100).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils union 6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = {
        left: 0,
        right: 100,
        top: 0,
        bottom: 100
      };
      try {
        drawing.RectUtils.union(rect, rect2);
        console.info(msg + ' RectUtils union 7 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 100 && rect.bottom == 100).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils union 7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = drawing.RectUtils.makeLtrb(10, 10, 20, 20);
      try {
        drawing.RectUtils.union(rect, rect2);
        console.info(msg + ' RectUtils union 8 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 100 && rect.bottom == 100).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils union 8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      rect2 = drawing.RectUtils.makeLtrb(0, 0, 90, 90);
      try {
        drawing.RectUtils.union(rect, rect2);
        console.info(msg + ' RectUtils union 9 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 100 && rect.bottom == 100).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils union 9 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 60.365, 60.28);
      rect2 = drawing.RectUtils.makeLtrb(-1, -1, 101.36, 101.36);
      try {
        drawing.RectUtils.union(rect, rect2);
        console.info(msg + ' RectUtils union 10 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == -1 && rect.top == -1 && rect.right == 101.36000061035156 &&
          rect.bottom == 101.36000061035156).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils union 10 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 101.36, 101.36);
      try {
        drawing.RectUtils.union(rect, rect2);
        console.info(msg + ' RectUtils union 11 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == -1 && rect.top == -1 && rect.right == 101.36000061035156 &&
          rect.bottom == 101.36000061035156).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils union 11 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      rect2 = drawing.RectUtils.makeLtrb(50, 50, 150, 150);
      try {
        drawing.RectUtils.union(rect, rect2);
        console.info(msg + ' RectUtils union 12 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 150 && rect.bottom == 150).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils union 12 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(50, 50, 150, 150);
      rect2 = drawing.RectUtils.makeLtrb(0, 75, 200, 125);
      try {
        drawing.RectUtils.union(rect, rect2);
        console.info(msg + ' RectUtils union 13 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 50 && rect.right == 200 && rect.bottom == 150).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils union 13 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      rect2 = drawing.RectUtils.makeLtrb(100, 50, 200, 150);
      try {
        drawing.RectUtils.union(rect, rect2);
        console.info(msg + ' RectUtils union 14 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 200 && rect.bottom == 150).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils union 14 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      rect2 = drawing.RectUtils.makeLtrb(100, 50, 200, 75);
      try {
        drawing.RectUtils.union(rect, rect2);
        console.info(msg + ' RectUtils union 15 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 200 && rect.bottom == 100).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils union 15 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      rect2 = drawing.RectUtils.makeLtrb(100, 100, 200, 200);
      try {
        drawing.RectUtils.union(rect, rect2);
        console.info(msg + ' RectUtils union 16 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 200 && rect.bottom == 200).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils union 16 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      rect2 = drawing.RectUtils.makeLtrb(200, 200, 300, 300);
      try {
        drawing.RectUtils.union(rect, rect2);
        console.info(msg + ' RectUtils union 17 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 300 && rect.bottom == 300).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils union 17 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 10.2632, 100.25474, 100.2884);
      rect2 = drawing.RectUtils.makeLtrb(0, 10, 100, 100.6884);
      try {
        drawing.RectUtils.union(rect, rect2);
        console.info(msg + ' RectUtils union 18 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 10 && rect.right == 100.2547378540039 && rect.bottom == 100.68840026855469)
          .assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils union 18 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 10.2632, 100.25474, 100.2884);
      rect2 = {
        left: 0.9512,
        right: 100.1,
        top: 10.4632,
        bottom: 100.1
      };
      try {
        drawing.RectUtils.union(rect, rect2);
        console.info(msg + ' RectUtils union 19 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 10.263199806213379 && rect.right == 100.2547378540039 &&
          rect.bottom == 100.28839874267578).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils union 19 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(-100, -100.98788, 100.20, 100);
      rect2 = drawing.RectUtils.makeLtrb(-100, -100.98788, 100.20, 100);
      try {
        drawing.RectUtils.union(rect, rect2);
        console.info(msg + ' RectUtils union 20 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == -100 && rect.top == -100.98787689208984 && rect.right == 100.19999694824219 &&
          rect.bottom == 100).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils union 20 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE + 1, Number.MAX_VALUE + 1);
      rect2 =
        drawing.RectUtils.makeLtrb(Number.MAX_VALUE, Number.MAX_VALUE, Number.MAX_VALUE + 1, Number.MAX_VALUE + 1);
      try {
        drawing.RectUtils.union(rect, rect2);
        console.info(msg + ' RectUtils union 21 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils union 21 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_UNION_4000
     * @tc.name      : testUnion0040
     * @tc.desc      : testRectUtilsUnionMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testUnion0040', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsUnionMultipleCalls';
      let rect = drawing.RectUtils.makeLtrb(10, 10, 20, 20);
      let rect2 = drawing.RectUtils.makeLtrb(0, 0, 40, 40);
      for (let i = 0; i < 20; i += 1) {
        try {
          let isIntersect = drawing.RectUtils.union(rect, rect2);
          console.info(msg + `RectUtils.union success step: ` + i);
        } catch (e) {
          console.info(msg + `RectUtils union error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_UNION_4100
     * @tc.name      : testUnion0041
     * @tc.desc      : testRectUtilsUnionNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 4
     */
    it('testUnion0041', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, () => {
      let msg = 'testRectUtilsUnionNull';
      let rect = drawing.RectUtils.makeLtrb(10, 10, 20, 20);
      let rect2 = drawing.RectUtils.makeLtrb(0, 0, 40, 40);
      try {
        drawing.RectUtils.union(null, rect2);
        console.info(msg + `RectUtils union 1 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils union 1 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.union(undefined, rect2);
        console.info(msg + `RectUtils union 2 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils union 2 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.union(rect, null);
        console.info(msg + `RectUtils union 3 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils union 3 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.union(rect, undefined);
        console.info(msg + `RectUtils union 4 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils union 4 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_ISEMPTY_4200
     * @tc.name      : testIsEmpty0042
     * @tc.desc      : Test for testRectUtilsIsEmptyNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testIsEmpty0042', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let msg = 'testRectUtilsIsEmptyNormal';
      let rect = drawing.RectUtils.makeEmpty();
      try {
        let isEmpty = drawing.RectUtils.isEmpty(rect);
        console.info(msg + ' RectUtils isEmpty isEmpty successed');
        expect(isEmpty).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils isEmpty isEmpty errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 20, 20, 20);
      try {
        let isEmpty2 = drawing.RectUtils.isEmpty(rect);
        console.info(msg + ' RectUtils isEmpty isEmpty2 successed');
        expect(isEmpty2).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils isEmpty isEmpty2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 20);
      try {
        let isEmpty3 = drawing.RectUtils.isEmpty(rect);
        console.info(msg + ' RectUtils isEmpty isEmpty3 successed');
        expect(isEmpty3).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils isEmpty isEmpty3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 10);
      try {
        let isEmpty4 = drawing.RectUtils.isEmpty(rect);
        console.info(msg + ' RectUtils isEmpty isEmpty4 successed');
        expect(isEmpty4).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils isEmpty isEmpty4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      try {
        let isEmpty5 = drawing.RectUtils.isEmpty(rect);
        console.info(msg + ' RectUtils isEmpty isEmpty5 successed');
        expect(isEmpty5).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils isEmpty isEmpty5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0,10.2632,100.25474,100.2884);
      try {
        let isEmpty6 = drawing.RectUtils.isEmpty(rect);
        console.info(msg + ' RectUtils isEmpty isEmpty6 successed');
        expect(isEmpty6).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils isEmpty isEmpty6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(-100,-100.98788,-50,-50);
      try {
        let isEmpty7 = drawing.RectUtils.isEmpty(rect);
        console.info(msg + ' RectUtils isEmpty isEmpty7 successed');
        expect(isEmpty7).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils isEmpty isEmpty7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(100,100.25,-100,-100.255);
      try {
        let isEmpty8 = drawing.RectUtils.isEmpty(rect);
        console.info(msg + ' RectUtils isEmpty isEmpty8 successed');
        expect(isEmpty8).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils isEmpty isEmpty8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_ISEMPTY_4300
     * @tc.name      : testIsEmpty0043
     * @tc.desc      : testRectUtilsIsEmptyMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testIsEmpty0043', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsIsEmptyMultipleCalls';
      let rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      for (let i = 0; i < 20; i += 1) {
        try {
          let isEmpty = drawing.RectUtils.isEmpty(rect);
          console.info(msg + `RectUtils.isEmpty success step: ` + i);
          expect(isEmpty).assertEqual(false);
        } catch (e) {
          console.info(msg + `RectUtils isEmpty error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_ISEMPTY_4400
     * @tc.name      : testIsEmpty0044
     * @tc.desc      : testRectUtilsIsEmptyNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 4
     */
    it('testIsEmpty0044', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, () => {
      let msg = 'testRectUtilsIsEmptyNull';
      let rect = drawing.RectUtils.makeEmpty();
      try {
        let isEmpty = drawing.RectUtils.isEmpty(null);
        console.info(msg + `RectUtils isEmpty 1 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils isEmpty 1 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        let isEmpty2 = drawing.RectUtils.isEmpty(undefined);
        console.info(msg + `RectUtils isEmpty 2 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils isEmpty 2 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_OFFSET_4500
     * @tc.name      : testOffset0045
     * @tc.desc      : Test for testRectUtilsOffsetNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testOffset0045', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let msg = 'testRectUtilsOffsetNormal';
      let rect = drawing.RectUtils.makeEmpty();
      try {
        drawing.RectUtils.offset(rect, 10, 20);
        console.info(msg + ' RectUtils offset 1 successed');
        console.info(msg + ' RectUtils offset 1 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 10 && rect.top == 20 && rect.right == 10 && rect.bottom == 20).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils offset 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 20, 20, 20);
      try {
        drawing.RectUtils.offset(rect, 10.1, 20.2);
        console.info(msg + ' RectUtils offset 2 successed');
        console.info(msg + ' RectUtils offset 2 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 20.100000381469727 && rect.top == 40.20000076293945 && rect.right == 30.100000381469727 && rect.bottom == 40.20000076293945).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils offset 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 20);
      try {
        drawing.RectUtils.offset(rect, -5, -5.1);
        console.info(msg + ' RectUtils offset 3 successed');
        console.info(msg + ' RectUtils offset 3 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 5 && rect.top == 4.900000095367432 && rect.right == 5 && rect.bottom == 14.899999618530273).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils offset 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 10);
      try {
        drawing.RectUtils.offset(rect, 0, 5.1);
        console.info(msg + ' RectUtils offset 4 successed');
        console.info(msg + ' RectUtils offset 4 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 10 && rect.top == 15.100000381469727 && rect.right == 10 && rect.bottom == 15.100000381469727).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils offset 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      try {
        drawing.RectUtils.offset(rect, 10, 0);
        console.info(msg + ' RectUtils offset 5 successed');
        console.info(msg + ' RectUtils offset 5 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 10 && rect.top == 0 && rect.right == 110 && rect.bottom == 100).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils offset 5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0,10.2632,100.25474,100.2884);
      try {
        drawing.RectUtils.offset(rect, 5.256, -2.552);
        console.info(msg + ' RectUtils offset 6 successed');
        console.info(msg + ' RectUtils offset 6 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 5.25600004196167 && rect.top == 7.711199760437012 && rect.right == 105.51073455810547 && rect.bottom == 97.73639678955078).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils offset 6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(-100,-100.98788,300.20,300);
      try {
        drawing.RectUtils.offset(rect, 10, 5);
        console.info(msg + ' RectUtils offset 7 successed');
        console.info(msg + ' RectUtils offset 7 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == -90 && rect.top == -95.98787689208984 && rect.right == 310.20001220703125 && rect.bottom == 305).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils offset 7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(100,100.25,-100,-100);
      try {
        drawing.RectUtils.offset(rect, -100000, 100000);
        console.info(msg + ' RectUtils offset 8 successed');
        console.info(msg + ' RectUtils offset 8 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == -99900 && rect.top == 100100.25 && rect.right == -100100 && rect.bottom == 99900).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils offset 8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(Number.MAX_VALUE,Number.MAX_VALUE,Number.MAX_VALUE+1,Number.MAX_VALUE+1);
      try {
        drawing.RectUtils.offset(rect, Number.MAX_VALUE, Number.MAX_VALUE);
        console.info(msg + ' RectUtils offset 9 successed');
        console.info(msg + ' RectUtils offset 9 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils offset 9 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_OFFSET_4600
     * @tc.name      : testOffset0046
     * @tc.desc      : testRectUtilsOffsetMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testOffset0046', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsOffsetMultipleCalls';
      let rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      for (let i = 0; i < 20; i += 1) {
        try {
          drawing.RectUtils.offset(rect, Math.random() *100, Math.random() *20);
          console.info(msg + `RectUtils.offset success step: ` + i);
        } catch (e) {
          console.info(msg + `RectUtils offset error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_OFFSET_4700
     * @tc.name      : testOffset0047
     * @tc.desc      : testRectUtilsOffsetNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 4
     */
    it('testOffset0047', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, () => {
      let msg = 'testRectUtilsOffsetNull';
      let rect = drawing.RectUtils.makeEmpty();
      try {
        drawing.RectUtils.offset(null, 10, 20);
        console.info(msg + `RectUtils offset 1 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils offset 1 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.offset(undefined, 10, 20);
        console.info(msg + `RectUtils offset 2 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils offset 2 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.offset(rect, null, 20);
        console.info(msg + `RectUtils offset 3 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils offset 3 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.offset(rect, undefined, 20);
        console.info(msg + `RectUtils offset 4 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils offset 4 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.offset(rect, 10, null);
        console.info(msg + `RectUtils offset 5 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils offset 5 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.offset(rect, 10, undefined);
        console.info(msg + `RectUtils offset 6 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils offset 6 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_OFFSETTO_4800
     * @tc.name      : testOffsetTo0048
     * @tc.desc      : Test for testRectUtilsOffsetToNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testOffsetTo0048', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let msg = 'testRectUtilsOffsetToNormal';
      let rect = drawing.RectUtils.makeEmpty();
      try {
        drawing.RectUtils.offsetTo(rect, 10, 20);
        console.info(msg + ' RectUtils offsetTo 1 successed');
        console.info(msg + ' RectUtils offsetTo 1 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 10 && rect.top == 20 && rect.right == 10 && rect.bottom == 20).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils offsetTo 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 20, 20, 20);
      try {
        drawing.RectUtils.offsetTo(rect, 5.1, 5.2);
        console.info(msg + ' RectUtils offsetTo 2 successed');
        console.info(msg + ' RectUtils offsetTo 2 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 5.099999904632568 && rect.top == 5.199999809265137 && rect.right == 15.100000381469727 && rect.bottom == 5.199999809265137).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils offsetTo 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 20);
      try {
        drawing.RectUtils.offsetTo(rect, -5, -5.1);
        console.info(msg + ' RectUtils offsetTo 3 successed');
        console.info(msg + ' RectUtils offsetTo 3 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == -5 && rect.top == -5.100000381469727 && rect.right == -5 && rect.bottom == 4.899999618530273).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils offsetTo 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 10);
      try {
        drawing.RectUtils.offsetTo(rect, 0, 5.1);
        console.info(msg + ' RectUtils offsetTo 4 successed');
        console.info(msg + ' RectUtils offsetTo 4 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 5.099999904632568 && rect.right == 0 && rect.bottom == 5.099999904632568).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils offsetTo 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      try {
        drawing.RectUtils.offsetTo(rect, -50, 50);
        console.info(msg + ' RectUtils offsetTo 5 successed');
        console.info(msg + ' RectUtils offsetTo 5 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == -50 && rect.top == 50 && rect.right == 50 && rect.bottom == 150).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils offsetTo 5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0,10.2632,100.25474,100.2884);
      try {
        drawing.RectUtils.offsetTo(rect, 205.256, -2.552);
        console.info(msg + ' RectUtils offsetTo 6 successed');
        console.info(msg + ' RectUtils offsetTo 6 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 205.25599670410156 && rect.top == -2.552000045776367 && rect.right == 305.5107421875 && rect.bottom == 87.47319793701172).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils offsetTo 6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(-100,-100.98788,300.20,300);
      try {
        drawing.RectUtils.offsetTo(rect, 600, 500);
        console.info(msg + ' RectUtils offsetTo 7 successed');
        console.info(msg + ' RectUtils offsetTo 7 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 600 && rect.top == 499.9999694824219 && rect.right == 1000.2000122070313 && rect.bottom == 900.9878540039063).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils offsetTo 7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(100,100.25,-100,-100);
      try {
        drawing.RectUtils.offsetTo(rect, -100000, 100000);
        console.info(msg + ' RectUtils offsetTo 8 successed');
        console.info(msg + ' RectUtils offsetTo 8 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == -100000 && rect.top == 100000 && rect.right == -100200 && rect.bottom == 99799.75).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils offsetTo 8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(Number.MAX_VALUE,Number.MAX_VALUE,Number.MAX_VALUE+1,Number.MAX_VALUE+1);
      try {
        drawing.RectUtils.offsetTo(rect,Number.MAX_VALUE, Number.MAX_VALUE);
        console.info(msg + ' RectUtils offsetTo 9 successed');
        console.info(msg + ' RectUtils offsetTo 9 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils offsetTo 9 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_OFFSETTO_4900
     * @tc.name      : testOffsetTo0049
     * @tc.desc      : testRectUtilsOffsetToMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testOffsetTo0049', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsOffsetToMultipleCalls';
      let rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      for (let i = 0; i < 20; i += 1) {
        try {
          drawing.RectUtils.offsetTo(rect, Math.random() *100, Math.random() *20);
          console.info(msg + `RectUtils.offsetTo success step: ` + i);
        } catch (e) {
          console.info(msg + `RectUtils offsetTo error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_OFFSETTO_5000
     * @tc.name      : testOffsetTo0050
     * @tc.desc      : testRectUtilsOffsetToNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 4
     */
    it('testOffsetTo0050', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, () => {
      let msg = 'testRectUtilsOffsetToNull';
      let rect = drawing.RectUtils.makeEmpty();
      try {
        drawing.RectUtils.offsetTo(null, 10, 20);
        console.info(msg + `RectUtils offsetTo 1 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils offsetTo 1 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.offsetTo(undefined, 10, 20);
        console.info(msg + `RectUtils offsetTo 2 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils offsetTo 2 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.offsetTo(rect, null, 20);
        console.info(msg + `RectUtils offsetTo 3 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils offsetTo 3 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.offsetTo(rect, undefined, 20);
        console.info(msg + `RectUtils offsetTo 4 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils offsetTo 4 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.offsetTo(rect, 10, null);
        console.info(msg + `RectUtils offsetTo 5 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils offsetTo 5 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.offsetTo(rect, 10, undefined);
        console.info(msg + `RectUtils offsetTo 6 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils offsetTo 6 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_SETRECT_5100
     * @tc.name      : testSetRect0051
     * @tc.desc      : Test for testRectUtilsSetRectNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testSetRect0051', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let msg = 'testRectUtilsSetRectNormal';
      let rect = drawing.RectUtils.makeEmpty();
      let rect2: common2D.Rect = { left: 0, right: 90, top: 0, bottom: 120 };
      try {
        drawing.RectUtils.setRect(rect, rect2);
        console.info(msg + ' RectUtils setRect 1 successed');
        console.info(msg + ' RectUtils setRect 1 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils setRect 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = drawing.RectUtils.makeLtrb(10, 20, 20, 20);
      try {
        drawing.RectUtils.setRect(rect, rect2);
        console.info(msg + ' RectUtils setRect 2 successed');
        console.info(msg + ' RectUtils setRect 2 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils setRect 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = drawing.RectUtils.makeLtrb(10, 10, 10, 20);
      try {
        drawing.RectUtils.setRect(rect, rect2);
        console.info(msg + ' RectUtils setRect 3 successed');
        console.info(msg + ' RectUtils setRect 3 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils setRect 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = drawing.RectUtils.makeLtrb(10, 10, 10, 10);
      try {
        drawing.RectUtils.setRect(rect, rect2);
        console.info(msg + ' RectUtils setRect 4 successed');
        console.info(msg + ' RectUtils setRect 4 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils setRect 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = drawing.RectUtils.makeLtrb(0, 0, 300, 300);
      try {
        drawing.RectUtils.setRect(rect, rect2);
        console.info(msg + ' RectUtils setRect 5 successed');
        console.info(msg + ' RectUtils setRect 5 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils setRect 5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = drawing.RectUtils.makeLtrb(0,100.2632,300.25474,300.2884);
      try {
        drawing.RectUtils.setRect(rect, rect2);
        console.info(msg + ' RectUtils setRect 6 successed');
        console.info(msg + ' RectUtils setRect 6 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils setRect 6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = drawing.RectUtils.makeLtrb(-100,-100.98788,350.20,350);
      try {
        drawing.RectUtils.setRect(rect, rect2);
        console.info(msg + ' RectUtils setRect 7 successed');
        console.info(msg + ' RectUtils setRect 7 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils setRect 7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = drawing.RectUtils.makeLtrb(500,510.25,-100,-100);
      try {
        drawing.RectUtils.setRect(rect, rect2);
        console.info(msg + ' RectUtils setRect 8 successed');
        console.info(msg + ' RectUtils setRect 8 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils setRect 8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = drawing.RectUtils.makeEmpty();
      try {
        drawing.RectUtils.setRect(rect, rect2);
        console.info(msg + ' RectUtils setRect 9 successed');
        console.info(msg + ' RectUtils setRect 9 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils setRect 9 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = drawing.RectUtils.makeLtrb(200,400,300,500);
      rect = drawing.RectUtils.makeLtrb(200,400,300,500);
      try {
        drawing.RectUtils.setRect(rect, rect2);
        console.info(msg + ' RectUtils setRect 10 successed');
        console.info(msg + ' RectUtils setRect 10 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils setRect 10 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(Number.MAX_VALUE,Number.MAX_VALUE,Number.MAX_VALUE+1,Number.MAX_VALUE+1);
      try {
        drawing.RectUtils.setRect(rect, rect2);
        console.info(msg + ' RectUtils setRect 11 successed');
        console.info(msg + ' RectUtils setRect 11 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils setRect 11 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_SETRECT_5200
     * @tc.name      : testSetRect0052
     * @tc.desc      : testRectUtilsSetRectMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testSetRect0052', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsSetRectMultipleCalls';
      let rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      for (let i = 0; i < 20; i += 1) {
        try {
          let rect2: common2D.Rect = { left: Math.random() *10, right: Math.random() *20, top: Math.random() *30, bottom: Math.random() *40 };
          drawing.RectUtils.setRect(rect, rect2);
          console.info(msg + `RectUtils.setRect success step: ` + i);
        } catch (e) {
          console.info(msg + `RectUtils setRect error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_SETRECT_5300
     * @tc.name      : testSetRect0053
     * @tc.desc      : testRectUtilsSetRectNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 4
     */
    it('testSetRect0053', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, () => {
      let msg = 'testRectUtilsSetRectNull';
      let rect = drawing.RectUtils.makeEmpty();
      let rect2: common2D.Rect = { left: 0, right: 90, top: 0, bottom: 120 };
      try {
        drawing.RectUtils.setRect(null, rect2);
        console.info(msg + `RectUtils setRect 1 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils setRect 1 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.setRect(undefined, rect2);
        console.info(msg + `RectUtils setRect 2 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils setRect 2 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.setRect(rect, null);
        console.info(msg + `RectUtils setRect 3 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils setRect 3 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.setRect(rect, undefined);
        console.info(msg + `RectUtils setRect 4 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils setRect 4 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_SETLTRB_5400
     * @tc.name      : testSetLtrb0054
     * @tc.desc      : Test for testRectUtilsSetLtrbNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testSetLtrb0054', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let msg = 'testRectUtilsSetLtrbNormal';
      let rect = drawing.RectUtils.makeEmpty();
      try {
        drawing.RectUtils.setLtrb(rect, 0,0,90,120);
        console.info(msg + ' RectUtils setLtrb 1 successed');
        console.info(msg + ' RectUtils setLtrb 1 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils setLtrb 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        drawing.RectUtils.setLtrb(rect, 10, 20, 20, 20);
        console.info(msg + ' RectUtils setLtrb 2 successed');
        console.info(msg + ' RectUtils setLtrb 2 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils setLtrb 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        drawing.RectUtils.setLtrb(rect, 10, 10, 10, 20);
        console.info(msg + ' RectUtils setLtrb 3 successed');
        console.info(msg + ' RectUtils setLtrb 3 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils setLtrb 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        drawing.RectUtils.setLtrb(rect, 10, 10, 10, 10);
        console.info(msg + ' RectUtils setLtrb 4 successed');
        console.info(msg + ' RectUtils setLtrb 4 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils setLtrb 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        drawing.RectUtils.setLtrb(rect, 0, 0, 300, 300);
        console.info(msg + ' RectUtils setLtrb 5 successed');
        console.info(msg + ' RectUtils setLtrb 5 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils setLtrb 5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        drawing.RectUtils.setLtrb(rect, 0,100.2632,300.25474,300.2884);
        console.info(msg + ' RectUtils setLtrb 6 successed');
        console.info(msg + ' RectUtils setLtrb 6 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils setLtrb 6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        drawing.RectUtils.setLtrb(rect, -100,-100.98788,350.20,350);
        console.info(msg + ' RectUtils setLtrb 7 successed');
        console.info(msg + ' RectUtils setLtrb 7 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils setLtrb 7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        drawing.RectUtils.setLtrb(rect, 500,510.25,-100,-100);
        console.info(msg + ' RectUtils setLtrb 8 successed');
        console.info(msg + ' RectUtils setLtrb 8 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils setLtrb 8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      try {
        drawing.RectUtils.setLtrb(rect, 0,0,0,0);
        console.info(msg + ' RectUtils setLtrb 9 successed');
        console.info(msg + ' RectUtils setLtrb 9 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils setLtrb 9 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(200,400,300,500);
      try {
        drawing.RectUtils.setLtrb(rect, 200,400,300,500);
        console.info(msg + ' RectUtils setLtrb 10 successed');
        console.info(msg + ' RectUtils setLtrb 10 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils setLtrb 10 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(Number.MAX_VALUE,Number.MAX_VALUE,Number.MAX_VALUE+1,Number.MAX_VALUE+1);
      try {
        drawing.RectUtils.setLtrb(rect, Number.MAX_VALUE,Number.MAX_VALUE,Number.MAX_VALUE+1,Number.MAX_VALUE+1);
        console.info(msg + ' RectUtils setLtrb 11 successed');
        console.info(msg + ' RectUtils setLtrb 11 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils setLtrb 11 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_SETLTRB_5500
     * @tc.name      : testSetLtrb0055
     * @tc.desc      : testRectUtilsSetLtrbMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testSetLtrb0055', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsSetLtrbMultipleCalls';
      let rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      for (let i = 0; i < 20; i += 1) {
        try {
          drawing.RectUtils.setLtrb(rect, Math.random() *10,Math.random() *20,Math.random() *10,Math.random() *10);
          console.info(msg + `RectUtils.setLtrb success step: ` + i);
        } catch (e) {
          console.info(msg + `RectUtils setLtrb error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_SETLTRB_5600
     * @tc.name      : testSetLtrb0056
     * @tc.desc      : testRectUtilsSetLtrbNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 4
     */
    it('testSetLtrb0056', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, () => {
      let msg = 'testRectUtilsSetLtrbNull';
      let rect = drawing.RectUtils.makeEmpty();
      try {
        drawing.RectUtils.setLtrb(null, 0, 0, 300, 300);
        console.info(msg + `RectUtils setLtrb 1 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils setLtrb 1 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.setLtrb(undefined, 0, 0, 300, 300);
        console.info(msg + `RectUtils setLtrb 2 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils setLtrb 2 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.setLtrb(rect, null, 0, 300, 300);
        console.info(msg + `RectUtils setLtrb 3 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils setLtrb 3 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.setLtrb(rect, undefined, 0, 300, 300);
        console.info(msg + `RectUtils setLtrb 4 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils setLtrb 4 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.setLtrb(rect, 0, null, 300, 300);
        console.info(msg + `RectUtils setLtrb 5 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils setLtrb 5 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.setLtrb(rect, 0, undefined, 300, 300);
        console.info(msg + `RectUtils setLtrb 6 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils setLtrb 6 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.setLtrb(rect, 0, 0, null, 300);
        console.info(msg + `RectUtils setLtrb 7 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils setLtrb 7 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.setLtrb(rect, 0, 0, undefined, 300);
        console.info(msg + `RectUtils setLtrb 8 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils setLtrb 8 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.setLtrb(rect, 0, 0, 300, null);
        console.info(msg + `RectUtils setLtrb 9 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils setLtrb 9 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.setLtrb(rect, 0, 0, 300, undefined);
        console.info(msg + `RectUtils setLtrb 10 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils setLtrb 10 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_SETEMPTY_5700
     * @tc.name      : testSetEmpty0057
     * @tc.desc      : Test for testRectUtilsSetEmptyNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testSetEmpty0057', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let msg = 'testRectUtilsSetEmptyNormal';
      let rect = drawing.RectUtils.makeEmpty();
      try {
        drawing.RectUtils.setEmpty(rect);
        console.info(msg + ' RectUtils setEmpty 1 successed');
        console.info(msg + ' RectUtils setEmpty 1 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 0 && rect.bottom == 0).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils setEmpty 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 20, 20, 20);
      try {
        drawing.RectUtils.setEmpty(rect);
        console.info(msg + ' RectUtils setEmpty 2 successed');
        console.info(msg + ' RectUtils setEmpty 2 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 0 && rect.bottom == 0).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils setEmpty 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 20);
      try {
        drawing.RectUtils.setEmpty(rect);
        console.info(msg + ' RectUtils setEmpty 3 successed');
        console.info(msg + ' RectUtils setEmpty 3 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 0 && rect.bottom == 0).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils setEmpty 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 10);
      try {
        drawing.RectUtils.setEmpty(rect);
        console.info(msg + ' RectUtils setEmpty 4 successed');
        console.info(msg + ' RectUtils setEmpty 4 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 0 && rect.bottom == 0).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils setEmpty 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 300, 300);
      try {
        drawing.RectUtils.setEmpty(rect);
        console.info(msg + ' RectUtils setEmpty 5 successed');
        console.info(msg + ' RectUtils setEmpty 5 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 0 && rect.bottom == 0).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils setEmpty 5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0,100.2632,300.25474,300.2884);
      try {
        drawing.RectUtils.setEmpty(rect);
        console.info(msg + ' RectUtils setEmpty 6 successed');
        console.info(msg + ' RectUtils setEmpty 6 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 0 && rect.bottom == 0).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils setEmpty 6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(-100,-100.98788,350.20,350);
      try {
        drawing.RectUtils.setEmpty(rect);
        console.info(msg + ' RectUtils setEmpty 7 successed');
        console.info(msg + ' RectUtils setEmpty 7 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 0 && rect.bottom == 0).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils setEmpty 7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(500,510.25,-100,-100);
      try {
        drawing.RectUtils.setEmpty(rect);
        console.info(msg + ' RectUtils setEmpty 8 successed');
        console.info(msg + ' RectUtils setEmpty 8 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 0 && rect.bottom == 0).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils setEmpty 8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(Number.MAX_VALUE,Number.MAX_VALUE,Number.MAX_VALUE+1,Number.MAX_VALUE+1);
      try {
        drawing.RectUtils.setEmpty(rect);
        console.info(msg + ' RectUtils setEmpty 9 successed');
        console.info(msg + ' RectUtils setEmpty 9 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 0 && rect.bottom == 0).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils setEmpty 9 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_SETEMPTY_5800
     * @tc.name      : testSetEmpty0058
     * @tc.desc      : testRectUtilsSetEmptyMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testSetEmpty0058', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsSetEmptyMultipleCalls';
      let rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      for (let i = 0; i < 20; i += 1) {
        try {
          drawing.RectUtils.setEmpty(rect);
          console.info(msg + `RectUtils.setEmpty success step: ` + i);
          console.info(msg + ' RectUtils setEmpty  successed rect: ' + JSON.stringify(rect));
          expect(rect.left == 0 && rect.top == 0 && rect.right == 0 && rect.bottom == 0).assertEqual(true);
        } catch (e) {
          console.info(msg + `RectUtils setEmpty error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_SETEMPTY_5900
     * @tc.name      : testSetEmpty0059
     * @tc.desc      : testRectUtilsSetEmptyNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 4
     */
    it('testSetEmpty0059', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, () => {
      let msg = 'testRectUtilsSetEmptyNull';
      let rect = drawing.RectUtils.makeEmpty();
      try {
        drawing.RectUtils.setEmpty(null);
        console.info(msg + `RectUtils setEmpty 1 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils setEmpty 1 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.setEmpty(undefined);
        console.info(msg + `RectUtils setEmpty 2 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils setEmpty 2 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_SORT_6000
     * @tc.name      : testSort0060
     * @tc.desc      : Test for testRectUtilsSortNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testSort0060', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let msg = 'testRectUtilsSortNormal';
      let rect = drawing.RectUtils.makeEmpty();
      try {
        drawing.RectUtils.sort(rect);
        console.info(msg + ' RectUtils sort 1 successed');
        console.info(msg + ' RectUtils sort 1 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 0 && rect.bottom == 0).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils sort 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 20, 20, 20);
      try {
        drawing.RectUtils.sort(rect);
        console.info(msg + ' RectUtils sort 2 successed');
        console.info(msg + ' RectUtils sort 2 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 10 && rect.top == 20 && rect.right == 20 && rect.bottom == 20).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils sort 2 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 20);
      try {
        drawing.RectUtils.sort(rect);
        console.info(msg + ' RectUtils sort 3 successed');
        console.info(msg + ' RectUtils sort 3 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 10 && rect.top == 10 && rect.right == 10 && rect.bottom == 20).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils sort 3 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 10);
      try {
        drawing.RectUtils.sort(rect);
        console.info(msg + ' RectUtils sort 4 successed');
        console.info(msg + ' RectUtils sort 4 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 10 && rect.top == 10 && rect.right == 10 && rect.bottom == 10).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils sort 4 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 300, 300);
      try {
        drawing.RectUtils.sort(rect);
        console.info(msg + ' RectUtils sort 5 successed');
        console.info(msg + ' RectUtils sort 5 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 0 && rect.right == 300 && rect.bottom == 300).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils sort 5 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0,100.2632,300.25474,300.2884);
      try {
        drawing.RectUtils.sort(rect);
        console.info(msg + ' RectUtils sort 6 successed');
        console.info(msg + ' RectUtils sort 6 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == 0 && rect.top == 100.26319885253906 && rect.right == 300.2547302246094 && rect.bottom == 300.28839111328125).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils sort 6 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(-100,-100.98788,350.20,350);
      try {
        drawing.RectUtils.sort(rect);
        console.info(msg + ' RectUtils sort 7 successed');
        console.info(msg + ' RectUtils sort 7 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == -100 && rect.top == -100.98787689208984 && rect.right == 350.20001220703125 && rect.bottom == 350).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils setEmpty 7 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(500,510.25,-100,-100);
      try {
        drawing.RectUtils.sort(rect);
        console.info(msg + ' RectUtils sort 8 successed');
        console.info(msg + ' RectUtils sort 8 successed rect: ' + JSON.stringify(rect));
        expect(rect.left == -100 && rect.top == -100 && rect.right == 500 && rect.bottom == 510.25).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils setEmpty 8 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(Number.MAX_VALUE,Number.MAX_VALUE,Number.MAX_VALUE+1,Number.MAX_VALUE+1);
      try {
        drawing.RectUtils.sort(rect);
        console.info(msg + ' RectUtils sort 9 successed');
        console.info(msg + ' RectUtils sort 9 successed rect: ' + JSON.stringify(rect));
      } catch (e) {
        console.info(msg + ` RectUtils sort 9 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_SORT_6100
     * @tc.name      : testSort0061
     * @tc.desc      : testRectUtilsSortMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testSort0061', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsSortMultipleCalls';
      let rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      for (let i = 0; i < 20; i += 1) {
        try {
          drawing.RectUtils.sort(rect);
          console.info(msg + `RectUtils.sort success step: ` + i);
          console.info(msg + ' RectUtils sort  successed rect: ' + JSON.stringify(rect));
          expect(rect.left == 0 && rect.top == 0 && rect.right == 100 && rect.bottom == 100).assertEqual(true);
        } catch (e) {
          console.info(msg + `RectUtils sort error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_SORT_6200
     * @tc.name      : testSort0062
     * @tc.desc      : testRectUtilsSortNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 4
     */
    it('testSort0062', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, () => {
      let msg = 'testRectUtilsSortNull';
      let rect = drawing.RectUtils.makeEmpty();
      try {
        drawing.RectUtils.sort(null);
        console.info(msg + `RectUtils sort 1 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils sort 1 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.sort(undefined);
        console.info(msg + `RectUtils sort 2 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils sort 2 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_ISEQUAL_6300
     * @tc.name      : testIsEqual0063
     * @tc.desc      : Test for testRectUtilsIsEqualNormal.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testIsEqual0063', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let msg = 'testRectUtilsIsEqualNormal';
      let rect = drawing.RectUtils.makeEmpty();
      let rect2: common2D.Rect = { left: 0, right: 0, top: 0, bottom: 0 };
      try {
        let isEqual: boolean = drawing.RectUtils.isEqual(rect, rect2);
        console.info(msg + ' RectUtils isEqual 1 successed');
        expect(isEqual).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils isEqual 1 errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect2 = drawing.RectUtils.makeLtrb(10, 20, 20, 20);
      try {
        let isEqual2: boolean = drawing.RectUtils.isEqual(rect, rect2);
        console.info(msg + ' RectUtils isEqual2  successed');
        expect(isEqual2).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils isEqual2  errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 20);
      try {
        let isEqual3: boolean = drawing.RectUtils.isEqual(rect, rect2);
        console.info(msg + ' RectUtils isEqual3  successed');
        expect(isEqual3).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils isEqual3  errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(10, 10, 10, 10);
      rect2 = drawing.RectUtils.makeLtrb(20, 20, 20, 20);
      try {
        let isEqual4: boolean = drawing.RectUtils.isEqual(rect, rect2);
        console.info(msg + ' RectUtils isEqual4  successed');
        expect(isEqual4).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils isEqual4  errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0, 0, 300, 300);
      drawing.RectUtils.setEmpty(rect2);
      try {
        let isEqual5: boolean = drawing.RectUtils.isEqual(rect, rect2);
        console.info(msg + ' RectUtils isEqual5  successed');
        expect(isEqual5).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils isEqual5  errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(0,100.2632,300.25474,300.2884);
      rect2 = drawing.RectUtils.makeLtrb(0,100.3632,300.251,300.2884);
      try {
        let isEqual6: boolean = drawing.RectUtils.isEqual(rect, rect2);
        console.info(msg + ' RectUtils isEqual6  successed');
        expect(isEqual6).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils isEqual6  errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(-100,-100.98788,350.20,350);
      rect2 = drawing.RectUtils.makeLtrb(-100,-100.98788,350.20,350);
      try {
        let isEqual7: boolean = drawing.RectUtils.isEqual(rect, rect2);
        console.info(msg + ' RectUtils isEqual7  successed');
        expect(isEqual7).assertEqual(true);
      } catch (e) {
        console.info(msg + ` RectUtils isEqual7  errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
      rect = drawing.RectUtils.makeLtrb(500,510.25,-100,-100);
      rect2 = drawing.RectUtils.makeLtrb(350.20,350, -100,-100.98788);
      try {
        let isEqual8: boolean = drawing.RectUtils.isEqual(rect, rect2);
        console.info(msg + ' RectUtils isEqual8  successed');
        expect(isEqual8).assertEqual(false);
      } catch (e) {
        console.info(msg + ` RectUtils isEqual8  errorCode is:  ${e.code} + errormsg is: ${e.message}`);
        expect().assertFail()
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_ISEQUAL_6400
     * @tc.name      : testIsEqual0064
     * @tc.desc      : testRectUtilsIsEqualMultipleCalls
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level3
     */
    it('testIsEqual0064', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      let msg = 'testRectUtilsIsEqualMultipleCalls';
      let rect = drawing.RectUtils.makeLtrb(0, 0, 100, 100);
      let rect2: common2D.Rect = { left: 0, right: 0, top: 0, bottom: 0 };
      for (let i = 0; i < 20; i += 1) {
        try {
          let isEqual: boolean = drawing.RectUtils.isEqual(rect, rect2);
          console.info(msg + `RectUtils.isEqual success step: ` + i);
          expect(isEqual).assertEqual(false);
        } catch (e) {
          console.info(msg + `RectUtils isEqual error. errorCode is: ${e.code} + errormsg is: ${e.message}} step: ${i}`);
          expect().assertFail()
        }
      }
    })

    /**
     * @tc.number    : SUB_GRAPHIC_RECTUTILS_ISEQUAL_6500
     * @tc.name      : testIsEqual0065
     * @tc.desc      : testRectUtilsIsEqualNull
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 4
     */
    it('testIsEqual0065', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL4, () => {
      let msg = 'testRectUtilsIsEqualNull';
      let rect2: common2D.Rect = { left: 0, right: 100, top: 0, bottom: 100 };
      try {
        drawing.RectUtils.isEqual(null, rect2);
        console.info(msg + `RectUtils isEqual 1 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils isEqual 1 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.isEqual(undefined, rect2);
        console.info(msg + `RectUtils isEqual 2 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils isEqual 2 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.isEqual(rect2, null);
        console.info(msg + `RectUtils isEqual 3 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils isEqual 3 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
      try {
        drawing.RectUtils.isEqual(rect2, undefined);
        console.info(msg + `RectUtils isEqual 4 successed`);
        expect().assertFail();
      } catch (e) {
        console.info(msg + `RectUtils isEqual 4 failed. Error code is: ${e.code}. Error message is: ${e.message}`);
        expect(e.code).assertEqual(401);
      }
    })
  })
}