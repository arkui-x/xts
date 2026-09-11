/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

import { describe, it, expect } from '@ohos/hypium';
import util from '@ohos.util';

export default function UtilFormatTest() {
  describe("UtilFormatTest", () => {
    /**
     * @tc.number: SUB_COMMONLIBRARY_UTIL_UTIL1_1010
     * @tc.name  : testUtilFormat001
     * @tc.desc  : Testing the format interface with value null.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 0
     */
    it("testUtilFormat001", 0, () => {
      const TAG = 'testUtilFormat001';
      try {
        let value1 = null;
        let result = util.format(value1);
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} failed, error: ${err.code}`);
        expect(err.code).assertEqual(401);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_UTIL_UTIL1_2050
     * @tc.name  : testDecodeToString001
     * @tc.desc  : Testing the decodeToString interface with DecodeToStringOptions{stream: false} while input value undefined.
     * @tc.size  : MediumTest
     * @tc.type  : Method
     * @tc.level : Level 1
     */
    it("testDecodeToString001", 0, () => {
      const TAG = 'testDecodeToString001';
      try {
        let decodeToStringOptions: util.DecodeToStringOptions = {
          stream: false
        }
        const that = util.TextDecoder.create('utf-8');
        let uint8 = new Uint8Array([0x61, 0x62, 0x63]);
        let retStr = that.decodeToString(uint8, decodeToStringOptions);
        console.info(`${TAG} decodeToString, retStr: ${retStr}`);
        expect(retStr).assertEqual("abc");
      } catch (err) {
        console.error(`${TAG} failed, error code: ${err.code}`);
        expect().assertFail();
      }
    });
  })
}
