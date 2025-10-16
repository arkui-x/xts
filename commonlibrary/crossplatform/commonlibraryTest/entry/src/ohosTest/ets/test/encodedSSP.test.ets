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

export default function encodedSSPTest() {
  describe('encodedSSPTest', () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDSSP_0100
     * @tc.name      : testEncodedSSP0001
     * @tc.desc      : Testing if the correct encoded SSP is retrieved from a URI with multiple leading slashes.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedSSP0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedSSP0001';
      try {
        let Uri = "https:////username:my+name@host:8080/directory/my+file?foo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedSSP).assertEqual("////username:my+name@host:8080/directory/my+file?foo=1&bar=2");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDSSP_0200
     * @tc.name      : testEncodedSSP0002
     * @tc.desc      : Testing if a Syntax Error is returned for a URI with double hashes.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedSSP0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedSSP0002';
      try {
        let Uri = "https://username:my+name@host:8080/directory/my+file?foo=1&bar=2##fragment";
        new uri.URI(Uri);
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect(err.code).assertEqual(10200002);
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDSSP_0300
     * @tc.name      : testEncodedSSP0003
     * @tc.desc      : Testing if the correct encoded SSP is retrieved from a URI with a different scheme.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedSSP0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedSSP0003';
      try {
        let Uri = "https:ftp://username:my+name@host:8080/directory/my+file?foo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedSSP).assertEqual("ftp://username:my+name@host:8080/directory/my+file?foo=1&bar=2");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDSSP_0400
     * @tc.name      : testEncodedSSP0004
     * @tc.desc      : Testing if null is returned for a URI with percent-encoded characters in the scheme.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedSSP0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedSSP0004';
      try {
        let Uri = "https:%2F%2Fusername%3Amy%2Bname%40host%2B8080%2Fdirectory%2Fmy%" +
          "3Afile%3Ffoo%3D1%26bar%3D2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedSSP).assertEqual("%2F%2Fusername%3Amy%2Bname%40host%2B8080%" +
          "2Fdirectory%2Fmy%3Afile%3Ffoo%3D1%26bar%3D2");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDSSP_0500
     * @tc.name: testEncodedSSP0005
     * @tc.desc:  Encoded URI specific scheme section
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedSSP0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('http://username:name@www.test.com/path?query=example');
      expect(route.encodedSSP).assertEqual("//username:name@www.test.com/path?query=example");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDSSP_0600
     * @tc.name: testEncodedSSP0006
     * @tc.desc:  Encoded URI specific scheme section
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedSSP0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('http://username:my%20name@www.test.com');
      expect(route.encodedSSP).assertEqual("//username:my%20name@www.test.com");
      let route1 = new uri.URI('http://username:my_20name@www.test.com');
      expect(route1.encodedSSP).assertEqual("//username:my_20name@www.test.com");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDSSP_0700
     * @tc.name: testEncodedSSP0007
     * @tc.desc:  Encoded URI specific scheme section
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedSSP0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('https://www.test.com/');
      expect(route.encodedSSP).assertEqual("//www.test.com/");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDSSP_0800
     * @tc.name: testEncodedSSP0008
     * @tc.desc: set EncodedSsp to the URI Ssp
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedSSP0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("http://userinfo@www.test.com:77/testuri017/p大p/?query#asd");
      uriObj.encodedSSP = 'usc@asjf:99/path1/ss?key=1';
      expect(uriObj.userInfo).assertEqual(null);
      expect(uriObj.host).assertEqual(null);
      expect(uriObj.port).assertEqual("-1");
      expect(uriObj.authority).assertEqual(null);
      expect(uriObj.path).assertEqual(null);
      expect(uriObj.encodedSSP).assertEqual('usc@asjf:99/path1/ss?key=1');
      expect(uriObj.toString()).assertEqual('http:usc@asjf:99/path1/ss?key=1#asd');
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDSSP_0900
     * @tc.name: testEncodedSSP0009
     * @tc.desc: set EncodedSsp to the URI Ssp
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedSSP0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("http://userinfo@www.test.com:77/testuri017/p大p/?query#asd");
      uriObj.encodedSSP = '/usc@asjf:99/path1/ss?key=1';
      expect(uriObj.userInfo).assertEqual(null);
      expect(uriObj.host).assertEqual(null);
      expect(uriObj.path).assertEqual("/usc@asjf:99/path1/ss");
      expect(uriObj.authority).assertEqual(null);
      expect(uriObj.encodedSSP).assertEqual('/usc@asjf:99/path1/ss?key=1');
      expect(uriObj.toString()).assertEqual('http:/usc@asjf:99/path1/ss?key=1#asd');
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDSSP_1000
     * @tc.name: testEncodedSSP0010
     * @tc.desc: set EncodedSsp to the URI Ssp
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedSSP0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("safdcas://userinfo@www.test.com:77/testuri017/p大p/?query#asd");
      uriObj.encodedSSP = '//usc@www.test321.cn:996?key=1';
      expect(uriObj.userInfo).assertEqual("usc");
      expect(uriObj.host).assertEqual("www.test321.cn");
      expect(uriObj.path).assertEqual(null);
      expect(uriObj.encodedAuthority).assertEqual('usc@www.test321.cn:996');
      expect(uriObj.encodedSSP).assertEqual('//usc@www.test321.cn:996?key=1');
      expect(uriObj.toString()).assertEqual('safdcas://usc@www.test321.cn:996?key=1#asd');
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDSSP_1100
     * @tc.name: testEncodedSSP0011
     * @tc.desc: set EncodedSsp to the URI Ssp
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedSSP0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("safdcas://userinfo@www.test.com:77/testuri017/p大p/?query#asdasf");
      uriObj.encodedSSP = '//www.test321.cn';
      expect(uriObj.userInfo).assertEqual(null);
      expect(uriObj.host).assertEqual("www.test321.cn");
      expect(uriObj.path).assertEqual(null);
      expect(uriObj.authority).assertEqual('www.test321.cn');
      expect(uriObj.encodedSSP).assertEqual('//www.test321.cn');
      expect(uriObj.toString()).assertEqual('safdcas://www.test321.cn#asdasf');
    });
  })
}