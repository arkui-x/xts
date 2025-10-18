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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, Size, TestType } from '@ohos/hypium';
import geoLocationm from '@ohos.geoLocationManager';
import { BusinessError } from '@kit.BasicServicesKit';
import { notificationManager } from '@kit.NotificationKit';

function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function geolocationNoPermissionTest() {
  describe('geolocationTest', () => {
    beforeAll(async () => {
    })
    beforeEach(async () => {
    })
    afterEach(async () => {
      await sleep(3000)
    })
    afterAll(() => {
    })

    /*
     * @tc.number:SUB_geoLocationManager_permission_test_0100
     * @tc.name: testOnLocationErrorPermission0001
     * @tc.desc:Using the geoLocationManager.off method without permission
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it('testOnLocationErrorPermission0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
      let locationError1 = (errcode:geoLocationm.LocationError) => {
        console.log('[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCATIONERROR_NOPERMISSION_0100 data:' + JSON.stringify(errcode));
        expect(true).assertEqual(errcode !=null);
      };
      try {
        geoLocationm.on('locationError', locationError1);
        expect(true).assertFail();
      } catch (error) {
        console.info("[lbs_js] on try err." + JSON.stringify(error.code));
        expect(error.code).assertEqual("201")
      }
      await sleep(1000);
      done();
    });

    /*
     * @tc.number:SUB_geoLocationManager_permission_test_0200
     * @tc.name: testOnLocationErrorPermission0002
     * @tc.desc:Using the geoLocationManager.off method without permission
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it('testOnLocationErrorPermission0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) =>{
      let requestInfo:geoLocationm.LocationRequest = {'priority': 0x200,
        'scenario': 0x300, 'timeInterval': 1, 'distanceInterval': 0, 'maxAccuracy': 0};
      let locationChange = (location: geoLocationm.Location):void => {
        console.info('locationChange: data: ' + JSON.stringify(location));
        expect(true).assertEqual(locationChange != null);
      };
      try {
        geoLocationm.on('locationChange', requestInfo, locationChange);
        expect(true).assertFail();
      } catch (error){
        console.info("[lbs_js] locationChangerOn292 try err." + JSON.stringify(error));
        expect(error.code).assertEqual("201")
      }
      await sleep(1000);
      done();
    });

    /*
     * @tc.number:SUB_geoLocationManager_permission_test_0300
     * @tc.name: testGetCurrentLocationPermission0003
     * @tc.desc:Using the geoLocationManager.off method without permission
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it('testGetCurrentLocationPermission0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
      try {
        await geoLocationm.getCurrentLocation().then((result) => {
          console.info('[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_err00 promise result271 ' + JSON.stringify(result));
          expect(true).assertFail();
        }).catch((error: BusinessError) => {
          console.info('[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_err00 promise err271:' + JSON.stringify(error));
          console.info("error类型",typeof error.code);
          expect(error.code).assertEqual(201);
        });
      } catch (error) {
        console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_err00 promise try err." + JSON.stringify(error));
        console.info("error类型",typeof error.code);
        expect(error.code).assertEqual(201)
      }
      await sleep(1000);
      done();
    });

    /*
     * @tc.number:SUB_geoLocationManager_permission_test_0400
     * @tc.name: testGetCurrentLocationPermission0004
     * @tc.desc:Using the geoLocationManager.off method without permission
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it('testGetCurrentLocationPermission0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
      let currentLocationRequest: geoLocationm.CurrentLocationRequest = { "priority": geoLocationm.LocationRequestPriority.UNSET, "scenario": geoLocationm.LocationRequestScenario.NAVIGATION, "timeoutMs": 1000, "maxAccuracy": 10 };
      try {
        await geoLocationm.getCurrentLocation(currentLocationRequest, (err, result) => {
          if (err) {
            console.info("[lbs_js] getCurrentLocation15 callback err:  " + JSON.stringify(err));
            expect(err.code).assertEqual(201);
            console.info('[lbs_js] getCurrentLocationCallback reject after');
            done();
          } else {
            console.info("[lbs_js] getCurrentLocation15 callback result:" + JSON.stringify(result));
            expect(true).assertFail();
          }
        });
      } catch (error) {
        console.info("[lbs_js] getCurrentLocation15 callback try err." + JSON.stringify(error));
        if (error.code == 201) {
          expect(error.code).assertEqual(201)
        }
      }
      await sleep(2000);
      done();
    });

    /*
     * @tc.number:SUB_geoLocationManager_permission_test_0500
     * @tc.name: testGetCurrentLocationPermission0005
     * @tc.desc:Using the geoLocationManager.off method without permission
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it('testGetCurrentLocationPermission0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
      try {
        await geoLocationm.getCurrentLocation((err, result) => {
          if (err) {
            console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_3700 callback err:  " + JSON.stringify(err));
            expect(err.code).assertEqual(201);
            console.info('[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_3700 reject after')
          } else {
            console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_3700 callback, result:  " + JSON.stringify(result));
            expect(true).assertFail();
          }
        });
      } catch (error) {
        console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_3900 promise try err." + JSON.stringify(error));
        if (error.code == 201) {
          expect(error.code).assertEqual(201)
        } else {
          expect(true).assertFail();
        }
      }
      await sleep(4000);
      done();
    });

    /*
     * @tc.number:SUB_geoLocationManager_permission_test_0600
     * @tc.name: testOnNmessagePermission0006
     * @tc.desc:Using the geoLocationManager.off method without permission
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it('testOnNmessagePermission0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let nmeaCb1 = (str: string): void => {
          console.log('[lbs_js] nmeaMessage1: ' + str);
        }
        let nmeaCb2 = (str: string): void => {
          console.log('[lbs_js] nmeaMessage2: ' + str);
        }
        try {
          geoLocationm.on('nmeaMessage', nmeaCb1);
          expect(true).assertFail();
        } catch (error) {
          console.info("nmea on err:" + JSON.stringify(error));
          if (error.code == "201"){
            expect(error.code).assertEqual("201");
          } else {
            expect(error.code).assertEqual("801");
          }
        }
        try {
          geoLocationm.on('nmeaMessage', nmeaCb2);
          expect(true).assertFail();
        } catch (error) {
          if (error.code == "201"){
            expect(error.code).assertEqual("201");
          } else {
            expect(error.code).assertEqual("801");
          }
        }
        await sleep(1000);
        done();
      });

    /*
     * @tc.number:SUB_geoLocationManager_permission_test_0700
     * @tc.name: testOnSatelliteStatusChangePermission0007
     * @tc.desc:Using the geoLocationManager.off method without permission
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it('testOnSatelliteStatusChangePermission0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let gnssStatusCb = (satelliteStatusInfo:geoLocationm.SatelliteStatusInfo):void => {
          console.info('satelliteStatusChange: ' + JSON.stringify(satelliteStatusInfo));
          let totalNumber: number = satelliteStatusInfo.satellitesNumber;
          let satelliteIds: Array<number> = satelliteStatusInfo.satelliteIds;
          let carrierToNoiseDensitys: Array<number> = satelliteStatusInfo.carrierToNoiseDensitys;
          let altitudes: Array<number> = satelliteStatusInfo.altitudes;
          let azimuths: Array<number> = satelliteStatusInfo.azimuths;
          let carrierFrequencies: Array<number> = satelliteStatusInfo.carrierFrequencies;
          let satelliteConstellations: Array<geoLocationm.SatelliteConstellationCategory> | undefined = satelliteStatusInfo.satelliteConstellation;
          let satelliteAdditionalInfos: Array<number> | undefined = satelliteStatusInfo.satelliteAdditionalInfo;
          for (let i = 0;i < totalNumber;i++) {
            let satelliteId: Number = satelliteIds[i];
            let carrierToNoiseDensity: Number = carrierToNoiseDensitys[i];
            let altitude: Number = altitudes[i];
            let azimuth: Number = azimuths[i];
            let carrierFrequencie: Number = carrierFrequencies[i];
            if (satelliteConstellations != undefined) {
              let satelliteConstellation: geoLocationm.SatelliteConstellationCategory = satelliteConstellations[i];
            }
            if (satelliteAdditionalInfos != undefined) {
              let satelliteAdditionalInfo: Number = satelliteAdditionalInfos[i];
            }
          }
        }

        try {
          geoLocationm.on('satelliteStatusChange', gnssStatusCb);
          expect(true).assertFail();
        } catch (error) {
          if (error.code == "201"){
            expect(error.code).assertEqual("201");
          } else {
            expect(error.code).assertEqual("801");
          }
          console.error("errCode:" + error.code + ", message:"  + error.message);
        }
        await sleep(1000);
        done();
      });

    /*
     * @tc.number:SUB_geoLocationManager_permission_test_0800
     * @tc.name: testGetCurrentWifiBssidForLocatingPermission0008
     * @tc.desc:Using the geoLocationManager.off method without permission
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it('testGetCurrentWifiBssidForLocatingPermission0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) =>{
      try {
        let mac = geoLocationm.getCurrentWifiBssidForLocating();
        expect(false).assertEqual(mac != '');
      } catch(error) {
        expect(error.code).assertEqual(201);
      }
      await sleep(1000);
      done();
    });

    /*
     * @tc.number:SUB_geoLocationManager_permission_test_0900
     * @tc.name: testAddGnssGeofencePermission0009
     * @tc.desc:Using the geoLocationManager.off method without permission
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it('testAddGnssGeofencePermission0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let geofence: geoLocationm.Geofence = {
        "latitude": 34.12, "longitude": 124.11, "radius": 10000.0, "expiration": 10000.0
      }
      let transitionStatusList: Array<geoLocationm.GeofenceTransitionEvent> = [
        geoLocationm.GeofenceTransitionEvent.GEOFENCE_TRANSITION_EVENT_ENTER,
        geoLocationm.GeofenceTransitionEvent.GEOFENCE_TRANSITION_EVENT_EXIT,
      ];
      let notificationRequest1: notificationManager.NotificationRequest = {
        id: 1,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
          normal: {
            title: "围栏通知",
            text: "围栏进入",
            additionalText: ""
          }
        }
      };
      let notificationRequest2: notificationManager.NotificationRequest = {
        id: 2,
        content: {
          notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
          normal: {
            title: '围栏通知',
            text: '围栏退出',
            additionalText: ""
          }
        }
      };
      let notificationRequestList: Array<notificationManager.NotificationRequest> =
        [notificationRequest1, notificationRequest2];
      let gnssGeofenceRequest: geoLocationm.GnssGeofenceRequest = {
        geofence: geofence,
        monitorTransitionEvents: transitionStatusList,
        notifications: notificationRequestList,
        geofenceTransitionCallback: (err : BusinessError, transition : geoLocationm.GeofenceTransition) => {
          if (err) {
            console.error('geofenceTransitionCallback: err=' + JSON.stringify(err));
          }
          if (transition) {
            console.info("GeofenceTransition: %{public}s", JSON.stringify(transition));
          }
        }
      }
      let fenceId = -1;
      try {
        await geoLocationm.addGnssGeofence(gnssGeofenceRequest).then((id) => {
          console.info("addGnssGeofence success, fence id: " + id);
          let fenceId = id;
        }).catch((err: BusinessError) => {
          expect(err.code).assertEqual(201);
          console.error("addGnssGeofence failed, promise errCode:" + (err as BusinessError).code +
            ",errMessage:" + (err as BusinessError).message);
        });
      } catch(error) {
        expect(error.code).assertEqual(201);
        console.error("addGnssGeofence failed, err:" + JSON.stringify(error));
      }
      done();
    });

    /*
   * @tc.number    : SUB_geoLocationManager_permission_test_1000
   * @tc.name      : testGeoLocationManagerPermission0010
   * @tc.desc      : Call getCurrentLocation with configured CurrentLocationRequest, expect return of error code 201
   * @tc.level     : Level 2
   * @tc.type      : Function
   * @tc.size      : MediumTest
   */
    it('testGeoLocationManagerPermission0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let currentLocationRequest: geoLocationm.CurrentLocationRequest =
          { "priority": 0x200,"scenario": 0x300, "timeoutMs": 1000, "maxAccuracy": 0 };
        try {
          await geoLocationm.getCurrentLocation(currentLocationRequest).then((result) => {
            console.info('[lbs_js] geoLocationManager_permission_test_012 promise result ' + JSON.stringify(result));
            expect(true).assertFail();
          }).catch((error: BusinessError) => {
            console.info('[lbs_js] geoLocationManager_permission_test_012 promise err:' + JSON.stringify(error));
            expect(error.code).assertEqual(201)
          })
        } catch (error) {
          console.info("[lbs_js] geoLocationManager_permission_test_012 try err." + JSON.stringify(error));
          expect(error.code).assertEqual(201)
        }
        done();
      });
    /*
     * @tc.number:SUB_geoLocationManager_permission_test_1100
     * @tc.name: testGeoLocationManagerPermission0011
     * @tc.desc:Using the geoLocationManager.off method without permission
     * @tc.level:Level 2
     * @tc.type:Function
     * @tc.size:MediumTest
     */
    it("testGeoLocationManagerPermission0011", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      try {
        let location = geoLocationm.getLastLocation()
      } catch (error){
        expect(error.code).assertEqual(201);
        console.error("getLastLocation: error=" + JSON.stringify(error));
      }
      done();
    });


    /**
     * @tc.number    : SUB_geoLocationManager_permission_test_1200
     * @tc.name      : testBlueToothScanPermission0012
     * @tc.desc      : Test Report Fence Transition.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testBlueToothScanPermission0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
      let bluetoothScanResult = (result:geoLocationm.BluetoothScanResult) => {

        console.info("[lbs_js] testBlueToothScan01 bluetoothScanResult" + JSON.stringify(result));
        expect(true).assertEqual(result.deviceId != 'NA')
        expect(true).assertEqual(result.rssi != -1)
        expect(true).assertEqual(result.data != undefined)
        expect(true).assertEqual(result.deviceName != 'NA')
        expect(true).assertEqual(result.connectable == true || result.connectable == false)
      }
      try {
        geoLocationm.on('bluetoothScanResultChange', bluetoothScanResult)
      } catch(error) {
        console.info("[lbs_js] testBlueToothScan01 on err" + JSON.stringify(error));
        if (error.code == "201") {
          expect(error.code).assertEqual("201")
        } else {
          expect(true).assertFalse();
        }
      }
      try {
        geoLocationm.off('bluetoothScanResultChange')
      } catch(error) {
        console.info("[lbs_js] testBlueToothScan01 off err" + JSON.stringify(error));
        if (error.code == "201") {
          expect(error.code).assertEqual("201")
        } else {
          expect(true).assertFalse();
        }
      }
      try {
        geoLocationm.off('bluetoothScanResultChange', bluetoothScanResult)
      } catch(error) {
        console.info("[lbs_js] testBlueToothScan01 off err" + JSON.stringify(error));
        if (error.code == "201") {
          expect(error.code).assertEqual("201")
        } else {
          expect(true).assertFalse();
        }
      }
      done();
    });
  })
}