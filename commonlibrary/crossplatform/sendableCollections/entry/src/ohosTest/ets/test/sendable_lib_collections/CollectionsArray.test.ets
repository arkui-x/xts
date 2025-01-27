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

export default function collectionsArrayTest() {
  describe('CollectionsArrayTest', () => {
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
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayConstructor_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayConstructor_0100
    * @tc.desc  : Create a constructor for ArkTS Array,Empty parameter constructor.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayConstructor_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayConstructor_0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>();
        console.log(`${caseName} array.length ${array.length}`);
        expect(0).assertEqual(array.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayConstructor_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayConstructor_0200
    * @tc.desc  : Create a constructor for ArkTS Array,Parameters 1, 2, 3, 4.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayConstructor_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayConstructor_0200';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} array.length ${array.length}`);
        expect(4).assertEqual(array.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error.message)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayConstructor_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayConstructor_0300
    * @tc.desc  : Create a constructor for ArkTS Array,Parameters 1, 2, 3, 4.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayConstructor_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayConstructor_0300';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<null> = new collections.Array<null>(null);
        console.log(`${caseName} array ${array.length}`);
        expect(1).assertEqual(array.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`)
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayConstructor_0400
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayConstructor_0400
    * @tc.desc  : Create a constructor for ArkTS Array,The array object calls constructor().
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayConstructor_0400', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayConstructor_0400';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        array.constructor();
        console.log(`${caseName} array.constructor()`);
        expect().assertFail();
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect(10200012).assertEqual(error.code);
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayCreate_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayCreate_0100
    * @tc.desc  : Generate a fixed-length Array, where the initial value of each element is initialValue,Array.create<number>(3, 10);.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayCreate_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayCreate_0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = collections.Array.create<number>(3, 10); // [10, 10, 10]
        console.log(`${caseName} array length ${array.length}`);
        expect(3).assertEqual(array.length);
        expect(10).assertEqual(array[0]);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayCreate_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayCreate_0200
    * @tc.desc  : Generate a fixed-length Array, where the initial value of each element is initialValue,Array.create<number>(2.5, 10).
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayCreate_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayCreate_0200';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = collections.Array.create<number>(2.5, 10);
        console.log(`${caseName} array length ${array.length}`);
        expect().assertFail();
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}`);
        expect(401).assertEqual(error.code);
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayCreate_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayCreate_0300
    * @tc.desc  : Generate a fixed-length Array, where the initial value of each element is initialValue,Array.create<number>(0, 10).
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayCreate_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayCreate_0300';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = collections.Array.create<number>(0, 10);
        console.log(`${caseName} array length ${array.length}`);
        expect(0).assertEqual(array.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayCreate_0400
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayCreate_0400
    * @tc.desc  : Generate a fixed-length Array, where the initial value of each element is initialValue,Array.create<number>(0, 10).
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayCreate_0400', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayCreate_0400';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = collections.Array.create<number>(-1, 10);
        console.log(`${caseName} array length ${array.length}`);
        expect().assertFail();
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}`);
        expect(401).assertEqual(error.code);
        done();
      }
      console.log(`${caseName} test end `);
    });


    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFrom_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFrom_0100
    * @tc.desc  : Create a new ArkTS Array from an object that implements the ArrayLike interface.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFrom_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFrom_0100';
      console.log(`${caseName} test start `);
      try {
        let arrayLike: ArrayLike<number> = [1, 3, 5];
        let array: collections.Array<number> = collections.Array.from<number>(arrayLike);
        console.log(`${caseName} array length ${array.length}`);
        expect(3).assertEqual(array.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFrom_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFrom_0200
    * @tc.desc  : Create a new ArkTS Array from an object that implements the ArrayLike interface.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFrom_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFrom_0200';
      console.log(`${caseName} test start `);
      try {
        let arr: Array<number> = new Array(1, 2, 3, 4);
        let array: collections.Array<number> = collections.Array.from<number>(arr);
        console.log(`${caseName} array length ${array.length}`);
        expect(4).assertEqual(array.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFrom_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFrom_0300
    * @tc.desc  : Create a new ArkTS Array from an object that implements the ArrayLike interface.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFrom_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFrom_0300';
      console.log(`${caseName} test start `);
      try {
        // let arr: Array<number> = new Array(1, 2, 3, 4);
        let array: collections.Array<number> = collections.Array.from<number>([1, 2, 3, 4]);
        console.log(`${caseName} array length ${array.length}`);
        expect(4).assertEqual(array.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPop_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPop_0100
    * @tc.desc  : Removes and returns the last element from the ArkTS Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPop_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPop_0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} array pop before ${array.length}`);
        let lastElement: number | undefined = array.pop();
        console.log(`${caseName} array pop after ${array.length}  lastElement ${lastElement}`);
        expect(4).assertEqual(lastElement);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPop_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPop_0200
    * @tc.desc  : Removes and returns the last element from the ArkTS Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPop_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPop_0200';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1);
        console.log(`${caseName} array pop before ${array.length}`);
        let lastElement: number | undefined = array.pop();
        console.log(`${caseName} array pop after ${array.length}  lastElement ${lastElement}`);
        expect(1).assertEqual(lastElement);
        expect(0).assertEqual(array.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPop_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPop_0300
    * @tc.desc  : Removes and returns the last element from the ArkTS Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPop_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPop_0300';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>();
        console.log(`${caseName} array pop before ${array.length}`);
        let lastElement: number | undefined = array.pop();
        console.log(`${caseName} array pop after ${array.length}  lastElement ${lastElement}`);
        expect(undefined).assertEqual(lastElement);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPop_0400
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPop_0400
    * @tc.desc  : Removes and returns the last element from the ArkTS Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPop_0400', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPop_0400';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1);
        console.log(`${caseName} array pop before ${array.length}`);
        array.pop();
        let lastElement2: number | undefined = array.pop();
        console.log(`${caseName} array pop after ${array.length}  lastElement ${lastElement2}`);
        expect(undefined).assertEqual(lastElement2);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });


    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPush_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPush_0100
    * @tc.desc  : Add one or more elements to the end of the ArkTS Array and return the new Array length.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPush_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPush_0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} array push before ${array.length}`);
        let pushLength: number = array.push(5);
        console.log(`${caseName} array push after ${array.length}  pushLength ${pushLength}`);
        expect(5).assertEqual(pushLength);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPush_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPush_0200
    * @tc.desc  : Add one or more elements to the end of the ArkTS Array and return the new Array length.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPush_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayPush_0200';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} array push before ${array.length}`);
        let pushLength: number = array.push(5, 6);
        console.log(`${caseName} array push after ${array.length}  pushLength ${pushLength}`);
        expect(6).assertEqual(pushLength);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayJoin_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayJoin_0100
    * @tc.desc  : Concatenates all elements of ArkTS Array into a string that can be separated by a specified delimiter.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayJoin_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayJoin_0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} array join before ${array.length}`);
        let joinStr: string = array.join('-');
        console.log(`${caseName} array join after  ${joinStr}`);
        expect('1-2-3-4').assertEqual(joinStr);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayJoin_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayJoin_0200
    * @tc.desc  : Concatenates all elements of ArkTS Array into a string that can be separated by a specified delimiter.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayJoin_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayJoin_0200';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} array join before ${array.length}`);
        let joinStr: string = array.join();
        console.log(`${caseName} array join after  ${joinStr}`);
        expect('1,2,3,4').assertEqual(joinStr);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayJoin_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayJoin_0300
    * @tc.desc  : Concatenates all elements of ArkTS Array into a string that can be separated by a specified delimiter.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayJoin_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayJoin_0300';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} array join before ${array.length}`);
        let joinStr: string = array.join(undefined);
        console.log(`${caseName} array join after  ${joinStr}`);
        expect('1,2,3,4').assertEqual(joinStr);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShift_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShift_0100
    * @tc.desc  : Removes and returns the first element from the ArkTS Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShift_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShift_0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} array shift before ${array.length}`);
        let firstElement: number | undefined = array.shift();
        console.log(`${caseName} array shift after ${array.length}  firstElement  ${firstElement}`);
        expect(1).assertEqual(firstElement);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShift_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShift_0200
    * @tc.desc  : Removes and returns the first element from the ArkTS Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShift_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShift_0200';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>();
        console.log(`${caseName} array shift before ${array.length}`);
        let firstElement: number | undefined = array.shift();
        console.log(`${caseName} array shift after ${array.length}  firstElement  ${firstElement}`);
        expect(undefined).assertEqual(firstElement);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShift_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShift_0300
    * @tc.desc  : Removes and returns the first element from the ArkTS Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShift_0300', 0, async (done: Function) => {
      let caseName: string = 'testArrayShift0300';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1);
        console.log(`${caseName} array shift before ${array.length}`);
        let firstElement: number | undefined = array.shift();
        console.log(`${caseName} array shift after ${array.length}  firstElement  ${firstElement}`);
        expect(1).assertEqual(firstElement);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShift_0400
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShift_0400
    * @tc.desc  : Removes and returns the first element from the ArkTS Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShift_0400', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShift_0400';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1);
        console.log(`${caseName} array shift before ${array.length}`);
        array.shift();
        let firstElement: number | undefined = array.shift();
        console.log(`${caseName} array shift after ${array.length}  firstElement  ${firstElement}`);
        expect(undefined).assertEqual(firstElement);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayUnshift_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayUnshift_0100
    * @tc.desc  : Inserts one or more elements at the head of the ArkTS Array and returns the new Array length.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayUnshift_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayUnshift_0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} array Unshift before ${array.length}`);
        let pushLength: number | undefined = array.unshift(5);
        console.log(`${caseName} array Unshift after ${array.length}  pushLength ${pushLength}`);
        expect(5).assertEqual(pushLength);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayUnshift_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayUnshift_0200
    * @tc.desc  : Inserts one or more elements at the head of the ArkTS Array and returns the new Array length.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayUnshift_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayUnshift_0200';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} array Unshift before ${array.length}`);
        let pushLength: number = array.unshift(5, 6);
        console.log(`${caseName} array Unshift after ${array.length}  pushLength ${pushLength}`);
        expect(6).assertEqual(pushLength);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0100
    * @tc.desc  : Returns a new Array, which is a slice of the original ArkTS Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0100', 0, async (done: Function) => {
      let caseName: string = 'testArraySlice0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} array slice before ${array.length}`);
        let newArray: collections.Array<number> = array.slice(0, 2);
        console.log(`${caseName} array slice after newArray ${newArray.length}`);
        expect(2).assertEqual(newArray.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0200
    * @tc.desc  : Returns a new Array, which is a slice of the original ArkTS Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0200';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} array Unshift before ${array.length}`);
        let newArray: collections.Array<number> = array.slice(0);
        console.log(`${caseName} array slice after newArray ${newArray.length}`);
        expect(4).assertEqual(newArray.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0300
    * @tc.desc  : Returns a new Array, which is a slice of the original ArkTS Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0300';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} array Unshift before ${array.length}`);
        let newArray: collections.Array<number> = array.slice();
        console.log(`${caseName} array slice after newArray ${newArray.length}`);
        expect(4).assertEqual(newArray.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0400
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0400
    * @tc.desc  : Returns a new Array, which is a slice of the original ArkTS Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0400', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0400';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} Array<number> Unshift before ${array.length}`);
        let newArray: collections.Array<number> = array.slice(5);
        console.log(`${caseName} array slice after newArray ${newArray.length}`);
        expect(0).assertEqual(newArray.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0500
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0500
    * @tc.desc  : Returns a new Array, which is a slice of the original ArkTS Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0500', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0500';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} array Unshift before ${array.length}`);
        let newArray: collections.Array<number> = array.slice(0, 5);
        console.log(`${caseName} array slice after newArray ${newArray.length}`);
        expect(4).assertEqual(newArray.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0600
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0600
    * @tc.desc  : Returns a new Array, which is a slice of the original ArkTS Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0600', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0600';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} array Unshift before ${array.length}`);
        let newArray: collections.Array<number> = array.slice(3, 2);
        console.log(`${caseName} array slice after newArray ${newArray.length}`);
        expect(0).assertEqual(newArray.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0700
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0700
    * @tc.desc  : Returns a new Array, which is a slice of the original ArkTS Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0700', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0700';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} array Unshift before ${array.length}`);
        let newArray: collections.Array<number> = array.slice(-1);
        console.log(`${caseName} array slice after newArray ${newArray.length}`);
        expect(1).assertEqual(newArray.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0800
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0800
    * @tc.desc  : Returns a new Array, which is a slice of the original ArkTS Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0800', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0800';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} array Unshift before ${array.length}`);
        let newArray: collections.Array<number> = array.slice(0, -1);
        console.log(`${caseName} array slice after newArray ${newArray.length}`);
        expect(3).assertEqual(newArray.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });


    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0900
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0900
    * @tc.desc  : Returns a new Array, which is a slice of the original ArkTS Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0900', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_0900';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} array Unshift before ${array.length}`);
        let newArray: collections.Array<number> = array.slice(-1, -1);
        console.log(`${caseName} array slice after newArray ${newArray.length}`);
        expect(0).assertEqual(newArray.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_1000
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_1000
    * @tc.desc  : Returns a new Array, which is a slice of the original ArkTS Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_1000', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArraySlice_1000';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} array Unshift before ${array.length}`);
        let newArray: collections.Array<number> = array.slice(0, 0);
        console.log(`${caseName} array slice after newArray ${newArray.length}`);
        expect(0).assertEqual(newArray.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArraySort_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArraySort_0100
    * @tc.desc  : Sorts the ArkTS Array and returns the sorted Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArraySort_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArraySort_0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(4, 3, 2, 1);
        console.log(`${caseName} array sort before ${array.length}`);
        let newArray: collections.Array<number> = array.sort((a: number, b: number) => a - b);
        console.log(`${caseName} array sort after newArray ${newArray.length}`);
        expect(1).assertEqual(newArray[0]);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArraySort_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArraySort_0200
    * @tc.desc  : Sorts the ArkTS Array and returns the sorted Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArraySort_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArraySort_0200';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} array sort before ${array.length}`);
        let newArray: collections.Array<number> = array.sort((a: number, b: number) => b - a);
        console.log(`${caseName} array sort after newArray ${newArray.length}`);
        expect(4).assertEqual(newArray[0]);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArraySort_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArraySort_0300
    * @tc.desc  : Sorts the ArkTS Array and returns the sorted Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArraySort_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArraySort_0300';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} array sort before ${array.length}`);
        let newArray: collections.Array<number> = array.sort(undefined);
        console.log(`${caseName} array sort after newArray ${newArray.length}`);
        expect(1).assertEqual(newArray[0]);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIndexOf_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIndexOf_0100
    * @tc.desc  : Returns the index where the search element first appears in ArkTS Array, or-1 if it does not exist.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIndexOf_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIndexOf_0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<string> = new collections.Array<string>('a', 'b', 'c', 'd');
        let index: number = array.indexOf('b');
        console.log(`${caseName} index ${index}`);
        expect(1).assertEqual(index);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIndexOf_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIndexOf_0300
    * @tc.desc  : Returns the index where the search element first appears in ArkTS Array, or-1 if it does not exist.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIndexOf_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIndexOf_0300';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<string> = new collections.Array<string>(' ', ' ', 'a', 'b');
        let index: number = array.indexOf('b');
        console.log(`${caseName} index ${index}`);
        expect(3).assertEqual(index);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIndexOf_0400
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIndexOf_0400
    * @tc.desc  : Returns the index where the search element first appears in ArkTS Array, or-1 if it does not exist.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIndexOf_0400', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_testArrayIndexOf0400';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<string> = new collections.Array<string>('a', 'b', 'c');
        let index: number = array.indexOf('d');
        console.log(`${caseName} index ${index}`);
        expect(-1).assertEqual(index);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayForEach_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayForEach_0100
    * @tc.desc  : Executes the provided callback function on each element in the Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayForEach_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayForEach_0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        let num: number = 0;
        array.forEach(() => {
          num++;
        });
        expect(array.length).assertEqual(num);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });


    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayForEach_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayForEach_0200
    * @tc.desc  : Executes the provided callback function on each element in the Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayForEach_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayForEach_0300';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        array.forEach((value: number) => {
          expect('number').assertEqual(typeof value);
        });
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayMap_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayMap_0100
    * @tc.desc  : Executes the provided callback function on each element in the Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayMap_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayMap_0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} array ${array.length}`);
        let mapArray: collections.Array<number> = array.map((value: number) => {
          return value + 2;
        });
        console.log(`${caseName} filter ${mapArray.length}`);
        expect(3).assertEqual(mapArray[0]);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayMap_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayMap_0200
    * @tc.desc  : Executes the provided callback function on each element in the Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayMap_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayMap_0200';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4);
        console.log(`${caseName} array ${array.length}`);
        array.map((value: number, index: number, arr: collections.Array<number>) => {
          expect(arr[index]).assertEqual(value);
          return value + 2;
        });
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });


    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFilter_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFilter_0100
    * @tc.desc  : Returns a new Array that contains all the elements tested by the specified callback function.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFilter_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFilter_0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        let filterArray: collections.Array<number> = array.filter((value: number) => {
          return value > 5;
        });
        console.log(`${caseName} map ${filterArray.length}`);
        expect(filterArray[0] > 5);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFilter_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFilter_0200
    * @tc.desc  : Returns a new Array that contains all the elements tested by the specified callback function.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFilter_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFilter_0200';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        let filterArray: collections.Array<number> = array.filter((value: number, index: number, arr: collections.Array<number>) => {
          expect(arr[index]).assertEqual(value);
          return value > 5;
        });
        console.log(`${caseName} filter ${filterArray.length}`);
        expect(true).assertEqual(filterArray[0] > 5);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayReduce_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayReduce_0100
    * @tc.desc  : Returns a new Array that contains all the elements tested by the specified callback function.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayReduce_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayReduce_0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        let sum: number = array.reduce((accumulator: number, value: number) => accumulator + value);
        console.log(`${caseName} reduce ${sum}`);
        expect(55).assertEqual(sum);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayReduce_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayReduce_0200
    * @tc.desc  : Returns a new Array that contains all the elements tested by the specified callback function.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayReduce_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayReduce_0200';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        let sum: number = array.reduce((accumulator: number, value: number) => accumulator + value, 0);
        console.log(`${caseName} reduce ${sum}`);
        expect(55).assertEqual(sum);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayReduce_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayReduce_0300
    * @tc.desc  : Returns a new Array that contains all the elements tested by the specified callback function.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayReduce_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayReduce_0300';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        let sum: number = array.reduce((accumulator: number, value: number) => accumulator + value, 10);
        console.log(`${caseName} reduce ${sum}`);
        expect(65).assertEqual(sum);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayReduce_0400
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayReduce_0400
    * @tc.desc  : Returns a new Array that contains all the elements tested by the specified callback function.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayReduce_0400', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayReduce_0400';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        let sum: number = array.reduce((accumulator: number, value: number) => accumulator + value, -1);
        console.log(`${caseName} reduce ${sum}`);
        expect(54).assertEqual(sum);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayAt_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayAt_0100
    * @tc.desc  : Returns the element at the specified index position in the Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayAt_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayAt_0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        let atIndex: number | undefined = array.at(0);
        console.log(`${caseName} at ${atIndex}`);
        expect(1).assertEqual(atIndex);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayAt_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayAt_0200
    * @tc.desc  : Returns the element at the specified index position in the Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayAt_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayAt_0200';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        let atIndex: number | undefined = array.at(-1);
        console.log(`${caseName} at ${atIndex}`);
        expect(10).assertEqual(atIndex);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayAt_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayAt_0300
    * @tc.desc  : Returns the element at the specified index position in the Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayAt_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayAt_0300';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        let atIndex: number | undefined = array.at(11);
        console.log(`${caseName} at ${atIndex}`);
        expect(undefined).assertEqual(atIndex);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayAt_0400
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayAt_0400
    * @tc.desc  : Returns the element at the specified index position in the Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayAt_0400', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayAt_0400';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        let atIndex: number | undefined = array.at(0.1);
        console.log(`${caseName} at ${atIndex}`);
        expect(1).assertEqual(atIndex);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayEntries_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayEntries_0100
    * @tc.desc  : Returns a new iterable object that contains key-value pairs for each element in the Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayEntries_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayEntries_0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>();
        console.log(`${caseName} array ${array.length}`);
        let iterator: Iterator<Array<number>> = array.entries();
        console.log(`${caseName} entries ${JSON.stringify(iterator)}`);
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
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayEntries_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayEntries_0200
    * @tc.desc  : Returns a new iterable object that contains key-value pairs for each element in the Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayEntries_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayEntries_0200';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        let iterator: Iterator<Array<number>> = array.entries();
        console.log(`${caseName} entries ${JSON.stringify(iterator)}`);
        let value: Array<number> = iterator.next().value;
        console.log(`${caseName} entries  value ${value}`);
        expect(0).assertEqual(value[0]);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayKeys_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayKeys_0100
    * @tc.desc  : Returns a new iterable object that contains the key for each element in the Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayKeys_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayKeys_0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>();
        console.log(`${caseName} array ${array.length}`);
        let iterator: Iterator<number> = array.keys();
        console.log(`${caseName} entries ${JSON.stringify(iterator)}`);
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
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayKeys_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayKeys_0200
    * @tc.desc  : Returns a new iterable object that contains the key for each element in the Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayKeys_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayKeys_0200';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        let iterator: Iterator<number> = array.keys();
        console.log(`${caseName} iterator ${JSON.stringify(iterator)}`);
        let value: number = iterator.next().value;
        console.log(`${caseName} keys  value${value}`);
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
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayValues_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayValues_0100
    * @tc.desc  : Returns a new iterable object that contains the value of each element in the Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayValues_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayValues_0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>();
        console.log(`${caseName} array ${array.length}`);
        let iterator: Iterator<number> = array.values();
        console.log(`${caseName} values ${JSON.stringify(iterator)}`);
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
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayValues_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayValues_0200
    * @tc.desc  : Returns a new iterable object that contains the value of each element in the Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayValues_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayValues_0200';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        let iterator: Iterator<number> = array.values();
        console.log(`${caseName} iterator ${JSON.stringify(iterator)}`);
        let value: number = iterator.next().value;
        console.log(`${caseName} values  value ${value}`);
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
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFind_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFind_0100
    * @tc.desc  : Returns a new iterable object that contains the value of each element in the Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFind_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFind_0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        let findValue: number | undefined = array.find((value: number) => value > 5);
        console.log(`${caseName} find ${findValue}`);
        expect(6).assertEqual(findValue);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFind_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFind_0200
    * @tc.desc  : Returns a new iterable object that contains the value of each element in the Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFind_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFind_0200';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>();
        console.log(`${caseName} array ${array.length}`);
        let findValue: number | undefined = array.find((value: number) => value > 5);
        console.log(`${caseName} find ${findValue}`);
        expect(undefined).assertEqual(findValue);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFind_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFind_0300
    * @tc.desc  : Returns a new iterable object that contains the value of each element in the Array.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFind_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFind_0300';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9);
        console.log(`${caseName} array ${array.length}`);
        let findValue: number | undefined = array.find((value: number) => value === 10);
        console.log(`${caseName} find ${findValue}`);
        expect(undefined).assertEqual(findValue);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0100
    * @tc.desc  : Determines whether the Array contains the specified element and returns a Boolean value.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9);
        console.log(`${caseName} array ${array.length}`);
        let findValue: boolean = array.includes(5);
        console.log(`${caseName} includes ${findValue}`);
        expect(true).assertEqual(findValue);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0200
    * @tc.desc  : Determines whether the Array contains the specified element and returns a Boolean value.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0200';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>();
        console.log(`${caseName} array ${array.length}`);
        let findValue: boolean = array.includes(5);
        console.log(`${caseName} includes ${findValue}`);
        expect(false).assertEqual(findValue);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0300
    * @tc.desc  : Determines whether the Array contains the specified element and returns a Boolean value.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0300';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        let findValue: boolean = array.includes(11);
        console.log(`${caseName} includes ${findValue}`);
        expect(false).assertEqual(findValue);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0400
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0400
    * @tc.desc  : Determines whether the Array contains the specified element and returns a Boolean value.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0400', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0400';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        let findValue: boolean = array.includes(5, 6);
        console.log(`${caseName} includes ${findValue}`);
        expect(false).assertEqual(findValue);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0500
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0500
    * @tc.desc  : Determines whether the Array contains the specified element and returns a Boolean value.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0500', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0500';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        let findValue: boolean = array.includes(5, -1);
        console.log(`${caseName} includes ${findValue}`);
        expect(false).assertEqual(findValue);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0600
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0600
    * @tc.desc  : Determines whether the Array contains the specified element and returns a Boolean value.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0600', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0600';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        let findValue: boolean = array.includes(5, 11);
        console.log(`${caseName} includes ${findValue}`);
        expect(false).assertEqual(findValue);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0700
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0700
    * @tc.desc  : Determines whether the Array contains the specified element and returns a Boolean value.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0700', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0700';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        let findValue: boolean = array.includes(5, 2.5);
        console.log(`${caseName} includes ${findValue}`);
        expect(true).assertEqual(findValue);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0800
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0800
    * @tc.desc  : Determines whether the Array contains the specified element and returns a Boolean value.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0800', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayIncludes_0800';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        let findValue: boolean = array.includes(5, undefined);
        console.log(`${caseName} includes ${findValue}`);
        expect(true).assertEqual(findValue);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFindIndex_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFindIndex_0100
    * @tc.desc  : Returns the index of the first element in Array that satisfies the specified test function, or-1 if none of the elements are satisfied.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFindIndex_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFindIndex_0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        let findValue: number | undefined = array.findIndex((value: number) => value > 5);
        console.log(`${caseName} findIndex ${findValue}`);
        expect(5).assertEqual(findValue);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFindIndex_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFindIndex_0200
    * @tc.desc  : Returns the index of the first element in Array that satisfies the specified test function, or-1 if none of the elements are satisfied.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFindIndex_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFindIndex_0200';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>();
        console.log(`${caseName} array ${array.length}`);
        let findValue: number | undefined = array.findIndex((value: number) => value > 5);
        console.log(`${caseName} findIndex ${findValue}`);
        expect(-1).assertEqual(findValue);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFindIndex_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFindIndex_0300
    * @tc.desc  : Returns the index of the first element in Array that satisfies the specified test function, or-1 if none of the elements are satisfied.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFindIndex_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFindIndex_0300';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9);
        console.log(`${caseName} array ${array.length}`);
        let findValue: number | undefined = array.findIndex((value: number) => value === 10);
        console.log(`${caseName} findIndex ${findValue}`);
        expect(-1).assertEqual(findValue);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0100
    * @tc.desc  : Fills all elements in the specified range of Array with the specified values.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>();
        console.log(`${caseName} array ${array.length}`);
        let fillArray: collections.Array<number> = array.fill(0);
        console.log(`${caseName} fill ${fillArray.length}`);
        console.log(`${caseName} array fill ${array.length}`);
        expect(0).assertEqual(fillArray.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0200
    * @tc.desc  : Fills all elements in the specified range of Array with the specified values.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0200';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1);
        console.log(`${caseName} array ${array.length}`);
        let fillArray: collections.Array<number> = array.fill(0);
        console.log(`${caseName} fill ${fillArray.length} ${fillArray}`);
        console.log(`${caseName} array fill ${array.length}`);
        expect(0).assertEqual(fillArray[0]);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0300
    * @tc.desc  : Fills all elements in the specified range of Array with the specified values.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0300';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3);
        console.log(`${caseName} array ${array.length}`);
        let fillArray: collections.Array<number> = array.fill(0, 1, 2);
        console.log(`${caseName} fill ${fillArray.length} ${fillArray}`);
        console.log(`${caseName} array fill ${array.length}`);
        expect(true).assertEqual(fillArray[0] === 1 && fillArray[1] === 0 && fillArray[2] === 3);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0400
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0400
    * @tc.desc  : Fills all elements in the specified range of Array with the specified values.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0400', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0400';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3);
        console.log(`${caseName} array ${array.length}`);
        let fillArray: collections.Array<number> = array.fill(0, -1, 2);
        console.log(`${caseName} fill ${fillArray.length} ${fillArray}`);
        console.log(`${caseName} array fill ${array.length}`);
        expect(true).assertEqual(fillArray[0] === 1 && fillArray[1] === 2 && fillArray[2] === 3);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0500
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0500
    * @tc.desc  : Fills all elements in the specified range of Array with the specified values.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0500', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0500';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3);
        console.log(`${caseName} array ${array.length}`);
        let fillArray: collections.Array<number> = array.fill(0, 1, -1);
        console.log(`${caseName} fill ${fillArray.length} ${fillArray}`);
        console.log(`${caseName} array fill ${array.length}`);
        expect(true).assertEqual(fillArray[0] === 1 && fillArray[1] === 0 && fillArray[2] === 3);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0600
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0600
    * @tc.desc  : Fills all elements in the specified range of Array with the specified values.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0600', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0600';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3);
        console.log(`${caseName} array ${array.length}`);
        let fillArray: collections.Array<number> = array.fill(0, 3, 2);
        console.log(`${caseName} fill ${fillArray.length} ${fillArray}`);
        console.log(`${caseName} array fill ${array.length}`);
        expect(true).assertEqual(fillArray[0] === 1 && fillArray[1] === 2 && fillArray[2] === 3);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0700
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0700
    * @tc.desc  : Fills all elements in the specified range of Array with the specified values.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0700', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0700';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3);
        console.log(`${caseName} array ${array.length}`);
        let fillArray: collections.Array<number> = array.fill(0, 1, 3);
        console.log(`${caseName} fill ${fillArray.length} ${fillArray}`);
        console.log(`${caseName} array fill ${array.length}`);
        expect(true).assertEqual(fillArray[0] === 1 && fillArray[1] === 0 && fillArray[2] === 0);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0800
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0800
    * @tc.desc  : Fills all elements in the specified range of Array with the specified values.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0800', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0800';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3);
        console.log(`${caseName} array ${array.length}`);
        let fillArray: collections.Array<number> = array.fill(0, undefined, 2);
        console.log(`${caseName} fill ${fillArray.length} ${fillArray}`);
        console.log(`${caseName} array fill ${array.length}`);
        expect(true).assertEqual(fillArray[0] === 0 && fillArray[1] === 0 && fillArray[2] === 3);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0900
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0900
    * @tc.desc  : Fills all elements in the specified range of Array with the specified values.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_0900', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_testArrayFill0900';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3);
        console.log(`${caseName} array ${array.length}`);
        let fillArray: collections.Array<number> = array.fill(0, 1, undefined);
        console.log(`${caseName} fill ${fillArray.length} ${fillArray}`);
        console.log(`${caseName} array fill ${array.length}`);
        expect(true).assertEqual(fillArray[0] === 1 && fillArray[1] === 0 && fillArray[2] === 0);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_1000
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_1000
    * @tc.desc  : Fills all elements in the specified range of Array with the specified values.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_1000', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayFill_1000';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3);
        console.log(`${caseName} array ${array.length}`);
        let fillArray: collections.Array<number> = array.fill(3, 2, 1);
        console.log(`${caseName} fill ${fillArray.length} ${fillArray}`);
        console.log(`${caseName} array fill ${array.length}`);
        expect(true).assertEqual(fillArray[0] === 1 && fillArray[1] === 2 && fillArray[2] === 3);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShrinkTo_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShrinkTo_0100
    * @tc.desc  : Shrinks the Array to the specified length.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShrinkTo_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShrinkTo_0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        array.shrinkTo(1);
        console.log(`${caseName} shrinkTo ${array.length} `);
        expect(1).assertEqual(array.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShrinkTo_0200
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShrinkTo_0200
    * @tc.desc  : Shrinks the Array to the specified length.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShrinkTo_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShrinkTo_0200';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>();
        console.log(`${caseName} array ${array.length}`);
        array.shrinkTo(1);
        console.log(`${caseName} shrinkTo ${array.length} `);
        expect(0).assertEqual(array.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShrinkTo_0300
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShrinkTo_0300
    * @tc.desc  : Shrinks the Array to the specified length.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShrinkTo_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShrinkTo_0300';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3);
        console.log(`${caseName} array ${array.length}`);
        array.shrinkTo(10);
        console.log(`${caseName} shrinkTo ${array.length} `);
        expect(3).assertEqual(array.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShrinkTo_0400
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShrinkTo_0400
    * @tc.desc  : Shrinks the Array to the specified length.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShrinkTo_0400', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShrinkTo_0400';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3);
        console.log(`${caseName} array ${array.length}`);
        array.shrinkTo(-1);
        console.log(`${caseName} shrinkTo ${array.length} `);
        expect().assertFail();
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect(401).assertEqual(error.code);
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShrinkTo_0500
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShrinkTo_0500
    * @tc.desc  : Shrinks the Array to the specified length.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShrinkTo_0500', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayShrinkTo_0500';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3);
        console.log(`${caseName} array ${array.length}`);
        array.shrinkTo(1.2);
        console.log(`${caseName} shrinkTo ${array.length} `);
        expect().assertFail();
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect(401).assertEqual(error.code);
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
    * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayExtendTo_0100
    * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayExtendTo_0100
    * @tc.desc  : Expands the Array to the specified length, and the extended part is filled with the given value.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : level 2
    */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayExtendTo_0100', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayExtendTo_0100';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3);
        console.log(`${caseName} array ${array.length}`);
        array.extendTo(5, 10);
        console.log(`${caseName} extendTo ${array.length} `);
        expect(5).assertEqual(array.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
     * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayExtendTo_0200
     * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayExtendTo_0200
     * @tc.desc  : Expands the Array to the specified length, and the extended part is filled with the given value.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : level 2
     */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayExtendTo_0200', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayExtendTo_0200';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3);
        console.log(`${caseName} array ${array.length}`);
        array.extendTo(2, 10);
        console.log(`${caseName} extendTo ${array.length} `);
        expect(3).assertEqual(array.length);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
     * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayExtendTo_0300
     * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayExtendTo_0300
     * @tc.desc  : Expands the Array to the specified length, and the extended part is filled with the given value.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : level 2
     */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayExtendTo_0300', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayExtendTo_0300';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3);
        console.log(`${caseName} array ${array.length}`);
        array.extendTo(-1, 10);
        console.log(`${caseName} extendTo ${array.length} `);
        expect().assertFail();
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect(401).assertEqual(error.code);
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
     * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayExtendTo_0400
     * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayExtendTo_0400
     * @tc.desc  : Expands the Array to the specified length, and the extended part is filled with the given value.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : level 2
     */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayExtendTo_0400', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayExtendTo_0400';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3);
        console.log(`${caseName} array ${array.length}`);
        array.extendTo(1.2, 10);
        console.log(`${caseName} extendTo ${array.length} `);
        expect().assertEqual(false);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}}`);
        expect(401).assertEqual(error.code);
        done();
      }
      console.log(`${caseName} test end `);
    });

    /* *
     * @tc.number: ACTS_ARKUIX_ArkTS_Language_Backend_ArrayExtendTo_0500
     * @tc.name  : ACTS_ARKUIX_ArkTS_Language_Backend_ArrayExtendTo_0500
     * @tc.desc  : Expands the Array to the specified length, and the extended part is filled with the given value.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : level 2
     */
    it('ACTS_ARKUIX_ArkTS_Language_Backend_ArrayExtendTo_0500', 0, async (done: Function) => {
      let caseName: string = 'ACTS_ARKUIX_ArkTS_Language_Backend_ArrayExtendTo_0500';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>();
        console.log(`${caseName} array ${array.length}`);
        array.extendTo(3, 10);
        console.log(`${caseName} extendTo ${array.length} `);
        expect(3).assertEqual(array.length);
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