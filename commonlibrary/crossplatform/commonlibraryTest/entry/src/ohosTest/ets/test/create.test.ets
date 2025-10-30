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
import { util } from '@kit.ArkTS';

function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function CreateTest() {
  describe('CreateTest', () => {
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
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_TEXTENCODERCREATE_0100
     * @tc.name       : testTextEncoderCreate0001
     * @tc.desc       : Testing the Constructor of TextEncoderCreate values iso-8859-14.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testTextEncoderCreate0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testTextEncoderCreate0001';
      try {
        let result = util.TextEncoder.create('iso-8859-14')
        let retStr = result.encoding
        expect(retStr).assertEqual('iso-8859-14')
      } catch (err) {
        console.error(`${TAG} failed, error code: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_TEXTENCODERCREATE_0200
     * @tc.name       : testTextEncoderCreate0002
     * @tc.desc       : Testing the Constructor of TextEncoderCreate values undefined.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testTextEncoderCreate0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testTextEncoderCreate0002';
      try {
        let result = util.TextEncoder.create(undefined)
        let retStr = result.encoding
        expect(retStr).assertEqual('utf-8')
      } catch (err) {
        console.error(`${TAG} failed, error code: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_TEXTENCODERCREATE_0300
     * @tc.name       : testTextEncoderCreate0003
     * @tc.desc       : Testing the Constructor of TextEncoderCreate values null.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testTextEncoderCreate0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testTextEncoderCreate0003';
      try {
        let result = util.TextEncoder.create(null)
        let retStr = result.encoding
        expect(retStr).assertEqual('utf-8')
      } catch (err) {
        console.error(`${TAG} failed, error code: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_TEXTENCODERCREATE_0400
     * @tc.name       : testTextEncoderCreate0004
     * @tc.desc       : Testing the Constructor of TextEncoderCreate values 'windows-1250'.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testTextEncoderCreate0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testTextEncoderCreate0004';
      try {
        let result = util.TextEncoder.create('windows-1250')
        let retStr = result.encoding
        expect(retStr).assertEqual('windows-1250')
      } catch (err) {
        console.error(`${TAG} failed, error code: ${err.code}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_TEXTENCODERCREATE_0500
     * @tc.name       : testTextEncoderCreate0005
     * @tc.desc       : Testing the Constructor of TextEncoderCreate values 'utf-16'.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testTextEncoderCreate0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testTextEncoderCreate0005';
      try {
        let result = util.TextEncoder.create('utf-16')
        let retStr = result.encoding
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} failed, error code: ${err.code}`);
        expect(err.code).assertEqual(undefined);
      }
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_UTIL_TEXTENCODERCREATE_0600
     * @tc.name       : testTextEncoderCreate0006
     * @tc.desc       : Testing the Constructor of TextEncoderCreate values 'utf-32'.
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testTextEncoderCreate0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let TAG = 'testTextEncoderCreate0006';
      try {
        let result = util.TextEncoder.create('utf-32')
        let retStr = result.encoding
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} failed, error code: ${err.code}`);
        expect(err.code).assertEqual(undefined);
      }
    });
  })
}