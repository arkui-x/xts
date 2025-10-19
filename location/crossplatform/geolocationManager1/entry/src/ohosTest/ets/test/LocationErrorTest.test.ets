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
import {describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Size, Level} from '@ohos/hypium'
import { BusinessError } from '@ohos.base';
import AtManager from '@ohos.abilityAccessCtrl'

let context: common.UIAbilityContext;

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

export default function geolocationTest_geo2(){
    describe('geolocationTest_geo2', ()=> {
        beforeAll(async (done:Function) => {
            context = globalThis.abilityContext;
            const isAllGranted = await reqPermissionsFromUser(LOCATION_PERMISSIONS, context as common.UIAbilityContext);
            if (!isAllGranted) {
                console.error('no permission');
                throw new Error('no permission');
            }
            console.info('beforeAll case');
            done();
        })
    
        beforeEach( () => {
            console.info('beforeEach case');
        })
        afterEach( () =>{
        })

        /**
         * @tc.number SUB_HSS_LocationSystem_BatchingErr_0100
         * @tc.name TestgetCachedGnssLocationsSize0001
         * @tc.desc An incorrect parameter is used to obtain the number of GNSS cache locations reported at a time.
         * @tc.size MEDIUM
         * @tc.type Function
         * @tc.level Level 2
         */
        it('TestgetCachedGnssLocationsSize0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
                try {
                    geolocationm.getCachedGnssLocationsSize((err, data) => {
                        if (err) {
                            console.info('[lbs_js] getCachedSiz1 callback err is:' + JSON.stringify(err));
                            expect(err.code).assertEqual(801);
                            return;
                        }
                        console.info("[lbs_js] getCachedSiz1 callback data is:" + JSON.stringify(data));
                        expect(true).assertFalse();
                    });
                } catch (error) {
                    console.info("[lbs_js] getCachedSiz1 callback try error:"+ JSON.stringify(error) +"code"+ error.code +"mes"+ error.message);
                    expect(error.code).assertEqual( 801);
                }
                await sleep(2000);
                done();
        })
    
        /**
         * @tc.number SUB_HSS_LocationSystem_BatchingErr_0200
         * @tc.name TestflushCachedGnssLocations0002
         * @tc.desc All prepared GNSS locations are returned to the application and the underlying buffers are cleared.
         * @tc.size MEDIUM
         * @tc.type Function
         * @tc.level Level 2
         */
        it('TestflushCachedGnssLocations0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
                try {
                    geolocationm.flushCachedGnssLocations((err, data) => {
                        if (err) {
                            console.info('[lbs_js] flushCachedGnssLocations4 callback err is : ' + JSON.stringify(err));
                            expect(err.code).assertEqual(801);
                            return;
                        }
                        console.info("[lbs_js] flushCachedGnssLocations4 callback data is: " + JSON.stringify(data));
                        expect(true).assertFalse();
                    });
                } catch (error) {
                    console.info("[lbs_js] flushCachedGnssLocations4 callback try error:"+ JSON.stringify(error) +"code"+ error.code +"mes"+ error.message);
                    expect(error.code).assertEqual(801);
                }
                await sleep(2000);
                done();
        })
    
        /**
         * @tc.number SUB_HSS_LocationSystem_BatchingErr_0300
         * @tc.name TestflushCachedGnssLocations0003
         * @tc.desc All prepared GNSS locations are returned to the application and the underlying buffers are cleared.
         * @tc.size MEDIUM
         * @tc.type Function
         * @tc.level Level 2
         */
        it('TestflushCachedGnssLocations0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
                (async () => {
                    try {
                        let result = await geolocationm.flushCachedGnssLocations();
                        console.info("[lbs_js] flushCachedGnssLocations5 promise successful :" + JSON.stringify(result));
                    } catch(error) {
                        console.info('[lbs_js] flushCachedGnssLocations5 promise err:' + JSON.stringify(error) +"code"+ error.code +"mes"+ error.message);
                        expect(error.code).assertEqual(801);
                    }
                })();
                await sleep(2000);
                done();
            // }
        })

        /**
         * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GEOFENCE_0400
         * @tc.name      : testAddGnssGeofence0004
         * @tc.desc      : Test the function of locating the validity period of the fence.
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 1
         */
        it('testAddGnssGeofence0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:Function) => {
            let geofenceUnsupportFlag = 0;
                let geofence :geolocationm.Geofence= {
                    "latitude": 31.12, "longitude": 121.11, "radius": 1, "expiration": 100000, "coordinateSystemType": 1
                }
                let transitionStatusList = [
                    geolocationm.GeofenceTransitionEvent.GEOFENCE_TRANSITION_EVENT_ENTER,
                    geolocationm.GeofenceTransitionEvent.GEOFENCE_TRANSITION_EVENT_EXIT,
                    geolocationm.GeofenceTransitionEvent.GEOFENCE_TRANSITION_EVENT_DWELL
                ];
                let gnssGeofenceRequest :geolocationm.GnssGeofenceRequest = {
                    geofence: geofence,
                    monitorTransitionEvents: transitionStatusList,
                    geofenceTransitionCallback: (err, transition) => {}
                }
                for (let i = 0; i < 1000; i++) {
                    try {
                        await geolocationm.addGnssGeofence(gnssGeofenceRequest);
                    } catch(error) {
                        console.error("addGnssGeofence failed, err:" + JSON.stringify(error));
                        if (error.code == 801) {
                            expect(true).assertTrue();
                            geofenceUnsupportFlag = 1;
                            done();
                            break;
                        }
                    }
                }

                if (geofenceUnsupportFlag == 0) {
                    try {
                        await geolocationm.addGnssGeofence(gnssGeofenceRequest).then((id) => {
                         }).catch((error: BusinessError) => {
                            console.error("addGnssGeofence failed, err:" + JSON.stringify(error));
                            expect(error.code).assertEqual(3301601);
                        });
                    } catch(error) {
                        console.error("addGnssGeofence failed, err:" + JSON.stringify(error));
                    }
                    done();
                // }
            }
                done();
        })

        /**
         * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GEOFENCE_0500
         * @tc.name      : testAddGnssGeofence0005
         * @tc.desc      : Test the function of locating the validity period of the fence.
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 1
         */
        it('testAddGnssGeofence0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done:Function) => {
                let fenceId = -1
                try {
                    await geolocationm.removeGnssGeofence(fenceId).then(() => {
                     }).catch((error: BusinessError) => {
                        console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_GEOFENCE_0500 remove error=" + JSON.stringify(error));
                        expect(error.code).assertEqual(3301602);
                    });
                } catch(error) {
                    console.error("addGnssGeofence failed, err:" + JSON.stringify(error));
                }
                done();
        })
    })
}


function done() {
    throw new Error('Function not implemented.');
}
