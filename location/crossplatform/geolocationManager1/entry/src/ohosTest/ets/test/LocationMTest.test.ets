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
import {describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Size, Level} from '@ohos/hypium';
import { BusinessError } from '@ohos.base';
import { abilityAccessCtrl, common, Permissions } from '@kit.AbilityKit';
import AtManager from '@ohos.abilityAccessCtrl';

let context: common.UIAbilityContext;
let request_scenario_UNSET = geolocationm.LocationRequestScenario.UNSET
let request_scenario_NAVIGATION = geolocationm.LocationRequestScenario.NAVIGATION
let request_scenario_TRAJECTORY_TRACKING = geolocationm.LocationRequestScenario.TRAJECTORY_TRACKING
let request_scenario_CAR_HAILING = geolocationm.LocationRequestScenario.CAR_HAILING
let request_scenario_DAILY_LIFE_SERVICE = geolocationm.LocationRequestScenario.DAILY_LIFE_SERVICE
let request_scenario_NO_POWER = geolocationm.LocationRequestScenario.NO_POWER

let request_priority_UNSET = geolocationm.LocationRequestPriority.UNSET
let request_priority_ACCURACY = geolocationm.LocationRequestPriority.ACCURACY
let request_priority_LOW_POWER = geolocationm.LocationRequestPriority.LOW_POWER
let request_priority_FIRST_FIX = geolocationm.LocationRequestPriority.FIRST_FIX
let coordinate_WGS84 = geolocationm.CoordinateSystemType.WGS84

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

