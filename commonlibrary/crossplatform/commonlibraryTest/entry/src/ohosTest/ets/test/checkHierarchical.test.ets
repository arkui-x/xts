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

export default function CheckHierarchicalTest() {
  describe('CheckHierarchicalTest', () => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(() => {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    })
    beforeEach(() => {
      // Presets an action, which is performed before each unit test case starts.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: preset action function.
    })
    afterEach(() => {
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    })
    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    })
    // Check the UriCheckHierarchical.
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