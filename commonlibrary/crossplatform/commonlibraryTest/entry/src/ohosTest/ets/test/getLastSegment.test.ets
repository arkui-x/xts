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

export class Utils {
  static async msSleep(count: number): Promise<number> {
    return new Promise<number>((resolve, reject) => {
      setTimeout(() => {
        resolve(0)
      }, count)
    })
  }
}

let str2 =
  '!!%22%22%23%23%24%24%25%25\'\'(())**%2B%2B%2C%2C--..%2F%2F%3A%3A%3B%3B%3C%3C%3D%3D%3E%3E%3F%3F%40%40%5B%5B%5C%5C%5D%5D%5E%5E__%60%60%7B%7B%7C%7C%7D%7D~~';
let str2Decode = '!!""##$$%%\'\'(())**++,,--..//::;;<<==>>??@@[[\\\\]]^^__``{{||}}~~';
let str3 =
  '%21%21%22%22%23%23%24%24%25%25%26%26%27%27%28%28%2A%2A%2B%2B%2C%2C%2D%2D%2E%2E%2F%2F%3A%3A%3B%3B%3C%3C%3D%3D%3E%3E%3F%3F%40%40%5B%5B%5C%5C%5D%5D%5E%5E%5F%5F%60%60%7B%7B%7C%7C%7D%7D%7E%7E';
let str3Decode = '!!""##$$%%&&\'\'((**++,,--..//::;;<<==>>??@@[[\\\\]]^^__``{{||}}~~';

