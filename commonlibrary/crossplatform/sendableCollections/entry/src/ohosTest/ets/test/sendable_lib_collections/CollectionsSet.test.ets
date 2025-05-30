/*
 *  Copyright (c) 2025 Huawei Device Co., Ltd.
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 */

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import collections from '@arkts.collections';

export default function collectionsSetTest() {
  describe('CollectionsSetTest', () => {
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

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetConstructor_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetConstructor_0100
    * @tc.desc  : Constructor that is used to create an ArkTS Set object.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetConstructor_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetConstructor_0100';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>();
        console.log(`${caseName} set.size ${set.size}`);
        expect(0).assertEqual(set.size);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetConstructor_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetConstructor_0200
    * @tc.desc  : Constructor that is used to create an ArkTS Set object.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetConstructor_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetConstructor_0200';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>([1, 2, 3, 4]);
        console.log(`${caseName} set.size ${set.size}`);
        expect(4).assertEqual(set.size);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetConstructor_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetConstructor_0300
    * @tc.desc  : Constructor that is used to create an ArkTS Set object.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetConstructor_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetConstructor_0300';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>([1, 1, 2, 2, 3, 4]);
        console.log(`${caseName} set.size ${set.size}`);
        expect(4).assertEqual(set.size);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetConstructor_0400
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetConstructor_0400
    * @tc.desc  : Constructor that is used to create an ArkTS Set object.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetConstructor_0400', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetConstructor_0400';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>(null);
        console.log(`${caseName} set.size ${set.size}`);
        expect(0).assertEqual(set.size);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetEntries_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetEntries_0100
    * @tc.desc  : Returns a Set iterator object.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetEntries_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetEntries_0100';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>();
        console.log(`${caseName} set.size ${set.size}`);
        let iterator: Iterator<[number, number]> = set.entries();
        console.log(`${caseName} iterator ${iterator}`);
        expect('{}').assertEqual(JSON.stringify(iterator));
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetEntries_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetEntries_0200
    * @tc.desc  : Returns a Set iterator object.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetEntries_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetEntries_0200';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>([1, 2, 3, 4]);
        console.log(`${caseName} set.size ${set.size}`);
        let iterator: Iterator<[number, number]> = set.entries();
        console.log(`${caseName} iterator ${iterator}`);
        let value: Array<number> = iterator.next().value;
        console.log(`${caseName} iterator next ${value}`);
        expect(1).assertEqual(value[0]);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetEntries_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetEntries_0300
    * @tc.desc  : Returns a Set iterator object.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetEntries_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetEntries_0300';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>(null);
        console.log(`${caseName} set.size ${set.size}`);
        let iterator: Iterator<[number, number]> = set.entries();
        console.log(`${caseName} iterator ${iterator}`);

        expect("{}").assertEqual(JSON.stringify(iterator));
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetKeys_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetKeys_0100
    * @tc.desc  : Returns an Set iterator object that contains the value of each element in this Set.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetKeys_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetKeys_0100';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>();
        console.log(`${caseName} set.size ${set.size}`);
        let iterator: Iterator<number> = set.keys();
        console.log(`${caseName} iterator ${iterator}`);
        expect('{}').assertEqual(JSON.stringify(iterator));
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetKeys_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetKeys_0200
    * @tc.desc  : Returns an Set iterator object that contains the value of each element in this Set.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetKeys_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetKeys_0200';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>([1, 2, 3, 4]);
        console.log(`${caseName} set.size ${set.size}`);
        let iterator: Iterator<number> = set.keys();
        console.log(`${caseName} iterator ${iterator}`);
        let value: number = iterator.next().value;
        console.log(`${caseName} iterator next ${value}`);
        expect(1).assertEqual(value);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetKeys_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetKeys_0300
    * @tc.desc  : Returns an Set iterator object that contains the value of each element in this Set.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetKeys_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetKeys_0300';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>(null);
        console.log(`${caseName} set.size ${set.size}`);
        let iterator: Iterator<number> = set.keys();
        console.log(`${caseName} iterator ${iterator}`);

        expect("{}").assertEqual(JSON.stringify(iterator));
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetValues_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetValues_0100
    * @tc.desc  : Returns an Set iterator object that contains the value of each element in this Set.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetValues_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetValues_0100';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>();
        console.log(`${caseName} set.size ${set.size}`);
        let iterator: Iterator<number> = set.values();
        console.log(`${caseName} iterator ${iterator}`);
        expect('{}').assertEqual(JSON.stringify(iterator));
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetValues_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetValues_0200
    * @tc.desc  : Returns an Set iterator object that contains the value of each element in this Set.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetValues_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetValues_0200';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>([1, 2, 3, 4]);
        console.log(`${caseName} set.size ${set.size}`);
        let iterator: Iterator<number> = set.values();
        console.log(`${caseName} iterator ${iterator}`);
        let value: number = iterator.next().value;
        console.log(`${caseName} iterator next ${value}`);
        expect(1).assertEqual(value);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetValues_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetValues_0300
    * @tc.desc  : Returns an Set iterator object that contains the value of each element in this Set.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetValues_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetValues_0300';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>(null);
        console.log(`${caseName} set.size ${set.size}`);
        let iterator: Iterator<number> = set.values();
        console.log(`${caseName} iterator ${iterator}`);

        expect("{}").assertEqual(JSON.stringify(iterator));
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetClear_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetClear_0100
    * @tc.desc  : Returns an Set iterator object that contains the value of each element in this Set.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetClear_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetClear_0100';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>();
        console.log(`${caseName} set.size ${set.size}`);
        set.clear();
        console.log(`${caseName} clear ${set.size}`);
        expect(0).assertEqual(set.size);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetClear_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetClear_0200
    * @tc.desc  : Returns an Set iterator object that contains the value of each element in this Set.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetClear_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetClear_0200';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>([1, 2, 3, 4]);
        console.log(`${caseName} set.size ${set.size}`);
        set.clear();
        console.log(`${caseName} clear ${set.size}`);
        expect(0).assertEqual(set.size);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetClear_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetClear_0300
    * @tc.desc  : Returns an Set iterator object that contains the value of each element in this Set.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetClear_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetClear_0300';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>(null);
        console.log(`${caseName} set.size ${set.size}`);
        set.clear();
        console.log(`${caseName} clear ${set.size}`);
        expect(0).assertEqual(set.size);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetDelete_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetDelete_0100
    * @tc.desc  : Deletes the specified element in the Set.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetDelete_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetDelete_0100';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>();
        console.log(`${caseName} set.size ${set.size}`);
        let flg: boolean = set.delete(1);
        console.log(`${caseName} clear ${set.size}`);
        expect(true).assertEqual(!flg);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetDelete_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetDelete_0200
    * @tc.desc  : Deletes the specified element in the Set.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetDelete_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetDelete_0200';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>([1, 2, 3, 4]);
        console.log(`${caseName} set.size ${set.size}`);
        let flg: boolean = set.delete(1);
        console.log(`${caseName} clear ${set.size}`);
        expect(true).assertEqual(flg);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetDelete_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetDelete_0300
    * @tc.desc  : Deletes the specified element in the Set.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetDelete_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetDelete_0300';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>(null);
        console.log(`${caseName} set.size ${set.size}`);
        let flg: boolean = set.delete(1);
        console.log(`${caseName} clear ${set.size}`);
        expect(true).assertEqual(!flg);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetForEach_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetForEach_0100
    * @tc.desc  : The callback function is executed once for each key / value pair in the Set in the insertion order.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetForEach_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetForEach_0100';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>([1, 2, 3, 4]);
        console.log(`${caseName} set.size ${set.size}`);
        let num: number = 1;
        set.forEach((value: number, index: number, s: collections.Set<number>) => {
          expect(num).assertEqual(value);
          num++;
        });
        console.log(`${caseName} num ${num}`);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetForEach_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetForEach_0200
    * @tc.desc  : The callback function is executed once for each key / value pair in the Set in the insertion order.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetForEach_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetForEach_0200';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>();
        console.log(`${caseName} set.size ${set.size}`);
        let num: number = 1;
        set.forEach((value: number, index: number, s: collections.Set<number>) => {
          num++;
        });
        expect(1).assertEqual(num);
        console.log(`${caseName} num ${num}`);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetHas_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetHas_0100
    * @tc.desc  : Determines whether the specified element exists in the Set.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetHas_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetHas_0100';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>([1, 2, 3, 4]);
        console.log(`${caseName} set.size ${set.size}`);
        let flg: boolean = set.has(1);
        expect(true).assertEqual(flg);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetHas_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetHas_0200
    * @tc.desc  : Determines whether the specified element exists in the Set.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetHas_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetHas_0200';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>([1, 2, 3, 4]);
        console.log(`${caseName} set.size ${set.size}`);
        let flg: boolean = set.has(5);
        expect(true).assertEqual(!flg);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetHas_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetHas_0300
    * @tc.desc  : Determines whether the specified element exists in the Set.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetHas_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetHas_0300';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>();
        console.log(`${caseName} set.size ${set.size}`);
        let flg: boolean = set.has(5);
        expect(true).assertEqual(!flg);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetAdd_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetAdd_0100
    * @tc.desc  : If there is no same element, a new element is inserted into the Set.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetAdd_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetAdd_0100';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>([1, 2, 3, 4]);
        console.log(`${caseName} set.size ${set.size}`);
        set.add(5);
        let flg: boolean = set.has(5);
        expect(true).assertEqual(flg);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetAdd_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetAdd_0200
    * @tc.desc  : If there is no same element, a new element is inserted into the Set.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetAdd_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetAdd_0200';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>([1, 2, 3, 4]);
        console.log(`${caseName} set.size ${set.size}`);
        set.add(1);
        console.log(`${caseName} set.size ${set.size}`);
        expect(4).assertEqual(set.size);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_SetAdd_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_SetAdd_0300
    * @tc.desc  : If there is no same element, a new element is inserted into the Set.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_SetAdd_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_SetAdd_0300';
      console.log(`${caseName} test start `);
      try {
        let set: collections.Set<number> = new collections.Set<number>();
        console.log(`${caseName} set.size ${set.size}`);
        set.add(5);
        let flg: boolean = set.has(5);
        expect(true).assertEqual(flg);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

  });
}