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

export default function EncodedFragmentTest() {
  describe('EncodedFragmentTest', () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDFRAGMENT_0100
     * @tc.name      : testEncodedFragment0001
     * @tc.desc      : Testing if a Syntax Error is returned for a URI with double hash marks.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedFragment0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedFragment0001';
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
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDFRAGMENT_0200
     * @tc.name      : testEncodedFragment0002
     * @tc.desc      : Testing if a Syntax Error is returned for a URI with multiple fragment sections.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedFragment0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedFragment0002';
      try {
        let Uri = "https://username:my+name@host:8080/directory/my+file?foo=1&bar=2#fr#agment";
        new uri.URI(Uri);
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect(err.code).assertEqual(10200002);
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDFRAGMENT_0300
     * @tc.name      : testEncodedFragment0003
     * @tc.desc      : Testing if a Syntax Error is returned for a URI with trailing hash.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedFragment0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedFragment0003';
      try {
        let Uri = "https://username:my+name@host:8080/directory/my+file?foo=1&bar=2#fragment#";
        new uri.URI(Uri);
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect(err.code).assertEqual(10200002);
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDFRAGMENT_0400
     * @tc.name      : testEncodedFragment0004
     * @tc.desc      : Testing if a Syntax Error is returned for a URI with malformed fragment.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedFragment0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedFragment0003';
      try {
        let Uri = "https://username:my+name@host:8080/directory/my+file?foo=1&bar=2#frag==##ment";
        new uri.URI(Uri);
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect(err.code).assertEqual(10200002);
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDFRAGMENT_0500
     * @tc.name      : testEncodedFragment0005
     * @tc.desc      : Testing if null is returned for a URI with percent-encoded fragment character in the path.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedFragment0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedFragment0005';
      try {
        let Uri = "https://username:my+name@host:8080/directory/my+file?foo=1&bar=2%23fragment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedFragment).assertEqual(null);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_ENCODEDFRAGMENT_0600
     * @tc.name      : testEncodedFragment0006
     * @tc.desc      : Testing if the correct encoded fragment is retrieved from a URI with encoded fragment characters.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testEncodedFragment0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testEncodedFragment0006';
      try {
        let Uri = "https://username:my+name@host:8080/directory/my+file?foo=1&bar=2#frag%3Dment";
        let uriInstance = new uri.URI(Uri);
        expect(uriInstance.encodedFragment).assertEqual("frag%3Dment");
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDFRAGMENT_0700
     * @tc.name: testEncodedFragment0007
     * @tc.desc: Encoded URI fragment
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedFragment0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('mailto:body#top');
      expect(route.encodedFragment).assertEqual("top");
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDFRAGMENT_0800
     * @tc.name: testEncodedFragment0008
     * @tc.desc: Encoded URI fragment
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedFragment0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('mailto:body#');
      expect(route.encodedFragment).assertEqual(null);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDFRAGMENT_0900
     * @tc.name: testEncodedFragment0009
     * @tc.desc: Encoded URI fragment
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedFragment0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('mailto:body#te%20st');
      expect(route.encodedFragment).assertEqual("te%20st");
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDFRAGMENT_1000
     * @tc.name: testEncodedFragment0010
     * @tc.desc: Encoded URI fragment
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedFragment0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('mailto:body');
      expect(route.encodedFragment).assertEqual(null);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDFRAGMENT_1100
     * @tc.name: testEncodedFragment0011
     * @tc.desc: set EncodedFragment to the URI Fragment
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedFragment0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("http:/userinfo@www.test.com:77/testuri017/p大p/?query#qwer");
      uriObj.encodedFragment = 'kkey=sal&jj=oi';
      expect(uriObj.encodedFragment).assertEqual("kkey=sal&jj=oi");
      expect(uriObj.ssp).assertEqual("/userinfo@www.test.com:77/testuri017/p大p/?query");
      expect(uriObj.toString())
        .assertEqual('http:/userinfo@www.test.com:77/testuri017/p%E5%A4%A7p/?query#kkey=sal&jj=oi');
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDFRAGMENT_1200
     * @tc.name: testEncodedFragment0012
     * @tc.desc: set EncodedFragment to the URI Fragment
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedFragment0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("http:/userinfo@www.test.com:77/testuri017/p大p/?query#qwer");
      uriObj.encodedFragment = '';
      expect(uriObj.encodedFragment).assertEqual(null);
      expect(uriObj.toString()).assertEqual('http:/userinfo@www.test.com:77/testuri017/p%E5%A4%A7p/?query');
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDFRAGMENT_1300
     * @tc.name: testEncodedFragment0013
     * @tc.desc: set EncodedFragment to the URI Fragment
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedFragment0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("http:/userinfo@www.test.com:77/testuri017/p大p/?query#qwer");
      uriObj.encodedFragment = '#jia片段';
      expect(uriObj.encodedFragment).assertEqual("qwer");
      expect(uriObj.toString()).assertEqual('http:/userinfo@www.test.com:77/testuri017/p%E5%A4%A7p/?query#qwer');
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDFRAGMENT_1400
     * @tc.name: testEncodedFragment0014
     * @tc.desc: set EncodedFragment to the URI Fragment
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedFragment0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("http://userinfo@www.test.com:77/testuri017/p大p/?query");
      uriObj.encodedFragment = 'jia片段f';
      expect(uriObj.encodedFragment).assertEqual("jia片段f");
      expect(uriObj.toString())
        .assertEqual('http://userinfo@www.test.com:77/testuri017/p%E5%A4%A7p/?query#jia%E7%89%87%E6%AE%B5f');
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_ENCODEDFRAGMENT_1500
     * @tc.name: testEncodedFragment0015
     * @tc.desc: set EncodedFragment to the URI Fragment
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testEncodedFragment0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uriObj = new uri.URI("http:userinfo@www.test.com:77/testuri017/p大p/?query");
      uriObj.encodedFragment = 'jia片段f';
      expect(uriObj.encodedFragment).assertEqual("jia片段f");
      expect(uriObj.toString())
        .assertEqual('http:userinfo@www.test.com:77/testuri017/p%E5%A4%A7p/?query#jia%E7%89%87%E6%AE%B5f');
    });
  })
}