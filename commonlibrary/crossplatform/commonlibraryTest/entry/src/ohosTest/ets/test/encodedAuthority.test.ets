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

export default function EncodedAuthorityTest() {
  describe('EncodedAuthorityTest', () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDAUTHORITY_0100
     * @tc.name      : testEncodedAuthority0001
     * @tc.desc      : Testing if the correct encoded authority is retrieved from a URI with double '@' symbols.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedAuthority0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedAuthority0001';
      try {
        let Uri = "https://username:my+name@@host:8080/directory/my+file?foo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedAuthority).assertEqual("username:my+name@@host:8080");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDAUTHORITY_0200
     * @tc.name      : testEncodedAuthority0002
     * @tc.desc      : Testing if the correct encoded authority is retrieved from a URI with a colon followed by an invalid character.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedAuthority0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedAuthority0002';
      try {
        let Uri = "https://username:@my+name@host:8080/directory/my+file?foo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedAuthority).assertEqual("username:@my+name@host:8080");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDAUTHORITY_0300
     * @tc.name      : testEncodedAuthority0003
     * @tc.desc      : Testing if the correct encoded authority is retrieved from a URI with an '@' in the username.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedAuthority0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedAuthority0003';
      try {
        let Uri = "https://user@name:my+name@host:8080/directory/my+file?foo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedAuthority).assertEqual("user@name:my+name@host:8080");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDAUTHORITY_0400
     * @tc.name      : testEncodedAuthority0004
     * @tc.desc      : Testing if the correct encoded authority is retrieved from a URI with invalid format.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedAuthority0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedAuthority0004';
      try {
        let Uri = "https://username:my+name@host@:8080/directory/my+file?foo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedAuthority).assertEqual("username:my+name@host@:8080");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDAUTHORITY_0500
     * @tc.name      : testEncodedAuthority0005
     * @tc.desc      : Testing if null is returned for a URI with percent-encoded authority character.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedAuthority0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedAuthority0005';
      try {
        let Uri = "https:%2F%2Fusername%3Amy%2Bname%40host%2B8080%2Fdirectory/my+file?foo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedAuthority).assertEqual(null);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDAUTHORITY_0600
     * @tc.name      : testEncodedAuthority0006
     * @tc.desc      : Testing if the correct encoded authority is retrieved from a URI with
     *                 percent-encoded characters in the username.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedAuthority0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedAuthority0006';
      try {
        let Uri = "https://username%3Amy%2Bname%40host%2B8080%2Fdirectory/my+file?foo=1&bar=2#fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedAuthority).assertEqual("username%3Amy%2Bname%40host%2B8080%2Fdirectory");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDAUTHORITY_0700
     * @tc.name: testEncodedAuthority0007
     * @tc.desc: Encoded resource location information
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedAuthority0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let route = new uri.URI('https://www.test.com/search?query=name&query=my');
      expect(route.encodedAuthority).assertEqual("www.test.com");
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDAUTHORITY_0800
     * @tc.name: testEncodedAuthority0008
     * @tc.desc: Encoded resource location information
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedAuthority0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let route = new uri.URI('http://username:my%20name@www.test.com/');
      expect(route.encodedAuthority).assertEqual("username:my%20name@www.test.com");
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDAUTHORITY_0900
     * @tc.name: testEncodedAuthority0009
     * @tc.desc: Encoded resource location information
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedAuthority0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let route = new uri.URI('mailto:body#top');
      expect(route.encodedAuthority).assertEqual(null);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDAUTHORITY_1000
     * @tc.name: testEncodedAuthority0010
     * @tc.desc: Encoded resource location information
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedAuthority0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, (): void => {
      let route = new uri.URI('https://www.test.com:8080/');
      expect(route.encodedAuthority).assertEqual("www.test.com:8080");
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDAUTHORITY_1100
     * @tc.name: testEncodedAuthority0011
     * @tc.desc: set EncodedAuthority to the URI Authority
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 2
     */
    it('testEncodedAuthority0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, (): void => {
      let uriObj = new uri.URI("http://userinfo@www.test.com:77/testuri017/p大p/?query#asd");
      uriObj.encodedAuthority = 'www.test11.cn:88';
      expect(uriObj.encodedUserInfo).assertEqual(null);
      expect(uriObj.host).assertEqual("www.test11.cn");
      expect(uriObj.port).assertEqual("88");
      expect(uriObj.toString()).assertEqual('http://www.test11.cn:88/testuri017/p%E5%A4%A7p/?query#asd');
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDAUTHORITY_1200
     * @tc.name: testEncodedAuthority0012
     * @tc.desc: set EncodedAuthority to the URI Authority
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 2
     */
    it('testEncodedAuthority0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, (): void => {
      let uriObj = new uri.URI("http://userinfo@www.test.com:77/testuri017/p大p/?query#asd");
      uriObj.encodedAuthority = 'uusc@www.testuc.com:741';
      expect(uriObj.encodedUserInfo).assertEqual("uusc");
      expect(uriObj.host).assertEqual("www.testuc.com");
      expect(uriObj.port).assertEqual("741");
      expect(uriObj.encodedAuthority).assertEqual("uusc@www.testuc.com:741");
      expect(uriObj.toString()).assertEqual('http://uusc@www.testuc.com:741/testuri017/p%E5%A4%A7p/?query#asd');
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDAUTHORITY_1300
     * @tc.name: testEncodedAuthority0013
     * @tc.desc: set EncodedAuthority to the URI Authority
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 2
     */
    it('testEncodedAuthority0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, (): void => {
      let uriObj = new uri.URI("http://userinfo@www.test.com:77/testuri017/p大p/?query#asd");
      uriObj.encodedAuthority = '';
      expect(uriObj.userInfo).assertEqual(null);
      expect(uriObj.host).assertEqual(null);
      expect(uriObj.port).assertEqual("-1");
      expect(uriObj.encodedAuthority).assertEqual(null);
      expect(uriObj.encodedSSP).assertEqual('/testuri017/p大p/?query');
      expect(uriObj.toString()).assertEqual('http:/testuri017/p%E5%A4%A7p/?query#asd');
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDAUTHORITY_1400
     * @tc.name: testEncodedAuthority0014
     * @tc.desc: set EncodedAuthority to the URI Authority
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 2
     */
    it('testEncodedAuthority0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, (): void => {
      let uriObj = new uri.URI("http://userinfo@www.test.com:77/testuri017/p大p/?query#asd");
      uriObj.encodedAuthority = 'usc@';
      expect(uriObj.userInfo).assertEqual(null);
      expect(uriObj.host).assertEqual(null);
      expect(uriObj.port).assertEqual("-1");
      expect(uriObj.encodedAuthority).assertEqual("usc@");
      expect(uriObj.encodedSSP).assertEqual('//usc@/testuri017/p大p/?query');
      expect(uriObj.toString()).assertEqual('http://usc@/testuri017/p%E5%A4%A7p/?query#asd');
    });
  })
}