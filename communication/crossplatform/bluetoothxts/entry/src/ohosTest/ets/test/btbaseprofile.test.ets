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

import btAccess from '@ohos.bluetooth.access';
import baseProfile from '@ohos.bluetooth.baseProfile';
import a2dp from '@ohos.bluetooth.a2dp';
import { describe, beforeAll, it, expect } from '@ohos/hypium'
import deviceInfo from '@ohos.deviceInfo';

let osFullNameInfo: string = deviceInfo.osFullName;
console.info('the deviceInfo osFullName is :' + osFullNameInfo);
let platform = osFullNameInfo.split(' ')[0];
console.info('the device platform is :' + platform)

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function onReceiveEvent(data: baseProfile.StateChangeParam) {
  console.info('a2dp state = ' + JSON.stringify(data));
}

export default function btbaseProfile() {
  let A2dpSourceProfile: a2dp.A2dpSourceProfile = a2dp.createA2dpSrcProfile();

  describe('baseProfile', () => {

    beforeAll(async () => {
      await sleep(3000);
      let sta = btAccess.getState();
      if (sta != btAccess.BluetoothState.STATE_ON) {
        btAccess.enableBluetooth();
        await sleep(3000);
      }
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_BaseProfile_0010
     * @tc.desc   : Test bluetooth BaseProfile getConnectionState interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_BaseProfile_0010', 0, async (done: Function) => {
      try {
        await sleep(3000)
        let state = A2dpSourceProfile.getConnectionState("11:22:33:AA:BB:FF");
        console.info("SUB_ArkUIX_Bluetooth_BaseProfile_0010 the connection state:" + state);
        expect(true).assertEqual(state == 0 || state == 1 || state == 2);
      } catch (err) {
        await sleep(3000)
        console.error("SUB_ArkUIX_Bluetooth_BaseProfile_0010 getConnectionState errCode:" + err.code + ",errMessage:" +
        err.message);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_BaseProfile_0020
     * @tc.desc   : Test bluetooth BaseProfile on('connectionStateChange') interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_BaseProfile_0020', 0, async (done: Function) => {
      try {
        await sleep(3000)
        A2dpSourceProfile.on('connectionStateChange', onReceiveEvent);
      } catch (err) {
        console.error("SUB_ArkUIX_Bluetooth_BaseProfile_0020 errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code).assertEqual(2900099);
      }
      A2dpSourceProfile.off('connectionStateChange', onReceiveEvent);
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_BaseProfile_0030
     * @tc.desc   : Test bluetooth BaseProfile getConnectedDevices interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_BaseProfile_0030', 0, async (done: Function) => {
      try {
        await sleep(3000)
        let devices: Array<string> = A2dpSourceProfile.getConnectedDevices();
        console.info("SUB_ArkUIX_Bluetooth_BaseProfile_0030 getConnectedDevices devices list:" + devices);
        expect(true).assertEqual(devices != null);
      } catch (err) {
        console.error("SUB_ArkUIX_Bluetooth_BaseProfile_0030 getConnectedDevices errCode:" + err.code + ",errMessage:" +
        err.message);
        expect(err.code).assertEqual(2900099);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_0040
     * @tc.desc   : Test bluetooth BaseProfile on('connectionStateChange') interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_BaseProfile_0040', 0, async (done: Function) => {
      try {
        A2dpSourceProfile.on(null, onReceiveEvent);
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_BaseProfile_0040 fail");
        expect().assertFail();
      } catch (err) {
        console.error("SUB_ArkUIX_Bluetooth_BaseProfile_0040 pass errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_0050
     * @tc.desc   : Test bluetooth BaseProfile on('connectionStateChange') interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_BaseProfile_0050', 0, async (done: Function) => {
      try {
        A2dpSourceProfile.on(undefined, onReceiveEvent);
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_BaseProfile_0050 fail");
        expect().assertFail();
      } catch (err) {
        console.error("SUB_ArkUIX_Bluetooth_BaseProfile_0050 pass errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_BaseProfile_0060
     * @tc.desc   : Test bluetooth BaseProfile off('connectionStateChange') interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_BaseProfile_0060', 0, async (done: Function) => {
      try {
        A2dpSourceProfile.on(undefined, onReceiveEvent);
        await sleep(1000);
        A2dpSourceProfile.on(null, onReceiveEvent);
        console.info("SUB_ArkUIX_Bluetooth_BaseProfile_0060 fail");
        expect().assertFail();
      } catch (err) {
        console.error("SUB_ArkUIX_Bluetooth_BaseProfile_0060 pass errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_BaseProfile_0070
     * @tc.desc   : Test bluetooth BaseProfile off('connectionStateChange') interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_BaseProfile_0070', 0, async (done: Function) => {
      try {
        A2dpSourceProfile.on(null, onReceiveEvent);
        await sleep(1000);
        A2dpSourceProfile.off(null, onReceiveEvent);
        console.info("SUB_ArkUIX_Bluetooth_BaseProfile_0070 fail");
        expect().assertFail()
      } catch (err) {
        console.error("SUB_ArkUIX_Bluetooth_BaseProfile_0070 pass errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code).assertEqual(401);
      }
      done();
    })
  })
}