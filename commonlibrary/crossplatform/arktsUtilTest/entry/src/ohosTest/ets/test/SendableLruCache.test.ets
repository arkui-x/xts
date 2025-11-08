/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { describe, afterAll, it, expect, beforeAll, beforeEach, afterEach, TestType, Level, Size } from '@ohos/hypium'
import { ArkTSUtils } from '@kit.ArkTS';

function sleep(ms: number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function SendableLruCacheTest() {
  describe('SendableLruCacheTest', () => {
    afterEach(async () => {
      await sleep(1000)
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_CONSTRUCTOR_0100
     * @tc.name: testSendableLruCacheConstructor0001
     * @tc.desc: The default constructor is used to create a new SendableLRUCache instance with a default capacity of 64.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCacheConstructor0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testSendableLruCacheConstructor0001";
        try {
          let that = new ArkTSUtils.SendableLruCache<number | string, number | string>();
          let cap = that.getCapacity()
          expect(cap).assertEqual(64);
          done();
        } catch (error) {
          console.log(`${TAG} catchError ${JSON.stringify(error)}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_CONSTRUCTOR_0200
     * @tc.name: testSendableLruCacheConstructor0002
     * @tc.desc: The default constructor is used to create a new SendableLRUCache instance with a default capacity of 64.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCacheConstructor0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testSendableLruCacheConstructor0002";
        try {
          let that: ArkTSUtils.SendableLruCache<number | string, number | string> =
            new ArkTSUtils.SendableLruCache<number | string, number | string>(52);
          let cap: number = that.getCapacity()
          expect(cap).assertEqual(52);
          done();
        } catch (error) {
          console.log(`${TAG} catchError ${JSON.stringify(error)}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_UPDATECAPACITY_0100
     * @tc.name: testSendableLruCacheUpdateCapacity0001
     * @tc.desc: Updates the buffer capacity to a specified capacity.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCacheUpdateCapacity0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testSendableLruCacheUpdateCapacity0001";
        try {
          let that = new ArkTSUtils.SendableLruCache<number | string, number | string>()
          that.updateCapacity(10)
          let result = that.getCapacity()
          console.log(`${TAG} result:` + result);
          expect(result).assertEqual(10);
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_UPDATECAPACITY_0200
     * @tc.name: testSendableLruCacheUpdateCapacity0002
     * @tc.desc: Updates the buffer capacity to a specified capacity.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 2
     */
    it('testSendableLruCacheUpdateCapacity0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const TAG = "testSendableLruCacheUpdateCapacity0002";
        try {
          let that = new ArkTSUtils.SendableLruCache<number | string, number | string>()
          that.updateCapacity(-1)
          expect().assertFail();
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect(err.code == 401).assertTrue();
          done();
        }
      })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_GET_0100
     * @tc.name: testSendableLruCacheGet0001
     * @tc.desc: Obtains the value associated with a specified key.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCacheGet0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testSendableLruCacheGet0001";
      try {
        let that = new ArkTSUtils.SendableLruCache<number | string, number | string>(100)
        that.put(1, 2)
        let result = that.get(1)
        expect(result).assertEqual(2)
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_GET_0200
     * @tc.name: testSendableLruCacheGet0002
     * @tc.desc: Obtains the value associated with a specified key.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCacheGet0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testSendableLruCacheGet0002";
      try {
        let that = new ArkTSUtils.SendableLruCache<number | string, number | string>(100)
        that.put(1, 2)
        let result = that.get(5)
        expect(result).assertEqual(undefined)
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_PUT_0100
     * @tc.name: testSendableLruCachePut0001
     * @tc.desc: Adds a key-value pair to the buffer.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCachePut0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testSendableLruCachePut0001";
      try {
        let that = new ArkTSUtils.SendableLruCache<number | string, number | string>()
        let temp = that.put('1111', 'bcjdshc')
        expect(temp).assertEqual('bcjdshc')
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_PUT_0200
     * @tc.name: testSendableLruCachePut0002
     * @tc.desc: Adds a key-value pair to the buffer.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCachePut0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testSendableLruCachePut0002";
      try {
        let that = new ArkTSUtils.SendableLruCache<number | string, number | string>()
        let temp1 = that.put('1111', 'bcjdshc')
        let temp2 = that.put('1111', 13)
        expect(temp2).assertEqual(13)
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_REMOVE_0100
     * @tc.name: testSendableLruCacheRemove0001
     * @tc.desc: Deletes a specified key and its associated value from the current buffer.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCacheRemove0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testSendableLruCacheRemove0001";
      try {
        let that = new ArkTSUtils.SendableLruCache<number | string, number | string>()
        that.put(1, 2)
        let result = that.remove(1)
        expect(result).assertEqual(2)
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_REMOVE_0200
     * @tc.name: testSendableLruCacheRemove0002
     * @tc.desc: Deletes a specified key and its associated value from the current buffer.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCacheRemove0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testSendableLruCacheRemove0002";
      try {
        let that = new ArkTSUtils.SendableLruCache<number | string, number | string>()
        that.put(1, 2)
        let result1 = that.remove(1)
        let result2 = that.remove(1)
        expect(result1).assertEqual(2)
        expect(result2).assertEqual(undefined)
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_CONTAINS_0100
     * @tc.name: testSendableLruCacheContains0001
     * @tc.desc: Checks whether the current buffer contains a specified key.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCacheContains0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testSendableLruCacheContains0001";
        try {
          let that = new ArkTSUtils.SendableLruCache<number | string, number | string>()
          that.put(1, 2)
          let result = that.contains(1)
          expect(result).assertEqual(true)
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_CONTAINS_0200
     * @tc.name: testSendableLruCacheContains0002
     * @tc.desc: Checks whether the current buffer contains a specified key.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCacheContains0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testSendableLruCacheContains0002";
        try {
          let that = new ArkTSUtils.SendableLruCache<number | string, number | string>()
          that.put(1, 2)
          that.put('abcd', 20)
          let result1 = that.contains(1)
          let result2 = that.contains(20)
          expect(result1).assertEqual(true)
          expect(result2).assertEqual(false)
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_GETCREATECOUNT_0100
     * @tc.name: testSendableLruCacheGetCreateCount0001
     * @tc.desc: Obtains the number of times createDefault(Object) returned a value.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCacheGetCreateCount0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testSendableLruCacheGetCreateCount0001";
        try {
          let that = new ArkTSUtils.SendableLruCache<number | string, number | string>()
          that.put(1, 2)
          that.put(2, 10)
          that.put('abcd', 15)
          that.get(3)
          that.get(5)
          that.get(10)
          let result = that.getCreateCount()
          expect(result).assertEqual(0)
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_GETMISSCOUNT_0100
     * @tc.name: testSendableLruCacheGetMissCount0001
     * @tc.desc: Obtains the number of times that the queried values are not matched.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCacheGetMissCount0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testSendableLruCacheGetMissCount0001";
        try {
          let that = new ArkTSUtils.SendableLruCache<number | string, number | string>()
          that.put(1, 2)
          that.put(2, 10)
          that.put('abcd', 15)
          that.get(3)
          that.get(5)
          that.get(10)
          let result = that.getMissCount()
          expect(result).assertEqual(3)
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_GETREMOVECOUNT_0100
     * @tc.name: testSendableLruCacheGetRemoveCount0001
     * @tc.desc: Obtains the number of times that values are evicted from the buffer.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCacheGetRemoveCount0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testSendableLruCacheGetRemoveCount0001";
        try {
          let that = new ArkTSUtils.SendableLruCache<number | string, number | string>()
          that.put(1, 2)
          that.put(2, 10)
          that.put('abcd', 15)
          that.updateCapacity(2)
          that.put(3, 20)
          that.put(5, 30)
          let result = that.getRemoveCount()
          expect(result).assertEqual(3)
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_GETMATCHCOUNT_0100
     * @tc.name: testSendableLruCacheGetMatchCount0001
     * @tc.desc: Obtains the number of times that the queried values are successfully matched.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCacheGetMatchCount0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testSendableLruCacheGetMatchCount0001";
        try {
          let that = new ArkTSUtils.SendableLruCache<number | string, number | string>()
          that.put(1, 2)
          that.put(2, 10)
          that.put('abcd', 15)
          that.get(1)
          that.get(2)
          that.get('abcd')
          let result = that.getMatchCount()
          expect(result).assertEqual(3)
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_GETPUTCOUNT_0100
     * @tc.name: testSendableLruCacheGetPutCount0001
     * @tc.desc: Obtains the number of times that values are added to the buffer.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCacheGetPutCount0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testSendableLruCacheGetPutCount0001";
        try {
          let that = new ArkTSUtils.SendableLruCache<number | string, number | string>()
          that.put(1, 2)
          that.put(2, 10)
          that.updateCapacity(2)
          that.put('abcd', 'abc')
          let result = that.getPutCount()
          expect(result).assertEqual(3)
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_GETCAPACITY_0100
     * @tc.name: testSendableLruCacheGetCapacity0001
     * @tc.desc: Obtains the capacity of the current buffer.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCacheGetCapacity0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testSendableLruCacheGetCapacity0001";
        try {
          let that = new ArkTSUtils.SendableLruCache<number | string, number | string>()
          let result = that.getCapacity()
          expect(result).assertEqual(64)
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_CLEAR_0100
     * @tc.name: testSendableLruCacheClear0001
     * @tc.desc: Clears key-value pairs from the current buffer.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCacheClear0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testSendableLruCacheClear0001";
      try {
        let that = new ArkTSUtils.SendableLruCache<number | string, number | string>()
        that.put(1, 2)
        let result1 = that.length
        that.clear()
        let result2 = that.length
        expect(result1).assertEqual(1)
        expect(result2).assertEqual(0)
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_ISEMPTY_0100
     * @tc.name: testSendableLruCacheIsEmpty0001
     * @tc.desc: Checks whether the current buffer is empty.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCacheIsEmpty0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testSendableLruCacheIsEmpty0001";
        try {
          let that = new ArkTSUtils.SendableLruCache<number | string, number | string>()
          that.put(1, 2)
          let result = that.isEmpty()
          expect(result).assertEqual(false)
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_ISEMPTY_0200
     * @tc.name: testSendableLruCacheIsEmpty0002
     * @tc.desc: Checks whether the current buffer is empty.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCacheIsEmpty0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testSendableLruCacheIsEmpty0002";
        try {
          let that = new ArkTSUtils.SendableLruCache<number | string, number | string>()
          that.put(1, 2)
          that.put(2, 10)
          that.put(5, 33);
          that.clear()
          let result = that.isEmpty()
          expect(result).assertEqual(true)
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_TOSTRING_0100
     * @tc.name: testSendableLruCacheToString0001
     * @tc.desc: Returns a string representation of the object.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCacheToString0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testSendableLruCacheToString0001";
        try {
          let that = new ArkTSUtils.SendableLruCache<number | string, number | string>()
          that.put('1111', 'bcjdshc')
          that.put(1, 2)
          that.get(1)
          that.get('1111')
          let result = that.toString()
          expect(result).assertEqual('SendableLruCache[ maxSize = 64, hits = 2, misses = 0, hitRate = 100% ]')
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_VALUES_0100
     * @tc.name: testSendableLruCacheValues0001
     * @tc.desc: Obtains a list of all values in the current buffer.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCacheValues0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testSendableLruCacheValues0001";
      try {
        let that = new ArkTSUtils.SendableLruCache<number | string, number | string>()
        that.put(1, 2)
        that.put(3, 10)
        that.put(5, 15)
        that.put('abc', 20)
        that.get(3)
        let result = that.values()
        expect(result[0]).assertEqual(2)
        expect(result[1]).assertEqual(15)
        expect(result[2]).assertEqual(20)
        expect(result[3]).assertEqual(10)
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_KEYS_0100
     * @tc.name: testSendableLruCacheKeys0001
     * @tc.desc: Obtains a list of keys for the values in the current buffer.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCacheKeys0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testSendableLruCacheKeys0001";
      try {
        let that = new ArkTSUtils.SendableLruCache<number | string, number | string>()
        that.put(1, 2)
        that.put(3, 10)
        that.put(5, 15)
        that.put('abc', 20)
        let result = that.keys()
        expect(result[0]).assertEqual(1)
        expect(result[1]).assertEqual(3)
        expect(result[2]).assertEqual(5)
        expect(result[3]).assertEqual('abc')
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_ENTRIES_0100
     * @tc.name: testSendableLruCacheENTRIES0001
     * @tc.desc: Returns an array of key-value pairs of enumeratable properties of a given object.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLruCacheENTRIES0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const TAG = "testSendableLruCacheENTRIES0001";
        try {
          let that = new ArkTSUtils.SendableLruCache<number | string, number | string>()
          that.put(1, 2)
          that.put(3, 10)
          that.put(5, 15)
          that.put('abc', 20)
          let i = 0;
          let arr = new Array<number | string>();
          for (let entry of that.entries()) {
            arr[i] = entry[0];
            i++;
            arr[i] = entry[1];
            i++;
          }
          expect(arr[1]).assertEqual(2);
          done();
        } catch (err) {
          console.error(`${TAG} failed, error: ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_LENGTH_001
     * @tc.name: testSendableLRUCacheLength001
     * @tc.desc: Obtains the total number of values in the current buffer.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLRUCacheLength001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testSendableLRUCacheLength001";
      try {
        let that = new ArkTSUtils.SendableLruCache<number | string, number | string>()
        that.put(1, 2)
        that.put(2, 10)
        that.put('abcd', 15)
        that.put('abcd', 20)
        let result = that.length
        expect(result).assertEqual(3)
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
    })

    /**
     * @tc.number: SUB_COMMONLIBRARY_ARKTSUTILS_SENDABLELRUCACHE_LENGTH_002
     * @tc.name: testSendableLRUCacheLength002
     * @tc.desc: Obtains the total number of values in the current buffer.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testSendableLRUCacheLength002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const TAG = "testSendableLRUCacheLength002";
      try {
        let that = new ArkTSUtils.SendableLruCache<number | string, number | string>()
        that.put(1, 2)
        that.put(2, 10)
        that.put('abcd', 15)
        that.put('abcd', 20)
        that.updateCapacity(3);
        that.put(5, 33);
        that.put(25, 35);
        let result = that.length
        expect(result).assertEqual(3)
        done();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
        done();
      }
    })
  });
}