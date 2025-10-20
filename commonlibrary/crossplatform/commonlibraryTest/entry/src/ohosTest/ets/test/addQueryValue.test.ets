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

export default function AddQueryValueTest() {
  describe('AddQueryValueTest', () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_URI_BASE_ADDQUERYVALUE_0100
     * @tc.name      : testAddQueryValue0001
     * @tc.desc      : Testing if a query parameter with special characters in the key is correctly added to the URI.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testAddQueryValue0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testAddQueryValue0001';
      try {
        let uri1 = 'https://username:password@host:8080/directory/file';
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.addQueryValue('key1' + str2, 'value').query;
        expect(result1).assertEqual('key1' + str2 + '=value');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_BASE_ADDQUERYVALUE_0200
     * @tc.name      : testAddQueryValue0002
     * @tc.desc      : Testing if a query parameter with special characters in the key is correctly added to the URI.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testAddQueryValue0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testAddQueryValue0002';
      try {
        let uri1 = 'https://username:password@host:8080/directory/file';
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.addQueryValue('key1' + str3, 'value').query;
        expect(result1).assertEqual('key1' + str3 + '=value');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_BASE_ADDQUERYVALUE_0300
     * @tc.name      : testAddQueryValue0003
     * @tc.desc      : Testing if a query parameter with special characters in the value is correctly added to the URI.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testAddQueryValue0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testAddQueryValue0003';
      try {
        let uri1 = 'https://username:password@host:8080/directory/file';
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.addQueryValue('key1', 'value' + str2).query;
        expect(result1).assertEqual('key1=value' + str2);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_BASE_ADDQUERYVALUE_0400
     * @tc.name      : testAddQueryValue0004
     * @tc.desc      : Testing if a query parameter with special characters in the value is correctly added to the URI.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testAddQueryValue0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testAddQueryValue0004';
      try {
        let uri1 = 'https://username:password@host:8080/directory/file';
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.addQueryValue('key1', 'value' + str3).query;
        expect(result1).assertEqual('key1=value' + str3);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_ADDQUERYVALUE_0500
     * @tc.name       : testAddQueryValue0005
     * @tc.desc       : Testing the Uri interface AddQueryValue with input emoji \ud83d\ude0a
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAddQueryValue0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testAddQueryValue0005";
      try {
        let emoji = '\ud83d\ude0a';
        let baseUri = new uri.URI('http://test.com');
        let newUri1 = baseUri.addQueryValue('smile', emoji);
        let newUri2 = newUri1.addQueryValue('smile', emoji);
        let newUri3 = newUri2.addQueryValue('smile', emoji);
        expect(newUri1.toString()).assertEqual('http://test.com?smile=%F0%9F%98%8A');
        expect(newUri2.toString()).assertEqual('http://test.com?smile=%F0%9F%98%8A&smile=%F0%9F%98%8A');
        expect(newUri3.toString())
          .assertEqual('http://test.com?smile=%F0%9F%98%8A&smile=%F0%9F%98%8A&smile=%F0%9F%98%8A');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_ADDQUERYVALUE_0600
     * @tc.name       : testAddQueryValue0006
     * @tc.desc       : Testing the Uri interface AddQueryValue with input emoji \ud83d\udc64
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAddQueryValue0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testAddQueryValue0006";
      try {
        let emoji = '\ud83d\udc64';
        let baseUri = new uri.URI('http://test.com');
        let newUri1 = baseUri.addQueryValue('avatar', emoji);
        let newUri2 = newUri1.addQueryValue('avatar', emoji);
        let newUri3 = newUri2.addQueryValue('avatar', emoji);
        expect(newUri1.toString()).assertEqual('http://test.com?avatar=%F0%9F%91%A4');
        expect(newUri2.toString()).assertEqual('http://test.com?avatar=%F0%9F%91%A4&avatar=%F0%9F%91%A4');
        expect(newUri3.toString())
          .assertEqual('http://test.com?avatar=%F0%9F%91%A4&avatar=%F0%9F%91%A4&avatar=%F0%9F%91%A4');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_ADDQUERYVALUE_0700
     * @tc.name       : testAddQueryValue0007
     * @tc.desc       : Testing the Uri interface AddQueryValue with input emoji \ud83d\udc6b
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAddQueryValue0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testAddQueryValue0007";
      try {
        let emoji = '\ud83d\udc6b';
        let baseUri = new uri.URI('http://test.com');
        let newUri1 = baseUri.addQueryValue('parent', emoji);
        let newUri2 = newUri1.addQueryValue('parent', emoji);
        let newUri3 = newUri2.addQueryValue('parent', emoji);
        expect(newUri1.toString()).assertEqual('http://test.com?parent=%F0%9F%91%AB');
        expect(newUri2.toString()).assertEqual('http://test.com?parent=%F0%9F%91%AB&parent=%F0%9F%91%AB');
        expect(newUri3.toString())
          .assertEqual('http://test.com?parent=%F0%9F%91%AB&parent=%F0%9F%91%AB&parent=%F0%9F%91%AB');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_ADDQUERYVALUE_0800
     * @tc.name       : testAddQueryValue0008
     * @tc.desc       : Testing the Uri interface AddQueryValue with input emoji \u260e
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAddQueryValue0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testAddQueryValue0008";
      try {
        let emoji = '\u260e';
        let baseUri = new uri.URI('http://test.com');
        let newUri1 = baseUri.addQueryValue('phone', emoji);
        let newUri2 = newUri1.addQueryValue('phone', emoji);
        let newUri3 = newUri2.addQueryValue('phone', emoji);
        expect(newUri1.toString()).assertEqual('http://test.com?phone=%E2%98%8E');
        expect(newUri2.toString()).assertEqual('http://test.com?phone=%E2%98%8E&phone=%E2%98%8E');
        expect(newUri3.toString()).assertEqual('http://test.com?phone=%E2%98%8E&phone=%E2%98%8E&phone=%E2%98%8E');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_ADDQUERYVALUE_0900
     * @tc.name       : testAddQueryValue0009
     * @tc.desc       : Testing the Uri interface AddQueryValue with input emoji \ud83d\udc79
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAddQueryValue0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testAddQueryValue0009";
      try {
        let emoji = '\ud83d\udc79';
        let baseUri = new uri.URI('http://test.com');
        let newUri1 = baseUri.addQueryValue('grimace', emoji);
        let newUri2 = newUri1.addQueryValue('grimace', emoji);
        let newUri3 = newUri2.addQueryValue('grimace', emoji);
        expect(newUri1.toString()).assertEqual('http://test.com?grimace=%F0%9F%91%B9');
        expect(newUri2.toString()).assertEqual('http://test.com?grimace=%F0%9F%91%B9&grimace=%F0%9F%91%B9');
        expect(newUri3.toString())
          .assertEqual('http://test.com?grimace=%F0%9F%91%B9&grimace=%F0%9F%91%B9&grimace=%F0%9F%91%B9');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_ADDQUERYVALUE_1000
     * @tc.name       : testAddQueryValue0010
     * @tc.desc       : Testing the Uri interface AddQueryValue with input emoji \ud83d\udd5b
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAddQueryValue0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testAddQueryValue0010";
      try {
        let emoji = '\ud83d\udd5b';
        let baseUri = new uri.URI('http://test.com');
        let newUri1 = baseUri.addQueryValue('timepiece', emoji);
        let newUri2 = newUri1.addQueryValue('timepiece', emoji);
        let newUri3 = newUri2.addQueryValue('timepiece', emoji);
        expect(newUri1.toString()).assertEqual('http://test.com?timepiece=%F0%9F%95%9B');
        expect(newUri2.toString()).assertEqual('http://test.com?timepiece=%F0%9F%95%9B&timepiece=%F0%9F%95%9B');
        expect(newUri3.toString())
          .assertEqual('http://test.com?timepiece=%F0%9F%95%9B&timepiece=%F0%9F%95%9B&timepiece=%F0%9F%95%9B');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_ADDQUERYVALUE_1100
     * @tc.name       : testAddQueryValue0011
     * @tc.desc       : Testing the Uri interface AddQueryValue with input emoji \ud83c\udf4f
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAddQueryValue0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testAddQueryValue0011";
      try {
        let emoji = '\ud83c\udf4f';
        let baseUri = new uri.URI('http://test.com');
        let newUri1 = baseUri.addQueryValue('apple', emoji);
        let newUri2 = newUri1.addQueryValue('apple', emoji);
        let newUri3 = newUri2.addQueryValue('apple', emoji);
        expect(newUri1.toString()).assertEqual('http://test.com?apple=%F0%9F%8D%8F');
        expect(newUri2.toString()).assertEqual('http://test.com?apple=%F0%9F%8D%8F&apple=%F0%9F%8D%8F');
        expect(newUri3.toString())
          .assertEqual('http://test.com?apple=%F0%9F%8D%8F&apple=%F0%9F%8D%8F&apple=%F0%9F%8D%8F');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_ADDQUERYVALUE_1200
     * @tc.name       : testAddQueryValue0012
     * @tc.desc       : Testing the Uri interface AddQueryValue with input emoji \ud83d\udd03
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAddQueryValue0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testAddQueryValue0012";
      try {
        let emoji = '\ud83d\udd03';
        let baseUri = new uri.URI('http://test.com');
        let newUri1 = baseUri.addQueryValue('recovery', emoji);
        let newUri2 = newUri1.addQueryValue('recovery', emoji);
        let newUri3 = newUri2.addQueryValue('recovery', emoji);
        expect(newUri1.toString()).assertEqual('http://test.com?recovery=%F0%9F%94%83');
        expect(newUri2.toString()).assertEqual('http://test.com?recovery=%F0%9F%94%83&recovery=%F0%9F%94%83');
        expect(newUri3.toString())
          .assertEqual('http://test.com?recovery=%F0%9F%94%83&recovery=%F0%9F%94%83&recovery=%F0%9F%94%83');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_ADDQUERYVALUE_1300
     * @tc.name       : testAddQueryValue0013
     * @tc.desc       : Testing the Uri interface AddQueryValue with input emoji \ud83c\udf41
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAddQueryValue0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testAddQueryValue0013";
      try {
        let emoji = '\ud83c\udf41';
        let baseUri = new uri.URI('http://test.com');
        let newUri1 = baseUri.addQueryValue('maple leaf', emoji);
        let newUri2 = newUri1.addQueryValue('maple leaf', emoji);
        let newUri3 = newUri2.addQueryValue('maple leaf', emoji);
        expect(newUri1.toString()).assertEqual('http://test.com?maple%20leaf=%F0%9F%8D%81');
        expect(newUri2.toString()).assertEqual('http://test.com?maple%20leaf=%F0%9F%8D%81&maple%20leaf=%F0%9F%8D%81');
        expect(newUri3.toString())
          .assertEqual('http://test.com?maple%20leaf=%F0%9F%8D%81&maple%20leaf=%F0%9F%8D%81&maple%20leaf=%F0%9F%8D%81');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_ADDQUERYVALUE_1400
     * @tc.name       : testAddQueryValue0014
     * @tc.desc       : Testing the Uri interface AddQueryValue with input emoji \u2666
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAddQueryValue0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testAddQueryValue0014";
      try {
        let emoji = '\u2666';
        let baseUri = new uri.URI('http://test.com');
        let newUri1 = baseUri.addQueryValue('rhombus', emoji);
        let newUri2 = newUri1.addQueryValue('rhombus', emoji);
        let newUri3 = newUri2.addQueryValue('rhombus', emoji);
        expect(newUri1.toString()).assertEqual('http://test.com?rhombus=%E2%99%A6');
        expect(newUri2.toString()).assertEqual('http://test.com?rhombus=%E2%99%A6&rhombus=%E2%99%A6');
        expect(newUri3.toString()).assertEqual('http://test.com?rhombus=%E2%99%A6&rhombus=%E2%99%A6&rhombus=%E2%99%A6');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_ADDQUERYVALUE_1500
     * @tc.name       : testAddQueryValue0015
     * @tc.desc       : Testing the Uri interface AddQueryValue with input emoji \ud83d\udc48
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAddQueryValue0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testAddQueryValue0015";
      try {
        let emoji = '\ud83d\udc48';
        let baseUri = new uri.URI('http://test.com');
        let newUri1 = baseUri.addQueryValue('prod', emoji);
        let newUri2 = newUri1.addQueryValue('prod', emoji);
        let newUri3 = newUri2.addQueryValue('prod', emoji);
        expect(newUri1.toString()).assertEqual('http://test.com?prod=%F0%9F%91%88');
        expect(newUri2.toString()).assertEqual('http://test.com?prod=%F0%9F%91%88&prod=%F0%9F%91%88');
        expect(newUri3.toString()).assertEqual('http://test.com?prod=%F0%9F%91%88&prod=%F0%9F%91%88&prod=%F0%9F%91%88');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_ADDQUERYVALUE_1600
     * @tc.name       : testAddQueryValue0016
     * @tc.desc       : Testing the Uri interface AddQueryValue with input emoji \ud83e\udd3c\u200d\u2642\ufe0f
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAddQueryValue0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testAddQueryValue0016";
      try {
        let emoji = '\ud83e\udd3c\u200d\u2642\ufe0f';
        let baseUri = new uri.URI('http://test.com');
        let newUri1 = baseUri.addQueryValue('handshake', emoji);
        let newUri2 = newUri1.addQueryValue('handshake', emoji);
        let newUri3 = newUri2.addQueryValue('handshake', emoji);
        expect(newUri1.toString()).assertEqual('http://test.com?handshake=%F0%9F%A4%BC%E2%80%8D%E2%99%82%EF%B8%8F');
        expect(newUri2.toString())
          .assertEqual('http://test.com?handshake=%F0%9F%A4%BC%E2%80%8D%E2%99%82%EF%B8%8F&handshake=%F0%9F%A4%BC%E2%80%8D%E2%99%82%EF%B8%8F');
        expect(newUri3.toString())
          .assertEqual('http://test.com?handshake=%F0%9F%A4%BC%E2%80%8D%E2%99%82%EF%B8%8F&handshake=%F0%9F%A4%BC%E2%80%8D%E2%99%82%EF%B8%8F&handshake=%F0%9F%A4%BC%E2%80%8D%E2%99%82%EF%B8%8F');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_BASE_ADDQUERYVALUE_1700
     * @tc.name: testAddQueryValue0017
     * @tc.desc: Add query parameters for URI
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testAddQueryValue0017', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('https://www.test.com');
      let newRoute = route.addQueryValue("param1", "value1");
      expect(newRoute.getQueryValue("param1")).assertEqual("value1");
      expect(newRoute.toString()).assertEqual("https://www.test.com?param1=value1");
      let clearRoute = newRoute.clearQuery();
      expect(clearRoute.toString()).assertEqual("https://www.test.com");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_BASE_ADDQUERYVALUE_1800
     * @tc.name: testAddQueryValue0018
     * @tc.desc: Add query parameters for URI
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testAddQueryValue0018', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('https://www.test.com');
      let newRoute = route.addQueryValue("param1", "value1").addQueryValue("param2", "value2");
      expect(newRoute.getQueryValue('param1')).assertEqual("value1");
      expect(newRoute.getQueryValue('param2')).assertEqual("value2");
      expect(newRoute.toString()).assertEqual("https://www.test.com?param1=value1&param2=value2");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_BASE_ADDQUERYVALUE_1900
     * @tc.name: testAddQueryValue0019
     * @tc.desc: Add query parameters for URI
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testAddQueryValue0019', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('https://www.test.com');
      let newRoute = route.addQueryValue("param1", "hello world");
      expect(newRoute.toString()).assertEqual("https://www.test.com?param1=hello%20world");
      expect(newRoute.getQueryValue("param1")).assertEqual("hello world");
      let paramNames = newRoute.getQueryNames();
      expect(paramNames.length).assertEqual(1);
      expect(paramNames.values().next().value).assertEqual("param1");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_BASE_ADDQUERYVALUE_2000
     * @tc.name: testAddQueryValue0020
     * @tc.desc: Add query parameters for URI
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testAddQueryValue0020', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('https://www.test.com');
      let newRoute = route.addQueryValue("param1", "value1").addQueryValue("param1", "value2");
      expect(newRoute.toString()).assertEqual("https://www.test.com?param1=value1&param1=value2");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_BASE_ADDQUERYVALUE_2100
     * @tc.name: testAddQueryValue0021
     * @tc.desc: Add query parameters for URI
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testAddQueryValue0021', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('https://www.test.com');
      let newRoute = route.addQueryValue("param1", "value1").addQueryValue("param2", "null");
      expect(newRoute.toString()).assertEqual("https://www.test.com?param1=value1&param2=null");
      let values = newRoute.getQueryValues("param1");
      expect(values[0]).assertEqual("value1");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_BASE_ADDQUERYVALUE_2200
     * @tc.name: testAddQueryValue0022
     * @tc.desc: Add query parameters for URI
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testAddQueryValue0022', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let value = "value";
      let testUri = new uri.URI('https://www.test.com');
      let addQuery = testUri.addQueryValue("param", value);
      expect(addQuery.getQueryValue("param")).assertEqual(value);
      expect(addQuery.getQueryValues("param")[0]).assertEqual(value);
      expect(addQuery.toString()).assertEqual("https://www.test.com?param=value");
      value = "value1";
      let valueChange = testUri.addQueryValue("param", value);
      expect(valueChange.toString()).assertEqual("https://www.test.com?param=value1");
      let newChange = addQuery.addQueryValue("param", value);
      expect(newChange.toString()).assertEqual("https://www.test.com?param=value&param=value1");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_BASE_ADDQUERYVALUE_2300
     * @tc.name: testAddQueryValue0023
     * @tc.desc: Add query parameters for URI
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testAddQueryValue0023', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('https://www.test.com');
      let newRoute = route.addQueryValue("param 1", "value 1");
      expect(newRoute.getQueryValue("param 1")).assertEqual("value 1");
    })
  })
}