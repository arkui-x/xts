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

import { describe, expect, it, Level, Size, TestType } from '@ohos/hypium';
import collections from '@arkts.collections';

class NormalClass {
  public value: number;

  constructor(value: number) {
    this.value = value;
  }
}

export default function Uint32Test2() {
  describe('Uint32Test2', () => {

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_UINT32ARRAY_LASTINDEXOF_0100
     * @tc.name       : testUint32ArrayLastIndexOf0001
     * @tc.desc       : Testing whether lastIndexOf returns the first index of the given element or -1 if it does not exist.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testUint32ArrayLastIndexOf0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testUint32ArrayLastIndexOf0001";
      try {
        let array: collections.Uint32Array = collections.Uint32Array.from([1, 2, 3, 4, 3, 5, 3, 6, 3, 3]);
        let res: number = array.lastIndexOf(3, 5);
        expect(res).assertEqual(4);
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
      done()
    })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_UINT32ARRAY_LASTINDEXOF_0200
     * @tc.name       : testUint32ArrayLastIndexOf0002
     * @tc.desc       : Testing whether lastIndexOf returns the first index of the given element or -1 if it does not exist.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testUint32ArrayLastIndexOf0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testUint32ArrayLastIndexOf0002";
      try {
        let array: collections.Uint32Array = collections.Uint32Array.from([1, 2, 3, 4, 3, 5, 3, 6, 3, 3]);
        let res: number = array.lastIndexOf(3);
        expect(res).assertEqual(9);
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
      done()
    })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_UINT32ARRAY_LASTINDEXOF_0300
     * @tc.name       : testUint32ArrayLastIndexOf0003
     * @tc.desc       : Testing whether lastIndexOf returns the first index of the given element or -1 if it does not exist.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testUint32ArrayLastIndexOf0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const TAG = "testUint32ArrayLastIndexOf0003";
      try {
        let array: collections.Uint32Array = collections.Uint32Array.from([1, 2, 3, 4, 3, 5, 3, 6, 3, 3]);
        let res: number = array.lastIndexOf(3, -1);
        expect(res).assertEqual(array.length - 1);
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
      done()
    })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_UINT32ARRAY_LASTINDEXOF_0400
     * @tc.name       : testUint32ArrayLastIndexOf0004
     * @tc.desc       : Testing whether lastIndexOf returns the first index of the given element or -1 if it does not exist.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testUint32ArrayLastIndexOf0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testUint32ArrayLastIndexOf0004';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        let array = new collections.Uint32Array([1, 2, 3, 4, 5]);
        const normal = new NormalClass(10);
        const unbound = array.lastIndexOf;
        const bound: () => void = unbound.bind(normal);
        try {
          bound()
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200011)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_UINT32ARRAY_LASTINDEXOF_0500
     * @tc.name       : testUint32ArrayLastIndexOf0005
     * @tc.desc       : Testing whether lastIndexOf returns the first index of the given element or -1 if it does not exist.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testUint32ArrayLastIndexOf0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testUint32ArrayLastIndexOf0005';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          let array = new collections.Uint32Array([1, 2, 3, 4, 5]);
          array.forEach((value, key, array) => {
            array.fill(1, 4).forEach((value, key, array) => {
              array.fill(1, 4).lastIndexOf(9, 2)
              console.info(`m[${key}] = ${value}`);
            });
          });
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200201)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_UINT32ARRAY_REDUCERIGHT_0100
     * @tc.name       : testUint32ArrayReduceRight0001
     * @tc.desc       : Testing a reduction function on each element and returning the final result.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testUint32ArrayReduceRight0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testUint32ArrayReduceRight0001";
      try {
        let array: collections.Uint32Array = collections.Uint32Array.from([]);
        let num = array.reduceRight((accumulator: number, value: number) => accumulator + value);
        expect(num).assertEqual(0);
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        done();
      }
      done()
    })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_UINT32ARRAY_REDUCERIGHT_0200
     * @tc.name       : testUint32ArrayReduceRight0002
     * @tc.desc       : Testing a reduction function on each element and returning the final result.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testUint32ArrayReduceRight0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testUint32ArrayReduceRight0002";
      try {
        const array: collections.Uint32Array = collections.Uint32Array.from([1, 2, 3, 4, 5]);
        const initialAccumulator = 8;
        const expectedValues: number[] = [23, 22, 20, 17, 13];
        let reduceRightdValue: number = array.reduceRight((accumulator: number, value: number, index: number) => {
          const newAccumulator = accumulator + value;
          expect(newAccumulator).assertEqual(expectedValues[index]);
          return newAccumulator;
        }, initialAccumulator);
        expect(reduceRightdValue).assertEqual(23);
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
      done()
    })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_UINT32ARRAY_REDUCERIGHT_0300
     * @tc.name       : testUint32ArrayReduceRight0003
     * @tc.desc       : Testing a reduction function on each element and returning the final result.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testUint32ArrayReduceRight0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testUint32ArrayReduceRight0003";
      try {
        let array: collections.Uint32Array = collections.Uint32Array.from([1, 2, 3, 4, 5]);
        let initialValue = "initialValue";
        let reduceRightdValue: string = array.reduceRight<string>((accumulator: string, value: number) =>
        accumulator + value, initialValue);
        expect(reduceRightdValue).assertEqual('initialValue54321');
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
      done()
    })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_UINT32ARRAY_REDUCERIGHT_0400
     * @tc.name       : testUint32ArrayReduceRight0004
     * @tc.desc       : Testing a reduction function on each element and returning the final result.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testUint32ArrayReduceRight0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testUint32ArrayReduceRight0004';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        let array = new collections.Uint32Array([1, 2, 3, 4, 5]);
        const normal = new NormalClass(10);
        const unbound = array.reduceRight;
        const bound: () => void = unbound.bind(normal);
        try {
          bound()
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200011)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_UINT32ARRAY_REDUCERIGHT_0500
     * @tc.name       : testUint32ArrayReduceRight0005
     * @tc.desc       : Testing a reduction function on each element and returning the final result.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testUint32ArrayReduceRight0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testUint32ArrayReduceRight0005';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          let array = new collections.Uint32Array([1, 2, 3, 4, 5]);
          array.forEach((value, key, array) => {
            array.fill(1, 4).forEach((value, key, array) => {
              array.fill(1, 4).reduceRight((accumulator: number, value: number) => accumulator + value);
              console.info(`m[${key}] = ${value}`);
            });
          });
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200201)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_UINT32ARRAY_TOSTRING_0100
     * @tc.name       : testUint32ArrayToString0001
     * @tc.desc       : Test the function of the interface ArkTS Array ToString.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testUint32ArrayToString0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testUint32ArrayToString0001";
      try {
        const array1 = new collections.Uint32Array([1, 2, 3]);
        const iterator1 = array1.toString();
        console.log(`${TAG} result:` + iterator1);
        expect(iterator1).assertEqual('1,2,3');
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_UINT32ARRAY_TOSTRING_0200
     * @tc.name       : testUint32ArrayToString0002
     * @tc.desc       : Test the function of the interface ArkTS Array ToString.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testUint32ArrayToString0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testUint32ArrayToString0002';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        let array = new collections.Uint32Array([1, 2, 3, 4, 5]);
        const normal = new NormalClass(10);
        const unbound = array.toString;
        const bound: () => void = unbound.bind(normal);
        try {
          bound()
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200011)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_UINT32ARRAY_TOSTRING_0300
     * @tc.name       : testUint32ArrayToString0003
     * @tc.desc       : Test the function of the interface ArkTS Array ToString.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testUint32ArrayToString0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testUint32ArrayToString0003';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          let array = new collections.Uint32Array([1, 2, 3, 4, 5]);
          array.forEach((value, key, array) => {
            array.fill(1, 4).toString()
            console.info(`m[${key}] = ${value}`);
          });
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200201)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_UINT32ARRAY_TOLOCALESTRING_0100
     * @tc.name       : testUint32ArrayToLocaleString0001
     * @tc.desc       : Test the function of the interface ArkTS Array ToLocaleString.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testUint32ArrayToLocaleString0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testUint32ArrayToLocaleString0001";
        try {
          const array1 = new collections.Uint32Array([1, 2, 3]);
          const iterator1 = array1.toLocaleString();
          console.log(`${TAG} result:` + iterator1);
          expect(iterator1).assertEqual('1,2,3');
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
        done()
      });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_UINT32ARRAY_TOLOCALESTRING_0200
     * @tc.name       : testUint32ArrayToLocaleString0002
     * @tc.desc       : Test the function of the interface ArkTS Array ToLocaleString.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testUint32ArrayToLocaleString0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testUint32ArrayToLocaleString0002';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        let array = new collections.Uint32Array([1, 2, 3, 4, 5]);
        const normal = new NormalClass(10);
        const unbound = array.toLocaleString;
        const bound: () => void = unbound.bind(normal);
        try {
          bound()
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200011)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_UINT32ARRAY_TOLOCALESTRING_0300
     * @tc.name       : testUint32ArrayToLocaleString0003
     * @tc.desc       : Test the function of the interface ArkTS Array ToLocaleString.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testUint32ArrayToLocaleString0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testUint32ArrayToLocaleString0003';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          let array = new collections.Uint32Array([1, 2, 3, 4, 5]);
          array.forEach((value, key, array) => {
            array.fill(1, 4).toLocaleString()
            console.info(`m[${key}] = ${value}`);
          });
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200201)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_UINT32ARRAY_OF_0100
     * @tc.name       : testUint32ArrayOf0001
     * @tc.desc       : Test the function of the interface Of
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testUint32ArrayOf0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testUint32ArrayOf0001";
      try {
        let result: collections.Uint32Array = collections.Uint32Array.of(1);
        expect(result.toString()).assertEqual('1');
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
      done()
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_UINT32ARRAY_OF_0200
     * @tc.name       : testUint32ArrayOf0002
     * @tc.desc       : Test the function of the interface Of
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testUint32ArrayOf0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testUint32ArrayOf0002";
      try {
        let result: collections.Uint32Array = collections.Uint32Array.of(1, 2, 3);
        expect(result.toString()).assertEqual('1,2,3');
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
      done()
    });
  })
}
