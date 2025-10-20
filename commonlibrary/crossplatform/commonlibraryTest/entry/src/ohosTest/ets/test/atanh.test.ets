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
function test_atanh_001 (n: string, pr: number, rm: Rounding, expected: string) {
  Decimal.set ({ precision: pr, rounding: rm });
  expect(expected).assertEqual(Decimal.atanh(n).valueOf());
  expect(expected).assertEqual(new Decimal(n).atanh().valueOf());
}
async function Delay(delay: number): Promise<void> {
  return new Promise((resolve:Function)=>{
    setTimeout(()=>{
      resolve('Hello World!');
    },delay);
  });
}
export default function AtanhTest() {
  describe("AtanhTest", () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_ATANH_0100
     * @tc.name      : testAtanh0001
     * @tc.desc      : Test atanh
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testAtanh0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 40,
        rounding: 4,
        toExpNeg: -9e15,
        toExpPos: 9e15,
        minE: -9e15,
        maxE: 9e15
      });
      test_atanh_001('-0.63774941', 1, 4, '-0.8');
      test_atanh_001('0.1221481', 9, 0, '0.122761087');
      test_atanh_001('-0.17990274590466674', 7, 1, '-0.1818821');
      test_atanh_001('-0.6', 5, 6, '-0.69315');
      test_atanh_001('-0.6712743', 3, 3, '-0.814');
      test_atanh_001('-0.8', 9, 2, '-1.09861228');
      test_atanh_001('0.034059491123193', 10, 5, '0.03407267052');
      test_atanh_001('0.971383207580654133272', 2, 6, '2.1');
      test_atanh_001('-0.4', 5, 5, '-0.42365');
      test_atanh_001('0.7', 8, 2, '0.86730053');
      test_atanh_001('0.4206840645836230484032786410995', 2, 2, '0.45');
      test_atanh_001('0.11657', 3, 0, '0.118');
      test_atanh_001('-0.06', 1, 4, '-0.06');
      test_atanh_001('0.8679596950069114083213661', 5, 4, '1.3247');
      test_atanh_001('-0.895165912892044', 7, 0, '-1.447342');
      test_atanh_001('-0.24549498277000856006664760772730973', 10, 0, '-0.2506131893');
      test_atanh_001('0.003434934411074', 9, 2, '0.00343494793');
      test_atanh_001('0.8', 10, 2, '1.098612289');
      test_atanh_001('0.9', 6, 5, '1.47222');
      test_atanh_001('-0.35115', 4, 6, '-0.3668');
      test_atanh_001('-0.07006008', 9, 1, '-0.0701750467');
      test_atanh_001('-0.805588217169184404803545', 7, 3, '-1.114332');
      test_atanh_001('0.035042192', 55, 2, '0.0350565459913177073622482641959208402405964262615529299');
      test_atanh_001('-0.27398', 41, 6, '-0.2811617873835199297281322455211358234326');
      test_atanh_001('-0.4860194', 77, 4, '-0.53083537941098533673177663090557161489026982518920257398555815069258399000671');
      test_atanh_001('-0.24023148147547753705876525534786727823', 64, 6, '-0.2450197568943221990022234155266189427014650372890460086779371601');
      test_atanh_001('0.6011860402795', 70, 1, '0.6950024335022886924643340340622320956358285387350047592361304767363335');
      test_atanh_001('-0.29093', 44, 2, '-0.29958195778891861736095524290964866810281107');
      test_atanh_001('0.266818124020332161434635904184413087903', 70, 6, '0.2734349124503902665106317554881156645559479073060421002241446128732386');
      test_atanh_001('-0.432531956714370232077', 6, 4, '-0.463007');
      test_atanh_001('-0.12287097619204275583897636378879', 2, 1, '-0.12');
      test_atanh_001('0.2897036197075545', 60, 6, '0.298242699414791823529878292721126830768439530743706217501737');
      test_atanh_001('-0.2655773613852928593375285', 77, 0, '-0.27209952218398509029158426102152882183064360960300836509805625022650344274319');
      test_atanh_001('0.5735882938793959782751026397687223000311120959777492896023791205', 33, 5, '0.65285425106191064820540169018885');
      test_atanh_001('0.7426414548', 23, 4, '0.95634354421618813937091');
      test_atanh_001('0.79326', 64, 1, '1.080164253158982312196251050504784270125752587840009002471824728');
      test_atanh_001('0.1991301120855576845', 79, 4, '0.2018265847477406706392428533389908448862292415015902102343859228007472489793578');
      test_atanh_001('0.58575026964988311327717364047728706968432384708442439806628335397331041029', 35, 4, '0.67117196259416045496400738728525138');
      test_atanh_001('-0.6382435885085400741', 52, 5, '-0.7552044376964453055912660622103201093353424263040963');
      test_atanh_001('-0.1937766857572633836824102902726660707344', 65, 0, '-0.19625823857879391217692284026627503312320392329436359124182475746');
      test_atanh_001('-0.77329685', 58, 3, '-1.028477133857644453547320325736890284496863994792903106468');
      test_atanh_001('-0.38935628384', 30, 0, '-0.411041070277527417008424457354');
      test_atanh_001('-0.514', 10, 3, '-0.5681509051');
      test_atanh_001('0.958729982986459836771826622473322363124574975404328744', 21, 1, '1.92995765916231006555');
      test_atanh_001('0.46401438080114898349', 52, 1, '0.5024150932833156698557467674808132274481991616651669');
      test_atanh_001('0.5989023538423641713709183', 71, 2, '0.69143386983135895477423195223524769608010916945045113248577167194266556');
      test_atanh_001('-0.03651542020603455193763551331484375543974794103475847308026587749101823431', 59, 6, '-0.036531662796419796028369200191680396653704276902211463476447');
      test_atanh_001('-0.33', 51, 2, '-0.342828254415393852722154089483655258153765543829547');
      test_atanh_001('-0.127827075266907724285915869037463706439', 80, 1, '-0.1285302029045167436793945158211468632668697124786207606960739918130299633916413');
      test_atanh_001('0.7847923398129302653846940761', 14, 2, '1.057726963944');
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_ATANH_0200
     * @tc.name      : testAtanh0002
     * @tc.desc      : Test atanh
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testAtanh0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 40,
        rounding: 4,
        toExpNeg: -9e15,
        toExpPos: 9e15,
        minE: -9e15,
        maxE: 9e15
      });
      try {
        test_atanh_001('e1', 10, 3, '-0.5681509051');
        expect(true).assertEqual(false);
      } catch (err) {
        expect(err.name).assertEqual(`BusinessError`);
        expect(err.code).assertEqual(401);
        expect(err.message).assertEqual(`The type of "test(str)" must be Hex/Binary/Octal. Received value is: e1`);
      }
    });
  });
}