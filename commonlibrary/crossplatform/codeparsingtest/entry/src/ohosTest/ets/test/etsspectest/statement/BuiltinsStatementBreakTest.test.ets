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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, TestType, Level, Size } from "@ohos/hypium";
import { sleep } from "../../../testability/pages/Utils";

export default function BuiltinsStatementBreakTest() {
  describe('BuiltinsStatementBreakTest', () => {
    beforeEach(async () => {
      await sleep(100);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0100
     * @tc.number ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0100
     * @tc.desc   test Break
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (Done: Function) => {
      let count = 0;
      while (true) {
        console.log(`count: ${count}`);
        count++;
        if (count >= 5) {
          break;
        }
      }
      expect(count).assertEqual(5);
      Done();
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0200
     * @tc.number ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0200
     * @tc.desc   test Break
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (Done: Function) => {
      let count = 0;
      for (count; count <= 10; count++) {
        console.log(`count: ${count}`);
        if (count === 5) {
          break;
        }
      }
      expect(count).assertEqual(5);
      Done();
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0300
     * @tc.number ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0300
     * @tc.desc   test Break
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (Done: Function) => {
      let count = 0;
      do {
        console.log(`count: ${count}`);
        count++;
        if (count === 5) {
          break;
        }
      } while (true);
      expect(count).assertEqual(5);
      Done();
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0400
     * @tc.number ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0400
     * @tc.desc   test Break
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (Done: Function) => {
      let num: number = 0;
      let range: number = 0;
      switch (range) {
        case -1:
          num = -1;
          break;
        case 0:
          num = 0;
          break;
        case 1:
          num = 1;
          break;
        case 2:
          num = 2;
          break;
        case 3:
          num = 3;
          break;
        default:
          num = -2;
      }
      expect(num).assertEqual(0);
      Done();
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0500
     * @tc.number ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0500
     * @tc.desc   test Break
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (Done: Function) => {
      let num: number = 0;
      let range: number = 0;
      switch (range) {
        case -1:
          num = -1;
        case 0:
          num = 0;
        case 1:
          num = 1;
        case 2:
          num = 2;
        case 3:
          num = 3;
        default:
          num = -2;
      }
      expect(num).assertEqual(-2);
      Done();
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0600
     * @tc.number ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0600
     * @tc.desc   test Break
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (Done: Function) => {
      let loopResult: boolean | number = -1;
      let i = 0;
      outerWhile: while (i < 5) {
        let j = 0;
        while (j < 5) {
          console.log(`i: ${i}, j: ${j}`);
          if (i === 1 && j === 4) {
            loopResult = true;
            break;
          }
          if (i === 3 && j === 2) {
            loopResult = 100;
            break;
          }
          if (i === 2 && j === 3) {
            loopResult = false;
            break;
          }
          j++;
        }
        i++;
      }
      console.log(`The result of the loop is: ${loopResult}`);
      expect(loopResult).assertEqual(100);
      Done();
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0700
     * @tc.number ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0700
     * @tc.desc   test Break
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (Done: Function) => {
      let shouldBreak = false;
      let i = 0;
      outerLoop: while (i < 5) {
        let j = 0;
        while (j < 5) {
          console.log(`i: ${i}, j: ${j}`);
          if (i === 2 && j === 3) {
            shouldBreak = true;
          }
          if (shouldBreak) {
            break outerLoop;
          }
          j++;
        }
        i++;
      }
      console.log("Loop execution completed.");
      expect(shouldBreak).assertTrue();
      Done();
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0800
     * @tc.number ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0800
     * @tc.desc   test Break
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (Done: Function) => {
      const executeNonLoopLogic = () => {
        let value = 0;
        value += 1;
        console.log(`Value after step 1: ${value}`);
        if (value === 1) {
          return -1;
        }
        value *= 2;
        console.log(`Value after step 2: ${value}`);
        return value;
      }
      const result = executeNonLoopLogic();
      expect(result).assertEqual(-1);
      Done();
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0900
     * @tc.number ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0900
     * @tc.desc   test Break
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (Done: Function) => {
      const loopWithBreak = () => {
        let sum = 0;
        for (let i = 0; i < 10; i++) {
          sum += i;
          console.log(`Current sum: ${sum}`);
          if (sum > 15) {
            break;
          }
        }
        return sum;
      }
      const result = loopWithBreak();
      expect(result).assertEqual(21);
      Done();
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_1000
     * @tc.number ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_1000
     * @tc.desc   test Break
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_STATEMENT_BUILTINSSTATEMENTBREAKTEST_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (Done: Function) => {
      let loopResult: boolean | number = -1;
      let i = 0;
      outerWhile: while (i < 5) {
        let j = 0;
        while (j < 5) {
          console.log(`i: ${i}, j: ${j}`);
          if (i === 1 && j === 4) {
            loopResult = true;
            break outerWhile;
          }
          if (i === 3 && j === 2) {
            loopResult = 100;
            break outerWhile;
          }
          if (i === 2 && j === 3) {
            loopResult = false;
            break outerWhile;
          }
          j++;
        }
        i++;
      }
      console.log(`The result of the loop is: ${loopResult}`);
      expect(loopResult).assertTrue();
      Done();
    });
  })
}
