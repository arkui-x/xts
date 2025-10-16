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
function test_acosh_001 (n: string, pr: number, rm: Rounding, expected: string) {
  Decimal.set ({ precision: pr, rounding: rm });
  expect(expected).assertEqual(Decimal.acosh(n).valueOf());
  expect(expected).assertEqual(new Decimal(n).acosh().valueOf());
}
async function Delay(delay: number): Promise<void> {
  return new Promise((resolve:Function)=>{
    setTimeout(()=>{
      resolve('Hello World!');
    },delay);
  });
}
export default function AcoshTest() {
  describe("AcoshTest", () => {
    beforeAll(() => {
      console.info("beforeAll: Prerequisites at the test suite level, which are executed before the test suite is executed.");
    });
    beforeEach(async () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_ACOSH_0100
     * @tc.name      : testAcosh0001
     * @tc.desc      : Test acosh
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testAcosh0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 40,
        rounding: 4,
        toExpNeg: -9e15,
        toExpPos: 9e15,
        minE: -9e15,
        maxE: 9e15
      });
      test_acosh_001('NaN', 40, 4, 'NaN');
      test_acosh_001('0.9999999999999999999999999', 40, 4, 'NaN');
      test_acosh_001('0', 40, 4, 'NaN');
      test_acosh_001('-1', 40, 4, 'NaN');
      test_acosh_001('-Infinity', 40, 4, 'NaN');
      test_acosh_001('1', 40, 4, '0');
      test_acosh_001('Infinity', 40, 4, 'Infinity');
      test_acosh_001('3.3', 2, 4, '1.9');
      test_acosh_001('4608888.8834', 7, 1, '16.03664');
      test_acosh_001('145005612624726799', 7, 1, '40.20869');
      test_acosh_001('644444444487588842435356055860541441083823652904922222222222222', 2, 6, '150');
      test_acosh_001('9.28', 1, 5, '3');
      test_acosh_001('76', 10, 0, '5.023837236');
      test_acosh_001('28099999969999999491999992999999999999.9999999999999939697', 4, 1, '86.92');
      test_acosh_001('585287364', 7, 6, '20.88076');
      test_acosh_001('7', 3, 1, '2.63');
      test_acosh_001('43999099999999099999999999999999999997999999999999999999999990993999999.999099999999999699999', 10, 1, '163.3556877');
      test_acosh_001('557921.15371560132973597030139633138927112983', 9, 2, '13.9251202');
      test_acosh_001('222222270476', 7, 1, '26.82009');
      test_acosh_001('9925', 4, 2, '9.896');
      test_acosh_001('51156203358371111111111111111111.88888888888888185816094145162589', 5, 0, '73.706');
      test_acosh_001('920.33', 5, 5, '7.5179');
      test_acosh_001('398.29', 4, 0, '6.681');
      test_acosh_001('300000000000000000000000', 8, 4, '54.751217');
      test_acosh_001('2077', 8, 2, '8.331827');
      test_acosh_001('466660000000000000000000.666663813047981223086678888888888888', 5, 2, '55.194');
      test_acosh_001('1481.596575', 2, 0, '8');
      test_acosh_001('51843625827420648103724841829104208766358144', 6, 4, '101.35');
      test_acosh_001('66.49', 6, 6, '4.89014');
      test_acosh_001('30564048384', 13, 1, '24.83623744632');
      test_acosh_001('7', 48, 1, '2.63391579384963341725009269461593688805396394293');
      test_acosh_001('97574340', 32, 2, '19.08927228754035088993028581182');
      test_acosh_001('59258006', 62, 4, '18.590558631774124907454170672852196556349238888846297909065851');
      test_acosh_001('2', 29, 1, '1.3169578969248167086250463473');
      test_acosh_001('47824727144130804625931275592321416135112742535362856133451607743134653532851722527764075063.55842730879104516021234131120280682177076228198214593563443436114750010543987134572764385', 33, 3, '211.793348360036258224908114351528');
      test_acosh_001('28888888888888888888005555555555', 63, 4, '73.1341570240606241766246193827749684596026580789070620470111545');
      test_acosh_001('53333333332333333333333333333333333333333.3333333333238', 44, 1, '94.470527333874694216410397776492923242508444');
      test_acosh_001('372499047371205457405389940445944981761906694426814657494361227129962080514219995743180551139499492754067', 40, 4, '241.4770611463762121239476457202278064235');
      test_acosh_001('2800646674524111760613114531', 29, 6, '63.892795037101476241199480935');
      test_acosh_001('582502684111672632668804', 18, 4, '55.4147679267811784');
      test_acosh_001('59.9999999999194977', 38, 3, '4.7874222911013468319935340554530121378');
      test_acosh_001('3623643157643492007800000000000000000', 54, 0, '84.8736904452442702624435580686958522860590865192215031');
      test_acosh_001('23885562764027262', 28, 1, '38.40519778343449888592577782');
      test_acosh_001('676263', 32, 1, '14.117484513177343902058185404775');
      test_acosh_001('47551685235102870485407214.46883446439928999925', 58, 1, '59.81700664210749659679029308727990790424880703317942061059');
      test_acosh_001('2082819111111111111111.66668634223026707142169092', 34, 6, '49.78115645138172332225379630123395');
      test_acosh_001('7531.926725308', 22, 5, '9.620053337431944749948');
      test_acosh_001('3100000000000000000000000000000000070000080000000000000000000300000000000000000000000000000000080', 6, 6, '222.873');
      test_acosh_001('49844937529139.9399', 55, 0, '32.23308523365993666498473649670539223213853202660291314');
      test_acosh_001('36666666666999999999999.91929310391451604503565774644', 28, 5, '52.64930221056830211957060803');
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_ACOSH_0200
     * @tc.name      : testAcosh0002
     * @tc.desc      : Test acosh
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testAcosh0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 40,
        rounding: 4,
        toExpNeg: -9e15,
        toExpPos: 9e15,
        minE: -9e15,
        maxE: 9e15
      });
      try {
        test_acosh_001('e11', 6, 6, '4.89014');
        expect(true).assertEqual(false);
      } catch (err) {
        expect(err.name).assertEqual(`BusinessError`);
        expect(err.code).assertEqual(401);
        expect(err.message).assertEqual(`The type of "test(str)" must be Hex/Binary/Octal. Received value is: e11`);
      }
    });
  });
}