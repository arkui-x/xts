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

import bluetoothBle from '@ohos.bluetooth.ble';
import { describe, it, expect, TestType, Level, Size } from '@ohos/hypium';

export default function GattDisconnectReasonTest() {
  describe('GattDisconnectReasonTest', () => {
    /**
     * @tc.number : SUB_COMMUNICATION_BLUETOOTH_BLECONSTANT_GATTDISCONNECTREASON_0100
     * @tc.name   : testGattDisconnectReason0001
     * @tc.desc   : Test BLE Constant Api20 GattDisconnectReason
     * @tc.type   : Function
     * @tc.size   : MediumTest
     * @tc.level  : Level 0
     */
    it('testGattDisconnectReason0001',
      TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
        try {
          let CONN_TIMEOUT = bluetoothBle.GattDisconnectReason.CONN_TIMEOUT;
          console.info("CONN_TIMEOUT:" + CONN_TIMEOUT);
          expect(CONN_TIMEOUT).assertEqual(1);

          let CONN_TERMINATE_PEER_USER = bluetoothBle.GattDisconnectReason.CONN_TERMINATE_PEER_USER;
          console.info("CONN_TERMINATE_PEER_USER:" + CONN_TERMINATE_PEER_USER);
          expect(CONN_TERMINATE_PEER_USER).assertEqual(2);

          let CONN_TERMINATE_LOCAL_HOST = bluetoothBle.GattDisconnectReason.CONN_TERMINATE_LOCAL_HOST;
          console.info("CONN_TERMINATE_LOCAL_HOST:" + CONN_TERMINATE_LOCAL_HOST);
          expect(CONN_TERMINATE_LOCAL_HOST).assertEqual(3);

          let CONN_UNKNOWN = bluetoothBle.GattDisconnectReason.CONN_UNKNOWN;
          console.info("CONN_UNKNOWN:" + CONN_UNKNOWN);
          expect(CONN_UNKNOWN).assertEqual(4);
        } catch (error) {
          console.error("GattDisconnectReason get error:" + JSON.stringify(error));
          expect().assertFail();
        }
        done();
      });
  });
}