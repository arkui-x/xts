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

export default function EncodedQueryTest() {
  describe('EncodedQueryTest', () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDQUERY_0100
     * @tc.name      : testEncodedQuery0001
     * @tc.desc      : Testing if the correct encoded query is retrieved from a URI with double question marks.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedQuery0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedQuery0001';
      try {
        let Uri = "https://username:my+name@host:8080/directory/my+file??foo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedQuery).assertEqual("?foo=1&bar=2");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDQUERY_0200
     * @tc.name      : testEncodedQuery0002
     * @tc.desc      : Testing if the correct encoded query is retrieved from a URI with path ending with a slash followed by a double slash.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedQuery0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedQuery0002';
      try {
        let Uri = "https://username:my+name@host:8080/directory/my+file/?/?foo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedQuery).assertEqual("/?foo=1&bar=2");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDQUERY_0300
     * @tc.name      : testEncodedQuery0003
     * @tc.desc      : Testing if the correct encoded query is retrieved from a URI with unusual query structure.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedQuery0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedQuery0003';
      try {
        let Uri = "https://username:my+name@host:8080/directory/my+file?f?oo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedQuery).assertEqual("f?oo=1&bar=2");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDQUERY_0400
     * @tc.name      : testEncodedQuery0004
     * @tc.desc      : Testing if the correct encoded query is retrieved from a URI with complex query parameters.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedQuery0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedQuery0004';
      try {
        let Uri = "https://username:my+name@host:8080/directory/my+file?foo=aa=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedQuery).assertEqual("foo=aa=1&bar=2");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDQUERY_0500
     * @tc.name      : testEncodedQuery0005
     * @tc.desc      : Testing if the correct encoded query is retrieved from a URI with mixed query parameters.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedQuery0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedQuery0005';
      try {
        let Uri = "https://username:my+name@host:8080/directory/my+file?foo=1&&bar&=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedQuery).assertEqual("foo=1&&bar&=2");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDQUERY_0600
     * @tc.name      : testEncodedQuery0006
     * @tc.desc      : Testing if null is returned for a URI with percent-encoded question mark in path.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedQuery0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedQuery0006';
      try {
        let Uri = "https://username:my+name@host:8080/directory/my+file%3Ffoo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedQuery).assertEqual(null);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDQUERY_0700
     * @tc.name      : testEncodedQuery0007
     * @tc.desc      : Testing if the correct encoded query is retrieved from a URI with encoded query parameters.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedQuery0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedQuery0007';
      try {
        let Uri = "https://username:my+name@host:8080/directory/my+file?foo%3D1%26bar%3D2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedQuery).assertEqual("foo%3D1%26bar%3D2");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDQUERY_0800
     * @tc.name: testEncodedQuery0008
     * @tc.desc: Encoded URI parameters
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedQuery0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('https://www.test.com/search?query=name&query=my');
      expect(route.encodedQuery).assertEqual("query=name&query=my");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDQUERY_0900
     * @tc.name: testEncodedQuery0009
     * @tc.desc: Encoded URI parameters
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedQuery0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('https://www.test.com/search?');
      expect(route.encodedQuery).assertEqual(null);
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDQUERY_1000
     * @tc.name: testEncodedQuery0010
     * @tc.desc: Encoded URI parameters
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedQuery0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('https://www.test.com/');
      expect(route.encodedQuery).assertEqual(null);
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDQUERY_1100
     * @tc.name: testEncodedQuery0011
     * @tc.desc: Encoded URI parameters
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedQuery0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('https://www.test.com/search?query=my%20test');
      expect(route.encodedQuery).assertEqual("query=my%20test");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDQUERY_1200
     * @tc.name: testEncodedQuery0012
     * @tc.desc: set EncodedQuery to the URI Query
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedQuery0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("http://userinfo@www.test.com:77/testuri017/p大p/?query#qwer");
      uriObj.encodedQuery = "/testuri018/p大p/=sasf";
      expect(uriObj.encodedQuery).assertEqual('/testuri018/p大p/=sasf');
      let res = 'http://userinfo@www.test.com:77/testuri017/p%E5%A4%A7p/?/testuri018/p%E5%A4%A7p/=sasf#qwer';
      expect(uriObj.toString()).assertEqual(res);
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDQUERY_1300
     * @tc.name: testEncodedQuery0013
     * @tc.desc: set EncodedQuery to the URI Query
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedQuery0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("http://userinfo@www.test.com:77/testuri017/p大p/?query#qwer");
      uriObj.encodedQuery = "key=value&key1=value1";
      expect(uriObj.encodedQuery).assertEqual('key=value&key1=value1');
      expect(uriObj.toString())
        .assertEqual('http://userinfo@www.test.com:77/testuri017/p%E5%A4%A7p/?key=value&key1=value1#qwer');
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDQUERY_1400
     * @tc.name: testEncodedQuery0014
     * @tc.desc: set EncodedQuery to the URI Query
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedQuery0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("http://userinfo@www.test.com:77/testuri017/p大p/?query#qwer");
      uriObj.encodedQuery = '';
      expect(uriObj.encodedQuery).assertEqual(null);
      expect(uriObj.toString()).assertEqual('http://userinfo@www.test.com:77/testuri017/p%E5%A4%A7p/#qwer');
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDQUERY_1500
     * @tc.name: testEncodedQuery0015
     * @tc.desc: set EncodedQuery to the URI Query
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedQuery0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("http://userinfo@www.test.com:77/testuri017/p大p/?query#qwer");
      uriObj.encodedQuery = 'kkey=sal';
      expect(uriObj.encodedQuery).assertEqual("kkey=sal");
      expect(uriObj.ssp).assertEqual("//userinfo@www.test.com:77/testuri017/p大p/?kkey=sal");
      expect(uriObj.toString()).assertEqual('http://userinfo@www.test.com:77/testuri017/p%E5%A4%A7p/?kkey=sal#qwer');
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDQUERY_1600
     * @tc.name: testEncodedQuery0016
     * @tc.desc: set EncodedQuery to the URI Query
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedQuery0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("http:/userinfo@www.test.com:77/testuri017/p大p/?query#qwer");
      uriObj.encodedQuery = 'kkey=sal&jj=oi';
      expect(uriObj.encodedQuery).assertEqual("kkey=sal&jj=oi");
      expect(uriObj.ssp).assertEqual("/userinfo@www.test.com:77/testuri017/p大p/?kkey=sal&jj=oi");
      expect(uriObj.toString())
        .assertEqual('http:/userinfo@www.test.com:77/testuri017/p%E5%A4%A7p/?kkey=sal&jj=oi#qwer');
    });
  })
}