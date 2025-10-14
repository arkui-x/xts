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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, Size, TestType } from '@ohos/hypium';
import { ArkTSUtils, collections, lang } from '@kit.ArkTS';

class NormalClass {
  public value: number;

  constructor(value: number) {
    this.value = value;
  }
}

export default function ArrayTest2() {
  describe('ArrayTest2', () => {

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_FROM_0100
     * @tc.name       : testArrayFrom0001
     * @tc.desc       : Testing Collections of Array from.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testArrayFrom0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const TAG = "testArrayFrom0001";
      try {
        let array: Array<string> = ['d', 'e', 'f'];
        let sendableArray = collections.Array.from<string>(array);
        console.info("sendableArray is: " + sendableArray);
        expect(sendableArray.toString()).assertEqual('d,e,f');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done()
    })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_FROM_0200
     * @tc.name       : testArrayFrom0002
     * @tc.desc       : Testing Collections of Array from.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testArrayFrom0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testArrayFrom0002';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          let array: Array<Array<string>> = [['str1', 'str2', 'str3'], ['str4', 'str5', 'str6'],
            ['str7', 'str8', 'str9']];
          let sendableArray = collections.Array.from<Array<string>>(array, (value, index) => value.copyWithin(2, 1, 2));
          console.info('array:', sendableArray)
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(401)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number: SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_FROM_0300
     * @tc.name  : testArrayFrom0003
     * @tc.desc  : Testing Collections of Array from.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('testArrayFrom0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let caseName: string = 'testArrayFrom0003';
      console.log(`${caseName} test start `);
      try {
        let arrayLike: ArrayLike<number> = [1, 2, 3];
        let array: collections.Array<string> =
          collections.Array.from<number, string>(arrayLike, (value: number, index: number) => value + "." + index);
        console.log(`${caseName} array length ${array.length}`);
        expect('1.0,2.1,3.2').assertEqual(array.toString());
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_FROM_0400
     * @tc.name  : testArrayFrom0004
     * @tc.desc  : Testing Collections of Array from.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('testArrayFrom0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let caseName: string = 'testArrayFrom0004';
      console.log(`${caseName} test start `);
      try {
        let arrayLike: ArrayLike<string> = ["str1", "str2", "str3"];
        let array: collections.Array<number> =
          collections.Array.from<string, number>(arrayLike, (value: string, index: number) => index * 2);
        console.log(`${caseName} array length ${array.length}`);
        expect('0,2,4').assertEqual(array.toString());
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_FROM_0500
     * @tc.name      : testArrayFrom0005
     * @tc.desc      : Testing Collections of Array from.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testArrayFrom0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testArrayFrom0005';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          let array: Array<Array<string>> = [['str1', 'str2', 'str3'], ['str4', 'str5', 'str6'],
            ['str7', 'str8', 'str9']];
          let sendableArray = collections.Array.from<Array<string>, string>(array, (value, index) => value[0]);
          console.info('array:', sendableArray)
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(401)
        }
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_ISARRAY_0100
     * @tc.name       : testArrayIsArray0001
     * @tc.desc       : Test the function of the interface Of
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testArrayIsArray0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const TAG = "testArrayIsArray0001";
        try {
          let array = new collections.Array(1, 2, 3);
          let result = collections.Array.isArray(array);
          expect(result).assertTrue();
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_ISARRAY_0200
     * @tc.name       : testArrayIsArray0002
     * @tc.desc       : Test the function of the interface Of
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testArrayIsArray0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const TAG = "testArrayIsArray0002";
        try {
          let arrayLike = [1, 2, 3];
          let result = collections.Array.isArray(arrayLike);
          expect(result).assertFalse();
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_OF_0100
     * @tc.name       : testArrayOf0001
     * @tc.desc       : Test the function of the interface Of
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testArrayOf0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const TAG = "testArrayOf0001";
      try {
        let result: collections.Array<number> = collections.Array.of(1, 2, 3);
        expect(JSON.stringify(result)).assertEqual('[1,2,3]');
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_OF_0200
     * @tc.name       : testArrayOf0002
     * @tc.desc       : Test the function of the interface Of
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testArrayOf0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const TAG = "testArrayOf0002";
      try {
        let result: collections.Array<string> = collections.Array.of("str1", "str2", "str3");
        expect(JSON.stringify(result)).assertEqual('["str1","str2","str3"]');
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_COPYWITHIN_0100
     * @tc.name       : testArrayCopyWithin0001
     * @tc.desc       : Test the function of the interface ArkTS Array CopyWithin
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testArrayCopyWithin0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const TAG = "testArrayCopyWithin0001";
      try {
        let arr1: collections.Array<number> = new collections.Array(1, 2, 3, 4, 5);
        const obj: collections.Array<number> = arr1.copyWithin(0, 3, 4);
        console.log(`${TAG} result:` + JSON.stringify(obj));
        expect(JSON.stringify(obj)).assertEqual('[4,2,3,4,5]');
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
      done()
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_COPYWITHIN_0200
     * @tc.name       : testArrayCopyWithin0002
     * @tc.desc       : Test the function of the interface ArkTS Array CopyWithin
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testArrayCopyWithin0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testArrayCopyWithin0002";
        try {
          let arr1: collections.Array<number> = new collections.Array(1, 2, 3, 4, 5);
          const obj: collections.Array<number> = arr1.copyWithin(-2, 1, 4);
          console.log(`${TAG} result:` + JSON.stringify(obj));
          expect(JSON.stringify(obj)).assertEqual('[1,2,3,2,3]');
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_COPYWITHIN_0300
     * @tc.name       : testArrayCopyWithin0003
     * @tc.desc       : Test the function of the interface ArkTS Array CopyWithin
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testArrayCopyWithin0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testArrayCopyWithin0003";
        try {
          let arr1: collections.Array<number> = new collections.Array(1, 2, 3, 4, 5);
          const obj: collections.Array<number> = arr1.copyWithin(0, -2, 4);
          console.log(`${TAG} result:` + JSON.stringify(obj));
          expect(JSON.stringify(obj)).assertEqual('[4,2,3,4,5]');
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_COPYWITHIN_0400
     * @tc.name       : testArrayCopyWithin0004
     * @tc.desc       : Test the function of the interface ArkTS Array CopyWithin
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testArrayCopyWithin0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testArrayCopyWithin0004";
        try {
          let arr1: collections.Array<number> = new collections.Array(1, 2, 3, 4, 5);
          const obj: collections.Array<number> = arr1.copyWithin(0, 3, -1);
          console.log(`${TAG} result:` + JSON.stringify(obj));
          expect(JSON.stringify(obj)).assertEqual('[4,2,3,4,5]');
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_COPYWITHIN_0500
     * @tc.name      : testArrayCopyWithin0005
     * @tc.desc      : Test the function of the interface ArkTS Array CopyWithin
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testArrayCopyWithin0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const TAG = "testArrayCopyWithin0005";
        try {
          let arr1: collections.Array<number> = new collections.Array(1, 2, 3, 4, 5);
          const obj: collections.Array<number> = arr1.copyWithin(0, 3);
          console.log(`${TAG} result:` + JSON.stringify(obj));
          expect(JSON.stringify(obj)).assertEqual('[4,5,3,4,5]');
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_COPYWITHIN_0600
     * @tc.name       : testArrayCopyWithin0006
     * @tc.desc       : Test the function of the interface ArkTS Array CopyWithin
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testArrayCopyWithin0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const TAG = "testArrayCopyWithin0006";
        try {
          let arr1: collections.Array<number> = new collections.Array(1, 2, 3, 4, 5);
          const obj: collections.Array<number> = arr1.copyWithin(0, 3, 3);
          console.log(`${TAG} result:` + JSON.stringify(obj));
          expect(JSON.stringify(obj)).assertEqual('[1,2,3,4,5]');
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_COPYWITHIN_0700
     * @tc.name       : testArrayCopyWithin0007
     * @tc.desc       : Test the function of the interface ArkTS Array CopyWithin
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testArrayCopyWithin0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const TAG = "testArrayCopyWithin0007";
        try {
          let arr1: collections.Array<number> = new collections.Array(1, 2, 3, 4, 5);
          const obj: collections.Array<number> = arr1.copyWithin(0, 4, 3);
          console.log(`${TAG} result:` + JSON.stringify(obj));
          expect(JSON.stringify(obj)).assertEqual('[1,2,3,4,5]');
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_COPYWITHIN_0800
     * @tc.name       : testArrayCopyWithin0008
     * @tc.desc       : Test the function of the interface ArkTS Array CopyWithin
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testArrayCopyWithin0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const TAG = "testArrayCopyWithin0008";
        try {
          let arr1: collections.Array<number> = new collections.Array(1, 2, 3, 4, 5);
          const obj: collections.Array<number> = arr1.copyWithin(10, 1, 3);
          console.log(`${TAG} result:` + JSON.stringify(obj));
          expect(JSON.stringify(obj)).assertEqual('[1,2,3,4,5]');
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_COPYWITHIN_0900
     * @tc.name       : testArrayCopyWithin0009
     * @tc.desc       : Test the function of the interface ArkTS Array CopyWithin
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testArrayCopyWithin0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const TAG = "testArrayCopyWithin0009";
        try {
          let arr1: collections.Array<number> = new collections.Array();
          const obj: collections.Array<number> = arr1.copyWithin(0, 0, 0);
          console.log(`${TAG} result:` + JSON.stringify(obj));
          expect(JSON.stringify(obj)).assertEqual('[]');
          expect(arr1.length).assertEqual(0);
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_COPYWITHIN_1000
     * @tc.name       : testArrayCopyWithin0010
     * @tc.desc       : Array copyWithin 10200011
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testArrayCopyWithin0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testArrayCopyWithin0010';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          let array: collections.Array<number> = collections.Array.from([1, 2, 3, 4, 5, 6, 7, 8]);
          const normal = new NormalClass(10);
          const unbound = array.copyWithin;
          const bound: () => void = unbound.bind(normal);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_COPYWITHIN_1100
     * @tc.name       : testArrayCopyWithin0011
     * @tc.desc       : Array copyWithin 10200201
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testArrayCopyWithin0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testArrayCopyWithin0011';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          collections.Array.from([-10, 20, -30, 40, -50]).forEach((value1, value2, Array) => {
            let a = Array.copyWithin(3, 1, 3).copyWithin(1, 2, 1);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_REVERSE_0100
     * @tc.name       : testArrayReverse0001
     * @tc.desc       : Test the function of the interface ArkTS Array Reverse.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testArrayReverse0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const TAG = "testArrayReverse0001";
      try {
        const items: collections.Array<number> = new collections.Array(1, 2, 3);
        const result: collections.Array<number> = items.reverse();
        expect(JSON.stringify(result)).assertEqual('[3,2,1]');
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
      done()
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_REVERSE_0200
     * @tc.name       : testArrayReverse0002
     * @tc.desc       : Test the function of the interface ArkTS Array Reverse.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testArrayReverse0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testArrayReverse0002';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          let array = new collections.Array<number>(1, 2, 3, 4, 5);
          const normal = new NormalClass(10);
          const unbound = array.reverse;
          const bound: () => void = unbound.bind(normal);
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
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_REVERSE_0300
     * @tc.name      : testArrayReverse0003
     * @tc.desc      : Test the function of the interface ArkTS Array Reverse.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testArrayReverse0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testArrayReverse0003';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          collections.Array.from([-10, 20, -30, 40, -50]).forEach((value1, value2, Array) => {
            let a = Array.copyWithin(3, 1, 3).forEach((value1, value2, array) => {
              let a = array.copyWithin(3, 1, 3).reverse();
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_LASTINDEXOF_0100
     * @tc.name       : testArrayLastIndexOf0001
     * @tc.desc       : Test the function of the interface ArkTS Array LastIndexOf.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testArrayLastIndexOf0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const TAG = "testArrayLastIndexOf0001";
        try {
          const numbers: collections.Array<number> = new collections.Array(2, 5, 9, 2);
          const result: number = numbers.lastIndexOf(2, 3);
          console.log(`${TAG} result:` + result);
          expect(result).assertEqual(3);
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_LASTINDEXOF_0200
     * @tc.name       : testArrayLastIndexOf0002
     * @tc.desc       : Test the function of the interface ArkTS Array LastIndexOf.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testArrayLastIndexOf0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const TAG = "testArrayLastIndexOf0002";
      try {
        const numbers: collections.Array<number> = new collections.Array(2, 5, 9, 2);
        const result: number = numbers.lastIndexOf(2);
        console.log(`${TAG} result:` + result);
        expect(result).assertEqual(3);
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
      done()
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_LASTINDEXOF_0300
     * @tc.name       : testArrayLastIndexOf0003
     * @tc.desc       : Test the function of the interface ArkTS Array LastIndexOf.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testArrayLastIndexOf0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testArrayLastIndexOf0003";
      try {
        const numbers: collections.Array<number> = new collections.Array(2, 5, 9, 2);
        const result: number = numbers.lastIndexOf(2, -2);
        console.log(`${TAG} result:` + result);
        expect(result).assertEqual(0);
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
      done()
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_LASTINDEXOF_0400
     * @tc.name      : testArrayLastIndexOf0004
     * @tc.desc      : Test the function of the interface ArkTS Array LastIndexOf.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testArrayLastIndexOf0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testArrayLastIndexOf0004';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          let array: collections.Array<number> = collections.Array.from([1, 2, 3, 4, 5, 6, 7, 8]);
          const normal = new NormalClass(10);
          const unbound = array.lastIndexOf;
          const bound: () => void = unbound.bind(normal, 2, 2);
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
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_LASTINDEXOF_0500
     * @tc.name      : testArrayLastIndexOf0005
     * @tc.desc      : Test the function of the interface ArkTS Array LastIndexOf.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testArrayLastIndexOf0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testArrayLastIndexOf0005';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          collections.Array.from([-10, 20, -30, 40, -50]).forEach((value1, value2, Array) => {
            let a = Array.copyWithin(3, 1, 3).lastIndexOf(3);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_EVERY_0100
     * @tc.name       : testArrayEvery0001
     * @tc.desc       : Test the function of the interface ArkTS Array Every.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testArrayEvery0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const TAG = "testArrayEvery0001";
      try {
        let array = new collections.Array(1, 2, 3);
        const result: boolean = array.every((x: number) => x > 0);
        console.log(`${TAG} result:` + result);
        expect(result).assertEqual(true);
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
      done()
    })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_EVERY_0200
     * @tc.name       : testArrayEvery0002
     * @tc.desc       : Test the function of the interface ArkTS Array Every.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testArrayEvery0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const TAG = "testArrayEvery0002";
      try {
        let array: collections.Array<number> = new collections.Array(1, 2, 3);
        const result: boolean = array.every((x: number) => x > 3);
        console.log(`${TAG} result:` + result);
        expect(result).assertEqual(false);
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
      done()
    })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_EVERY_0300
     * @tc.name       : testArrayEvery0003
     * @tc.desc       : Array every 10200011
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testArrayEvery0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testArrayEvery0003';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          let array = new collections.Array<number>(1, 2, 3, 4, 5);
          const normal = new NormalClass(10);
          const unbound = array.every;
          const bound: () => void = unbound.bind(normal);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_EVERY_0400
     * @tc.name       : testArrayEvery0004
     * @tc.desc       : Array every 10200201
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testArrayEvery0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testArrayEvery0004';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          collections.Array.from([-10, 20, -30, 40, -50])
            .sort((a: number, b: number) => a - b)
            .forEach((value1, value2, Array) => {
              let a = Array.sort((a: number, b: number) => a - b).forEach((value1, value2, array) => {
                array.every((element: number) => element > 0);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_SOME_0100
     * @tc.name       : testArraySome0001
     * @tc.desc       : Test the function of the interface ArkTS Array Some.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testArraySome0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const TAG = "testArraySome0001";
      try {
        let array: collections.Array<number> = new collections.Array(1, 2, 3);
        const result: boolean = array.some((x: number) => x === 1);
        console.log(`${TAG} result:` + result);
        expect(result).assertEqual(true);
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
      done()
    })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_SOME_0200
     * @tc.name       : testArraySome0002
     * @tc.desc       : Test the function of the interface ArkTS Array Some.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testArraySome0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const TAG = "testArraySome0002";
      try {
        let array: collections.Array<number> = new collections.Array(1, 2, 3);
        const result: boolean = array.some((x: number) => x === -1);
        console.log(`${TAG} result:` + result);
        expect(result).assertEqual(false);
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
      done()
    })

    /**
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_SOME_0300
     * @tc.name      : testArraySome0003
     * @tc.desc      : Test the function of the interface ArkTS Array Some.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testArraySome0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testArraySome0003';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          let array: collections.Array<number> = collections.Array.from([1, 2, 3, 4, 5, 6, 7, 8]);
          const normal = new NormalClass(10);
          const unbound = array.some;
          const bound: () => void = unbound.bind(normal);
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
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_SOME_0400
     * @tc.name      : testArraySome0004
     * @tc.desc      : Test the function of the interface ArkTS Array Some.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testArraySome0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testArraySome0004';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          collections.Array.from([-10, 20, -30, 40, -50]).forEach((value1, value2, Array) => {
            let a = Array.copyWithin(3, 1, 3).some((element: number) => element < 0);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_TOSTRING_0100
     * @tc.name       : testArrayToString0001
     * @tc.desc       : Test the function of the interface ArkTS Array ToString.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testArrayToString0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const TAG = "testArrayToString0001";
      try {
        const array1: collections.Array<number | string> = new collections.Array<number | string>(1, 2, 'a', '1a');
        const result: string = array1.toString();
        console.log(`${TAG} result:` + result);
        expect(result).assertEqual('1,2,a,1a');
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
      done()
    })

    /**
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_TOSTRING_0200
     * @tc.name      : testArrayToString0002
     * @tc.desc      : Test the function of the interface ArkTS Array ToString.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testArrayToString0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testArrayToString0002';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          let array = new collections.Array<number>(1, 2, 3, 4, 5);
          const normal = new NormalClass(10);
          const unbound = array.toString;
          const bound: () => void = unbound.bind(normal);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_TOSTRING_0300
     * @tc.name       : testArrayToString0003
     * @tc.desc       : Test the function of the interface ArkTS Array ToString.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testArrayToString0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testArrayToString0003';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          collections.Array.from([-10, 20, -30, 40, -50]).forEach((value1, value2, Array) => {
            let a = Array.copyWithin(3, 1, 3).forEach((value1, value2, array) => {
              let a = array.copyWithin(3, 1, 3).toString();
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_TOLOCALESTRING_0100
     * @tc.name       : testArrayToLocaleString0001
     * @tc.desc       : Test the function of the interface ArkTS Array ToLocaleString.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 0
     */
    it('testArrayToLocaleString0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const TAG = "testArrayToLocaleString0001";
      try {
        const array1: collections.Array<number> = new collections.Array<number>();
        const iterator1: string = array1.toLocaleString();
        console.log(`${TAG} result:` + iterator1);
        expect(iterator1).assertEqual('');
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
      done()
    })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_TOLOCALESTRING_0200
     * @tc.name       : testArrayToLocaleString0002
     * @tc.desc       : Test the function of the interface ArkTS Array ToLocaleString.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testArrayToLocaleString0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testArrayToLocaleString0002';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          let array = new collections.Array<number>(1, 2, 3, 4, 5);
          const normal = new NormalClass(10);
          const unbound = array.toLocaleString;
          const bound: () => void = unbound.bind(normal);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_TOLOCALESTRING_0300
     * @tc.name       : testArrayToLocaleString0003
     * @tc.desc       : Array toLocaleString 10200201
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testArrayToLocaleString0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testArrayToLocaleString0003';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          collections.Array.from([-10, 20, -30, 40, -50])
            .sort((a: number, b: number) => a - b)
            .forEach((value1, value2, Array) => {
              let a = Array.sort((a: number, b: number) => a - b).forEach((value1, value2, array) => {
                array.toLocaleString();
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
     * @tc.number: SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_REDUCERIGHT_0100
     * @tc.name  : testArrayReduceRight0001
     * @tc.desc  : Test the function of the interface ArkTS Array ReduceRight.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('testArrayReduceRight0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let caseName: string = 'testArrayReduceRight0001';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        let sum: number = array.reduceRight((accumulator: number, value: number) => accumulator + value);
        console.log(`${caseName} reduceRight ${sum}`);
        expect(55).assertEqual(sum);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    })

    /**
     * @tc.number: SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_REDUCERIGHT_0200
     * @tc.name  : testArrayReduceRight0002
     * @tc.desc  : Test the function of the interface ArkTS Array ReduceRight.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     */
    it('testArrayReduceRight0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let caseName: string = 'testArrayReduceRight0002';
      console.log(`${caseName} test start `);
      try {
        let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
        console.log(`${caseName} array ${array.length}`);
        let sum: number = array.reduceRight((accumulator: number, value: number) => accumulator + value, 0);
        console.log(`${caseName} reduceRight ${sum}`);
        expect(55).assertEqual(sum);
        done();
      } catch (error) {
        console.log(`${caseName} catchError ${JSON.stringify(error)}`);
        expect().assertFail();
        done();
      }
      console.log(`${caseName} test end `);
    })

    /**
     * @tc.number: SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_REDUCERIGHT_0300
     * @tc.name  : testArrayReduceRight0003
     * @tc.desc  : Test the function of the interface ArkTS Array ReduceRight.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('testArrayReduceRight0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testArrayReduceRight0003';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          let array = new collections.Array<number>(1, 2, 3, 4, 5);
          const normal = new NormalClass(10);
          const unbound = array.reduceRight;
          const bound: () => void = unbound.bind(normal, () => {
          });
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
     * @tc.number: SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_REDUCERIGHT_0400
     * @tc.name  : testArrayReduceRight0004
     * @tc.desc  : Test the function of the interface ArkTS Array ReduceRight.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('testArrayReduceRight0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testArrayReduceRight0004';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          collections.Array.from([-10, 20, -30, 40, -50]).forEach((value1, value2, Array) => {
            let a = Array.copyWithin(3, 1, 3).forEach((value1, value2, array) => {
              let a = array.copyWithin(3, 1, 3).reduceRight((accumulator, value) => accumulator + value);
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
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_REDUCERIGHT_0500
     * @tc.name      : testArrayReduceRight0005
     * @tc.desc      : Test the function of the interface ArkTS Array ReduceRight.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testArrayReduceRight0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let caseName: string = 'testArrayReduceRight0005';
        console.log(`${caseName} test start `);
        try {
          let array: collections.Array<number> = new collections.Array<number>(1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
          console.log(`${caseName} array ${array.length}`);
          let sum: string =
            array.reduceRight<string>((accumulator: string, value: number) => accumulator + value, "str:");
          console.log(`${caseName} reduce ${sum}`);
          expect("str:10987654321").assertEqual(sum);
          done();
        } catch (error) {
          console.log(`${caseName} catchError ${JSON.stringify(error)}`);
          expect().assertFail();
          done();
        }
        console.log(`${caseName} test end `);
      })

    /**
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_REDUCERIGHT_0600
     * @tc.name      : testArrayReduceRight0006
     * @tc.desc      : Test the function of the interface ArkTS Array ReduceRight.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testArrayReduceRight0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testArrayReduceRight0006';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          let array = new collections.Array<number>(1, 2, 3, 4, 5);
          const normal = new NormalClass(10);
          const unbound = array.reduceRight;
          const bound: () => void = unbound.bind(normal, () => {
          });
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
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_ARRAY_REDUCERIGHT_0700
     * @tc.name      : testArrayReduceRight0007
     * @tc.desc      : Test the function of the interface ArkTS Array ReduceRight.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testArrayReduceRight0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testArrayReduceRight0007';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          collections.Array.from([-10, 20, -30, 40, -50]).forEach((value1, value2, Array) => {
            let a = Array.copyWithin(3, 1, 3).forEach((value1, value2, array) => {
              let a = array.copyWithin(3, 1, 3).reduceRight((accumulator, value) => accumulator + value);
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
  })
}