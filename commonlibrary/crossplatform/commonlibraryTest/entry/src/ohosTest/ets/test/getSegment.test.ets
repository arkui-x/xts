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

function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

let str2 =
  '!!%22%22%23%23%24%24%25%25\'\'(())**%2B%2B%2C%2C--..%2F%2F%3A%3A%3B%3B%3C%3C%3D%3D%3E%3E%3F%3F%40%40%5B%5B%5C%5C%5D%5D%5E%5E__%60%60%7B%7B%7C%7C%7D%7D~~';
let str2Decode = '!!""##$$%%\'\'(())**++,,--..//::;;<<==>>??@@[[\\\\]]^^__``{{||}}~~';
let str3 =
  '%21%21%22%22%23%23%24%24%25%25%26%26%27%27%28%28%2A%2A%2B%2B%2C%2C%2D%2D%2E%2E%2F%2F%3A%3A%3B%3B%3C%3C%3D%3D%3E%3E%3F%3F%40%40%5B%5B%5C%5C%5D%5D%5E%5E%5F%5F%60%60%7B%7B%7C%7C%7D%7D%7E%7E';
let str3Decode = '!!""##$$%%&&\'\'((**++,,--..//::;;<<==>>??@@[[\\\\]]^^__``{{||}}~~';

export default function GetSegmentTest() {
  describe('GetSegmentTest', () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_UTIL_GETSEGMENT_0100
     * @tc.name      : testGetSegment0001
     * @tc.desc      : Testing if a specific segment of the URI path with special characters is correctly retrieved.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testGetSegment0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetSegment0001';
      try {
        let uri1 = `https://username:password@host:8080/directory/file/${str2}?key1=value1&key1=value2#qwer=da`;
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.getSegment();
        expect(result1[0]).assertEqual('directory');
        expect(result1[1]).assertEqual('file');
        expect(result1[2]).assertEqual(str2Decode);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_UTIL_GETSEGMENT_0200
     * @tc.name      : testGetSegment0002
     * @tc.desc      : Testing if a specific segment of the URI path with special characters is correctly retrieved.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testGetSegment0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testGetSegment0002';
      try {
        let uri1 = `https://username:password@host:8080/directory/file/${str3}?key1=value1&key1=value2#qwer=da`;
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.getSegment();
        expect(result1[0]).assertEqual('directory');
        expect(result1[1]).assertEqual('file');
        expect(result1[2]).assertEqual(str3Decode);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    })
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETSEGMENT_0300
     * @tc.name       : testGetSegment0003
     * @tc.desc       : Testing the Uri interface GetSegment with input emoji \ud83d\ude0a
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetSegment0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetSegment0003";
      try {
        let uriInstance = new uri.URI("http://www.test.com/path/to/\ud83d\ude0a");
        console.info(uriInstance.getSegment().toString()); // path,to,image.jpg
        console.log(`+++(${uriInstance.getSegment().toString()})`);
        let EverySegment = uriInstance.getSegment().toString();
        expect(EverySegment).assertEqual('path,to,😊');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETSEGMENT_0400
     * @tc.name       : testGetSegment0004
     * @tc.desc       : Testing the Uri interface GetSegment with input emoji \ud83d\udc64
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetSegment0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetSegment0004";
      try {
        let uriInstance = new uri.URI("http://www.test.com/path/to/\ud83d\udc64");
        console.info(uriInstance.getSegment().toString()); // path,to,image.jpg
        console.log(`+++(${uriInstance.getSegment().toString()})`);
        let EverySegment = uriInstance.getSegment().toString();
        expect(EverySegment).assertEqual('path,to,👤');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETSEGMENT_0500
     * @tc.name       : testGetSegment0005
     * @tc.desc       : Testing the Uri interface GetSegment with input emoji \ud83d\udc6b
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetSegment0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetSegment0005";
      try {
        let uriInstance = new uri.URI("http://www.test.com/path/to/\ud83d\udc6b");
        console.info(uriInstance.getSegment().toString()); // path,to,image.jpg
        console.log(`+++(${uriInstance.getSegment().toString()})`);
        let EverySegment = uriInstance.getSegment().toString();
        expect(EverySegment).assertEqual('path,to,👫');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETSEGMENT_0600
     * @tc.name       : testGetSegment0006
     * @tc.desc       : Testing the Uri interface GetSegment with input emoji \u260e
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetSegment0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetSegment0006";
      try {
        let uriInstance = new uri.URI("http://www.test.com/path/to/\u260e");
        console.info(uriInstance.getSegment().toString());
        console.log(`+++(${uriInstance.getSegment().toString()})`);
        let EverySegment = uriInstance.getSegment().toString();
        expect(EverySegment).assertEqual('path,to,☎');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETSEGMENT_0700
     * @tc.name       : testGetSegment0007
     * @tc.desc       : Testing the Uri interface GetSegment with input emoji \ud83d\udc79
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetSegment0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetSegment0007";
      try {
        let uriInstance = new uri.URI("http://www.test.com/path/to/\ud83d\udc79");
        console.info(uriInstance.getSegment().toString());
        console.log(`+++(${uriInstance.getSegment().toString()})`);
        let EverySegment = uriInstance.getSegment().toString();
        expect(EverySegment).assertEqual('path,to,👹');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETSEGMENT_0800
     * @tc.name       : testGetSegment0008
     * @tc.desc       : Testing the Uri interface GetSegment with input emoji \ud83d\udd5b
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetSegment0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetSegment0008";
      try {
        let uriInstance = new uri.URI("http://www.test.com/path/to/\ud83d\udd5b");
        console.info(uriInstance.getSegment().toString());
        console.log(`+++(${uriInstance.getSegment().toString()})`);
        let EverySegment = uriInstance.getSegment().toString();
        expect(EverySegment).assertEqual('path,to,🕛');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETSEGMENT_0900
     * @tc.name       : testGetSegment0009
     * @tc.desc       : Testing the Uri interface GetSegment with input emoji \ud83c\udf4f
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetSegment0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetSegment0009";
      try {
        let uriInstance = new uri.URI("http://www.test.com/path/to/\ud83c\udf4f");
        console.info(uriInstance.getSegment().toString()); // path,to,image.jpg
        console.log(`+++(${uriInstance.getSegment().toString()})`);
        let EverySegment = uriInstance.getSegment().toString();
        expect(EverySegment).assertEqual('path,to,🍏');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETSEGMENT_1000
     * @tc.name       : testGetSegment0010
     * @tc.desc       : Testing the Uri interface GetSegment with input emoji \ud83d\udd03
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetSegment0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetSegment0010";
      try {
        let uriInstance = new uri.URI("http://www.test.com/path/to/\ud83d\udd03");
        console.info(uriInstance.getSegment().toString());
        console.log(`+++(${uriInstance.getSegment().toString()})`);
        let EverySegment = uriInstance.getSegment().toString();
        expect(EverySegment).assertEqual('path,to,🔃');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETSEGMENT_1100
     * @tc.name       : testGetSegment0011
     * @tc.desc       : Testing the Uri interface GetSegment with input emoji \ud83c\udf41
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetSegment0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetSegment0011";
      try {
        let uriInstance = new uri.URI("http://www.test.com/path/to/\ud83c\udf41");
        console.info(uriInstance.getSegment().toString()); // path,to,image.jpg
        console.log(`+++(${uriInstance.getSegment().toString()})`);
        let EverySegment = uriInstance.getSegment().toString();
        expect(EverySegment).assertEqual('path,to,🍁');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETSEGMENT_1200
     * @tc.name       : testGetSegment0012
     * @tc.desc       : Testing the Uri interface GetSegment with input emoji \u2666
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetSegment0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetSegment0012";
      try {
        let uriInstance = new uri.URI("http://www.test.com/path/to/\u2666");
        console.info(uriInstance.getSegment().toString()); // path,to,image.jpg
        console.log(`+++(${uriInstance.getSegment().toString()})`);
        let EverySegment = uriInstance.getSegment().toString();
        expect(EverySegment).assertEqual('path,to,♦');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETSEGMENT_1300
     * @tc.name       : testGetSegment0013
     * @tc.desc       : Testing the Uri interface GetSegment with input emoji \ud83d\udc48
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetSegment0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetSegment0013";
      try {
        let uriInstance = new uri.URI("http://www.test.com/path/to/\ud83d\udc48");
        console.info(uriInstance.getSegment().toString()); // path,to,image.jpg
        console.log(`+++(${uriInstance.getSegment().toString()})`);
        let EverySegment = uriInstance.getSegment().toString();
        expect(EverySegment).assertEqual('path,to,👈');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_GETSEGMENT_1400
     * @tc.name       : testGetSegment0014
     * @tc.desc       : Testing the Uri interface GetSegment with input emoji \ud83e\udd3c\u200d\u2642\ufe0f
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testGetSegment0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testGetSegment0014";
      try {
        let uriInstance = new uri.URI("http://www.test.com/path/to/\ud83e\udd3c\u200d\u2642\ufe0f");
        console.info(uriInstance.getSegment().toString()); // path,to,image.jpg
        console.log(`+++(${uriInstance.getSegment().toString()})`);
        let EverySegment = uriInstance.getSegment().toString();
        expect(EverySegment).assertEqual('path,to,🤼‍♂️');
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_UTIL_GETSEGMENT_1500
     * @tc.name: testGetSegment0015
     * @tc.desc: Get all segments in the URI path
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetSegment0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      try {
        let route = new uri.URI('content://com.test.uri/files/a a');
        let segments = route.getSegment();
      } catch (err) {
        expect(err.toString()).assertEqual("BusinessError: Syntax Error. Invalid Uri string");
        expect(err.code).assertEqual(10200002);
        expect(err.message).assertEqual("Syntax Error. Invalid Uri string");
      }
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_UTIL_GETSEGMENT_1600
     * @tc.name: testGetSegment0016
     * @tc.desc: Get all segments in the URI path
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetSegment0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('content://com.test.uri/files/images');
      let segments = route.getSegment();
      expect(segments.length).assertEqual(2);
      expect(segments[0]).assertEqual("files");
      expect(segments[1]).assertEqual("images");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_UTIL_GETSEGMENT_1700
     * @tc.name: testGetSegment0017
     * @tc.desc: Get all segments in the URI path
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetSegment0017', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('content://com.test.uri/');
      let segments = route.getSegment();
      expect(segments.length).assertEqual(0);
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_UTIL_GETSEGMENT_1800
     * @tc.name: testGetSegment0018
     * @tc.desc: Get all segments in the URI path
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetSegment0018', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('content://com.test.uri/files/');
      let segments = route.getSegment();
      expect(segments.length).assertEqual(1);
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_UTIL_GETSEGMENT_1900
     * @tc.name: testGetSegment0019
     * @tc.desc: Get all segments in the URI path
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetSegment0019', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('content://com.test.uri');
      let segments = route.getSegment();
      expect(segments.length).assertEqual(0);
      let mailRoute = new uri.URI('mailto:people');
      expect(mailRoute.getSegment().length).assertEqual(0);
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_UTIL_GETSEGMENT_2000
     * @tc.name: testGetSegment0020
     * @tc.desc: Get all segments in the URI path
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetSegment0020', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('content://com.test.uri/files/a%20a/b%20b');
      let segments = route.getSegment();
      expect(segments[0]).assertEqual("files");
      expect(segments[1]).assertEqual("a a");
      expect(segments[2]).assertEqual("b b");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_UTIL_GETSEGMENT_2100
     * @tc.name: testGetSegment0021
     * @tc.desc: Get all segments in the URI path
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testGetSegment0021', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('http://www.test.com/path/to/image.jpg');
      let segments = route.getSegment();
      expect(segments[2]).assertEqual("image.jpg");
    });
  })
}