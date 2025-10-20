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

export default function ScanModeTest() {
  describe('ScanModeTest', () => {
    /**
     * @tc.number : SUB_COMMUNICATION_BLUETOOTHCONNECTION_SCANMODE_0100
     * @tc.name   : testScanMode0001
     * @tc.desc   : Test ScanMode enum.
     * @tc.type   : Function
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     */
    it('testScanMode0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let SCAN_MODE_NONE = bluetooth.ScanMode.SCAN_MODE_NONE;
          console.info("[bluetooth_js]ScanMode SCAN_MODE_NONE: " + SCAN_MODE_NONE);
          expect(SCAN_MODE_NONE).assertEqual(0);
          let SCAN_MODE_CONNECTABLE = bluetooth.ScanMode.SCAN_MODE_CONNECTABLE;
          console.info("[bluetooth_js]ScanMode SCAN_MODE_CONNECTABLE: " + SCAN_MODE_CONNECTABLE);
          expect(SCAN_MODE_CONNECTABLE).assertEqual(1);
          let SCAN_MODE_CONNECTABLE_GENERAL_DISCOVERABLE =
            bluetooth.ScanMode.SCAN_MODE_CONNECTABLE_GENERAL_DISCOVERABLE;
          console.info("[bluetooth_js]ScanMode SCAN_MODE_CONNECTABLE_GENERAL_DISCOVERABLE: " +
            SCAN_MODE_CONNECTABLE_GENERAL_DISCOVERABLE);
          expect(SCAN_MODE_CONNECTABLE_GENERAL_DISCOVERABLE).assertEqual(4);
        } catch (err) {
          console.info("bluetooth a2dp CodecType errCode:" + err.code + ",bluetooth a2dp CodecType errMessage:" +
          err.message);
          expect().assertFail();
        }
        done();
      });
  });
}