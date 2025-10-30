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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, Level, Size, TestType } from '@ohos/hypium';
import uri from '@ohos.uri';

function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function CheckHierarchicalTest() {
  describe('CheckHierarchicalTest', () => {
    beforeAll(() => {
      console.info("beforeAll: Prerequisites at the test suite level, which are executed before the test suite is executed.");
    });
    beforeEach(async() => {
      await sleep(100);
      console.info("beforeEach: Prerequisites at the test case level, which are executed before each test case is executed.");
    });
    afterEach(() => {
      console.info("afterEach: Test case-level clearance conditions, which are executed after each test case is executed.");
    });
    afterAll(async() => {
      await sleep(500);
      console.info("afterAll: Test suite-level cleanup condition, which is executed after the test suite is executed");
    });
    console.info("start################################start");

    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_CHECJHIERARCHIACL_0100
     * @tc.name: testCheckHierarchical0001
     * @tc.desc: Tells whether or not this URI is Opaque.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testCheckHierarchical0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let route = new uri.URI('http://www.test.com/images/pic.jpg');
      let res = route.checkHierarchical();
      expect(String(res)).assertEqual('true');
    });

    // Check the UriCheckHierarchical.
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_CHECJHIERARCHIACL_0200
     * @tc.name: testCheckHierarchical0002
     * @tc.desc: Tells whether or not this URI is Opaque.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testCheckHierarchical0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let route = new uri.URI('mailto:test@test.com');
      let res = route.checkHierarchical();
      expect(String(res)).assertEqual('false');
    });

    // Check the UriCheckHierarchical.
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_CHECJHIERARCHIACL_0300
     * @tc.name: testCheckHierarchical0003
     * @tc.desc: Tells whether or not this URI is Opaque.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testCheckHierarchical0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let route = new uri.URI('images/pic.jpg');
      let res = route.checkHierarchical();
      expect(String(res)).assertEqual('true');
    });

    // Check the UriCheckHierarchical.
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_CHECJHIERARCHIACL_0400
     * @tc.name: testCheckHierarchical0004
     * @tc.desc: Tells whether or not this URI is Opaque.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testCheckHierarchical0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let route = new uri.URI('path');
      expect(String(route.checkHierarchical())).assertEqual('true');
      let testUri = new uri.URI('path:');
      expect(String(testUri.checkHierarchical())).assertEqual('false');
    })
  })
}