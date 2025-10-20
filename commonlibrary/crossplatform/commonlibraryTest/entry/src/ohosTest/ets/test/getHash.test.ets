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
import Stack from '@ohos.util.Stack';
import {
  ArrayList,
  buffer,
  Deque,
  HashMap,
  HashSet,
  LightWeightMap,
  LightWeightSet,
  LinkedList,
  PlainArray,
  Queue,
  TreeMap,
  TreeSet,
  uri,
  url,
  util
} from '@kit.ArkTS';

interface GeneratedObjectLiteralInterface_1 {
  name: string;
  age: number;
}

interface GeneratedObjectLiteralInterface_2 {
  gname: string;
  floor: string;
}

interface GeneratedObjectLiteralInterface_3 {
  name: string;
  age: number;
  grade: GeneratedObjectLiteralInterface_2;
}

interface GeneratedObjectLiteralInterface_5 {}

interface GeneratedObjectLiteralInterface_6 {
  "name": string;
  "isStudent": boolean;
  "score": null;
}

export default function GetHashTest() {
  describe('GetHashTest', () => {
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
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_0100
     * @tc.name       : testGetHash0001
     * @tc.desc       : Testing the getHash interface with value null.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetHash0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetHash0001';
      try {
        let value = null;
        let result = util.getHash(value);
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} failed, error code: ${err.code}`);
        expect(err.code).assertEqual(401);
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_0200
     * @tc.name       : testGetHash0002
     * @tc.desc       : Testing the getHash interface with value undefined.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetHash0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetHash0002';
      try {
        let value = undefined;
        let result = util.getHash(value);
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} failed, error code: ${err.code}`);
        expect(err.code).assertEqual(401);
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_0300
     * @tc.name       : testGetHash0003
     * @tc.desc       : Testing the getHash interface with json value.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetHash0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetHash0003';
      try {
        let person: GeneratedObjectLiteralInterface_1 = {
          name: "Alice",
          age: 30
        };
        let result1 = util.getHash(person);
        let result2 = util.getHash(person);
        expect(result1).assertEqual(result2);
      } catch (err) {
        console.error(`${TAG} failed, error code: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_UTILGETHASH_0400
     * @tc.name       : testGetHash0004
     * @tc.desc       : Testing the getHash interface with array value.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetHash0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetHash0004';
      try {
        let numbers = [1, 2, 3, 4, 5];
        let result1 = util.getHash(numbers);
        let result2 = util.getHash(numbers);
        expect(result1).assertEqual(result2);
      } catch (err) {
        console.error(`${TAG} failed, error code: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_0500
     * @tc.name       : testGetHash0005
     * @tc.desc       : Testing the getHash interface with class value.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetHash0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetHash0005';
      try {
        class Car {
          make: string;
          model: string;

          constructor(make: string, model: string) {
            this.make = make;
            this.model = model;
          }
        }

        let myCar = new Car("Toyota", "Corolla");
        let result1 = util.getHash(myCar);
        let result2 = util.getHash(myCar);
        expect(result1).assertEqual(result2);
      } catch (err) {
        console.error(`${TAG} failed, error code: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_0600
     * @tc.name       : testGetHash0006
     * @tc.desc       : Testing the getHash interface with date value.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetHash0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetHash0006';
      try {
        let time = new Date();
        let result1 = util.getHash(time);
        let result2 = util.getHash(time);
        expect(result1).assertEqual(result2);
      } catch (err) {
        console.error(`${TAG} failed, error code: ${err.code}`);
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_0700
     * @tc.name       : testGetHash0007
     * @tc.desc       : Testing the getHash interface with regular expression.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetHash0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetHash0007';
      try {
        let value = RegExp('^(\\-)?\\d+(\\.\\d{1,2})?$')
        let result1 = util.getHash(value);
        let result2 = util.getHash(value);
        expect(result1).assertEqual(result2);
      } catch (err) {
        console.error(`${TAG} failed, error code: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_0800
     * @tc.name       : testGetHash0008
     * @tc.desc       : Testing the getHash interface with math value.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetHash0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetHash0008';
      try {
        let mathObject = Math;
        let result1 = util.getHash(mathObject);
        let result2 = util.getHash(mathObject);
        expect(result1).assertEqual(result2);
      } catch (err) {
        console.error(`${TAG} failed, error code: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_0900
     * @tc.name       : testGetHash0009
     * @tc.desc       : Testing the getHash interface with math nested json.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetHash0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetHash0009';
      try {
        let person: GeneratedObjectLiteralInterface_3 = {
          name: "Alice",
          age: 30,
          grade: ({
            gname: '三年八班',
            floor: 'Three'
          } as GeneratedObjectLiteralInterface_2)
        };
        let result1 = util.getHash(person);
        let result2 = util.getHash(person);
        expect(result1).assertEqual(result2);
      } catch (err) {
        console.error(`${TAG} failed, error code: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_1000
     * @tc.name       : testGetHash0010
     * @tc.desc       : Testing the getHash interface with value {}.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetHash0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetHash0010';
      try {
        let value: GeneratedObjectLiteralInterface_5 = {};
        let result1 = util.getHash(value);
        let result2 = util.getHash(value);
        expect(result1).assertEqual(result2);
      } catch (err) {
        console.error(`${TAG} failed, error code: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_1100
     * @tc.name       : testGetHash0011
     * @tc.desc       : Testing the getHash interface with value {}.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetHash0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetHash0011';
      try {
        let value = [];
        let result1 = util.getHash(value);
        let result2 = util.getHash(value);
        expect(result1).assertEqual(result2);
      } catch (err) {
        console.error(`${TAG} failed, error code: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_1200
     * @tc.name       : testGetHash0012
     * @tc.desc       : Testing the getHash interface with special json.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetHash0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetHash0012';
      try {
        let value: GeneratedObjectLiteralInterface_6 = {
          "name": "小明",
          "isStudent": true,
          "score": null
        };
        let result1 = util.getHash(value);
        let result2 = util.getHash(value);
        expect(result1).assertEqual(result2);
      } catch (err) {
        console.error(`${TAG} failed, error code: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_1300
     * @tc.name       : testGetHash0013
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let TAG = 'testGetHash0013';
      try {
        let arr1 = [0, 1, 2, 3];
        let arr2 = new Array<number>();
        let result1 = util.getHash(arr1);
        let result2 = util.getHash(arr2);
        expect(result1 === result2).assertFalse();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_1400
     * @tc.name       : testGetHash0014
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let TAG = 'testGetHash0014';
      try {
        let a = new ArrayList<number>();
        a.add(7)
        let result1 = util.getHash(a);
        a.add(9);
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_1500
     * @tc.name       : testGetHash0015
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new LinkedList<number>();
        a.add(7)
        let result1 = util.getHash(a);
        a.add(9);
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_1600
     * @tc.name       : testGetHash0016
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new Set<number>();
        a.add(7)
        let result1 = util.getHash(a);
        a.add(9);
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_1700
     * @tc.name       : testGetHash0017
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0017', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new Map<number, number>();
        a.set(7, 0)
        let result1 = util.getHash(a);
        a.set(9, 2);
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_1800
     * @tc.name       : testGetHash0018
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0018', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new BigInt64Array(8);
        a[0] = 1n;
        let result1 = util.getHash(a);
        a[1] = 2n;
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_1900
     * @tc.name       : testGetHash0019
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0019', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new BigUint64Array(8);
        a[0] = 1n;
        let result1 = util.getHash(a);
        a[1] = 2n;
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_2000
     * @tc.name       : testGetHash0020
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0020', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new Float32Array(8);
        a[0] = 1;
        let result1 = util.getHash(a);
        a[1] = 2;
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_2100
     * @tc.name       : testGetHash0021
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0021', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new Float64Array(8);
        a[0] = 1;
        let result1 = util.getHash(a);
        a[1] = 2;
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_2200
     * @tc.name       : testGetHash0022
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0022', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new Int8Array(8);
        a[0] = 1;
        let result1 = util.getHash(a);
        a[1] = 2;
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_2300
     * @tc.name       : testGetHash0023
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0023', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new Int16Array(8);
        a[0] = 1;
        let result1 = util.getHash(a);
        a[1] = 2;
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_2400
     * @tc.name       : testGetHash0024
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0024', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new Int32Array(8);
        a[0] = 1;
        let result1 = util.getHash(a);
        a[1] = 2;
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
      } catch (err) {
        expect().assertFail();
      }
    });


    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_2500
     * @tc.name       : testGetHash0025
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0025', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new Uint8Array(8);
        a[0] = 1;
        let result1 = util.getHash(a);
        a[1] = 2;
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_2600
     * @tc.name       : testGetHash0026
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0026', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new Uint16Array(8);
        a[0] = 1;
        let result1 = util.getHash(a);
        a[1] = 2;
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_2700
     * @tc.name       : testGetHash0027
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0027', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new Uint32Array(8);
        a[0] = 1;
        let result1 = util.getHash(a);
        a[1] = 2;
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_2800
     * @tc.name       : testGetHash0028
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0028', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new Uint8ClampedArray(8);
        a[0] = 1;
        let result1 = util.getHash(a);
        a[1] = 2;
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_2900
     * @tc.name       : testGetHash0029
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0029', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = buffer.from([1, 2, 3]);
        let result1 = util.getHash(a);
        a.fill(1);
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
        let b = buffer.from([1, 2, 3]);
        expect(a === b).assertFalse();
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_3000
     * @tc.name       : testGetHash0030
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0030', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new url.URLParams("www.baidu.com");
        a.append("1", "kuku");
        let result1 = util.getHash(a);
        a.append("2", "kuku");
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
        let b = new url.URLParams("www.baidu.com");
        expect(a === b).assertFalse();
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_3100
     * @tc.name       : testGetHash0031
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0031', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new uri.URI("www.baidu.com");
        a.addQueryValue("1", "kuku");
        let result1 = util.getHash(a);
        a.addQueryValue("2", "kuku");
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
        let b = new uri.URI("www.baidu.com");
        expect(a === b).assertFalse();
      } catch (err) {
        expect().assertFail();
      }
    });
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_3200
     * @tc.name       : testGetHash0032
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0032', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new Deque<number>();
        a.insertFront(7);
        let result1 = util.getHash(a);
        a.insertFront(9);
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
        let b = new Deque<number>();
        b.insertFront(7);
        a.insertFront(9);
        expect(a === b).assertFalse();
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_3300
     * @tc.name       : testGetHash0033
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0033', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new HashMap<string, number>();
        a.set("1", 7);
        let result1 = util.getHash(a);
        a.set("3", 7);
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
        let b = new HashMap<string, number>();
        b.set("1", 7);
        b.set("3", 7);
        expect(a === b).assertFalse();
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_3400
     * @tc.name       : testGetHash0034
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0034', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new HashSet<string>();
        a.add("1");
        let result1 = util.getHash(a);
        a.add("3");
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
        let b = new HashSet<string>();
        b.add("1");
        b.add("3");
        expect(a === b).assertFalse();
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_3500
     * @tc.name       : testGetHash0035
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0035', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new LightWeightMap<string, number>();
        a.set("1", 1);
        let result1 = util.getHash(a);
        a.set("3", 3);
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
        let b = new LightWeightMap<string, number>();
        b.set("1", 1);
        b.set("3", 3);
        expect(a === b).assertFalse();
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_3600
     * @tc.name       : testGetHash0036
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0036', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new LightWeightSet<string>();
        a.add("1");
        let result1 = util.getHash(a);
        a.add("3");
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
        let b = new LightWeightSet<string>();
        b.add("1");
        b.add("3");
        expect(a === b).assertFalse();
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_3700
     * @tc.name       : testGetHash0037
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0037', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new LinkedList<string>();
        a.add("1");
        let result1 = util.getHash(a);
        a.add("3");
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
        let b = new LinkedList<string>();
        b.add("1");
        b.add("3");
        expect(a === b).assertFalse();
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_3800
     * @tc.name       : testGetHash0038
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0038', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new PlainArray<string>();
        a.add(0, "1");
        let result1 = util.getHash(a);
        a.add(1, "3");
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
        let b = new PlainArray<string>();
        b.add(0, "1");
        b.add(1, "3");
        expect(a === b).assertFalse();
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_3900
     * @tc.name       : testGetHash0039
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0039', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new ArrayList<string>();
        a.add("1");
        let result1 = util.getHash(a);
        a.add("3");
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
        let b = new ArrayList<string>();
        b.add("1");
        b.add("3");
        expect(a === b).assertFalse();
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_4000
     * @tc.name       : testGetHash0040
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0040', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new PlainArray<string>();
        a.add(0, "1");
        let result1 = util.getHash(a);
        a.add(3, "3");
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
        let b = new PlainArray<string>();
        b.add(0, "1");
        b.add(3, "3");
        expect(a === b).assertFalse();
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_4100
     * @tc.name       : testGetHash0041
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0041', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new Queue<string>();
        a.add("1");
        let result1 = util.getHash(a);
        a.add("3");
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
        let b = new Queue<string>();
        b.add("1");
        b.add("3");
        expect(a === b).assertFalse();
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_4200
     * @tc.name       : testGetHash0042
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0042', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new Stack<string>();
        a.push("1");
        let result1 = util.getHash(a);
        a.push("3");
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
        let b = new Stack<string>();
        b.push("1");
        b.push("3");
        expect(a === b).assertFalse();
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_4300
     * @tc.name       : testGetHash0043
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0043', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new TreeSet<string>();
        a.add("1");
        let result1 = util.getHash(a);
        a.add("3");
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
        let b = new TreeSet<string>();
        b.add("1");
        b.add("3");
        expect(a === b).assertFalse();
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_4400
     * @tc.name       : testGetHash0044
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0044', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let a = new TreeMap<string, number>();
        a.set("1", 1);
        let result1 = util.getHash(a);
        a.set("3", 3);
        let result2 = util.getHash(a);
        expect(result1).assertEqual(result2);
        let b = new TreeMap<string, number>();
        b.set("1", 1);
        b.set("3", 3);
        expect(a === b).assertFalse();
      } catch (err) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_4500
     * @tc.name       : testGetHash0045
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0045', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        util.getHash(null);
        expect().assertFail();
      } catch (err) {
        expect(err.code).assertEqual(401);
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETHASH_4600
     * @tc.name       : testGetHash0046
     * @tc.desc       : Testing the getHash interface
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testGetHash0046', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        util.getHash(undefined);
        expect().assertFail();
      } catch (err) {
        expect(err.code).assertEqual(401);
      }
    });
  })
}