export default function GetLastSegmentTest() {
  describe('GetLastSegmentTest', () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_UTIL_GETLASTSEGMENT_0100
     * @tc.name      : testGetLastSegment0001
     * @tc.desc      : Testing if the last segment of the URI path with special characters is correctly retrieved.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testGetLastSegment0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetLastSegment0001';
      try {
        let uri1 = `https://username:password@host:8080/directory/file/${str2}?key1=value1&key1=value2#qwer=da`;
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.getLastSegment();
        expect(result1).assertEqual(str2Decode);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_UTIL_GETLASTSEGMENT_0200
     * @tc.name      : testGetLastSegment0002
     * @tc.desc      : Testing if the last segment of the URI path with special characters is correctly retrieved.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testGetLastSegment0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetLastSegment0002';
      try {
        let uri1 = `https://username:password@host:8080/directory/file/${str3}?key1=value1&key1=value2#qwer=da`;
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.getLastSegment();
        expect(result1).assertEqual(str3Decode);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_UTIL_GETLASTSEGMENT_0300
     * @tc.name      : testGetLastSegment0003
     * @tc.desc       : Testing the Uri interface GetLastSegment with input emoji \ud83d\ude0a
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetLastSegment0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetLastSegment0003";
      try {
        let temp = "\ud83d\ude0a";
        let uriString = "content://com.test.hello/files/" + temp;
        let uriInstance = new uri.URI(uriString);
        console.log(`+++(${uriInstance.getLastSegment()})`);
        let lastSegment = uriInstance.getLastSegment();
        expect(lastSegment).assertEqual('😊');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_UTIL_GETLASTSEGMENT_0400
     * @tc.name      : testGetLastSegment0004
     * @tc.desc       : Testing the Uri interface GetLastSegment with input emoji \ud83d\udc64
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetLastSegment0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetLastSegment0004";
      try {
        let temp = "\ud83d\udc64";
        let uriInstance = new uri.URI("content://com.test.hello/files/" + temp);
        console.log(`+++(${uriInstance.getLastSegment()})`);
        let lastSegment = uriInstance.getLastSegment();
        expect(lastSegment).assertEqual('👤');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETLASTSEGMENT_0500
     * @tc.name       : testGetLastSegment0005
     * @tc.desc       : Testing the Uri interface GetLastSegment with input emoji \ud83d\udc6b
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetLastSegment0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetLastSegment0005";
      try {
        let temp = "\ud83d\udc6b";
        let uriInstance = new uri.URI("content://com.test.hello/files/" + temp);
        console.log(`+++(${uriInstance.getLastSegment()})`);
        let lastSegment = uriInstance.getLastSegment();
        expect(lastSegment).assertEqual('👫');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETLASTSEGMENT_0600
     * @tc.name       : testGetLastSegment0006
     * @tc.desc       : Testing the Uri interface GetLastSegment with input emoji \u260e
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetLastSegment0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetLastSegment0006";
      try {
        let temp = "\u260e";
        let uriInstance = new uri.URI("content://com.test.hello/test/" + temp);
        console.log(`+++(${uriInstance.getLastSegment()})`);
        let lastSegment = uriInstance.getLastSegment();
        expect(lastSegment).assertEqual('☎');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETLASTSEGMENT_0700
     * @tc.name       : testGetLastSegment0007
     * @tc.desc       : Testing the Uri interface GetLastSegment with input emoji \ud83d\udc79
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetLastSegment0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetLastSegment0007";
      try {
        let temp = "\ud83d\udc79";
        let uriInstance = new uri.URI("content://com.test.hello/test/" + temp);
        console.log(`+++(${uriInstance.getLastSegment()})`);
        let lastSegment = uriInstance.getLastSegment();
        expect(lastSegment).assertEqual('👹');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETLASTSEGMENT_0800
     * @tc.name       : testGetLastSegment0008
     * @tc.desc       : Testing the Uri interface GetLastSegment with input emoji \ud83d\udd5b
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetLastSegment0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetLastSegment0008";
      try {
        let temp = "\ud83d\udd5b";
        let uriString = "content://com.test.hello/test/";
        let uriInstance = new uri.URI(uriString + temp);
        console.log(`+++(${uriInstance.getLastSegment()})`);
        let lastSegment = uriInstance.getLastSegment();
        expect(lastSegment).assertEqual('🕛');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETLASTSEGMENT_0900
     * @tc.name       : testGetLastSegment0009
     * @tc.desc       : Testing the Uri interface GetLastSegment with input emoji \ud83c\udf4f
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetLastSegment0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetLastSegment0009";
      try {
        let temp = "\ud83c\udf4f";
        let uriString = "content://com.test.hello/test/";
        let uriInstance = new uri.URI(uriString + temp);
        console.log(`+++(${uriInstance.getLastSegment()})`);
        let lastSegment = uriInstance.getLastSegment();
        expect(lastSegment).assertEqual('🍏');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETLASTSEGMENT_1000
     * @tc.name       : testGetLastSegment0010
     * @tc.desc       : Testing the Uri interface GetLastSegment with input emoji \ud83d\udd03
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetLastSegment0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetLastSegment0010";
      try {
        let temp = "\ud83d\udd03";
        let uriString = "content://com.test.hello/test/";
        let uriInstance = new uri.URI(uriString + temp);
        console.log(`+++(${uriInstance.getLastSegment()})`);
        let lastSegment = uriInstance.getLastSegment();
        expect(lastSegment).assertEqual('🔃');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETLASTSEGMENT_1100
     * @tc.name       : testGetLastSegment0011
     * @tc.desc       : Testing the Uri interface GetLastSegment with input emoji \ud83c\udf41
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetLastSegment0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetLastSegment0011";
      try {
        let temp = "\ud83c\udf41";
        let uriString = "content://com.test.hello/emoji/";
        let uriInstance = new uri.URI(uriString + temp);
        console.log(`+++(${uriInstance.getLastSegment()})`);
        let lastSegment = uriInstance.getLastSegment();
        expect(lastSegment).assertEqual('🍁');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETLASTSEGMENT_1200
     * @tc.name       : testGetLastSegment0012
     * @tc.desc       : Testing the Uri interface GetLastSegment with input emoji \u2666
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetLastSegment0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetLastSegment0012";
      try {
        let temp = '\u2666';
        let uriString = "content://com.test.hello/test/";
        let uriInstance = new uri.URI(uriString + temp);
        console.log(`+++(${uriInstance.getLastSegment()})`);
        let lastSegment = uriInstance.getLastSegment();
        expect(lastSegment).assertEqual('♦');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETLASTSEGMENT_1300
     * @tc.name       : testGetLastSegment0013
     * @tc.desc       : Testing the Uri interface GetLastSegment with input emoji \ud83d\udc48
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetLastSegment0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetLastSegment0013";
      try {
        let temp = "\ud83d\udc48";
        let uriString = "content://com.test.hello/emoji/" + temp;
        let uriInstance = new uri.URI(uriString);
        console.log(`+++(${uriInstance.getLastSegment()})`);
        let lastSegment = uriInstance.getLastSegment();
        expect(lastSegment).assertEqual('👈');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETLASTSEGMENT_1400
     * @tc.name       : testGetLastSegment0014
     * @tc.desc       : Testing the Uri interface GetLastSegment with input emoji \ud83e\udd3c\u200d\u2642\ufe0f
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetLastSegment0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetLastSegment0014";
      try {
        let temp = "\ud83e\udd3c\u200d\u2642\ufe0f";
        let uriString = "content://com.test.hello/emoji/";
        let uriInstance = new uri.URI(uriString + temp);
        console.log(`+++(${uriInstance.getLastSegment()})`);
        let lastSegment = uriInstance.getLastSegment();
        expect(lastSegment).assertEqual('🤼‍♂️');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_UTIL_GETLASTSEGMENT_1500
     * @tc.name: testGetLastSegment0015
     * @tc.desc: Get the last segment of URI path
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetLastSegment0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('content://com.test.uri/files/image.jpg');
      let lastSegment = route.getLastSegment();
      expect(lastSegment).assertEqual("image.jpg");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_UTIL_GETLASTSEGMENT_1600
     * @tc.name: testGetLastSegment0016
     * @tc.desc: Get the last segment of URI path
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetLastSegment0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('content://com.test.uri/');
      let lastSegment = route.getLastSegment();
      expect(lastSegment).assertEqual("");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_UTIL_GETLASTSEGMENT_1700
     * @tc.name: testGetLastSegment0017
     * @tc.desc: Get the last segment of URI path
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetLastSegment0017', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('content://com.test.uri');
      let lastSegment = route.getLastSegment();
      expect(lastSegment).assertEqual("");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_UTIL_GETLASTSEGMENT_1800
     * @tc.name: testGetLastSegment0018
     * @tc.desc: Get the last segment of URI path
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetLastSegment0018', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('content://com.test.uri/files/');
      let lastSegment = route.getLastSegment();
      expect(lastSegment).assertEqual("files");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_UTIL_GETLASTSEGMENT_1900
     * @tc.name: testGetLastSegment0019
     * @tc.desc: Get the last segment of URI path
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetLastSegment0019', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('content://com.test.uri/files/my%20file.jpg');
      let lastSegment = route.getLastSegment();
      expect(lastSegment).assertEqual("my file.jpg");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_UTIL_GETLASTSEGMENT_2000
     * @tc.name: testGetLastSegment0020
     * @tc.desc: Get the last segment of URI path
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetLastSegment0020', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('content://com.test.uri/files/my+file.jpg');
      let lastSegment = route.getLastSegment();
      expect(lastSegment).assertEqual("my+file.jpg");
    });
  })
}