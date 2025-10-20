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
function test_abs_001 (expected: string, value: string) {
  expect(expected).assertEqual(Decimal.abs(value).valueOf());
  expect(expected).assertEqual(new Decimal(value).abs().valueOf());
}
function test_abs_002 (expected: string, value: number) {
  expect(expected).assertEqual(Decimal.abs(value).valueOf());
  expect(expected).assertEqual(new Decimal(value).abs().valueOf());
}
function test_abs_003 (expected: string, value: Decimal) {
  expect(expected).assertEqual(Decimal.abs(value).valueOf());
  expect(expected).assertEqual(new Decimal(value).abs().valueOf());
}
async function Delay(delay: number): Promise<void> {
  return new Promise((resolve:Function)=>{
    setTimeout(()=>{
      resolve('Hello World!');
    },delay);
  });
}
export default function AbsTest() {
  describe("AbsTest", () => {
    beforeAll(() => {
      console.info("beforeAll: Prerequisites at the test suite level, which are executed before the test suite is executed.");
    });
    beforeEach(async() => {
      await Delay(1000);
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
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_ABS_0100
     * @tc.name      : testAbs0001
     * @tc.desc      : Test abs
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testAbs0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 20,
        rounding: 4,
        toExpNeg: -7,
        toExpPos: 21,
        minE: -9e15,
        maxE: 9e15
      });
      test_abs_002('0', 0);
      test_abs_001('0', '0');
      test_abs_002('0', -0);
      test_abs_001('0', '-0');
      test_abs_002('1', 1);
      test_abs_002('1', -1);
      test_abs_001('1', '-1');
      test_abs_001('0.5', '0.5');
      test_abs_001('0.5', '-0.5');
      test_abs_002('0.1', 0.1);
      test_abs_002('0.1', -0.1);
      test_abs_002('1.1', 1.1);
      test_abs_002('1.1', -1.1);
      test_abs_001('1.5', '1.5');
      test_abs_001('1.5', '-1.5');
      test_abs_001('0.00001', '-1e-5');
      test_abs_001('9000000000', '-9e9');
      test_abs_001('123456.7891011', '123456.7891011');
      test_abs_002('123456.7891011', -123456.7891011);
      test_abs_001('99', '99');
      test_abs_002('99', -99);
      test_abs_002('999.999', 999.999);
      test_abs_001('999.999', '-999.999');
      test_abs_003('1', new Decimal(-1));
      test_abs_003('1', new Decimal('-1'));
      test_abs_003('0.001', new Decimal(0.001));
      test_abs_003('0.001', new Decimal('-0.001'));
      test_abs_002('Infinity', Infinity);
      test_abs_002('Infinity', -Infinity);
      test_abs_001('Infinity', 'Infinity');
      test_abs_001('Infinity', '-Infinity');
      test_abs_002('NaN', NaN);
      test_abs_002('NaN', -NaN);
      test_abs_001('NaN', 'NaN');
      test_abs_001('NaN', '-NaN');
      test_abs_001('11.121', '11.121');
      test_abs_001('0.023842', '-0.023842');
      test_abs_001('1.19', '-1.19');
      test_abs_001('9.622e-11', '-0.00000000009622');
      test_abs_001('5.09e-10', '-0.000000000509');
      test_abs_001('3838.2', '3838.2');
      test_abs_001('127', '127.0');
      test_abs_001('4.23073', '4.23073');
      test_abs_001('2.5469', '-2.5469');
      test_abs_001('29949', '-29949');
      test_abs_001('277.1', '-277.10');
      test_abs_001('4.97898e-15', '-0.00000000000000497898');
      test_abs_001('53.456', '53.456');
      test_abs_001('100564', '-100564');
      test_abs_001('12431.9', '-12431.9');
      test_abs_001('97633.7', '-97633.7');
      test_abs_001('220', '220');
      test_abs_001('18.72', '18.720');
      test_abs_001('2817', '-2817');
      test_abs_001('44535', '-44535');
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_ABS_0200
     * @tc.name      : testAbs0002
     * @tc.desc      : Test abs
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testAbs0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 20,
        rounding: 4,
        toExpNeg: -7,
        toExpPos: 21,
        minE: -9e15,
        maxE: 9e15
      });
      Decimal.set ({ toExpNeg: 0, toExpPos:0 })
      test_abs_001('5.2452468128e+1', '-5.2452468128e+1');
      test_abs_001('1.41525905257189365008396e+16', '1.41525905257189365008396e+16');
      test_abs_001('2.743068083928e+11', '2.743068083928e+11');
      test_abs_001('1.52993064722314247378724599e+26', '-1.52993064722314247378724599e+26');
      test_abs_001('3.7205576746e+10', '3.7205576746e+10');
      test_abs_001('2.663e-10', '-2.663e-10');
      test_abs_001('1.26574209965030360615518e+17', '-1.26574209965030360615518e+17');
      test_abs_001('1.052e+3', '1.052e+3');
      test_abs_001('4.452945872502e+6', '-4.452945872502e+6');
      test_abs_001('2.95732460816619226e+13', '2.95732460816619226e+13');
      test_abs_001('1.1923100194288654481424e+18', '-1.1923100194288654481424e+18');
      test_abs_001('8.99315449050893705e+6', '8.99315449050893705e+6');
      test_abs_001('5.200726538434486963e+8', '5.200726538434486963e+8');
      test_abs_001('1.182618278949368566264898065e+18', '1.182618278949368566264898065e+18');
      test_abs_001('3.815873266712e-20', '-3.815873266712e-20');
      test_abs_001('1.316675370382742615e+6', '-1.316675370382742615e+6');
      test_abs_001('2.1032502e+6', '-2.1032502e+6');
      test_abs_001('1.8e+1', '1.8e+1');
      test_abs_001('1.033525906631680944018544811261e-13', '1.033525906631680944018544811261e-13');
      test_abs_001('1.102361746443461856816e+14', '-1.102361746443461856816e+14');
      test_abs_001('8.595358491143959e+1', '8.595358491143959e+1');
      test_abs_001('1.226806049797304683867e-18', '1.226806049797304683867e-18');
      test_abs_001('5e+0', '-5e+0');
      test_abs_001('1.091168788407093537887970016e+15', '-1.091168788407093537887970016e+15');
      test_abs_001('3.87166413612272027e+12', '3.87166413612272027e+12');
      test_abs_001('1.411514e+5', '1.411514e+5');
      test_abs_001('1.0053454672509859631996e+22', '1.0053454672509859631996e+22');
      test_abs_001('6.9265714e+0', '6.9265714e+0');
      test_abs_001('1.04627709e+4', '1.04627709e+4');
      test_abs_001('2.285650225267766689304972e+5', '2.285650225267766689304972e+5');
      test_abs_001('4.5790517211306242e+7', '4.5790517211306242e+7');
      test_abs_001('3.0033340092338313923473428e+16', '-3.0033340092338313923473428e+16');
      test_abs_001('2.83879929283797623e+1', '-2.83879929283797623e+1');
      test_abs_001('4.5266377717178121183759377414e-5', '4.5266377717178121183759377414e-5');
      test_abs_001('5.3781e+4', '-5.3781e+4');
      test_abs_001('6.722035208213298413522819127e-18', '-6.722035208213298413522819127e-18');
      test_abs_001('3.02865707828281230987116e+23', '-3.02865707828281230987116e+23');
      test_abs_001('1e-9000000000000000', '1e-9000000000000000');
      test_abs_001('1e-9000000000000000', '-1e-9000000000000000');
      test_abs_001('0e+0', '-9.9e-9000000000000001');
      test_abs_001('9.999999e+9000000000000000', '9.999999e+9000000000000000');
      test_abs_001('9.999999e+9000000000000000', '-9.999999e+9000000000000000');
      test_abs_001('Infinity', '1E9000000000000001');
      test_abs_001('Infinity', '-1e+9000000000000001');
      test_abs_001('5.5879983320336874473209567979e+287894365', '-5.5879983320336874473209567979e+287894365');
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_ABS_0300
     * @tc.name      : testAbs0003
     * @tc.desc      : Test abs
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testAbs0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 20,
        rounding: 4,
        toExpNeg: -7,
        toExpPos: 21,
        minE: -9e15,
        maxE: 9e15
      });
      try {
        test_abs_001('e', 'e');
        expect(true).assertEqual(false);
      } catch (err) {
        expect(err.name).assertEqual(`BusinessError`);
        expect(err.code).assertEqual(401);
        expect(err.message).assertEqual(`The type of "test(str)" must be Hex/Binary/Octal. Received value is: e`);
      }
    });
  });
}