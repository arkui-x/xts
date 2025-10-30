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
function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function CheckRelativeTest() {
  describe('CheckRelativeTest', () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_URI_CHECKRELATIVE_0100
     * @tc.name      : testCheckRelative0001
     * @tc.desc      : Testing if a URI with special characters in the query key part is correctly identified as relative.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testCheckRelative0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testCheckRelative0001';
      try {
        let uri1 = '/directory/file?key1' + str2 + '=value1#qwer=da';
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.checkRelative();
        expect(result1).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_CHECKRELATIVE_0200
     * @tc.name      : testCheckRelative0002
     * @tc.desc      : Testing if a URI with special characters in the query key part is correctly identified as relative.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testCheckRelative0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testCheckRelative0002';
      try {
        let uri1 = '/directory/file?key1' + str3 + '=value1#qwer=da';
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.checkRelative();
        expect(result1).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_CHECKRELATIVE_0300
     * @tc.name      : testCheckRelative0003
     * @tc.desc      : Testing if a URI with special characters in the query value part is correctly identified as relative.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testCheckRelative0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testCheckRelative0003';
      try {
        let uri1 = '/directory/file?key1=value1' + str2 + '#qwer=da';
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.checkRelative();
        expect(result1).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_CHECKRELATIVE_0400
     * @tc.name      : testCheckRelative0004
     * @tc.desc      : Testing if a URI with special characters in the query value part is correctly identified as relative.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testCheckRelative0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testCheckRelative0004';
      try {
        let uri1 = '/directory/file?key1=value1' + str3 + '#qwer=da';
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.checkRelative();
        expect(result1).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_CHECKRELATIVE_0500
     * @tc.name      : testCheckRelative0005
     * @tc.desc      : Testing if a URI with special characters in the query key part is correctly identified as not relative.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testCheckRelative0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testCheckRelative0005';
      try {
        let uri1 = 'https://username:password@host:8080/directory/file?key1' + str2 + '=value1#qwer=da';
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.checkRelative();
        expect(result1).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_CHECKRELATIVE_0600
     * @tc.name      : testCheckRelative0006
     * @tc.desc      : Testing if a URI with special characters in the query key part is correctly identified as not relative.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testCheckRelative0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testCheckRelative0006';
      try {
        let uri1 = 'https://username:password@host:8080/directory/file?key1' + str3 + '=value1#qwer=da';
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.checkRelative();
        expect(result1).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_CHECKRELATIVE_0700
     * @tc.name      : testCheckRelative0007
     * @tc.desc      : Testing if a URI with special characters in the query value part is correctly identified as not relative.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testCheckRelative0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testCheckRelative0007';
      try {
        let uri1 = 'https://username:password@host:8080/directory/file?key1=value1' + str2 + '#qwer=da';
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.checkRelative();
        expect(result1).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_URI_CHECKRELATIVE_0800
     * @tc.name      : testCheckRelative0008
     * @tc.desc      : Testing if a URI with special characters in the query value part is correctly identified as not relative.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level      : Level 1
     */
    it('testCheckRelative0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testCheckRelative0008';
      try {
        let uri1 = 'https://username:password@host:8080/directory/file?key1=value1' + str3 + '#qwer=da';
        let uriInstance = new uri.URI(uri1);
        let result1 = uriInstance.checkRelative();
        expect(result1).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_CHECKRELATIVE_0900
     * @tc.name: testCheckRelative0009
     * @tc.desc: Tells whether or not this URI is relative.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 0
     */
    it('testCheckRelative0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let route = new uri.URI('http://www.test.com/images/pic.jpg');
      let res = route.checkRelative();
      expect(res).assertEqual(false);
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_CHECKRELATIVE_1000
     * @tc.name: testCheckRelative0010
     * @tc.desc: Tells whether or not this URI is relative.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 0
     */
    it('testCheckRelative0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let route = new uri.URI('/images/pic.jpg');
      let res = route.checkRelative();
      expect(res).assertEqual(true);
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_CHECKRELATIVE_1100
     * @tc.name: testCheckRelative0011
     * @tc.desc: Tells whether or not this URI is relative.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testCheckRelative0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('https://www.test.com/images/logo.jpg');
      let res = route.checkRelative();
      expect(res).assertEqual(false);
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_CHECKRELATIVE_1200
     * @tc.name: testCheckRelative0012
     * @tc.desc: Tells whether or not this URI is relative.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testCheckRelative0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let route = new uri.URI('aaa');
      let res = route.checkRelative();
      expect(res).assertEqual(true);
    });
    
    /**
     * @tc.number: SUB_COMMONLIBRARY_URI_CHECKRELATIVE_1300
     * @tc.name: testCheckRelative0013
     * @tc.desc: Tells whether or not this URI is relative.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it('testCheckRelative0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let mailtoRoute = new uri.URI('mailto:user@test.com');
      expect(mailtoRoute.checkRelative()).assertEqual(false);
    })
  })
}