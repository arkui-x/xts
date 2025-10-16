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
function test_toPrecision_001 (expected: string, n: string, sd: number, rm: Rounding) {
  expect(expected).assertEqual(new Decimal(n).toPrecision(sd, rm));
}
function test_toPrecision_002 (expected: string, n: number, sd: number, rm: Rounding) {
  expect(expected).assertEqual(new Decimal(n).toPrecision(sd, rm));
}
export default function ToPrecisionTest() {
  describe("ToPrecisionTest", () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_TO_PRECISION_0100
     * @tc.name      : testToPrecision0001
     * @tc.desc      : Test toPrecision
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testToPrecision0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 20,
        rounding: 4,
        toExpNeg: -7,
        toExpPos: 40,
        minE: -9e15,
        maxE: 9e15
      });
      Decimal.set({ rounding: 0});
      test_toPrecision_002('1e+4', 9631.01, 1, 4);
      test_toPrecision_002('1.0e+7', 9950095.87, 2, 4);
      test_toPrecision_001('1e+1', '9.856839969', 1, 4);
      test_toPrecision_001('1e+2', '97.504', 1, 4);
      test_toPrecision_002('1e+5', 97802.6, 1, 4);
      test_toPrecision_002('1e+1', 9.9617, 1, 4);
      test_toPrecision_002('1e+3', 989.2, 1, 4);
      test_toPrecision_002('1.0e+5', 99576, 2, 4);
      test_toPrecision_001('1e+8', '96236483.87', 1, 4);
      Decimal.set({ rounding: 1});
      test_toPrecision_001('-1.4e+9', '-1336106841', 2, 0);
      test_toPrecision_001('-2244450.2134814273335263', '-2244450.2134814273335262397290334104071203538487453309626146', 23, 0);
      test_toPrecision_001('8.74e+29', '873625255363763952428129881990.679929486040461455296118489', 3, 0);
      test_toPrecision_001('-1.85453549733179613185923288786', '-1.8545354973317961318592328878502252820666161607740183', 30, 0);
      test_toPrecision_001('431.7150651927', '431.71506519265522010949747887049', 13, 0);
      test_toPrecision_001('-8606297211156287.52520023752564', '-8606297211156287.5252002375256362382564355963505470716151', 30, 0);
      test_toPrecision_001('-8.4634889709e+24', '-8463488970828351722405003.220603', 11, 0);
      Decimal.set({ rounding: 2});
      test_toPrecision_001('5.80e+18', '5805164734299168659.6173113885173384955443', 3, 1);
      test_toPrecision_001('-1.719875889271327', '-1.719875889271327133154458155573493605566221534', 16, 1);
      test_toPrecision_001('113.672129563', '113.672129563441659725876055771857758675550104070419635029', 12, 1);
      test_toPrecision_001('-77950052814622081084397.9', '-77950052814622081084397.91853869253589242574', 24, 1);
      test_toPrecision_001('4.53106985e+27', '4531069852787151785292512309.2901993579425172826443679877', 9, 1);
      test_toPrecision_001('45285.246089613169416440797840714', '45285.2460896131694164407978407142422013937', 32, 1);
      test_toPrecision_001('307760226411464.7333268079863299', '307760226411464.73332680798632996332324381779707', 31, 1);
      Decimal.set({ rounding: 3});
      test_toPrecision_001('-1.7218673528e+29', '-172186735288586033321621121024.11240623', 11, 2);
      test_toPrecision_001('-3.31e+28', '-33197729862068219255677464974', 3, 2);
      test_toPrecision_001('-4.835191326e+29', '-483519132605694848658321267839.23575134378118945659616358', 10, 2);
      test_toPrecision_001('7.3', '7.24882150443803', 2, 2);
      test_toPrecision_001('-89186640077683569.407061427673', '-89186640077683569.4070614276736450982125609', 29, 2);
      test_toPrecision_001('-49379651041268.5', '-49379651041268.548293', 15, 2);
      test_toPrecision_001('-7685054.17489171951660', '-7685054.17489171951660508194254495141726065698575306365447451', 21, 2);
      Decimal.set({ rounding: 4});
      test_toPrecision_001('687378946204028.408158998985701', '687378946204028.408158998985701430935094', 30, 3);
      test_toPrecision_001('42.452', '42.4523909443358871476552683504968536100051', 5, 3);
      test_toPrecision_001('-22771061110217019663705702.44170142085172', '-22771061110217019663705702.44170142085171219649140996', 40, 3);
      test_toPrecision_001('-1470.640309974016167512235698629586', '-1470.6403099740161675122356986295857257144815364', 34, 3);
      test_toPrecision_001('-1.110228e+27', '-1110227398804733429555663947.06619', 7, 3);
      test_toPrecision_001('-6.4898237111e+26', '-648982371105405071851661301', 11, 3);
      test_toPrecision_001('-4641197449469148.658850361201903', '-4641197449469148.658850361201902222', 31, 3);
      Decimal.set({ rounding: 5});
      test_toPrecision_001('-8e+26', '-786589693451258754942279859.3834', 1, 4);
      test_toPrecision_001('-26.0', '-26', 3, 4);
      test_toPrecision_001('-8.462226728e+11', '-846222672789.2087639320702375427266333530942524245', 10, 4);
      test_toPrecision_001('-4e-7', '-0.0000004019666978288041783154210868', 1, 4);
      test_toPrecision_001('-315609.775843992', '-315609.775843992', 15, 4);
      test_toPrecision_001('-3.319e+9', '-3318880945', 4, 4);
      test_toPrecision_001('-6', '-6.2847', 1, 4);
      Decimal.set({ rounding: 6});
      test_toPrecision_001('42334337596496149636254', '42334337596496149636254.4926162509306406461', 23, 5);
      test_toPrecision_001('-7e+9', '-7246374971.34279698356', 1, 5);
      test_toPrecision_001('71516263932998764871838469072', '71516263932998764871838469072.280115355524', 29, 5);
      test_toPrecision_001('71257489.5995227415169007618702182092', '71257489.59952274151690076187021820922744', 36, 5);
      test_toPrecision_001('268492835', '268492834.77041', 9, 5);
      test_toPrecision_001('50325.551277778107847798802', '50325.551277778107847798801525', 26, 5);
      test_toPrecision_001('-5.289303987e+29', '-528930398665449048343281311623.69686', 10, 5);
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_TO_PRECISION_0200
     * @tc.name      : testToPrecision0002
     * @tc.desc      : Test toPrecision
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testToPrecision0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 20,
        rounding: 4,
        toExpNeg: -7,
        toExpPos: 40,
        minE: -9e15,
        maxE: 9e15
      });
      try {
        test_toPrecision_001('-6', '-6.2847', 1e10, 4);
        expect(true).assertEqual(false);
      } catch (err) {
        expect(err.name).assertEqual(`BusinessError`);
        expect(err.code).assertEqual(10200001);
        expect(err.message).assertEqual(`The value of "10000000000" is out of range. It must be >= 1 && <= 1000000000 . Received value is: 10000000000`);
      }
    });
  });
}