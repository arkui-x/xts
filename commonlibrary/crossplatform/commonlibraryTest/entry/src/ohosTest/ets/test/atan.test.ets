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
function test_atan_001 (n: string, pr: number, rm: Rounding, expected: string) {
  Decimal.set ({ precision: pr, rounding: rm });
  expect(expected).assertEqual(Decimal.atan(n).valueOf());
  expect(expected).assertEqual(new Decimal(n).atan().valueOf());
}
function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function AtanTest() {
  describe("AtanTest", () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_ATAN_0100
     * @tc.name      : testAtan0001
     * @tc.desc      : Test atan
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testAtan0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 40,
        rounding: 4,
        toExpNeg: -9e15,
        toExpPos: 9e15,
        minE: -9e15,
        maxE: 9e15
      });
      test_atan_001('NaN', 40, 4, 'NaN');
      test_atan_001('0', 40, 4, '0');
      test_atan_001('-0', 40, 4, '-0');
      test_atan_001('Infinity', 20, 4, '1.5707963267948966192');
      test_atan_001('-Infinity', 20, 4, '-1.5707963267948966192');
      test_atan_001('0.454786854', 2, 1, '0.42');
      test_atan_001('392.8825877961099786091', 2, 1, '1.5');
      test_atan_001('90.02', 9, 1, '1.55968814');
      test_atan_001('0.22618819', 1, 6, '0.2');
      test_atan_001('2.104', 3, 3, '1.12');
      test_atan_001('0.4', 2, 0, '0.39');
      test_atan_001('700000', 7, 5, '1.570795');
      test_atan_001('0.1034373855738', 4, 0, '0.1031');
      test_atan_001('2888822222222222.77777777888888888887945111', 4, 2, '1.571');
      test_atan_001('0.7163035', 5, 0, '0.62159');
      test_atan_001('31986483109634719887104428745', 4, 1, '1.57');
      test_atan_001('66099.99999090960999899', 9, 2, '1.5707812');
      test_atan_001('1453.5793000200494316368218639720487955117970374751', 8, 3, '1.5701083');
      test_atan_001('25', 10, 1, '1.530817639');
      test_atan_001('0.00083', 2, 5, '0.00083');
      test_atan_001('15469795946533333333333', 3, 2, '1.58');
      test_atan_001('0.0471789911257911619518474101710506908660018025802862437747', 10, 4, '0.04714403323');
      test_atan_001('2436496471267622480734244943816819264461333', 6, 4, '1.5708');
      test_atan_001('397.86', 6, 3, '1.56828');
      test_atan_001('23350774.374402222222222222', 5, 2, '1.5708');
      test_atan_001('6.4999999895999999999999989901', 3, 2, '1.42');
      test_atan_001('0.2021040932658758909350221378184270710381308788971', 25, 0, '0.1994179053851243775408929');
      test_atan_001('37322947047433501470414286593213511', 3, 4, '1.57');
      test_atan_001('0.2', 30, 5, '0.197395559849880758370049765195');
      test_atan_001('68205', 73, 0, '1.570781665113202779409754819994955472047433041976705657000777636779446534');
      test_atan_001('546276727353824444.00000000000000000004444444444444444', 10, 1, '1.570796326');
      test_atan_001('0.702767582631380812', 59, 3, '0.6125809883518849916298401561171422315736485425008362936336');
      test_atan_001('77.2782608490479012', 63, 5, '1.55785679919770947051742907742015525136935668142627146470943833');
      test_atan_001('3782579384288161800008711705384065591', 64, 1, '1.570796326794896619231321691639751441834214834998463624232552952');
      test_atan_001('353878', 38, 3, '1.5707935009622650418565673617028447836');
      test_atan_001('474922903013', 37, 0, '1.570796326792791014313858641566394633');
      test_atan_001('0.983379312948256841133252743255261706498115379968780272468295525', 33, 3, '0.777018375475969147205287424713916');
      test_atan_001('0.94045376770729661028346135758732992772225497003464820039412612634023416', 56, 1, '0.75472103378449515948583375795023656690367842174996205064');
      test_atan_001('8343887380309832830517659566088111111111111111111.111', 62, 0, '1.570796326794896619231321691639751442098584699687433062273514');
      test_atan_001('0.0228839501439921', 54, 5, '0.0228799568131160143605040060800166535189129302340883479');
      test_atan_001('99999920979720113000000.551327043', 30, 2, '1.57079632679489661923131169164');
      test_atan_001('8203149', 25, 4, '1.570796204890491371929944');
      test_atan_001('930000000504000000000000000000000.0870000004', 43, 1, '1.570796326794896619231321691639750366829768');
      test_atan_001('50000000000', 16, 4, '1.570796326774897');
      test_atan_001('2675303931293671338171189092726796196.369350899273657748425', 9, 3, '1.57079632');
      test_atan_001('98351.2797372595375675252656040297344674063', 52, 5, '1.570786159159024091806382088738657135356199886480858');
      test_atan_001('9291816239901918141826076554839014635448673990956049062', 55, 4, '1.57079632679489661923132169163975144209858469968755291');
      test_atan_001('6', 72, 6, '1.40564764938026978095219340199580798810019803922252509146943786614276254');
      test_atan_001('2366378489504444444444.33333333333488', 12, 0, '1.5707963268');
      test_atan_001('161100000000000000000000.5111111', 42, 0, '1.57079632679489661923131548431510836326557');
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_ATAN_0200
     * @tc.name      : testAtan0002
     * @tc.desc      : Test atan
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testAtan0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 40,
        rounding: 4,
        toExpNeg: -9e15,
        toExpPos: 9e15,
        minE: -9e15,
        maxE: 9e15
      });
      try {
        test_atan_001('e1', 40, 4, 'NaN');
        expect(true).assertEqual(false);
      } catch (err) {
        expect(err.name).assertEqual(`BusinessError`);
        expect(err.code).assertEqual(401);
        expect(err.message).assertEqual(`The type of "test(str)" must be Hex/Binary/Octal. Received value is: e1`);
      }
    });
  });
}