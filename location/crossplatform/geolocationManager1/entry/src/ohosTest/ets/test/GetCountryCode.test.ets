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

function sleep(ms: number): Promise<void> {
    return new Promise((resolve) => {
        setTimeout(resolve, ms);
    });
}

enum  CountryCodeType {
        COUNTRY_CODE_FROM_LOCALE = 1,
        COUNTRY_CODE_FROM_SIM = 2,
        COUNTRY_CODE_FROM_LOCATION = 3,
        COUNTRY_CODE_FROM_NETWORK = 4,
    }

export default function geolocationTest_geo4() {


    describe('geolocationTest_geo4', () => {
        beforeAll(async (done : Function) => {
            console.info('beforeAll case');
            await sleep(3000);
            done();
        })
    
        beforeEach(async (done : Function) => {
            console.info('beforeEach case');
            await sleep(3000);
            done();
        })
    
    /**
     * @tc.number SUB_HSS_LocationSystem_CountryCode_0100
     * @tc.name TestgetCountryCode0001
     * @tc.desc Obtaining Country Code Information
     * @tc.type Function
     * @tc.level Level 1
     */
     it('TestgetCountryCode0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {
        try {
            await geolocationm.getCountryCode().then((result) => {
                console.info("[lbs_js] getCountryCode promise result: " + JSON.stringify(result));
                console.info("[lbs_js] country :" + result.country);
                console.info("[lbs_js] type: " + result.type);
                expect(true).assertEqual(result!=null);
                expect(true).assertEqual(JSON.stringify(result.country)!=null);
                expect(true).assertEqual(JSON.stringify(result.type)!=null);
            }).catch((error : BusinessError) => {
                console.info("[lbs_js] getCountryCode promise then error."  + JSON.stringify(error));
                expect().assertFail();
            });
        } catch (error) {
            console.info("[lbs_js] getCountryCode promise try err."  + JSON.stringify(error));
            expect().assertFail();
        }
        done();
    })

    /**
     * @tc.number SUB_HSS_LocationSystem_CountryCode_0200
     * @tc.name TestgetCountryCode0002
     * @tc.desc Obtaining Country Code Information
     * @tc.type Function
     * @tc.level Level 1
     */
     it('TestgetCountryCode0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {
        try {
            geolocationm.getCountryCode((err,data) => {
                if (err) {
                    return console.info("getCountryCode callback err:  " + JSON.stringify(err));
                } else {
                    console.info("getCountryCode callback success"+ JSON.stringify(data));
                    expect(true).assertEqual(data != null);
                }
            });
        } catch (error) {
            console.info("[lbs_js] getCountryCode callback try err."  + JSON.stringify(error));
            expect().assertFail();
        }
        await sleep(1000);
        done();
    })

    /**
     * @tc.number SUB_HSS_LocationSystem_CountryCode_0300
     * @tc.name testgetCountryCodeonoff0003
     * @tc.desc The interception country code is changed.
     * @tc.type Function
     * @tc.level Level 1
     */
    it('testgetCountryCodeonoff0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {
        console.info("[lbs_js] countryCodeChange");
        try {
            geolocationm.on('countryCodeChange', (data)=> {
                console.info('[lbs_js] countryCodeChange' +JSON.stringify(data) );
            });
        } catch (error) {
            console.info("[lbs_js] countryCodeChangeOn try err."  + JSON.stringify(error));
            expect(true).assertEqual(JSON.stringify(error)!=null);
        }
        try {
            await geolocationm.getCountryCode().then((result) => {
                console.info("[lbs_js] getCountryCode promise result: " + JSON.stringify(result));
                expect(true).assertEqual(JSON.stringify(result)!=null);
            }).catch((error : BusinessError) => {
                console.info("[lbs_js] getCountryCode promise then error."  + JSON.stringify(error));
                expect().assertFail();
            });
        } catch (error) {
            console.info("[lbs_js] getCountryCode callback try err."  + JSON.stringify(error));
            expect().assertFail();
        }
        try {
            geolocationm.off('countryCodeChange', (data)=> {
                console.info('[lbs_js] countryCodeChange' + JSON.stringify(data));
            })
        } catch (error) {
            console.info("[lbs_js] countryCodeChangeOff try err."  + JSON.stringify(error));
            expect(true).assertEqual(JSON.stringify(error)!=null);
        }
        done();
    });

    /**
     * @tc.number SUB_HSS_LocationSystem_CountryCode_0400
     * @tc.name TestgetCountryCode0004
     * @tc.desc Obtaining Country Code Information
     * @tc.type Function
     * @tc.level Level 1
     */
    it('TestgetCountryCode0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done : Function) => {
        try {
            await geolocationm.getCountryCode().then((result) => {
                console.info("[lbs_js] getCountryCode promise result: " + JSON.stringify(result));
                console.info("[lbs_js] country :" + result.country);
                console.info("[lbs_js] type: " + result.type);
                expect(true).assertEqual(result!=null);
                expect(true).assertEqual(JSON.stringify(result.country)!=null);
                expect(true).assertEqual(JSON.stringify(result.type)!=null);
            }).catch((error : BusinessError) => {
                console.info("[lbs_js] getCountryCode promise then error."  + JSON.stringify(error));
                expect().assertFail();
            });
        } catch (error) {
            console.info("[lbs_js] getCountryCode promise try err." + JSON.stringify(error));
            if (error.code == "801") {
                expect(error.code).assertEqual("801")
            } else {
                expect().assertFail();
            }
        }
        done();
    })
    
    })
}

