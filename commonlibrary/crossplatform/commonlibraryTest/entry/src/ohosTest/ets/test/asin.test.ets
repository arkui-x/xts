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
function test_asin_001 (n: string, pr: number, rm: Rounding, expected: string) {
  Decimal.set ({ precision: pr, rounding: rm });
  expect(expected).assertEqual(Decimal.asin(n).valueOf());
  expect(expected).assertEqual(new Decimal(n).asin().valueOf());
}
async function Delay(delay: number): Promise<void> {
  return new Promise((resolve:Function)=>{
    setTimeout(()=>{
      resolve('Hello World!');
    },delay);
  });
}
export default function AsinTest() {
  describe("AsinTest", () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_ASIN_0100
     * @tc.name      : testAsin0001
     * @tc.desc      : Test asin
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testAsin0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 40,
        rounding: 4,
        toExpNeg: -9e15,
        toExpPos: 9e15,
        minE: -9e15,
        maxE: 9e15
      });
      test_asin_001('NaN', 40, 4, 'NaN');
      test_asin_001('1.0000000000000001', 40, 4, 'NaN');
      test_asin_001('2', 40, 4, 'NaN');
      test_asin_001('Infinity', 40, 4, 'NaN');
      test_asin_001('-1.00000000000000000001', 40, 4, 'NaN');
      test_asin_001('-Infinity', 40, 4, 'NaN');
      test_asin_001('0', 40, 4, '0');
      test_asin_001('-0', 40, 4, '-0');
      test_asin_001('0.365496185994558260858326718937', 10, 5, '0.3741658147');
      test_asin_001('-0.35641389188', 3, 0, '-0.365');
      test_asin_001('0.68955841424562468594284036990178287693727890663761450264565153347585586987783918662506831', 7, 6, '0.7608791');
      test_asin_001('-0.8185571137226394757008542835605396', 1, 1, '-0.9');
      test_asin_001('0.3909767220307331413111', 5, 3, '0.40169');
      test_asin_001('0.4973777625990946249943842344354278064648780030532232700989739966171872596183742540844', 7, 0, '0.5205736');
      test_asin_001('-0.3220586075', 7, 1, '-0.3279031');
      test_asin_001('-0.4712856183846410563097510893908', 6, 5, '-0.490748');
      test_asin_001('0.05838677605449046055272817746189607969418472098217185904914', 2, 6, '0.058');
      test_asin_001('0.8', 9, 5, '0.927295218');
      test_asin_001('-0.35', 4, 5, '-0.3576');
      test_asin_001('0.5', 10, 1, '0.5235987755');
      test_asin_001('0.12', 3, 1, '0.12');
      test_asin_001('-0.5434', 8, 3, '-0.57448199');
      test_asin_001('0.0073911', 6, 1, '0.00739116');
      test_asin_001('0.6413', 9, 5, '0.696191343');
      test_asin_001('0.6695', 7, 5, '0.7335355');
      test_asin_001('-0.73867', 9, 0, '-0.831095123');
      test_asin_001('-0.734541962948526931', 1, 1, '-0.8');
      test_asin_001('0.8124222852789144395978469359524044494', 9, 5, '0.94829454');
      test_asin_001('0.01', 6, 1, '0.0100001');
      test_asin_001('-0.788421', 4, 1, '-0.9082');
      test_asin_001('-0.3', 2, 2, '-0.3');
      test_asin_001('0.6608633389456637408497420998651914114139088612446', 2, 4, '0.72');
      test_asin_001('0.3931549079701655746240375417718660050381124496506720523996527133505517587998', 23, 1, '0.40406030213304057779811');
      test_asin_001('-0.587605525487010465245800314956501132921', 13, 3, '-0.6280963940928');
      test_asin_001('-0.5', 52, 3, '-0.5235987755982988730771072305465838140328615665625177');
      test_asin_001('0.7772699', 16, 4, '0.8903148827665578');
      test_asin_001('-0.449412073227066332425902525593181', 57, 6, '-0.466107096571843683526424227582248251927561787620454186534');
      test_asin_001('-0.88842', 56, 4, '-1.0938915908813483958517153077667620622507918440274546335');
      test_asin_001('-0.5088737561', 24, 3, '-0.533875977309913500769379');
      test_asin_001('-0.0765762285855571311226935212468317451162677', 61, 0, '-0.07665126622547200709328366279959297473262965998499827526363485');
      test_asin_001('0.002058774932399380728', 73, 3, '0.002058776386773685135920502914113033566749664057124819063683489089253866675');
      test_asin_001('0.6191705648197127900333', 20, 3, '0.6676860026273445248');
      test_asin_001('0.0451', 71, 3, '0.045115302986200826677187000097752946920986469377743210302486079583770366');
      test_asin_001('0.156883637', 65, 6, '0.15753442001936249496738123179710495311489551498086102245485050903');
      test_asin_001('0.163388332624365770456915424679194860444773341061114349237610212142206187981629282902', 67, 0, '0.1641241692993679299065215302292638564718643006858786702204768697199');
      test_asin_001('-0.1958', 17, 5, '-0.19707317438982823');
      test_asin_001('0.873332', 19, 5, '1.062001065132184521');
      test_asin_001('-0.8517325896144402', 29, 0, '-1.0192830764340094095462711303');
      test_asin_001('-0.5110799', 65, 2, '-0.53644070128325494453237503822033662227949443391067147724566337039');
      test_asin_001('-0.579334355419195148', 31, 3, '-0.617911801796609232511609252874');
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_ASIN_0200
     * @tc.name      : testAsin0002
     * @tc.desc      : Test asin
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testAsin0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 40,
        rounding: 4,
        toExpNeg: -9e15,
        toExpPos: 9e15,
        minE: -9e15,
        maxE: 9e15
      });
      try {
        test_asin_001('e', 19, 5, '1.062001065132184521');
        expect(true).assertEqual(false);
      } catch (err) {
        expect(err.name).assertEqual(`BusinessError`);
        expect(err.code).assertEqual(401);
        expect(err.message).assertEqual(`The type of "test(str)" must be Hex/Binary/Octal. Received value is: e`);
      }
    });
  });
}