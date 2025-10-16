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

export default function EncodedUserInfoTest() {
  describe('EncodedUserInfoTest', () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDUSERINFO_0100
     * @tc.name      : testEncodedUserInfo0001
     * @tc.desc      : Testing if the correct encoded user info is retrieved from a URI with doubles colons.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedUserInfo0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedUserInfo0001';
      try {
        let Uri = "https://username::my+name@host:8080/directory/my+file?foo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedUserInfo).assertEqual("username::my+name");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDUSERINFO_0200
     * @tc.name      : testEncodedUserInfo0002
     * @tc.desc      : Testing if null is returned for a URI with malformed user info (leading slash).
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedUserInfo0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedUserInfo0002';
      try {
        let Uri = "https:///username:my+name@host:8080/directory/my+file?foo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedUserInfo).assertEqual(null);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDUSERINFO_0300
     * @tc.name      : testEncodedUserInfo0003
     * @tc.desc      : Testing if null is returned for a URI with invalid user info (double @).
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedUserInfo0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedUserInfo0003';
      try {
        let Uri = "https://username:my+name@@host:8080/directory/my+file?foo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedUserInfo).assertEqual(null);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDUSERINFO_0400
     * @tc.name      : testEncodedUserInfo0004
     * @tc.desc      : Testing if null is returned for a URI with incomplete user info.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedUserInfo0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedUserInfo0004';
      try {
        let Uri = "https://username:@my+name@host:8080/directory/my+file?foo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedUserInfo).assertEqual(null);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDUSERINFO_0500
     * @tc.name      : testEncodedUserInfo0005
     * @tc.desc      : Testing if null is returned for a URI with malformed user info (host).
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedUserInfo0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedUserInfo0005';
      try {
        let Uri = "https://username:my+name@host@:8080/directory/my+file?foo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedUserInfo).assertEqual(null);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDUSERINFO_0600
     * @tc.name      : testEncodedUserInfo0006
     * @tc.desc      : Testing if the correct encoded user info is retrieved from a percent-encoded username and password.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedUserInfo0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedUserInfo0006';
      try {
        let Uri = "https://username%3Apassword@host:8080/directory/file?foo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedUserInfo).assertEqual("username%3Apassword");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDUSERINFO_0700
     * @tc.name      : testEncodedUserInfo0007
     * @tc.desc      : Testing if null is returned for a percent-encoded URI with an encoded host character.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedUserInfo0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedUserInfo0007';
      try {
        let Uri = "https://username%3Apassword%40host:8080/directory/file?foo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedUserInfo).assertEqual(null);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDUSERINFO_0800
     * @tc.name: testEncodedUserInfo0008
     * @tc.desc:Encoded URI user information
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedUserInfo0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('http://username:name@www.test.com/');
      expect(route.encodedUserInfo).assertEqual("username:name");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDUSERINFO_0900
     * @tc.name: testEncodedUserInfo0009
     * @tc.desc: Encoded URI user information
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedUserInfo0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('http://username:@www.test.com/');
      expect(route.encodedUserInfo).assertEqual("username:");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDUSERINFO_1000
     * @tc.name: testEncodedUserInfo0010
     * @tc.desc: Encoded URI user information
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedUserInfo0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('http://username:my%20name@www.test.com/');
      expect(route.encodedUserInfo).assertEqual("username:my%20name");
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDUSERINFO_1100
     * @tc.name: testEncodedUserInfo0011
     * @tc.desc: Encoded URI user information
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedUserInfo0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('http://www.test.com');
      expect(route.encodedUserInfo).assertEqual(null);
      let mailRoute = new uri.URI('mailto:body');
      expect(mailRoute.encodedUserInfo).assertEqual(null);
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDUSERINFO_1200
     * @tc.name: testEncodedUserInfo0012
     * @tc.desc: set EncodedUserInfo to the URI UserInfo
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedUserInfo0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("http://user@www.hw.com:77/path/path23?query#qwer");
      uriObj.encodedUserInfo = "testuri007";
      expect(uriObj.encodedUserInfo).assertEqual('testuri007');
      expect(uriObj.toString()).assertEqual('http://testuri007@www.hw.com:77/path/path23?query#qwer');
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDUSERINFO_1300
     * @tc.name: testEncodedUserInfo0013
     * @tc.desc: set EncodedUserInfo to the URI UserInfo
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedUserInfo0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("http://www.test.com:77/path/path23?query#qwer");
      uriObj.encodedUserInfo = "testuri008";
      expect(uriObj.encodedUserInfo).assertEqual('testuri008');
      expect(uriObj.toString()).assertEqual('http://testuri008@www.test.com:77/path/path23?query#qwer');
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDUSERINFO_1400
     * @tc.name: testEncodedUserInfo0014
     * @tc.desc: set EncodedUserInfo to the URI UserInfo
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedUserInfo0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("http://userinfo@www.test.com:77/path/path23?query#qwer");
      uriObj.encodedUserInfo = "sji<+s大";
      expect(uriObj.encodedUserInfo).assertEqual('userinfo');
      expect(uriObj.toString()).assertEqual('http://userinfo@www.test.com:77/path/path23?query#qwer');
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDUSERINFO_1500
     * @tc.name: testEncodedUserInfo0015
     * @tc.desc: set EncodedUserInfo to the URI UserInfo
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedUserInfo0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("http:/userinfo@www.test.com:77/path/path23?query#qwer");
      uriObj.encodedUserInfo = "sji<+s大";
      expect(uriObj.encodedUserInfo).assertEqual(null);
      expect(uriObj.toString()).assertEqual('http:/userinfo@www.test.com:77/path/path23?query#qwer');
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDUSERINFO_1600
     * @tc.name: testEncodedUserInfo0016
     * @tc.desc: set EncodedUserInfo to the URI UserInfo
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedUserInfo0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("http://userinfo@www.test.com:77/path/path23?query#qwer");
      uriObj.encodedUserInfo = "";
      expect(uriObj.userInfo).assertEqual(null);
      expect(uriObj.toString()).assertEqual('http://www.test.com:77/path/path23?query#qwer');
    });
  })
}