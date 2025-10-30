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
function test_asinh_001 (n: string, pr: number, rm: Rounding, expected: string) {
  Decimal.set ({ precision: pr, rounding: rm });
  expect(expected).assertEqual(Decimal.asinh(n).valueOf());
  expect(expected).assertEqual(new Decimal(n).asinh().valueOf());
}

function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function AsinhTest() {
  describe("AsinhTest", () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_ASINH_0100
     * @tc.name      : testAsinh0001
     * @tc.desc      : Test asinh
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testAsinh0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 40,
        rounding: 4,
        toExpNeg: -9e15,
        toExpPos: 9e15,
        minE: -9e15,
        maxE: 9e15
      });
      test_asinh_001('NaN', 40, 4, 'NaN');
      test_asinh_001('Infinity', 40, 4, 'Infinity');
      test_asinh_001('-Infinity', 40, 4, '-Infinity');
      test_asinh_001('0', 40, 4, '0');
      test_asinh_001('-0', 40, 4, '-0');
      test_asinh_001('3.1444197343', 4, 3, '1.863');
      test_asinh_001('-7546164.80347805747707434691023987685', 5, 2, '-16.529');
      test_asinh_001('-0.15139', 9, 1, '-0.150817601');
      test_asinh_001('7649', 8, 2, '9.6354774');
      test_asinh_001('9522664768544403839474412593333.0574738', 8, 6, '72.024375');
      test_asinh_001('7979240.25859873', 3, 3, '16.5');
      test_asinh_001('268', 5, 2, '6.2842');
      test_asinh_001('-0.036', 2, 5, '-0.036');
      test_asinh_001('0.4807', 9, 3, '0.4638831');
      test_asinh_001('0.229', 10, 4, '0.2270443104');
      test_asinh_001('2.00400000074005', 7, 0, '1.445423');
      test_asinh_001('200000000000000.00004161', 6, 5, '33.6225');
      test_asinh_001('-58888888888888791888.6', 3, 0, '-46.3');
      test_asinh_001('-6031221', 3, 4, '-16.3');
      test_asinh_001('-640.3942', 7, 5, '-7.155232');
      test_asinh_001('14', 10, 4, '3.333477587');
      test_asinh_001('4', 2, 0, '2.1');
      test_asinh_001('0.03', 7, 0, '0.02999551');
      test_asinh_001('90', 1, 4, '5');
      test_asinh_001('5312357191358436060512320673773898993193725886736164185043184432297', 9, 5, '154.333799');
      test_asinh_001('7199699999999999999999999999999999999999999939998.999999990999999', 5, 3, '113.19');
      test_asinh_001('-882.444444444144444444494444440464444444494940444444244444', 5, 4, '-7.4758');
      test_asinh_001('-8', 13, 5, '-2.776472280724');
      test_asinh_001('-86000000000000000000.000000000000000000000005', 70, 0, '-46.59402615070627535463115294058075590852999710911467932978308270954662');
      test_asinh_001('-376.89', 48, 4, '-6.62510230823208343124289061224985909335679702244');
      test_asinh_001('96266757965567956426092817863148449', 5, 0, '81.246');
      test_asinh_001('7519.1832', 46, 1, '9.618359979005094092372581180036903865361423221');
      test_asinh_001('3111111111111111111111111113111111111111.111111111111161138', 73, 2, '91.62894574016671152726822536730571926386870493068213127138241128153116515');
      test_asinh_001('-8428702594578936542477442030434333806', 37, 5, '-85.71785338514359573130458501589518584');
      test_asinh_001('-729028279311299860.939180266635717461', 48, 6, '-41.8236360986491235923183022666827171650501445231');
      test_asinh_001('636378004660459076120.99604591124', 11, 4, '48.595471588');
      test_asinh_001('461967326081151345517140931535', 45, 1, '68.9984388572118740675493758006785202194685299');
      test_asinh_001('0.92', 17, 6, '0.82365909043241051');
      test_asinh_001('-230982323268609169145946104396150217.76896733458979187647947774685888534', 35, 0, '-82.120796434310525765547736423296875');
      test_asinh_001('-672211211111111111101111111111.1111111111111111111111111111131117111', 35, 5, '-69.373517284788400913185878628465723');
      test_asinh_001('0.00000060482048460767108485365525600300117458763457062849', 77, 2, '0.00000060482048460763421017663533424068534983602813406207303024723328078399099182286');
      test_asinh_001('-0.03384059130054301010037', 28, 4, '-0.03383413566704186353496859594');
      test_asinh_001('71984879069309', 42, 1, '32.6006243805224822843383423875877387660665');
      test_asinh_001('0.0900770980497960620934208869160426353386017063437926198857463084798514071501', 39, 0, '0.089955728166487127683719480764589414987');
      test_asinh_001('2844969', 19, 5, '15.55420990973386475');
      test_asinh_001('-356', 50, 1, '-6.5680798840106081722529702658569854797470604302438');
      test_asinh_001('-49.3', 14, 4, '-4.5911741056591');
      test_asinh_001('0.03933187411044072735132236169900601818974716', 8, 3, '0.03932174');
      test_asinh_001('-34170.3', 62, 0, '-11.132259305476110273648480940373325075775200555781318183293398');
      test_asinh_001('77.47574325137050802631', 52, 1, '5.043153724397571705290385521814303549847001281430545');
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_ASINH_0200
     * @tc.name      : testAsinh0002
     * @tc.desc      : Test asinh
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testAsinh0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 40,
        rounding: 4,
        toExpNeg: -9e15,
        toExpPos: 9e15,
        minE: -9e15,
        maxE: 9e15
      });
      try {
        test_asinh_001('e11', 14, 4, '-4.5911741056591');
        expect(true).assertEqual(false);
      } catch (err) {
        expect(err.name).assertEqual(`BusinessError`);
        expect(err.code).assertEqual(401);
        expect(err.message).assertEqual(`The type of "test(str)" must be Hex/Binary/Octal. Received value is: e11`);
      }
    });
  });
}