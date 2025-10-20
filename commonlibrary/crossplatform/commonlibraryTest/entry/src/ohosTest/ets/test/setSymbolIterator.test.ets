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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Level, Size } from '@ohos/hypium'
import { HashSet } from '@kit.ArkTS';
export default function setSymbolIteratorTest() {
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
  describe('setSymbolIteratorTest', () => {
    /**
     * @tc.number : SUB_COMMONLIBRARY_SET_SYMBOL_ITERATOR_0100
     * @tc.name   : testSymbolIterator0001
     * @tc.desc   : Testing HashSet is empty while loop check
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSymbolIterator0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testSymbolIterator0001';
      try {
        let hashSet = new HashSet<number>();
        let iter = hashSet[Symbol.iterator]();
        let temp: IteratorResult<number> = iter.next();
        while (!temp.done) {
          expect(hashSet.length).assertEqual(0)
          temp = iter.next()
        }
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_SET_SYMBOL_ITERATOR_0200
     * @tc.name   : testSymbolIterator0002
     * @tc.desc   : Testing HashSet has data while loop check value and length
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSymbolIterator0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testSymbolIterator0002';
      try {
        let hashSet = new HashSet<number>();
        hashSet.add(1)
        hashSet.add(2)
        hashSet.add(3)
        let iter = hashSet[Symbol.iterator]();
        let temp: IteratorResult<number> = iter.next();
        let index = 1;
        while (!temp.done) {
          if (temp.value) {
            expect(temp.value).assertEqual(index)
          }
          index++;
          temp = iter.next()
        }
        expect(hashSet.length).assertEqual(3)
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });
  })
}

