/*
* Copyright (c) 2024-2025 Huawei Device Co., Ltd.
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
import bluetoothBle from '@ohos.bluetooth.ble';
import { describe, beforeAll, it, expect, TestType, Level, Size } from '@ohos/hypium'
import { BusinessError } from '@ohos.base';
import deviceInfo from '@ohos.deviceInfo';

let osFullNameInfo: string = deviceInfo.osFullName;
console.info('the deviceInfo osFullName is :' + osFullNameInfo);
let platform = osFullNameInfo.split(' ')[0];
console.info('the device platform is :' + platform)

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function onReceiveEvent(data: Array<bluetoothBle.ScanResult>) {
  console.info('BLE scan device find result = ' + JSON.stringify(data));
}

function readCcc(code: BusinessError, BLECharacteristic: bluetoothBle.BLECharacteristic) {
  if (code.code != 0) {
    return;
  }
  console.log('bluetooth characteristic uuid: ' + BLECharacteristic.characteristicUuid);
  let value = new Uint8Array(BLECharacteristic.characteristicValue);
  console.log('bluetooth characteristic value: ' + value[0] + ',' + value[1] + ',' + value[2] + ',' + value[3]);
}

function readDesc(code: BusinessError, BLEDescriptor: bluetoothBle.BLEDescriptor) {
  if (code.code != 0) {
    return;
  }
  console.info('bluetooth descriptor uuid: ' + BLEDescriptor.descriptorUuid);
  let value = new Uint8Array(BLEDescriptor.descriptorValue);
  console.info('bluetooth descriptor value: ' + value[0] + ',' + value[1] + ',' + value[2] + ',' + value[3]);
}

async function ReadCharacteristicReq(characteristicReadRequest: bluetoothBle.CharacteristicReadRequest) {
  let arrayBufferCCC = new ArrayBuffer(8);
  let cccValue = new Uint8Array(arrayBufferCCC);
  cccValue[0] = 1123;
  let gattServer = bluetoothBle.createGattServer();
  let deviceId: string = characteristicReadRequest.deviceId;
  let transId: number = characteristicReadRequest.transId;
  console.info('CharacteristicWriteRequest deviceId:' + deviceId);
  console.info('CharacteristicWriteRequest transId:' + transId);
  console.info('CharacteristicWriteRequest gattServer:' + gattServer);
  expect(true).assertEqual(characteristicReadRequest != null);
}

function WriteCharacteristicReq(characteristicWriteRequest: bluetoothBle.CharacteristicWriteRequest) {
  let gattServer = bluetoothBle.createGattServer();
  let arrayBufferCCC = new ArrayBuffer(8);
  let cccValue = new Uint8Array(arrayBufferCCC);
  let deviceId: string = characteristicWriteRequest.deviceId;
  let transId: number = characteristicWriteRequest.transId;
  let value: Uint8Array = new Uint8Array(characteristicWriteRequest.value);
  let characteristicUuid: string = characteristicWriteRequest.characteristicUuid;
  let serviceUuid: string = characteristicWriteRequest.serviceUuid;
  console.info('CharacteristicWriteRequest deviceId:' + deviceId);
  console.info('CharacteristicWriteRequest transId:' + transId);
  console.info('CharacteristicWriteRequest value:' + value);
  console.info('CharacteristicWriteRequest characteristicUuid:' + characteristicUuid);
  console.info('CharacteristicWriteRequest serviceUuid:' + serviceUuid);
  console.info('CharacteristicWriteRequest gattServer:' + gattServer);
  cccValue[0] = value[0];
  expect(true).assertEqual(characteristicWriteRequest != null);
}

function WriteDescriptorReq(DescriptorWriteRequest: bluetoothBle.DescriptorWriteRequest) {
  let gattServer: bluetoothBle.GattServer = bluetoothBle.createGattServer();
  let arrayBufferDesc = new ArrayBuffer(8);
  let descValue = new Uint8Array(arrayBufferDesc);
  let deviceId: string = DescriptorWriteRequest.deviceId;
  let transId: number = DescriptorWriteRequest.transId;
  let value: Uint8Array = new Uint8Array(DescriptorWriteRequest.value);
  let descriptorUuid: string = DescriptorWriteRequest.descriptorUuid;
  descValue[0] = value[0];
  console.info('CharacteristicWriteRequest deviceId:' + deviceId);
  console.info('CharacteristicWriteRequest transId:' + transId);
  console.info('CharacteristicWriteRequest value:' + value);
  console.info('CharacteristicWriteRequest descriptorUuid:' + descriptorUuid);
  console.info('CharacteristicWriteRequest gattServer:' + gattServer);
  expect(true).assertEqual(DescriptorWriteRequest != null);
}

function ReadDescriptorReq(descriptorReadRequest: bluetoothBle.DescriptorReadRequest) {
  let gattServer: bluetoothBle.GattServer = bluetoothBle.createGattServer();
  let arrayBufferCCC = new ArrayBuffer(8);
  let cccValue = new Uint8Array(arrayBufferCCC);
  cccValue[0] = 1011;
  let deviceId: string = descriptorReadRequest.deviceId;
  let transId: number = descriptorReadRequest.transId;
  let characteristicUuid: string = descriptorReadRequest.characteristicUuid;
  console.info('CharacteristicWriteRequest deviceId:' + deviceId);
  console.info('CharacteristicWriteRequest transId:' + transId);
  console.info('CharacteristicWriteRequest characteristicUuid:' + characteristicUuid);
  console.info('CharacteristicWriteRequest gattServer:' + gattServer);
  expect(true).assertEqual(descriptorReadRequest != null);
}

function ConnectStateChanged(state: bluetoothBle.BLEConnectionChangeState) {
  console.log('bluetooth connect state changed');
  let connectState = state.state;
  console.info('[bluetooth_js] state changed' + connectState)
  expect(true).assertEqual(connectState != null);
}

function Connected(state: bluetoothBle.BLEConnectionChangeState) {
  let deviceId = state.deviceId;
  let status = state.state;
  console.info("[bluetooth_js] connectStateChange jsondata:"
    + 'deviceId:' + deviceId + 'status:' + status);
  expect(true).assertEqual(state != null);
}

function onReceiveEvent1(data: bluetoothBle.AdvertisingStateChangeInfo) {
  console.info('bluetooth advertising state = ' + JSON.stringify(data));
}

function BluetoothState(data: btAccess.BluetoothState) {
  console.info('bluetooth state001 =' + JSON.stringify(data));
}

export default function btble() {
  let manufactureValueBuffer = new Uint8Array(4);
  manufactureValueBuffer[0] = 1;
  manufactureValueBuffer[1] = 2;
  manufactureValueBuffer[2] = 3;
  manufactureValueBuffer[3] = 4;

  let serviceValueBuffer = new Uint8Array(4);
  serviceValueBuffer[0] = 4;
  serviceValueBuffer[1] = 6;
  serviceValueBuffer[2] = 7;
  serviceValueBuffer[3] = 8;
  console.info('manufactureValueBuffer = ' + JSON.stringify(manufactureValueBuffer));
  console.info('serviceValueBuffer = ' + JSON.stringify(serviceValueBuffer));

  let setting: bluetoothBle.AdvertiseSetting = {
    connectable: true
  };

  let manufactureDataUnit: bluetoothBle.ManufactureData = {
    manufactureId: 4567,
    manufactureValue: manufactureValueBuffer.buffer
  };

  let serviceDataUnit: bluetoothBle.ServiceData = {
    serviceUuid: "00001888-0000-1000-8000-00805f9b34fb",
    serviceValue: serviceValueBuffer.buffer
  };

  let advData: bluetoothBle.AdvertiseData = {
    serviceUuids: ["00001888-0000-1000-8000-00805f9b34fb"],
    manufactureData: [manufactureDataUnit],
    serviceData: [serviceDataUnit]
  };
  let advResponse: bluetoothBle.AdvertiseData = {
    serviceUuids: ["00001888-0000-1000-8000-00805f9b34fb"],
    manufactureData: [manufactureDataUnit],
    serviceData: [serviceDataUnit]
  };

  let gattServer = bluetoothBle.createGattServer();
  console.info('bluetooth ble create gattserver result:' + gattServer);
  let gattClient: bluetoothBle.GattClientDevice;
  if (platform == "iOS") {
    gattClient = bluetoothBle.createGattClientDevice('6A385CE6-E74E-6873-F2BF-0E210EB8181D');
    console.info('bluetooth ble create gattclientdevice result:' + gattClient);
  } else {
    gattClient = bluetoothBle.createGattClientDevice('04:30:02:01:00:00');
    console.info('bluetooth ble create gattclientdevice result:' + gattClient);
  }

  describe('btble', () => {

    beforeAll(async () => {
      await sleep(3000);
      btAccess.on('stateChange', BluetoothState);
      let sta = btAccess.getState();
      if (sta != btAccess.BluetoothState.STATE_ON) {
        btAccess.enableBluetooth();
        await sleep(3000);
      }
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_0010
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_0010
     * @tc.desc   : Test bluetooth ble createGattClientDevice interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        gattClient.connect();
        await sleep(2000);
        gattClient.disconnect();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_0010]disconnect failed, code is ${err.code},message is ${err.message}`);
        expect(err.code == 2900099).assertTrue();

      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_0020
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_0020
     * @tc.desc   : Test bluetooth ble getDeviceName interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_0020', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        gattClient.getDeviceName((err, data) => {
          if (err) {
            console.error('SUB_ArkUIX_Bluetooth_Ble_0020 getRssi failed' + err);
          } else {
            console.info('[SUB_ArkUIX_Bluetooth_Ble_0020]getRssi value:' + JSON.stringify(data));
            expect(true).assertEqual(data != null);
            done();
          }
        });
        await sleep(1000);
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_0020] err, code is ${err.code},message is ${err.message}`);
        expect(err.code == 2900099).assertTrue();
        done();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_0030
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_0030
     * @tc.desc   : Test bluetooth ble getDeviceName interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_0030', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        await gattClient.getDeviceName().then((data) => {
          console.info('[SUB_ArkUIX_Bluetooth_Ble_0030] device name:' + JSON.stringify(data))
          expect(true).assertEqual(data != null);
          done();
        }).catch((err: BusinessError) => {
          console.error('[SUB_ArkUIX_Bluetooth_Ble_0030] bluetooth getDeviceName has err: ' + JSON.stringify(err));
          done();
        });
        await sleep(1000);
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_0030]GetDeviceName failed, code is ${err.code},message is ${err.message}`);
        expect(err.code).assertEqual(2900099);
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_0040
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_0040
     * @tc.desc   : Test bluetooth ble getServices interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_0040', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        gattClient.getServices((err, data) => {
          if (err) {
            console.error('getService failed' + err);
          } else {
            console.info('[SUB_ArkUIX_Bluetooth_Ble_0040]getService value:' + JSON.stringify(data));
            expect(true).assertEqual(data != null);
          }
        });
        await sleep(1000);
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_0040] failed, code is ${err.code},message is ${err.message}`);
        expect(err.code).assertEqual(2900099);
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_0050
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_0050
     * @tc.desc   : Test bluetooth ble getServices interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_0050', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        await gattClient.getServices().then((GattService) => {
          console.info('[SUB_ArkUIX_Bluetooth_Ble_0050] getServices successfully:' + JSON.stringify(GattService));
          expect(GattService).assertNull();
          done();
        })
        await sleep(1000);
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_0050] failed, code is ${err.code},message is ${err.message}`);
        expect(err.code == 2900099).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_0060
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_0060
     * @tc.desc   : Test bluetooth ble readCharacteristicValue interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_0060', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let descriptors: Array<bluetoothBle.BLEDescriptor> = [];
      let bufferDesc = new ArrayBuffer(8);
      let descV = new Uint8Array(bufferDesc);
      descV[0] = 11;
      let descriptor: bluetoothBle.BLEDescriptor = {
        serviceUuid: '00001810-0000-1000-8000-00805F9B34FB',
        characteristicUuid: '00001820-0000-1000-8000-00805F9B34FB',
        descriptorUuid: '00002903-0000-1000-8000-00805F9B34FB',
        descriptorValue: bufferDesc
      };
      descriptors[0] = descriptor;
      let bufferCCC = new ArrayBuffer(8);
      let cccV = new Uint8Array(bufferCCC);
      cccV[0] = 1;
      let characteristic: bluetoothBle.BLECharacteristic = {
        serviceUuid: '00001810-0000-1000-8000-00805F9B34FB',
        characteristicUuid: '00001820-0000-1000-8000-00805F9B34FB',
        characteristicValue: bufferCCC,
        descriptors: descriptors
      };
      try {
        gattClient.readCharacteristicValue(characteristic);
        await sleep(1000);
        done();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_0060]readDescrValue failed, code is ${err.code},message is ${err.message}`);
        expect(err.code).assertEqual('401');
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_0070
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_0070
     * @tc.desc   : Test bluetooth ble readCharacteristicValue interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_0070', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let descriptors: Array<bluetoothBle.BLEDescriptor> = [];
      let bufferDesc = new ArrayBuffer(8);
      let descV = new Uint8Array(bufferDesc);
      descV[0] = 11;
      let descriptor: bluetoothBle.BLEDescriptor = {
        serviceUuid: '00001810-0000-1000-8000-00805F9B34FB',
        characteristicUuid: '00001820-0000-1000-8000-00805F9B34FB',
        descriptorUuid: '00002903-0000-1000-8000-00805F9B34FB',
        descriptorValue: bufferDesc
      };
      descriptors[0] = descriptor;

      let bufferCCC = new ArrayBuffer(8);
      let cccV = new Uint8Array(bufferCCC);
      cccV[0] = 1;
      let characteristic: bluetoothBle.BLECharacteristic = {
        serviceUuid: '00001810-0000-1000-8000-00805F9B34FB',
        characteristicUuid: '00001820-0000-1000-8000-00805F9B34FB',
        characteristicValue: bufferCCC,
        descriptors: descriptors
      };
      try {
        gattClient.readCharacteristicValue(characteristic, readCcc);
        await sleep(1000);
        done();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_0070]readCharacteristicValue failed, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_0080
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_0080
     * @tc.desc   : Test bluetooth ble readDescriptorValue interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_0080', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let bufferDesc = new ArrayBuffer(8);
      let descV = new Uint8Array(bufferDesc);
      descV[0] = 11;
      let descriptor: bluetoothBle.BLEDescriptor = {
        serviceUuid: '00001810-0000-1000-8000-00805F9B34FB',
        characteristicUuid: '00001820-0000-1000-8000-00805F9B34FB',
        descriptorUuid: '00002903-0000-1000-8000-00805F9B34FB',
        descriptorValue: bufferDesc
      };
      try {
        gattClient.readDescriptorValue(descriptor);
        await sleep(1000);
        done();
      } catch (err) {
        console.error("SUB_ArkUIX_Bluetooth_Ble_0080 errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code == 401).assertTrue();
        done();
      }
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_0090
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_0090
     * @tc.desc   : Test bluetooth ble readDescriptorValue interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_0090', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let bufferDesc = new ArrayBuffer(8);
      let descV = new Uint8Array(bufferDesc);
      descV[0] = 11;
      let descriptor: bluetoothBle.BLEDescriptor = {
        serviceUuid: '00001810-0000-1000-8000-00805F9B34FB',
        characteristicUuid: '00001820-0000-1000-8000-00805F9B34FB',
        descriptorUuid: '00002903-0000-1000-8000-00805F9B34FB',
        descriptorValue: bufferDesc
      };
      try {
        gattClient.readDescriptorValue(descriptor, readDesc);
        await sleep(1000);
        done();
      } catch (err) {
        console.error("SUB_ArkUIX_Bluetooth_Ble_0090 errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code == 401).assertTrue();
        done();
      }
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00100
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00100
     * @tc.desc   : Test bluetooth ble writeCharacteristicValue interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let descriptors: Array<bluetoothBle.BLEDescriptor> = [];
      let bufferDesc = new ArrayBuffer(8);
      let descV = new Uint8Array(bufferDesc);
      descV[0] = 11;
      let descriptor: bluetoothBle.BLEDescriptor = {
        serviceUuid: '00001810-0000-1000-8000-00805F9B34FB',
        characteristicUuid: '00001820-0000-1000-8000-00805F9B34FB',
        descriptorUuid: '00002903-0000-1000-8000-00805F9B34FB',
        descriptorValue: bufferDesc
      };
      descriptors[0] = descriptor;
      let bufferCCC = new ArrayBuffer(8);
      let cccV = new Uint8Array(bufferCCC);
      cccV[0] = 1;
      let characteristic: bluetoothBle.BLECharacteristic = {
        serviceUuid: '00001810-0000-1000-8000-00805F9B34FB',
        characteristicUuid: '00001820-0000-1000-8000-00805F9B34FB',
        characteristicValue: bufferCCC,
        descriptors: descriptors
      };

      try {
        gattClient.writeCharacteristicValue(characteristic, bluetoothBle.GattWriteType.WRITE, (err, data) => {
          if (err) {
            console.info('wrCharacteristicVal failed' + err);
          } else {
            console.info('[SUB_ArkUIX_Bluetooth_Ble_00100]wrCharacteristicVal value:' + JSON.stringify(data));
            expect(true).assertEqual(data != null);
          }
        });
        await sleep(1000);
      } catch (err) {
        console.error('SUB_ArkUIX_Bluetooth_Ble_00100 errCode: ' + (err as BusinessError).code + ', errMessage: ' +
        (err as BusinessError).message);
        expect(err.code == 401).assertTrue();
        done();
      }
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00110
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00110
     * @tc.desc   : Test bluetooth ble writeCharacteristicValue interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00110', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let descriptors: Array<bluetoothBle.BLEDescriptor> = [];
      let bufferDesc = new ArrayBuffer(8);
      let descV = new Uint8Array(bufferDesc);
      descV[0] = 11;
      let descriptor: bluetoothBle.BLEDescriptor = {
        serviceUuid: '00001810-0000-1000-8000-00805F9B34FB',
        characteristicUuid: '00001820-0000-1000-8000-00805F9B34FB',
        descriptorUuid: '00002903-0000-1000-8000-00805F9B34FB',
        descriptorValue: bufferDesc
      };
      descriptors[0] = descriptor;

      let bufferCCC = new ArrayBuffer(8);
      let cccV = new Uint8Array(bufferCCC);
      cccV[0] = 1;
      await sleep(1000);
      let characteristic: bluetoothBle.BLECharacteristic = {
        serviceUuid: '00001810-0000-1000-8000-00805F9B34FB',
        characteristicUuid: '00001820-0000-1000-8000-00805F9B34FB',
        characteristicValue: bufferCCC,
        descriptors: descriptors
      };

      try {
        gattClient.writeCharacteristicValue(characteristic, bluetoothBle.GattWriteType.WRITE_NO_RESPONSE).then(() => {
          console.info("SUB_ArkUIX_Bluetooth_Ble_00110 writeCharacteristicValue");
          done();
        }, (err: BusinessError) => {
          console.error("SUB_ArkUIX_Bluetooth_Ble_00110 :errCode" + err.code + ",errMessage:" + err.message);
          done();
        });
        await sleep(1000);
      } catch (err) {
        console.error('SUB_ArkUIX_Bluetooth_Ble_00110 errCode: ' + (err as BusinessError).code + ', errMessage: ' +
        (err as BusinessError).message);
        expect(err.code == 401).assertTrue();
        done();
      }
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00120
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00120
     * @tc.desc   : Test bluetooth ble writeDescriptorValue interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00120', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      let bufferDesc = new ArrayBuffer(8);
      let descV = new Uint8Array(bufferDesc);
      descV[0] = 22;
      let descriptor: bluetoothBle.BLEDescriptor = {
        serviceUuid: '00001810-0000-1000-8000-00805F9B34FB',
        characteristicUuid: '00001820-0000-1000-8000-00805F9B34FB',
        descriptorUuid: '00002903-0000-1000-8000-00805F9B34FB',
        descriptorValue: bufferDesc
      };
      try {
        gattClient.writeDescriptorValue(descriptor).then(() => {
          console.info("writeDescriptorValue");
          done();
        }, (err: BusinessError) => {
          console.error("SUB_ArkUIX_Bluetooth_Ble_00120 :errCode" + err.code + ",errMessage:" + err.message);
          done();
        });
        await sleep(1000);
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00120]writeDescriptorValue failed, code is ${err.code},
            message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00130
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00130
     * @tc.desc   : Test bluetooth ble writeDescriptorValue interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00130', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      let bufferDesc = new ArrayBuffer(8);
      let descV = new Uint8Array(bufferDesc);
      descV[0] = 22;
      let descriptor: bluetoothBle.BLEDescriptor = {
        serviceUuid: '00001810-0000-1000-8000-00805F9B34FB',
        characteristicUuid: '00001820-0000-1000-8000-00805F9B34FB',
        descriptorUuid: '00002903-0000-1000-8000-00805F9B34FB',
        descriptorValue: bufferDesc
      };
      try {
        gattClient.writeDescriptorValue(descriptor, (err, data) => {
          if (err) {
            console.error('Descriptor failed' + err);
          } else {
            console.info('[SUB_ArkUIX_Bluetooth_Ble_00130]Descriptor value:' + JSON.stringify(data));
            expect(true).assertEqual(data != null);
          }
        });
        await sleep(1000);
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00130]writeDescriptorValue failed, code is ${err.code},
            message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00140
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00140
     * @tc.desc   : Test bluetooth ble setBLEMtuSize interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00140', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        gattClient.setBLEMtuSize(500);
        console.info("[SUB_ArkUIX_Bluetooth_Ble_00140]setBLEMtuSize success");
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00140]MtuSize failed, code is ${err.code},message is ${err.message}`);
        expect(err.code == 2900099).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00150
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00150
     * @tc.desc   : Test bluetooth ble on('BLEConnectionStateChange') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00150', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        gattClient.on('BLEConnectionStateChange', ConnectStateChanged);
        await sleep(1000);
        gattClient.off("BLEConnectionStateChange");
        done();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00150]GattConnect failed, code is ${err.code},message is ${err.message}`);
        expect(err.code == 2900099).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00160
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00160
     * @tc.desc   : Test bluetooth ble on('BLEMtuChange') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00160', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        gattClient.on('BLEMtuChange', (mtu: number) => {
          console.info('SUB_ArkUIX_Bluetooth_Ble_00160 BLEMtuChange, mtu: ' + mtu);
        });
        await sleep(1000);
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Ble_00160 mtu errCode:" + err.code + ", errMessage:" + err.message);
        expect(err.code == 2900099).assertTrue();
      }
      gattClient.off('BLEMtuChange');
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00170
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00170
     * @tc.desc   : Test bluetooth ble on('BLEMtuChange') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00170', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      gattClient.on('BLEMtuChange', (mtu: number) => {
        console.info('BLEMtuChange, mtu: ' + mtu);
      });
      await sleep(1000);
      try {
        gattClient.off('BLEMtuChange');
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Ble_00170 mtu errCode:" + err.code + ", errMessage:" + err.message);
        expect(err.code == 2900099).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00180
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00180
     * @tc.desc   : Test bluetooth ble getConnectedBLEDevices interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00180', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        let result = bluetoothBle.getConnectedBLEDevices();
        await sleep(1000);
        console.info("[SUB_ArkUIX_Bluetooth_Ble_00180] getConnDev:" + JSON.stringify(result)
          + "length:" + result.length);
        expect(result != null).assertTrue();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00180]getConnDev failed, code is ${err.code},message is ${err.message}`);
        expect(err.code == 2900099).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00190
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00190
     * @tc.desc   : Test bluetooth ble addService interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00190', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      let descriptors: Array<bluetoothBle.BLEDescriptor> = [];
      let arrayBuffer = new ArrayBuffer(8);
      let descV = new Uint8Array(arrayBuffer);
      descV[0] = 11;
      let descriptor: bluetoothBle.BLEDescriptor = {
        serviceUuid: '00001810-0000-1000-8000-00805F9B34FB',
        characteristicUuid: '00001820-0000-1000-8000-00805F9B34FB',
        descriptorUuid: '00002902-0000-1000-8000-00805F9B34FB',
        descriptorValue: arrayBuffer
      };
      descriptors[0] = descriptor;
      let characteristics: Array<bluetoothBle.BLECharacteristic> = [];
      let arrayBufferC = new ArrayBuffer(8);
      let cccV = new Uint8Array(arrayBufferC);
      cccV[0] = 1;
      let characteristic: bluetoothBle.BLECharacteristic = {
        serviceUuid: '00001810-0000-1000-8000-00805F9B34FB',
        characteristicUuid: '00001820-0000-1000-8000-00805F9B34FB',
        characteristicValue: arrayBufferC,
        descriptors: descriptors
      };
      characteristics[0] = characteristic;
      let gattService: bluetoothBle.GattService = {
        serviceUuid: '00001810-0000-1000-8000-00805F9B34FB',
        isPrimary: false,
        characteristics: characteristics,
        includeServices: []
      };
      try {
        await sleep(2000);
        gattServer.addService(gattService);
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00190] failed, code is ${err.code},message is ${err.message}`);
        expect(err.code == 2900099).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00200
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00200
     * @tc.desc   : Test bluetooth ble removeService interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        gattServer.removeService('00001810-0000-1000-8000-00805F9B34FB');
        await sleep(2000);
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00200] failed, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00210
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00210
     * @tc.desc   : Test bluetooth ble on("BLEDeviceFind") interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00210', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        bluetoothBle.on("BLEDeviceFind", onReceiveEvent);
        bluetoothBle.startBLEScan(
          [{
            deviceId: "00:11:22:33:44:55",
            name: "test",
            serviceUuid: "00001888-0000-1000-8000-00805f9b34fb"
          }],
          {
            interval: 500,
            dutyMode: bluetoothBle.ScanDuty.SCAN_MODE_LOW_POWER,
            phyType: bluetoothBle.PhyType.PHY_LE_1M
          }
        );
        await sleep(1000);
      } catch (err) {
        console.error("SUB_ArkUIX_Bluetooth_Ble_00210 errCode:" + err.code + ",errMessage:" + err.message);
        if (platform = 'iOS') {
          expect(err.code == 401).assertTrue();
        }
      }
      bluetoothBle.off("BLEDeviceFind", onReceiveEvent);
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00220
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00220
     * @tc.desc   : Test bluetooth ble on("characteristicWrite") interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00220', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        gattServer.on("characteristicWrite", WriteCharacteristicReq);
        await sleep(1000);
        gattServer.off("characteristicWrite");
        done();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00220] failed, code is ${err.code},message is ${err.message}`);
        expect(err.code == 2900099).assertTrue();

        done();
      }
    })

    /**
     * @tc.number :SUB_ArkUIX_Bluetooth_Ble_00230
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00230
     * @tc.desc   : Test bluetooth ble on("characteristicRead") interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00230', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        await gattServer.on("characteristicRead", ReadCharacteristicReq);
        await sleep(1000);
        done();
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Ble_00230 errCode:" + err.code + ",errMessage:" + err.message);
        expect(err.code == 2900099).assertTrue();
      }
      gattServer.off("characteristicRead");
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00240
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00240
     * @tc.desc   : Test bluetooth ble on("descriptorRead") interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00240', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        await gattServer.on("descriptorRead", ReadDescriptorReq);
        await gattServer.off("descriptorRead");
        done();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00240] failed, code is ${err.code},message is ${err.message}`);
        expect(err.code == 2900099).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00250
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00250
     * @tc.desc   : Test bluetooth ble on("descriptorWrite") interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00250', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      if (platform == "iOS") {
        done();
        return;
      }
      try {
        gattServer.on("descriptorWrite", WriteDescriptorReq);
        await sleep(1000);
        gattServer.off("descriptorWrite");
        done();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00250] failed, code is ${err.code}, message is ${err.message}`);
        expect(err.code == 2900099).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00260
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00260
     * @tc.desc   : Test bluetooth ble on("connectionStateChange") interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00260', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      try {
        gattServer.on("connectionStateChange", Connected);
        await sleep(1000);
        gattServer.off("connectionStateChange");
        done();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00260] failed, code is ${err.code},message is ${err.message}`);
        expect(err.code == 2900099).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00270
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00270
     * @tc.desc   : Test bluetooth ble startAdvertising stopAdvertising Promise interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00270', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let advertisingParams: bluetoothBle.AdvertisingParams = {
        advertisingSettings: setting,
        advertisingData: advData,
        advertisingResponse: advResponse,
      }
      let advHandle = 0xFF;
      try {
        bluetoothBle.startAdvertising(advertisingParams).then((outAdvHandle) => {
          console.info('[SUB_ArkUIX_Bluetooth_Ble_00270]startAdvertising promise info03:' +
          JSON.stringify(outAdvHandle));
          advHandle = outAdvHandle;
          console.info('[SUB_ArkUIX_Bluetooth_Ble_00270]startAdvertising promise info03:' + JSON.stringify(advHandle));
          expect(advHandle != null).assertTrue();
        });
        await sleep(1000);
        await bluetoothBle.stopAdvertising(advHandle).then((data) => {
          console.info('[SUB_ArkUIX_Bluetooth_Ble_00270] stopAdvertising promise result03:' + JSON.stringify(data));
        });
        done();
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Ble_00270 errCode:" + err.code + ",03errMessage:" + err.message);
        expect().assertFail();
      }
      await sleep(2000);
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00280
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00280
     * @tc.desc   : Test bluetooth ble startAdvertising stopAdvertising Callback interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00280', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let advertisingParams: bluetoothBle.AdvertisingParams = {
        advertisingSettings: setting,
        advertisingData: advData,
        advertisingResponse: advResponse,
      }
      let advHandle = 0xFF;
      try {
        bluetoothBle.startAdvertising(advertisingParams, (err, outAdvHandle) => {
          if (err) {
            console.info('SUB_ArkUIX_Bluetooth_Ble_00280 startAdvertising callback failed' + err);
          } else {
            console.info('[SUB_ArkUIX_Bluetooth_Ble_00280]startAdvertising callback info01:' +
            JSON.stringify(outAdvHandle));
            advHandle = outAdvHandle;
            console.info('[SUB_ArkUIX_Bluetooth_Ble_00280]startAdvertising callback info01:' +
            JSON.stringify(advHandle));
            expect(advHandle != null).assertTrue();
          }
        });
        await sleep(1000);
        bluetoothBle.stopAdvertising(advHandle, (err, data) => {
          if (err) {
            console.info('SUB_ArkUIX_Bluetooth_Ble_00280 stopAdvertising callback failed' + JSON.stringify(err));
          } else {
            console.info('[SUB_ArkUIX_Bluetooth_Ble_00280]stopAdvertising callback info02:' + JSON.stringify(data));
          }
        });
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Ble_00280 errCode:" + err.code + ",04errMessage:" + err.message);
        expect(err.code == 401).assertTrue();
      }
      await sleep(2000);
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00290
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00290
     * @tc.desc   : Test bluetooth ble on('advertisingStateChange') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00290', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let advertisingParams: bluetoothBle.AdvertisingParams = {
        advertisingSettings: setting,
        advertisingData: advData,
        advertisingResponse: advResponse,
      }
      let advHandle = 0xFF;
      try {
        bluetoothBle.on('advertisingStateChange', onReceiveEvent1);
        bluetoothBle.startAdvertising(advertisingParams).then((outAdvHandle) => {
          console.info('[SUB_ArkUIX_Bluetooth_Ble_00290]startAdvertising promise info03:' +
          JSON.stringify(outAdvHandle));
          advHandle = outAdvHandle;
          console.info('[SUB_ArkUIX_Bluetooth_Ble_00290]startAdvertising promise info03:' + JSON.stringify(advHandle));
          expect(advHandle != null).assertTrue();
        });
        await sleep(1000);
        await bluetoothBle.stopAdvertising(advHandle).then((data) => {
          console.info('[SUB_ArkUIX_Bluetooth_Ble_00290] stopAdvertising promise result03:' + JSON.stringify(data));
        });
        done();
      } catch (err) {
        console.info("SUB_ArkUIX_Bluetooth_Ble_00290 errCode:" + err.code + ",03errMessage:" + err.message);
        expect().assertFail();
      }
      bluetoothBle.off('advertisingStateChange', onReceiveEvent1);
      await sleep(2000);
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00300
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00300
     * @tc.desc   : Test bluetooth ble createGattClientDevice interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattClient = bluetoothBle.createGattClientDevice(undefined);
        gattClient.connect();
        await sleep(2000);
        gattClient.disconnect();
        console.info("SUB_ArkUIX_Bluetooth_Ble_00300 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00300] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00310
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00310
     * @tc.desc   : Test bluetooth ble createGattClientDevice interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00310', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattClient = bluetoothBle.createGattClientDevice(null);
        gattClient.connect();
        await sleep(2000);
        gattClient.disconnect();
        console.info("SUB_ArkUIX_Bluetooth_Ble_00310 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00310] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00320
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00320
     * @tc.desc   : Test bluetooth Ble on('BLEMtuChange') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00320', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattClient.on(undefined, (mtu: number) => {
          console.info('BLEMtuChange, mtu: ' + mtu);
        });
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00320 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00320] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00330
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00330
     * @tc.desc   : Test bluetooth Ble on('BLEMtuChange') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00330', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattClient.on(null, (mtu: number) => {
          console.info('BLEMtuChange, mtu: ' + mtu);
        });
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00330 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00330] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00340
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00340
     * @tc.desc   : Test bluetooth Ble on('BLEMtuChange') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00340', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattClient.on(null, (mtu: number) => {
          console.info('BLEMtuChange, mtu: ' + mtu);
        });
        await sleep(1000);
        gattClient.off('BLEMtuChange');
        console.info("SUB_ArkUIX_Bluetooth_Ble_00340 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00340] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00350
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00350
     * @tc.desc   : Test bluetooth Ble off('BLEMtuChange') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00350', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattClient.on(undefined, (mtu: number) => {
          console.info('BLEMtuChange, mtu: ' + mtu);
        });
        await sleep(1000);
        gattClient.off('BLEMtuChange');
        console.info("SUB_ArkUIX_Bluetooth_Ble_00350 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00350] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00360
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00360
     * @tc.desc   : Test bluetooth Ble on('BLEDeviceFind') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00360', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        bluetoothBle.on(undefined, onReceiveEvent);
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00360 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00360] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00370
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00370
     * @tc.desc   : Test bluetooth Ble on('BLEDeviceFind') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00370', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        bluetoothBle.on(null, onReceiveEvent);
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00370 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00370] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00380
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00380
     * @tc.desc   : Test bluetooth Ble off('BLEDeviceFind') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00380', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        bluetoothBle.on(null, onReceiveEvent);
        await sleep(1000);
        bluetoothBle.off(null, onReceiveEvent);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00380 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00380] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00390
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00390
     * @tc.desc   : Test bluetooth Ble off('BLEDeviceFind') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00390', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        bluetoothBle.on(undefined, onReceiveEvent);
        await sleep(1000);
        bluetoothBle.off(undefined, onReceiveEvent);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00390 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00390] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00400
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00400
     * @tc.desc   : Test bluetooth Ble on('BLEConnectionStateChange') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattClient.on(null, ConnectStateChanged);
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00400 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00400] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00410
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00410
     * @tc.desc   : Test bluetooth Ble on('BLEConnectionStateChange') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00410', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattClient.on(undefined, ConnectStateChanged);
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00410 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00410] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00420
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00420
     * @tc.desc   : Test bluetooth Ble off('BLEConnectionStateChange') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00420', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattClient.on(undefined, ConnectStateChanged);
        await sleep(1000);
        gattClient.off("BLEConnectionStateChange");
        console.info("SUB_ArkUIX_Bluetooth_Ble_00420 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00420] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00430
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00430
     * @tc.desc   : Test bluetooth Ble off('BLEConnectionStateChange') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00430', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattClient.on(null, ConnectStateChanged);
        await sleep(1000);
        gattClient.off("BLEConnectionStateChange");
        console.info("SUB_ArkUIX_Bluetooth_Ble_00430 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00430] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00440
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00440
     * @tc.desc   : Test bluetooth Ble on('characteristicWrite') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00440', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattServer.on(undefined, WriteCharacteristicReq);
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00440 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00440] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00450
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00450
     * @tc.desc   : Test bluetooth Ble on('characteristicWrite') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00450', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattServer.on(null, WriteCharacteristicReq);
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00450 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00450] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00460
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00460
     * @tc.desc   : Test bluetooth Ble off('characteristicWrite') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00460', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattServer.on(undefined, WriteCharacteristicReq);
        await sleep(1000);
        await gattServer.off(undefined);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00460 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00460] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00470
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00470
     * @tc.desc   : Test bluetooth Ble off('characteristicWrite') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00470', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattServer.on(null, WriteCharacteristicReq);
        await sleep(1000);
        await gattServer.off(null);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00470 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00470] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00480
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00480
     * @tc.desc   : Test bluetooth Ble on('characteristicRead') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00480', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await gattServer.on(undefined, ReadCharacteristicReq);
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00480 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00480] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00490
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00490
     * @tc.desc   : Test bluetooth Ble on('characteristicRead') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00490', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await gattServer.on(null, ReadCharacteristicReq);
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00490 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00490]disconnect pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00500
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00500
     * @tc.desc   : Test bluetooth Ble off('characteristicRead') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await gattServer.on(null, ReadCharacteristicReq);
        await sleep(1000);
        await gattServer.off(null);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00500 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00500] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00510
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00510
     * @tc.desc   : Test bluetooth Ble off('characteristicRead') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00510', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await gattServer.on(undefined, ReadCharacteristicReq);
        await sleep(1000);
        await gattServer.off(undefined);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00510 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00510] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00520
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00520
     * @tc.desc   : Test bluetooth Ble on('descriptorRead') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00520', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await gattServer.on(undefined, ReadDescriptorReq);
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00520 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00520] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00530
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00530
     * @tc.desc   : Test bluetooth Ble on('descriptorRead') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00530', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await gattServer.on(null, ReadDescriptorReq);
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00530 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00530] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00540
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00540
     * @tc.desc   : Test bluetooth Ble off('descriptorRead') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00540', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await gattServer.on(undefined, ReadDescriptorReq);
        await sleep(1000);
        await gattServer.off(undefined);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00540 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00540] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00550
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00550
     * @tc.desc   : Test bluetooth Ble off('descriptorRead') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00550', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await gattServer.on(null, ReadDescriptorReq);
        await sleep(1000);
        await gattServer.off(null);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00550 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00550] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00560
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00560
     * @tc.desc   : Test bluetooth Ble on('descriptorWrite') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00560', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattServer.on(null, WriteDescriptorReq);
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00560 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00560] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00570
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00570
     * @tc.desc   : Test bluetooth Ble on('descriptorWrite') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00570', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattServer.on(undefined, WriteDescriptorReq);
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00570 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00570] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00580
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00580
     * @tc.desc   : Test bluetooth Ble off('descriptorWrite') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00580', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattServer.on(undefined, WriteDescriptorReq);
        await sleep(1000);
        gattServer.off(undefined);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00580 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00580] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00590
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00590
     * @tc.desc   : Test bluetooth Ble off('descriptorWrite') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00590', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattServer.on(null, WriteDescriptorReq);
        await sleep(1000);
        gattServer.off(null);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00590 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00590] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00600
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00600
     * @tc.desc   : Test bluetooth Ble on('connectionStateChange') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattServer.on(null, Connected);
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00600 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00600] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00610
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00610
     * @tc.desc   : Test bluetooth Ble on('connectionStateChange') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00610', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattServer.on(undefined, Connected);
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00610 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00610] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00620
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00620
     * @tc.desc   : Test bluetooth Ble off('connectionStateChange') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00620', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattServer.on(undefined, Connected);
        await sleep(1000);
        gattServer.off(undefined);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00620 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00620] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00630
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00630
     * @tc.desc   : Test bluetooth Ble off('connectionStateChange') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00630', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattServer.on(null, Connected);
        await sleep(1000);
        gattServer.off(null);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00630 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00630] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00640
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00640
     * @tc.desc   : Test bluetooth Ble on('advertisingStateChange') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00640', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        bluetoothBle.on(null, onReceiveEvent1);
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00640 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00640] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00650
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00650
     * @tc.desc   : Test bluetooth Ble on('advertisingStateChange') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00650', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {

        bluetoothBle.on(undefined, onReceiveEvent1);
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00650 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00650] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00660
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00660
     * @tc.desc   : Test bluetooth Ble off('advertisingStateChange') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00660', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        bluetoothBle.on(undefined, onReceiveEvent1);
        await sleep(1000);
        bluetoothBle.off(undefined, onReceiveEvent1);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00660 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00660] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00670
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00670
     * @tc.desc   : Test bluetooth Ble off('advertisingStateChange') interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00670', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        bluetoothBle.on(null, onReceiveEvent1);
        await sleep(1000);
        bluetoothBle.off(null, onReceiveEvent1);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00670 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00670] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00680
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00680
     * @tc.desc   : Test bluetooth Ble startAdvertising interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00680', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        bluetoothBle.startAdvertising(null).then((data) => {
          console.info('[SUB_ArkUIX_Bluetooth_Ble_00680]startAdvertising promise fail');
        });
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00680 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00680] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00690
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00690
     * @tc.desc   : Test bluetooth Ble startAdvertising interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00690', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        bluetoothBle.startAdvertising(undefined).then((data) => {
          console.info('[SUB_ArkUIX_Bluetooth_Ble_00690]startAdvertising promise fail');
        });
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00690 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00690] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00700
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00700
     * @tc.desc   : Test bluetooth Ble startAdvertising interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        bluetoothBle.startAdvertising(setting, advData, null);
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00700 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00700] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00710
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00710
     * @tc.desc   : Test bluetooth Ble stopAdvertising interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00710', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await bluetoothBle.stopAdvertising(undefined).then((data) => {
          console.info('[SUB_ArkUIX_Bluetooth_Ble_00710] stopAdvertising promise fail');
        });
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00710 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00710] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00720
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00720
     * @tc.desc   : Test bluetooth Ble stopAdvertising interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00720', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await bluetoothBle.stopAdvertising(null).then((data) => {
          console.info('[SUB_ArkUIX_Bluetooth_Ble_00720] stopAdvertising promise fail');
        });
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00720 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00720] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00730
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00730
     * @tc.desc   : Test bluetooth Ble stopAdvertising interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00730', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        await bluetoothBle.stopAdvertising(88).then((data) => {
          console.info('[SUB_ArkUIX_Bluetooth_Ble_00730] stopAdvertising promise fail');
        });
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00730 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00730] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00740
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00740
     * @tc.desc   : Test bluetooth Ble setBLEMtuSize interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00740', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattClient.setBLEMtuSize(undefined);
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00740 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00740] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00750
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00750
     * @tc.desc   : Test bluetooth Ble setBLEMtuSize interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00750', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattClient.setBLEMtuSize(null);
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00750 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00750] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 401).assertTrue();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Bluetooth_Ble_00760
     * @tc.name   : SUB_ArkUIX_Bluetooth_Ble_00760
     * @tc.desc   : Test bluetooth Ble setBLEMtuSize interface
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Bluetooth_Ble_00760', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        gattClient.setBLEMtuSize(1000);
        console.info("[SUB_ArkUIX_Bluetooth_Ble_00760]setBLEMtuSize fail");
        await sleep(1000);
        console.info("SUB_ArkUIX_Bluetooth_Ble_00760 fail");
        expect().assertFail();
      } catch (err) {
        console.error(`[SUB_ArkUIX_Bluetooth_Ble_00760] pass, code is ${err.code},message is ${err.message}`);
        expect(err.code == 2900099).assertTrue();
      }
      done();
    })
  })
}