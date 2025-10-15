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
import abilityAccessCtrl from '@ohos.abilityAccessCtrl'
import bundle from '@ohos.bundle'
import osaccount from '@ohos.account.osAccount'
import type { Permissions } from '@ohos.privacyManager';
import {describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Size, Level} from '@ohos/hypium'
import { BusinessError } from '@ohos.base';


function sleep(ms: number): Promise<void> {
    return new Promise((resolve) => {
        setTimeout(resolve, ms);
    });
}

export default function geolocationTest_geo1(){
    describe('geolocationTest_geo1', ()=> {
        beforeAll(async (done:Function) => {
            console.info('beforeAll case');
            done();
        })
    
        beforeEach(async (done:Function) => {
            console.info('beforeEach case');
            done();
        })
    
        /**
         * @tc.number SUB_HSS_LocationSystem_CountryCodeErr_0100
         * @tc.name testgetCountryCodeon0001
         * @tc.desc The interception country code is changed.
         * @tc.type Function
         * @tc.level Level 2
         */
        it('testgetCountryCodeon0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
            let country = (countrycode:geolocationm.CountryCode) => {
                console.log('[lbs_js] cachedGnssLocationsReporting9:locations:' + JSON.stringify(country));
                expect(true).assertEqual(country !=null);
            }
            try {
                console.info("[lbs_js] SUB_HSS_LocationSystem_CountryCodeErr_0100");
                geolocationm.on('countryCodeChange', country);
            } catch (error) {
                console.info("[lbs_js] countryCodeOn2 try error:"+ JSON.stringify(error) +"code"+ error.code +"mes"+ error.message);
                expect(error.code).assertEqual("401");
            }
        })
    
        /**
         * @tc.number SUB_HSS_LocationSystem_CountryCodeErr_0200
         * @tc.name testgetCountryCodeoff0002
         * @tc.desc The interception country code is changed.
         * @tc.type Function
         * @tc.level Level 2
         */
        it('testgetCountryCodeoff0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,  ()=> {
            try {
                console.info("[lbs_js] SUB_HSS_LocationSystem_CountryCodeErr_0200");
                geolocationm.off('countryCodeChange');
            } catch (error) {
                console.info("[lbs_js] countryCodeOff3 try error:"+ JSON.stringify(error) +"code"+ error.code +"mes"+ error.message);
                expect(true).assertFalse();
            }
        })

        /**
         * @tc.number SUB_HSS_LocationSystem_CountryCodeErr_0300
         * @tc.name testgetCountryCodeonoff0003
         * @tc.desc The interception country code is changed.
         * @tc.type Function
         * @tc.level Level 2
         */
        it('testgetCountryCodeoff0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
            let callback = (code:geolocationm.CountryCode) => {
                console.log('countryCodeChange: ' + JSON.stringify(code));
            }
            try {
                console.info("[lbs_js] SUB_HSS_LocationSystem_CountryCodeErr_0300");
                geolocationm.on('countryCodeChange',callback);
                console.info('[lbs_js] countryCodeOn2' +JSON.stringify(callback));
            } catch (error) {
                console.info("[lbs_js] countryCodeOn2 try error:"+ JSON.stringify(error) +"code"+ error.code +"mes"+ error.message);
                expect(error.code).assertEqual("401");
            }
            await sleep(1000);
            done();
        })

        /**
         * @tc.number SUB_HSS_LocationSystem_CountryCodeErr_0400
         * @tc.name testgetCountryCodeoff0004
         * @tc.desc The interception country code is changed.
         * @tc.type Function
         * @tc.level Level 2
         */
        it('testgetCountryCodeoff0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
            let callback = (code:geolocationm.CountryCode) => {
                console.log('countryCodeChange: ' + JSON.stringify(code));
            }
            try {
                console.info("[lbs_js] SUB_HSS_LocationSystem_CountryCodeErr_0300");
                geolocationm.off('countryCodeChange', callback);
                console.info('[lbs_js] countryCodeOff3' +JSON.stringify(callback));
            } catch (error) {
                console.info("[lbs_js] countryCodeOff3 try error:"+ JSON.stringify(error) +"code"+ error.code +"mes"+ error.message);
                expect(error.code).assertEqual("401");
            }
            await sleep(1500);
            done();
        })

        /**
         * @tc.number SUB_HSS_LocationSystem_CountryCodeErr_0500
         * @tc.name testsatelliteStatusChangeon0005
         * @tc.desc Subscribe satellite status changed.
         * @tc.type Function
         * @tc.level Level 2
         */
        it('testsatelliteStatusChangeon0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
                let gnssStatusCb = (satelliteStatusInfo:geolocationm.SatelliteStatusInfo) => {
                    console.info('[lbs_js] gnssStatusChange1: ' + satelliteStatusInfo);
                    expect(true).assertEqual(satelliteStatusInfo != null);
                }
                try {
                    geolocationm.on('satelliteStatusChange',gnssStatusCb);
                    console.info('[lbs_js] satelliteOn1' +JSON.stringify(gnssStatusCb));
                } catch (error) {
                    console.info("[lbs_js] satelliteOn1 try error:"+ JSON.stringify(error) +"code"+ error.code +"mes"+ error.message);
                    expect(error.code).assertEqual("801");
                }
                await sleep(1000);
                done();
        })
    
        /**
         * @tc.number SUB_HSS_LocationSystem_GnssErr_0600
         * @tc.name testsatelliteStatusChangeoff0006
         * @tc.desc Unsubscribe satellite status changed.
         * @tc.type Function
         * @tc.level Level 2
         */
        it('satelliteStatusChange_on_off_006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
                let gnssStatusCb = (satelliteStatusInfo:geolocationm.SatelliteStatusInfo) => {
                    console.info('[lbs_js] gnssStatusChange4: ' + satelliteStatusInfo);
                    expect(true).assertEqual(satelliteStatusInfo != null);
                }
                try {
                    geolocationm.off('satelliteStatusChange',gnssStatusCb);
                    console.info('[lbs_js] satelliteOff4' +JSON.stringify(gnssStatusCb));
                } catch (error) {
                    console.info("[lbs_js] satelliteOff4 try error:"+ JSON.stringify(error) +"code"+ error.code +"mes"+ error.message);
                    expect(error.code).assertEqual("401");
                }
                await sleep(1500);
                done();
        })
    
        /**
         * @tc.number SUB_HSS_LocationSystem_GnssErr_0700
         * @tc.name testlocationChangeoff0007
         * @tc.desc Subscribe location changed.
         * @tc.type Function
         * @tc.level Level 2
         */
        it('testlocationChangeoff0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
            let requestInfo : geolocationm.LocationRequest = {"priority":0x200, "scenario":0x301, "timeInterval":0,
                "distanceInterval": 0, "maxAccuracy": 0};
            let locationChange = (location:geolocationm.Location) => {
                console.log('[lbs_js] gnsslocationChanger2: data: ' + JSON.stringify(location));
                expect(true).assertEqual(locationChange !=null);
            };
            try {
                geolocationm.on('locationChange', requestInfo,locationChange);
                console.info('[lbs_js] locationChangeOn2' +JSON.stringify(locationChange));
            } catch (error) {
                console.info("[lbs_js] locationChangeOn2 try error:"+ JSON.stringify(error) +"code"+ error.code +"mes"+ error.message);
                expect(error.code).assertEqual("401");
            }
            await sleep(1000);
            done();
        })
    
        /**
         * @tc.number SUB_HSS_LocationSystem_GnssErr_0800
         * @tc.name testlocationChangeoff0008
         * @tc.desc Unsubscribe location changed.
         * @tc.type Function
         * @tc.level Level 2
         */
        it('testlocationChangeoff0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
            let locationChange = (location:geolocationm.Location) => {
                console.log('[lbs_js] gnsslocationChanger5: data: ' + JSON.stringify(location));
                expect(true).assertEqual(locationChange !=null);
            };
            try {
                geolocationm.off('locationChange',locationChange);
                console.info('[lbs_js] locationChangeOff5' +JSON.stringify(locationChange));
            } catch (error) {
                console.info("[lbs_js] locationChangeOff5 try error:"+ JSON.stringify(error) +"code"+ error.code +"mes"+ error.message);
                expect(error.code).assertEqual("401");
            }
            await sleep(1500);
            done();
        })
    
        /**
         * @tc.number SUB_HSS_LocationSystem_GnssErr_0900
         * @tc.name testnmeaMessageon0009
         * @tc.desc Subscribe nmea message changed.
         * @tc.type Function
         * @tc.level Level 2
         */
        it('testnmeaMessageon0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
                let nmeaCb = (str:string) => {
                    console.log('[lbs_js] nmeaMessage: ' + str);
                }
                try {
                    geolocationm.on('nmeaMessage',nmeaCb);
                    console.info('[lbs_js] nmeaMessageOn2' +JSON.stringify(nmeaCb));
                } catch (error) {
                    console.info("[lbs_js] nmeaMessageOn2 try error:"+ JSON.stringify(error) +"code"+ error.code +"mes"+ error.message);
                    expect(error.code).assertEqual("801");
                }
                await sleep(1000);
                done();
            // }
        })
    
        /**
         * @tc.number SUB_HSS_LocationSystem_GnssErr_1000
         * @tc.name testnmeaMessageoff0010
         * @tc.desc Unsubscribe nmea message changed.
         * @tc.type Function
         * @tc.level Level 2
         */
        it('testnmeaMessageoff0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
                let nmeaCb = (str:string) => {
                    console.log('[lbs_js] nmeaMessage: ' + str);
                }
                try {
                    geolocationm.off('nmeaMessage',nmeaCb);
                    console.info('[lbs_js] nmeaMessageOff6' +JSON.stringify(nmeaCb));
                } catch (error) {
                    console.info("[lbs_js] nmeaMessageOff6 try error:"+ JSON.stringify(error) +"code"+ error.code +"mes"+ error.message);
                    expect(error.code).assertEqual("401");
                }
                await sleep(1500);
                done();
            // }
        })

        /**
         * @tc.number SUB_HSS_LocationSystem_LocSwitchErr_1100
         * @tc.name testlocationEnabledChangeon0011
         * @tc.desc Subscribe location switch changed.
         * @tc.type Function
         * @tc.level Level 2
         */
        it('testlocationEnabledChangeon0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
            let locationServiceState = (state:boolean) => {
                console.log('[lbs_js] locationServiceState: state: ' + JSON.stringify(state));
            }
            try {
                geolocationm.on('locationEnabledChange', locationServiceState);
                console.info('[lbs_js] nEnabledChangeOn1' +JSON.stringify(locationServiceState));
            } catch (error) {
                console.info("[lbs_js] nEnabledChangeOn1 try error:"+ JSON.stringify(error) +"code"+ error.code +"mes"+ error.message);
                expect(error.code).assertEqual("401");
            }
            await sleep(1000);
            done();
        })
    
        /**
         * @tc.number SUB_HSS_LocationSystem_LocSwitchErr_1200
         * @tc.name testlocationEnabledChangeoff0012
         * @tc.desc Unsubscribe location switch changed.
         * @tc.type Function
         * @tc.level Level 2
         */
        it('testlocationEnabledChangeoff0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
            let locationServiceState = (state:boolean) => {
                console.log('[lbs_js] locationServiceState: state: ' + JSON.stringify(state));
            }
            try {
                geolocationm.off('locationEnabledChange',locationServiceState);
                console.info('[lbs_js] EnabledChangeOff2' +JSON.stringify(locationServiceState));
            } catch (error) {
                console.info("[lbs_js] EnabledChangeOff2 try error:"+ JSON.stringify(error) +"code"+ error.code +"mes"+ error.message);
                expect(error.code).assertEqual("401");
            }
            await sleep(1500);
            done();
        })
    
    })    
}
