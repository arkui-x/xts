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
import { taskpool, uri } from '@kit.ArkTS';

let str2 =
  '!!%22%22%23%23%24%24%25%25\'\'(())**%2B%2B%2C%2C--..%2F%2F%3A%3A%3B%3B%3C%3C%3D%3D%3E%3E%3F%3F%40%40%5B%5B%5C%5C%5D%5D%5E%5E__%60%60%7B%7B%7C%7C%7D%7D~~';
let str2Decode = '!!""##$$%%\'\'(())**++,,--..//::;;<<==>>??@@[[\\\\]]^^__``{{||}}~~';
let str3 =
  '%21%21%22%22%23%23%24%24%25%25%26%26%27%27%28%28%2A%2A%2B%2B%2C%2C%2D%2D%2E%2E%2F%2F%3A%3A%3B%3B%3C%3C%3D%3D%3E%3E%3F%3F%40%40%5B%5B%5C%5C%5D%5D%5E%5E%5F%5F%60%60%7B%7B%7C%7C%7D%7D%7E%7E';
let str3Decode = '!!""##$$%%&&\'\'((**++,,--..//::;;<<==>>??@@[[\\\\]]^^__``{{||}}~~';
let concurrentNum = 100

@Concurrent
export function testUriCreateFromParts() {
  let caseName = 'testCreateFromPartsSpecialSymbolsScheme0002';
  try {
    console.log(`${caseName} test start`);
    let uriInstance = uri.URI.createFromParts('mailto-+.test0002', 'no body', 'top');
    let result1 = uriInstance.toString();
    let expected = 'mailto-+.test0002:no%20body#top';
    if (result1 !== expected) {
      throw new Error(`${caseName} createFromParts result mismatch`);
    }
    console.log(`${caseName} test end`);
  } catch (err) {
    console.error(`${caseName} failed: ${err.message}`);
    throw new Error(`${caseName} catch error.`);
  }
}

