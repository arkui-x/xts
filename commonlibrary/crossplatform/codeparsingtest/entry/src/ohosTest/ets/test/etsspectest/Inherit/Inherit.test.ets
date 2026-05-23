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

import {getLiteralObject, InheritTest006, InheritTest007, InheritTest008, InheritTest009,
  InheritTest010} from './Inherit'

export default function InheritTest() {
  describe('InheritTest', () => {
    beforeEach(async () => {
      await sleep(100)
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0100
     * @tc.number ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0100
     * @tc.desc   Access own property of object
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const o:ESObject = getLiteralObject({ a: 1, b: 2, __proto__: { b: 3, c: 4 } });
      expect(o.a).assertEqual(1);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0200
     * @tc.number ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0200
     * @tc.desc   Property shadowing for own property
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const o:ESObject = getLiteralObject({ a: 1, b: 2, __proto__: { b: 3, c: 4 } });
      expect(o.b).assertEqual(2);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0300
     * @tc.number ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0300
     * @tc.desc   Access inherited property from prototype
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const o:ESObject = getLiteralObject( { a: 1, b: 2, __proto__: { b: 3, c: 4 } });
      expect(o.c).assertEqual(4);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0400
     * @tc.number ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0400
     * @tc.desc   Return undefined for non-existent property
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const o:ESObject = getLiteralObject( { a: 1, b: 2, __proto__: { b: 3, c: 4 } });
      expect(o.d).assertEqual(undefined);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0500
     * @tc.number ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0500
     * @tc.desc   Access property from long prototype chain
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      const o:ESObject = getLiteralObject( { a: 1, b: 2, __proto__: { b: 3, c: 4, __proto__: { d: 5 } } });
      expect(o.d).assertEqual(5);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0600
     * @tc.number ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0600
     * @tc.desc   Inherited method uses parent's property
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      expect(InheritTest006()).assertEqual(3);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0700
     * @tc.number ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0700
     * @tc.desc   Method overriding with child's own property
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      expect(InheritTest007()).assertEqual(5);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0800
     * @tc.number ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0800
     * @tc.desc   Constructor prototype method reuse
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      expect(InheritTest008()).assertEqual(1);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0900
     * @tc.number ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0900
     * @tc.desc   Modify prototype method affects existing instances
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      expect(InheritTest009()).assertEqual(2);
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_1000
     * @tc.number ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_1000
     * @tc.desc   Class syntax is syntactic sugar for constructor
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_INHERIT_INHERIT_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, ():void => {
      expect(InheritTest010()).assertEqual(3);
    })
  })
}
