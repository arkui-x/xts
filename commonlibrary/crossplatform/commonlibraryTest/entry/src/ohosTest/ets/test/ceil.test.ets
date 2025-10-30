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

function test_ceil_001 (expected: string, n: number) {
  expect(expected).assertEqual(Decimal.ceil(n).valueOf());
  expect(expected).assertEqual(new Decimal(n).ceil().valueOf());
}
function test_ceil_002 (expected: string, n: string) {
  expect(expected).assertEqual(Decimal.ceil(n).valueOf());
  expect(expected).assertEqual(new Decimal(n).ceil().valueOf());
}
function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function CeilTest() {
  describe("CeilTest", () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_CEIL_0100
     * @tc.name      : testCeil0001
     * @tc.desc      : Test ceil
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testCeil0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 20,
        rounding: 4,
        toExpNeg: -100,
        toExpPos: 100,
        minE: -9e15,
        maxE: 9e15
      });
      test_ceil_001('0', 0);
      test_ceil_001('-0', -0);
      test_ceil_001('Infinity', Infinity);
      test_ceil_001('-Infinity', -Infinity);
      test_ceil_001('NaN', NaN);
      test_ceil_001('1', 0.1);
      test_ceil_002('1', '0.4999999999999999');
      test_ceil_001('1', 0.5);
      test_ceil_001('1', 0.7);
      test_ceil_001('-0', -0.1);
      test_ceil_002('-0', '-0.4999999999999999');
      test_ceil_001('-0', -0.5);
      test_ceil_001('-0', -0.7);
      test_ceil_001('1', 1);
      test_ceil_001('2', 1.1);
      test_ceil_001('2', 1.5);
      test_ceil_001('2', 1.7);
      test_ceil_001('-1', -1);
      test_ceil_001('-1', -1.1);
      test_ceil_001('-1', -1.5);
      test_ceil_001('-1', -1.7);
      test_ceil_002('-0', '-0.999');
      test_ceil_002('2', '1.0000000000000000001');
      test_ceil_002('2', '1.0000000000000000000000000000000000000000000000000000000000000000000000000000001');
      test_ceil_002('1', '1e-9000000000000000');
      test_ceil_002('-0', '-1e-9000000000000000');
      test_ceil_002('-0', '-9.9e-9000000000000001');
      test_ceil_002('9.999999e+9000000000000000', '9.999999e+9000000000000000');
      test_ceil_002('-9.999999e+9000000000000000', '-9.999999e+9000000000000000');
      test_ceil_002('-Infinity', '-1e+9000000000000001');
      test_ceil_002('5.5879983320336874473209567979e+287894365', '5.5879983320336874473209567979e+287894365');
      test_ceil_002('-5.5879983320336874473209567979e+287894365', '-5.5879983320336874473209567979e+287894365');
      test_ceil_002('-2075364', '-2075364.364286541923');
      test_ceil_002('60593539780450631', '60593539780450631');
      test_ceil_002('65937898671515', '65937898671515');
      test_ceil_002('-39719494751819198566798', '-39719494751819198566798.578');
      test_ceil_002('92627382695288166557', '92627382695288166556.8683774524284866028260448205069');
      test_ceil_002('-881574', '-881574');
      test_ceil_002('-3633239209', '-3633239209.654526163275621746013315304191073405508491056');
      test_ceil_002('321978830777554620127500540', '321978830777554620127500539.339278568133088682532238002577');
      test_ceil_002('2074', '2073.532654804291079327244387978249477171032485250998396');
      test_ceil_002('677676305592', '677676305591.2');
      test_ceil_002('1', '0.0000000000006');
      test_ceil_002('39181479479778357', '39181479479778357');
      test_ceil_002('1', '0.00000000000000000087964700066672916651');
      test_ceil_002('896', '896');
      test_ceil_002('115083055948552475', '115083055948552475');
      test_ceil_002('9105942082143427451223', '9105942082143427451223');
      test_ceil_002('276312604693909858428', '276312604693909858427.21965306055697011390137926559');
      test_ceil_002('1', '0.0000252');
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_CEIL_0200
     * @tc.name      : testCeil0002
     * @tc.desc      : Test ceil
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testCeil0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      Decimal.set ({
        precision: 20,
        rounding: 4,
        toExpNeg: -100,
        toExpPos: 100,
        minE: -9e15,
        maxE: 9e15
      });
      try {
        test_ceil_002('e', 'e');
        expect(true).assertEqual(false);
      } catch (err) {
        expect(err.name).assertEqual(`BusinessError`);
        expect(err.code).assertEqual(401);
        expect(err.message).assertEqual(`The type of "test(str)" must be Hex/Binary/Octal. Received value is: e`);
      }
    });
  });
}
