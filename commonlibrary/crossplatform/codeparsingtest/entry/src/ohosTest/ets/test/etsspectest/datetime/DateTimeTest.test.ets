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

export default function dateTimeTest() {
  describe('DateTimeTest', () => {
    beforeEach(async () => {
      await sleep(100)
    })

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0100
     * @tc.number ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0100
     * @tc.desc   Verify creation with current time using new Date()
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0100', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const date = new Date();
      expect(date instanceof Date).assertTrue();
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0200
     * @tc.number ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0200
     * @tc.desc   Verify creation with timestamp (0 = 1970-01-01 UTC)
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0200', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const date = new Date(0);
      expect(date.toUTCString()).assertEqual('Thu, 01 Jan 1970 00:00:00 GMT');
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0300
     * @tc.number ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0300
     * @tc.desc   Verify creation with ISO string "2023-01-01"
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0300', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const date = new Date('2023-01-01');
      expect(date.getFullYear()).assertEqual(2023);
      expect(date.getMonth()).assertEqual(0);
      expect(date.getDate()).assertEqual(1);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0400
     * @tc.number ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0400
     * @tc.desc   Verify creation with year, month, day parameters
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0400', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const date = new Date(2023, 0, 1); // Month 0 = January
      expect(date.getFullYear()).assertEqual(2023);
      expect(date.getMonth()).assertEqual(0);
      expect(date.getDate()).assertEqual(1);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0500
     * @tc.number ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0500
     * @tc.desc   Verify getFullYear() returns correct year
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0500', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const date = new Date('2024-05-15');
      expect(date.getFullYear()).assertEqual(2024);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0600
     * @tc.number ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0600
     * @tc.desc   Verify getMonth() returns 0 for January
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0600', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const date = new Date('2023-01-15');
      expect(date.getMonth()).assertEqual(0);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0700
     * @tc.number ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0700
     * @tc.desc   Verify getDate() returns correct day of month
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0700', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const date = new Date('2023-03-25');
      expect(date.getDate()).assertEqual(25);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0800
     * @tc.number ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0800
     * @tc.desc   Verify getHours() returns correct hour
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0800', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const date = new Date('2023-01-01T14:30:00');
      expect(date.getHours()).assertEqual(14);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0900
     * @tc.number ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0900
     * @tc.desc   Verify getMinutes() returns correct minutes
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_0900', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const date = new Date('2023-01-01T14:30:00');
      expect(date.getMinutes()).assertEqual(30);
    });

    /**
     * @tc.name   ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_1000
     * @tc.number ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_1000
     * @tc.desc   Verify getSeconds() returns correct seconds
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_ETSSPECTEST_DATETIME_DATETIMETEST_1000', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, () => {
      const date = new Date('2023-01-01T14:30:45');
      expect(date.getSeconds()).assertEqual(45);
    });
  })
}