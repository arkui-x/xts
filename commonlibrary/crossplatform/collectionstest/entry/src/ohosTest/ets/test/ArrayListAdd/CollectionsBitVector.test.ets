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
import { collections, taskpool } from '@kit.ArkTS';
import { BusinessError } from '@kit.BasicServicesKit';

@Concurrent
export function testPush(index: number, bit: collections.BitVector) {
  let tag = 'testPush'
  try {
    bit.push(index)
  } catch (e) {
    console.info(`${tag} Task execution catch: ${e.message}, code: ${e.code}`);
  }
}

@Concurrent
export function testPop(index: number, bit: collections.BitVector) {
  let tag = 'testPop'
  try {
    bit.pop()
  } catch (e) {
    console.info(`${tag} Task execution catch: ${e.message}, code: ${e.code}`);
  }
}

@Concurrent
export function testHas(index: number, bit: collections.BitVector) {
  let tag = 'testHas'
  try {
    bit.has(index, 0, 1)
  } catch (e) {
    console.info(`${tag} Task execution catch: ${e.message}, code: ${e.code}`);
  }
}

@Concurrent
export function testSetBitsByRange(index: number, bit: collections.BitVector) {
  let tag = 'testSetBitsByRange'
  try {
    bit.setBitsByRange(index, 0, 1)
  } catch (e) {
    console.info(`${tag} Task execution catch: ${e.message}, code: ${e.code}`);
  }
}

@Concurrent
export function testSetAllBits(index: number, bit: collections.BitVector) {
  let tag = 'testSetAllBits'
  try {
    bit.setAllBits(index)
  } catch (e) {
    console.info(`${tag} Task execution catch: ${e.message}, code: ${e.code}`);
  }
}

@Concurrent
export function testGetBitsByRange(index: number, bit: collections.BitVector) {
  let tag = 'testGetBitsByRange'
  try {
    bit.getBitsByRange(0, 1)
  } catch (e) {
    console.info(`${tag} Task execution catch: ${e.message}, code: ${e.code}`);
  }
}

@Concurrent
export function testResize(index: number, bit: collections.BitVector) {
  let tag = 'testResize'
  try {
    bit.resize(index)
  } catch (e) {
    console.info(`${tag} Task execution catch: ${e.message}, code: ${e.code}`);
  }
}

@Concurrent
export function testGetBitCountByRange(index: number, bit: collections.BitVector) {
  let tag = 'testPush'
  try {
    bit.getBitCountByRange(1, 0, 1)
  } catch (e) {
    console.info(`${tag} Task execution catch: ${e.message}, code: ${e.code}`);
  }
}

@Concurrent
export function testGetIndexOf(index: number, bit: collections.BitVector) {
  let tag = 'testGetIndexOf'
  try {
    bit.getIndexOf(1, 0, 4)
  } catch (e) {
    console.info(`${tag} Task execution catch: ${e.message}, code: ${e.code}`);
  }
}

@Concurrent
export function testGetLastIndexOf(index: number, bit: collections.BitVector) {
  let tag = 'testGetLastIndexOf'
  try {
    bit.getLastIndexOf(1, 0, 4)
  } catch (e) {
    console.info(`${tag} Task execution catch: ${e.message}, code: ${e.code}`);
  }
}

@Concurrent
export function testFlipBitByIndex(index: number, bit: collections.BitVector) {
  let tag = 'testFlipBitByIndex'
  try {
    bit.flipBitByIndex(0)
  } catch (e) {
    console.info(`${tag} Task execution catch: ${e.message}, code: ${e.code}`);
  }
}

@Concurrent
export function testFlipBitsByRange(index: number, bit: collections.BitVector) {
  let tag = 'testFlipBitsByRange'
  try {
    bit.flipBitsByRange(0, 1)
  } catch (e) {
    console.info(`${tag} Task execution catch: ${e.message}, code: ${e.code}`);
  }
}

@Concurrent
export function testValues(index: number, bit: collections.BitVector) {
  let tag = 'testValues'
  try {
    let res = bit.values()
  } catch (e) {
    console.info(`${tag} Task execution catch: ${e.message}, code: ${e.code}`);
  }
}

async function asyncSleep(time: number) {
  return await new Promise<number>((resolve) => {
    setTimeout(() => {
      resolve(1)
    }, time)
  })
}

export function sleep(time: number): Promise<void> {
  return new Promise((re, je) => {
    setTimeout(() => {
      re()
    }, time)
  })
}

