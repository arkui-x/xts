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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, Level, Size, TestType } from '@ohos/hypium';
import { NewObject } from './MapClear';

const WAIT_READY_MS_2000: number = 2000
const WAIT_READY_MS_300: number = 300

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

export default function MapClearTest() {
  describe('MapClearTest', () => {
    beforeAll(async () => {
      await sleep(WAIT_READY_MS_2000)
    })
    beforeEach(async () => {
      await sleep(WAIT_READY_MS_300)
    })
    afterEach(async () => {
      await sleep(WAIT_READY_MS_300)
    })
    afterAll(async () => {
      await sleep(WAIT_READY_MS_300)
    })

    /**
     * @tc.name   ArkUIX_SUB_MAPTEST_MAPCLEAR_0100
     * @tc.number ArkUIX_SUB_MAPTEST_MAPCLEAR_0100
     * @tc.desc   Clear an empty Map, check size is 0
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_MAPTEST_MAPCLEAR_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const map: Map<number, number> = new Map();
      map.clear();
      expect(map.size).assertEqual(0);
    });

    /**
     * @tc.name   ArkUIX_SUB_MAPTEST_MAPCLEAR_0200
     * @tc.number ArkUIX_SUB_MAPTEST_MAPCLEAR_0200
     * @tc.desc   Clear a Map with one element, check size is 0
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_MAPTEST_MAPCLEAR_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const map: Map<string, string> = new Map();
      map.set('key', 'value');
      map.clear();
      expect(map.size).assertEqual(0);
    });

    /**
     * @tc.name   ArkUIX_SUB_MAPTEST_MAPCLEAR_0300
     * @tc.number ArkUIX_SUB_MAPTEST_MAPCLEAR_0300
     * @tc.desc   Clear a Map with multiple elements, check size is 0
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_MAPTEST_MAPCLEAR_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const map: Map<number, string> = new Map();
      map.set(1, 'a');
      map.set(2, 'b');
      map.set(3, 'c');
      map.clear();
      expect(map.size).assertEqual(0);
    });

    /**
     * @tc.name   ArkUIX_SUB_MAPTEST_MAPCLEAR_0400
     * @tc.number ArkUIX_SUB_MAPTEST_MAPCLEAR_0400
     * @tc.desc   After clear, check if original key exists
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_MAPTEST_MAPCLEAR_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const map: Map<string, string> = new Map();
      map.set('key', 'value');
      map.clear();
      expect(map.has('key')).assertEqual(false);
    });

    /**
     * @tc.name   ArkUIX_SUB_MAPTEST_MAPCLEAR_0500
     * @tc.number ArkUIX_SUB_MAPTEST_MAPCLEAR_0500
     * @tc.desc   After clear, check if get returns undefined for original key
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_MAPTEST_MAPCLEAR_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const map: Map<string, string> = new Map();
      map.set('key', 'value');
      map.clear();
      expect(map.get('key')).assertEqual(undefined);
    });

    /**
     * @tc.name   ArkUIX_SUB_MAPTEST_MAPCLEAR_0600
     * @tc.number ArkUIX_SUB_MAPTEST_MAPCLEAR_0600
     * @tc.desc   Clear a Map with number keys
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_MAPTEST_MAPCLEAR_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const map: Map<number, string> = new Map();
      map.set(100, 'hundred');
      map.set(200, 'two hundred');
      map.clear();
      expect(map.size).assertEqual(0);
    });

    /**
     * @tc.name   ArkUIX_SUB_MAPTEST_MAPCLEAR_0700
     * @tc.number ArkUIX_SUB_MAPTEST_MAPCLEAR_0700
     * @tc.desc   Clear a Map with boolean keys
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_MAPTEST_MAPCLEAR_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const map: Map<boolean, string> = new Map();
      map.set(true, 'yes');
      map.set(false, 'no');
      map.clear();
      expect(map.size).assertEqual(0);
    });

    /**
     * @tc.name   ArkUIX_SUB_MAPTEST_MAPCLEAR_0800
     * @tc.number ArkUIX_SUB_MAPTEST_MAPCLEAR_0800
     * @tc.desc   Clear a Map with object keys
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_MAPTEST_MAPCLEAR_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const obj1 = NewObject();
      const obj2 = NewObject();
      const map: Map<object, string> = new Map();
      map.set(obj1, 'value1');
      map.set(obj2, 'value2');
      map.clear();
      expect(map.size).assertEqual(0);
    });

    /**
     * @tc.name   ArkUIX_SUB_MAPTEST_MAPCLEAR_0900
     * @tc.number ArkUIX_SUB_MAPTEST_MAPCLEAR_0900
     * @tc.desc   Clear a Map with null key
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_MAPTEST_MAPCLEAR_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const map: Map<ESObject, string> = new Map();
      map.set(null, 'null value');
      map.clear();
      expect(map.size).assertEqual(0);
    });

    /**
     * @tc.name   ArkUIX_SUB_MAPTEST_MAPCLEAR_1000
     * @tc.number ArkUIX_SUB_MAPTEST_MAPCLEAR_1000
     * @tc.desc   Clear a Map with undefined key
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_MAPTEST_MAPCLEAR_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      const map: Map<ESObject, string> = new Map();
      map.set(undefined, 'undefined value');
      map.clear();
      expect(map.size).assertEqual(0);
    });
  })
}


