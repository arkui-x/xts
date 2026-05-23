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

const WAIT_READY_MS_2000: number = 2000
const WAIT_READY_MS_300: number = 300

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

interface TestObjs1 {
  a?: number;
}

interface TestObjs2 {
  a?: TestObjs3;
}

interface TestObjs3 {
  b?: number;
}

interface TestObjs4 {
  a?: number[];
}

interface TestObj {
  x?: number;
  y?: number;
  arr?: number[];
  a?: TestObj2;
}

interface TestObj2 {
  b?: TestObj3;
}

interface TestObj3 {
  c?: number[];
}

export default function JSONStringifyBasicTest() {
  describe('JSONStringifyBasicTest', () => {
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
     * @tc.name   ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0100
     * @tc.number ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0100
     * @tc.desc   Test string serialization
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0100', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, async () => {
      let result: string = JSON.stringify("foo");
      expect(result).assertEqual('"foo"');
    });

    /**
     * @tc.name   ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0200
     * @tc.number ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0200
     * @tc.desc   Test number serialization
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0200', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, async () => {
      let result: string = JSON.stringify(123);
      expect(result).assertEqual('123');
    });

    /**
     * @tc.name   ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0300
     * @tc.number ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0300
     * @tc.desc   Test boolean true serialization
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0300', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, async () => {
      let result: string = JSON.stringify(true);
      expect(result).assertEqual('true');
    });

    /**
     * @tc.name   ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0400
     * @tc.number ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0400
     * @tc.desc   Test boolean false serialization
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0400', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, async () => {
      let result: string = JSON.stringify(false);
      expect(result).assertEqual('false');
    });

    /**
     * @tc.name   ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0500
     * @tc.number ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0500
     * @tc.desc   Test null serialization
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0500', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, async () => {
      let result: string = JSON.stringify(null);
      expect(result).assertEqual('null');
    });

    /**
     * @tc.name   ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0600
     * @tc.number ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0600
     * @tc.desc   Test empty object serialization
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0600', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, async () => {
      let obj: Record<string, never> = {};
      let result: string = JSON.stringify(obj);
      expect(result).assertEqual('{}');
    });

    /**
     * @tc.name   ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0700
     * @tc.number ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0700
     * @tc.desc   Test simple object serialization
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0700', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, async () => {
      let obj: TestObj = { x: 5 };
      let result: string = JSON.stringify(obj);
      expect(result).assertEqual('{"x":5}');
    });

    /**
     * @tc.name   ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0800
     * @tc.number ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0800
     * @tc.desc   Test multi-property object serialization
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0800', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, async () => {
      let obj: TestObj = { x: 5, y: 6 };
      let result: string = JSON.stringify(obj);
      expect(result).assertEqual('{"x":5,"y":6}');
    });

    /**
     * @tc.name   ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0900
     * @tc.number ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0900
     * @tc.desc   Test empty array serialization
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_0900', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, async () => {
      let arr: never[] = [];
      let result: string = JSON.stringify(arr);
      expect(result).assertEqual('[]');
    });

    /**
     * @tc.name   ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_1000
     * @tc.number ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_1000
     * @tc.desc   Test simple array serialization
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL0
     */
    it('ArkUIX_SUB_JSONTEST_JSONSTRINGIFYBASICTEST_1000', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0, async () => {
      let arr: (number | string | boolean)[] = [1, "false", false];
      let result: string = JSON.stringify(arr);
      expect(result).assertEqual('[1,"false",false]');
    });

  })
}
