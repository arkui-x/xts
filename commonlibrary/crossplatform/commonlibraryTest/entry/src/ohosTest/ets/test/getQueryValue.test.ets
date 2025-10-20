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

export class Utils {
  static async msSleep(count: number): Promise<number> {
    return new Promise<number>((resolve, reject) => {
      setTimeout(() => {
        resolve(0)
      }, count)
    })
  }
}

export default function GetQueryValueTest() {
  describe('GetQueryValueTest', () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUE_0100
     * @tc.name      : testGetQueryValue0001
     * @tc.desc       : Testing the Uri interface GetQueryValue with input emoji \ud83d\ude0a
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValue0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValue0001"
      try {
        let uriInstance = new uri.URI("https://www.com?param1=\ud83d\ude0a&param2=value2");
        let uriInstance1 = new uri.URI('https://www.zyy.ss?sa%3D=\ud83d\ude0a');
        expect(uriInstance.getQueryValue("param1")).assertEqual("\ud83d\ude0a")
        expect(uriInstance1.getQueryValue('sa=')).assertEqual("\ud83d\ude0a")
        expect(uriInstance1.getQueryValue('abc')).assertEqual(null)
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`)
        expect().assertFail()
      }
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUE_0200
     * @tc.name      : testGetQueryValue0002
     * @tc.desc       : Testing the Uri interface GetQueryValue with input emoji \ud83d\udc64
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValue0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValue0002";
      try {
        let uriInstance = new uri.URI("https://www.com?param1=\ud83d\udc64&param2=value2");
        let uriInstance1 = new uri.URI('https://www.zyy.ss?sa%3D=\ud83d\udc64');
        expect(uriInstance.getQueryValue("param1")).assertEqual("\ud83d\udc64");
        expect(uriInstance1.getQueryValue('sa=')).assertEqual("\ud83d\udc64");
        expect(uriInstance1.getQueryValue('abc')).assertEqual(null);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUE_0300
     * @tc.name      : testGetQueryValue0003
     * @tc.desc       : Testing the Uri interface GetQueryValue with input emoji \ud83d\udc6b
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValue0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValue0003";
      try {
        let uriInstance = new uri.URI("https://www.com?param1=\ud83d\udc6b&param2=value2");
        let uriInstance1 = new uri.URI('https://www.zyy.ss?sa%3D=\ud83d\udc6b');
        expect(uriInstance.getQueryValue("param1")).assertEqual("\ud83d\udc6b");
        expect(uriInstance1.getQueryValue('sa=')).assertEqual("\ud83d\udc6b");
        expect(uriInstance1.getQueryValue('abc')).assertEqual(null);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUE_0400
     * @tc.name      : testGetQueryValue0004
     * @tc.desc       : Testing the Uri interface GetQueryValue with input emoji \u260e
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValue0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValue0004";
      try {
        let uriInstance = new uri.URI("https://www.com?param1=\u260e&param2=value2");
        let uriInstance1 = new uri.URI('https://www.zyy.ss?sa%3D=\u260e');
        expect(uriInstance.getQueryValue("param1")).assertEqual("\u260e");
        expect(uriInstance1.getQueryValue('sa=')).assertEqual("\u260e");
        expect(uriInstance1.getQueryValue('abc')).assertEqual(null);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUE_0500
     * @tc.name      : testGetQueryValue0005
     * @tc.desc       : Testing the Uri interface GetQueryValue with input emoji \ud83d\udc79
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValue0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValue0005";
      try {
        let uriInstance = new uri.URI("https://www.com?param1=\ud83d\udc79&param2=value2");
        let uriInstance1 = new uri.URI('https://www.zyy.ss?sa%3D=\ud83d\udc79');
        expect(uriInstance.getQueryValue("param1")).assertEqual("\ud83d\udc79");
        expect(uriInstance1.getQueryValue('sa=')).assertEqual("\ud83d\udc79");
        expect(uriInstance1.getQueryValue('abc')).assertEqual(null);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUE_0600
     * @tc.name      : testGetQueryValue0006
     * @tc.desc       : Testing the Uri interface GetQueryValue with input emoji \ud83d\udd5b
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValue0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValue0006";
      try {
        let uriInstance = new uri.URI("https://www.com?param1=\ud83d\udd5b&param2=value2");
        let uriInstance1 = new uri.URI('https://www.zyy.ss?sa%3D=\ud83d\udd5b');
        expect(uriInstance.getQueryValue("param1")).assertEqual("\ud83d\udd5b");
        expect(uriInstance1.getQueryValue('sa=')).assertEqual("\ud83d\udd5b");
        expect(uriInstance1.getQueryValue('abc')).assertEqual(null);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUE_0700
     * @tc.name      : testGetQueryValue0007
     * @tc.desc       : Testing the Uri interface GetQueryValue with input emoji \ud83c\udf4f
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValue0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValue0007";
      try {
        let uriInstance = new uri.URI("https://www.com?param1=\ud83c\udf4f&param2=value2");
        let uriInstance1 = new uri.URI('https://www.zyy.ss?sa%3D=\ud83c\udf4f');
        expect(uriInstance.getQueryValue("param1")).assertEqual("\ud83c\udf4f");
        expect(uriInstance1.getQueryValue('sa=')).assertEqual("\ud83c\udf4f");
        expect(uriInstance1.getQueryValue('abc')).assertEqual(null);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUE_0800
     * @tc.name      : testGetQueryValue0008
     * @tc.desc       : Testing the Uri interface GetQueryValue with input emoji \ud83d\udd03
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValue0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValue0008";
      try {
        let uriInstance = new uri.URI("https://www.com?param1=\ud83d\udd03&param2=value2");
        let uriInstance1 = new uri.URI('https://www.zyy.ss?sa%3D=\ud83d\udd03');
        expect(uriInstance.getQueryValue("param1")).assertEqual("\ud83d\udd03");
        expect(uriInstance1.getQueryValue('sa=')).assertEqual("\ud83d\udd03");
        expect(uriInstance1.getQueryValue('abc')).assertEqual(null);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUE_0900
     * @tc.name      : testGetQueryValue0009
     * @tc.desc       : Testing the Uri interface GetQueryValue with input emoji \ud83c\udf41
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValue0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValue0009";
      try {
        let uriInstance = new uri.URI("https://www.com?param1=\ud83c\udf41&param2=value2");
        let uriInstance1 = new uri.URI('https://www.zyy.ss?sa%3D=\ud83c\udf41');
        expect(uriInstance.getQueryValue("param1")).assertEqual("\ud83c\udf41");
        expect(uriInstance1.getQueryValue('sa=')).assertEqual("\ud83c\udf41");
        expect(uriInstance1.getQueryValue('abc')).assertEqual(null);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUE_1000
     * @tc.name      : testGetQueryValue0010
     * @tc.desc       : Testing the Uri interface GetQueryValue with input emoji '\u2666
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValue0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValue0010";
      try {
        let uriInstance = new uri.URI("https://www.com?param1=\u2666&param2=value2");
        let uriInstance1 = new uri.URI('https://www.zyy.ss?sa%3D=\u2666');
        expect(uriInstance.getQueryValue("param1")).assertEqual("\u2666");
        expect(uriInstance1.getQueryValue('sa=')).assertEqual("\u2666");
        expect(uriInstance1.getQueryValue('abc')).assertEqual(null);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUE_1100
     * @tc.name       : testGetQueryValue0011
     * @tc.desc       : Testing the Uri interface GetQueryValue with input emoji \ud83d\udc48
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValue0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValue0011";
      try {
        let uriInstance = new uri.URI("https://www.com?param1=\ud83d\udc48&param2=value2");
        let uriInstance1 = new uri.URI('https://www.zyy.ss?sa%3D=\ud83d\udc48');
        expect(uriInstance.getQueryValue("param1")).assertEqual("\ud83d\udc48");
        expect(uriInstance1.getQueryValue('sa=')).assertEqual("\ud83d\udc48");
        expect(uriInstance1.getQueryValue('abc')).assertEqual(null);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUE_1200
     * @tc.name       : testGetQueryValue0012
     * @tc.desc       : Testing the Uri interface GetQueryValue with input emoji \ud83e\udd3c\u200d\u2642\ufe0f
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValue0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValue0012";
      try {
        let uriInstance = new uri.URI("https://www.com?param1=\ud83e\udd3c\u200d\u2642\ufe0f&param2=value2");
        let uriInstance1 = new uri.URI('https://www.zyy.ss?sa%3D=\ud83e\udd3c\u200d\u2642\ufe0f');
        expect(uriInstance.getQueryValue("param1")).assertEqual("\ud83e\udd3c\u200d\u2642\ufe0f");
        expect(uriInstance1.getQueryValue('sa=')).assertEqual("\ud83e\udd3c\u200d\u2642\ufe0f");
        expect(uriInstance1.getQueryValue('abc')).assertEqual(null);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUE_1300
     * @tc.name: testGetQueryValue0013
     * @tc.desc: Get specific query parameters from URI
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetQueryValue0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let route = new uri.URI('https://www.test.com?param1=value1&param2=value2');
      let param1Value = route.getQueryValue("param1");
      let param2Value = route.getQueryValue("param2");
      expect(param1Value).assertEqual('value1');
      expect(param2Value).assertEqual('value2');
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUE_1400
     * @tc.name: testGetQueryValue0014
     * @tc.desc: Get specific query parameters from URI
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetQueryValue0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let route = new uri.URI('https://www.test.com');
      expect(route.getQueryValue("param1")).assertEqual(null);
      let include = new uri.URI('https://www.test.com?param1=value1');
      expect(include.getQueryValue("param")).assertEqual(null);
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUE_1500
     * @tc.name: testGetQueryValue0015
     * @tc.desc: Get specific query parameters from URI
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetQueryValue0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let route = new uri.URI('https://www.test.com?param1=hello%20world');
      expect(route.getQueryValue("param1")).assertEqual("hello world");
      let specialSymbol = new uri.URI('https://www.test.com?param1=hello+world');
      expect(specialSymbol.getQueryValue("param1")).assertEqual("hello world");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUE_1600
     * @tc.name: testGetQueryValue0016
     * @tc.desc: Get specific query parameters from URI
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetQueryValue0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let route = new uri.URI('https://www.test.com?param%201=hello');
      expect(route.getQueryValue("param 1")).assertEqual("hello");
      expect(route.getQueryValue("1")).assertEqual(null);
      expect(route.getQueryValue(" 1")).assertEqual(null);
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUE_1700
     * @tc.name: testGetQueryValue0017
     * @tc.desc: Get specific query parameters from URI
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetQueryValue0017', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let route = new uri.URI('https://www.test.com?param1=&param2=');
      expect(route.getQueryValue("param1")).assertEqual("");
      expect(route.getQueryValue("param2")).assertEqual("");
      let noNameUri = new uri.URI('https://www.test.com?=value');
      expect(noNameUri.getQueryValue("")).assertEqual("value");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUE_1800
     * @tc.name: testGetQueryValue0018
     * @tc.desc: Get specific query parameters from URI
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetQueryValue0018', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let emptyParameter1 = new uri.URI('https://www.test.com?param1=value1&&param3=value3');
      expect(emptyParameter1.getQueryValue("")).assertEqual("");
      let emptyParameter12 = new uri.URI('https://www.test.com?param1=value1&');
      expect(emptyParameter12.getQueryValue("")).assertEqual("");
      let router = new uri.URI('https://www.test.com?');
      expect(router.getQueryValue("")).assertEqual(null);
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUE_1900
     * @tc.name: testGetQueryValue0019
     * @tc.desc: Get specific query parameters from URI
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetQueryValue0019', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let route = new uri.URI('https://www.test.com?param1=value1&param1=value2&param1=value3');
      let param1Value = route.getQueryValue("param1");
      expect(param1Value).assertEqual("value1");
      expect(route.getQueryValues("param1")[0]).assertEqual("value1");
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUE_2000
     * @tc.name      : testGetQueryValue0020
     * @tc.desc      : Testing if the correct value is retrieved from a URI's query when the key contains special symbols.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValues0020', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let TAG = 'testGetQueryValues0020';
      try {
        let uri1 = `https://username:password@host:8080/directory/file?key1${str2}=value1#qwer=da`;
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.getQueryValue(`key1${str2Decode}`);
        expect(result1!.toString()).assertEqual('value1');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect(false).assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_2100
     * @tc.name      : testGetQueryValues0021
     * @tc.desc      : Testing if the correct value is retrieved from a URI's query when the key contains special symbols (different case).
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValues0021', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetQueryValues0021';
      try {
        let uri1 = `https://username:password@host:8080/directory/file?key1${str3}=value3#qwer=da`;
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.getQueryValues(`key1${str3Decode}`);
        expect(result1.toString()).assertEqual('value3');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_2200
     * @tc.name      : testGetQueryValues0022
     * @tc.desc      : Testing if the correct value is retrieved from a URI's query when the value contains special symbols.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValues0022', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetQueryValues0022';
      try {
        let uri1 = `https://username:password@host:8080/directory/file?key1=value1${str2}#qwer=da`;
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.getQueryValues(`key1`);
        expect(result1.toString()).assertEqual('value1' + str2Decode);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_2300
     * @tc.name      : testGetQueryValues0023
     * @tc.desc      : Testing if the correct value is retrieved from a URI's query when the value contains special symbols.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValues0023', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetQueryValues0023';
      try {
        let uri1 = `https://username:password@host:8080/directory/file?key1=value3${str3}#qwer=da`;
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.getQueryValues(`key1`);
        expect(result1.toString()).assertEqual('value3' + str3Decode);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_2400
     * @tc.name      : testGetQueryValues0024
     * @tc.desc      : Testing if the correct value is retrieved from a URI's query when the key contains special symbols.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValues0024', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetQueryValues0024';
      try {
        let uri1 = `https://username:password@host:8080/directory/file?key1${str2}=value1&key1${str2}=value2#qwer=da`;
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.getQueryValues(`key1${str2Decode}`);
        expect(result1.constructor.name).assertEqual('Array')
        expect(result1.length).assertEqual(2);
        expect(result1[0]).assertEqual('value1');
        expect(result1[1]).assertEqual('value2');
        expect(result1.toString()).assertEqual('value1,value2');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_2500
     * @tc.name      : testGetQueryValues0025
     * @tc.desc      : Testing if the correct value is retrieved from a URI's query when the key contains special symbols (different case).
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValues0025', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetQueryValues0025';
      try {
        let uri1 = `https://username:password@host:8080/directory/file?key1${str3}=value3&key1${str3}=value4#qwer=da`;
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.getQueryValues(`key1${str3Decode}`);
        expect(result1.constructor.name).assertEqual('Array')
        expect(result1.length).assertEqual(2);
        expect(result1[0]).assertEqual('value3');
        expect(result1[1]).assertEqual('value4');
        expect(result1.toString()).assertEqual('value3,value4');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_2600
     * @tc.name      : testGetQueryValues0026
     * @tc.desc      : Testing if the correct value is retrieved from a URI's query when the value contains special symbols.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValues0026', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetQueryValues0026';
      try {
        let uri1 = `https://username:password@host:8080/directory/file?key1=value1${str2}&key1=value2${str2}#qwer=da`;
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.getQueryValues(`key1`);
        expect(result1.constructor.name).assertEqual('Array')
        expect(result1.length).assertEqual(2);
        expect(result1[0]).assertEqual('value1' + str2Decode);
        expect(result1[1]).assertEqual('value2' + str2Decode);
        expect(result1.toString()).assertEqual(`value1${str2Decode},value2${str2Decode}`);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_2700
     * @tc.name      : testGetQueryValues0027
     * @tc.desc      : Testing if the correct value is retrieved from a URI's query when the value contains special symbols.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValues0027', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetQueryValues0027';
      try {
        let uri1 = `https://username:password@host:8080/directory/file?key1=value3${str3}&key1=value4${str3}#qwer=da`;
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.getQueryValues(`key1`);
        expect(result1.constructor.name).assertEqual('Array')
        expect(result1.length).assertEqual(2);
        expect(result1[0]).assertEqual('value3' + str3Decode);
        expect(result1[1]).assertEqual('value4' + str3Decode);
        expect(result1.toString()).assertEqual(`value3${str3Decode},value4${str3Decode}`);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_2800
     * @tc.name       : testGetQueryValues0028
     * @tc.desc       : Test the function of the interface getQueryValues() with Emoji
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValues0028', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValues0028";
      try {
        let emoji = "\ud83d\ude0a";
        let uriInstance = new uri.URI(`https://www.test.com/search?emoji=${emoji}&emoji=${emoji}`);
        let buf1 = uriInstance.getQueryValues("emoji");
        expect(buf1.toString()).assertEqual("😊,😊");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_2900
     * @tc.name       : testGetQueryValues0029
     * @tc.desc       : Test the function of the interface getQueryValues() with Emoji
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValues0029', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValues0029";
      try {
        let emoji = "\ud83d\udc64";
        let uriInstance = new uri.URI(`https://www.test.com/search?emoji=${emoji}&emoji=${emoji}`);
        let buf1 = uriInstance.getQueryValues("emoji");
        expect(buf1.toString()).assertEqual("👤,👤");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_3000
     * @tc.name       : testGetQueryValues0030
     * @tc.desc       : Test the function of the interface getQueryValues() with Emoji
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValues0030', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValues0030";
      try {
        let emoji = "\ud83d\udc6b";
        let uriInstance = new uri.URI(`https://www.test.com/search?emoji=${emoji}&emoji=${emoji}`);
        let buf1 = uriInstance.getQueryValues("emoji");
        expect(buf1.toString()).assertEqual("👫,👫");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_3100
     * @tc.name       : testGetQueryValues0031
     * @tc.desc       : Test the function of the interface getQueryValues() with Emoji
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValues0031', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValues0031";
      try {
        let emoji = "\u260e";
        let uriInstance = new uri.URI(`https://www.test.com/search?emoji=${emoji}&emoji=${emoji}`);
        let buf1 = uriInstance.getQueryValues("emoji");
        expect(buf1.toString()).assertEqual("☎,☎");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_3200
     * @tc.name       : testGetQueryValues0032
     * @tc.desc       : Test the function of the interface getQueryValues() with Emoji
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValues0032', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValues0032";
      try {
        let emoji = "\ud83d\udc79";
        let uriInstance = new uri.URI(`https://www.test.com/search?emoji=${emoji}&emoji=${emoji}`);
        let buf1 = uriInstance.getQueryValues("emoji");
        expect(buf1.toString()).assertEqual("👹,👹");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_3300
     * @tc.name       : testGetQueryValues0033
     * @tc.desc       : Test the function of the interface getQueryValues() with Emoji
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValues0033', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValues0033";
      try {
        let emoji = "\ud83d\udd5b";
        let uriInstance = new uri.URI(`https://www.test.com/search?emoji=${emoji}&emoji=${emoji}`);
        let buf1 = uriInstance.getQueryValues("emoji");
        expect(buf1.toString()).assertEqual("🕛,🕛");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_3400
     * @tc.name       : testGetQueryValues0034
     * @tc.desc       : Test the function of the interface getQueryValues() with Emoji
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValues0034', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValues0034";
      try {
        let emoji = "\ud83c\udf4f";
        let uriInstance = new uri.URI(`https://www.test.com/search?emoji=${emoji}&emoji=${emoji}`);
        let buf1 = uriInstance.getQueryValues("emoji");
        expect(buf1.toString()).assertEqual("🍏,🍏");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_3500
     * @tc.name       : testGetQueryValues0035
     * @tc.desc       : Test the function of the interface getQueryValues() with Emoji
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValues0035', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValues0035";
      try {
        let emoji = "\ud83d\udd03";
        let uriInstance = new uri.URI(`https://www.test.com/search?emoji=${emoji}&emoji=${emoji}`);
        let buf1 = uriInstance.getQueryValues("emoji");
        expect(buf1.toString()).assertEqual("🔃,🔃");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_3600
     * @tc.name       : testGetQueryValues0036
     * @tc.desc       : Test the function of the interface getQueryValues() with Emoji
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValues0036', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValues0036";
      try {
        let emoji = "\ud83c\udf41";
        let uriInstance = new uri.URI(`https://www.test.com/search?emoji=${emoji}&emoji=${emoji}`);
        let buf1 = uriInstance.getQueryValues("emoji");
        expect(buf1.toString()).assertEqual("🍁,🍁");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_3700
     * @tc.name       : testGetQueryValues0037
     * @tc.desc       : Test the function of the interface getQueryValues() with Emoji
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValues0037', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValues0037";
      try {
        let emoji = "\u2666";
        let uriInstance = new uri.URI(`https://www.test.com/search?emoji=${emoji}&emoji=${emoji}`);
        let buf1 = uriInstance.getQueryValues("emoji");
        expect(buf1.toString()).assertEqual("♦,♦");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_3800
     * @tc.name       : testGetQueryValues0038
     * @tc.desc       : Test the function of the interface getQueryValues() with Emoji
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValues0038', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValues0038";
      try {
        let emoji = "\ud83d\udc48";
        let uriInstance = new uri.URI(`https://www.test.com/search?emoji=${emoji}&emoji=${emoji}`);
        let buf1 = uriInstance.getQueryValues("emoji");
        expect(buf1.toString()).assertEqual("👈,👈");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_3900
     * @tc.name       : testGetQueryValues0039
     * @tc.desc       : Test the function of the interface getQueryValues() with Emoji
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetQueryValues0039', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetQueryValues0039";
      try {
        let emoji = "\ud83e\udd3c\u200d\u2642\ufe0f";
        let uriInstance = new uri.URI(`https://www.test.com/search?emoji=${emoji}&emoji=${emoji}`);
        let buf1 = uriInstance.getQueryValues("emoji");
        expect(buf1.toString()).assertEqual("🤼‍♂️,🤼‍♂️");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_4000
     * @tc.name: testGetQueryValues0040
     * @tc.desc: Get all parameters and their corresponding values in the URI query string
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetQueryValues0040', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let route1 = new uri.URI('https://www.test.com?param_g=value_1');
      let values1 = route1.getQueryValues("param_g");
      expect(values1[0]).assertEqual("value_1");
      expect(route1.getQueryValue('param_g')).assertEqual("value_1");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_4100
     * @tc.name: testGetQueryValues0041
     * @tc.desc: Get all parameters and their corresponding values in the URI query string
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetQueryValues0041', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let route = new uri.URI('https://www.test.com/search?query=name&sort=asc&filter=f');
      let values = route.getQueryValues("query");
      expect(String(values.length)).assertEqual("1");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_4200
     * @tc.name: testGetQueryValues0042
     * @tc.desc: Get all parameters and their corresponding values in the URI query string
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetQueryValues0042', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let route = new uri.URI('https://www.test.com/search?query=name');
      let values = route.getQueryValues("query");
      expect(values[0]).assertEqual("name");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_4300
     * @tc.name: testGetQueryValues0043
     * @tc.desc: Get all parameters and their corresponding values in the URI query string
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetQueryValues0043', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let emptyParameter1 = new uri.URI('https://www.test.com/search?query=');
      let result1 = emptyParameter1.getQueryValues("query");
      expect(String(result1.length)).assertEqual("1");
      expect(result1[0]).assertEqual("");
      let emptyParameter2 = new uri.URI('https://www.test.com/search?=value&');
      let result2 = emptyParameter2.getQueryValues("");
      expect(result2[0]).assertEqual("value");
      expect(result2[1]).assertEqual("");
      let emptyParameter3 = new uri.URI('https://www.test.com?');
      let result3 = emptyParameter3.getQueryValues("");
      expect(String(result3.length)).assertEqual("0");
      let emptyParameter4 = new uri.URI('https://www.test.com?param');
      let result4 = emptyParameter4.getQueryValues("param");
      expect(String(result4.length)).assertEqual("1");
      expect(result4[0]).assertEqual("");
      let emptyParameter5 = new uri.URI('https://www.test.com?param1=value1&&param3=value3');
      let result5 = emptyParameter5.getQueryValues("");
      expect(result5[0]).assertEqual("");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_4400
     * @tc.name: testGetQueryValues0044
     * @tc.desc: Get all parameters and their corresponding values in the URI query string
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetQueryValues0044', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let route = new uri.URI('https://www.test.com/search');
      let values = route.getQueryValues("query");
      expect(String(values.length)).assertEqual("0");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_4500
     * @tc.name: testGetQueryValues0045
     * @tc.desc: Get all parameters and their corresponding values in the URI query string
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetQueryValues0045', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let route = new uri.URI('https://www.test.com/search?query=my%20query');
      let values = route.getQueryValues("query");
      expect(values[0]).assertEqual("my query");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_4600
     * @tc.name: testGetQueryValues0046
     * @tc.desc: Get all parameters and their corresponding values in the URI query string
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetQueryValues0046', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let route = new uri.URI('https://www.test.com/search?query=name&query=my');
      let values = route.getQueryValues("query");
      expect(values[0]).assertEqual("name");
      expect(values[1]).assertEqual("my");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_BASE_GETQUERYVALUES_4700
     * @tc.name: testGetQueryValues0047
     * @tc.desc: Get all parameters and their corresponding values in the URI query string
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetQueryValues0047', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let route = new uri.URI('https://www.test.com?query=hello+world');
      let values = route.getQueryValues("query");
      expect(values[0]).assertEqual("hello+world");
    });
  })
}