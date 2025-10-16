/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file expect in compliance with the License.
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

import bluetooth from '@ohos.bluetooth.connection';
import { describe, it, expect, TestType, Level, Size } from '@ohos/hypium';

export default function UnbondCauseTest() {
  describe('UnbondCauseTest', () => {
    /**
     * @tc.number : SUB_COMMUNICATION_BLUETOOTHCONNECTION_UNBONDCAUSE_0100
     * @tc.name   : testUnbondCause0001
     * @tc.desc   : Test UnbondCause api12
     * @tc.type   : Function
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testUnbondCause0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let userRemoved = bluetooth.UnbondCause.USER_REMOVED;
          expect(userRemoved).assertEqual(0);
        } catch (err) {
          console.info("UnbondCause errCode:" + err.code + ",errMessage:" + err.message);
          expect().assertFail();
        }
        done();
      });
  });
}