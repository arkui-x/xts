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
import { HashMap } from '@kit.ArkTS';

function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function mapSymbolIteratorTest() {
  describe('mapSymbolIteratorTest', () => {
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
     * @tc.number : SUB_COMMONLIBRARY_MAP_SYMBOL_ITERATOR_0100
     * @tc.name   : testSymbolIterator0001
     * @tc.desc   : Testing HashMap is empty while loop check
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSymbolIterator0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testSymbolIterator0001';
      try {
        let hashMap = new HashMap<number, number>();
        let iter = hashMap[Symbol.iterator]();
        let temp: IteratorResult<[number, number]> = iter.next();
        while (!temp.done) {
          expect(hashMap.length).assertEqual(0)
          temp = iter.next()
        }
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_MAP_SYMBOL_ITERATOR_0200
     * @tc.name   : testSymbolIterator0002
     * @tc.desc   : Testing HashMap has data while loop check value and length
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testSymbolIterator0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testSymbolIterator0002';
      try {
        let hashMap = new HashMap<number, number>();
        hashMap.set(0, 0);
        hashMap.set(1, 1);
        hashMap.set(2, 2);
        let iter = hashMap[Symbol.iterator]();
        let temp: IteratorResult<[number, number]> = iter.next();
        let index = 0;
        while (!temp.done) {
          if (temp.value) {
            expect(temp.value[0]).assertEqual(index);
            expect(temp.value[1]).assertEqual(index);
          }
          index++;
          temp = iter.next()
        }
        expect(hashMap.length).assertEqual(3)
      } catch (err) {
        console.error(`${TAG} failed, error: ${err}`);
        expect().assertFail();
      }
    });
  })
}
