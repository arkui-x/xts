/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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
import bluetooth from '@ohos.bluetooth.access';
import { describe, beforeAll, it, expect } from '@ohos/hypium'
import deviceInfo from '@ohos.deviceInfo';

let osFullNameInfo: string = deviceInfo.osFullName;
console.info('the deviceInfo osFullName is :' + osFullNameInfo);
let platform = osFullNameInfo.split(' ')[0];
console.info('the device platform is :' + platform)

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function onReceiveEvent(data: bluetooth.BluetoothState) {
  console.info('bluetooth state001 =' + JSON.stringify(data));
}

export default function btaccess() {
  describe('bluetoothaccess', () => {

    beforeAll(async () => {
      await sleep(3000);
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Access_0010
     * @tc.desc   : Test bluetooth Access enableBluetooth interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Access_0010', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      let state = bluetooth.getState();
      console.info('[SUB_ArkUIX_Bluetooth_Access_0010] bluetooth state = ' + JSON.stringify(state));
      if (state != bluetooth.BluetoothState.STATE_ON) {
        bluetooth.enableBluetooth();
        await sleep(3000);
        let openSt = bluetooth.getState();
        console.info('[SUB_ArkUIX_Bluetooth_Access_0010] bluetooth enable state =' + JSON.stringify(openSt));
        expect(openSt).assertEqual(bluetooth.BluetoothState.STATE_ON);
      } else {
        console.info('[SUB_ArkUIX_Bluetooth_Access_0010] bluetooth state is ON');
      }
      try {
        bluetooth.disableBluetooth();
        await sleep(3000);
      } catch (error) {
        console.error(`[SUB_ArkUIX_Bluetooth_Access_0010] disable StateChange error, code is ${error.code},message is ${error.message}`);
        expect(error.code).assertEqual('2900099');
      }
      let closeSt = bluetooth.getState();
      console.info('[SUB_ArkUIX_Bluetooth_Access_0010] bluetooth disable state =' + JSON.stringify(closeSt));
      expect(closeSt).assertEqual(bluetooth.BluetoothState.STATE_OFF);
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Access_0020
     * @tc.desc   : Test bluetooth Access disableBluetooth interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Access_0020', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      let state = bluetooth.getState();
      console.info('[SUB_ArkUIX_Bluetooth_Access_0020] bluetooth state = ' + JSON.stringify(state));
      if (state != bluetooth.BluetoothState.STATE_OFF) {
        bluetooth.disableBluetooth();
        await sleep(3000);
        let closeSt = bluetooth.getState();
        console.info('[SUB_ArkUIX_Bluetooth_Access_0020] bluetooth disable state =' + JSON.stringify(closeSt));
        await sleep(3000);
        expect(closeSt).assertEqual(bluetooth.BluetoothState.STATE_OFF);
      } else {
        console.info('[SUB_ArkUIX_Bluetooth_Access_0020] bluetooth state is OFF');
      }
      try {
        bluetooth.enableBluetooth();
        await sleep(3000);
      } catch (error) {
        console.error(`[SUB_ArkUIX_Bluetooth_Access_0020] enable StateChange error, code is ${error.code},message is ${error.message}`);
        expect(error.code).assertEqual('2900099');
      }
      let openSt = bluetooth.getState();
      console.info('[SUB_ArkUIX_Bluetooth_Access_0020] bluetooth enable state =' + JSON.stringify(openSt));
      expect(openSt).assertEqual(bluetooth.BluetoothState.STATE_ON);
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Access_0030
     * @tc.desc   : Test bluetooth Access on('stateChange') interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Access_0030', 0, async (done: Function) => {
      if (platform == "iOS") {
        await bluetooth.on('stateChange', onReceiveEvent);
        let state1 = bluetooth.getState();
        expect(state1).assertEqual(bluetooth.BluetoothState.STATE_ON);
        bluetooth.off('stateChange', onReceiveEvent);
        done();
        return;
      }
      try {
        await bluetooth.on('stateChange', onReceiveEvent);
        let state = bluetooth.getState();
        console.info('[SUB_ArkUIX_Bluetooth_Access_0030] get bluetooth state' + JSON.stringify(state));
        if (state != bluetooth.BluetoothState.STATE_ON) {
          bluetooth.enableBluetooth();
          await sleep(10000);
          let state1 = bluetooth.getState();
          console.info('[SUB_ArkUIX_Bluetooth_Access_0030] enable state' + JSON.stringify(state1));
          expect(state1).assertEqual(bluetooth.BluetoothState.STATE_ON);
        }
      } catch (error) {
        console.error(`[SUB_ArkUIX_Bluetooth_Access_0030]disable StateChange error, code is ${error.code},message is ${error.message}`);
        expect(error.code).assertEqual('2900099');
      }
      bluetooth.off('stateChange', onReceiveEvent);
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Access_0040
     * @tc.desc   : Test bluetooth Access getState interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Access_0040', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        await bluetooth.on('stateChange', onReceiveEvent);
        await sleep(3000);
        await bluetooth.off('stateChange', onReceiveEvent);
        let state = bluetooth.getState();
        console.info('[SUB_ArkUIX_Bluetooth_Access_0040] get bluetooth state001' + JSON.stringify(state));
        if (state != bluetooth.BluetoothState.STATE_OFF) {
          bluetooth.disableBluetooth();
          await sleep(10000);
          let state1 = bluetooth.getState();
          console.info('[SUB_ArkUIX_Bluetooth_Access_0040] disable state001 ' + JSON.stringify(state1));
          expect(state1).assertEqual(bluetooth.BluetoothState.STATE_OFF);
        }
      } catch (error) {
        console.error(`[SUB_ArkUIX_Bluetooth_Access_0040]disable StateChange error, code is ${error.code},message is ${error.message}`);
        expect(error.code).assertEqual('2900099');
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Access_0050
     * @tc.desc   : Test bluetooth Access BluetoothState interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Access_0050', 0, async (done: Function) => {
      let STATE_ON = bluetooth.BluetoothState.STATE_ON;
      console.info("[SUB_ArkUIX_Bluetooth_Access_0050]STATE_ON : " + JSON.stringify(STATE_ON));
      expect(true).assertEqual(STATE_ON == 2);
      let STATE_OFF = bluetooth.BluetoothState.STATE_OFF;
      console.info("[SUB_ArkUIX_Bluetooth_Access_0050]STATE_OFF : " + JSON.stringify(STATE_OFF));
      expect(true).assertEqual(STATE_OFF == 0);
      let STATE_TURNING_ON = bluetooth.BluetoothState.STATE_TURNING_ON;
      console.info("[SUB_ArkUIX_Bluetooth_Access_0050]STATE_TURNING_ON : " + JSON.stringify(STATE_TURNING_ON));
      expect(true).assertEqual(STATE_TURNING_ON == 1);
      let STATE_TURNING_OFF = bluetooth.BluetoothState.STATE_TURNING_OFF;
      console.info("[SUB_ArkUIX_Bluetooth_Access_0050]STATE_TURNING_OFF : " + JSON.stringify(STATE_TURNING_OFF));
      expect(true).assertEqual(STATE_TURNING_OFF == 3);
      done();
    })
  })
}