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
function test_acos_001 (n: string, pr: number, rm: Rounding, expected: string) {
  Decimal.set ({ precision: pr, rounding: rm });
  expect(expected).assertEqual(Decimal.acos(n).valueOf());
  expect(expected).assertEqual(new Decimal(n).acos().valueOf());
}
async function Delay(delay: number): Promise<void> {
  return new Promise((resolve:Function)=>{
    setTimeout(()=>{
      resolve('Hello World!');
    },delay);
  });
}
export default function AcosTest() {
  describe("AcosTest", () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_ACOS_0100
     * @tc.name      : testAcos0001
     * @tc.desc      : Test acos
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testAcos0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 40,
        rounding: 4,
        toExpNeg: -9e15,
        toExpPos: 9e15,
        minE: -9e15,
        maxE: 9e15
      });
      test_acos_001('NaN', 40, 4, 'NaN');
      test_acos_001('Infinity', 40, 4, 'NaN');
      test_acos_001('-Infinity', 40, 4, 'NaN');
      test_acos_001('1.0000000000000001', 40, 4, 'NaN');
      test_acos_001('2', 40, 4, 'NaN');
      test_acos_001('-1.0000000000000001', 40, 4, 'NaN');
      test_acos_001('-2', 40, 4, 'NaN');
      test_acos_001('1', 40, 4, '0');
      test_acos_001('-1', 40, 4, '3.141592653589793238462643383279502884197');
      test_acos_001('0', 20, 4, '1.5707963267948966192');
      test_acos_001('-0', 20, 4, '1.5707963267948966192');
      test_acos_001('-0.6403', 7, 1, '2.265685');
      test_acos_001('-0.53', 2, 2, '2.2');
      test_acos_001('0.4396178420823739355530719404', 10, 0, '1.115623176');
      test_acos_001('0.496420101927875989152448746035981', 1, 5, '1');
      test_acos_001('0.1', 2, 0, '1.5');
      test_acos_001('-0.20878679', 6, 2, '1.78114');
      test_acos_001('-0.541191262571486130575708261722416873899', 6, 5, '2.14265');
      test_acos_001('0.5', 7, 1, '1.047197');
      test_acos_001('-0.409325859', 10, 2, '1.992511392');
      test_acos_001('0.551', 5, 6, '0.98723');
      test_acos_001('0.5', 7, 2, '1.047198');
      test_acos_001('-0.43419432724217379874620877899386037437997149166291587557428756984642427', 3, 1, '2.01');
      test_acos_001('0.553', 9, 3, '0.984835716');
      test_acos_001('0.7809790373261734623688348400648923431479560079817', 6, 1, '0.674564');
      test_acos_001('0.75824031', 9, 0, '0.710186479');
      test_acos_001('-0.8', 8, 2, '2.4980916');
      test_acos_001('0.0799', 3, 5, '1.49');
      test_acos_001('-0.38393812134692277325859', 4, 1, '1.964');
      test_acos_001('-0.3907773773285398604336', 1, 1, '1');
      test_acos_001('-0.69992716948032572772435', 9, 4, '2.34609185');
      test_acos_001('-0.66158215731029676878636733180177567', 8, 0, '2.2937231');
      test_acos_001('0.9147368246772431874', 37, 1, '0.415940230269184272745464503534348965');
      test_acos_001('-0.4553', 27, 1, '2.04350546255828224507689468');
      test_acos_001('-0.028011903303708804768053896701975443', 56, 1, '1.5988118947274791447123927148057628240666865110752680848');
      test_acos_001('0.4065777430651635458256706', 14, 6, '1.1520912372989');
      test_acos_001('-0.78468834561401325', 40, 6, '2.472989536549809027410129361828086088366');
      test_acos_001('-0.04164046779', 31, 2, '1.61244883758340629332195244831');
      test_acos_001('-0.117424541', 82, 1, '1.688492407881140013543521665402011226342602786603530341844248637463449252725522796');
      test_acos_001('-0.1870116529272128766435079579825546176806042554995693356583', 108, 6, '1.75891557205606890020875163685374748628399727002149491921316335140511350243361347958082966501905347526802867');
      test_acos_001('0.0769104749433424068', 66, 1, '1.49380982556189042854757067055954756775240858876530364274625200666');
      test_acos_001('-0.027096519359', 92, 3, '1.5978961630571391095050365835267438779450813578907877311954803581546591891147373364143685647');
      test_acos_001('-0.8', 33, 6, '2.49809154479650885165983415456218');
      test_acos_001('0.67487482885692802659376964747029780872121304015294984476148189310252027478897761772', 54, 3, '0.830001261924669662461861851080065080704764574011647298');
      test_acos_001('-0.0804595260228093312276197203', 26, 1, '1.6513429189757672993077865');
      test_acos_001('0.50408248676517825230780010554261667827445182236535818843176765834864294167168', 73, 4, '1.042477051429539838709819977914186923616698698550378124843462531977088459');
      test_acos_001('0.92980935280344761170800142822446189257', 42, 0, '0.376901826310506133287494991222901254976804');
      test_acos_001('0.41923186648524998285699814886092351368793359300547574', 42, 3, '1.13819724675000902666504291062053681280681');
      test_acos_001('-0.19508761025300975791021816036', 27, 1, '1.76714310275532020878366926');
      test_acos_001('0.0623252416', 19, 0, '1.508430664767542249');
      test_acos_001('0.9999999297625', 14, 4, '0.00037479994883195');
      test_acos_001('0.99999999467518', 14, 4, '0.0001031970930281');
      test_acos_001('0.9999999999999999995', 25, 4, '0.000000001000000000000000000041667');
      test_acos_001('0.99999999999999999999995', 30, 4, '0.0000000000100000000000000000000000416667');
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_ACOS_0200
     * @tc.name      : testAcos0002
     * @tc.desc      : Test acos
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testAcos0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 40,
        rounding: 4,
        toExpNeg: -9e15,
        toExpPos: 9e15,
        minE: -9e15,
        maxE: 9e15
      });
      try {
        test_acos_001('e', 40, 4, 'NaN');
        expect(true).assertEqual(false);
      } catch (err) {
        expect(err.name).assertEqual(`BusinessError`);
        expect(err.code).assertEqual(401);
        expect(err.message).assertEqual(`The type of "test(str)" must be Hex/Binary/Octal. Received value is: e`);
      }
    });
  });
}