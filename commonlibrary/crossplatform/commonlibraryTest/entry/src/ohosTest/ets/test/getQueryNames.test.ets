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

let str2 =
  '!!%22%22%23%23%24%24%25%25\'\'(())**%2B%2B%2C%2C--..%2F%2F%3A%3A%3B%3B%3C%3C%3D%3D%3E%3E%3F%3F%40%40%5B%5B%5C%5C%5D%5D%5E%5E__%60%60%7B%7B%7C%7C%7D%7D~~';
let str2Decode = '!!""##$$%%\'\'(())**++,,--..//::;;<<==>>??@@[[\\\\]]^^__``{{||}}~~';
let str3 =
  '%21%21%22%22%23%23%24%24%25%25%26%26%27%27%28%28%2A%2A%2B%2B%2C%2C%2D%2D%2E%2E%2F%2F%3A%3A%3B%3B%3C%3C%3D%3D%3E%3E%3F%3F%40%40%5B%5B%5C%5C%5D%5D%5E%5E%5F%5F%60%60%7B%7B%7C%7C%7D%7D%7E%7E';
let str3Decode = '!!""##$$%%&&\'\'((**++,,--..//::;;<<==>>??@@[[\\\\]]^^__``{{||}}~~';

export class Utils {
  static async msSleep(count: number): Promise<number> {
    return new Promise<number>((resolve, reject) => {
      setTimeout(() => {
        resolve(0)
      }, count)
    })
  }
}

export default function GetQueryNamesTest() {
  describe('GetQueryNamesTest', () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_UTIL_GETQUERYNAMES_0100
     * @tc.name      : testGetQueryNames0001
     * @tc.desc      : Testing if query names with special characters in their values are correctly retrieved from the URI.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryNames0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetQueryNames0001';
      try {
        let uri1 =
          'https://username:password@host:8080/directory/file?key1' + str2 + '=value1&key2' + str2 + '=value2&key1' +
            str2 + '=value3#qwer=da';
        let uriInstance = new uri.URI(uri1);
        let result1 = Array.from(uriInstance.getQueryNames()).toString();
        expect(result1).assertEqual('key1' + str2Decode + ',key2' + str2Decode);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_UTIL_GETQUERYNAMES_0200
     * @tc.name      : testGetQueryNames0002
     * @tc.desc      : Testing if query names with special characters in their values are correctly retrieved from the URI.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryNames0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetQueryNames0002';
      try {
        let uri1 =
          `https://username:password@host:8080/directory/file?key1${str3}=value1&key2${str3}=value2&key1${str3}=value3#qwer=da`;
        let uriInstance = new uri.URI(uri1);
        let result1 = Array.from(uriInstance.getQueryNames()).toString();
        expect(result1).assertEqual(`key1${str3Decode},key2${str3Decode}`);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_UTIL_GETQUERYNAMES_0300
     * @tc.name: testGetQueryNames0003
     * @tc.desc: Get the names of all query parameters in the URI
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetQueryNames0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('https://www.test.com?param1=value1&param2=value2');
      let paramNames = route.getQueryNames();
      expect(paramNames.length).assertEqual(2);
      expect(paramNames.values().next().value).assertEqual("param1");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_UTIL_GETQUERYNAMES_0400
     * @tc.name: testGetQueryNames0004
     * @tc.desc: Get the names of all query parameters in the URI
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetQueryNames0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('https://www.test.com');
      let paramNames = route.getQueryNames();
      expect(paramNames.length).assertEqual(0);
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_UTIL_GETQUERYNAMES_0500
     * @tc.name: testGetQueryNames0005
     * @tc.desc: Get the names of all query parameters in the URI
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetQueryNames0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('https://www.test.com?param1=value1&&param3=value3');
      let paramNames = route.getQueryNames();
      let values = paramNames.values();
      expect(paramNames.length).assertEqual(3);
      expect(values.next().value).assertEqual("param1");
      expect(values.next().value).assertEqual("");
      expect(values.next().value).assertEqual("param3");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_UTIL_GETQUERYNAMES_0600
     * @tc.name: testGetQueryNames0006
     * @tc.desc: Get the names of all query parameters in the URI
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetQueryNames0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('https://www.test.com?param1=value1&=value2&param3=value3');
      let paramNames = route.getQueryNames();
      expect(paramNames.length).assertEqual(3);
      let values = paramNames.values();
      expect(values.next().value).assertEqual("param1");
      expect(values.next().value).assertEqual("");
      expect(values.next().value).assertEqual("param3");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_UTIL_GETQUERYNAMES_0700
     * @tc.name: testGetQueryNames0007
     * @tc.desc: Get the names of all query parameters in the URI
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetQueryNames0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('https://www.test.com?param1=value1&&&a&b=v&param3');
      let paramNames = route.getQueryNames();
      expect(paramNames.length).assertEqual(5);
      let values = paramNames.values();
      expect(values.next().value).assertEqual("param1");
      expect(values.next().value).assertEqual("");
      expect(values.next().value).assertEqual("a");
      expect(values.next().value).assertEqual("b");
      expect(values.next().value).assertEqual("param3");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_UTIL_GETQUERYNAMES_0800
     * @tc.name: testGetQueryNames0008
     * @tc.desc: Get the names of all query parameters in the URI
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetQueryNames0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('https://www.test.com?param%201=value1');
      let paramNames = route.getQueryNames();
      expect(paramNames.length).assertEqual(1);
      expect(paramNames.values().next().value).assertEqual("param 1");
      let route1 = new uri.URI('https://www.test.com?param+1=value1');
      let paramNames1 = route1.getQueryNames();
      expect(paramNames1.length).assertEqual(1);
      expect(paramNames1.values().next().value).assertEqual("param+1");
    });
  })
}