/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, Level, Size, TestType } from '@ohos/hypium';
import {
  originalArr5,
  originalFn6,
  originalObj4,
  originalSymbol8,
  result1,
  result10,
  result2,
  result3,
  result4,
  result5,
  result6,
  result7,
  result8,
  result8_1,
  result9
} from './Object1';

const WAIT_READY_MS_2000: number = 2000
const WAIT_READY_MS_300: number = 300

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

export default function Object1Test() {
  describe('Object1Test', () => {
    beforeAll(async () => {
      await sleep(WAIT_READY_MS_2000)
    })
    beforeEach(async () => {
      await sleep(WAIT_READY_MS_300)
    })
    afterEach(async () => {
      await sleep(WAIT_READY_MS_300)
    })
    afterAll(async () => {
      await sleep(WAIT_READY_MS_300)
    })

    /**
     * @tc.name   ArkUIX_SUB_OBJECTTEST_OBJECT1_0100
     * @tc.number ArkUIX_SUB_OBJECTTEST_OBJECT1_0100
     * @tc.desc   Call Object() with no parameters, verify returning empty object and its prototype
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_OBJECTTEST_OBJECT1_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      expect(typeof result1).assertEqual('object');
      expect(JSON.stringify(result1)).assertEqual('{}');
    });

    /**
     * @tc.name   ArkUIX_SUB_OBJECTTEST_OBJECT1_0200
     * @tc.number ArkUIX_SUB_OBJECTTEST_OBJECT1_0200
     * @tc.desc   Call Object() with null as parameter, verify returning empty object
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_OBJECTTEST_OBJECT1_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      expect(typeof result2).assertEqual('object');
      expect(JSON.stringify(result2)).assertEqual('{}');
    });

    /**
     * @tc.name   ArkUIX_SUB_OBJECTTEST_OBJECT1_0300
     * @tc.number ArkUIX_SUB_OBJECTTEST_OBJECT1_0300
     * @tc.desc   Call Object() with undefined as parameter, verify returning empty object
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_OBJECTTEST_OBJECT1_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      expect(typeof result3).assertEqual('object');
      expect(JSON.stringify(result3)).assertEqual('{}');
    });

    /**
     * @tc.name   ArkUIX_SUB_OBJECTTEST_OBJECT1_0400
     * @tc.number ArkUIX_SUB_OBJECTTEST_OBJECT1_0400
     * @tc.desc   Call Object() with a plain object as parameter, verify returning original object and its properties
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_OBJECTTEST_OBJECT1_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      expect(result4).assertEqual(originalObj4);
      expect(result4.name).assertEqual('test');
      expect(result4.age).assertEqual(20);
    });

    /**
     * @tc.name   ArkUIX_SUB_OBJECTTEST_OBJECT1_0500
     * @tc.number ArkUIX_SUB_OBJECTTEST_OBJECT1_0500
     * @tc.desc   Call Object() with an array as parameter, verify returning original array and its characteristics
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_OBJECTTEST_OBJECT1_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      expect(result5).assertEqual(originalArr5);
      expect(result5.length).assertEqual(3);
      expect(result5[1]).assertEqual(20);
      expect(Array.isArray(result5)).assertEqual(true);
    });

    /**
     * @tc.name   ArkUIX_SUB_OBJECTTEST_OBJECT1_0600
     * @tc.number ArkUIX_SUB_OBJECTTEST_OBJECT1_0600
     * @tc.desc   Call Object() with a function as parameter, verify returning original function and its callability
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_OBJECTTEST_OBJECT1_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      expect(result6).assertEqual(originalFn6);
      expect(result6(2, 3)).assertEqual(5);
      expect(typeof result6).assertEqual('function');
    });

    /**
     * @tc.name   ArkUIX_SUB_OBJECTTEST_OBJECT1_0700
     * @tc.number ArkUIX_SUB_OBJECTTEST_OBJECT1_0700
     * @tc.desc   Call Object() with a BigInt as parameter, verify wrapped object and its characteristics
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_OBJECTTEST_OBJECT1_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      expect(typeof result7).assertEqual('object');
      expect(result7.valueOf()).assertEqual(456n);
    });

    /**
     * @tc.name   ArkUIX_SUB_OBJECTTEST_OBJECT1_0800
     * @tc.number ArkUIX_SUB_OBJECTTEST_OBJECT1_0800
     * @tc.desc   Call Object() with a Symbol as parameter, verify wrapped object and its characteristics
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_OBJECTTEST_OBJECT1_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      expect(typeof result8).assertEqual('object');
      expect(result8_1 === originalSymbol8).assertEqual(true);
    });

    /**
     * @tc.name   ArkUIX_SUB_OBJECTTEST_OBJECT1_0900
     * @tc.number ArkUIX_SUB_OBJECTTEST_OBJECT1_0900
     * @tc.desc   Call Object() with a Number primitive as parameter, verify wrapped object and its prototype methods
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_OBJECTTEST_OBJECT1_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      expect(typeof result9).assertEqual('object');
      expect(result9.valueOf()).assertEqual(789);
      expect(result9.toFixed(2)).assertEqual('789.00');
    });

    /**
     * @tc.name   ArkUIX_SUB_OBJECTTEST_OBJECT1_1000
     * @tc.number ArkUIX_SUB_OBJECTTEST_OBJECT1_1000
     * @tc.desc   Call Object() with a String primitive as parameter, verify wrapped object and its prototype methods
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_OBJECTTEST_OBJECT1_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      expect(typeof result10).assertEqual('object');
      expect(result10.valueOf()).assertEqual('javascript');
      expect(result10.slice(0, 4)).assertEqual('java');
    });
  })
}

