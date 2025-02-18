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
import bluetooth from '@ohos.bluetooth.connection';
import { describe, beforeAll, it, expect } from '@ohos/hypium';
import { BusinessError } from '@ohos.base';
import deviceInfo from '@ohos.deviceInfo';

let osFullNameInfo: string = deviceInfo.osFullName;
console.info('the deviceInfo osFullName is :' + osFullNameInfo);
let platform = osFullNameInfo.split(' ')[0];
console.info('the device platform is :' + platform)

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function BondStateParam(data: bluetooth.BondStateParam) {
  console.info("[bluetooth_js] bondStateChange on:" + JSON.stringify(data)
    + 'bondStateChange deviceId:' + data.deviceId + 'bondStateChange state:' + data.state + 'bondStateChange cause:' +
  data.cause);
}

function onReceiveEvent(data: Array<string>) {
  console.info('data length' + data.length);
}

export default function btConnection() {
  describe('bluetoothConnection', () => {

    beforeAll(async () => {
      await sleep(3000);
      let sta = btAccess.getState();
      if (sta != btAccess.BluetoothState.STATE_ON) {
        btAccess.enableBluetooth();
        await sleep(5000);
      }
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_0010
     * @tc.desc   : Test bluetooth Connection pairDevice interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Connection_0010', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        bluetooth.on('bondStateChange', BondStateParam);
        await bluetooth.pairDevice("11:22:55:66:33:44").then((data) => {
          console.info('SUB_ArkUIX_Bluetooth_Connection_0010 pairDevice success');
        });
        await sleep(800);
        expect(bluetooth.BondState.BOND_STATE_INVALID == 0).assertTrue();
        expect(bluetooth.BondState.BOND_STATE_BONDING == 1).assertTrue();
        expect(bluetooth.BondState.BOND_STATE_BONDED == 2).assertTrue();
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_0010 errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code).assertEqual(2900099);
      }
      bluetooth.off('bondStateChange', BondStateParam);
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_0020
     * @tc.desc   : Test bluetooth Connection on('bondStateChange') interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Connection_0020', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        bluetooth.on('bondStateChange', BondStateParam);
        bluetooth.pairDevice("11:22:55:66:33:44").then((data) => {
          console.info('SUB_ArkUIX_Bluetooth_Connection_0020 info success');
        }, (err: BusinessError) => {
          console.info('SUB_ArkUIX_Bluetooth_Connection_0020:errCode' + err.code + ', errMessage: ' + err.message);
        });
        await sleep(800);
        bluetooth.off('bondStateChange', BondStateParam);
        expect(bluetooth.BondState.BOND_STATE_INVALID == 0).assertTrue();
        expect(bluetooth.BondState.BOND_STATE_BONDING == 1).assertTrue();
        expect(bluetooth.BondState.BOND_STATE_BONDED == 2).assertTrue();
        done();
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_0020 errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code).assertEqual(2900099);
      }
      bluetooth.off('bondStateChange', BondStateParam);
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_0030
     * @tc.desc   : Test bluetooth Connection getLocalName interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Connection_0030', 0, async (done: Function) => {
      try {
        let localName = bluetooth.getLocalName();
        console.info('[SUB_ArkUIX_Bluetooth_Connection_0030] localName = ' + JSON.stringify(localName));
        expect(true).assertEqual(localName != null);
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_0030 errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code).assertEqual(2900099);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_0040
     * @tc.desc   : Test bluetooth Connection getPairedDevices interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Connection_0040', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        let ret = bluetooth.getPairedDevices();
        console.info('[SUB_ArkUIX_Bluetooth_Connection_0040] getPairedDevices ret2:' + JSON.stringify(ret));
        expect(true).assertEqual(ret.length >= 0);
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_0040 errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code).assertEqual(2900099);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_0050
     * @tc.desc   : Test bluetooth Connection getRemoteDeviceName interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Connection_0050', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        let ret = bluetooth.getRemoteDeviceName("00:00:00:00:00:00");
        console.info('[SUB_ArkUIX_Bluetooth_Connection_0050]  getRemoteDeviceName ret2:' + JSON.stringify(ret));
        expect(ret != null).assertTrue();
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_0050 errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code).assertEqual(2900099);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_0060
     * @tc.desc   : Test bluetooth Connection getRemoteDeviceName interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Connection_0060', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        let ret = bluetooth.getRemoteDeviceName(null);
        console.info('[SUB_ArkUIX_Bluetooth_Connection_0060]  getRemoteDeviceName ret2:' + JSON.stringify(ret));
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_0060 errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_0070
     * @tc.desc   : Test bluetooth Connection getRemoteDeviceName interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Connection_0070', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        let ret = bluetooth.getRemoteDeviceName(undefined);
        console.info('[SUB_ArkUIX_Bluetooth_Connection_0070] getRemoteDeviceName ret2:' + JSON.stringify(ret));
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_0070 errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_0080
     * @tc.desc   : Test bluetooth Connection getRemoteDeviceName interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Connection_0080', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        let ret = bluetooth.getRemoteDeviceName('');
        console.info('[SUB_ArkUIX_Bluetooth_Connection_0080] getRemoteDeviceName ret2:' + JSON.stringify(ret));
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_0080 errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_0090
     * @tc.desc   : Test bluetooth Connection getRemoteDeviceClass interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Connection_0090', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        let DeviceClass = bluetooth.getRemoteDeviceClass("00:00:00:00:00:00");
        console.info('[SUB_ArkUIX_Bluetooth_Connection_0090]getRemoteDeviceClass majorClass:' + DeviceClass.majorClass);
        console.info('[SUB_ArkUIX_Bluetooth_Connection_0090]getRemoteDeviceClass majorMinorClass:' +
        DeviceClass.majorMinorClass);
        console.info('[SUB_ArkUIX_Bluetooth_Connection_0090]getRemoteDeviceClass classOfDevice:' +
        DeviceClass.classOfDevice);
        expect(DeviceClass != null).assertTrue();
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_0090 errCode:" + err.code + ",errMessage:" + err.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_00100
     * @tc.desc   : Test bluetooth Connection getRemoteDeviceClass interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Connection_00100', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        let DeviceClass = bluetooth.getRemoteDeviceClass(null);
        console.info('[SUB_ArkUIX_Bluetooth_Connection_00100]getRemoteDeviceClass majorClass:' +
        DeviceClass.majorClass);
        console.info('[SUB_ArkUIX_Bluetooth_Connection_00100]getRemoteDeviceClass majorMinorClass:' +
        DeviceClass.majorMinorClass);
        console.info('[SUB_ArkUIX_Bluetooth_Connection_00100]getRemoteDeviceClass classOfDevice:' +
        DeviceClass.classOfDevice);
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_00100 errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_00110
     * @tc.desc   : Test bluetooth Connection getRemoteDeviceClass interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Connection_00110', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        let DeviceClass = bluetooth.getRemoteDeviceClass(undefined);
        console.info('[SUB_ArkUIX_Bluetooth_Connection_00110]getRemoteDeviceClass majorClass:' +
        DeviceClass.majorClass);
        console.info('[SUB_ArkUIX_Bluetooth_Connection_00110]getRemoteDeviceClass majorMinorClass:' +
        DeviceClass.majorMinorClass);
        console.info('[SUB_ArkUIX_Bluetooth_Connection_00110]getRemoteDeviceClass classOfDevice:' +
        DeviceClass.classOfDevice);

      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_00110 errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_00120
     * @tc.desc   : Test bluetooth Connection getRemoteDeviceClass interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Connection_00120', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        let DeviceClass = bluetooth.getRemoteDeviceClass('');
        console.info('[SUB_ArkUIX_Bluetooth_Connection_00120]getRemoteDeviceClass majorClass:' +
        DeviceClass.majorClass);
        console.info('[SUB_ArkUIX_Bluetooth_Connection_00120]getRemoteDeviceClass majorMinorClass:' +
        DeviceClass.majorMinorClass);
        console.info('[SUB_ArkUIX_Bluetooth_Connection_00120]getRemoteDeviceClass classOfDevice:' +
        DeviceClass.classOfDevice);

      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_00120 errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_00130
     * @tc.desc   : Test bluetooth Connection getPairState interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Connection_00130', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        let state: bluetooth.BondState = bluetooth.getPairState("00:11:22:33:44:55");
        console.log('[SUB_ArkUIX_Bluetooth_Connection_00130] getPairState: ' + state);
        expect(true).assertEqual(state == 0 || state == 1 || state == 2);
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_00130 getPairState errCode:" + err.code + ",errMessage:" +
        err.message);
        expect(err.code).assertEqual(2900099);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_00140
     * @tc.desc   : Test bluetooth Connection getPairState interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Connection_00140', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        let state: bluetooth.BondState = bluetooth.getPairState(undefined);
        console.log('[SUB_ArkUIX_Bluetooth_Connection_00140] getPairState: ' + state);
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_00140 errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_00150
     * @tc.desc   : Test bluetooth Connection getPairState interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Connection_00150', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        let state: bluetooth.BondState = bluetooth.getPairState(null);
        console.log('[SUB_ArkUIX_Bluetooth_Connection_00150] getPairState: ' + state);
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_00150 errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_00160
     * @tc.desc   : Test bluetooth Connection getPairState interface
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Connection_00160', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        let state: bluetooth.BondState = bluetooth.getPairState('');
        console.log('[SUB_ArkUIX_Bluetooth_Connection_00160] getPairState: ' + state);
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_00160 errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_00170
     * @tc.desc   : Test bluetooth Connection getBluetoothScanMode interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Connection_00170', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        let state = btAccess.getState();
        console.info('[SUB_ArkUIX_Bluetooth_Connection_00170] get bluetooth state001' + JSON.stringify(state));
        if (state == 2) {
          let oldScanMode: bluetooth.ScanMode = bluetooth.getBluetoothScanMode();
          console.info('[SUB_ArkUIX_Bluetooth_Connection_00170] oldScanMode = ' + JSON.stringify(oldScanMode));
          expect(true).assertEqual(oldScanMode == 1 || oldScanMode == 4);
          done();
        } else {
          console.info('SUB_ArkUIX_Bluetooth_Connection_00170 switch  off,state is   = ' + JSON.stringify(state));
        }

      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_00170 errCode:" + err.code + ",errMessage:" + err.message);
        expect().assertFail();
        done()
      }
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_00180
     * @tc.desc   : Test bluetooth Connection getProfileConnectionState interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Connection_00180', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        let result = bluetooth.getProfileConnectionState(parseInt('1'));
        console.info('[SUB_ArkUIX_Bluetooth_Connection_00180]  reslult = ' + JSON.stringify(result));
        expect(result).assertEqual(0);
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_00180 errCode:" + err.code + ",errMessage:" + err.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_00190
     * @tc.desc   : Test bluetooth Connection getProfileConnectionState interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Connection_00190', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        let result = bluetooth.getProfileConnectionState(parseInt('4'));
        console.info('[SUB_ArkUIX_Bluetooth_Connection_00190] reslult = ' + JSON.stringify(result));
        expect(result).assertEqual(0);
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_00190 errCode:" + err.code + ",errMessage:" + err.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_00200
     * @tc.desc   : Test bluetooth Connection getProfileConnectionState interface
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Connection_00200', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        let result = bluetooth.getProfileConnectionState(null);
        console.info('[SUB_ArkUIX_Bluetooth_Connection_00200] reslult = ' + JSON.stringify(result));
        console.info("SUB_ArkUIX_Bluetooth_Connection_00200 fail");
        expect().assertFail();
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_00200 errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_00210
     * @tc.desc   : Test bluetooth Connection getProfileConnectionState interface
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Connection_00210', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        let result = bluetooth.getProfileConnectionState(undefined);
        console.info('[SUB_ArkUIX_Bluetooth_Connection_00210] reslult = ' + JSON.stringify(result));
        console.info("SUB_ArkUIX_Bluetooth_Connection_00210 fail");
        expect().assertFail();
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_00210 errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_00220
     * @tc.desc   : Test bluetooth Connection on('bluetoothDeviceFind') interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Connection_00220', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        bluetooth.on('bluetoothDeviceFind', onReceiveEvent);
        bluetooth.startBluetoothDiscovery();
        await sleep(3000);
        bluetooth.off('bluetoothDeviceFind', onReceiveEvent);
        bluetooth.stopBluetoothDiscovery();
      } catch (error) {
        console.info(`[SUB_ArkUIX_Bluetooth_Connection_00220] error, code is ${error.code},message is ${error.message}`);
        expect(error.code).assertEqual(2900099);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_00230
     * @tc.desc   : Test bluetooth Connection isBluetoothDiscovering interface
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Connection_00230', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        let result = bluetooth.isBluetoothDiscovering();
        console.info('[SUB_ArkUIX_Bluetooth_Connection_00230] reslult = ' + JSON.stringify(result));
        expect(result != null).assertTrue();
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_00230 errCode:" + err.code + ",errMessage:" + err.message);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_00240
     * @tc.desc   : Test bluetooth Connection on('bondStateChange')  interface
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Connection_00240', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        bluetooth.on(null, BondStateParam);
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Connection_00240 fail");
        expect().assertFail();
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_00240 errCode:" + err.code + ",errMessage:" + err.message);
        console.info("SUB_ArkUIX_Bluetooth_Connection_00240 pass");
        expect(err.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_00250
     * @tc.desc   : Test bluetooth Connection on('bondStateChange') interface
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Connection_00250', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        bluetooth.on(undefined, BondStateParam);
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Connection_00250 fail");
        expect().assertFail();
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_00250 errCode:" + err.code + ",errMessage:" + err.message);
        console.info("SUB_ArkUIX_Bluetooth_Connection_00250 pass");
        expect(err.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_00260
     * @tc.desc   : Test bluetooth Connection on('bondStateChange') interface
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Connection_00260', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        bluetooth.on(undefined, BondStateParam);
        await sleep(1000);
        bluetooth.off(undefined, BondStateParam);
        console.info("SUB_ArkUIX_Bluetooth_Connection_00260 fail");
        expect().assertFail();
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_00260 errCode:" + err.code + ",errMessage:" + err.message);
        console.info("SUB_ArkUIX_Bluetooth_Connection_00260 pass");
        expect(err.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_00270
     * @tc.desc   : Test bluetooth Connection off('bondStateChange') interface
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Connection_00270', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        bluetooth.on(null, BondStateParam);
        await sleep(1000);
        bluetooth.off(null, BondStateParam);
        console.info("SUB_ArkUIX_Bluetooth_Connection_00270 fail");
        expect().assertFail();
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_00270 errCode:" + err.code + ",errMessage:" + err.message);
        console.info("SUB_ArkUIX_Bluetooth_Connection_00270 pass");
        expect(err.code).assertEqual(401);
      }
      done();
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_00280
     * @tc.desc   : Test bluetooth Connection pairDevice interface
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Connection_00280', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        await bluetooth.pairDevice(null).then(() => {
          console.info('SUB_ArkUIX_Bluetooth_Connection_00280 pairDevice fail');
        });
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Connection_00280 fail");
        expect().assertFail();
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_00280 errCode:" + err.code + ",errMessage:" + err.message);
        console.info("SUB_ArkUIX_Bluetooth_Connection_00280 pass");
        expect(err.code).assertEqual(401);
        done();
      }
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_00290
     * @tc.desc   : Test bluetooth Connection pairDevice interface
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Connection_00290', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        await bluetooth.pairDevice(undefined).then(() => {
          console.info('SUB_ArkUIX_Bluetooth_Connection_00290 pairDevice fail');
        });
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Connection_00290 fail");
        expect().assertFail();
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_00290 errCode:" + err.code + ",errMessage:" + err.message);
        console.info("SUB_ArkUIX_Bluetooth_Connection_00290 pass");
        expect(err.code).assertEqual(401);
        done();
      }
    })

    /**
     * @tc.name   : SUB_ArkUIX_Bluetooth_Connection_00300
     * @tc.desc   : Test bluetooth Connection pairDevice interface
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Connection_00300', 0, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        await bluetooth.pairDevice('').then(() => {
          console.info('SUB_ArkUIX_Bluetooth_Connection_00300 pairDevice fail');
        });
        await sleep(1000)
        console.info("SUB_ArkUIX_Bluetooth_Connection_00300 fail");
        expect().assertFail();
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Connection_00300 errCode:" + err.code + ",errMessage:" + err.message);
        console.info("SUB_ArkUIX_Bluetooth_Connection_00300 pass");
        expect(err.code).assertEqual(401);
        done();
      }
    })
  })
}