export default function geolocationTest_geo3() {


    describe('geolocationTest_geo3', () => {
        beforeAll(async (done : Function) => {
            console.info('beforeAll case');
            context = globalThis.abilityContext;
            const isAllGranted = await reqPermissionsFromUser(LOCATION_PERMISSIONS, context as common.UIAbilityContext);
            if (!isAllGranted) {
                console.error('no permission');
                throw new Error('no permission');
            }
            await sleep(3000);
            done();
        })
    
        beforeEach(() => {
            console.info('beforeEach case');
        })
        afterEach(() => {
        })



    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_0100
     * @tc.name      : testIsLocationEnabled0001
     * @tc.desc      : Enabling the Location Service Function for a Third-Party App - Callback
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
     it('testIsLocationEnabled0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
        try {
            let state = geolocationm.isLocationEnabled();
            console.info('[lbs_js] getLocationSwitchState06 result: ' + JSON.stringify(state));
            expect(true).assertEqual(state);
        } catch (error) {
            console.info("[lbs_js] getLocationSwitchState06 try err." + JSON.stringify(error));
            if (error.code == "801") {
                expect(error.code).assertEqual("801")
            } else {
                expect().assertFail();
            }
        }
    });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_0200
     * @tc.name      : testLocationEnabledChange0002
     * @tc.desc      : Subscribe to the location service status change.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationEnabledChange0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
        console.log('[lbs_js] just for overwriting,locationServiceState test need system api ');
        let locationServiceState = (state:boolean) => {
            console.log('[lbs_js] locationServiceState: state: ' + JSON.stringify(state));
        }
        try {
            geolocationm.on('locationEnabledChange', locationServiceState);

        } catch (error) {
            console.info("[lbs_js] locationServiceStateOn07 try err." + JSON.stringify(error));
            if (error.code == "801") {
                expect(error.code).assertEqual("801")
            } else {
                expect().assertFail();
            }
        }
        try {
            geolocationm.off('locationEnabledChange', locationServiceState);
        } catch (error) {
            console.info("[lbs_js] locationServiceStateOff07 try err." + JSON.stringify(error));
            if (error.code == "801") {
                expect(error.code).assertEqual("801")
            } else {
                expect().assertFail();
            }
        }
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_0300
     * @tc.name      : testLocationEnabledChange0003
     * @tc.desc      : Subscribe to the location service status change.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationEnabledChange0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {
        console.log('[lbs_js] just for overwriting,locationServiceState test need system api ');
        let  locationServiceState1 = (state:boolean) => {
            console.log('[lbs_js] locationServiceState: state1: ' + JSON.stringify(state));
        }
        let locationServiceState2 = (state:boolean) => {
            console.log('[lbs_js] locationServiceState: state2: ' + JSON.stringify(state));
        }
        try {
            geolocationm.on('locationEnabledChange', locationServiceState1);

        } catch (error) {
            console.info("[lbs_js] locationServiceStateOn1 try err." + JSON.stringify(error));
            expect().assertFail();
        }
        try {
            geolocationm.on('locationEnabledChange', locationServiceState2);

        } catch (error) {
            console.info("[lbs_js] locationServiceStateOn2 try err." + JSON.stringify(error));
            expect().assertFail();
        }
        try {
            geolocationm.off('locationEnabledChange');
        } catch (error) {
            console.info("[lbs_js] locationServiceStateOffall try err." + JSON.stringify(error));
            expect().assertFail();
        }
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_0400
     * @tc.name      : testGetCurrentLocation0004
     * @tc.desc      : Initiate a single location request in a specified scenario and set the navigation scenario.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testGetCurrentLocation04', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
        let currentLocationRequest: geolocationm.CurrentLocationRequest = { "priority": request_priority_UNSET, "scenario": request_scenario_NAVIGATION, "timeoutMs": 1000, "maxAccuracy": 10 };
        try {
            geolocationm.getCurrentLocation(currentLocationRequest, (err, result) => {
                if (err) {
                    console.info("[lbs_js] getCurrentLocation15 callback err:  " + JSON.stringify(err));
                    expect(err.code).assertEqual(3301200);
                    console.info('[lbs_js] getCurrentLocationCallback reject after');
                    done();
                } else {
                    console.info("[lbs_js] getCurrentLocation15 callback result:" + JSON.stringify(result));
                    expect(true).assertEqual(result != null);
                }
            });
        } catch (error) {
            console.info("[lbs_js] getCurrentLocation15 callback try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1000);
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_0500
     * @tc.name      : testGetCurrentLocation0005
     * @tc.desc      : Initiate a single location request in a specified scenario and set the navigation scenario.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testGetCurrentLocation05', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
        let currentLocationRequest: geolocationm.CurrentLocationRequest = { "priority": request_priority_FIRST_FIX, "scenario": request_scenario_NAVIGATION, "timeoutMs": 1000, "maxAccuracy": 10 };
        try {
            await geolocationm.getCurrentLocation(currentLocationRequest).then((result) => {
                console.info('[lbs_js] getCurrentLocation16 promise result ' + JSON.stringify(result));
            }).catch((error: BusinessError) => {
                console.info('[lbs_js] getCurrentLocation16 promise err:' + JSON.stringify(error));
                expect(error.code).assertEqual(3301200);
            })
        } catch (error) {
            console.info("[lbs_js] getCurrentLocation16 promise try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1000);
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_0600
     * @tc.name      : testGetCurrentLocation0006
     * @tc.desc      : Initiate a single location request in a specified scenario and set the track tracing scenario.
     * @tc.size      : MediumTestTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
     it('testGetCurrentLocation0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
        let currentLocationRequest: geolocationm.CurrentLocationRequest = { "priority": request_priority_UNSET, "scenario": request_scenario_TRAJECTORY_TRACKING, "timeoutMs": 1000, "maxAccuracy": 10 };
        try {
            await geolocationm.getCurrentLocation(currentLocationRequest).then((result) => {
                console.info("[lbs_js] getCurrentLocation callback17, result:" + JSON.stringify(result));
                expect(true).assertEqual(result != null);
            }).catch((error:BusinessError) => {
                console.info('[lbs_js] getCurrentLocation callback17:' + JSON.stringify(error));
                expect(error.code).assertEqual(3301200);
            })
        } catch (error) {
            console.info("[lbs_js] getCurrentLocation callback17 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1000);
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_0700
     * @tc.name      : testGetCurrentLocation0007
     * @tc.desc      : Initiate a single location request in a specified scenario and set a car-sharing scenario.
     * @tc.size      : MediumTestTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testGetCurrentLocation0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
        let currentLocationRequest : geolocationm.CurrentLocationRequest = { "priority": request_priority_UNSET, "scenario": request_scenario_CAR_HAILING, "timeoutMs": 1000, "maxAccuracy": 10 };
        try {
            await geolocationm.getCurrentLocation(currentLocationRequest).then((result) => {
                console.info('[lbs_js] getCurrentLocation18 promise result ' + JSON.stringify(result));
            }).catch((error:BusinessError) => {
                console.info('[lbs_js] getCurrentLocation18 promise err:' + JSON.stringify(error));
                expect(error.code).assertEqual(3301200);
            })
        } catch (error) {
            console.info("[lbs_js] getCurrentLocation18 promise try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1000);
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_0800
     * @tc.name      : testGetCurrentLocation0008
     * @tc.desc      : Initiate a single location request in a specified scenario and set the life service scenario..
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testGetCurrentLocation0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
        let currentLocationRequest : geolocationm.CurrentLocationRequest= { "priority": request_priority_UNSET, "scenario": request_scenario_DAILY_LIFE_SERVICE, "timeoutMs": 1000, "maxAccuracy": 0 };
        try {
            await geolocationm.getCurrentLocation(currentLocationRequest).then((result) => {
                console.info('[lbs_js] getCurrentLocation19 promise result:' + JSON.stringify(result));
            }).catch((error:BusinessError) => {
                console.info('[lbs_js] getCurrentLocation19 promise err:' + JSON.stringify(error));
                expect(error.code).assertEqual(3301200);
            })
        } catch (error) {
            console.info("[lbs_js] getCurrentLocation18 promise try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1000);
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_0900
     * @tc.name      : testGetCurrentLocation0009
     * @tc.desc      : Initiate a single location request in a specified scenario
     *                 and set the scenario with no power consumption.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testGetCurrentLocation0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
        let currentLocationRequest1 : geolocationm.CurrentLocationRequest= { "priority": request_priority_UNSET, "scenario": request_scenario_NO_POWER, "timeoutMs": 1000, "maxAccuracy": 10 };
        let currentLocationRequest2 : geolocationm.CurrentLocationRequest= { "priority": request_priority_UNSET, "scenario": request_scenario_NAVIGATION, "timeoutMs": 1000, "maxAccuracy": 10 };
        try {
            await geolocationm.getCurrentLocation(currentLocationRequest1).then((result) => {
                console.info('[lbs_js] getCurrentLocation1901 promise result:' + JSON.stringify(result));
            }).catch((error:BusinessError) => {
                console.info('[lbs_js] getCurrentLocation1901 promise err:' + JSON.stringify(error));
                expect(error.code).assertEqual(3301200);
            })
        } catch (error) {
            console.info("[lbs_js] getCurrentLocation1901 promise try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1000);
        try {
            await geolocationm.getCurrentLocation(currentLocationRequest2).then((result) => {
                console.info('[lbs_js] getCurrentLocation1902 promise result:' + JSON.stringify(result));
            }).catch((error: BusinessError) => {
                console.info('[lbs_js] getCurrentLocation1902 promise err:' + JSON.stringify(error));
                expect(error.code).assertEqual(3301200);
            })
        } catch (error) {
            console.info("[lbs_js] getCurrentLocation1902 promise try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1000);
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_1000
     * @tc.name      : testGetCurrentLocation0010
     * @tc.desc      : Initiate a single location request with the parameter set to high-precision priority location request.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testGetCurrentLocation0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
        let currentLocationRequest: geolocationm.CurrentLocationRequest = { "priority": 0x0201, "scenario": 0x0300, "timeoutMs": 1000, "maxAccuracy": 10 };
        try {
            await geolocationm.getCurrentLocation(currentLocationRequest).then((result) => {
                console.info('[lbs_js] getCurrentLocation21 promise result ' + JSON.stringify(result));
            }).catch((error: BusinessError) => {
                console.info('[lbs_js] getCurrentLocation21 promise err:' + JSON.stringify(error));
                expect(error.code).assertEqual(3301200);
            })
        } catch (error) {
            console.info("[lbs_js] getCurrentLocation21 promise try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1000);
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_1100
     * @tc.name      : testGetCurrentLocation0011
     * @tc.desc      : Initiate a single location request with parameters set to fast location and priority location request.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testGetCurrentLocation0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
        let currentLocationRequest: geolocationm.CurrentLocationRequest = { "priority": 0x0203, "scenario": 0x0300, "timeoutMs": 1000, "maxAccuracy": 10 };
        try {
            await geolocationm.getCurrentLocation(currentLocationRequest).then((result) => {
                console.info('[lbs_js] getCurrentLocation22 promise result:' + JSON.stringify(result));
            }).catch((error: BusinessError) => {
                console.info('[lbs_js] getCurrentLocation22 promise err:' + JSON.stringify(error));
                expect(error.code).assertEqual(3301200);
            })
        } catch (error) {
            console.info("[lbs_js] getCurrentLocation22 promise try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1000);
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_1200
     * @tc.name      : testGetCurrentLocation0012
     * @tc.desc      : Initiate a single location request with parameters set to low power consumption.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testGetCurrentLocation0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
        let currentLocationRequest: geolocationm.CurrentLocationRequest = { "priority": 0x0202, "scenario": 0x0300, "timeoutMs": 1000, "maxAccuracy": 0 };
        try {
            await geolocationm.getCurrentLocation(currentLocationRequest).then((result) => {
                console.info('[lbs_js] getCurrentLocation promise result23:' + JSON.stringify(result));
            }).catch((error: BusinessError) => {
                console.info('[lbs_js] getCurrentLocation promise err23:' + JSON.stringify(error));
                expect(error.code).assertEqual(3301200);
            })
        } catch (error) {
            console.info("[lbs_js] getCurrentLocation23 promise try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1000);
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_1300
     * @tc.name      : testGetCurrentLocation0013
     * @tc.desc      : Initiate a single location request and set the location reporting precision.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testGetCurrentLocation0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
        let currentLocationRequest: geolocationm.CurrentLocationRequest = { "priority": 0x0200, "scenario": 0x0300, "timeoutMs": 1000, "maxAccuracy": 5 };
        let currentLocationRequest1: geolocationm.CurrentLocationRequest = { "priority": 0x0200, "scenario": 0x0300, "timeoutMs": 1000, "maxAccuracy": 2 };
        try {
            await geolocationm.getCurrentLocation(currentLocationRequest).then((result) => {
                console.info('[lbs_js] getCurrentLocation promise result241 ' + JSON.stringify(result));
            }).catch((error: BusinessError) => {
                console.info('[lbs_js] getCurrentLocation promise err241:' + JSON.stringify(error));
                expect(error.code).assertEqual(3301200);
            })
        } catch (error) {
            console.info("[lbs_js] getCurrentLocation241 promise try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1000);
        try {
            await geolocationm.getCurrentLocation(currentLocationRequest1).then((result) => {
                console.info('[lbs_js] getCurrentLocation promise result242 ' + JSON.stringify(result));
            }).catch((error: BusinessError) => {
                console.info('[lbs_js] getCurrentLocation promise err242:' + JSON.stringify(error));
                expect(error.code).assertEqual(3301200);
            })
        } catch (error) {
            console.info("[lbs_js] getCurrentLocation242 promise try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1000);
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_1400
     * @tc.name      : testGetCurrentLocation0014
     * @tc.desc      : Initiate a single location request for specific configuration
     *                 and set the reporting precision of abnormal location.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testGetCurrentLocation0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
        let currentLocationRequest : geolocationm.CurrentLocationRequest= { "priority": 0x0201, "scenario": 0x0300, "timeoutMs": 1000, "maxAccuracy": 0 };
        let currentLocationRequest1 : geolocationm.CurrentLocationRequest= { "priority": 0x0201, "scenario": 0x0300, "timeoutMs": 1000, "maxAccuracy": -1 };
        try {
            await geolocationm.getCurrentLocation(currentLocationRequest).then((result) => {
                console.info('[lbs_js] getCurrentLocation promise result251 ' + JSON.stringify(result));
            }).catch((error: BusinessError) => {
                console.info('[lbs_js] getCurrentLocation promise err251:' + JSON.stringify(error));
                expect(error.code).assertEqual(3301200);
            })
        } catch (error) {
            console.info("[lbs_js] getCurrentLocation251 promise try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1000);
        try {
            await geolocationm.getCurrentLocation(currentLocationRequest1).then((result) => {
                console.info('[lbs_js] getCurrentLocation promise result252 ' + JSON.stringify(result));
            }).catch((error: BusinessError) => {
                console.info('[lbs_js] getCurrentLocation promise err252:' + JSON.stringify(error));
                expect(error.code).assertEqual(3301200);
            })
        } catch (error) {
            console.info("[lbs_js] getCurrentLocation252 promise try err." + JSON.stringify(error));
            expect(error.code).assertEqual("401");
        }
        await sleep(1000);
        done();
    })

    /**
    * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_1500
    * @tc.name      : testGetCurrentLocation0015
    * @tc.desc      : Initiate a single location request and set the location timeout interval.
    * @tc.size      : MediumTest
    * @tc.type      : Function
    * @tc.level     : Level 2
    */
    it('testGetCurrentLocation0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
        let currentLocationRequest: geolocationm.CurrentLocationRequest ={ "priority": 0x0201, "scenario": 0x0301, "timeoutMs": 1000, "maxAccuracy": 0 };
        let currentLocationRequest1: geolocationm.CurrentLocationRequest= { "priority": 0x0201, "scenario": 0x0301, "timeoutMs": 1000, "maxAccuracy": 0 };
        try {
            await geolocationm.getCurrentLocation(currentLocationRequest).then((result) => {
                console.info('[lbs_js] getCurrentLocation promise result261 ' + JSON.stringify(result));
            }).catch((error: BusinessError) => {
                console.info('[lbs_js] getCurrentLocation promise err261:' + JSON.stringify(error));
                expect(error.code).assertEqual(3301200);
            })
        } catch (error) {
            console.info("[lbs_js] getCurrentLocation261 promise try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1000);
        try {
            await geolocationm.getCurrentLocation(currentLocationRequest1).then((result) => {
                console.info('[lbs_js] getCurrentLocation promise result262 ' + JSON.stringify(result));
            }).catch((error: BusinessError) => {
                console.info('[lbs_js] getCurrentLocation promise err262:' + JSON.stringify(error));
                expect(error.code).assertEqual(3301200);
            })
        } catch (error) {
            console.info("[lbs_js] getCurrentLocation262 promise try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1000);
        done();
    })

    /**
    * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_1600
    * @tc.name      : testGetCurrentLocation0016
    * @tc.desc      : Initiate a specified single location request and set the exception location timeout interval.
    * @tc.size      : MediumTest
    * @tc.type      : Function
    * @tc.level     : Level 2
    */
    it('testGetCurrentLocation0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
        let currentLocationRequest : geolocationm.CurrentLocationRequest= { "priority": 0x0201, "scenario": 0x0302, "timeoutMs": 0, "maxAccuracy": 0 };
        let currentLocationRequest1 : geolocationm.CurrentLocationRequest= { "priority": 0x0201, "scenario": 0x0302, "timeoutMs": -1000, "maxAccuracy": 0 };
        try {
            await geolocationm.getCurrentLocation(currentLocationRequest).then((result) => {
                console.info('[lbs_js] getCurrentLocation promise result271 ' + JSON.stringify(result));
            }).catch((error: BusinessError) => {
                console.info('[lbs_js] getCurrentLocation promise err271:' + JSON.stringify(error));
                expect(error.code).assertEqual(3301200);
            });
        } catch (error) {
            console.info("[lbs_js] getCurrentLocation271 promise try err." + JSON.stringify(error));
            expect(error.code).assertEqual("401");
        }
        await sleep(1000);
        try {
            await geolocationm.getCurrentLocation(currentLocationRequest1).then((result) => {
                console.info('[lbs_js] getCurrentLocation promise result272 ' + JSON.stringify(result));
            }).catch((error: BusinessError) => {
                console.info('[lbs_js] getCurrentLocation promise err272:' + JSON.stringify(error));
                expect(error.code).assertEqual(3301200);
            })
        } catch (error) {
            console.info("[lbs_js] getCurrentLocation272 promise try err." + JSON.stringify(error));
            expect(error.code).assertEqual("401");
        }
        await sleep(1000);
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_1700
     * @tc.name      : testLocationChange0017
     * @tc.desc      : Initiate a request for continuous positioning in a specified scenario and set a track tracing scenario.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationChange0017', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {

        let requestInfo:geolocationm.LocationRequest  = {"priority":request_priority_UNSET, "scenario":request_scenario_TRAJECTORY_TRACKING, "timeInterval":1,
            "distanceInterval": 5, "maxAccuracy": 10};
        let  locationChange = (location:geolocationm.Location) => {
            console.info('[lbs_js] locationChanger17 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange !=null);
        };
        try {
            geolocationm.on('locationChange', requestInfo, locationChange);
        } catch (error) {
            console.info("[lbs_js] locationChangerOn17 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange);
        } catch (error) {
            console.info("[lbs_js] locationChangerOff17 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_1800
     * @tc.name      : testLocationChange0018
     * @tc.desc      : Initiate a continuous location request in a specified scenario and set a car-sharing scenario.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationChange0018', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {

        let requestInfo:geolocationm.LocationRequest  = {"priority":request_priority_UNSET, "scenario":request_scenario_CAR_HAILING, "timeInterval":5,
            "distanceInterval": 5, "maxAccuracy": 10};
        let locationChange = (location:geolocationm.Location) => {
            console.info('[lbs_js] locationChanger18 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange !=null);
        };
        try {
            geolocationm.on('locationChange', requestInfo, locationChange);
        } catch (error) {
            console.info("[lbs_js] locationChangerOn18 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange);
        } catch (error) {
            console.info("[lbs_js] locationChangerOff18 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_1900
     * @tc.name      : testLocationChange0019
     * @tc.desc      : Initiate a continuous location request in a specified scenario and set a life service scenario.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationChange0019', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {

        let requestInfo:geolocationm.LocationRequest = {"priority":request_priority_UNSET, "scenario":request_scenario_CAR_HAILING, "timeInterval":1,
            "distanceInterval": 5, "maxAccuracy": 0};
        let locationChange = (location:geolocationm.Location) => {
            console.info('[lbs_js] locationChanger19 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange !=null);
        };
        try {
            geolocationm.on('locationChange', requestInfo, locationChange);
        } catch (error) {
            console.info("[lbs_js] locationChangerOn19 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange);
        } catch (error) {
            console.info("[lbs_js] locationChangerOff19 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_2000
     * @tc.name      : testLocationChange0020
     * @tc.desc      : Initiate a continuous location request in a specified scenario
     *          and set the scenario with no power consumption.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationChange0020', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {

        let requestInfo:geolocationm.LocationRequest = {"priority":request_priority_UNSET, "scenario":request_scenario_NO_POWER, "timeInterval":1,
            "distanceInterval": 5, "maxAccuracy": 10};
        let locationChange1 = (location:geolocationm.Location) => {
            console.log('[lbs_js] locationChanger201 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange1 !=null);
        };
        let locationChange2 = (location:geolocationm.Location) => {
            console.log('[lbs_js] locationChanger202 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange2 !=null);
        };
        try {
            geolocationm.on('locationChange', requestInfo, locationChange1);
        } catch (error) {
            console.info("[lbs_js] locationChangerOn201 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.on('locationChange', requestInfo, locationChange2);
        } catch (error) {
            console.info("[lbs_js] locationChangerOn202 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange1);
        } catch (error) {
            console.info("[lbs_js] locationChangerOff201 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange2);
        } catch (error) {
            console.info("[lbs_js] locationChangerOff202 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_2100
     * @tc.name      : testLocationChange0021
     * @tc.desc      : Initiate a specified continuous positioning request and
     *          set the parameter to high-precision priority positioning request.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationChange0021', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {

        let requestInfo:geolocationm.LocationRequest = {"priority":request_priority_ACCURACY, "scenario":request_scenario_UNSET, "timeInterval":1,
            "distanceInterval": 5, "maxAccuracy": 10};
        let locationChange = (location:geolocationm.Location) => {
            console.log('[lbs_js] locationChanger21 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange !=null);
        };
        try {
            geolocationm.on('locationChange', requestInfo, locationChange);
        } catch (error) {
            console.info("[lbs_js] locationChangerOn21 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange);
        } catch (error) {
            console.info("[lbs_js] locationChangerOff21 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_2200
     * @tc.name      : testLocationChange0022
     * @tc.desc      : Initiate a specified continuous positioning request with the parameter
     *          set to fast positioning and priority positioning request.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationChange0022', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {

        let requestInfo:geolocationm.LocationRequest  = {"priority":request_priority_FIRST_FIX, "scenario":request_scenario_UNSET, "timeInterval":5,
            "distanceInterval": 5, "maxAccuracy": 10};
        let  locationChange = (location:geolocationm.Location) => {
            console.log('[lbs_js] locationChanger22 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange !=null);
        };
        try {
            geolocationm.on('locationChange', requestInfo, locationChange);
        } catch (error) {
            console.info("[lbs_js] locationChangerOn22 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange);
        } catch (error) {
            console.info("[lbs_js] locationChangerOff22 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_2300
     * @tc.name      : testLocationChange0023
     * @tc.desc      : Initiate a specified continuous positioning request with the parameter
     *          set to low power consumption type.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationChange0023', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {

        let requestInfo:geolocationm.LocationRequest = {"priority":request_priority_LOW_POWER, "scenario":request_scenario_UNSET, "timeInterval":1,
            "distanceInterval": 5, "maxAccuracy": 10}
        let locationChange = (location:geolocationm.Location) => {
            console.log('[lbs_js] locationChanger23 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange !=null);
        };
        try {
            geolocationm.on('locationChange', requestInfo, locationChange);
        } catch (error) {
            console.info("[lbs_js] locationChangerOn23 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange);
        } catch (error) {
            console.info("[lbs_js] locationChangerOff23 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_2400
     * @tc.name      : testLocationChange0024
     * @tc.desc      : Initiate a specified continuous location request and set the reporting interval.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationChange24', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {

        let requestInfo:geolocationm.LocationRequest = {"priority":request_priority_UNSET, "scenario":request_scenario_NAVIGATION, "timeInterval":3,
            "distanceInterval": 0, "maxAccuracy": 0};
        let locationChange = (location:geolocationm.Location) => {
            console.log('[lbs_js] locationChanger24 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange !=null);
        };
        try {
            geolocationm.on('locationChange', requestInfo, locationChange);
        } catch (error) {
            console.info("[lbs_js] locationChangerOn24 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange);
        } catch (error) {
            console.info("[lbs_js] locationChangerOff24 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_2500
     * @tc.name      : testLocationChange0025
     * @tc.desc      : Initiate a specified continuous location request and set the location reporting interval.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationChange0025', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {

        let requestInfo:geolocationm.LocationRequest  = {"priority":request_priority_UNSET, "scenario":request_scenario_NAVIGATION, "timeInterval":5,
            "distanceInterval": 0, "maxAccuracy": 0};
        let locationChange = (location:geolocationm.Location) => {
            console.log('[lbs_js] locationChanger25 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange !=null);
        };
        try {
            geolocationm.on('locationChange', requestInfo, locationChange);
        } catch (error) {
            console.info("[lbs_js] locationChangerOn25 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange);
        } catch (error) {
            console.info("[lbs_js] locationChangerOff25 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        done();
    })

    /**
    * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_2600
    * @tc.name      : testLocationChange0026
    * @tc.desc      : Initiate a specified continuous location request and set the interval for reporting exceptions.
    * @tc.size      : MediumTest
    * @tc.type      : Function
    * @tc.level     : Level 1
    */
    it('testLocationChange0026', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {

        let requestInfo:geolocationm.LocationRequest = {"priority":request_priority_UNSET, "scenario":request_scenario_NAVIGATION, "timeInterval":0,
            "distanceInterval": 0, "maxAccuracy": 0};
        let locationChange = (location:geolocationm.Location) => {
            console.log('[lbs_js] locationChanger26 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange !=null);
        };
        try {
            geolocationm.on('locationChange', requestInfo, locationChange);
        } catch (error) {
            console.info("[lbs_js] locationChangerOn26 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange);
        } catch (error) {
            console.info("[lbs_js] locationChangerOff26 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        done();
    })

    /**
    * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_2700
    * @tc.name      : testLocationChange0027
    * @tc.desc      : Initiate a specified continuous location request and set the interval for reporting abnormal locations.
    * @tc.size      : MediumTest
    * @tc.type      : Function
    * @tc.level     : Level 1
    */
    it('testLocationChange0027', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {

        let requestInfo1:geolocationm.LocationRequest = {"priority":request_priority_UNSET, "scenario":request_scenario_NAVIGATION, "timeInterval":0,
            "distanceInterval": 0, "maxAccuracy": 0};
        let requestInfo2:geolocationm.LocationRequest = {"priority":request_priority_UNSET, "scenario":request_scenario_NAVIGATION, "timeInterval":0,
            "distanceInterval": 0, "maxAccuracy": 0};
        let locationChange1 = (location:geolocationm.Location) => {
            console.log('[lbs_js] locationChanger271 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange1 !=null);
        };
        let locationChange2 = (location:geolocationm.Location) => {
            console.log('[lbs_js] locationChanger272 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange2 !=null);
        };
        try {
            geolocationm.on('locationChange', requestInfo1, locationChange1);
        } catch (error) {
            console.info("[lbs_js] locationChangerOn271 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange1);
        } catch (error) {
            console.info("[lbs_js] locationChangerOff271 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        try {
            geolocationm.on('locationChange', requestInfo2, locationChange2);
        } catch (error) {
            console.info("[lbs_js] locationChangerOn272 try err." + JSON.stringify(error));
           expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange2);
        } catch (error) {
            console.info("[lbs_js] locationChangerOff272 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        done();
    })

    /**
    * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_2800
    * @tc.name      : testLocationChange0028
    * @tc.desc      : Initiate a specified continuous positioning request and set the positioning reporting precision.
    * @tc.size      : MediumTest
    * @tc.type      : Function
    * @tc.level     : Level 1
    */
    it('testLocationChange0028', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {

        let requestInfo1:geolocationm.LocationRequest  = {"priority":request_priority_UNSET, "scenario":request_scenario_NAVIGATION, "timeInterval":0,
            "distanceInterval": 0, "maxAccuracy": 5};
        let requestInfo2:geolocationm.LocationRequest  = {"priority":request_priority_UNSET, "scenario":request_scenario_NAVIGATION, "timeInterval":0,
            "distanceInterval": 0, "maxAccuracy": 2};
        let locationChange1 = (location:geolocationm.Location) => {
            console.log('[lbs_js] locationChanger281 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange1 !=null);
        };
        let locationChange2 = (location:geolocationm.Location) => {
            console.log('[lbs_js] locationChanger282 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange2 !=null);
        };
        try {
            geolocationm.on('locationChange', requestInfo1, locationChange1);
        } catch (error) {
            console.info("[lbs_js] locationChangerOn281 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange1);
        } catch (error) {
            console.info("[lbs_js] locationChangerOff281 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        try {
            geolocationm.on('locationChange', requestInfo2, locationChange2);
        } catch (error) {
            console.info("[lbs_js] locationChangerOn282 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange2);
        } catch (error) {
            console.info("[lbs_js] locationChangerOff282 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        done();
    })

    /**
    * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_2900
    * @tc.name      : testLocationChange0029
    * @tc.desc      : Initiate a specified continuous location request and set the reporting precision of abnormal location.
    * @tc.size      : MediumTest
    * @tc.type      : Function
    * @tc.level     : Level 2
    */
    it('testLocationChange0029', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {

        let requestInfo1 :geolocationm.LocationRequest = {"priority":request_priority_UNSET, "scenario":request_scenario_NAVIGATION, "timeInterval":0,
            "distanceInterval": 0, "maxAccuracy": 0};
        let requestInfo2 :geolocationm.LocationRequest = {"priority":request_priority_UNSET, "scenario":request_scenario_NAVIGATION, "timeInterval":0,
            "distanceInterval": 0, "maxAccuracy": -1};
        let locationChange1 = (location:geolocationm.Location) => {
            console.log('[lbs_js] locationChanger291 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange1 !=null);
        };
        let locationChange2 = (location:geolocationm.Location) => {
            console.log('[lbs_js] locationChanger292 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange2 !=null);
        };
        try {
            geolocationm.on('locationChange', requestInfo1, locationChange1);
        } catch (error) {
            console.info("[lbs_js] locationChangerOn291 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange1);
        } catch (error) {
            console.info("[lbs_js] locationChangerOff291 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        try {
            geolocationm.on('locationChange', requestInfo2, locationChange2);
        } catch (error) {
            console.info("[lbs_js] locationChangerOn292 try err." + JSON.stringify(error));
            expect(error.code).assertEqual("401");
        }
        try {
            geolocationm.off('locationChange', locationChange2);
        } catch (error) {
            console.info("[lbs_js] locationChangerOff292 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        done();
    })

    /**
    * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_3000
    * @tc.name      : testLocationChange0030
    * @tc.desc      : Initiate a specified continuous location request and set the reporting precision of abnormal location.
    * @tc.size      : MediumTest
    * @tc.type      : Function
    * @tc.level     : Level 1
    */
    it('testLocationChange0030', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {

        let requestInfo1:geolocationm.ContinuousLocationRequest  = {'interval': 1, 'locationScenario': 0x401};
        let locationChange1 = (location:geolocationm.Location) => {
            console.log('[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCREQUEST_3000 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange1 !=null);
        };
        try {
            geolocationm.on('locationChange', requestInfo1, locationChange1);
        } catch (error) {
            console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCREQUEST_3000 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange1);
        } catch (error) {
            console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCREQUEST_3000 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        done();
    })

    /**
    * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_3100
    * @tc.name      : testLocationChange0031
    * @tc.desc      : Initiate a specified continuous location request and set the reporting precision of abnormal location.
    * @tc.size      : MediumTest
    * @tc.type      : Function
    * @tc.level     : Level 1
    */
    it('testLocationChange0031', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {

        let requestInfo1:geolocationm.ContinuousLocationRequest = {'interval': 1, 'locationScenario': 0x402};
        let locationChange1 = (location:geolocationm.Location) => {
            console.log('[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCREQUEST_3100 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange1 !=null);
        };
        try {
            geolocationm.on('locationChange', requestInfo1, locationChange1);
        } catch (error) {
            console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCREQUEST_3100 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange1);
        } catch (error) {
            console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCREQUEST_3100 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        done();
    })

    /**
    * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_3200
    * @tc.name      : testLocationChange0032
    * @tc.desc      : Initiate a specified continuous location request and set the reporting precision of abnormal location.
    * @tc.size      : MediumTest
    * @tc.type      : Function
    * @tc.level     : Level 1
    */
    it('testLocationChange0032', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {

        let requestInfo1:geolocationm.ContinuousLocationRequest = {'interval': 1, 'locationScenario': 0x403};
        let locationChange1 = (location:geolocationm.Location) => {
            console.log('[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCREQUEST_3200 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange1 !=null);
        };
        try {
            geolocationm.on('locationChange', requestInfo1, locationChange1);
        } catch (error) {
            console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCREQUEST_3200 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange1);
        } catch (error) {
            console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCREQUEST_3200 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        done();
    })

    /**
    * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_3300
    * @tc.name      : testLocationChange0033
    * @tc.desc      : Initiate a specified continuous location request and set the reporting precision of abnormal location.
    * @tc.size      : MediumTest
    * @tc.type      : Function
    * @tc.level     : Level 1
    */
    it('testLocationChange0033', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {

        let requestInfo1:geolocationm.ContinuousLocationRequest = {'interval': 1, 'locationScenario': 0x403};
        let locationChange1 = (location:geolocationm.Location) => {
            console.log('[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCREQUEST_3300 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange1 !=null);
        };
        try {
            geolocationm.on('locationChange', requestInfo1, locationChange1);
        } catch (error) {
            console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCREQUEST_3300 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange1);
        } catch (error) {
            console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCREQUEST_3300 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        done();
    })

    /**
    * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_3400
    * @tc.name      : testLocationChange0034
    * @tc.desc      : Initiate a specified continuous location request and set the reporting precision of abnormal location.
    * @tc.size      : MediumTest
    * @tc.type      : Function
    * @tc.level     : Level 1
    */
    it('testLocationChange0034', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {

        let requestInfo1:geolocationm.ContinuousLocationRequest = {'interval': 1, 'locationScenario': 0x601};
        let locationChange1 = (location:geolocationm.Location) => {
            console.log('[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCREQUEST_3400 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange1 !=null);
        };
        try {
            geolocationm.on('locationChange', requestInfo1, locationChange1);
        } catch (error) {
            console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCREQUEST_3400 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange1);
        } catch (error) {
            console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCREQUEST_3400 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        done();
    })

    /**
    * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_3500
    * @tc.name      : testLocationChange0035
    * @tc.desc      : Initiate a specified continuous location request and set the reporting precision of abnormal location.
    * @tc.size      : MediumTest
    * @tc.type      : Function
    * @tc.level     : Level 1
    */
    it('testLocationChange0035', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {

        let requestInfo1:geolocationm.ContinuousLocationRequest = {'interval': 1, 'locationScenario': 0x602};
        let locationChange1 = (location:geolocationm.Location) => {
            console.log('[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCREQUEST_3500 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange1 !=null);
        };
        try {
            geolocationm.on('locationChange', requestInfo1, locationChange1);
        } catch (error) {
            console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCREQUEST_3500 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange1);
        } catch (error) {
            console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCREQUEST_3500 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        done();
    })

    /**
    * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_3600
    * @tc.name      : testLocationChange0036
    * @tc.desc      : Initiate a specified continuous location request and set the reporting precision of abnormal location.
    * @tc.size      : MediumTest
    * @tc.type      : Function
    * @tc.level     : Level 1
    */
    it('testLocationChange0036', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {

        let requestInfo1:geolocationm.ContinuousLocationRequest = {'interval': 1, 'locationScenario': 0x603};
        let locationChange1 = (location:geolocationm.Location) => {
            console.log('[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCREQUEST_3600 data:' + JSON.stringify(location));
            expect(true).assertEqual(locationChange1 !=null);
        };
        try {
            geolocationm.on('locationChange', requestInfo1, locationChange1);
        } catch (error) {
            console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCREQUEST_3600 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange1);
        } catch (error) {
            console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCREQUEST_3600 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        done();
    })

    /**
    * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_3700
    * @tc.name      : testLocationError0037
    * @tc.desc      : Initiate a specified continuous location request and set the reporting precision of abnormal location.
    * @tc.size      : MediumTest
    * @tc.type      : Function
    * @tc.level     : Level 2
    */
    it('testLocationError0037', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {

        let locationError1 = (errcode:geolocationm.LocationError) => {
            console.log('[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCATIONERROR_0100 data:' + JSON.stringify(errcode));
            expect(true).assertEqual(errcode !=null);
        };
        try {
            geolocationm.on('locationError', locationError1);
        } catch (error) {
            console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCATIONERROR_0100 try err." + JSON.stringify(error));
            if (error.code == "801") {
                expect(error.code).assertEqual("801")
            } else {
                expect(true).assertFalse();
            }
        }
        try {
            geolocationm.off('locationError', locationError1);
        } catch (error) {
            console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_LOCATIONERROR_0100 try err." + JSON.stringify(error));
            if (error.code == "801") {
                expect(error.code).assertEqual("801")
            } else {
                expect(true).assertFalse();
            }
        }
        await sleep(1500);
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_3800
     * @tc.name      : testLocationChange0038
     * @tc.desc      : Obtain the last location after a single location.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationChange0038', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function)=> {

        let requestInfo:geolocationm.LocationRequest = {"priority":request_priority_UNSET, "scenario":request_scenario_NAVIGATION, "timeInterval":0,
            "distanceInterval": 0, "maxAccuracy": 0};
        let locationChange = (location:geolocationm.Location) => {
            console.info('[lbs_js] LastlocationChanger1: data: ' + JSON.stringify(location));
            expect(true).assertEqual(location !=null);
        };
        try {
            geolocationm.on('locationChange', requestInfo, locationChange);
        } catch (error) {
            console.info("[lbs_js] locationChangerOn03 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        try {
            geolocationm.off('locationChange', locationChange);
        } catch (error) {
            console.info("[lbs_js] locationChangerOff03 try err." + JSON.stringify(error));
            expect(true).assertFalse();
        }
        await sleep(1500);
        try {
            let last =geolocationm.getLastLocation();
            console.info('[lbs_js] getLastLocation latitude: ' + last.latitude +
            ' longitude: ' + last.longitude +' altitude: ' + last.altitude
            +' accuracy: ' + last.accuracy+' speed: ' + last.speed +
            'timeStamp: ' + last.timeStamp+'direction:' + last.direction+' timeSinceBoot: '
            + last.timeSinceBoot +'additions: ' + last.additions+' additionSize' + last.additionSize);

            expect(true).assertEqual(JSON.stringify(last) != null);
        } catch (error) {
            console.info("[lbs_js] getLastLocation error:"+ error)
            if (error.code == 801) {
                expect(error.code).assertEqual(801)
            } else {
                expect(error.code).assertEqual(3301200);
            }
        }
        await sleep(1500);
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_3900
     * @tc.name      : testSatelliteStatusChange0039
     * @tc.desc      : Monitoring Satellite Information Reporting
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testSatelliteStatusChange0039', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {

            let gnssStatusCb = (satelliteStatusInfo:geolocationm.SatelliteStatusInfo) => {
                console.info('[lbs_js] gnssStatusChange1: ' + satelliteStatusInfo);
                expect(true).assertEqual(satelliteStatusInfo != null)
                expect(true).assertEqual(satelliteStatusInfo.satellitesNumber != -1)
                if (satelliteStatusInfo.satellitesNumber != 0) {
                    expect(true).assertEqual(satelliteStatusInfo.satelliteIds[0] != -1)
                    expect(true).assertEqual(satelliteStatusInfo.carrierToNoiseDensitys[0] != -1)
                    expect(true).assertEqual(satelliteStatusInfo.altitudes[0] != -1)
                    expect(true).assertEqual(satelliteStatusInfo.azimuths[0] != -1)
                    expect(true).assertEqual(satelliteStatusInfo.carrierFrequencies[0] != -1)
                }
            }
            try {
                geolocationm.on('satelliteStatusChange', gnssStatusCb);
            } catch (error) {
                console.info("[lbs_js] satelliteStatusOn03 try err." + JSON.stringify(error));
                if (error.code == "801") {
                    expect(error.code).assertEqual("801")
                } else {
                    expect(true).assertFalse();
                }
            }

            let requestInfo:geolocationm.LocationRequest = {"priority":request_priority_UNSET, "scenario":request_scenario_NAVIGATION, "timeInterval":0,
                "distanceInterval": 0, "maxAccuracy": 0};
            let locationChange = (location:geolocationm.Location) => {
                console.log('[lbs_js] gnsslocationChanger3: data: ' + JSON.stringify(location));
                expect(true).assertEqual(locationChange !=null);
            };
            try {
                geolocationm.on('locationChange', requestInfo, locationChange);
            } catch (error) {
                console.info("[lbs_js] locationChangerOn03 try err." + JSON.stringify(error));
                if (error.code == "801") {
                    expect(error.code).assertEqual("801")
                } else {
                    expect(true).assertFalse();
                }
            }
            try {
                geolocationm.off('satelliteStatusChange', gnssStatusCb);
            } catch (error) {
                console.info("[lbs_js] satelliteStatusOff03 try err." + JSON.stringify(error));
                if (error.code == "801") {
                    expect(error.code).assertEqual("801")
                } else {
                    expect(true).assertFalse();
                }
            }
            try {
                geolocationm.off('locationChange', locationChange);
            } catch (error) {
                console.info("[lbs_js] locationChangerOff03 try err." + JSON.stringify(error));
                if (error.code == "801") {
                    expect(error.code).assertEqual("801")
                } else {
                    expect(true).assertFalse();
                }
            }
            await sleep(1000);
            done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_4000
     * @tc.name      : testNmeaMessage0040
     * @tc.desc      : Monitoring NMEA Information Reporting
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testNmeaMessage0040', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {

            let requestInfo:geolocationm.LocationRequest = {"priority":request_priority_UNSET, "scenario":request_scenario_NAVIGATION, "timeInterval":0,
                "distanceInterval": 0, "maxAccuracy": 0};
            let nmeaCb = (str:string) => {
                console.log('[lbs_js] nmeaMessage: ' + str);
            }
            let locationChange = (location:geolocationm.Location) => {
                console.log('[lbs_js] gnsslocationChanger4 data:' + JSON.stringify(location));
                expect(true).assertEqual(locationChange !=null);
            };
            try {
                 geolocationm.on('nmeaMessage', nmeaCb);
            } catch (error) {
                console.info("nmea on err:" + JSON.stringify(error));
                if (error.code == "801") {
                    expect(error.code).assertEqual("801")
                } else {
                    expect(true).assertFalse();
                }
            }
            try {
                 geolocationm.on('locationChange', requestInfo, locationChange);
            } catch (error) {
                 console.info("[lbs_js] locationChangerOn04 try err." + JSON.stringify(error));
                 if (error.code == "801") {
                    expect(error.code).assertEqual("801")
                } else {
                    expect(true).assertFalse();
                }
            }
            try {
                geolocationm.off('nmeaMessage', nmeaCb);
            } catch (error) {
                console.info("nmea off err:" + JSON.stringify(error));
                if (error.code == "801") {
                    expect(error.code).assertEqual("801")
                } else {
                    expect(true).assertFalse();
                }
            }
            try {
                geolocationm.off('locationChange', locationChange);
            } catch (error) {
                console.info("[lbs_js] locationChangerOff03 try err." + JSON.stringify(error));
                if (error.code == "801") {
                    expect(error.code).assertEqual("801")
                } else {
                    expect(true).assertFalse();
                }
            }
            await sleep(1000);
            done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_4100
     * @tc.name      : testlocationChange0041
     * @tc.desc      : off all location listeners
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testlocationChange0041', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {

            let requestInfo:geolocationm.LocationRequest = {"priority":request_priority_UNSET, "scenario":request_scenario_NAVIGATION, "timeInterval":0,
                "distanceInterval": 0, "maxAccuracy": 0};
            let locationChange1 = (location:geolocationm.Location) => {
                console.log('[lbs_js] gnsslocationChanger1 data:' + JSON.stringify(location));
                expect(true).assertEqual(location !=null);
            };
            let locationChange2 = (location:geolocationm.Location) => {
                console.log('[lbs_js] gnsslocationChanger2 data:' + JSON.stringify(location));
                expect(true).assertEqual(location !=null);
            };
            try {
                geolocationm.on('locationChange', requestInfo, locationChange1);
            } catch (error) {
                console.info("[lbs_js] locationChangerOn1 try err." + JSON.stringify(error));
                expect(true).assertEqual(JSON.stringify(error) != null);
            }

            try {
                geolocationm.on('locationChange', requestInfo, locationChange2);
            } catch (error) {
                console.info("[lbs_js] locationChangerOn2 try err." + JSON.stringify(error));
                expect(true).assertEqual(JSON.stringify(error) != null);
            }
            try {
                geolocationm.off('locationChange');
            } catch (error) {
                console.info("[lbs_js] locationChangerOffall try err." + JSON.stringify(error));
                expect(true).assertFalse();
            }
            await sleep(3000);
            done();
   })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_4200
     * @tc.name      : testCachedGnssLocationsChange0042
     * @tc.desc      : Setting the Gnss Batching Reporting Interval
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testCachedGnssLocationsChange0042', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
            let cachedLocationsCb1 = (locations:Array<geolocationm.Location>) => {
                console.log('[lbs_js] cachedGnssLocationsReporting7:locations:' + JSON.stringify(locations));
                expect(true).assertEqual(locations !=null);
            }
            let CachedGnssLoactionsRequest1:geolocationm.CachedGnssLocationsRequest = {'reportingPeriodSec': 5, 'wakeUpCacheQueueFull': false};
            try {
                geolocationm.on('cachedGnssLocationsChange', CachedGnssLoactionsRequest1, cachedLocationsCb1);
            } catch (error) {
                console.info("[lbs_js] cachedGnssLocOn071 try err." + JSON.stringify(error));
                if (error.code == "801") {
                    expect(error.code).assertEqual("801")
                } else {
                    expect().assertFail();
                }
            }
            try {
                geolocationm.off('cachedGnssLocationsChange',cachedLocationsCb1);
            } catch (error) {
                console.info("[lbs_js] cachedGnssLocOff071 try err." + JSON.stringify(error));
                console.info('[lbs_js] not support now');
                if (error.code == "801") {
                    expect(error.code).assertEqual("801")
                } else {
                    expect().assertFail();
                }
            }
            await sleep(1500);
            let cachedLocationsCb2 = (locations:Array<geolocationm.Location>) => {
                console.log('[lbs_js] cachedGnssLocationsReporting7:locations:' + JSON.stringify(locations));
                expect(true).assertEqual(locations !=null);
            }
            let CachedGnssLoactionsRequest2:geolocationm.CachedGnssLocationsRequest = {'reportingPeriodSec': 5, 'wakeUpCacheQueueFull': false};
            try {
                geolocationm.on('cachedGnssLocationsChange', CachedGnssLoactionsRequest2, cachedLocationsCb2);
            } catch (error) {
                console.info("[lbs_js] cachedGnssLocOn072 try err." + JSON.stringify(error));
                console.info('[lbs_js] not support now');
                if (error.code == "801") {
                    expect(error.code).assertEqual("801")
                } else {
                    expect().assertFail();
                }
            }
            try {
                geolocationm.off('cachedGnssLocationsChange',cachedLocationsCb1);
            } catch (error) {
                console.info("[lbs_js] cachedGnssLocOff072 try err." + JSON.stringify(error));
                console.info('[lbs_js] not support now');
                if (error.code == "801") {
                    expect(error.code).assertEqual("801")
                } else {
                    expect().assertFail();
                }
            }
            await sleep(1500);
            done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_4300
     * @tc.name      : testCachedGnssLocationsChange0043
     * @tc.desc      : Setting the Gnss Batching Cache Queue to Be Reported When the Gnss Batching Cache Queue Is Full
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testCachedGnssLocationsChange0043', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
            let cachedLocationsCb = (locations:Array<geolocationm.Location>) => {
                console.log('[lbs_js] cachedGnssLocationsReporting8:locations:' + JSON.stringify(locations));
                expect(true).assertEqual(locations !=null);
            }
            let CachedGnssLoactionsRequest:geolocationm.CachedGnssLocationsRequest = {'reportingPeriodSec': 5, 'wakeUpCacheQueueFull': true};
            try {
                geolocationm.on('cachedGnssLocationsChange', CachedGnssLoactionsRequest, cachedLocationsCb);
            } catch (error) {
                console.info("[lbs_js] cachedGnssLocOn08 try err." + JSON.stringify(error));
                console.info('[lbs_js] not support now');
                expect(error.code).assertEqual("801");
            }
            try {
                geolocationm.off('cachedGnssLocationsChange',cachedLocationsCb);
            } catch (error) {
                console.info("[lbs_js] cachedGnssLocOff08 try err." + JSON.stringify(error));
                console.info('[lbs_js] not support now');
                expect(error.code).assertEqual("801");
            }
            await sleep(1500);
            done();

    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_4400
     * @tc.name      : testCachedGnssLocationsChange0044
     * @tc.desc      : Obtains the number of GNSS data records in the batching process.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testCachedGnssLocationsChange0044', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
            let cachedLocationsCb = (locations:Array<geolocationm.Location>) => {
                console.log('[lbs_js] cachedGnssLocationsReporting9:locations: ' + JSON.stringify(locations));
                expect(true).assertEqual(locations !=null);
            }
            let CachedGnssLoactionsRequest:geolocationm.CachedGnssLocationsRequest = {'reportingPeriodSec': 5, 'wakeUpCacheQueueFull': true};
            try {
                geolocationm.on('cachedGnssLocationsChange', CachedGnssLoactionsRequest, cachedLocationsCb);
            } catch (error) {
                console.info("[lbs_js] cachedGnssLocOn09 try err." + JSON.stringify(error));
                console.info('[lbs_js] not support now');
                expect(error.code).assertEqual("801");
            }
            try {
                geolocationm.off('cachedGnssLocationsChange',cachedLocationsCb);
            } catch (error) {
                console.info("[lbs_js] cachedGnssLocOff09 try err." + JSON.stringify(error));
                console.info('[lbs_js] not support now');
                expect(error.code).assertEqual("801");
            }
            await sleep(1500);
            try {
                geolocationm.getCachedGnssLocationsSize((err, data) => {
                    if (err) {
                        console.info('[lbs_js] getCachedGnssLocationsSize09 callback err:' + JSON.stringify(err));
                        console.info('[lbs_js] not support now');
                        expect(err.code).assertEqual(801);
                    }else {
                        console.info("[lbs_js] getCachedGnssLocationsSize09 callback data:" + JSON.stringify(data));
                        expect(true).assertEqual(data != null);
                    }
                });
            } catch (error) {
                console.info("[lbs_js] getCachedGnssLocationsSize09 callback try err." + JSON.stringify(error));
                expect(true).assertFalse();

            }
            await sleep(1000);
            done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_4500
     * @tc.name      : testCachedGnssLocationsChange0045
     * @tc.desc      : Obtains the number of GNSS data records in the batching process.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testCachedGnssLocationsChange0045', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {

            let cachedLocationsCb = (locations:Array<geolocationm.Location>) => {
                console.log('[lbs_js] cachedGnssLocationsReporting10:locations:' + JSON.stringify(locations));
                expect(true).assertEqual(locations !=null);
            }
            let CachedGnssLoactionsRequest:geolocationm.CachedGnssLocationsRequest = {'reportingPeriodSec': 5, 'wakeUpCacheQueueFull': true};
            try {
                geolocationm.on('cachedGnssLocationsChange', CachedGnssLoactionsRequest, cachedLocationsCb);
            } catch (error) {
                console.info("[lbs_js] cachedGnssLocOn10 try err." + JSON.stringify(error));
                console.info('[lbs_js] not support now');
                expect(error.code).assertEqual("801");
            }
            try {
                geolocationm.off('cachedGnssLocationsChange',cachedLocationsCb);
            } catch (error) {
                console.info("[lbs_js] cachedGnssLocOff10 try err." + JSON.stringify(error));
                console.info('[lbs_js] not support now');
                expect(error.code).assertEqual("801");
            }
            await sleep(1000);
            try {
                await geolocationm.getCachedGnssLocationsSize().then( (result) => {
                    console.info('[lbs_js] getCachedGnssLocationsSiz promise '+ JSON.stringify(result));
                    expect(true).assertEqual(result != null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] promise then error." + JSON.stringify(error));
                    console.info('[lbs_js] not support now');
                expect(error.code).assertEqual(801);
                });
            } catch (error) {
                console.info("[lbs_js] getCachedGnssLocationsSize promise try err." + JSON.stringify(error));
                expect(true).assertFalse();
            }
            await sleep(1500);
            done();

    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_4600
     * @tc.name      : testCachedGnssLocationsChange0046
     * @tc.desc      : Obtains the GNSS data of the current batching.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testCachedGnssLocationsChange0046', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {

            let cachedLocationsCb = (locations:Array<geolocationm.Location>) => {
                console.log('[lbs_js] cachedGnssLocationsReporting11:locations:' + JSON.stringify(locations));
                expect(true).assertEqual(locations !=null);
            }
            let CachedGnssLoactionsRequest:geolocationm.CachedGnssLocationsRequest = {'reportingPeriodSec': 5, 'wakeUpCacheQueueFull': true};
            try {
                geolocationm.on('cachedGnssLocationsChange', CachedGnssLoactionsRequest, cachedLocationsCb);
            } catch (error) {
                console.info("[lbs_js] cachedGnssLocOn11 try err." + JSON.stringify(error));
                console.info('[lbs_js] not support now');
                expect(error.code).assertEqual("801");
            }
            try {
                geolocationm.off('cachedGnssLocationsChange',cachedLocationsCb);
            } catch (error) {
                console.info("[lbs_js] cachedGnssLocOff11 try err." + JSON.stringify(error));
                console.info('[lbs_js] not support now');
                expect(error.code).assertEqual("801");
            }
            await sleep(1000);
            try {
                geolocationm.flushCachedGnssLocations((err, data) => {
                    if (err) {
                        console.info('[lbs_js] flushCachedGnssLocations11 callback err is : ' + JSON.stringify(err));
                        console.info('[lbs_js] not support now');
                        if (err.code == 801) {
                            expect(err.code).assertEqual(801);
                        } else {
                            expect(err.code).assertEqual(3301200);
                        }
                    }else {
                        console.info("[lbs_js] flushCachedGnssLocations11 callback data is: " + JSON.stringify(data));
                        expect(true).assertEqual(data != null);
                    }
                });
            } catch (error) {
                console.info("[lbs_js] flushCachedGnssLocations11 callback try err." + JSON.stringify(error));
                expect(error.code == 201 || error.code == 401 || error.code == 801 || error.code == 3301000
                    || error.code == 3301100 || error.code == 3301200).assertFail();
            }
            await sleep(1000);
            done();

    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_4700
     * @tc.name      : testCachedGnssLocationsChange0047
     * @tc.desc      : Obtain the GNSS data of the current batching.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testCachedGnssLocationsChange0047', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
            let cachedLocationsCb = (locations:Array<geolocationm.Location>) => {
                console.log('[lbs_js] cachedGnssLocationsReporting12:locations:' + JSON.stringify(locations));
                expect(true).assertEqual(locations !=null);
            }
            let CachedGnssLoactionsRequest:geolocationm.CachedGnssLocationsRequest = {'reportingPeriodSec': 5, 'wakeUpCacheQueueFull': true};
            try {
                geolocationm.on('cachedGnssLocationsChange', CachedGnssLoactionsRequest, cachedLocationsCb);
            } catch (error) {
                console.info("[lbs_js] cachedGnssLocOn11 try err." + JSON.stringify(error));
                console.info('[lbs_js] not support now');
                expect(error.code).assertEqual("801");
            }
            try {
                geolocationm.off('cachedGnssLocationsChange',cachedLocationsCb);
            } catch (error) {
                console.info("[lbs_js] cachedGnssLocOff11 try err." + JSON.stringify(error));
                console.info('[lbs_js] not support now');
                expect(error.code).assertEqual("801");
            }
            await sleep(1000);
            try {
                await geolocationm.flushCachedGnssLocations().then((result) => {
                    console.info('[lbs_js] flushCachedGnssLocations promise '+ JSON.stringify(result));
                    expect(true).assertEqual(result != null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] promise then error." + JSON.stringify(error));
                    console.info('[lbs_js] not support now');
                    if (error.code == 801) {
                        expect(error.code).assertEqual(801);
                    } else {
                        expect(error.code).assertEqual(3301200);
                    }
                });
            } catch (error) {
                console.info("[lbs_js] flushCachedGnssLocations11 promise try err." + JSON.stringify(error));
                expect(true).assertFalse();
            }
            await sleep(1000);
            done();
    })


    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_4800
     * @tc.name      : testCachedGnssLocationsChange0048
     * @tc.desc      : Obtain the GNSS data of the current batching.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testCachedGnssLocationsChange48', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {

            let cachedLocationsCb1 = (locations:Array<geolocationm.Location>) => {
                console.log('[lbs_js] cachedGnssLocationsReporting12:locations:' + JSON.stringify(locations));
                expect(true).assertEqual(locations !=null);
            }
            let cachedLocationsCb2 = (locations:Array<geolocationm.Location>) => {
                console.log('[lbs_js] cachedGnssLocationsReporting12:locations:' + JSON.stringify(locations));
                expect(true).assertEqual(locations !=null);
            }
            let CachedGnssLoactionsRequest:geolocationm.CachedGnssLocationsRequest = {'reportingPeriodSec': 5, 'wakeUpCacheQueueFull': true};
            try {
                geolocationm.on('cachedGnssLocationsChange', CachedGnssLoactionsRequest, cachedLocationsCb1);
            } catch (error) {
                console.info("[lbs_js] cachedGnssLocOn11 try err." + JSON.stringify(error));
                console.info('[lbs_js] not support now');
                expect(error.code).assertEqual("801");
            }
            try {
                geolocationm.on('cachedGnssLocationsChange', CachedGnssLoactionsRequest, cachedLocationsCb2);
            } catch (error) {
                console.info("[lbs_js] cachedGnssLocOn11 try err." + JSON.stringify(error));
                console.info('[lbs_js] not support now');
                expect(error.code).assertEqual("801");
            }
            try {
                geolocationm.off('cachedGnssLocationsChange');
            } catch (error) {
                console.info("[lbs_js] cachedGnssLocOffall try err." + JSON.stringify(error));
                console.info('[lbs_js] not support now');
                expect(error.code).assertEqual("801");
            }
            await sleep(1000);
            done();

    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_4900
     * @tc.name      : testAddGnssGeofence0049
     * @tc.desc      : Test the function of locating the validity period of the fence.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testAddGnssGeofence0049', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {

            let geofence:geolocationm.Geofence = { "latitude": 31.12, "longitude": 121.11, "radius": 1, "expiration": 1, "coordinateSystemType": 1};
            let events = [1, 2, 4];
            let fenceRequest:geolocationm.GnssGeofenceRequest = {
                "geofence": geofence,
                "monitorTransitionEvents": events,
                "geofenceTransitionCallback" : (err:BusinessError, transition:geolocationm.GeofenceTransition) => {
                    if (err) {
                        console.info("SUB_HSS_LOCATIONSYSTEM_TEST_4900 transition callback  err:" + err);
                        expect(true).assertEqual(JSON.stringify(err) != null);
                        return;
                    }
                    console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_TEST_4900 callback result:" + JSON.stringify(transition));
                    expect(true).assertEqual(transition != null);
                    expect(true).assertEqual(transition.geofenceId != -1)
                    expect(true).assertEqual(transition.transitionEvent != -1 as geolocationm.GeofenceTransitionEvent)
                },
                "notifications" : []
            };
            let fenceId = -1;
            try {
                await geolocationm.addGnssGeofence(fenceRequest).then((id) => {
                    console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_TEST_4900 addGnssGeofence success, id = " + id);
                    fenceId = id;
                    expect(true).assertEqual(id != -1);
                }).catch((err : BusinessError) => {
                    console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_TEST_4900 add error=" + JSON.stringify(err));
                    expect(true).assertEqual(JSON.stringify(err) != null);
                }
                );
            } catch (error) {
                console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_TEST_4900 add try error:"+ JSON.stringify(error));
                if (error.code == "801") {
                    expect(error.code).assertEqual("801")
                } else {
                    expect(true).assertEqual(JSON.stringify(error) != null);
                }
            }
            await sleep(1000);
            try {
                await geolocationm.removeGnssGeofence(fenceId).then(() => {
                    console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_TEST_4900 remove success");
                    expect(true).assertEqual(fenceId != -1);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_TEST_4900 remove error=" + JSON.stringify(error));
                    expect(true).assertEqual(JSON.stringify(error) != null);
                });
                console.info("SUB_HSS_LOCATIONSYSTEM_TEST_4900 remove fenceId:" + fenceId);
            } catch (error) {
                console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_TEST_4900 remove try error:"+ JSON.stringify(error));
                if (error.code == "801") {
                    expect(error.code).assertEqual("801")
                } else {
                    expect(true).assertEqual(JSON.stringify(error) != null);
                }
            }
            await sleep(1000);
            done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_5000
     * @tc.name      : testGetGeofenceSupportedCoordTypes0050
     * @tc.desc      : Test the function of locating the validity period of the fence.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testGetGeofenceSupportedCoordTypes0050', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {

            try {
                let types = geolocationm.getGeofenceSupportedCoordTypes();
                expect(true).assertEqual(JSON.stringify(types) != null);
            } catch (error) {
                console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_GEOFENCE_0700 try error:" + JSON.stringify(error));
                if (error.code == "801") {
                    expect(error.code).assertEqual("801")
                } else {
                    expect(true).assertFalse();
                }
            }
            await sleep(1000);
            done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_5100
     * @tc.name      : testGetCurrentLocation0051
     * @tc.desc      : Initiate a single location request in a specified scenario and set the navigation scenario..
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testGetCurrentLocation0051', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
        let currentLocationRequest:geolocationm.CurrentLocationRequest = { "priority": request_priority_UNSET, "scenario": request_scenario_NAVIGATION, "timeoutMs": 1000, "maxAccuracy": 0 };
        try {
            geolocationm.getCurrentLocation(currentLocationRequest, (err, result) => {
                if (err) {
                    console.info("[lbs_js] getCurrentLocation callback err:  " + JSON.stringify(err));
                    expect(err.code).assertEqual(3301200);
                    console.info('[lbs_js] getCurrentLocationCallback reject after')
                } else {
                    console.info("[lbs_js] getCurrentLocation callback, result:  " + JSON.stringify(result));
                    expect(true).assertEqual(result != null);
                }
            });
        } catch (error) {
            console.info("[lbs_js] getCurrentLocation callback try err." + JSON.stringify(error));
            if (error.code == "801") {
                expect(error.code).assertEqual("801")
            } else {
                expect(true).assertEqual(JSON.stringify(error) != null);
            }
        }
        await sleep(1000);
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_5200
     * @tc.name      : testGetCurrentLocation0052
     * @tc.desc      : Initiate a single location request in a specified scenario and set the navigation scenario..
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testGetCurrentLocation0052', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
        let singleLocationRequest:geolocationm.SingleLocationRequest = { 'locatingTimeoutMs': 1000, 'locatingPriority': 0x501};
        try {
            geolocationm.getCurrentLocation(singleLocationRequest, (err, result) => {
                if (err) {
                    console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_3600 callback err:  " + JSON.stringify(err));
                    expect(err.code).assertEqual(3301200);
                    console.info('[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_3600 reject after')
                } else {
                    console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_3600 callback, result:  " + JSON.stringify(result));
                    expect(true).assertEqual(result != null);
                }
            });
        } catch (error) {
            console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_3600 callback try err." + JSON.stringify(error));
            if (error.code == "801") {
                expect(error.code).assertEqual("801")
            } else {
                expect(true).assertEqual(JSON.stringify(error) != null);
            }
        }
        await sleep(1000);
        done();
    })

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_5300
     * @tc.name      : testGetCurrentLocation0053
     * @tc.desc      : Initiate a single location request in a specified scenario and set the navigation scenario..
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testGetCurrentLocation0053', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
        let singleLocationRequest:geolocationm.SingleLocationRequest = { 'locatingTimeoutMs': 1000, 'locatingPriority': 0x502 };
        try {
            geolocationm.getCurrentLocation(singleLocationRequest, (err, result) => {
                if (err) {
                    console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_3700 callback err:  " + JSON.stringify(err));
                    expect(err.code).assertEqual(3301200);
                    console.info('[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_3700 reject after')
                } else {
                    console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_3700 callback, result:  " + JSON.stringify(result));
                    expect(true).assertEqual(result != null);
                }
            });
        } catch (error) {
            console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_3700 callback try err." + JSON.stringify(error));
            if (error.code == "801") {
                expect(error.code).assertEqual("801")
            } else {
                expect(true).assertEqual(JSON.stringify(error) != null);
            }
        }
        await sleep(1000);
        done();
    })

   /**
    * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_5400
    * @tc.name      : testGetCurrentLocation0054
    * @tc.desc      : Initiate a specified single location request and set the exception location timeout interval.
    * @tc.size      : MediumTest
    * @tc.type      : Function
    * @tc.level     : Level 2
    */
    it('testGetCurrentLocation0054', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
        let singleLocationRequest:geolocationm.SingleLocationRequest = { 'locatingTimeoutMs': 1000, 'locatingPriority': 0x501 };
        try {
            await geolocationm.getCurrentLocation(singleLocationRequest).then((result) => {
                console.info('[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_3800 promise result271 ' + JSON.stringify(result));
            }).catch((error: BusinessError) => {
                console.info('[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_3800 promise err271:' + JSON.stringify(error));
                expect(error.code).assertEqual(3301200);
            });
        } catch (error) {
            console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_3800 promise try err." + JSON.stringify(error));
            if (error.code == "801") {
                expect(error.code).assertEqual("801")
            } else {
                expect(error.code).assertEqual("401");
            }
        }
        await sleep(1000);
        done();
    })

   /**
    * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_5500
    * @tc.name      : testGetCurrentLocation0055
    * @tc.desc      : Initiate a specified single location request and set the exception location timeout interval.
    * @tc.size      : MediumTest
    * @tc.type      : Function
    * @tc.level     : Level 2
    */
    it('testGetCurrentLocation0055', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
        let singleLocationRequest:geolocationm.SingleLocationRequest = { 'locatingTimeoutMs': 1000, 'locatingPriority': 0x502 };
        try {
            await geolocationm.getCurrentLocation(singleLocationRequest).then((result) => {
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
                expect(error.code).assertEqual("401");
            }
        }
        await sleep(1000);
        done();
    })

    /**
    * @tc.number    : SUB_HSS_LOCATIONSYSTEM_TEST_5600
    * @tc.name      : testGetCurrentLocation0056
    * @tc.desc      : Initiate a specified single location request and set the exception location timeout interval.
    * @tc.size      : MediumTest
    * @tc.type      : Function
    * @tc.level     : Level 2
    */
    it('testGetCurrentLocation0056', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
        try {
            await geolocationm.getCurrentLocation((err, result) => {
                if (err) {
                    console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_3700 callback err:  " + JSON.stringify(err));
                    expect(err.code).assertEqual(3301200);
                    console.info('[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_3700 reject after')
                } else {
                    console.info("[lbs_js] SUB_HSS_LOCATIONSYSTEM_SINGLELOC_3700 callback, result:  " + JSON.stringify(result));
                    expect(true).assertEqual(result != null);
                }
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
    })
}

