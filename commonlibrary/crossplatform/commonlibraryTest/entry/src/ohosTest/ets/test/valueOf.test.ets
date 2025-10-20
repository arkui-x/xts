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
function test_valueOf_001 (expected: string, n: number) {
  expect(expected).assertEqual(new Decimal(n).valueOf());
}
function test_valueOf_002 (expected: string, n: string) {
  expect(expected).assertEqual(new Decimal(n).valueOf());
}
export default function ValueOfTest() {
  describe("ValueTest", () => {
    beforeAll(() => {
      console.info("beforeAll: Prerequisites at the test suite level, which are executed before the test suite is executed.");
    });
    beforeEach(() => {
      console.info("beforeEach: Prerequisites at the test case level, which are executed before each test case is executed.");
    });
    afterEach(() => {
      console.info("afterEach: Test case-level clearance conditions, which are executed after each test case is executed.");
    });
    afterAll(() => {
      console.info("afterAll: Test suite-level cleanup condition, which is executed after the test suite is executed");
    });
    console.info("start################################start");

    /**
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_VALUE_OF_0100
     * @tc.name      : testValueOf0001
     * @tc.desc      : Test valueOf
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testValueOf0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 20,
        rounding: 4,
        toExpNeg: -9e15,
        toExpPos: 9e15,
        minE: -9e15,
        maxE: 9e15
      });
      test_valueOf_001('0', 0);
      test_valueOf_002('0', '0');
      test_valueOf_001('NaN', NaN);
      test_valueOf_002('NaN', 'NaN');
      test_valueOf_001('Infinity', 1/0);
      test_valueOf_002('Infinity', 'Infinity');
      test_valueOf_001('1', 1);
      test_valueOf_001('9', 9);
      test_valueOf_001('90', 90);
      test_valueOf_001('90.12', 90.12);
      test_valueOf_001('0.1', 0.1);
      test_valueOf_001('0.01', 0.01);
      test_valueOf_001('0.0123', 0.0123);
      test_valueOf_002('111111111111111111111',   '111111111111111111111');
      test_valueOf_001('0.00001', 0.00001);
      test_valueOf_001('-0', -0);
      test_valueOf_002('-0', '-0');
      test_valueOf_001('-Infinity', -1/0);
      test_valueOf_002('-Infinity', '-Infinity');
      test_valueOf_001('-1', -1);
      test_valueOf_001('-9', -9);
      test_valueOf_001('-90', -90);
      test_valueOf_001('-90.12', -90.12);
      test_valueOf_001('-0.1', -0.1);
      test_valueOf_001('-0.01', -0.01);
      test_valueOf_001('-0.0123', -0.0123);
      test_valueOf_002('-111111111111111111111',  '-111111111111111111111');
      test_valueOf_001('-0.00001', -0.00001);
      Decimal.set({ toExpNeg: 0, toExpPos: 0 });
      test_valueOf_001('1e-7', 0.0000001);
      test_valueOf_001('1.23e-7', 0.000000123);
      test_valueOf_001('1.2e-8', 0.000000012);
      test_valueOf_001('-1e-7', -0.0000001);
      test_valueOf_001('-1.23e-7', -0.000000123);
      test_valueOf_001('-1.2e-8', -0.000000012);
      test_valueOf_002('5.73447902457635174479825134e+14', '573447902457635.174479825134');
      test_valueOf_002('1.07688e+1', '10.7688');
      test_valueOf_002('3.171194102379077141557759899307946350455841e+27', '3171194102379077141557759899.307946350455841');
      test_valueOf_002('4.924353466898191177698653319742594890634579e+37', '49243534668981911776986533197425948906.34579');
      test_valueOf_002('6.85558243926569397328633907445409866949445343654692955e+18', '6855582439265693973.28633907445409866949445343654692955');
      test_valueOf_002('1e+0', '1');
    });
  });
}