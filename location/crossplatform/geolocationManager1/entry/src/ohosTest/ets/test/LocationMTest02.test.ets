/*
 * Copyright (C) 2025 Huawei Device Co., Ltd.
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


import geolocationm from '@ohos.geoLocationManager';
import { abilityAccessCtrl, common, Permissions } from '@kit.AbilityKit';
import AtManager from '@ohos.abilityAccessCtrl';
import {describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Size, Level} from '@ohos/hypium';
import { BusinessError } from '@ohos.base';

function sleep(ms: number): Promise<void> {
    return new Promise((resolve) => {
        setTimeout(resolve, ms);
    });
}

const LOCATION_PERMISSIONS: Permissions[] = ['ohos.permission.LOCATION', 'ohos.permission.APPROXIMATELY_LOCATION', 'ohos.permission.LOCATION_IN_BACKGROUND']

function reqPermissionsFromUser(permissions: Array<Permissions>, context: common.UIAbilityContext): Promise<boolean> {
  return new Promise((resolve, reject) => {
    let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
    atManager.requestPermissionsFromUser(context, permissions)
      .then((data) => {
        let grantStatus: Array<number> = data.authResults;
        let allGranted = grantStatus.every(status => status === 0);
        if (allGranted) {
          resolve(true);
        }
      }).catch((err: BusinessError) => {
      console.error('permission has been reject, test stop');
      reject(new Error('permission denied'));
    });
  });
}

export default function geolocationTest_geo5() {
    describe('geolocationTest_geo5', () => {
        beforeAll(async (done : Function) => {
            context = getContext();
            const isAllGranted = await reqPermissionsFromUser(LOCATION_PERMISSIONS, context as common.UIAbilityContext);
            if (!isAllGranted) {
                console.error('no permission');
                throw new Error('no permission');
            }
            console.info('beforeAll case');
            await sleep(3000);
            done();
        })

        beforeEach(() => {
            console.info('beforeEach case');
        })
        afterEach(() => {
        })



        /**
        * @tc.number    : SUB_HSS_LOCATIONSYSTEM_BLUE_TOOTH_SCAN_0100
        * @tc.name      : testBlueToothScan0001
        * @tc.desc      : Test Report Fence Transition.
        * @tc.size      : MediumTest
        * @tc.type      : Function
        * @tc.level     : Level 2
        */
        it('testBlueToothScan0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
            let bluetoothScanResult = (result:geolocationm.BluetoothScanResult) => {
                console.info("[lbs_js] testBlueToothScan01 bluetoothScanResult" + JSON.stringify(result));
                expect(true).assertEqual(result.deviceId != 'NA')
                expect(true).assertEqual(result.rssi != -1)
                expect(true).assertEqual(result.data != undefined)
                expect(true).assertEqual(result.deviceName != 'NA')
                expect(true).assertEqual(result.connectable == true || result.connectable == false)
            }
            try {
                geolocationm.on('bluetoothScanResultChange', bluetoothScanResult)
            } catch(error) {
                console.info("[lbs_js] testBlueToothScan01 on err" + JSON.stringify(error));
                if (error.code == "801") {
                    expect(error.code).assertEqual("801")
                } else {
                    expect(true).assertFalse();
                }
            }
            try {
                geolocationm.off('bluetoothScanResultChange')
            } catch(error) {
                console.info("[lbs_js] testBlueToothScan01 off err" + JSON.stringify(error));
                if (error.code == "801") {
                    expect(error.code).assertEqual("801")
                } else {
                    expect(true).assertFalse();
                }
            }
            try {
                geolocationm.off('bluetoothScanResultChange', bluetoothScanResult)
            } catch(error) {
                console.info("[lbs_js] testBlueToothScan01 off err" + JSON.stringify(error));
                if (error.code == "801") {
                    expect(error.code).assertEqual("801")
                } else {
                    expect(true).assertFalse();
                }
            }
            done();
        })

        /**
        * @tc.number    : SUB_HSS_LOCATIONSYSTEM_SINGLELOC_0200
        * @tc.name      : testGetCurrentLocation0002
        * @tc.desc      : Initiate a specified single location request and set the exception location timeout interval.
        * @tc.size      : MediumTest
        * @tc.type      : Function
        * @tc.level     : Level 2
        */
        it('testGetCurrentLocation0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
            try {
                await geolocationm.getCurrentLocation().then((result) => {
                    console.info('[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_3900 promise result271 ' + JSON.stringify(result));
                }).catch((error: BusinessError) => {
                    console.info('[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_3900 promise err271:' + JSON.stringify(error));
                    expect(error.code).assertEqual(3301200);
                });
            } catch (error) {
                console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_3900 promise try err." + JSON.stringify(error));
                if (error.code == "801") {
                    expect(error.code).assertEqual("801")
                } else {
                    expect(true).assertFail();
                }
            }
            await sleep(1000);
            done();
        })

        /**
        * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GETWIFIBSSID_0300
        * @tc.name      : testGetCurrentWifiBssidForLocating0003
        * @tc.desc      : Obtain the Actual Bssid of the Wifi Network.
        * @tc.size      : MediumTest
        * @tc.type      : Function
        * @tc.level     : Level 2
        */
        it('testGetCurrentWifiBssidForLocating0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
            try {
                let mac = geolocationm.getCurrentWifiBssidForLocating();
                expect(true).assertEqual(mac != '');
            } catch(error) {
                if (error.code == 801) {
                    expect(error.code).assertEqual(801)
                } else {
                    expect(error.code).assertEqual(3301900)
                }
            }
            done();
        })

        /**
        * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_DISTANCE_BETWEEN_LOCATION_0400
        * @tc.name      : testGetDistanceBetweenLocations0004
        * @tc.desc      : Obtain the isLocationEnabled status
        * @tc.size      : MediumTest
        * @tc.type      : Function
        * @tc.level     : Level 1
        */
        it('testGetDistanceBetweenLocations0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {
            try {
                let location1 :geolocationm.Location= {"latitude": 30.12, "longitude": 120.11, "altitude": 0, "accuracy": 0,
                    "speed": 0, "timeStamp": 0, "direction": 0, "timeSinceBoot": 0, "additionSize": 0}
                let location2 :geolocationm.Location= {"latitude": 30.12, "longitude": 120.11, "altitude": 0, "accuracy": 0,
                    "speed": 0, "timeStamp": 0, "direction": 0, "timeSinceBoot": 0, "additionSize": 0}
                let distance1 = geolocationm.getDistanceBetweenLocations(location1, location2);
                expect(distance1).assertEqual(0)
            } catch(error) {
                console.error("getDistanceBetweenLocations: errCode" + error.code + ", errMessage" + error.message);
                expect(true).assertFail();
            }
            done();
        })

       /**
        * @tc.number    : SUB_HSS_LOCATIONSYSTEM_IS_POI_SERVICE_SUPPORTED_0500
        * @tc.name      : testIsPoiServiceSupported0005
        * @tc.desc      : Obtain the isLocationEnabled status
        * @tc.size      : MediumTest
        * @tc.type      : Function
        * @tc.level     : Level 1
        */
          it('testIsPoiServiceSupported0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {
              try {
                  const result = geolocationm.isLocationEnabled();
                  console.info("[lbs_js] location service is", JSON.stringify(result))
                  expect(result).assertEqual(true);
              } catch (error) {
                      console.info("[lbs_js] Capability not supported, errcode:", JSON.stringify(error.code));
                      expect(error.code).assertEqual(801 || 3301000);
              }
              done();
          })


    })
}

