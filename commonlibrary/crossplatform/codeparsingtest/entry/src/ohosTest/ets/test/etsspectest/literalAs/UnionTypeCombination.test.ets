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
import { sleep } from '../../../testability/pages/Utils';
import { UnionTypeTest } from './UnionTypeCombination';

export default function unionTypeCombination() {
  describe('UnionTypeCombination', () => {
    let unCls = new UnionTypeTest()
    beforeAll(() => {
    })
    beforeEach(async () => {
      await sleep(100)
    })
    afterEach(() => {
    })
    afterAll(() => {
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0100
     * @tc.number ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0100
     * @tc.desc   Literal Types and Union Primitive Type
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      expect(unCls.test1()).assertTrue();
    });
    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0200
     * @tc.number ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0200
     * @tc.desc   Literal Types and Union Primitive Type
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      expect(unCls.test4()).assertTrue();
    });
    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0300
     * @tc.number ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0300
     * @tc.desc   Literal Types and Union Primitive Type
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      expect(unCls.test6()).assertTrue();
    });
    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0400
     * @tc.number ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0400
     * @tc.desc   Literal Types and Union Primitive Type
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      expect(unCls.test8()).assertTrue();
    });
    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0500
     * @tc.number ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0500
     * @tc.desc   Literal Types and Union Primitive Type
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      expect(unCls.test10()).assertTrue();
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0600
     * @tc.number ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0600
     * @tc.desc   Literal Types and Union Primitive Type
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      expect(unCls.test12()).assertTrue();
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0700
     * @tc.number ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0700
     * @tc.desc   Literal Types and Union Primitive Type
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      expect(unCls.test14()).assertTrue();
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0800
     * @tc.number ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0800
     * @tc.desc   Literal Types and Union Primitive Type
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      expect(unCls.test16()).assertTrue();
    });
    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0900
     * @tc.number ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0900
     * @tc.desc   Literal Types and Union Primitive Type
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      expect(unCls.test17()).assertTrue();
    });
    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_1000
     * @tc.number ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_1000
     * @tc.desc   Literal Types and Union Primitive Type
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_LITERALAS_UNIONTYPECOMBINATION_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      expect(unCls.test18()).assertTrue();
    });
  })
}