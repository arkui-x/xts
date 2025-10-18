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
import { collections } from '@kit.ArkTS';

class NormalClass {
  public value: number;

  constructor(value: number) {
    this.value = value;
  }
}

export default function Uint8ClampedArrayTest2() {
  describe('Uint8ClampedArrayTest2', () => {

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_Uint8ClampedArray_LASTINDEXOF_0100
     * @tc.name       : testUint8ClampedArrayLastIndexOf0001
     * @tc.desc       : Testing whether lastIndexOf returns the first index of the given element or -1 if it does not exist.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testUint8ClampedArrayLastIndexOf0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testUint8ClampedArrayLastIndexOf0001";
        try {
          let array: collections.Uint8ClampedArray = collections.Uint8ClampedArray.from([1, 2, 3, 4, 3, 5, 3, 6, 3, 3]);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_Uint8ClampedArray_LASTINDEXOF_0200
     * @tc.name       : testUint8ClampedArrayLastIndexOf0002
     * @tc.desc       : Testing whether lastIndexOf returns the first index of the given element or -1 if it does not exist.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testUint8ClampedArrayLastIndexOf0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testUint8ClampedArrayLastIndexOf0002";
        try {
          let array: collections.Uint8ClampedArray = collections.Uint8ClampedArray.from([1, 2, 3, 4, 3, 5, 3, 6, 3, 3]);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_Uint8ClampedArray_LASTINDEXOF_0300
     * @tc.name       : testUint8ClampedArrayLastIndexOf0003
     * @tc.desc       : Testing whether lastIndexOf returns the first index of the given element or -1 if it does not exist.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testUint8ClampedArrayLastIndexOf0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testUint8ClampedArrayLastIndexOf0003";
        try {
          let array: collections.Uint8ClampedArray = collections.Uint8ClampedArray.from([1, 2, 3, 4, 3, 5, 3, 6, 3, 3]);
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
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_Uint8ClampedArray_LASTINDEXOF_0400
     * @tc.name      : testUint8ClampedArrayLastIndexOf0004
     * @tc.desc      : Uint8ClampedArray lastIndexOf 10200011
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testUint8ClampedArrayLastIndexOf0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testUint8ClampedArrayLastIndexOf0004';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        let array = new collections.Uint8ClampedArray([1, 2, 3, 4, 5]);
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
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_Uint8ClampedArray_LASTINDEXOF_0500
     * @tc.name      : testUint8ClampedArrayLastIndexOf0005
     * @tc.desc      : Uint8ClampedArray.lastIndexOf 10200201
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testUint8ClampedArrayLastIndexOf0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testUint8ClampedArrayLastIndexOf0005';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          let array = new collections.Uint8ClampedArray([1, 2, 3, 4, 5]);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_Uint8ClampedArray_REDUCERIGHT_0100
     * @tc.name       : testUint8ClampedArrayReduceRight0001
     * @tc.desc       : Testing a reduction function on each element and returning the final result.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testUint8ClampedArrayReduceRight0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testUint8ClampedArrayReduceRight0001";
        try {
          let array: collections.Uint8ClampedArray = collections.Uint8ClampedArray.from([]);
          array.reduceRight((accumulator: number, value: number) => accumulator + value);
          expect().assertFail();
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          done();
        }
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_Uint8ClampedArray_REDUCERIGHT_0200
     * @tc.name       : testUint8ClampedArrayReduceRight0002
     * @tc.desc       : Testing a reduction function on each element and returning the final result.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testUint8ClampedArrayReduceRight0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testUint8ClampedArrayReduceRight0002";
        try {
          const array: collections.Uint8ClampedArray = collections.Uint8ClampedArray.from([1, 2, 3, 4, 5]);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_Uint8ClampedArray_REDUCERIGHT_0300
     * @tc.name       : testUint8ClampedArrayReduceRight0003
     * @tc.desc       : Testing a reduction function on each element and returning the final result.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testUint8ClampedArrayReduceRight0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testUint8ClampedArrayReduceRight0003";
        try {
          let array: collections.Uint8ClampedArray = collections.Uint8ClampedArray.from([1, 2, 3, 4, 5]);
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
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_Uint8ClampedArray_REDUCERIGHT_0400
     * @tc.name      : testUint8ClampedArrayReduceRight0004
     * @tc.desc      : Uint8ClampedArray reduceRight 10200011
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testUint8ClampedArrayReduceRight0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testUint8ClampedArrayReduceRight0004';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        let array = new collections.Uint8ClampedArray([1, 2, 3, 4, 5]);
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
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_Uint8ClampedArray_REDUCERIGHT_0500
     * @tc.name      : testUint8ClampedArrayReduceRight0005
     * @tc.desc      : Uint8ClampedArray.reduceRight 10200201
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testUint8ClampedArrayReduceRight0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testUint8ClampedArrayReduceRight0005';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          let array = new collections.Uint8ClampedArray([1, 2, 3, 4, 5]);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_Uint8ClampedArray_TOSTRING_0100
     * @tc.name       : testUint8ClampedArrayToString0001
     * @tc.desc       : Testing create an ArrayBuffer with a not empty buffer.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testUint8ClampedArrayToString0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testUint8ClampedArrayToString0001";
        try {
          const array1 = new collections.Uint8ClampedArray([1, 2, 3]);
          const iterator1 = array1.toString();
          console.log(`${TAG} result:` + iterator1);
          expect(iterator1).assertEqual('1,2,3');
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_Uint8ClampedArray_TOSTRING_0200
     * @tc.name      : testUint8ClampedArrayToString0002
     * @tc.desc      : Uint8ClampedArray toString 10200011
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testUint8ClampedArrayToString0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testUint8ClampedArrayToString0002';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        let array = new collections.Uint8ClampedArray([1, 2, 3, 4, 5]);
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
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_Uint8ClampedArray_TOSTRING_0300
     * @tc.name      : testUint8ClampedArrayToString0003
     * @tc.desc      : ConcatArray toString 10200201
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testUint8ClampedArrayToString0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testUint8ClampedArrayToString0003';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          let array = new collections.Uint8ClampedArray([1, 2, 3, 4, 5]);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_Uint8ClampedArray_TOLOCALESTRING_0100
     * @tc.name       : testUint8ClampedArrayToLocalString0001
     * @tc.desc       : Test the function of the interface ArkTS Array ToLocaleString.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testUint8ClampedArrayToLocalString0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testUint8ClampedArrayToLocalString0001";
        try {
          const array1 = new collections.Uint8ClampedArray([1, 2, 3]);
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
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_Uint8ClampedArray_TOLOCALESTRING_0200
     * @tc.name      : testUint8ClampedArrayToLocalString0002
     * @tc.desc      : Uint8ClampedArray toLocaleString 10200011
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testUint8ClampedArrayToLocalString0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testUint8ClampedArrayToLocalString0002';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        let array = new collections.Uint8ClampedArray([1, 2, 3, 4, 5]);
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
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_Uint8ClampedArray_TOLOCALESTRING_0300
     * @tc.name      : testUint8ClampedArrayToLocalString0003
     * @tc.desc      : Uint8ClampedArray.toLocaleString 10200201
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testUint8ClampedArrayToLocalString0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testUint8ClampedArrayToLocalString0003';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          let array = new collections.Uint8ClampedArray([1, 2, 3, 4, 5]);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_Uint8ClampedArray_OF_0100
     * @tc.name       : testUint8ClampedArrayOf0001
     * @tc.desc       : Test the function of the interface Of
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testUint8ClampedArrayOf0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testUint8ClampedArrayOf0001";
      try {
        let result: collections.Uint8ClampedArray = collections.Uint8ClampedArray.of(1);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_Uint8ClampedArray_OF_0200
     * @tc.name       : testUint8ClampedArrayOf0002
     * @tc.desc       : Test the function of the interface Of
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testUint8ClampedArrayOf0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testUint8ClampedArrayOf0002";
      try {
        let result: collections.Uint8ClampedArray = collections.Uint8ClampedArray.of(1, 2, 3);
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