function sleep(ms: number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function BitVectorTest2() {
  describe('BitVectorTest2', () => {
    afterEach(async () => {
      await sleep(1000)
    });


    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_CONSTRUCTOR_0100
     * @tc.name       : testBitVectorConstructor0001
     * @tc.desc       : Testing the constructor of bitVector, length is 10
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testBitVectorConstructor0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testBitVectorConstructor0001";
      try {
        let bitVectorList: collections.BitVector = new collections.BitVector(10);
        expect(bitVectorList.length).assertEqual(10);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done()
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_CONSTRUCTOR_0200
     * @tc.name       : testBitVectorConstructor0002
     * @tc.desc       : Testing the constructor of bitVector, length is 0
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testBitVectorConstructor0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testBitVectorConstructor0002";
      try {
        let bitVectorList: collections.BitVector = new collections.BitVector(0);
        expect(bitVectorList.length).assertEqual(0);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done()
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_CONSTRUCTOR_0300
     * @tc.name      : testBitVectorConstructor0003
     * @tc.desc      : BitVector constructor 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testBitVectorConstructor0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorConstructor0003';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          const bitVector = new collections.BitVector(NaN);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_PUSH_0100
     * @tc.name       : testBitVectorPush0001
     * @tc.desc       : Testing the Push of bitVector, push 0
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testBitVectorPush0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testBitVectorPush0001";
      try {
        let bitVectorList: collections.BitVector = new collections.BitVector(0);
        let rst = bitVectorList.push(0);
        expect(rst).assertTrue();
        expect(bitVectorList[0]).assertEqual(0);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done()
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_PUSH_0200
     * @tc.name       : testBitVectorPush0002
     * @tc.desc       : Testing the Push of bitVector, push multiple values
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testBitVectorPush0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testBitVectorPush0002";
      try {
        let bitVector = new collections.BitVector(0);
        let res0 = bitVector.push(0);
        let res1 = bitVector.push(1);
        let res2 = bitVector.push(0);
        let res3 = bitVector.push(1);
        let res4 = bitVector.push(1);
        expect(res0).assertEqual(true);
        expect(res1).assertEqual(true);
        expect(res2).assertEqual(true);
        expect(res3).assertEqual(true);
        expect(res4).assertEqual(true);
        expect(bitVector[0]).assertEqual(0);
        expect(bitVector[1]).assertEqual(1);
        expect(bitVector[2]).assertEqual(0);
        expect(bitVector[3]).assertEqual(1);
        expect(bitVector[4]).assertEqual(1);
        expect(bitVector.length).assertEqual(5);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done()
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_PUSH_0300
     * @tc.name       : testBitVectorPush0003
     * @tc.desc       : BitVector push 10200011 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorPush0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorPush0003';
        console.info(`${caseName} test start`);
        let flag: boolean = false;
        try {
          const bitVector = new collections.BitVector(5);
          const unboundPush = bitVector.push;
          unboundPush(1);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_PUSH_0400
     * @tc.name       : testBitVectorPush0004
     * @tc.desc       : BitVector push 10200201 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorPush0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorPush0004';
        console.info(`${caseName} test start`);
        let count = 0;
        let bitVector = new collections.BitVector(4);
        try {
          for (let i = 0; i < 100; i++) {
            taskpool.execute(testPush, i, bitVector).then(() => {
              count++
            }).catch((e: BusinessError) => {
              console.info(`${caseName} Task execution catch: ${e.message}, code: ${e.code}`);
            })
          }
          for (let i = 0; i < 10; i++) {
            bitVector.push(i)
          }
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200201)
        }
        while (count < 100) {
          await asyncSleep(100)
        }
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_POP_0100
     * @tc.name       : testBitVectorPop0001
     * @tc.desc       : Testing the pop of bitVector, pop succeed
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testBitVectorPop0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testBitVectorPop0001";
      try {
        let bitVectorList: collections.BitVector = new collections.BitVector(0);
        let rst = bitVectorList.push(0);
        let num = bitVectorList.pop();
        expect(num).assertEqual(0);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done()
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_POP_0200
     * @tc.name       : testBitVectorPop0002
     * @tc.desc       : Testing the pop of bitVector, pop succeed
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testBitVectorPop0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testBitVectorPop0002";
      try {
        let bitVectorList: collections.BitVector = new collections.BitVector(0);
        let rst = bitVectorList.push(1);
        let num = bitVectorList.pop();
        expect(num).assertEqual(1);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done()
    });
    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_POP_0300
     * @tc.name       : testBitVectorPop0003
     * @tc.desc       : BitVector pop 10200011 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorPop0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorPop0003';
        let flag: boolean = false;
        console.info(`${caseName} test start`);

        try {
          let bitVector: collections.BitVector = new collections.BitVector(3);
          const popMethod = bitVector.pop;
          popMethod();
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_POP_0400
     * @tc.name       : testBitVectorPop0004
     * @tc.desc       : BitVector pop 10200201 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorPop0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorPop0004';
        console.info(`${caseName} test start`);
        let count = 0;
        let bitVector = new collections.BitVector(4);
        try {
          for (let i = 0; i < 100; i++) {
            taskpool.execute(testPop, i, bitVector).then(() => {
              count++
            }).catch((e: BusinessError) => {
              console.info(`${caseName} Task execution catch: ${e.message}, code: ${e.code}`);
            })
          }
          for (let i = 0; i < 10; i++) {
            bitVector.pop()
          }
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200201)
        }
        while (count < 100) {
          await asyncSleep(100)
        }
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_HAS_0100
     * @tc.name       : testBitVectorHas0001
     * @tc.desc       : Testing the has of bitVector, element=0 fromIndex=0 toIndex=10, return true.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testBitVectorHas0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testBitVectorHas0001";
      try {
        let bitVectorList: collections.BitVector = new collections.BitVector(0);
        bitVectorList.push(0);
        bitVectorList.push(0);
        bitVectorList.push(0);
        bitVectorList.push(0);
        bitVectorList.push(0);
        bitVectorList.push(1);
        bitVectorList.push(1);
        bitVectorList.push(1);
        bitVectorList.push(1);
        bitVectorList.push(1);
        let rst = bitVectorList.has(0, 0, 10);
        expect(rst).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done()
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_HAS_0200
     * @tc.name       : testBitVectorHas0002
     * @tc.desc       : Testing the has of bitVector, element=1 fromIndex=0 toIndex=5, return false.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testBitVectorHas0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testBitVectorHas0002";
      try {
        let bitVectorList: collections.BitVector = new collections.BitVector(0);
        bitVectorList.push(0);
        bitVectorList.push(0);
        bitVectorList.push(0);
        bitVectorList.push(0);
        bitVectorList.push(0);
        bitVectorList.push(1);
        bitVectorList.push(1);
        bitVectorList.push(1);
        bitVectorList.push(1);
        bitVectorList.push(1);
        let rst = bitVectorList.has(1, 0, 4);
        expect(rst).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done()
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_HAS_0300
     * @tc.name       : testBitVectorHas0003
     * @tc.desc       : BitVector has 10200001 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorHas0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorHas0003';
        let flag: boolean = false;
        console.info(`${caseName} test start`);

        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          let res0: boolean = bitVector.has(0, -1, 2);
          console.info("bitVector has 0:", res0);
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200001)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_HAS_0400
     * @tc.name       : testBitVectorHas0004
     * @tc.desc       : BitVector has 10200001 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorHas0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorHas0004';
        let flag: boolean = false;
        console.info(`${caseName} test start`);

        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          let res0: boolean = bitVector.has(0, 2, -1);
          console.info("bitVector has 0:", res0);
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200001)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_HAS_0500
     * @tc.name       : testBitVectorHas0005
     * @tc.desc       : BitVector has 10200011 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorHas0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorHas0005';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          let hasMethod = bitVector.has;
          hasMethod(0, 0, 2);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_HAS_0600
     * @tc.name       : testBitVectorHas0006
     * @tc.desc       : BitVector has 10200201 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorHas0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorHas0006';
        console.info(`${caseName} test start`);
        let count = 0;
        let bitVector = new collections.BitVector(4);
        try {
          for (let i = 0; i < 100; i++) {
            taskpool.execute(testHas, i, bitVector).then(() => {
              count++
            }).catch((e: BusinessError) => {
              console.info(`${caseName} Task execution catch: ${e.message}, code: ${e.code}`);
            })
          }
          for (let i = 0; i < 10; i++) {
            bitVector.has(1, 0, 4)
          }
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200201)
        }
        while (count < 100) {
          await asyncSleep(100)
        }
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_SETBITSBYRANGE_0100
     * @tc.name       : testBitVectorSetBitsByRange0001
     * @tc.desc       : Testing the setBitsByRange of bitVector, return true.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testBitVectorSetBitsByRange0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testBitVectorSetBitsByRange0001";
        try {
          let bitVectorList: collections.BitVector = new collections.BitVector(0);
          bitVectorList.push(0);
          bitVectorList.push(0);
          bitVectorList.push(0);
          bitVectorList.push(0);
          bitVectorList.push(0);
          bitVectorList.push(1);
          bitVectorList.push(1);
          bitVectorList.push(1);
          bitVectorList.push(1);
          bitVectorList.push(1);
          bitVectorList.setBitsByRange(1, 1, 3);
          expect(bitVectorList[0].toString()).assertEqual("0");
          expect(bitVectorList[1].toString()).assertEqual("1");
          expect(bitVectorList[2].toString()).assertEqual("1");
          expect(bitVectorList[3].toString()).assertEqual("0");
          expect(bitVectorList[4].toString()).assertEqual("0");
          expect(bitVectorList[5].toString()).assertEqual("1");
          expect(bitVectorList[6].toString()).assertEqual("1");
          expect(bitVectorList[7].toString()).assertEqual("1");
          expect(bitVectorList[8].toString()).assertEqual("1");
          expect(bitVectorList[9].toString()).assertEqual("1");
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done()
      });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_SETBITSBYRANGE_0200
     * @tc.name      : testBitVectorSetBitsByRange0002
     * @tc.desc      : BitVector setBitsByRange 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testBitVectorSetBitsByRange0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorSetBitsByRange0002';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.setBitsByRange(NaN, NaN, 3);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_SETBITSBYRANGE_0300
     * @tc.name       : testBitVectorSetBitsByRange0003
     * @tc.desc       : BitVector setBitsByRange 10200001 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorSetBitsByRange0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorSetBitsByRange0003';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.setBitsByRange(1, -1, 3);
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200001)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_SETBITSBYRANGE_0400
     * @tc.name       : testBitVectorSetBitsByRange0004
     * @tc.desc       : BitVector setBitsByRange 10200001 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorSetBitsByRange0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorSetBitsByRange0004';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.setBitsByRange(1, 1, 9);
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200001)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_SETBITSBYRANGE_0500
     * @tc.name       : testBitVectorSetBitsByRange0005
     * @tc.desc       : BitVector setBitsByRange 10200011 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorSetBitsByRange0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorSetBitsByRange0005';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          let setBitsByRangeMethod = bitVector.setBitsByRange;
          setBitsByRangeMethod(1, 1, 3)
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_SETBITSBYRANGE_0600
     * @tc.name       : testBitVectorSetBitsByRange0006
     * @tc.desc       : BitVector setBitsByRange 10200201 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorSetBitsByRange0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorSetBitsByRange0006';
        console.info(`${caseName} test start`);
        let count = 0;
        let bitVector = new collections.BitVector(4);
        try {
          for (let i = 0; i < 100; i++) {
            taskpool.execute(testSetBitsByRange, i, bitVector).then(() => {

              count++
            }).catch((e: BusinessError) => {
              console.info(`${caseName} Task execution catch: ${e.message}, code: ${e.code}`);
            })
          }
          for (let i = 0; i < 10; i++) {
            bitVector.setBitsByRange(1, 0, 4)
          }
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200201)
        }
        while (count < 100) {
          await asyncSleep(100)
        }
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_SETALLBITS_0100
     * @tc.name       : testBitVectorSetAllBits0001
     * @tc.desc       : Testing the SetAllBits of bitVector, set 0, return 0(all).
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testBitVectorSetAllBits0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testBitVectorSetAllBits0001";
      try {
        let bitVectorList: collections.BitVector = new collections.BitVector(0);
        for (let i = 0; i < 10; i++) {
          if (i < 5) {
            bitVectorList.push(0);
          } else {
            bitVectorList.push(1);
          }
        }
        bitVectorList.setAllBits(0);
        for (let i = 0; i < 10; i++) {
          expect(bitVectorList[i].toString()).assertEqual("0");
        }
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done()
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_SETALLBITS_0200
     * @tc.name       : testBitVectorSetAllBits0002
     * @tc.desc       : BitVector setAllBits 10200011 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorSetAllBits0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorSetAllBits0002';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          let setAllBitsMethod = bitVector.setAllBits;
          setAllBitsMethod(1)
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_SETALLBITS_0300
     * @tc.name       : testBitVectorSetAllBits0003
     * @tc.desc       : BitVector setAllBits 10200201 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorSetAllBits0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorSetAllBits0003';
        console.info(`${caseName} test start`);
        let count = 0;
        let bitVector = new collections.BitVector(4);
        try {
          for (let i = 0; i < 100; i++) {
            taskpool.execute(testSetAllBits, i, bitVector).then(() => {
              count++
            }).catch((e: BusinessError) => {
              console.info(`${caseName} Task execution catch: ${e.message}, code: ${e.code}`);
            })
          }
          for (let i = 0; i < 10; i++) {
            bitVector.setAllBits(i)
          }
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200201)
        }
        while (count < 100) {
          await asyncSleep(100)
        }
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETBITSBYRANGE_0100
     * @tc.name       : testBitVectorGetBitsByRange0001
     * @tc.desc       : Testing the getBitsByRange of bitVector, fromIndex=0,toIndex=6, return 000001.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testBitVectorGetBitsByRange0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testBitVectorGetBitsByRange0001";
        try {
          let bitVectorList: collections.BitVector = new collections.BitVector(0);
          for (let i = 0; i < 10; i++) {
            if (i < 5) {
              bitVectorList.push(0);
            } else {
              bitVectorList.push(1);
            }
          }
          let bitVectorList2 = bitVectorList.getBitsByRange(0, 6);
          for (let i = 0; i < 6; i++) {
            if (i < 5) {
              expect(bitVectorList2[i].toString()).assertEqual("0");
            } else {
              expect(bitVectorList2[i].toString()).assertEqual("1");
            }
          }
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done()
      });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETBITSBYRANGE_0200
     * @tc.name       : testBitVectorGetBitsByRange0002
     * @tc.desc       : BitVector getBitsByRange 10200001 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorGetBitsByRange0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorGetBitsByRange0002';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          let bitVector2 = bitVector.getBitsByRange(-1, 1);
          console.info("bitVector2 length:", bitVector2.length);
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200001)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETBITSBYRANGE_0300
     * @tc.name       : testBitVectorGetBitsByRange0003
     * @tc.desc       : BitVector getBitsByRange 10200001 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorGetBitsByRange0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorGetBitsByRange0003';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          let bitVector2 = bitVector.getBitsByRange(1, -1);
          console.info("bitVector2 length:", bitVector2.length);
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200001)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETBITSBYRANGE_0400
     * @tc.name       : testBitVectorGetBitsByRange0004
     * @tc.desc       : BitVector getBitsByRange 10200011 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorGetBitsByRange0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorGetBitsByRange0004';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          let getBitsByRangeMethod = bitVector.getBitsByRange;
          getBitsByRangeMethod(1, 3)
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETBITSBYRANGE_0500
     * @tc.name       : testBitVectorGetBitsByRange0005
     * @tc.desc       : BitVector getBitsByRange 10200201 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorGetBitsByRange0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorGetBitsByRange0005';
        console.info(`${caseName} test start`);
        let count = 0;
        let bitVector = new collections.BitVector(4);
        try {
          for (let i = 0; i < 100; i++) {
            taskpool.execute(testGetBitsByRange, i, bitVector).then(() => {
              count++
            }).catch((e: BusinessError) => {
              console.info(`${caseName} Task execution catch: ${e.message}, code: ${e.code}`);
            })
          }
          for (let i = 0; i < 10; i++) {
            bitVector.getBitsByRange(0, 1)
          }
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200201)
        }
        while (count < 100) {
          await asyncSleep(100)
        }
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETBITSBYRANGE_0600
     * @tc.name      : testBitVectorGetBitsByRange0006
     * @tc.desc      : BitVector getBitsByRange 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testBitVectorGetBitsByRange0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorGetBitsByRange0006';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          let bitVector2 = bitVector.getBitsByRange(NaN, NaN);
          console.info("bitVector2 length:", bitVector2.length);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_RESIZE_0100
     * @tc.name       : testBitVectorResize0001
     * @tc.desc       : Testing the resize of bitVector, size is 5, return 01000.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testBitVectorResize0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testBitVectorResize0001";
      try {
        let bitVectorList: collections.BitVector = new collections.BitVector(0);
        bitVectorList.push(0);
        bitVectorList.push(1);
        bitVectorList.push(0);
        bitVectorList.resize(5);
        expect(bitVectorList.length).assertEqual(5);
        expect(bitVectorList[0].toString()).assertEqual("0");
        expect(bitVectorList[1].toString()).assertEqual("1");
        expect(bitVectorList[2].toString()).assertEqual("0");
        expect(bitVectorList[3].toString()).assertEqual("0");
        expect(bitVectorList[4].toString()).assertEqual("0");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done()
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_RESIZE_0200
     * @tc.name       : testBitVectorResize0002
     * @tc.desc       : Testing the resize of bitVector, size is 1, return 0.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testBitVectorResize0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testBitVectorResize0002";
      try {
        let bitVectorList: collections.BitVector = new collections.BitVector(0);
        bitVectorList.push(0);
        bitVectorList.push(1);
        bitVectorList.push(0);
        bitVectorList.resize(1);
        expect(bitVectorList.length).assertEqual(1);
        expect(bitVectorList[0].toString()).assertEqual("0");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done()
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_RESIZE_0300
     * @tc.name       : testBitVectorResize0003
     * @tc.desc       : BitVector resize 10200011 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorResize0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorResize0003';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          let resizeMethod = bitVector.resize;
          resizeMethod(3)
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_RESIZE_0400
     * @tc.name       : testBitVectorResize0004
     * @tc.desc       : BitVector resize 10200201 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorResize0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorResize0004';
        console.info(`${caseName} test start`);
        let count = 0;
        let bitVector = new collections.BitVector(4);
        try {
          for (let i = 0; i < 100; i++) {
            taskpool.execute(testResize, i, bitVector).then(() => {
              count++
            }).catch((e: BusinessError) => {
              console.info(`${caseName} Task execution catch: ${e.message}, code: ${e.code}`);
            })
          }
          for (let i = 0; i < 10; i++) {
            bitVector.resize(i)
          }
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200201)
        }
        while (count < 100) {
          await asyncSleep(100)
        }
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_RESIZE_0500
     * @tc.name      : testBitVectorResize0005
     * @tc.desc      : BitVector resize 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testBitVectorResize0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorResize0005';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.resize(NaN);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETBITCOUNTBYRANGE_0100
     * @tc.name       : testBitVectorGetBitCountByRange0001
     * @tc.desc       : Testing the getBitCountByRange of bitVector, range is 0~6, return 1.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testBitVectorGetBitCountByRange0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testBitVectorGetBitCountByRange0001";
        try {
          let bitVectorList: collections.BitVector = new collections.BitVector(0);
          for (let i = 0; i < 10; i++) {
            if (i < 5) {
              bitVectorList.push(0);
            } else {
              bitVectorList.push(1);
            }
          }
          let num = bitVectorList.getBitCountByRange(1, 0, 6);
          expect(num).assertEqual(1);
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done()
      });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETBITCOUNTBYRANGE_0200
     * @tc.name       : testBitVectorGetBitCountByRange0002
     * @tc.desc       : BitVector getBitCountByRange 10200001 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorGetBitCountByRange0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorGetBitCountByRange0002';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          let res: number = bitVector.getBitCountByRange(1, -1, 4);
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200001)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETBITCOUNTBYRANGE_0300
     * @tc.name       : testBitVectorGetBitCountByRange0003
     * @tc.desc       : BitVector getBitCountByRange 10200001 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorGetBitCountByRange0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorGetBitCountByRange0003';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          let res: number = bitVector.getBitCountByRange(1, 4, -1);
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200001)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETBITCOUNTBYRANGE_0400
     * @tc.name       : testBitVectorGetBitCountByRange0004
     * @tc.desc       : BitVector getBitCountByRange 10200011 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorGetBitCountByRange0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorGetBitCountByRange0004';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          let getBitCountByRangeMethod = bitVector.getBitCountByRange;
          getBitCountByRangeMethod(1, -1, 4)
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETBITCOUNTBYRANGE_0500
     * @tc.name       : testBitVectorGetBitCountByRange0005
     * @tc.desc       : BitVector getBitCountByRange 10200201 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorGetBitCountByRange0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorGetBitCountByRange0005';
        console.info(`${caseName} test start`);
        let count = 0;
        let bitVector = new collections.BitVector(4);
        try {
          for (let i = 0; i < 100; i++) {
            taskpool.execute(testGetBitCountByRange, i, bitVector).then(() => {
              count++
            }).catch((e: BusinessError) => {
              console.info(`${caseName} Task execution catch: ${e.message}, code: ${e.code}`);
            })
          }
          for (let i = 0; i < 10; i++) {
            bitVector.getBitCountByRange(0, 0, 4)
          }
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200201)
        }
        while (count < 100) {
          await asyncSleep(100)
        }
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETBITCOUNTBYRANGE_0600
     * @tc.name      : testBitVectorGetBitCountByRange0006
     * @tc.desc      : BitVector getBitCountByRange 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testBitVectorGetBitCountByRange0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorGetBitCountByRange0006';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          let res: number = bitVector.getBitCountByRange(NaN, 1, NaN);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETINDEXOF_0100
     * @tc.name       : testBitVectorGetIndexOf0001
     * @tc.desc       : Testing the getIndexOf of bitVector, element=1 fromIndex=0 toIndex=5, return -1.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testBitVectorGetIndexOf0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testBitVectorGetIndexOf0001";
      try {
        let bitVectorList: collections.BitVector = new collections.BitVector(0);
        for (let i = 0; i < 10; i++) {
          if (i < 5) {
            bitVectorList.push(0);
          } else {
            bitVectorList.push(1);
          }
        }
        let num = bitVectorList.getIndexOf(1, 0, 5);
        expect(num).assertEqual(-1);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done()
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETINDEXOF_0200
     * @tc.name       : testBitVectorGetIndexOf0002
     * @tc.desc       : Testing the getIndexOf of bitVector, element=1 fromIndex=0 toIndex=10, return 5.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testBitVectorGetIndexOf0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testBitVectorGetIndexOf0002";
      try {
        let bitVectorList: collections.BitVector = new collections.BitVector(0);
        for (let i = 0; i < 10; i++) {
          if (i < 5) {
            bitVectorList.push(0);
          } else {
            bitVectorList.push(1);
          }
        }
        let num = bitVectorList.getIndexOf(1, 0, 10);
        expect(num).assertEqual(5);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done()
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETINDEXOF_0300
     * @tc.name       : testBitVectorGetIndexOf0003
     * @tc.desc       : BitVector getIndexOf 10200001 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorGetIndexOf0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorGetIndexOf0003';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          let res: number = bitVector.getIndexOf(0, -1, 4);
          console.info("bitVector getIndexOf:", res);
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200001)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETINDEXOF_0400
     * @tc.name       : testBitVectorGetIndexOf0004
     * @tc.desc       : BitVector getIndexOf 10200001 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorGetIndexOf0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorGetIndexOf0004';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          let res: number = bitVector.getIndexOf(0, 4, -1);
          console.info("bitVector getIndexOf:", res);
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200001)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETINDEXOF_0500
     * @tc.name       : testBitVectorGetIndexOf0005
     * @tc.desc       : BitVector getIndexOf 10200011 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorGetIndexOf0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorGetIndexOf0005';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          let getIndexOfMethod = bitVector.getIndexOf;
          getIndexOfMethod(0, -1, 4);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETINDEXOF_0600
     * @tc.name       : testBitVectorGetIndexOf0006
     * @tc.desc       : BitVector getIndexOf 10200201 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorGetIndexOf0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorGetIndexOf0006';
        console.info(`${caseName} test start`);
        let count = 0;
        let bitVector = new collections.BitVector(4);
        try {
          for (let i = 0; i < 100; i++) {
            taskpool.execute(testGetIndexOf, i, bitVector).then(() => {
              count++
            }).catch((e: BusinessError) => {
              console.info(`${caseName} Task execution catch: ${e.message}, code: ${e.code}`);
            })
          }
          for (let i = 0; i < 10; i++) {
            bitVector.getIndexOf(0, 0, 4)
          }
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200201)
        }
        while (count < 100) {
          await asyncSleep(100)
        }
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETLASTINDEXOF_0100
     * @tc.name       : testBitVectorGetLastIndexOf0001
     * @tc.desc       : Testing the getLastIndexOf of bitVector, element=1 fromIndex=0 toIndex=5, return -1.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testBitVectorGetLastIndexOf0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testBitVectorGetLastIndexOf0001";
        try {
          let bitVectorList: collections.BitVector = new collections.BitVector(0);
          for (let i = 0; i < 10; i++) {
            if (i < 5) {
              bitVectorList.push(0);
            } else {
              bitVectorList.push(1);
            }
          }
          let num = bitVectorList.getLastIndexOf(1, 0, 5);
          expect(num).assertEqual(-1);
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done()
      });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETLASTINDEXOF_0200
     * @tc.name       : testBitVectorGetLastIndexOf0002
     * @tc.desc       : Testing the getLastIndexOf of bitVector, element=1 fromIndex=0 toIndex=10, return 9.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testBitVectorGetLastIndexOf0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testBitVectorGetLastIndexOf0002";
        try {
          let bitVectorList: collections.BitVector = new collections.BitVector(0);
          for (let i = 0; i < 10; i++) {
            if (i < 5) {
              bitVectorList.push(0);
            } else {
              bitVectorList.push(1);
            }
          }
          let num = bitVectorList.getLastIndexOf(1, 0, 10);
          expect(num).assertEqual(9);
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done()
      });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETLASTINDEXOF_0300
     * @tc.name       : testBitVectorGetLastIndexOf0003
     * @tc.desc       : BitVector getLastIndexOf 10200001 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorGetLastIndexOf0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorGetLastIndexOf0003';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          let res: number = bitVector.getLastIndexOf(0, -1, 4);
          console.info("bitVector getLastIndexOf:", res);
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200001)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETLASTINDEXOF_0400
     * @tc.name       : testBitVectorGetLastIndexOf0004
     * @tc.desc       : BitVector getLastIndexOf 10200001 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorGetLastIndexOf0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorGetLastIndexOf0004';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          let res: number = bitVector.getLastIndexOf(0, 4, -1);
          console.info("bitVector getLastIndexOf:", res);
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200001)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETLASTINDEXOF_0500
     * @tc.name       : testBitVectorGetLastIndexOf0005
     * @tc.desc       : BitVector getLastIndexOf 10200011 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorGetLastIndexOf0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorGetLastIndexOf0005';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          let getLastIndexOfMethod = bitVector.getLastIndexOf;
          getLastIndexOfMethod(0, -1, 4);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_GETLASTINDEXOF_0600
     * @tc.name       : testBitVectorGetLastIndexOf0006
     * @tc.desc       : BitVector getLastIndexOf 10200201 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorGetLastIndexOf0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorGetLastIndexOf0006';
        console.info(`${caseName} test start`);
        let count = 0;
        let bitVector = new collections.BitVector(4);
        try {
          for (let i = 0; i < 100; i++) {
            taskpool.execute(testGetLastIndexOf, i, bitVector).then(() => {
              count++
            }).catch((e: BusinessError) => {
              console.info(`${caseName} Task execution catch: ${e.message}, code: ${e.code}`);
            })
          }
          for (let i = 0; i < 10; i++) {
            let res = bitVector.getLastIndexOf(0, 0, 1)
          }
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200201)
        }
        while (count < 100) {
          await asyncSleep(100)
        }
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_FLIPBITBYINDEX_0100
     * @tc.name       : testBitVectorFlipBitByIndex0001
     * @tc.desc       : Testing the flipBitByIndex of bitVector, index is 0.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testBitVectorFlipBitByIndex0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testBitVectorFlipBitByIndex0001";
        try {
          let bitVectorList: collections.BitVector = new collections.BitVector(0);
          bitVectorList.push(0);
          bitVectorList.push(1);
          bitVectorList.push(0);
          bitVectorList.flipBitByIndex(0);
          expect(bitVectorList[0].toString()).assertEqual("1");
          expect(bitVectorList[1].toString()).assertEqual("1");
          expect(bitVectorList[2].toString()).assertEqual("0");
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done()
      });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_FLIPBITBYINDEX_0200
     * @tc.name       : testBitVectorFlipBitByIndex0002
     * @tc.desc       : BitVector flipBitByIndex 10200001 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorFlipBitByIndex0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorFlipBitByIndex0002';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.flipBitByIndex(-1);
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200001)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_FLIPBITBYINDEX_0300
     * @tc.name       : testBitVectorFlipBitByIndex0003
     * @tc.desc       : BitVector flipBitByIndex 10200011 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorFlipBitByIndex0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorFlipBitByIndex0003';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          let flipBitByIndexMethod = bitVector.flipBitByIndex;
          flipBitByIndexMethod(3)
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_FLIPBITBYINDEX_0400
     * @tc.name       : testBitVectorFlipBitByIndex0004
     * @tc.desc       : BitVector flipBitByIndex 10200201 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorFlipBitByIndex0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorFlipBitByIndex0004';
        console.info(`${caseName} test start`);
        let count = 0;
        let bitVector = new collections.BitVector(4);
        try {
          for (let i = 0; i < 100; i++) {
            taskpool.execute(testFlipBitByIndex, i, bitVector).then(() => {
              count++
            }).catch((e: BusinessError) => {
              console.info(`${caseName} Task execution catch: ${e.message}, code: ${e.code}`);
            })
          }
          for (let i = 0; i < 10; i++) {
            bitVector.flipBitByIndex(1)
          }
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200201)
        }
        while (count < 100) {
          await asyncSleep(100)
        }
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_FLIPBITBYINDEX_0500
     * @tc.name      : testBitVectorFlipBitByIndex0005
     * @tc.desc      : BitVector flipBitByIndex 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testBitVectorFlipBitByIndex0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorFlipBitByIndex0005';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.flipBitByIndex(NaN);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_FLIPBITBYRANGE_0100
     * @tc.name       : testBitVectorFlipBitsByRange0001
     * @tc.desc       : Testing the flipBitsByRange of bitVector, fromIndex=0,toIndex=6.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testBitVectorFlipBitsByRange0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testBitVectorFlipBitsByRange0001";
        try {
          let bitVectorList: collections.BitVector = new collections.BitVector(0);
          for (let i = 0; i < 10; i++) {
            if (i < 5) {
              bitVectorList.push(0);
            } else {
              bitVectorList.push(1);
            }
          }
          bitVectorList.flipBitsByRange(0, 6);
          let arrayList = new collections.Array<string>("1", "1", "1", "1", "1", "0", "1", "1", "1", "1");
          for (let i = 0; i < 10; i++) {
            expect(bitVectorList[i].toString()).assertEqual(arrayList[i]);
          }
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done()
      });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_FLIPBITBYRANGE_0200
     * @tc.name       : testBitVectorFlipBitsByRange0002
     * @tc.desc       : BitVector flipBitsByRange 10200001 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorFlipBitsByRange0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorFlipBitsByRange0002';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.flipBitsByRange(-1, 4);
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200001)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_FLIPBITBYRANGE_0300
     * @tc.name       : testBitVectorFlipBitsByRange0003
     * @tc.desc       : BitVector flipBitsByRange 10200001 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorFlipBitsByRange0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorFlipBitsByRange0003';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.flipBitsByRange(4, -1);
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200001)
          flag = true
        }
        expect(flag).assertTrue()
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_FLIPBITBYRANGE_0400
     * @tc.name       : testBitVectorFlipBitsByRange0004
     * @tc.desc       : BitVector flipBitsByRange 10200011 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorFlipBitsByRange0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorFlipBitsByRange0004';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          let flipBitsByRangeMethod = bitVector.flipBitsByRange;
          flipBitsByRangeMethod(1, 4)
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_FLIPBITBYRANGE_0500
     * @tc.name       : testBitVectorFlipBitsByRange0005
     * @tc.desc       : BitVector flipBitsByRange 10200201 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorFlipBitsByRange0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorFlipBitsByRange0005';
        console.info(`${caseName} test start`);
        let count = 0;
        let bitVector = new collections.BitVector(4);
        try {
          for (let i = 0; i < 100; i++) {
            taskpool.execute(testFlipBitsByRange, i, bitVector).then(() => {
              count++
            }).catch((e: BusinessError) => {
              console.info(`${caseName} Task execution catch: ${e.message}, code: ${e.code}`);
            })
          }
          for (let i = 0; i < 10; i++) {
            bitVector.flipBitsByRange(0, 1)
          }
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200201)
        }
        while (count < 100) {
          await asyncSleep(100)
        }
        console.info(`${caseName} test end`);
        done()
      })

    /**
     * @tc.number    : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_FLIPBITBYRANGE_0600
     * @tc.name      : testBitVectorFlipBitsByRange0006
     * @tc.desc      : BitVector flipBitsByRange 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testBitVectorFlipBitsByRange0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorFlipBitsByRange0006';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.push(1);
          bitVector.push(0);
          bitVector.flipBitsByRange(NaN, 4);
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_VALUES_0100
     * @tc.name       : testBitVectorValues0001
     * @tc.desc       : Testing the values of bitVector, bitvector is not null, return true.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testBitVectorValues0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testBitVectorValues0001";
      try {
        let bitVectorList: collections.BitVector = new collections.BitVector(0);
        bitVectorList.push(0);
        bitVectorList.push(1);
        bitVectorList.push(1);
        let arrayList = new Array<number>(0, 1, 1);
        let i = 0;
        for (let iter of bitVectorList.values()) {
          expect(iter).assertEqual(arrayList[i])
          i++;
        }
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
      done()
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_VALUES_0200
     * @tc.name       : testBitVectorValues0002
     * @tc.desc       : BitVector values 10200011 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorValues0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorValues0002';
        let flag: boolean = false;
        console.info(`${caseName} test start`);
        try {
          let bitVector: collections.BitVector = new collections.BitVector(0);
          const valuesFunc = bitVector.values;
          let iter: IterableIterator<number> = valuesFunc();
          let temp: IteratorResult<number> = iter.next();
          while (!temp.done) {
            console.info(JSON.stringify(temp.value));
            temp = iter.next();
          }
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
     * @tc.number     : SUB_COMMONLIBRARY_COLLECTIONS_BITVECTOR_VALUES_0300
     * @tc.name       : testBitVectorValues0003
     * @tc.desc       : BitVector values 10200201 error
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testBitVectorValues0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: () => void): Promise<void> => {
        const caseName = 'testBitVectorValues0003';
        console.info(`${caseName} test start`);
        let count = 0;
        let bitVector = new collections.BitVector(4);
        try {
          for (let i = 0; i < 100; i++) {
            taskpool.execute(testValues, i, bitVector).then(() => {
              count++
            }).catch((e: BusinessError) => {
              console.info(`${caseName} Task execution catch: ${e.message}, code: ${e.code}`);
            })
          }
          for (let i = 0; i < 10; i++) {
            let res = bitVector.values()
          }
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect(e.code).assertEqual(10200201)
        }
        while (count < 100) {
          await asyncSleep(100)
        }
        console.info(`${caseName} test end`);
        done()
      })
  })
}