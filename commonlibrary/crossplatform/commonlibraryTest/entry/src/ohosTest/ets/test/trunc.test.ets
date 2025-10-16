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
function test_trunc_001 (expected: string, n: string) {
  expect(expected).assertEqual(Decimal.trunc(n).valueOf());
}
function test_trunc_002 (expected: string, n: number) {
  expect(expected).assertEqual(Decimal.trunc(n).valueOf());
}
export default function TruncTest() {
  describe("TruncTest", () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_TRUNC_0100
     * @tc.name      : testTrunc0001
     * @tc.desc      : Test trunc
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testTrunc0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 20,
        rounding: 4,
        toExpNeg: -1e3,
        toExpPos: 1e3,
        minE: -9e15,
        maxE: 9e15
      });
      test_trunc_002('0', 0);
      test_trunc_002('-0', -0);
      test_trunc_001('0', '0.000');
      test_trunc_002('Infinity', Infinity);
      test_trunc_002('-Infinity', -Infinity);
      test_trunc_002('NaN', NaN);
      test_trunc_002('0', 0.1);
      test_trunc_001('0', '0.49999999999999994');
      test_trunc_002('0', 0.5);
      test_trunc_002('0', 0.7);
      test_trunc_002('-0', -0.1);
      test_trunc_001('-0', '-0.49999999999999994');
      test_trunc_002('-0', -0.5);
      test_trunc_002('-0', -0.7);
      test_trunc_002('1', 1);
      test_trunc_002('1', 1.1);
      test_trunc_002('1', 1.5);
      test_trunc_002('1', 1.7);
      test_trunc_002('-1', -1);
      test_trunc_002('-1', -1.1);
      test_trunc_002('-1', -1.5);
      test_trunc_002('-1', -1.7);
      test_trunc_001('1', '1.9999999999');
      test_trunc_001('-1', '-1.9999999999');
      test_trunc_001('-2075364', '-2075364.364286541923');
      test_trunc_001('60593539780450631', '60593539780450631');
      test_trunc_001('65937898671515', '65937898671515');
      test_trunc_001('-39719494751819198566798', '-39719494751819198566798.578');
      test_trunc_001('92627382695288166556', '92627382695288166556.8683774524284866028260448205069');
      test_trunc_001('-881574', '-881574');
      test_trunc_001('-3633239209', '-3633239209.654526163275621746013315304191073405508491056');
      test_trunc_001('-23970335459820625362', '-23970335459820625362');
      test_trunc_001('131869457416154038', '131869457416154038');
      test_trunc_001('-4542227860', '-4542227860.9511298545226');
      test_trunc_001('2416872281', '2416872281.963955669484225137349193306323379254936827');
      test_trunc_001('-757684868752087594264588207655', '-757684868752087594264588207655.27838048392835556');
      test_trunc_001('-438798503526', '-438798503526.2317623894721299587561697');
      test_trunc_001('801625782231888715214665', '801625782231888715214665');
      test_trunc_001('327765350218284325239839632046', '327765350218284325239839632046.91682741746683081459605386');
      test_trunc_001('-7469045007691432294', '-7469045007691432294.362757245');
      test_trunc_001('8365540212937142194319515218789', '8365540212937142194319515218789.4106658678537421977827');
      test_trunc_001('-14108', '-14108.495051214515');
      test_trunc_001('49104501', '49104501.10055989379655329194309526150310568683504206945625');
      test_trunc_001('131370406', '131370406.330005158136313262837556068534122953');
      test_trunc_001('-689', '-689.6944252229740521128820354989299283');
      test_trunc_001('73441822178', '73441822178.572653');
      test_trunc_001('-2329', '-2329.42655772223486531483602927572548264457');
      test_trunc_001('-834103872107533086', '-834103872107533086');
      test_trunc_001('-1501493189970435', '-1501493189970435.74866616700317');
      test_trunc_001('70591', '70591.2244675522123484658978887');
      test_trunc_001('4446128540401735117', '4446128540401735117.435836700611264749985822486641350492901');
      test_trunc_001('-597273', '-597273');
      test_trunc_001('729117', '729117');
      test_trunc_001('-6581532150677269472829', '-6581532150677269472829.38194951340848938896000325718062365494');
      test_trunc_001('-131279182164804751', '-131279182164804751.430589952021038264');
      test_trunc_001('2949426983040959', '2949426983040959.8911208825380208568451907');
      test_trunc_001('25166', '25166.125888418871654557352055849116604612621573251770362');
      test_trunc_001('4560569286495', '4560569286495.98300685103599898554605198');
      test_trunc_001('13', '13.763105480576616251068323541559825687');
      test_trunc_001('9050999219306', '9050999219306.7846946346757664893036971777');
      test_trunc_001('20962819101135667464733349383', '20962819101135667464733349383.8959025798517496777183');
      test_trunc_001('4125789711001606948191', '4125789711001606948191.4707575965791242737346836');
      test_trunc_001('-6935501', '-6935501.294727166142750626019282');
      test_trunc_001('-1', '-1.518418076611593764852321765899');
      test_trunc_001('6912783515683955988122411164548', '6912783515683955988122411164548.393');
      test_trunc_001('657', '657.0353902852');
      test_trunc_001('0', '0.00000000000000000000000017921822306362413915');
      test_trunc_001('1483059355427939255846407887', '1483059355427939255846407887.011361095342689876');
      test_trunc_001('8551283060956479352', '8551283060956479352.5707396');
      test_trunc_001('0', '0.000000000000000000000000019904267');
      test_trunc_001('321978830777554620127500539', '321978830777554620127500539.339278568133088682532238002577');
      test_trunc_001('2073', '2073.532654804291079327244387978249477171032485250998396');
      test_trunc_001('677676305591', '677676305591.2');
      test_trunc_001('0', '0.0000000000006');
      test_trunc_001('39181479479778357', '39181479479778357');
      test_trunc_001('0', '0.00000000000000000087964700066672916651');
      test_trunc_001('896', '896');
      test_trunc_001('115083055948552475', '115083055948552475');
      test_trunc_001('9105942082143427451223', '9105942082143427451223');
      test_trunc_001('0', '0.0000000000000009');
      test_trunc_001('0', '0.00000000000000000000004');
      test_trunc_001('0', '0.000250427721966583680168028884692015623739');
      test_trunc_001('0', '0.000000000001585613219016120158734661293405081934');
      test_trunc_001('0', '0.000000090358252973411013592234');
      test_trunc_001('276312604693909858427', '276312604693909858427.21965306055697011390137926559');
      test_trunc_001('0', '0.0000252');
      Decimal.set({ toExpNeg: -100, toExpPos: 100 });
      test_trunc_002('-0', -1e-308);
      test_trunc_002('-1e+308', -1e308);
      test_trunc_001('2.1e+308', '2.1e308');
      test_trunc_001('-0', '-1e-999');
      test_trunc_001('0', '1e-999');
      test_trunc_001('0', '1e-9000000000000000');
      test_trunc_001('-0', '-1e-9000000000000000');
      test_trunc_001('-0', '-9.9e-9000000000000001');
      test_trunc_001('9.999999e+9000000000000000', '9.999999e+9000000000000000');
      test_trunc_001('-9.999999e+9000000000000000', '-9.999999e+9000000000000000');
      test_trunc_001('Infinity', '1E9000000000000001');
      test_trunc_001('-Infinity', '-1e+9000000000000001');
      test_trunc_001('5.5879983320336874473209567979e+287894365', '5.5879983320336874473209567979e+287894365');
      test_trunc_001('-5.5879983320336874473209567979e+287894365', '-5.5879983320336874473209567979e+287894365');
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_TRUNC_0200
     * @tc.name      : testTrunc0002
     * @tc.desc      : Test trunc
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testTrunc0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 20,
        rounding: 4,
        toExpNeg: -1e3,
        toExpPos: 1e3,
        minE: -9e15,
        maxE: 9e15
      });
      try {
        test_trunc_001('e', 'e11');
        expect(true).assertEqual(false);
      } catch (err) {
        expect(err.name).assertEqual(`BusinessError`);
        expect(err.code).assertEqual(401);
        expect(err.message).assertEqual(`The type of "test(str)" must be Hex/Binary/Octal. Received value is: e11`);
      }
    });
  });
}