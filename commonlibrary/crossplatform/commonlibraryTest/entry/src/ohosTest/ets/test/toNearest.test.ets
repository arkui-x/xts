/*
 * Copyright (C) 2025 Huawei Device Co., Ltd.
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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, Size, TestType} from "@ohos/hypium";
import { Decimal } from '@kit.ArkTS';

type Rounding = 0 | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8;
function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}
function test_toNearest_001 (expected: string, n: string, v: number, rm: Rounding) {
  expect(expected).assertEqual(new Decimal(n).toNearest(v, rm).valueOf());
}
function test_toNearest_002 (expected: string, n: number, v: number, rm: Rounding) {
  expect(expected).assertEqual(new Decimal(n).toNearest(v, rm).valueOf());
}
function test_toNearest_003 (expected: string, n: string, v: string, rm: Rounding) {
  expect(expected).assertEqual(new Decimal(n).toNearest(v, rm).valueOf());
}
function test_toNearest_004 (expected: string, n: string, v: Decimal, rm: Rounding) {
  expect(expected).assertEqual(new Decimal(n).toNearest(v, rm).valueOf());
}

export default function ToNearestTest() {
  describe("ToNearestTest", () => {
    beforeAll(() => {
      console.info("beforeAll: Prerequisites at the test suite level, which are executed before the test suite is executed.");
    });
    beforeEach(async() => {
      await sleep(100);
      console.info("beforeEach: Prerequisites at the test case level, which are executed before each test case is executed.");
    });
    afterEach(() => {
      console.info("afterEach: Test case-level clearance conditions, which are executed after each test case is executed.");
    });
    afterAll(async() => {
      await sleep(500);
      console.info("afterAll: Test suite-level cleanup condition, which is executed after the test suite is executed");
    });
    console.info("start################################start");

    /**
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_TONEAREST_0100
     * @tc.name      : testToNearest0001
     * @tc.desc      : Test toNearest
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testToNearest0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 20,
        rounding: 4,
        toExpNeg: -9e15,
        toExpPos: 9e15,
        minE: -9e15,
        maxE: 9e15
      });
      test_toNearest_002('3', 1.5, -3, 0);
      test_toNearest_002('-0', -1.5, -3, 1);
      test_toNearest_002('-3', -1.5, -3, 2);
      test_toNearest_001('83105511540', '83105511539.5', 1, 4);
      test_toNearest_003('83105511539', '83105511539.5', '1', 5);
      Decimal.set({ precision: 3});
      test_toNearest_004('83105511540', '83105511539.5', new Decimal(1), 4);
      test_toNearest_001('83105511539', '83105511539.499999999999999999999999999999', 1, 4);
      test_toNearest_004('83105511539', '83105511539.5', new Decimal('1'), 5);
      Decimal.set({ precision: 20});
      test_toNearest_001('83105511540', '83105511539.5', -1, 4);
      test_toNearest_003('83105511539', '83105511539.5', '-1', 5);
      test_toNearest_004('-83105511540', '-83105511539.5', new Decimal(-1), 4);
      test_toNearest_004('-83105511539', '-83105511539.5', new Decimal('-1'), 5);
      test_toNearest_001('83105511540', '83105511539.5', 1, 0);
      test_toNearest_001('83105511539', '83105511539.5', 1, 1);
      test_toNearest_001('83105511540', '83105511539.5', 1, 2);
      test_toNearest_001('83105511539', '83105511539.5', 1, 3);
      test_toNearest_001('83105511540', '83105511539.5', 1, 4);
      test_toNearest_001('83105511539', '83105511539.5', 1, 5);
      test_toNearest_001('83105511540', '83105511539.5', 1, 6);
      test_toNearest_001('83105511540', '83105511539.5', 1, 7);
      test_toNearest_001('83105511539', '83105511539.5', 1, 8);
      test_toNearest_001('3847570', '3847561.00000749', 10, 0);
      test_toNearest_001('500', '449.999', 100, 0);
      test_toNearest_001('400', '449.999', 100, 1);
      test_toNearest_001('500', '449.999', 100, 2);
      test_toNearest_001('400', '449.999', 100, 3);
      test_toNearest_001('400', '449.999', 100, 4);
      test_toNearest_001('400', '449.999', 100, 5);
      test_toNearest_001('400', '449.999', 100, 6);
      test_toNearest_001('400', '449.999', 100, 7);
      test_toNearest_001('400', '449.999', 100, 8);
      test_toNearest_001('-500', '-449.999', 100, 0);
      test_toNearest_001('-400', '-449.999', 100, 1);
      test_toNearest_001('-400', '-449.999', 100, 2);
      test_toNearest_001('-500', '-449.999', 100, 3);
      test_toNearest_001('-400', '-449.999', 100, 4);
      test_toNearest_001('-400', '-449.999', 100, 5);
      test_toNearest_001('-400', '-449.999', 100, 6);
      test_toNearest_001('-400', '-449.999', 100, 7);
      test_toNearest_001('-400', '-449.999', 100, 8);
      test_toNearest_001('500', '450', 100, 0);
      test_toNearest_001('400', '450', 100, 1);
      test_toNearest_001('500', '450', 100, 2);
      test_toNearest_001('400', '450', 100, 3);
      test_toNearest_001('500', '450', 100, 4);
      test_toNearest_001('400', '450', 100, 5);
      test_toNearest_001('400', '450', 100, 6);
      test_toNearest_001('500', '450', 100, 7);
      test_toNearest_001('400', '450', 100, 8);
      test_toNearest_001('-500', '-450', 100, 0);
      test_toNearest_001('-400', '-450', 100, 1);
      test_toNearest_001('-400', '-450', 100, 2);
      test_toNearest_001('-500', '-450', 100, 3);
      test_toNearest_001('-500', '-450', 100, 4);
      test_toNearest_001('-400', '-450', 100, 5);
      test_toNearest_001('-400', '-450', 100, 6);
      test_toNearest_001('-400', '-450', 100, 7);
      test_toNearest_001('-500', '-450', 100, 8);
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_TONEAREST_0200
     * @tc.name      : testToNearest0002
     * @tc.desc      : Test toNearest
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testToNearest0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 20,
        rounding: 4,
        toExpNeg: -9e15,
        toExpPos: 9e15,
        minE: -9e15,
        maxE: 9e15
      });
      try {
        test_toNearest_001('b1', 'b1', 100, 8);
        expect(true).assertEqual(false);
      } catch (err) {
        expect(err.name).assertEqual(`BusinessError`);
        expect(err.code).assertEqual(401);
        expect(err.message).assertEqual(`The type of "test(str)" must be Hex/Binary/Octal. Received value is: b1`);
      }
    });
  });
}