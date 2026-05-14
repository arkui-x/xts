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

const WAIT_READY_MS_2000: number = 2000
const WAIT_READY_MS_300: number = 300

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

export default function DateTestCase001() {
  describe('DateTestCase001', () => {
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
     * @tc.name   ArkUIX_SUB_DATETEST_DATETESTCASE001_0100
     * @tc.number ArkUIX_SUB_DATETEST_DATETESTCASE001_0100
     * @tc.desc   Verify toDateString() returns date portion string.
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_DATETEST_DATETESTCASE001_0100', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, (): void => {
      const date: Date = new Date(2024, 5, 15, 14, 30, 45);
      const str: string = date.toDateString();
      expect(typeof str).assertEqual('string');
      expect(str.length).assertLarger(0);
    });

    /**
     * @tc.name   ArkUIX_SUB_DATETEST_DATETESTCASE001_0200
     * @tc.number ArkUIX_SUB_DATETEST_DATETESTCASE001_0200
     * @tc.desc   Verify toDateString() format includes month, day, year.
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_DATETEST_DATETESTCASE001_0200', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, (): void => {
      const date: Date = new Date(2024, 5, 15);
      const str: string = date.toDateString();
      expect(str).assertEqual("Sat Jun 15 2024");
    });

    /**
     * @tc.name   ArkUIX_SUB_DATETEST_DATETESTCASE001_0300
     * @tc.number ArkUIX_SUB_DATETEST_DATETESTCASE001_0300
     * @tc.desc   Verify toISOString() returns ISO 8601 format string.
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_DATETEST_DATETESTCASE001_0300', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, (): void => {
      const date: Date = new Date('2024-06-15T12:00:00Z');
      const isoString: string = date.toISOString();
      expect(isoString).assertEqual('2024-06-15T12:00:00.000Z');
    });

    /**
     * @tc.name   ArkUIX_SUB_DATETEST_DATETESTCASE001_0400
     * @tc.number ArkUIX_SUB_DATETEST_DATETESTCASE001_0400
     * @tc.desc   Verify toISOString() format compliance.
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_DATETEST_DATETESTCASE001_0400', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, (): void => {
      const date: Date = new Date(Date.UTC(2024, 5, 15, 14, 30, 45, 123));
      const isoString: string = date.toISOString();
      expect(isoString).assertEqual("2024-06-15T14:30:45.123Z");
    });

    /**
     * @tc.name   ArkUIX_SUB_DATETEST_DATETESTCASE001_0500
     * @tc.number ArkUIX_SUB_DATETEST_DATETESTCASE001_0500
     * @tc.desc   Verify toJSON() returns ISO format string.
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_DATETEST_DATETESTCASE001_0500', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, (): void => {
      const date: Date = new Date('2024-06-15T12:00:00Z');
      const json: string = date.toJSON();
      expect(json).assertEqual('2024-06-15T12:00:00.000Z');
    });

    /**
     * @tc.name   ArkUIX_SUB_DATETEST_DATETESTCASE001_0600
     * @tc.number ArkUIX_SUB_DATETEST_DATETESTCASE001_0600
     * @tc.desc   Verify toJSON() and toISOString() return same value.
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_DATETEST_DATETESTCASE001_0600', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, (): void => {
      const date: Date = new Date('2024-06-15T12:00:00Z');
      expect(date.toJSON()).assertEqual(date.toISOString());
    });

    /**
     * @tc.name   ArkUIX_SUB_DATETEST_DATETESTCASE001_0700
     * @tc.number ArkUIX_SUB_DATETEST_DATETESTCASE001_0700
     * @tc.desc   Verify toJSON() returns null for invalid date.
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_DATETEST_DATETESTCASE001_0700', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, (): void => {
      const invalidDate: Date = new Date('invalid');
      expect(invalidDate.toJSON()).assertNull();
    });

    /**
     * @tc.name   ArkUIX_SUB_DATETEST_DATETESTCASE001_0800
     * @tc.number ArkUIX_SUB_DATETEST_DATETESTCASE001_0800
     * @tc.desc   Verify toLocaleDateString() returns localized date string.
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_DATETEST_DATETESTCASE001_0800', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, (): void => {
      const date: Date = new Date(2024, 5, 15);
      const str: string = date.toLocaleDateString();
      expect(typeof str).assertEqual('string');
      expect(str.length).assertLarger(0);
    });

    /**
     * @tc.name   ArkUIX_SUB_DATETEST_DATETESTCASE001_0900
     * @tc.number ArkUIX_SUB_DATETEST_DATETESTCASE001_0900
     * @tc.desc   Verify toLocaleDateString() with locale parameter.
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_DATETEST_DATETESTCASE001_0900', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, (): void => {
      const date: Date = new Date(2024, 5, 15);
      const str: string = date.toLocaleDateString('zh-CN');
      expect(typeof str).assertEqual('string');
    });

    /**
     * @tc.name   ArkUIX_SUB_DATETEST_DATETESTCASE001_1000
     * @tc.number ArkUIX_SUB_DATETEST_DATETESTCASE001_1000
     * @tc.desc   Verify toLocaleDateString() with options parameter.
     * @tc.type   FUNCTION
     * @tc.size   SMALLTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_DATETEST_DATETESTCASE001_1000', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL1, (): void => {
      const date: Date = new Date(2024, 5, 15);
      const options: Intl.DateTimeFormatOptions = {
        year: 'numeric',
        month: 'long',
        day: 'numeric'
      };
      const str: string = date.toLocaleDateString('en-US', options);
      expect(typeof str).assertEqual('string');
    });

  });
}