export default function CreateFromPartsTest() {
  describe('CreateFromPartsTest', () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_URI_CREATEFROMPARTS_0100
     * @tc.name      : testCreateFromParts0001
     * @tc.desc      : Testing if a URI instance is correctly created from parts with invalid special symbols in the scheme.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testCreateFromParts0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testCreateFromParts0001';
      try {
        let uriInstance = uri.URI.createFromParts("mailto" + str2, "no body", "top");
        uriInstance.toString();
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect(err.code).assertEqual(10200002)
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_CREATEFROMPARTS_0200
     * @tc.name      : testCreateFromParts0002
     * @tc.desc      : Testing if a URI instance is correctly created from parts with valid special symbols in the scheme.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testCreateFromParts0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testCreateFromParts0002';
      try {
        let uriInstance = uri.URI.createFromParts("mailto-+.test0002", "no body", "top");
        let result1 = uriInstance.toString();
        expect(result1).assertEqual("mailto-+.test0002:no%20body#top");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_CREATEFROMPARTS_0300
     * @tc.name      : testCreateFromParts0003
     * @tc.desc      : Testing if a URI instance is correctly created from parts with special symbols in the ssp.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testCreateFromParts0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testCreateFromParts0003';
      try {
        let uriInstance = uri.URI.createFromParts("mailto", "no body" + str2, "top");
        let result1 = uriInstance.toString();
        expect(result1).assertEqual("mailto:no%20body" + '!!%2522%2522%2523%2523%2524%2524%2525%2525\'\'(())**%252B' +
          '%252B%252C%252C--..%252F%252F%253A%253A%253B%253B%253C%253C%253D%253D%253E%253E%253F%253F%2540' +
          '%2540%255B%255B%255C%255C%255D%255D%255E%255E__%2560%2560%257B%257B%257C%257C%257D%257D~~' + "#top");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_CREATEFROMPARTS_0400
     * @tc.name      : testCreateFromParts0004
     * @tc.desc      : Testing if a URI instance is correctly created from parts with special symbols in the ssp.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testCreateFromParts0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testCreateFromParts0004';
      try {
        let uriInstance = uri.URI.createFromParts("mailto", "no body" + str3, "top");
        let result1 = uriInstance.toString();
        expect(result1).assertEqual("mailto:no%20body" + '%2521%2521%2522%2522%2523%2523%2524%2524%2525%2525' +
          '%2526%2526%2527%2527%2528%2528%252A%252A%252B%252B%252C%252C%252D%252D%252E%252E%252F%252F%253A' +
          '%253A%253B%253B%253C%253C%253D%253D%253E%253E%253F%253F%2540%2540%255B%255B%255C%255C%255D%255D' +
          '%255E%255E%255F%255F%2560%2560%257B%257B%257C%257C%257D%257D%257E%257E' + "#top");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_CREATEFROMPARTS_0500
     * @tc.name      : testCreateFromParts0005
     * @tc.desc      : Testing if a URI instance is correctly created from parts with special symbols in the ssp.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testCreateFromParts0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testCreateFromParts0005';
      try {
        let uriInstance = uri.URI.createFromParts("mailto", "no body", "top" + str2);
        let result1 = uriInstance.toString();
        expect(result1)
          .assertEqual("mailto:no%20body" + "#top" + '!!%2522%2522%2523%2523%2524%2524%2525%2525\'\'(())**%252B' +
            '%252B%252C%252C--..%252F%252F%253A%253A%253B%253B%253C%253C%253D%253D%253E%253E%253F%253F%2540' +
            '%2540%255B%255B%255C%255C%255D%255D%255E%255E__%2560%2560%257B%257B%257C%257C%257D%257D~~');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_CREATEFROMPARTS_0600
     * @tc.name      : testCreateFromParts0006
     * @tc.desc      : Testing if a URI instance is correctly created from parts with special symbols in the ssp.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testCreateFromParts0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testCreateFromParts0006';
      try {
        let uriInstance = uri.URI.createFromParts("mailto", "no body", "top" + str3);
        let result1 = uriInstance.toString();
        expect(result1).assertEqual("mailto:no%20body" + "#top" + '%2521%2521%2522%2522%2523%2523%2524%2524%2525%2525' +
          '%2526%2526%2527%2527%2528%2528%252A%252A%252B%252B%252C%252C%252D%252D%252E%252E%252F%252F%253A' +
          '%253A%253B%253B%253C%253C%253D%253D%253E%253E%253F%253F%2540%2540%255B%255B%255C%255C%255D%255D' +
          '%255E%255E%255F%255F%2560%2560%257B%257B%257C%257C%257D%257D%257E%257E');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_CREATEFROMPARTS_0700
     * @tc.name       : testCreateFromParts0007
     * @tc.desc       : Testing the Uri interface CreateFromParts with input emoji \ud83d\ude0a
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testCreateFromParts0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testCreateFromParts0007";
      try {
        let uriInstance = uri.URI.createFromParts("mailto", "no body", "\ud83d\ude0a");
        console.info(uriInstance.toString());
        console.log(`+++(${uriInstance.toString()})`);
        let CreateFrom = uriInstance.toString();
        expect(CreateFrom).assertEqual('mailto:no%20body#%F0%9F%98%8A');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_CREATEFROMPARTS_0800
     * @tc.name       : testCreateFromParts0008
     * @tc.desc       : Testing the Uri interface CreateFromParts with input emoji \ud83d\udc64
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testCreateFromParts0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testCreateFromParts0008";
      try {
        let uriInstance = uri.URI.createFromParts("mailto", "no body", "\ud83d\udc64");
        console.info(uriInstance.toString());
        console.log(`+++(${uriInstance.toString()})`);
        let CreateFrom = uriInstance.toString();
        expect(CreateFrom).assertEqual('mailto:no%20body#%F0%9F%91%A4');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_CREATEFROMPARTS_0900
     * @tc.name       : testCreateFromParts0009
     * @tc.desc       : Testing the Uri interface CreateFromParts with input emoji \ud83d\udc6b
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testCreateFromParts0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testCreateFromParts0009";
      try {
        let uriInstance = uri.URI.createFromParts("mailto", "no body", "\ud83d\udc6b");
        console.info(uriInstance.toString());
        console.log(`+++(${uriInstance.toString()})`);
        let CreateFrom = uriInstance.toString();
        expect(CreateFrom).assertEqual('mailto:no%20body#%F0%9F%91%AB');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_CREATEFROMPARTS_1000
     * @tc.name       : testCreateFromParts0010
     * @tc.desc       : Testing the Uri interface CreateFromParts with input emoji \u260e
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testCreateFromParts0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testCreateFromParts0010";
      try {
        let uriInstance = uri.URI.createFromParts("mailto", "no body", "\u260e");
        console.info(uriInstance.toString());
        console.log(`+++(${uriInstance.toString()})`);
        let CreateFrom = uriInstance.toString();
        expect(CreateFrom).assertEqual('mailto:no%20body#%E2%98%8E');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_CREATEFROMPARTS_1100
     * @tc.name       : testCreateFromParts0011
     * @tc.desc       : Testing the Uri interface CreateFromParts with input emoji \ud83d\udc79
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testCreateFromParts0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testCreateFromParts0011";
      try {
        let uriInstance = uri.URI.createFromParts("mailto", "no body", "\ud83d\udc79");
        console.info(uriInstance.toString());
        console.log(`+++(${uriInstance.toString()})`);
        let CreateFrom = uriInstance.toString();
        expect(CreateFrom).assertEqual('mailto:no%20body#%F0%9F%91%B9');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_CREATEFROMPARTS_1200
     * @tc.name       : testCreateFromParts0012
     * @tc.desc       : Testing the Uri interface CreateFromParts with input emoji \ud83d\udd5b
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testCreateFromParts0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testCreateFromParts0012";
      try {
        let uriInstance = uri.URI.createFromParts("mailto", "no body", "\ud83d\udd5b");
        console.info(uriInstance.toString());
        console.log(`+++(${uriInstance.toString()})`);
        let CreateFrom = uriInstance.toString();
        expect(CreateFrom).assertEqual('mailto:no%20body#%F0%9F%95%9B');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_CREATEFROMPARTS_1300
     * @tc.name       : testCreateFromParts0013
     * @tc.desc       : Testing the Uri interface CreateFromParts with input emoji \ud83c\udf4f
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testCreateFromParts0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testCreateFromParts0013";
      try {
        let uriInstance = uri.URI.createFromParts("mailto", "no body", "\ud83c\udf4f");
        console.info(uriInstance.toString());
        console.log(`+++(${uriInstance.toString()})`);
        let CreateFrom = uriInstance.toString();
        expect(CreateFrom).assertEqual('mailto:no%20body#%F0%9F%8D%8F');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_CREATEFROMPARTS_1400
     * @tc.name       : testCreateFromParts0014
     * @tc.desc       : Testing the Uri interface CreateFromParts with input emoji \ud83d\udd03
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testCreateFromParts0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testCreateFromParts0014";
      try {
        let uriInstance = uri.URI.createFromParts("mailto", "no body", "\ud83d\udd03");
        console.info(uriInstance.toString());
        console.log(`+++(${uriInstance.toString()})`);
        let CreateFrom = uriInstance.toString();
        expect(CreateFrom).assertEqual('mailto:no%20body#%F0%9F%94%83');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_CREATEFROMPARTS_1500
     * @tc.name       : testCreateFromParts0015
     * @tc.desc       : Testing the Uri interface CreateFromParts with input emoji \ud83c\udf41
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testCreateFromParts0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testCreateFromParts0015";
      try {
        let uriInstance = uri.URI.createFromParts("mailto", "no body", "\ud83c\udf41");
        console.info(uriInstance.toString());
        console.log(`+++(${uriInstance.toString()})`);
        let CreateFrom = uriInstance.toString();
        expect(CreateFrom).assertEqual('mailto:no%20body#%F0%9F%8D%81');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_CREATEFROMPARTS_1600
     * @tc.name       : testCreateFromParts0016
     * @tc.desc       : Testing the Uri interface CreateFromParts with input emoji \u2666
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testCreateFromParts0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testCreateFromParts0016";
      try {
        let uriInstance = uri.URI.createFromParts("mailto", "no body", "\u2666");
        console.info(uriInstance.toString());
        console.log(`+++(${uriInstance.toString()})`);
        let CreateFrom = uriInstance.toString();
        expect(CreateFrom).assertEqual('mailto:no%20body#%E2%99%A6');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_CREATEFROMPARTS_1700
     * @tc.name       : testCreateFromParts0017
     * @tc.desc       : Testing the Uri interface CreateFromParts with input emoji \ud83d\udc48
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testCreateFromParts0017', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testCreateFromParts0017";
      try {
        let uriInstance = uri.URI.createFromParts("mailto", "no body", "\ud83d\udc48");
        console.info(uriInstance.toString());
        console.log(`+++(${uriInstance.toString()})`);
        let CreateFrom = uriInstance.toString();
        expect(CreateFrom).assertEqual('mailto:no%20body#%F0%9F%91%88');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_URI_CREATEFROMPARTS_1800
     * @tc.name       : testCreateFromParts0018
     * @tc.desc       : Testing the Uri interface CreateFromParts with input emoji \ud83e\udd3c\u200d\u2642\ufe0f
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testCreateFromParts0018', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testCreateFromParts0018";
      try {
        let uriInstance = uri.URI.createFromParts("mailto", "no body", "\ud83e\udd3c\u200d\u2642\ufe0f");
        console.info(uriInstance.toString());
        console.log(`+++(${uriInstance.toString()})`);
        let CreateFrom = uriInstance.toString();
        expect(CreateFrom).assertEqual('mailto:no%20body#%F0%9F%A4%BC%E2%80%8D%E2%99%82%EF%B8%8F');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number    :SUB_COMMONLIBRARY_URI_CREATEFROMPARTS_1900
     * @tc.name      : testCreateFromParts0019
     * @tc.desc      : Testing concurrent URI creation via TaskGroup
     * @tc.size      : SmallTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testCreateFromParts0019', TestType.FUNCTION | Size.SMALLTEST | Level.LEVEL0,
      async (done: () => void): Promise<void> => {
        let caseName = 'testCreateFromParts0019';
        console.info(`${caseName} test start`);
        let result = 0
        try {
          let group = new taskpool.TaskGroup(caseName)
          for (let i = 0; i < concurrentNum; i++) {
            group.addTask(testUriCreateFromParts)
          }
          await taskpool.execute(group).then((res) => {
            console.info(`${caseName} Task execution success`);
            result = res.length
          }).catch((e: Error) => {
            console.info(`${caseName} Task execution catch: ${e.message}`);
            expect().assertFail()
          })
          expect(result).assertEqual(concurrentNum)
        } catch (e) {
          console.info(`${caseName} Task execution failed with error: ${e.message}, code: ${e.code}`);
          expect().assertFail()
        }
        console.info(`${caseName} test end`);
        done();
      });
    // Check the UriCreateFromParts.
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_CREATEFROMPARTS_2000
     * @tc.name: testCreateFromParts0020
     * @tc.desc: Build a new URI object
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testCreateFromParts0020', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = uri.URI.createFromParts("http", "", "fragment");
      expect(route.toString()).assertEqual("http:#fragment");
    })
    
    // Check the UriCreateFromParts.
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_CREATEFROMPARTS_2100
     * @tc.name: testCreateFromParts0021
     * @tc.desc: Build a new URI object
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testCreateFromParts0021', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = uri.URI.createFromParts("mailto", "no body", "top");
      expect(route.toString()).assertEqual("mailto:no%20body#top");
    })
    
    // Check the UriCreateFromParts.
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_CREATEFROMPARTS_2200
     * @tc.name: testCreateFromParts0022
     * @tc.desc: Build a new URI object
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testCreateFromParts0022', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = uri.URI.createFromParts("foo", "", "");
      expect(route.toString()).assertEqual("foo:");
      try {
        uri.URI.createFromParts("", "", "");
      } catch (err) {
        expect(err.toString())
          .assertEqual("BusinessError: Syntax Error. Invalid Uri string: The Scheme the first character must be a letter");
        expect(err.code).assertEqual(10200002);
        expect(err.message)
          .assertEqual("Syntax Error. Invalid Uri string: The Scheme the first character must be a letter");
      }
      try {
        uri.URI.createFromParts(null, null, null);
      } catch (err) {
        expect(err.toString()).assertEqual("BusinessError: Parameter error. The type of null must be string");
        expect(err.code).assertEqual(401);
        expect(err.message).assertEqual("Parameter error. The type of null must be string");
      }
      try {
        uri.URI.createFromParts("foo", null, "fragment");
      } catch (err) {
        expect(err.toString()).assertEqual("BusinessError: Parameter error. The type of null must be string");
        expect(err.code).assertEqual(401);
        expect(err.message).assertEqual("Parameter error. The type of null must be string");
      }
    })
    
    // Check the UriCreateFromParts.
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_CREATEFROMPARTS_2300
     * @tc.name: testCreateFromParts0023
     * @tc.desc: Build a new URI object
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testCreateFromParts0023', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let scheme = "https";
      let ssp = "www.test.com";
      let fragment = "fragment";
      let route = uri.URI.createFromParts(scheme, ssp, fragment);
      expect(route.toString()).assertEqual("https:www.test.com#fragment");
    })
  })
}