/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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
import { ArrayList } from '@kit.ArkTS';
class Temp {
  age: number = 0
  name: string = ""
}
export default function arraySymbolIteratorTest() {
  describe('arraySymbolIteratorTest', () => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(() => {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    })
    beforeEach(() => {
      // Presets an action, which is performed before each unit test case starts.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: preset action function.
    })
    afterEach(() => {
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    })
    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    })
    /**
     * @tc.number : SUB_COMMONLIBRARY_ARRAY_SYMBOL_ITERATOR_0100
     * @tc.name   : testSymbolIterator0001
     * @tc.desc   : Testing ArrayList Symbol.iterator
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSymbolIterator0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testSymbolIterator0001';
      try {
        let arrayList: ArrayList<number | string | Array<number | string | boolean> | boolean | undefined | null |
        Object> = new ArrayList();
        arrayList.add("zhang san");
        arrayList.add(1);
        let temp: Temp = {
          age: 10, name: "zhang"
        };
        arrayList.add(temp);
        arrayList.add(undefined);
        arrayList.add(null);
        arrayList.add(true);
        let array = [0, 1, 2, undefined];
        arrayList.add(array);
        arrayList.add("");
        arrayList.add("`");
        arrayList.add("%");
        arrayList.add(`"`);
        let iter = arrayList[Symbol.iterator]();
        let tem = iter.next();
        while (!tem.done) {
          console.log(`${TAG} value: ${tem.value}`);
          expect(arrayList.has(tem.value)).assertEqual(true);
          tem = iter.next();
        }
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });
  })
}