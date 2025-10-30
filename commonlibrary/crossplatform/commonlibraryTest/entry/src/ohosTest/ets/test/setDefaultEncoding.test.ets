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
import { stream } from '@kit.ArkTS';

function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function SetDefaultEncodingTest() {
  describe('SetDefaultEncodingTest', () => {
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
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_SETDEFAULTENCODING_0100
     * @tc.name       : testSetDefaultEncoding0001
     * @tc.desc       : Test the function of the interface testSetDefaultEncoding.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testSetDefaultEncoding0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testSetDefaultEncoding0001";
      try {
        let x = new stream.Writable;
        expect(x.setDefaultEncoding()).assertFalse();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_SETDEFAULTENCODING_0200
     * @tc.name       : testSetDefaultEncoding0002
     * @tc.desc       : Test the function of the interface testSetDefaultEncoding.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testSetDefaultEncoding0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testSetDefaultEncoding0002";
      try {
        let x = new stream.Writable;
        expect(x.setDefaultEncoding("")).assertFalse();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_SETDEFAULTENCODING_0300
     * @tc.name       : testSetDefaultEncoding0003
     * @tc.desc       : Test the function of the interface testSetDefaultEncoding.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testSetDefaultEncoding0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testSetDefaultEncoding0003";
      try {
        let x = new stream.Writable;
        x.setDefaultEncoding(' ');
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect(err.message).assertEqual('Unknown encoding:  ');
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_SETDEFAULTENCODING_0400
     * @tc.name       : testSetDefaultEncoding0004
     * @tc.desc       : Test the function of the interface testSetDefaultEncoding.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testSetDefaultEncoding0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testSetDefaultEncoding0004";
      try {
        let x = new stream.Writable;
        let y = x.setDefaultEncoding('11');
        console.log(`${TAG} result: ` + y);
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect(err.message).assertEqual('Unknown encoding: 11');
      }
    });
    
    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_SETDEFAULTENCODING_0500
     * @tc.name       : testSetDefaultEncoding0005
     * @tc.desc       : Test the function of the interface testSetDefaultEncoding.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testSetDefaultEncoding0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = "testSetDefaultEncoding0005";
      try {
        let x = new stream.Writable;
        expect(x.setDefaultEncoding('utf-8')).assertTrue();
        expect(x.setDefaultEncoding('gb18030')).assertTrue();
        expect(x.setDefaultEncoding('gbk')).assertTrue();
        expect(x.setDefaultEncoding('gb2312')).assertTrue();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.message}`);
        expect().assertFail();
      }
    });
  })
}