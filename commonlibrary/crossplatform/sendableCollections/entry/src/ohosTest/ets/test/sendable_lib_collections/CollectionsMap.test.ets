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

export default function collectionsMapTest() {
  describe('CollectionsMapTest', () => {
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
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapConstructor_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapConstructor_0100
    * @tc.desc  : Constructor that is used to create an ArkTS Map object.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapConstructor_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapConstructor_0100';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>();
        console.log(`${caseName} map.size ${map.size}`);
        expect(0).assertEqual(map.size);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapConstructor_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapConstructor_0200
    * @tc.desc  : Constructor that is used to create an ArkTS Map object.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapConstructor_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapConstructor_0200';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>([[0, '1'], [1, '1'], [2, '2']]);
        console.log(`${caseName} map.size ${map.size}`);
        expect(3).assertEqual(map.size);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapConstructor_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapConstructor_0300
    * @tc.desc  : Constructor that is used to create an ArkTS Map object.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapConstructor_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapConstructor_0300';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>(null);
        console.log(`${caseName} map.size ${map.size}`);
        expect(0).assertEqual(map.size);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapConstructor_0400
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapConstructor_0400
    * @tc.desc  : Constructor that is used to create an ArkTS Map object.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapConstructor_0400', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapConstructor_0400';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>([[0, '1'], [0, '1'], [2, '2']]);
        console.log(`${caseName} map.size ${map.size}`);
        expect(2).assertEqual(map.size);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapEntries_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapEntries_0100
    * @tc.desc  : Returns a Map iterator object that contains the [key, value] pairs of each element in this Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapEntries_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapEntries_0100';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>();
        console.log(`${caseName} map.size ${map.size}`);
        let iterator: Iterator<[number, string]> = map.entries();
        console.log(`${caseName} entries ${iterator} `);
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
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapEntries_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapEntries_0200
    * @tc.desc  : Returns a Map iterator object that contains the [key, value] pairs of each element in this Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapEntries_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapEntries_0200';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>([[0, '1'], [1, '1'], [2, '2']]);
        console.log(`${caseName} map.size ${map.size}`);
        let iterator: Iterator<[number, string]> = map.entries();
        let value: Array<string> = iterator.next().value;
        console.log(`${caseName} entries ${value} `);
        expect('1').assertEqual(value[1]);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapEntries_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapEntries_0300
    * @tc.desc  : Returns a Map iterator object that contains the [key, value] pairs of each element in this Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapEntries_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapEntries_0300';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>(null);
        console.log(`${caseName} map.size ${map.size}`);
        let iterator: Iterator<[number, string]> = map.entries();

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
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapKeys_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapKeys_0100
    * @tc.desc  : Returns an Map iterator object that contains the key of each element in this Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapKeys_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapKeys_0100';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>();
        console.log(`${caseName} map.size ${map.size}`);
        let iterator: Iterator<number> = map.keys();
        console.log(`${caseName} keys ${iterator} `);
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
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapKeys_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapKeys_0200
    * @tc.desc  : Returns an Map iterator object that contains the key of each element in this Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapKeys_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapKeys_0200';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>([[0, '1'], [1, '1'], [2, '2']]);
        console.log(`${caseName} map.size ${map.size}`);
        let iterator: Iterator<number> = map.keys();
        let value: number = iterator.next().value;
        console.log(`${caseName} keys ${value} `);
        expect(0).assertEqual(value);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapKeys_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapKeys_0300
    * @tc.desc  : Returns an Map iterator object that contains the key of each element in this Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapKeys_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapKeys_0300';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>(null);
        console.log(`${caseName} map.size ${map.size}`);
        let iterator: Iterator<number> = map.keys();
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
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapValues_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapValues_0100
    * @tc.desc  : Returns an Map iterator object that contains the value of each element in this Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapValues_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapValues_0100';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>();
        console.log(`${caseName} map.size ${map.size}`);
        let iterator: Iterator<string> = map.values();
        console.log(`${caseName} values ${iterator} `);
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
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapValues_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapValues_0200
    * @tc.desc  : Returns an Map iterator object that contains the value of each element in this Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapValues_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapValues_0200';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>([[0, '1'], [1, '1'], [2, '2']]);
        console.log(`${caseName} map.size ${map.size}`);
        let iterator: Iterator<string> = map.values();
        let value: string = iterator.next().value;
        console.log(`${caseName} values ${value} `);
        expect('1').assertEqual(value);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapValues_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapValues_0300
    * @tc.desc  : Returns an Map iterator object that contains the value of each element in this Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapValues_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapValues_0300';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>(null);
        console.log(`${caseName} map.size ${map.size}`);
        let iterator: Iterator<string> = map.values();
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
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapClear_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapClear_0100
    * @tc.desc  : Delete all elements in the Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapClear_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapClear_0100';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>(null);
        console.log(`${caseName} map.size ${map.size}`);
        map.clear();
        console.log(`${caseName} map.size clear ${map.size}`);
        expect(0).assertEqual(map.size);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapClear_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapClear_0200
    * @tc.desc  : Delete all elements in the Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapClear_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapClear_0200';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>([[0, '1'], [1, '1'], [2, '2']]);
        console.log(`${caseName} map.size ${map.size}`);
        map.clear();
        console.log(`${caseName} map.size clear ${map.size}`);
        expect(0).assertEqual(map.size);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapClear_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapClear_0300
    * @tc.desc  : Delete all elements in the Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapClear_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapClear_0300';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>(null);
        console.log(`${caseName} map.size ${map.size}`);
        map.clear();
        console.log(`${caseName} map.size clear ${map.size}`);
        expect(0).assertEqual(map.size);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapDelete_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapDelete_0100
    * @tc.desc  : Deletes the specified element in the Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapDelete_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapDelete_0100';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>([[0, '1'], [1, '1'], [2, '2']]);
        console.log(`${caseName} map.size ${map.size}`);
        let deleteFlg: boolean = map.delete(0);
        console.log(`${caseName} deleteFlg ${deleteFlg}`);
        expect(true).assertEqual(deleteFlg);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapDelete_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapDelete_0200
    * @tc.desc  : Deletes the specified element in the Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapDelete_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapDelete_0200';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>([[0, '1'], [1, '1'], [2, '2']]);
        console.log(`${caseName} map.size ${map.size}`);
        let deleteFlg: boolean = map.delete(4);
        console.log(`${caseName} deleteFlg ${deleteFlg}`);
        expect(true).assertEqual(!deleteFlg);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapDelete_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapDelete_0300
    * @tc.desc  : Deletes the specified element in the Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapDelete_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapDelete_0300';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>();
        console.log(`${caseName} map.size ${map.size}`);
        let deleteFlg: boolean = map.delete(4);
        console.log(`${caseName} deleteFlg ${deleteFlg}`);
        expect(true).assertEqual(!deleteFlg);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapForEach_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapForEach_0100
    * @tc.desc  : The callback function is executed once for each key / value pair in the Map in the insertion order.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapForEach_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapForEach_0100';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>();
        console.log(`${caseName} map.size ${map.size}`);
        let num = 0;
        map.forEach((v: string, k: number, m: collections.Map<number, string>) => {
          num++;
        });
        console.log(`${caseName} deleteFlg ${num}`);
        expect(0).assertEqual(num);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapForEach_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapForEach_0200
    * @tc.desc  : The callback function is executed once for each key / value pair in the Map in the insertion order.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapForEach_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapForEach_0200';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>([[0, '1'], [1, '1'], [2, '2']]);
        console.log(`${caseName} map.size ${map.size}`);
        let num = 0;
        map.forEach((v: string, k: number, m: collections.Map<number, string>) => {
          expect(num).assertEqual(k);
          num++;
        });
        console.log(`${caseName} deleteFlg ${num}`);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapGet_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapGet_0100
    * @tc.desc  : Returns the specified element in the Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapGet_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapGet_0100';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>([[0, '1'], [1, '1'], [2, '2']]);
        console.log(`${caseName} map.size ${map.size}`);
        let value: string | undefined = map.get(0);
        console.log(`${caseName} get ${value}`);
        expect('1').assertEqual(value);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapGet_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapGet_0200
    * @tc.desc  : Returns the specified element in the Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapGet_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapGet_0200';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>([[0, '1'], [1, '1'], [2, '2']]);
        console.log(`${caseName} map.size ${map.size}`);
        let value: string | undefined = map.get(4);
        console.log(`${caseName} get ${value}`);
        expect(undefined).assertEqual(value);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapGet_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapGet_0300
    * @tc.desc  : Returns the specified element in the Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapGet_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapGet_0300';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>();
        console.log(`${caseName} map.size ${map.size}`);
        let value: string | undefined = map.get(0);
        console.log(`${caseName} get ${value}`);
        expect(undefined).assertEqual(value);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });


    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapHas_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapHas_0100
    * @tc.desc  : Determines whether the specified element exists in the Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapHas_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapHas_0100';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>([[0, '1'], [1, '1'], [2, '2']]);
        console.log(`${caseName} map.size ${map.size}`);
        let flg: boolean = map.has(0);
        console.log(`${caseName} has ${flg}`);
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
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapHas_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapHas_0200
    * @tc.desc  : Determines whether the specified element exists in the Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapHas_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapHas_0200';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>([[0, '1'], [1, '1'], [2, '2']]);
        console.log(`${caseName} map.size ${map.size}`);
        let value: boolean = map.has(4);
        console.log(`${caseName} has ${value}`);
        expect(true).assertEqual(!value);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapHas_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapHas_0300
    * @tc.desc  : Determines whether the specified element exists in the Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapHas_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapHas_0300';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>();
        console.log(`${caseName} map.size ${map.size}`);
        let value: boolean = map.has(1);
        console.log(`${caseName} has ${value}`);
        expect(true).assertEqual(!value);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapSetHas_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapSetHas_0100
    * @tc.desc  : Adds or updates a specified key-value pair to the Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapSetHas_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapSetHas_0100';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>();
        console.log(`${caseName} map.size ${map.size}`);
        map.set(0, '1');
        console.log(`${caseName} map.size ${map.size}`);
        expect(true).assertEqual(map.has(0));
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapSetHas_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapSetHas_0200
    * @tc.desc  : Adds or updates a specified key-value pair to the Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapSetHas_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapSetHas_0200';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>([[0, '1'], [1, '2']]);
        console.log(`${caseName} map.size ${map.size}`);
        map.set(0, '1');
        console.log(`${caseName} map.size ${map.size}`);
        expect(2).assertEqual(map.size);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapSetHas_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapSetHas_0300
    * @tc.desc  : Adds or updates a specified key-value pair to the Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapSetHas_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapSetHas_0300';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>([[0, '1'], [1, '2']]);
        console.log(`${caseName} map.size ${map.size}`);
        map.set(0, '3');
        console.log(`${caseName} map.size ${map.size}`);
        expect(2).assertEqual(map.size);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_MapSetHas_0400
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_MapSetHas_0400
    * @tc.desc  : Adds or updates a specified key-value pair to the Map.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_MapSetHas_0400', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_MapSetHas_0400';
      console.log(`${caseName} test start `);
      try {
        let map: collections.Map<number, string> = new collections.Map<number, string>([[0, '1'], [1, '2']]);
        console.log(`${caseName} map.size ${map.size}`);
        map.set(2, '1');
        console.log(`${caseName} map.size ${map.size}`);
        expect(3).assertEqual(map.size);
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