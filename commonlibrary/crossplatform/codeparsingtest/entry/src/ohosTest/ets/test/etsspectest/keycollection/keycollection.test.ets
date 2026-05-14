/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, Level, TestType, Size } from '@ohos/hypium'
import { sleep } from '../../../testability/pages/Utils'

export default function KeyCollectionTest() {
  describe('KeyCollectionTest', () => {
    beforeEach(async () => {
      await sleep(100)
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0100
     * @tc.number ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0100
     * @tc.desc   Map initialization (Empty instance)
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const map: Map<string, number> = new Map();
      expect(map.size).assertEqual(0);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0200
     * @tc.number ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0200
     * @tc.desc   Map Initialization (including initial data)
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const map: Map<number, string> = new Map([[1, 'a'], [2, 'b']]);
      expect(map.size).assertEqual(2);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0300
     * @tc.number ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0300
     * @tc.desc   Map.set() New string key added
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const map: Map<string, boolean> = new Map();
      map.set('active', true);
      expect(map.get('active')).assertEqual(true);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0400
     * @tc.number ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0400
     * @tc.desc   Map.set() New number key added
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const map: Map<number, string> = new Map();
      map.set(100, 'hundred');
      expect(map.get(100)).assertEqual('hundred');
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0500
     * @tc.number ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0500
     * @tc.desc   Map.set() New object key
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      class A { id: number =1 };
      const key:A  = { id: 1 };
      const map: Map<A, string> = new Map();
      map.set(key, 'user');
      expect(map.get(key)).assertEqual('user');
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0600
     * @tc.number ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0600
     * @tc.desc   Map.get() Get a non-existent key
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const map: Map<string, number> = new Map();
      expect(map.get('none')).assertEqual(undefined);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0700
     * @tc.number ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0700
     * @tc.desc   Map.has() Detect non-existent keys
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const map: Map<boolean, string> = new Map();
      expect(map.has(false)).assertEqual(false);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0800
     * @tc.number ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0800
     * @tc.desc   Map.delete() Delete multiple keys consecutively
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const map: Map<number, number> = new Map([[1, 10], [2, 20], [3, 30]]);
      map.delete(1);
      map.delete(2);
      expect(map.size).assertEqual(1);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0900
     * @tc.number ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0900
     * @tc.desc   Map.clear() Then add the element again
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const map: Map<string, string> = new Map([['a', 'b']]);
      map.clear();
      map.set('c', 'd');
      expect(map.size).assertEqual(1);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_1000
     * @tc.number ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_1000
     * @tc.desc   Map iterator keys()
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_KEYCOLLECTION_KEYCOLLECTION_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const map: Map<number, string> = new Map([[1, 'x'], [2, 'y']]);
      const keys: number[] = Array.from(map.keys());
      expect(keys[0]).assertEqual(1);
    })
  })
}
