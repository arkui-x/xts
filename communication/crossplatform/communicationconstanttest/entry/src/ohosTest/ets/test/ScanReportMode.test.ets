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

import bluetooth from '@ohos.bluetooth.ble';
import { describe, it, expect, TestType, Level, Size } from '@ohos/hypium';

export default function ScanReportModeTest() {
  describe('ScanReportModeTest', () => {
    /**
     * @tc.number : SUB_COMMUNICATION_BLUETOOTH_SCANREPORTTYPE_0100
     * @tc.name   : testScanReportType0001
     * @tc.desc   : Test ScanReportType
     * @tc.type   : Function
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     */
    it('testScanReportType0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let ON_FOUND = bluetooth.ScanReportType.ON_FOUND;
        console.info("[bluetooth_js]ScanReportType ON_FOUND: " + JSON.stringify(ON_FOUND));
        expect(ON_FOUND).assertEqual(1);
        let ON_LOST = bluetooth.ScanReportType.ON_LOST;
        console.info("[bluetooth_js]ScanReportType ON_LOST: " + JSON.stringify(ON_LOST));
        expect(ON_LOST).assertEqual(2);
        done();
      });

    /**
     * @tc.number : SUB_COMMUNICATION_BLUETOOTH_SCANREPORTMODE_0100
     * @tc.name   : testScanReportMode0001
     * @tc.desc   : Test ScanReportMode
     * @tc.type   : Function
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     */
    it('testScanReportMode0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let NORMAL = bluetooth.ScanReportMode.NORMAL;
        console.info("[bluetooth_js]ScanReportMode NORMAL: " + JSON.stringify(NORMAL));
        expect(NORMAL).assertEqual(1);
        let FENCE_SENSITIVITY_LOW = bluetooth.ScanReportMode.FENCE_SENSITIVITY_LOW;
        console.info("[bluetooth_js]ScanReportMode FENCE_SENSITIVITY_LOW: " + JSON.stringify(FENCE_SENSITIVITY_LOW));
        expect(FENCE_SENSITIVITY_LOW).assertEqual(10);
        let FENCE_SENSITIVITY_HIGH = bluetooth.ScanReportMode.FENCE_SENSITIVITY_HIGH;
        console.info("[bluetooth_js]ScanReportMode FENCE_SENSITIVITY_HIGH: " + JSON.stringify(FENCE_SENSITIVITY_HIGH));
        expect(FENCE_SENSITIVITY_HIGH).assertEqual(11);
        done();
      });
  });
}

