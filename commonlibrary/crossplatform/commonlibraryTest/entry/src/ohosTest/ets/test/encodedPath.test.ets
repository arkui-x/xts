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

export default function EncodedPathTest() {
  describe('EncodedPathTest', () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDPATH_0100
     * @tc.name      : testEncodedPath0001
     * @tc.desc      : Testing if the correct encoded path is retrieved from a URI with leading slashes.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedPath0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedPath0001';
      try {
        let Uri = "https://username:my+name@host:8080///directory/my+file?foo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedPath).assertEqual("///directory/my+file");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDPATH_0200
     * @tc.name      : testEncodedPath0002
     * @tc.desc      : Testing if the correct encoded path is retrieved from a URI with multiple slashes.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedPath0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedPath0002';
      try {
        let Uri = "https://username:my+name@host:8080/directory///my+file?foo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedPath).assertEqual("/directory///my+file");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDPATH_0300
     * @tc.name      : testEncodedPath0003
     * @tc.desc      : Testing if the correct encoded path is retrieved from a URI with complex path segments.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedPath0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedPath0003';
      try {
        let Uri = "https://username:my+name@host:8080/direct/ory/my+/file/?/?foo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedPath).assertEqual("/direct/ory/my+/file/");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDPATH_0400
     * @tc.name      : testEncodedPath0004
     * @tc.desc      : Testing if a Syntax Error is returned for a URI with percent encoding in the path.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedPath0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedPath0004';
      try {
        let Uri = "https://username:my+name@host:8080%2Fdirectory%2Fmy+file?foo=1&bar=2#fragment";
        new uri.URI(Uri);
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect(err.code).assertEqual(10200002);
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDPATH_0500
     * @tc.name      : testEncodedPath0005
     * @tc.desc      : Testing if the correct encoded path is retrieved from a URI with encoded characters in path.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedPath0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedPath0005';
      try {
        let Uri = "https://username:my+name@host:8080/directory%2Fmy+file?foo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedPath).assertEqual("/directory%2Fmy+file");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDPATH_0600
     * @tc.name      : testEncodedPath0006
     * @tc.desc      : Testing if the correct encoded path is retrieved from a URI with complex encoded path.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedPath0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedPath0006';
      try {
        let Uri = "https://username:my+name@host:8080/direc%2F=tory%2Fmy+file?foo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedPath).assertEqual("/direc%2F=tory%2Fmy+file");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDPATH_0700
     * @tc.name: testEncodedPath0007
     * @tc.desc: Encoded URI path
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedPath0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('http://www.test.com/file/image.jpg');
      expect(route.encodedPath).assertEqual("/file/image.jpg");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDPATH_0800
     * @tc.name: testEncodedPath0008
     * @tc.desc: Encoded URI path
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedPath0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('http://www.test.com/');
      expect(route.encodedPath).assertEqual("/");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDPATH_0900
     * @tc.name: testEncodedPath0009
     * @tc.desc: Encoded URI path
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedPath0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('http://www.test.com');
      expect(route.encodedPath).assertEqual(null);
      let mailRoute = new uri.URI('mailto:body');
      expect(mailRoute.encodedPath).assertEqual(null);
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDPATH_1000
     * @tc.name: testEncodedPath0010
     * @tc.desc: Encoded URI path
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedPath0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('http://www.test.com/my%20file');
      expect(route.encodedPath).assertEqual("/my%20file");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDPATH_1100
     * @tc.name: testEncodedPath0011
     * @tc.desc: set EncodedPath to the URI Path
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedPath0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("http://userinfo@www.test.com:77/path/path23?query#qwer");
      uriObj.encodedPath = "";
      expect(uriObj.encodedPath).assertEqual(null);
      expect(uriObj.toString()).assertEqual('http://userinfo@www.test.com:77?query#qwer');
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDPATH_1200
     * @tc.name: testEncodedPath0012
     * @tc.desc: set EncodedPath to the URI Path
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedPath0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("http://userinfo@www.test.com:77/path/path23?query#qwer");
      uriObj.encodedPath = "pathtest/pp";
      expect(uriObj.encodedPath).assertEqual('pathtest/pp');
      expect(uriObj.toString()).assertEqual('http://userinfo@www.test.com:77/pathtest/pp?query#qwer');
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDPATH_1300
     * @tc.name: testEncodedPath0013
     * @tc.desc: set EncodedPath to the URI Path
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedPath0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("http://userinfo@www.test.com:77/path/path23?query#qwer");
      uriObj.encodedPath = "pathtest/p%E5%A4%A7p";
      expect(uriObj.encodedPath).assertEqual('pathtest/p%E5%A4%A7p');
      expect(uriObj.toString()).assertEqual('http://userinfo@www.test.com:77/pathtest/p%E5%A4%A7p?query#qwer');
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDPATH_1400
     * @tc.name: testEncodedPath0014
     * @tc.desc: set EncodedPath to the URI Path
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedPath0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("http://userinfo@www.test.com:77?query#qwer");
      uriObj.encodedPath = "/testuri015/p大p/";
      expect(uriObj.encodedPath).assertEqual('/testuri015/p大p/');
      expect(uriObj.toString()).assertEqual('http://userinfo@www.test.com:77/testuri015/p%E5%A4%A7p/?query#qwer');
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDPATH_1500
     * @tc.name: testEncodedPath0015
     * @tc.desc: set EncodedPath to the URI Path
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedPath0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("http://userinfo@www.test.com:77");
      uriObj.encodedPath = "testuri016/p%E5%A4%A7/";
      expect(uriObj.encodedPath).assertEqual('testuri016/p%E5%A4%A7/');
      expect(uriObj.toString()).assertEqual('http://userinfo@www.test.com:77/testuri016/p%E5%A4%A7/');
    });
  })
}