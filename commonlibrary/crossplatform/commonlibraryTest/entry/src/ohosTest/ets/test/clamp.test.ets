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

function test_clamp_001 (x: string, min: string, max: string, expected: string) {
  expect(expected).assertEqual(Decimal.clamp(x, min, max).valueOf());
}
function test_clamp_002 (x: number, min: number, max: number, expected: string) {
  expect(expected).assertEqual(Decimal.clamp(x, min, max).valueOf());
}
function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function ClampTest() {
  describe("ClampTest", () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_CLAMP_0100
     * @tc.name      : testClamp0001
     * @tc.desc      : Test clamp
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testClamp0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      test_clamp_001('-0', '0', '0', '-0');
      test_clamp_001('-0', '-0', '0', '-0');
      test_clamp_001('-0', '0', '-0', '-0');
      test_clamp_001('-0', '-0', '-0', '-0');
      test_clamp_001('0', '0', '0', '0');
      test_clamp_001('0', '-0', '0', '0');
      test_clamp_001('0', '0', '-0', '0');
      test_clamp_001('0', '-0', '-0', '0');
      test_clamp_002(0, 0, 1, '0');
      test_clamp_002(-1, 0, 1, '0');
      test_clamp_002(-2, 0, 1, '0');
      test_clamp_002(1, 0, 1, '1');
      test_clamp_002(2, 0, 1, '1');
      test_clamp_002(1, 1, 1, '1');
      test_clamp_002(-1, 1, 1, '1');
      test_clamp_002(-1, -1, 1, '-1');
      test_clamp_002(2, 1, 2, '2');
      test_clamp_002(3, 1, 2, '2');
      test_clamp_002(1, 0, 1, '1');
      test_clamp_002(2, 0, 1, '1');
      test_clamp_002(Infinity, 0, 1, '1');
      test_clamp_002(0, -Infinity, 0, '0');
      test_clamp_002(-Infinity, 0, 1, '0');
      test_clamp_002(-Infinity, -Infinity, Infinity, '-Infinity');
      test_clamp_002(Infinity, -Infinity, Infinity, 'Infinity');
      test_clamp_002(0, 1, Infinity, '1');
      test_clamp_002(0, NaN, 1, 'NaN');
      test_clamp_002(0, 0, NaN, 'NaN');
      test_clamp_002(NaN, 0, 1, 'NaN');
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_CLAMP_0200
     * @tc.name      : testClamp0002
     * @tc.desc      : Test clamp
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testClamp0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      try {
        test_clamp_001('e', 'e', 'e', 'e');
        expect(true).assertEqual(false);
      } catch (err) {
        expect(err.name).assertEqual(`BusinessError`);
        expect(err.code).assertEqual(401);
        expect(err.message).assertEqual(`The type of "test(str)" must be Hex/Binary/Octal. Received value is: e`);
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_DECIMAL_CLAMP_0300
     * @tc.name      : testClamp0003
     * @tc.desc      : Test clamp
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it("testClamp0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      try {
        test_clamp_002(0, 1, 0, '0');
        expect(true).assertEqual(false);
      } catch (err) {
        expect(err.name).assertEqual(`BusinessError`);
        expect(err.code).assertEqual(10200001);
        expect(err.message).assertEqual(`The value of min is out of range. It must be <= 0. Received value is: 1`);
      }
    });
  });
}
