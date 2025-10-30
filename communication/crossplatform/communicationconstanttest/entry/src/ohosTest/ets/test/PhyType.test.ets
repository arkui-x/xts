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
import { describe, it, expect, TestType, Level, Size, beforeAll, beforeEach, afterEach, afterAll } from '@ohos/hypium';

function sleep(ms: number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function PhyTypeTest() {
  describe('PhyTypeTest', () => {
    beforeEach(async () => {
      await sleep(100);
    })
    afterAll(async () => {
      await sleep(500);
    })
    /**
     * @tc.number : SUB_COMMUNICATION_BLUETOOTHBLE_PHYTYPE_0100
     * @tc.name   : testConstantPhyType0001
     * @tc.desc   : Test constant PhyType api12
     * @tc.type   : Function
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     */
    it('testConstantPhyType0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let PHY_LE_ALL_SUPPORTED = bluetooth.PhyType.PHY_LE_ALL_SUPPORTED;
        console.info("[bluetooth_js]PHY_LE_ALL_SUPPORTED : " + JSON.stringify(PHY_LE_ALL_SUPPORTED));
        expect(true).assertEqual(PHY_LE_ALL_SUPPORTED == 255);
        done();
      });
  });
}

