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
import { uri } from '@kit.ArkTS';

let str2 =
  '!!%22%22%23%23%24%24%25%25\'\'(())**%2B%2B%2C%2C--..%2F%2F%3A%3A%3B%3B%3C%3C%3D%3D%3E%3E%3F%3F%40%40%5B%5B%5C%5C%5D%5D%5E%5E__%60%60%7B%7B%7C%7C%7D%7D~~';
let str2Decode = '!!""##$$%%\'\'(())**++,,--..//::;;<<==>>??@@[[\\\\]]^^__``{{||}}~~';
let str3 =
  '%21%21%22%22%23%23%24%24%25%25%26%26%27%27%28%28%2A%2A%2B%2B%2C%2C%2D%2D%2E%2E%2F%2F%3A%3A%3B%3B%3C%3C%3D%3D%3E%3E%3F%3F%40%40%5B%5B%5C%5C%5D%5D%5E%5E%5F%5F%60%60%7B%7B%7C%7C%7D%7D%7E%7E';
let str3Decode = '!!""##$$%%&&\'\'((**++,,--..//::;;<<==>>??@@[[\\\\]]^^__``{{||}}~~';

export default function ClearQueryTest() {
  describe('ClearQueryTest', () => {
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
    /**
     * @tc.number    : SUB_COMMONLIBRARY_UTIL_CLEARQUERY_0100
     * @tc.name      : testClearQuery0001
     * @tc.desc      : Testing if query parameters with special characters in their keys are correctly cleared from the URI.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testClearQuery0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testClearQuery0001';
      try {
        let uri1 = `https://username:password@host:8080/directory/file?key1${str2}=value1&key1=value2#qwer=da`;
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.clearQuery().toString();
        expect(result1).assertEqual('https://username:password@host:8080/directory/file#qwer=da');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_UTIL_CLEARQUERY_0200
     * @tc.name      : testClearQuery0002
     * @tc.desc      : Testing if query parameters with special characters in their keys are correctly cleared from the URI.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testClearQuery0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testClearQuery0002';
      try {
        let uri1 = `https://username:password@host:8080/directory/file?key1${str3}=value1&key1=value2#qwer=da`;
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.clearQuery().toString();
        expect(result1).assertEqual('https://username:password@host:8080/directory/file#qwer=da');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_UTIL_CLEARQUERY_0300
     * @tc.name      : testClearQuery0003
     * @tc.desc      : Testing if query parameters with special characters in their values are correctly cleared from the URI.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testClearQuery0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testClearQuery0003';
      try {
        let uri1 = `https://username:password@host:8080/directory/file?key1=value1${str2}&key1=value2#qwer=da`;
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.clearQuery().toString();
        expect(result1).assertEqual('https://username:password@host:8080/directory/file#qwer=da');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_UTIL_CLEARQUERY_0400
     * @tc.name      : testClearQuery0004
     * @tc.desc      : Testing if query parameters with special characters in their values are correctly cleared from the URI.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testClearQuery0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testClearQuery0004';
      try {
        let uri1 = `https://username:password@host:8080/directory/file?key1=value1${str3}&key1=value2#qwer=da`;
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.clearQuery().toString();
        expect(result1).assertEqual('https://username:password@host:8080/directory/file#qwer=da');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_UTIL_CLEARQUERY_0500
     * @tc.name      : testClearQuery0005
     * @tc.desc      : Clear URI query parameters
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testClearQuery0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('https://www.test.com');
      let newRoute = route.clearQuery();
      expect(newRoute.toString()).assertEqual("https://www.test.com");
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_UTIL_CLEARQUERY_0600
     * @tc.name      : testClearQuery0006
     * @tc.desc      : Clear URI query parameters
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testClearQuery0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('https://www.test.com?param1=value1');
      let newRoute = route.clearQuery();
      expect(newRoute.toString()).assertEqual("https://www.test.com");
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_UTIL_CLEARQUERY_0700
     * @tc.name      : testClearQuery0007
     * @tc.desc: Clear URI query parameters
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testClearQuery0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('https://www.test.com?param1=value1%');
      let newRoute = route.clearQuery();
      expect(newRoute.toString()).assertEqual("https://www.test.com");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_UTIL_CLEARQUERY_0800
     * @tc.name: testClearQuery0008
     * @tc.desc: Clear URI query parameters
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testClearQuery0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('https://www.test.com?param1=value1&param1=value2');
      let newRoute = route.clearQuery();
      expect(newRoute.toString()).assertEqual("https://www.test.com");
    })
  })
}