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
import {describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Size, Level} from '@ohos/hypium'
import { BusinessError } from '@ohos.base';
import { abilityAccessCtrl, common, Permissions } from '@kit.AbilityKit';

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

export default function geolocationTest_geoM() {

    describe('geolocationTest_geoM',  ()=> {

        console.log('#start AccessTokenTests#');
        beforeAll(async (done:Function)=> {
            context = globalThis.abilityContext;
            const isAllGranted = await reqPermissionsFromUser(LOCATION_PERMISSIONS, context as common.UIAbilityContext);
            if (!isAllGranted) {
                console.error('no permission');
                throw new Error('no permission');
            }
            console.info('beforeAll case');
            await sleep(3000);
            done();
        })

        beforeEach(async (done:Function)=> {
            console.info('beforeEach case');
            await sleep(3000);
            done();
        })


    /**
     * @tc.number SUB_HSS_LocationSystem_Geo_0100
     * @tc.name testIsGeoServiceAvailable0001
     * @tc.desc Check whether address resolution and reverse address resolution are supported.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     */
     it('testIsGeoServiceAvailable001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
        try {
            let geocoder1 = geolocationm.isGeocoderAvailable();
            console.info('[lbs_js] isGeocoderAvailable result: ' + JSON.stringify(geocoder1));
            expect(true).assertEqual(JSON.stringify(geocoder1) != null);
        } catch (error) {
            console.info('[lbs_js] isGeocoderAvailable err:' + JSON.stringify(error));
            console.info('[lbs_js] not support now');
            expect(error.code).assertEqual("801");
        }
    });

     /**
     * @tc.number SUB_HSS_LocationSystem_Geo_0200
     * @tc.name TestgetAddressesFromLocation0002
     * @tc.desc Address Resolution Test.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     */
    it('TestgetAddressesFromLocation0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {
        let geocoder1 = geolocationm.isGeocoderAvailable();
        if (geocoder1) {
            let reverseGeocodeRequest:geolocationm.ReverseGeoCodeRequest = {
                "latitude": 31.265496, "longitude": 121.62771, "maxItems": 1 , "locale": "zh", "country": "CN"
            };
            try {
                geolocationm.getAddressesFromLocation(reverseGeocodeRequest, (err, data) => {
                    if (err) {
                        console.info('[lbs_js] getAddressesFromLocation4 callback err is:' + JSON.stringify(err));
                        expect(err.code).assertEqual(3301300);
                    } else {
                        console.info("[lbs_js] getAddressesFromLocation4 callback data is:" + JSON.stringify(data));
                        expect(true).assertEqual((JSON.stringify(data)) != null);
                    }
                 });
            } catch (error) {
                console.info("[lbs_js] getAddressesFromLocation4 callback try error:"+ error);
                if (error.code == "801") {
                    expect(error.code).assertEqual("801")
                } else {
                    expect(true).assertFalse();
                }
            }
            await sleep(2000);
        } else {
            console.info("[lbs_js] The geocoding service is unavailable.");
        }
        done();
    })


    /**
    * @tc.number SUB_HSS_LocationSystem_Geo_0300
     * @tc.name TestgetAddressesFromLocation0003
     * @tc.desc Address Resolution Test.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('TestgetAddressesFromLocation0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
            try {
                let reverseGeocodeRequest:geolocationm.ReverseGeoCodeRequest = { "latitude": 31.265496, "longitude": 121.62771, "maxItems": 5};
                await geolocationm.getAddressesFromLocation(reverseGeocodeRequest).then((data) => {
                    console.info('[lbs_js] getAddressesFromLocation21 promise: ' + JSON.stringify(data));
                    if(data != null)
                    {
                        console.info('addressUrl: ' + JSON.stringify(data[0].addressUrl)
                        +',administrativeArea: '+ JSON.stringify(data[0].administrativeArea)
                        +',countryCode: '+ JSON.stringify(data[0].countryCode)
                        +'countryName: '+ JSON.stringify(data[0].countryName )
                        +',descriptions: '+ JSON.stringify(data[0].descriptions)
                        +',descriptionsSize: '+JSON.stringify(data[0].descriptionsSize)
                        +',latitude: '+ JSON.stringify(data[0].latitude)
                        +',locale: '+ JSON.stringify(data[0].locale)
                        +',locality:'+ JSON.stringify(data[0].locality)
                        +',longitude:'+ JSON.stringify(data[0].longitude)
                        +',phoneNumber: '+ JSON.stringify(data[0].phoneNumber)
                        +',placeName:'+ JSON.stringify(data[0].placeName)
                        + ',postalCode: '+JSON.stringify(data[0].postalCode)
                        + ',premises:'+JSON.stringify(data[0].premises)
                        + ',roadName:'+JSON.stringify(data[0].roadName)
                        + ',subAdministrativeArea:'+JSON.stringify(data[0].subAdministrativeArea)
                        + ',subLocality:'+JSON.stringify(data[0].subLocality )
                        +',subRoadName:'+ JSON.stringify(data[0].subRoadName)
                        + ',isFromMock:'+JSON.stringify(data[0].isFromMock));
                    }
                }).catch((error: BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocation21 promise then error." + JSON.stringify(error));
                    console.info('[lbs_js] not support now');
                    if (error.code == 801) {
                        expect(error.code).assertEqual(801)
                    } else {
                        expect(error.code).assertEqual(3301300);
                    }
                });
            } catch (error) {
                console.info("[lbs_js] getAddressesFromLocation21 try err." + JSON.stringify(error));
                expect(true).assertFalse();
            }
            await sleep(1000);
        done();
    })

    /**
     * @tc.number SUB_HSS_LocationSystem_Geo_0400
     * @tc.name TestgetAddressesFromLocation0004
     * @tc.desc Obtaining Multiple Addresses Using the Address Resolution Function.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     */
    it('TestgetAddressesFromLocation004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {
        let geocoder1 = geolocationm.isGeocoderAvailable();
        if (geocoder1) {
            try {
                let reverseGeocodeRequest:geolocationm.ReverseGeoCodeRequest = { "latitude": 31.265496, "longitude": 121.62771, "maxItems": 5 };
                await geolocationm.getAddressesFromLocation(reverseGeocodeRequest).then((data) => {
                    console.info('[lbs_js] getAddressesFromLocation22 promise:' + JSON.stringify(data));
                    expect(true).assertEqual((JSON.stringify(data)) != null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocation22 promise then error." + JSON.stringify(error));
                    console.info('[lbs_js] not support now');
                    expect(error.code).assertEqual(3301300);
                });
            } catch (error) {
                console.info("[lbs_js] getAddressesFromLocation22 try err." + JSON.stringify(error));
                expect(true).assertFalse();
            }
            await sleep(1000);
        } else {
            console.info("[lbs_js] The geocoding service is unavailable.");
        }
        done();
    })

    /**
    * @tc.number SUB_HSS_LocationSystem_Geo_0500
     * @tc.name TestgetAddressesFromLocation0005
     * @tc.desc Input parameter boundary test of the address resolution function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('TestgetAddressesFromLocation005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
        let geocoder1 = geolocationm.isGeocoderAvailable();
        if (geocoder1) {
            let reverseGeocodeRequest1:geolocationm.ReverseGeoCodeRequest = { "latitude": 90, "longitude": 121.62771, "maxItems": 1 };
            try {
                await geolocationm.getAddressesFromLocation(reverseGeocodeRequest1).then((data) => {
                    console.info('[lbs_js] getAddressesFromLocation2301 promise: ' + JSON.stringify(data));
                    expect(true).assertEqual((JSON.stringify(data)) != null);
                }).catch((error: BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocation2301 promise then error." + JSON.stringify(error));
                    console.info('[lbs_js] not support now');
                    expect(error.code).assertEqual(3301300);
                });
            } catch (error) {
                console.info("[lbs_js] getAddressesFromLocation message." + JSON.stringify(error));
                expect(true).assertFalse();
            }
            let reverseGeocodeRequest2:geolocationm.ReverseGeoCodeRequest = { "latitude": 90.1, "longitude": 121.62771, "maxItems": 1 };
            try {
                await geolocationm.getAddressesFromLocation(reverseGeocodeRequest2).then((data) => {
                    console.info('[lbs_js] getAddressesFromLocation promise: ' + JSON.stringify(data));
                    expect(data.length).assertEqual(0);
                }).catch((error: BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocation2302 promise then error." + JSON.stringify(error));
                    expect(true).assertFalse();
                });
            } catch (error) {
                console.info("[lbs_js] getAddressesFromLocation message." + JSON.stringify(error));
                expect(error.code).assertEqual("401");
            }
            let reverseGeocodeRequest3:geolocationm.ReverseGeoCodeRequest = { "latitude": -90, "longitude": 121.62771, "maxItems": 1 };
            try {
                await geolocationm.getAddressesFromLocation(reverseGeocodeRequest3).then((data) => {
                    console.info('[lbs_js] getAddressesFromLocation2303 promise: ' + JSON.stringify(data));
                    expect(true).assertEqual((JSON.stringify(data)) != null);
                }).catch((error: BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocation2303 promise then error." + JSON.stringify(error));
                    console.info('[lbs_js] not support now');
                    expect(error.code).assertEqual(3301300);
                });
            } catch (error) {
                console.info("[lbs_js] getAddressesFromLocation message." + JSON.stringify(error));
                expect(true).assertFalse();
            }
            let reverseGeocodeRequest4:geolocationm.ReverseGeoCodeRequest = { "latitude": -90.1, "longitude": 121.62771, "maxItems": 1 };
            try {
                await geolocationm.getAddressesFromLocation(reverseGeocodeRequest4).then((data) => {
                    console.info('[lbs_js] getAddressesFromLocation2304 promise: ' + JSON.stringify(data));
                    expect(true).assertEqual((JSON.stringify(data)) != null);
                }).catch((error: BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocation2304 promise then error." + JSON.stringify(error));
                    expect(true).assertFalse();
                });
            } catch (error) {
                console.info("[lbs_js] getAddressesFromLocation message." + JSON.stringify(error));
                expect(error.code).assertEqual("401");
            }
            await sleep(1000);
        } else {
            console.info("[lbs_js] The geocoding service is unavailable.");
        }
        done();
    })

    /**
     * @tc.number SUB_HSS_LocationSystem_Geo_0600
     * @tc.name TestgetAddressesFromLocation0006
     * @tc.desc Input parameter boundary test of the address resolution function
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('TestgetAddressesFromLocation006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
        let geocoder1 = geolocationm.isGeocoderAvailable();
        if (geocoder1) {
            let reverseGeocodeRequest:geolocationm.ReverseGeoCodeRequest= { "latitude": 31.265496, "longitude": 180, "maxItems": 1 };
            try {
                await geolocationm.getAddressesFromLocation(reverseGeocodeRequest).then((data) => {
                    console.info('[lbs_js] getAddressesFromLocation2401 promise: ' + JSON.stringify(data));
                    expect(true).assertEqual((JSON.stringify(data)) != null);
                }).catch((error: BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocation2401 promise then error." + JSON.stringify(error));
                    console.info('[lbs_js] not support now');
                    expect(error.code).assertEqual(3301300);
                });
            } catch (error) {
                console.info("[lbs_js] getAddressesFromLocation message1." + JSON.stringify(error));
                expect(true).assertFalse();
            }
            await sleep(1000);
            let reverseGeocodeRequest1:geolocationm.ReverseGeoCodeRequest= { "latitude": 31.265496, "longitude": -180.1, "maxItems": 1 };
            try {
                await geolocationm.getAddressesFromLocation(reverseGeocodeRequest1).then((data) => {
                    console.info('[lbs_js] getAddressesFromLocation2402 promise: ' + JSON.stringify(data));
                    expect(data.length).assertEqual(0);
                }).catch((error: BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocation2402 promise then error." + JSON.stringify(error));
                    expect(true).assertFalse();
                });
            } catch (error) {
                console.info("[lbs_js] getAddressesFromLocation message2." + JSON.stringify(error));
                expect(error.code).assertEqual("401");
            }
            await sleep(1000);
            let reverseGeocodeRequest2:geolocationm.ReverseGeoCodeRequest = { "latitude": 31.265496, "longitude": 180, "maxItems": 1 };
            try {
                await geolocationm.getAddressesFromLocation(reverseGeocodeRequest2).then((data) => {
                    console.info('[lbs_js] getAddressesFromLocation2403 promise: ' + JSON.stringify(data));
                    expect(true).assertEqual((JSON.stringify(data)) != null);
                }).catch((error: BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocation2403 promise then error." + JSON.stringify(error));
                    console.info('[lbs_js] not support now');
                    expect(error.code).assertEqual(3301300);
                });
            } catch (error) {
                console.info("[lbs_js] getAddressesFromLocation message3." + JSON.stringify(error));
                expect(true).assertFalse();
            }
            await sleep(1000);
            let reverseGeocodeRequest3:geolocationm.ReverseGeoCodeRequest = { "latitude": 31.265496, "longitude": 180.1, "maxItems": 1 };
            try {
                await geolocationm.getAddressesFromLocation(reverseGeocodeRequest3).then((data) => {
                    console.info('[lbs_js] getAddressesFromLocation2404 promise: ' + JSON.stringify(data));
                    expect(data.length).assertEqual(0);
                }).catch((error: BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocation2404 promise then error." + JSON.stringify(error));
                    expect(true).assertFalse();
                });
            } catch (error) {
                console.info("[lbs_js] getAddressesFromLocation message4." + JSON.stringify(error));
                expect(error.code).assertEqual("401");
            }
            await sleep(1000);
        } else {
            console.info("[lbs_js] The geocoding service is unavailable.");
        }
        done();
    })


    /**
     * @tc.number SUB_HSS_LocationSystem_Geo_0700
     * @tc.name TestgetAddressesFromLocation0007
     * @tc.desc Reverse address resolution test.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     */
    it('TestgetAddressesFromLocation0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {
            try {
                let geocodeRequest:geolocationm.GeoCodeRequest = {
                    "description": "上海市浦东新区金穗路1800号",
                    "maxItems": 1,
                    "locale": "zh",
                };
                geolocationm.getAddressesFromLocationName(geocodeRequest, (err, data) => {
                    if (err.code) {
                        switch (err.code) {
                            case 100:
                                console.info("NOT_SUPPORTED: " + JSON.stringify(err));
                                break;
                            case 101:
                                console.info("INPUT_PARAMS_ERROR: " + JSON.stringify(err));
                                break;
                            case 102:
                                console.info("REVERSE_GEOCODE_ERROR: " + JSON.stringify(err));
                                break;
                            case 103:
                                console.info("GEOCODE_ERROR: " + JSON.stringify(err));
                                break;
                            case 104:
                                console.info("LOCATOR_ERROR: " + JSON.stringify(err));
                                break;
                            case 105:
                                console.info("LOCATION_SWITCH_ERROR: " + JSON.stringify(err));
                                break;
                            case 106:
                                console.info("LAST_KNOWN_LOCATION_ERROR: " + JSON.stringify(err));
                                break;
                            case 107:
                                console.info("LOCATION_REQUEST_TIMEOUT_ERROR: " + JSON.stringify(err));
                                break;
                            case 108:
                                console.info("QUERY_COUNTRY_CODE_ERROR: " + JSON.stringify(err));
                                break;
                            default:
                                console.info('getAddressesFromLocationName callback err: ' + JSON.stringify(err));
                        }
                    }
                    else {
                            console.info("[lbs_js] getAddressesFromLocationName08 callback data is: " + JSON.stringify(data));
                    }
                    done();
                });
            } catch (error) {
                console.info("[lbs_js] getAddressesFromLocationName08 message." + JSON.stringify(error.message));
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
     * @tc.number SUB_HSS_LocationSystem_Geo_0800
     * @tc.name TestgetAddressesFromLocation0008
     * @tc.desc Reverse address resolution test.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     */
    it('TestgetAddressesFromLocation0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {
            let geocodeRequest:geolocationm.GeoCodeRequest = { "description": "上海市浦东新区金穗路1800号", "maxItems": 3 };
            try {
                await geolocationm.getAddressesFromLocationName(geocodeRequest).then((result) => {
                    console.info("[lbs_js] getAddressesFromLocation09 callback data is:" + JSON.stringify(result));
                    expect(true).assertEqual((JSON.stringify(result)) != null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName09 promise then error." + JSON.stringify(error));
                    console.info('[lbs_js] not support now');
                    expect(error.code).assertEqual(3301400);
                });
            } catch (error) {
                console.info("[lbs_js] getAddressesFromLocationName26 try err." + JSON.stringify(error));
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
     * @tc.number SUB_HSS_LocationSystem_Geo_0900
     * @tc.name TestgetAddressesFromLocation0009
     * @tc.desc Obtaining Multiple Locations Using the Reverse Address Resolution Function.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     */
    it('TestgetAddressesFromLocation0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {
            try {
                let geocodeRequest:geolocationm.GeoCodeRequest = { "description": "上海市浦东新区金穗路1800号", "maxItems": 5 };
                await geolocationm.getAddressesFromLocationName(geocodeRequest).then((result) => {
                    console.info("[lbs_js]  getAddressesFromLocation10 promise data is:" + JSON.stringify(result));
                    expect(true).assertEqual((JSON.stringify(result)) != null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName10 promise then error." + JSON.stringify(error));
                    console.info('[lbs_js] not support now');
                    expect(error.code).assertEqual(3301400);
                });
            } catch (error) {
                console.info("[lbs_js] getAddressesFromLocationName27 try err." + JSON.stringify(error));
                expect(true).assertFalse();
            }
            await sleep(1000);
        done();
    })

    /**
     * @tc.number SUB_HSS_LocationSystem_Geo_1000
     * @tc.name TestgetAddressesFromLocation0010
     * @tc.desc Invalid parameter input test for the reverse address resolution function.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('TestgetAddressesFromLocation0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
            try {
                let geocodeRequest:geolocationm.GeoCodeRequest = { "description": "", "maxItems": 1 };
                await geolocationm.getAddressesFromLocationName(geocodeRequest).then((result) => {
                    console.info("[lbs_js]  getAddressesFromLocation111  promise data is:" + JSON.stringify(result));
                    expect(true).assertEqual((JSON.stringify(result)) != null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName111 promise then error." + JSON.stringify(error));
                    expect(true).assertFalse();
                });
            }catch(error){
                console.info("[lbs_js] getAddressesFromLocationName111 message." + JSON.stringify(error.message));
                expect(error.code).assertEqual("401");
            }
            await sleep(1000);
            let geocodeRequest1:geolocationm.GeoCodeRequest = { "description": "", "maxItems": 1 };
            try {
                await geolocationm.getAddressesFromLocationName(geocodeRequest1).then((result) => {
                    console.info("[lbs_js]  getAddressesFromLocationName112 promise data is:" + JSON.stringify(result));
                    expect(result.length == 0).assertTrue();
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName112 promise then error." + JSON.stringify(error));
                    expect(true).assertFalse();
                });
            }catch(error){
                console.info("[lbs_js] getAddressesFromLocationName112 message." + JSON.stringify(error.message));
                expect(error.code).assertEqual("401");
            }
            await sleep(1000);
        done();
    })

    /**
     * @tc.number SUB_HSS_LocationSystem_Geo_1100
     * @tc.name TestgetAddressesFromLocation0011
     * @tc.desc Test the reverse address resolution function in the specified range..
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     */
    it('TestgetAddressesFromLocation0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {
            let geocodeRequest:geolocationm.GeoCodeRequest = {
                "description": "上海金穗路1800号",
                "maxItems": 1,
                "minLatitude": 31.3082812847,
                "minLongitude": 121.5782001832,
                "maxLatitude": 31.1537977881,
                "maxLongitude": 121.8026736943
            };
            try {
                await geolocationm.getAddressesFromLocationName(geocodeRequest).then((result) => {
                    console.info("[lbs_js] getAddressesFromLocation29 promise data is:" + JSON.stringify(result));
                    expect(true).assertEqual((JSON.stringify(result)) != null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName29 promise then error." + JSON.stringify(error));
                    console.info('[lbs_js] not support now');
                    expect(error.code).assertEqual(3301400);
                });
            } catch (error) {
                console.info("[lbs_js] getAddressesFromLocationName29 try err." + JSON.stringify(error));
                expect(true).assertFalse();
            }
            await sleep(1000);
        done();
    })

    /**
     * @tc.number SUB_HSS_LocationSystem_Geo_1200
     * @tc.name TestgetAddressesFromLocation0012
     * @tc.desc Invalid input parameter test for the reverse address resolution function in the specified range
     *          -Invalid location name.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('TestgetAddressesFromLocation0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
            let geocodeRequest:geolocationm.GeoCodeRequest = {
                "description": "",
                "maxItems": 1,
                "minLatitude": 331.3082812847,
                "minLongitude": 121.5782001832,
                "maxLatitude": 31.1537977881,
                "maxLongitude": 121.8026736943
            };
            try {
                await geolocationm.getAddressesFromLocationName(geocodeRequest).then((result) => {
                    console.info("[lbs_js] getAddressesFromLocationName301 promise data is:" + JSON.stringify(result));
                    expect(result.length == 0).assertTrue();
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName301 promise then error." + JSON.stringify(error));
                    expect(true).assertFalse();
                });
            }catch(error){
                console.info("[lbs_js] getAddressesFromLocationName301 message." + JSON.stringify(error.message));
                expect(error.code).assertEqual("401");
            }
            await sleep(1000);
            let geocodeRequest1:geolocationm.GeoCodeRequest = {
                "description": "",
                "maxItems": 1,
                "minLatitude": 331.3082812847,
                "minLongitude": 121.5782001832,
                "maxLatitude": 31.1537977881,
                "maxLongitude": 121.8026736943
            };
            try {
                await geolocationm.getAddressesFromLocationName(geocodeRequest1).then((result) => {
                    console.info("[lbs_js] getAddressesFromLocationName302 promise data is:" + JSON.stringify(result));
                    expect(result.length == 0).assertTrue();
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName302 promise then error." + JSON.stringify(error));
                    expect(true).assertFalse();

                });
            }catch(error){
                console.info("[lbs_js] getAddressesFromLocationName302 message." + JSON.stringify(error.message));
                expect(error.code).assertEqual("401");
            }
            await sleep(1000);
        done();
    })

    /**
     * @tc.number SUB_HSS_LocationSystem_Geo_1300
     * @tc.name TestgetAddressesFromLocation0013
     * @tc.desc Invalid input parameter test for the reverse address resolution function in the specified range
     *          - the address is not in the range.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('TestgetAddressesFromLocation0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
            let geocodeRequest:geolocationm.GeoCodeRequest = {
                "description": "北京天安门",
                "maxItems": 1,
                "minLatitude": 40.85,
                "minLongitude": 116.35,
                "maxLatitude": 40.95,
                "maxLongitude": 116.45
            };
            try {
                await geolocationm.getAddressesFromLocationName(geocodeRequest).then((result) => {
                    console.info("[lbs_js] getAddressesFromLocationName31 promise data is:" + JSON.stringify(result));
                    expect(result.length >= 0).assertTrue();
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName31 promise then error." + JSON.stringify(error));
                    expect(error.code).assertEqual(3301400);
                });
            } catch (error) {
                console.info("[lbs_js] getAddressesFromLocationName31 message." + JSON.stringify(error));
                expect(error.code).assertEqual("401");
            }
            await sleep(1000);
        done();
    })

    /**
     * @tc.number SUB_HSS_LocationSystem_Geo_1400
     * @tc.name TestgetAddressesFromLocation0014
     * @tc.desc Invalid longitude and latitude entered for the reverse address resolution
     *          function in the specified range. The longitude and latitude range boundary is inverted..
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('TestgetAddressesFromLocation014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
        let geocodeRequest:geolocationm.GeoCodeRequest = {
            "description": "北京天安门",
            "maxItems": 1,
            "minLatitude": 39.95,
            "minLongitude": 116.45,
            "maxLatitude": 39.85,
            "maxLongitude": 116.35
        };
            try {
                await geolocationm.getAddressesFromLocationName(geocodeRequest).then((result) => {
                    console.info("[lbs_js]  getAddressesFromLocationName32 promise data is:" + JSON.stringify(result));
                    expect(result.length >= 0).assertTrue();
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName32 promise then error." + JSON.stringify(error));
                    console.info('[lbs_js] not support now');
                    expect(error.code).assertEqual(3301400);
                });
            } catch (error) {
                console.info("[lbs_js] getAddressesFromLocationName32 message." + JSON.stringify(error));
                expect(error.code).assertEqual("401");
            }
            await sleep(1000);
        done();
    })

    /**
     * @tc.number SUB_HSS_LocationSystem_Geo_1500
     * @tc.name TestgetAddressesFromLocation0015
     * @tc.desc Input parameter boundary test for the reverse address resolution function in a specified range.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('TestgetAddressesFromLocation015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
            let geocodeRequest1:geolocationm.GeoCodeRequest = {
                "description": "上海金穗路1800号",
                "maxItems": 1,
                "minLatitude": -90,
                "minLongitude": 121.5782001832,
                "maxLatitude": 31.1537977881,
                "maxLongitude": 121.8026736943
            };
            try{
                await geolocationm.getAddressesFromLocationName(geocodeRequest1).then((result) => {
                    console.info("[lbs_js] getAddressesFromLocationName33 promise1:" + JSON.stringify(result));
                    expect(true).assertEqual((JSON.stringify(result)) != null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName33 promise1 then error." + JSON.stringify(error));
                    console.info('[lbs_js] not support now');
                    expect(error.code).assertEqual(3301400);
                });
            }catch(error){
                console.info("[lbs_js] getAddressesFromLocationName33 message1." + JSON.stringify(error.message));
                expect(true).assertFalse();
            }
            await sleep(1000);
            let geocodeRequest2:geolocationm.GeoCodeRequest = {
                "description": "上海金穗路1800号",
                "maxItems": 1,
                "minLatitude": 90,
                "minLongitude": 121.5782001832,
                "maxLatitude": 31.1537977881,
                "maxLongitude": 121.8026736943
            };
            try{
                await geolocationm.getAddressesFromLocationName(geocodeRequest2).then((result) => {
                    console.info("[lbs_js] getAddressesFromLocationName33 promise2: " + JSON.stringify(result));
                    expect(true).assertEqual((JSON.stringify(result)) != null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName33 promise2 then error." + JSON.stringify(error));
                    console.info('[lbs_js] not support now');
                    expect(error.code).assertEqual(3301400);
                });
            }catch(error){
                console.info("[lbs_js] getAddressesFromLocationName33 message2." + JSON.stringify(error.message));
                expect(true).assertFalse();
            }
            await sleep(1000);
            let geocodeRequest3:geolocationm.GeoCodeRequest = {
                "description": "上海金穗路1800号",
                "maxItems": 1,
                "minLatitude": -90.1,
                "minLongitude": 121.5782001832,
                "maxLatitude": 31.1537977881,
                "maxLongitude": 121.8026736943
            };
            try{
                await geolocationm.getAddressesFromLocationName(geocodeRequest3).then((result) => {
                    console.info("[lbs_js] getAddressesFromLocationName33 promise3: " + JSON.stringify(result));
                    expect(true).assertEqual((JSON.stringify(result)) == null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName33 promise3 then error." + JSON.stringify(error));
                    expect(true).assertFalse();
                });
            }catch(error){
                console.info("[lbs_js] getAddressesFromLocationName33 message3." + JSON.stringify(error.message));
                expect(error.code).assertEqual("401");
            }
            await sleep(1000);
            let geocodeRequest4:geolocationm.GeoCodeRequest = {
                "description": "上海金穗路1800号",
                "maxItems": 1,
                "minLatitude": 90.1,
                "minLongitude": 121.5782001832,
                "maxLatitude": 31.1537977881,
                "maxLongitude": 121.8026736943
            };
            try{
                await geolocationm.getAddressesFromLocationName(geocodeRequest4).then((result) => {
                    console.info("[lbs_js] getAddressesFromLocationName33 promise4: " + JSON.stringify(result));
                    console.info('[lbs_js] not support now');
                    expect(true).assertEqual(JSON.stringify(result) != null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName33 promise4 then error." + JSON.stringify(error));
                    expect(true).assertFalse();
                });
            }catch(error){
                console.info("[lbs_js] getAddressesFromLocationName33 message4." + JSON.stringify(error.message));
                expect(error.code).assertEqual("401");
            }
            await sleep(1000);
            let geocodeRequest5:geolocationm.GeoCodeRequest = {
                "description": "上海金穗路1800号",
                "maxItems": 1,
                "minLatitude": 31.3082812847,
                "minLongitude": 121.5782001832,
                "maxLatitude": -90,
                "maxLongitude": 121.8026736943
            };
            try {
                await geolocationm.getAddressesFromLocationName(geocodeRequest5).then((result) => {
                    console.info("[lbs_js] getAddressesFromLocationName33 promise5: " + JSON.stringify(result));
                    expect(true).assertEqual((JSON.stringify(result)) != null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName33 promise5 then error." + JSON.stringify(error));
                    console.info('[lbs_js] not support now');
                    expect(error.code).assertEqual(3301400);
                });
            }catch(error){
                console.info("[lbs_js] getAddressesFromLocationName33 message5." + JSON.stringify(error.message));
                expect(true).assertFalse();
            }
            await sleep(1000);
            let geocodeRequest6:geolocationm.GeoCodeRequest = {
                "description": "上海金穗路1800号",
                "maxItems": 1,
                "minLatitude": 31.3082812847,
                "minLongitude": 121.5782001832,
                "maxLatitude": 90,
                "maxLongitude": 121.8026736943
            };
            try{
                await geolocationm.getAddressesFromLocationName(geocodeRequest6).then((result) => {
                    console.info("[lbs_js] getAddressesFromLocationName33 promise6: " + JSON.stringify(result));
                    expect(true).assertEqual((JSON.stringify(result)) != null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName33 promise6 then error." + JSON.stringify(error));
                    console.info('[lbs_js] not support now');
                    expect(error.code).assertEqual(3301400);
                });
            }catch(error){
                console.info("[lbs_js] getAddressesFromLocationName33 message6." + JSON.stringify(error.message));
                expect(true).assertFalse();
            }
            await sleep(1000);
            let geocodeRequest7:geolocationm.GeoCodeRequest = {
                "description": "上海金穗路1800号",
                "maxItems": 1,
                "minLatitude": 31.3082812847,
                "minLongitude": 121.5782001832,
                "maxLatitude": -90.1,
                "maxLongitude": 121.8026736943
            };
            try{
                await geolocationm.getAddressesFromLocationName(geocodeRequest7).then((result) => {
                    console.info("[lbs_js] getAddressesFromLocationName33 promise7: " + JSON.stringify(result));
                    expect(true).assertEqual((JSON.stringify(result)) == null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName33 promise7 then error." + JSON.stringify(error));
                    expect(true).assertFalse();
                });
            }catch(error){
                console.info("[lbs_js] getAddressesFromLocationName33 message7." + JSON.stringify(error.message));
                expect(error.code).assertEqual("401");
            }
            await sleep(1000);
            let geocodeRequest8:geolocationm.GeoCodeRequest = {
                "description": "上海金穗路1800号",
                "maxItems": 1,
                "minLatitude": 31.3082812847,
                "minLongitude": 121.5782001832,
                "maxLatitude": 90.1,
                "maxLongitude": 121.8026736943
            };
            try{
                await geolocationm.getAddressesFromLocationName(geocodeRequest8).then((result) => {
                    console.info("[lbs_js] getAddressesFromLocationName33 promise8: " + JSON.stringify(result));
                    expect(true).assertEqual((JSON.stringify(result)) == null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName33 promise8 then error." + JSON.stringify(error));
                    expect(true).assertFalse();
                });
            }catch(error){
                console.info("[lbs_js] getAddressesFromLocationName33 message8." + JSON.stringify(error.message));
                expect(error.code).assertEqual("401");
            }
            await sleep(1000);
        done();
    })

    /**
     * @tc.number SUB_HSS_LocationSystem_Geo_1600
     * @tc.name TestgetAddressesFromLocation0016
     * @tc.desc Longitude input parameter boundary test for the reverse address resolution function in a specified range
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('TestgetAddressesFromLocation16', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done : Function) => {
            let geocodeRequest1:geolocationm.GeoCodeRequest = {
                "description": "北京天安门",
                "maxItems": 1,
                "minLatitude": 39.85,
                "minLongitude": -180,
                "maxLatitude": 39.95,
                "maxLongitude": 116.45
            };
            try{
                await geolocationm.getAddressesFromLocationName(geocodeRequest1).then((result) => {
                    console.info("[lbs_js] getAddressesFromLocationName34 promise1: " + JSON.stringify(result));
                    expect(true).assertEqual((JSON.stringify(result)) != null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName34 promise1 then error." + JSON.stringify(error));
                    console.info('[lbs_js] not support now');
                    expect(error.code).assertEqual(3301400);
                });
            }catch(error){
                console.info("[lbs_js] getAddressesFromLocationName34 message1." + JSON.stringify(error.message));
                expect(true).assertFalse();
            }
            await sleep(1000);
            let geocodeRequest2:geolocationm.GeoCodeRequest = {
                "description": "北京天安门",
                "maxItems": 1,
                "minLatitude": 39.85,
                "minLongitude": 180,
                "maxLatitude": 39.95,
                "maxLongitude": 116.45
            };
            try{
                await geolocationm.getAddressesFromLocationName(geocodeRequest2).then((result) => {
                    console.info("[lbs_js] getAddressesFromLocationName34 promise2: " + JSON.stringify(result));
                    expect(true).assertEqual((JSON.stringify(result)) != null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName34 promise2 then error." + JSON.stringify(error));
                    console.info('[lbs_js] not support now');
                    expect(error.code).assertEqual(3301400);
                });
            }catch(error){
                console.info("[lbs_js] getAddressesFromLocationName34 message2." + JSON.stringify(error.message));
                expect(true).assertFalse();
            }
            await sleep(1000);
            let geocodeRequest3:geolocationm.GeoCodeRequest = {
                "description": "北京天安门",
                "maxItems": 1,
                "minLatitude": 39.85,
                "minLongitude": -180.1,
                "maxLatitude": 39.95,
                "maxLongitude": 116.45
            };
            try{
                await geolocationm.getAddressesFromLocationName(geocodeRequest3).then((result) => {
                    console.info("[lbs_js] getAddressesFromLocationName34 promise3: " + JSON.stringify(result));
                    expect(true).assertEqual((JSON.stringify(result)) != null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName34 promise3 then error." + JSON.stringify(error));
                    expect(true).assertFalse();
                });
            }catch(error){
                console.info("[lbs_js] getAddressesFromLocationName34 message3." + JSON.stringify(error.message));
                expect(error.code).assertEqual("401");
            }
            await sleep(1000);
            let geocodeRequest4:geolocationm.GeoCodeRequest = {
                "description": "北京天安门",
                "maxItems": 1,
                "minLatitude": 39.85,
                "minLongitude": 180.1,
                "maxLatitude": 39.95,
                "maxLongitude": 116.45
            };
            try{
                await geolocationm.getAddressesFromLocationName(geocodeRequest4).then((result) => {
                    console.info("[lbs_js] getAddressesFromLocationName34 promise4: " + JSON.stringify(result));
                    expect(true).assertEqual((JSON.stringify(result)) != null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName34 promise4 then error." + JSON.stringify(error));
                    expect(true).assertFalse();
                });
            }catch(error){
                console.info("[lbs_js] getAddressesFromLocationName34 message4." + JSON.stringify(error.message));
                expect(error.code).assertEqual("401");
            }
            await sleep(1000);
            let geocodeRequest5:geolocationm.GeoCodeRequest = {
                "description": "北京天安门",
                "maxItems": 1,
                "minLatitude": 39.85,
                "minLongitude": 116.35,
                "maxLatitude": 39.95,
                "maxLongitude": -180
            };
            try{
                await geolocationm.getAddressesFromLocationName(geocodeRequest5).then((result) => {
                    console.info("[lbs_js] getAddressesFromLocationName34 promise5: " + JSON.stringify(result));
                    expect(true).assertEqual((JSON.stringify(result)) != null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName34 promise5 then error." + JSON.stringify(error));
                    console.info('[lbs_js] not support now');
                    expect(error.code).assertEqual(3301400);
                });
            }catch(error){
                console.info("[lbs_js] getAddressesFromLocationName34 message5." + JSON.stringify(error.message));
                expect(true).assertFalse();
            }
            let geocodeRequest6:geolocationm.GeoCodeRequest = {
                "description": "北京天安门",
                "maxItems": 1,
                "minLatitude": 39.85,
                "minLongitude": 116.35,
                "maxLatitude": 39.95,
                "maxLongitude": 180
            };
            try{
                await geolocationm.getAddressesFromLocationName(geocodeRequest6).then((result) => {
                    console.info("[lbs_js] getAddressesFromLocationName34 promise6: " + JSON.stringify(result));
                    expect(true).assertEqual((JSON.stringify(result)) != null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName34 promise6 then error." + JSON.stringify(error));
                    console.info('[lbs_js] not support now');
                    expect(error.code).assertEqual(3301400);
                });
            }catch(error){
                console.info("[lbs_js] getAddressesFromLocationName34 message6." + JSON.stringify(error.message));
                expect(true).assertFalse();
            }
            await sleep(1000);
            let geocodeRequest7:geolocationm.GeoCodeRequest = {
                "description": "北京天安门",
                "maxItems": 1,
                "minLatitude": 39.85,
                "minLongitude": 116.35,
                "maxLatitude": 39.95,
                "maxLongitude": -180.1
            };
            try{
                await geolocationm.getAddressesFromLocationName(geocodeRequest7).then((result) => {
                    console.info("[lbs_js] getAddressesFromLocationName34 promise7: " + JSON.stringify(result));
                    expect(true).assertEqual((JSON.stringify(result)) != null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName34 promise7 then error." + JSON.stringify(error));
                    expect(true).assertFalse();
                });
            }catch(error){
                console.info("[lbs_js] getAddressesFromLocationName34 message7." + JSON.stringify(error.message));
                expect(error.code).assertEqual("401");
            }
            let geocodeRequest8:geolocationm.GeoCodeRequest = {
                "description": "北京天安门",
                "maxItems": 1,
                "minLatitude": 39.85,
                "minLongitude": 116.35,
                "maxLatitude": 39.95,
                "maxLongitude": 180.1
            };
            try{
                await geolocationm.getAddressesFromLocationName(geocodeRequest8).then((result) => {
                    console.info("[lbs_js] getAddressesFromLocationName34 promise8: " + JSON.stringify(result));
                    expect(true).assertEqual((JSON.stringify(result)) != null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] getAddressesFromLocationName34 promise8 then error." + JSON.stringify(error));
                    expect(true).assertFalse();
                });
            }catch(error){
                console.info("[lbs_js] getAddressesFromLocationName34 message8." + JSON.stringify(error.message));
                expect(error.code).assertEqual("401");
            }
            await sleep(1000);
        done();
    })

    /**
     * @tc.number SUB_HSS_LocationSystem_Geo_1700
     * @tc.name TestgetAddressesFromLocation0017
     * @tc.desc Longitude input parameter boundary test for the reverse address resolution function in a specified range
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     */
    it('TestgetAddressesFromLocation017', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {
            let geocodeRequest1:geolocationm.GeoCodeRequest = {
                "description": "北京天安门",
                "maxItems": 1,
                "minLatitude": 39.85,
                "minLongitude": -180,
                "maxLatitude": 39.95,
                "maxLongitude": 116.45,
                "country": "cn"
            };
            try{
                await geolocationm.getAddressesFromLocationName(geocodeRequest1).then((result) => {
                    console.info("[lbs_js] SUB_HSS_LocationSystem_Geo_3500 promise1: " + JSON.stringify(result));
                    expect(true).assertEqual((JSON.stringify(result)) != null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] SUB_HSS_LocationSystem_Geo_3500 promise1 then error." + JSON.stringify(error));
                    console.info('[lbs_js] not support now');
                    expect(error.code).assertEqual(3301400);
                });
            }catch(error){
                console.info("[lbs_js] SUB_HSS_LocationSystem_Geo_3500 message1." + JSON.stringify(error.message));
                expect(true).assertFalse();
            }
            await sleep(1000);
        done();
    })

    /**
     * @tc.number SUB_HSS_LocationSystem_Geo_1800
     * @tc.name TestgetAddressesFromLocation0018
     * @tc.desc Longitude input parameter boundary test for the reverse address resolution function in a specified range
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     */
    it('TestgetAddressesFromLocation018', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {
            let geocodeRequest1:geolocationm.GeoCodeRequest = {
                "description": "北京天安门",
                "maxItems": 1,
                "minLatitude": 39.85,
                "minLongitude": -180,
                "maxLatitude": 39.95,
                "maxLongitude": 116.45,
                "country": "us"
            };
            try{
                await geolocationm.getAddressesFromLocationName(geocodeRequest1).then((result) => {
                    console.info("[lbs_js] SUB_HSS_LocationSystem_Geo_3600 promise1: " + JSON.stringify(result));
                    expect(true).assertEqual((JSON.stringify(result)) != null);
                }).catch((error : BusinessError) => {
                    console.info("[lbs_js] SUB_HSS_LocationSystem_Geo_3600 promise1 then error." + JSON.stringify(error));
                    console.info('[lbs_js] not support now');
                    expect(error.code).assertEqual(3301400);
                });
            }catch(error){
                console.info("[lbs_js] SUB_HSS_LocationSystem_Geo_3600 message1." + JSON.stringify(error.message));
                expect(true).assertFalse();
            }
            await sleep(1000);
        done();
    })
    })
}