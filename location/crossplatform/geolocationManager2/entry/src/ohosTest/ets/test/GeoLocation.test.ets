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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Size, Level } from '@ohos/hypium';
import geoLocationManager from '@ohos.geoLocationManager';
import { BusinessError } from '@kit.BasicServicesKit';
import { notificationManager } from '@kit.NotificationKit';
import { abilityAccessCtrl, common, Permissions } from '@kit.AbilityKit';
import AtManager from '@ohos.abilityAccessCtrl';

let context: common.UIAbilityContext;

function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
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

export default function geolocationTest() {
  describe('geolocationTest', () => {
    beforeAll(async () => {
      context = globalThis.abilityContext;
      const isAllGranted = await reqPermissionsFromUser(LOCATION_PERMISSIONS, context as common.UIAbilityContext);
      if (!isAllGranted) {
        console.error('no permission');
        throw new Error('no permission');
      }
      console.info('beforeAll case');
      await sleep(3000);
    })
    beforeEach(async () => {
      console.info('beforeEach case');
    })
    afterEach(async () => {
      await sleep(3000)
    })
    afterAll(() => {
    })


    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_ON_0100
     * @tc.name      : testLocationOn0001
     * @tc.desc      : priority is an abnormal value, expecting a return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationOn0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let requestInfo: geoLocationManager.LocationRequest = {
        'priority': -1,
        'scenario': 0x300,
        'timeInterval': 1,
        'distanceInterval': 0,
        'maxAccuracy': 0
      };
      let locationChange = (location: geoLocationManager.Location): void => {
        console.info('locationChange: data: ' + JSON.stringify(location));
      };
      try {
        geoLocationManager.on('locationChange', requestInfo, locationChange);
        expect(true).assertFail();
      } catch (error) {
        console.info("[lbs_js] testLocationOn001 try err." + JSON.stringify(error));
        expect(error.code).assertEqual("401");
      }
      done();
    });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_ON_0200
     * @tc.name      : testLocationOn0002
     * @tc.desc      : priority is empty, verify normal functionality
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationOn0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let requestInfo: geoLocationManager.LocationRequest = {
        'scenario': 0x300,
        'timeInterval': 1,
        'distanceInterval': 0,
        'maxAccuracy': 0
      };
      let locationChange = (location: geoLocationManager.Location): void => {
        console.info('locationChange: data: ' + JSON.stringify(location));
      };
      try {
        geoLocationManager.on('locationChange', requestInfo, locationChange);
      } catch (error) {
        console.info("[lbs_js] testLocationOn002 try err." + JSON.stringify(error));
        expect(true).assertFail();
      }
      await sleep(2000);
      done();
    });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_ON_0300
     * @tc.name      : testLocationOn0003
     * @tc.desc      : scenario is empty, verify normal functionality
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationOn0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let requestInfo: geoLocationManager.LocationRequest = {
        'priority': 0x200,
        'timeInterval': 1,
        'distanceInterval': 0,
        'maxAccuracy': 0
      };
      let locationChange = (location: geoLocationManager.Location): void => {
        console.info('locationChange: data: ' + JSON.stringify(location));
      };
      try {
        geoLocationManager.on('locationChange', requestInfo, locationChange);
      } catch (error) {
        console.info("[lbs_js] testLocationOn003 try err." + JSON.stringify(error));
        expect(true).assertFail();
      }
      await sleep(2000);
      done();
    });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_ON_0400
     * @tc.name      : testLocationOn0004
     * @tc.desc      : scenario is an abnormal value, expecting a return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationOn0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let requestInfo: geoLocationManager.LocationRequest = {
        'priority': 0x200,
        'scenario': -1,
        'timeInterval': 1,
        'distanceInterval': 0,
        'maxAccuracy': 0
      };
      let locationChange = (location: geoLocationManager.Location): void => {
        console.info('locationChange: data: ' + JSON.stringify(location));
      };
      try {
        geoLocationManager.on('locationChange', requestInfo, locationChange);
        expect(true).assertFail();
      } catch (error) {
        console.info("[lbs_js] testLocationOn004 try err." + JSON.stringify(error));
        expect(error.code).assertEqual("401");
      }
      await sleep(2000);
      done();
    });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_ON_0500
     * @tc.name      : testLocationOn0005
     * @tc.desc      : timeInterval is empty, verify normal functionality
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationOn0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let requestInfo: geoLocationManager.LocationRequest = {
        'priority': 0x200,
        'scenario': 0x300,
        'distanceInterval': 0,
        'maxAccuracy': 0
      };
      let locationChange = (location: geoLocationManager.Location): void => {
        console.info('locationChange: data: ' + JSON.stringify(location));
      };
      try {
        geoLocationManager.on('locationChange', requestInfo, locationChange);
      } catch (error) {
        console.info("[lbs_js] testLocationOn005 try err." + JSON.stringify(error));
        expect(true).assertFail();
      }
      await sleep(2000);
      done();
    });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_ON_0600
     * @tc.name      : testLocationOn0006
     * @tc.desc      : timeInterval is an abnormal value, expecting a return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationOn0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let requestInfo: geoLocationManager.LocationRequest = {
        'priority': 0x200,
        'scenario': 0x300,
        'timeInterval': -1,
        'distanceInterval': 0,
        'maxAccuracy': 0
      };
      let locationChange = (location: geoLocationManager.Location): void => {
        console.info('locationChange: data: ' + JSON.stringify(location));
      };
      try {
        geoLocationManager.on('locationChange', requestInfo, locationChange);
        expect(true).assertFail();
      } catch (error) {
        console.info("[lbs_js] testLocationOn006 try err." + JSON.stringify(error));
        expect(error.code).assertEqual("401");
      }
      await sleep(2000);
      done();
    });


    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_ON_0700
     * @tc.name      : testLocationOn0007
     * @tc.desc      : maxAccuracy is empty, verify normal functionality
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationOn0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let requestInfo: geoLocationManager.LocationRequest = {
        'priority': 0x200,
        'scenario': 0x300,
        'timeInterval': 1,
        'distanceInterval': 0
      };
      let locationChange = (location: geoLocationManager.Location): void => {
        console.info('locationChange: data: ' + JSON.stringify(location));
      };
      try {
        geoLocationManager.on('locationChange', requestInfo, locationChange);
      } catch (error) {
        console.info("[lbs_js] testLocationOn007 try err." + JSON.stringify(error));
        expect(true).assertFail();
      }
      await sleep(2000);
      done();
    });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_ON_0800
     * @tc.name      : testLocationOn0008
     * @tc.desc      : maxAccuracy is an abnormal value, expecting a return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationOn0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let requestInfo: geoLocationManager.LocationRequest = {
        'priority': 0x200,
        'scenario': 0x300,
        'timeInterval': 1,
        'distanceInterval': 0,
        'maxAccuracy': -1,
      };
      let locationChange = (location: geoLocationManager.Location): void => {
        console.info('locationChange: data: ' + JSON.stringify(location));
      };
      try {
        geoLocationManager.on('locationChange', requestInfo, locationChange);
        expect(true).assertFail();
      } catch (error) {
        console.info("[lbs_js] testLocationOn008 try err." + JSON.stringify(error));
        expect(error.code).assertEqual("401");
      }
      await sleep(2000);
      done();
    });


    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_ON_0900
     * @tc.name      : testLocationOn0009
     * @tc.desc      : distanceInterval is empty, verify normal functionality
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationOn0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let requestInfo: geoLocationManager.LocationRequest = {
        'priority': 0x200,
        'scenario': 0x300,
        'timeInterval': 1,
        'maxAccuracy': 0
      };
      let locationChange = (location: geoLocationManager.Location): void => {
        console.info('locationChange: data: ' + JSON.stringify(location));
      };
      try {
        geoLocationManager.on('locationChange', requestInfo, locationChange);
      } catch (error) {
        console.info("[lbs_js] testLocationOn009 try err." + JSON.stringify(error));
        expect(true).assertFail();
      }
      await sleep(2000);
      done();
    });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_ON_1000
     * @tc.name      : testLocationOn0010
     * @tc.desc      : distanceInterval is an abnormal value, expecting a return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationOn0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let requestInfo: geoLocationManager.LocationRequest = {
        'priority': 0x200,
        'scenario': 0x300,
        'timeInterval': 1,
        'maxAccuracy': 0,
        'distanceInterval': -1,
      };
      let locationChange = (location: geoLocationManager.Location): void => {
        console.info('locationChange: data: ' + JSON.stringify(location));
      };
      try {
        geoLocationManager.on('locationChange', requestInfo, locationChange);
        expect(true).assertFail();
      } catch (error) {
        console.info("[lbs_js] testLocationOn010 try err." + JSON.stringify(error));
        expect(error.code).assertEqual("401");
      }
      await sleep(2000);
      done();
    });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_0100
     * @tc.name      : testLocationAddressesFromLocation0001
     * @tc.desc      : When creating ReverseGeoCodeRequest without setting locale, verify the function executes normally
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationAddressesFromLocation0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let reverseGeocodeRequest: geoLocationManager.ReverseGeoCodeRequest =
          { "latitude": 31.265496, "longitude": 121.62771, "maxItems": 1 };
        try {
          geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest, (err, data) => {
            if (err) {
              console.info('[lbs_js] testLocationAddressesFromLocation001 err is : ' + JSON.stringify(err));
              expect(true).assertFail();
            } else {
              console.info("[lbs_js] testLocationAddressesFromLocation001 data is: " + JSON.stringify(data));
              expect(true).assertEqual((JSON.stringify(data)) != null);
            }
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocation001 try err:" + JSON.stringify(error));
          expect(true).assertFail();
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_0200
     * @tc.name      : testLocationAddressesFromLocation0002
     * @tc.desc      : When creating ReverseGeoCodeRequest without setting country, verify the function executes normally
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationAddressesFromLocation0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let reverseGeocodeRequest: geoLocationManager.ReverseGeoCodeRequest =
          {
            "latitude": 31.265496,
            "longitude": 121.62771,
            "maxItems": 1,
            "locale": "zh"
          };
        try {
          geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest, (err, data) => {
            if (err) {
              console.info('[lbs_js]  testLocationAddressesFromLocation002 callback err is : ' + JSON.stringify(err));
              expect(true).assertFail();
            } else {
              console.info("[lbs_js]  testLocationAddressesFromLocation002 callback data is: " + JSON.stringify(data));
              expect(true).assertEqual((JSON.stringify(data)) != null);
            }
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocation002 try err:" + JSON.stringify(error));
          expect(true).assertFail();
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_0300
     * @tc.name      : testLocationAddressesFromLocation0003
     * @tc.desc      : When creating ReverseGeoCodeRequest without setting maxitem, verify the function executes normally
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationAddressesFromLocation0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let reverseGeocodeRequest: geoLocationManager.ReverseGeoCodeRequest =
          {
            "latitude": 31.265496,
            "longitude": 121.62771,
            "locale": "zh",
            "country": "CN"
          };
        try {
          geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest, (err, data) => {
            if (err) {
              console.info('[lbs_js] testLocationAddressesFromLocation003 err is : ' + JSON.stringify(err));
              expect(true).assertFail();
            } else {
              console.info("[lbs_js] testLocationAddressesFromLocation003 data is: " + JSON.stringify(data));
              expect(true).assertEqual((JSON.stringify(data)) != null);
            }
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocation003 try err:" + JSON.stringify(error));
          expect(true).assertFail();
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_0400
     * @tc.name      : testLocationAddressesFromLocation0004
     * @tc.desc      : When latitude  in ReverseGeoCodeRequest are abnormal values, expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationAddressesFromLocation0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let reverseGeocodeRequest: geoLocationManager.ReverseGeoCodeRequest =
          {
            "latitude": 100,
            "longitude": 121.62771,
            "locale": "zh",
            "country": "CN"
          };
        try {
          geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest, (err, data) => {
            if (err) {
              console.info('[lbs_js] testLocationAddressesFromLocation004 err is : ' + JSON.stringify(err));
              expect(err.code).assertEqual("401");
            } else {
              console.info("[lbs_js] testLocationAddressesFromLocation004 data is: " + JSON.stringify(data));
              expect(true).assertFail();
            }
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocation004 try err:" + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_0500
     * @tc.name      : testLocationAddressesFromLocation0005
     * @tc.desc      : Pole coordinates, expecting return of 3301300
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationAddressesFromLocation0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let reverseGeocodeRequest: geoLocationManager.ReverseGeoCodeRequest =
          {
            "latitude": 0,
            "longitude": 121.62771,
            "locale": "zh",
            "country": "CN"
          };
        try {
          geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest, (err, data) => {
            if (err) {
              console.info('[lbs_js] testLocationAddressesFromLocation005 err is : ' + JSON.stringify(err));
              expect(err.code).assertEqual(3301300);
            } else {
              console.info("[lbs_js] testLocationAddressesFromLocation005 data is: " + JSON.stringify(data));
              expect(true).assertEqual((JSON.stringify(data)) != null);
            }
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocation005 try err:" + JSON.stringify(error));
          expect(error.code).assertEqual(3301300);
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_0600
     * @tc.name      : testLocationAddressesFromLocationPromise0001
     * @tc.desc      : When creating ReverseGeoCodeRequest without setting locale, verify the function executes normally
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationAddressesFromLocationPromise0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let reverseGeocodeRequest: geoLocationManager.ReverseGeoCodeRequest =
          {
            "latitude": 31.265496,
            "longitude": 121.62771,
            "maxItems": 5,
            "country": "CN"
          };
        try {
          await geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest).then((data) => {
            console.info('[lbs_js] testLocationAddressesFromLocationPromise001 promise: ' + JSON.stringify(data));
            expect(true).assertEqual((JSON.stringify(data)) != null);
          }).catch((error: BusinessError) => {
            console.info("[lbs_js] testLocationAddressesFromLocationPromise001 error." + JSON.stringify(error));
            console.info('[lbs_js] not support now');
            expect(true).assertFail();
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationPromise001 try err:" + JSON.stringify(error));
          expect(true).assertFail();
        }
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_0700
     * @tc.name      : testLocationAddressesFromLocationPromise0002
     * @tc.desc      : When creating ReverseGeoCodeRequest without setting country, verify the function executes normally
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationAddressesFromLocationPromise0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let reverseGeocodeRequest: geoLocationManager.ReverseGeoCodeRequest =
          {
            "latitude": 31.265496,
            "longitude": 121.62771,
            "maxItems": 5,
            "locale": "zh"
          };
        try {
          await geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest).then((data) => {
            console.info('[lbs_js] testLocationAddressesFromLocationPromise002 promise: ' + JSON.stringify(data));
            expect(true).assertEqual((JSON.stringify(data)) != null);
          }).catch((error: BusinessError) => {
            console.info("[lbs_js] testLocationAddressesFromLocationPromise002 then error." + JSON.stringify(error));
            console.info('[lbs_js] not support now');
            expect(true).assertFail();
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationPromise002 try err:" + JSON.stringify(error));
          expect(true).assertFail();
        }
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_0800
     * @tc.name      : testLocationAddressesFromLocationPromise0003
     * @tc.desc      : When creating ReverseGeoCodeRequest without setting maxitem, verify the function executes normally
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationAddressesFromLocationPromise0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let reverseGeocodeRequest: geoLocationManager.ReverseGeoCodeRequest =
          {
            "latitude": 31.265496,
            "longitude": 121.62771,
            "locale": "zh",
            "country": "CN"
          };
        try {
          await geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest).then((data) => {
            console.info('[lbs_js] testLocationAddressesFromLocationPromise003 promise: ' + JSON.stringify(data));
            expect(true).assertEqual((JSON.stringify(data)) != null);
          }).catch((error: BusinessError) => {
            console.info("[lbs_js] testLocationAddressesFromLocationPromise003 then error." + JSON.stringify(error));
            console.info('[lbs_js] not support now');
            expect(true).assertFail();
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationPromise003 try err:" + JSON.stringify(error));
          expect(true).assertFail();
        }
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_0900
     * @tc.name      : testLocationAddressesFromLocationPromise0004
     * @tc.desc      : When latitude in ReverseGeoCodeRequest are abnormal values, expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationAddressesFromLocationPromise0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let reverseGeocodeRequest: geoLocationManager.ReverseGeoCodeRequest =
          {
            "latitude": 100,
            "longitude": 121.62771,
            "locale": "zh",
            "country": "CN"
          };
        try {
          await geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest).then((data) => {
            console.info('[lbs_js] testLocationAddressesFromLocationPromise004 promise: ' + JSON.stringify(data));
            expect(true).assertFail();
          }).catch((error: BusinessError) => {
            console.info("[lbs_js] testLocationAddressesFromLocationPromise004 then error." + JSON.stringify(error));
            console.info('[lbs_js] not support now');
            expect(error.code).assertEqual("401");
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationPromise004 try err:" + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_1000
     * @tc.name      : testLocationAddressesFromLocationPromise0005
     * @tc.desc      : Pole coordinates, expecting return of 3301300
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationAddressesFromLocationPromise0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let reverseGeocodeRequest: geoLocationManager.ReverseGeoCodeRequest =
          {
            "latitude": 0,
            "longitude": 121.62771,
            "locale": "zh",
            "country": "CN"
          };
        try {
          await geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest).then((data) => {
            console.info('[lbs_js] testLocationAddressesFromLocationPromise005 promise: ' + JSON.stringify(data));
            expect(true).assertEqual((JSON.stringify(data)) != null);
          }).catch((error: BusinessError) => {
            console.info("[lbs_js] testLocationAddressesFromLocationPromise005 then error." + JSON.stringify(error));
            console.info('[lbs_js] not support now');
            expect(error.code).assertEqual(3301300);
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationPromise005 try err:" + JSON.stringify(error));
          expect(error.code).assertEqual(3301300);
        }
        done();
      });


    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_0100
     * @tc.name      : testLocationAddressesFromLocationName0001
     * @tc.desc      : When creating GeoCodeRequest without setting locale, verify the function executes normally and returns valid data
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationAddressesFromLocationName0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          let geocodeRequest: geoLocationManager.GeoCodeRequest = {
            "country": "CN",
            "description": "上海金穗路1800号",
            "maxItems": 1,
            "minLatitude": 90,
            "minLongitude": 121.5782001832,
            "maxLatitude": 31.1537977881,
            "maxLongitude": 121.8026736943
          };
          geoLocationManager.getAddressesFromLocationName(geocodeRequest, (err, data) => {
            if (err) {
              console.info('[lbs_js] testLocationAddressesFromLocationName001 err is:' + JSON.stringify(err));
              expect(true).assertFail();
            } else {
              console.info("[lbs_js] testLocationAddressesFromLocationName001 data is: " + JSON.stringify(data));
              expect(true).assertEqual((JSON.stringify(data)) != null);
            }
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationName001 try err." + JSON.stringify(error));
          expect(true).assertFail();
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_0200
     * @tc.name      : testLocationAddressesFromLocationName0002
     * @tc.desc      : When creating GeoCodeRequest without setting country, verify the function executes normally and returns valid data
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationAddressesFromLocationName0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          let geocodeRequest: geoLocationManager.GeoCodeRequest = {
            "locale": "zh",
            "description": "上海金穗路1800号",
            "maxItems": 1,
            "minLatitude": 90,
            "minLongitude": 121.5782001832,
            "maxLatitude": 31.1537977881,
            "maxLongitude": 121.8026736943
          };
          geoLocationManager.getAddressesFromLocationName(geocodeRequest, (err, data) => {
            if (err) {
              console.info('[lbs_js] testLocationAddressesFromLocationName002 err is:' + JSON.stringify(err));
              expect(true).assertFail();
            } else {
              console.info("[lbs_js] testLocationAddressesFromLocationName002 data is: " + JSON.stringify(data));
              expect(true).assertEqual((JSON.stringify(data)) != null);
            }
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationName002 try err." + JSON.stringify(error));
          expect(true).assertFail();
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_0300
     * @tc.name      : testLocationAddressesFromLocationName0003
     * @tc.desc      : When creating GeoCodeRequest without setting maxItems, verify the function executes normally and returns valid data
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationAddressesFromLocationName0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          let geocodeRequest: geoLocationManager.GeoCodeRequest = {
            "locale": "zh",
            "country": "CN",
            "description": "上海金穗路1800号",
            "minLatitude": 90,
            "minLongitude": 121.5782001832,
            "maxLatitude": 31.1537977881,
            "maxLongitude": 121.8026736943
          };
          geoLocationManager.getAddressesFromLocationName(geocodeRequest, (err, data) => {
            if (err) {
              console.info('[lbs_js] testLocationAddressesFromLocationName003 err is:' + JSON.stringify(err));
              expect(true).assertFail();
            } else {
              console.info("[lbs_js] testLocationAddressesFromLocationName003 data is: " + JSON.stringify(data));
              expect(true).assertEqual((JSON.stringify(data)) != null);
            }
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationName003 try err." + JSON.stringify(error));
          expect(true).assertFail();
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_0400
     * @tc.name      : testLocationAddressesFromLocationName0004
     * @tc.desc      : When creating GeoCodeRequest without setting minLatitude, verify the function executes normally and returns valid data
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationAddressesFromLocationName0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          let geocodeRequest: geoLocationManager.GeoCodeRequest = {
            "locale": "zh",
            "country": "CN",
            "description": "上海金穗路1800号",
            "maxItems": 1,
            "minLongitude": 121.5782001832,
            "maxLatitude": 31.1537977881,
            "maxLongitude": 121.8026736943
          };
          geoLocationManager.getAddressesFromLocationName(geocodeRequest, (err, data) => {
            if (err) {
              console.info('[lbs_js] testLocationAddressesFromLocationName004 err is:' + JSON.stringify(err));
              expect(true).assertFail();
            } else {
              console.info("[lbs_js] testLocationAddressesFromLocationName004 data is: " + JSON.stringify(data));
              expect(true).assertEqual((JSON.stringify(data)) != null);
            }
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationName004 try err." + JSON.stringify(error));
          expect(true).assertFail();
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_0500
     * @tc.name      : testLocationAddressesFromLocationName0005
     * @tc.desc      : When creating GeoCodeRequest without setting minLongitude, verify the function executes normally and returns valid data
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationAddressesFromLocationName0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          let geocodeRequest: geoLocationManager.GeoCodeRequest = {
            "locale": "zh",
            "country": "CN",
            "description": "上海金穗路1800号",
            "maxItems": 1,
            "minLatitude": 90,
            "maxLatitude": 31.1537977881,
            "maxLongitude": 121.8026736943
          };
          geoLocationManager.getAddressesFromLocationName(geocodeRequest, (err, data) => {
            if (err) {
              console.info('[lbs_js] testLocationAddressesFromLocationName005 err is:' + JSON.stringify(err));
              expect(true).assertFail();
            } else {
              console.info("[lbs_js] testLocationAddressesFromLocationName005 data is: " + JSON.stringify(data));
              expect(true).assertEqual((JSON.stringify(data)) != null);
            }
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationName005 try err." + JSON.stringify(error));
          expect(true).assertFail();
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_0600
     * @tc.name      : testLocationAddressesFromLocationName0006
     * @tc.desc      : When creating GeoCodeRequest without setting maxLatitude, verify the function executes normally and returns valid data
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationAddressesFromLocationName0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          let geocodeRequest: geoLocationManager.GeoCodeRequest = {
            "locale": "zh",
            "country": "CN",
            "description": "上海金穗路1800号",
            "maxItems": 1,
            "minLatitude": 90,
            "minLongitude": 121.5782001832,
            "maxLongitude": 121.8026736943
          };
          geoLocationManager.getAddressesFromLocationName(geocodeRequest, (err, data) => {
            if (err) {
              console.info('[lbs_js] testLocationAddressesFromLocationName006 err is:' + JSON.stringify(err));
              expect(true).assertFail();
            } else {
              console.info("[lbs_js] testLocationAddressesFromLocationName006 data is: " + JSON.stringify(data));
              expect(true).assertEqual((JSON.stringify(data)) != null);
            }
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationName006 try err." + JSON.stringify(error));
          expect(true).assertFail();
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_0700
     * @tc.name      : testLocationAddressesFromLocationName0007
     * @tc.desc      : When creating GeoCodeRequest without setting maxLongitude, verify the function executes normally and returns valid data
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationAddressesFromLocationName0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        try {
          let geocodeRequest: geoLocationManager.GeoCodeRequest = {
            "locale": "zh",
            "country": "CN",
            "description": "上海金穗路1800号",
            "maxItems": 1,
            "minLatitude": 90,
            "minLongitude": 121.5782001832,
            "maxLatitude": 31.1537977881,
          };
          geoLocationManager.getAddressesFromLocationName(geocodeRequest, (err, data) => {
            if (err) {
              console.info('[lbs_js] testLocationAddressesFromLocationName007 err is:' + JSON.stringify(err));
              expect(true).assertFail();
            } else {
              console.info("[lbs_js] testLocationAddressesFromLocationName007 data is: " + JSON.stringify(data));
              expect(true).assertEqual((JSON.stringify(data)) != null);
            }
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationName007 try err." + JSON.stringify(error));
          expect(true).assertFail();
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_0800
     * @tc.name      : testLocationAddressesFromLocationName0008
     * @tc.desc      : When minLatitude in GeoCodeRequest is an abnormal value, expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationAddressesFromLocationName0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let geocodeRequest: geoLocationManager.GeoCodeRequest = {
            "locale": "zh",
            "country": "CN",
            "description": "上海金穗路1800号",
            "maxItems": 1,
            "minLatitude": 100,
            "minLongitude": 121.5782001832,
            "maxLatitude": 31.1537977881,
          };
          geoLocationManager.getAddressesFromLocationName(geocodeRequest, (err, data) => {
            if (err) {
              console.info('[lbs_js] testLocationAddressesFromLocationName007 err is:' + JSON.stringify(err));
              expect(err.code).assertEqual("401");
            } else {
              console.info("[lbs_js] testLocationAddressesFromLocationName007 data is: " + JSON.stringify(data));
              expect(true).assertFail();
            }
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationName007 try err." + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_0900
     * @tc.name      : testLocationAddressesFromLocationName0009
     * @tc.desc      : When minLongitude in GeoCodeRequest is an abnormal value, expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationAddressesFromLocationName0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let geocodeRequest: geoLocationManager.GeoCodeRequest = {
            "locale": "zh",
            "country": "CN",
            "description": "上海金穗路1800号",
            "maxItems": 1,
            "minLatitude": 90,
            "minLongitude": 200,
            "maxLatitude": 31.1537977881,
          };
          geoLocationManager.getAddressesFromLocationName(geocodeRequest, (err, data) => {
            if (err) {
              console.info('[lbs_js] testLocationAddressesFromLocationName007 err is:' + JSON.stringify(err));
              expect(err.code).assertEqual("401");
            } else {
              console.info("[lbs_js] testLocationAddressesFromLocationName007 data is: " + JSON.stringify(data));
              expect(true).assertFail();
            }
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationName007 try err." + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_1000
     * @tc.name      : testLocationAddressesFromLocationName0010
     * @tc.desc      : When maxLatitude in GeoCodeRequest is an abnormal value, expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationAddressesFromLocationName0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let geocodeRequest: geoLocationManager.GeoCodeRequest = {
            "locale": "zh",
            "country": "CN",
            "description": "上海金穗路1800号",
            "maxItems": 1,
            "minLatitude": 90,
            "minLongitude": 121.5782001832,
            "maxLatitude": 100,
          };
          geoLocationManager.getAddressesFromLocationName(geocodeRequest, (err, data) => {
            if (err) {
              console.info('[lbs_js] testLocationAddressesFromLocationName010 err is:' + JSON.stringify(err));
              expect(err.code).assertEqual("401");
            } else {
              console.info("[lbs_js] testLocationAddressesFromLocationName010 data is: " + JSON.stringify(data));
              expect(true).assertFail();
            }
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationName010 try err." + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_1100
     * @tc.name      : testLocationAddressesFromLocationName0011
     * @tc.desc      : When maxLongitude in GeoCodeRequest is an abnormal value, expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationAddressesFromLocationName0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let geocodeRequest: geoLocationManager.GeoCodeRequest = {
            "locale": "zh",
            "country": "CN",
            "description": "上海金穗路1800号",
            "maxItems": 1,
            "minLatitude": 90,
            "minLongitude": 121.5782001832,
            "maxLatitude": 31.1537977881,
            "maxLongitude": 200
          };
          geoLocationManager.getAddressesFromLocationName(geocodeRequest, (err, data) => {
            if (err) {
              console.info('[lbs_js] testLocationAddressesFromLocationName011 err is:' + JSON.stringify(err));
              expect(err.code).assertEqual("401");
            } else {
              console.info("[lbs_js] testLocationAddressesFromLocationName011 data is: " + JSON.stringify(data));
              expect(true).assertFail();
            }
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationName011 try err." + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_1200
     * @tc.name      : testLocationAddressesFromLocationName0012
     * @tc.desc      : When description in GeoCodeRequest is an abnormal value, expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationAddressesFromLocationName0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let geocodeRequest: geoLocationManager.GeoCodeRequest = {
            "locale": "zh",
            "country": "CN",
            "description": "",
            "maxItems": 1,
            "minLatitude": 90,
            "minLongitude": 121.5782001832,
            "maxLatitude": 31.1537977881,
          };
          geoLocationManager.getAddressesFromLocationName(geocodeRequest, (err, data) => {
            if (err) {
              console.info('[lbs_js] testLocationAddressesFromLocationName012 err is:' + JSON.stringify(err));
              expect(err.code).assertEqual("401");
            } else {
              console.info("[lbs_js] testLocationAddressesFromLocationName012 data is: " + JSON.stringify(data));
              expect(true).assertFail();
            }
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationName012 try err." + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        await sleep(2000);
        done();
      });


    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_1300
     * @tc.name      : testLocationAddressesFromLocationNamePromise0001
     * @tc.desc      : When creating GeoCodeRequest without setting locale, verify the function executes normally and returns valid data
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationAddressesFromLocationNamePromise0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let geocodeRequest: geoLocationManager.GeoCodeRequest = {
          "country": "CN",
          "description": "上海金穗路1800号",
          "maxItems": 1,
          "minLatitude": 90,
          "minLongitude": 121.5782001832,
          "maxLatitude": 31.1537977881,
          "maxLongitude": 121.8026736943
        };
        try {
          await geoLocationManager.getAddressesFromLocationName(geocodeRequest).then((result) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise001 data: " + JSON.stringify(result));
            expect(true).assertEqual((JSON.stringify(result)) != null);
          }).catch((error: BusinessError) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise001 then error." +
            JSON.stringify(error));
            expect(true).assertFail();
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationNamePromise001 try err." + JSON.stringify(error));
          expect(true).assertFail();
        }
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_1400
     * @tc.name      : testLocationAddressesFromLocationNamePromise0002
     * @tc.desc      : When creating GeoCodeRequest without setting country, verify the function executes normally and returns valid data
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationAddressesFromLocationNamePromise0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let geocodeRequest: geoLocationManager.GeoCodeRequest = {
          "locale": "zh",
          "description": "上海金穗路1800号",
          "maxItems": 1,
          "minLatitude": 90,
          "minLongitude": 121.5782001832,
          "maxLatitude": 31.1537977881,
          "maxLongitude": 121.8026736943
        };
        try {
          await geoLocationManager.getAddressesFromLocationName(geocodeRequest).then((result) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise002 data: " + JSON.stringify(result));
            expect(true).assertEqual((JSON.stringify(result)) != null);
          }).catch((error: BusinessError) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise002 then error." +
            JSON.stringify(error));
            expect(true).assertFail();
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationNamePromise002 try err." + JSON.stringify(error));
          expect(true).assertFail();
        }
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_1500
     * @tc.name      : testLocationAddressesFromLocationNamePromise0003
     * @tc.desc      : When creating GeoCodeRequest without setting maxItems, verify the function executes normally and returns valid data
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationAddressesFromLocationNamePromise0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let geocodeRequest: geoLocationManager.GeoCodeRequest = {
          "locale": "zh",
          "country": "CN",
          "description": "上海金穗路1800号",
          "minLatitude": 90,
          "minLongitude": 121.5782001832,
          "maxLatitude": 31.1537977881,
          "maxLongitude": 121.8026736943
        };
        try {
          await geoLocationManager.getAddressesFromLocationName(geocodeRequest).then((result) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise003 data: " + JSON.stringify(result));
            expect(true).assertEqual((JSON.stringify(result)) != null);
          }).catch((error: BusinessError) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise003 then error." +
            JSON.stringify(error));
            expect(true).assertFail();
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationNamePromise003 try err." + JSON.stringify(error));
          expect(true).assertFail();
        }
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_1600
     * @tc.name      : testLocationAddressesFromLocationNamePromise0004
     * @tc.desc      : When creating GeoCodeRequest without setting minLatitude, verify the function executes normally and returns valid data
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationAddressesFromLocationNamePromise0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let geocodeRequest: geoLocationManager.GeoCodeRequest = {
          "locale": "zh",
          "country": "CN",
          "description": "上海金穗路1800号",
          "maxItems": 1,
          "minLongitude": 121.5782001832,
          "maxLatitude": 31.1537977881,
          "maxLongitude": 121.8026736943
        };
        try {
          await geoLocationManager.getAddressesFromLocationName(geocodeRequest).then((result) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise004 data: " + JSON.stringify(result));
            expect(true).assertEqual((JSON.stringify(result)) != null);
          }).catch((error: BusinessError) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise004 then error." +
            JSON.stringify(error));
            expect(true).assertFail();
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationNamePromise004 try err." + JSON.stringify(error));
          expect(true).assertFail();
        }
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_1700
     * @tc.name      : testLocationAddressesFromLocationNamePromise0005
     * @tc.desc      : When creating GeoCodeRequest without setting minLongitude, verify the function executes normally and returns valid data
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationAddressesFromLocationNamePromise0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let geocodeRequest: geoLocationManager.GeoCodeRequest = {
          "locale": "zh",
          "country": "CN",
          "description": "上海金穗路1800号",
          "maxItems": 1,
          "minLatitude": 90,
          "maxLatitude": 31.1537977881,
          "maxLongitude": 121.8026736943
        };
        try {
          await geoLocationManager.getAddressesFromLocationName(geocodeRequest).then((result) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise005 data: " + JSON.stringify(result));
            expect(true).assertEqual((JSON.stringify(result)) != null);
          }).catch((error: BusinessError) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise005 then error." +
            JSON.stringify(error));
            expect(true).assertFail();
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationNamePromise005 try err." + JSON.stringify(error));
          expect(true).assertFail();
        }
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_1800
     * @tc.name      : testLocationAddressesFromLocationNamePromise0006
     * @tc.desc      : When creating GeoCodeRequest without setting maxLatitude, verify the function executes normally and returns valid data
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationAddressesFromLocationNamePromise0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let geocodeRequest: geoLocationManager.GeoCodeRequest = {
          "locale": "zh",
          "country": "CN",
          "description": "上海金穗路1800号",
          "maxItems": 1,
          "minLatitude": 90,
          "minLongitude": 121.5782001832,
          "maxLongitude": 121.8026736943
        };
        try {
          await geoLocationManager.getAddressesFromLocationName(geocodeRequest).then((result) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise006 data: " + JSON.stringify(result));
            expect(true).assertEqual((JSON.stringify(result)) != null);
          }).catch((error: BusinessError) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise006 then error." +
            JSON.stringify(error));
            expect(true).assertFail();
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationNamePromise006 try err." + JSON.stringify(error));
          expect(true).assertFail();
        }
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_1900
     * @tc.name      : testLocationAddressesFromLocationNamePromise0007
     * @tc.desc      : When creating GeoCodeRequest without setting maxLongitude, verify the function executes normally and returns valid data
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationAddressesFromLocationNamePromise0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let geocodeRequest: geoLocationManager.GeoCodeRequest = {
          "locale": "zh",
          "country": "CN",
          "description": "上海金穗路1800号",
          "maxItems": 1,
          "minLatitude": 90,
          "minLongitude": 121.5782001832,
          "maxLatitude": 31.1537977881,
        };
        try {
          await geoLocationManager.getAddressesFromLocationName(geocodeRequest).then((result) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise007 data: " + JSON.stringify(result));
            expect(true).assertEqual((JSON.stringify(result)) != null);
          }).catch((error: BusinessError) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise007 then error." +
            JSON.stringify(error));
            expect(true).assertFail();
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationNamePromise007 try err." + JSON.stringify(error));
          expect(true).assertFail();
        }
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_2000
     * @tc.name      : testLocationAddressesFromLocationNamePromise0008
     * @tc.desc      : When minLatitude in GeoCodeRequest is an abnormal value, expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationAddressesFromLocationNamePromise0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let geocodeRequest: geoLocationManager.GeoCodeRequest = {
          "country": "CN",
          "description": "上海金穗路1800号",
          "maxItems": 1,
          "minLatitude": 100,
          "minLongitude": 121.5782001832,
          "maxLatitude": 31.1537977881,
          "maxLongitude": 121.8026736943
        };
        try {
          await geoLocationManager.getAddressesFromLocationName(geocodeRequest).then((result) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise008 data: " + JSON.stringify(result));
            expect(true).assertFail();
          }).catch((error: BusinessError) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise008 then error." +
            JSON.stringify(error));
            expect(error.code).assertEqual("401");
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationNamePromise008 try err." + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        await sleep(2000);
        done();
      });


    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_2100
     * @tc.name      : testLocationAddressesFromLocationNamePromise0009
     * @tc.desc      : When minLongitude in GeoCodeRequest is an abnormal value, expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationAddressesFromLocationNamePromise0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let geocodeRequest: geoLocationManager.GeoCodeRequest = {
          "country": "CN",
          "description": "上海金穗路1800号",
          "maxItems": 1,
          "minLatitude": 90,
          "minLongitude": 200,
          "maxLatitude": 31.1537977881,
          "maxLongitude": 121.8026736943
        };
        try {
          await geoLocationManager.getAddressesFromLocationName(geocodeRequest).then((result) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise009 data: " + JSON.stringify(result));
            expect(true).assertFail();
          }).catch((error: BusinessError) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise009 then error." +
            JSON.stringify(error));
            expect(error.code).assertEqual("401");
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationNamePromise009 try err." + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_2200
     * @tc.name      : testLocationAddressesFromLocationNamePromise0010
     * @tc.desc      : When maxLatitude in GeoCodeRequest is an abnormal value, expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationAddressesFromLocationNamePromise0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let geocodeRequest: geoLocationManager.GeoCodeRequest = {
          "country": "CN",
          "description": "上海金穗路1800号",
          "maxItems": 1,
          "minLatitude": 90,
          "minLongitude": 121.5782001832,
          "maxLatitude": 100,
          "maxLongitude": 121.8026736943
        };
        try {
          await geoLocationManager.getAddressesFromLocationName(geocodeRequest).then((result) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise010 data: " + JSON.stringify(result));
            expect(true).assertFail();
          }).catch((error: BusinessError) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise010 then error." +
            JSON.stringify(error));
            expect(error.code).assertEqual("401");
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationNamePromise010 try err." + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_2300
     * @tc.name      : testLocationAddressesFromLocationNamePromise0011
     * @tc.desc      : When maxLongitude in GeoCodeRequest is an abnormal value, expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationAddressesFromLocationNamePromise0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let geocodeRequest: geoLocationManager.GeoCodeRequest = {
          "country": "CN",
          "description": "上海金穗路1800号",
          "maxItems": 1,
          "minLatitude": 90,
          "minLongitude": 121.5782001832,
          "maxLatitude": 31.1537977881,
          "maxLongitude": 200,
        };
        try {
          await geoLocationManager.getAddressesFromLocationName(geocodeRequest).then((result) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise011 data: " + JSON.stringify(result));
            expect(true).assertFail();
          }).catch((error: BusinessError) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise011 then error." +
            JSON.stringify(error));
            expect(error.code).assertEqual("401");
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationNamePromise011 try err." + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_NAME_2400
     * @tc.name      : testLocationAddressesFromLocationNamePromise0012
     * @tc.desc      : When description in GeoCodeRequest is an abnormal value, expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationAddressesFromLocationNamePromise0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let geocodeRequest: geoLocationManager.GeoCodeRequest = {
          "country": "CN",
          "description": "",
          "maxItems": 1,
          "minLatitude": 90,
          "minLongitude": 121.5782001832,
          "maxLatitude": 31.1537977881,
          "maxLongitude": 121.8026736943
        };
        try {
          await geoLocationManager.getAddressesFromLocationName(geocodeRequest).then((result) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise012 data: " + JSON.stringify(result));
            expect(true).assertFail();
          }).catch((error: BusinessError) => {
            console.info("[lbs_js] testLocationAddressesFromLocationNamePromise012 then error." +
            JSON.stringify(error));
            expect(error.code).assertEqual("401");
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationNamePromise012 try err." + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_ADD_GNSS_GEO_FENCE_0100
     * @tc.name      : testLocationAddGnssGeofence0001
     * @tc.desc      : When latitude and longitude in GNSS geofence are abnormal values, expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationAddGnssGeofence0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let geofence: geoLocationManager.Geofence = {
        "latitude": 200,
        "longitude": 300,
        "radius": 10000.0,
        "expiration": 10000.0
      }
      let transitionStatusList: Array<geoLocationManager.GeofenceTransitionEvent> = [
        geoLocationManager.GeofenceTransitionEvent.GEOFENCE_TRANSITION_EVENT_ENTER,
        geoLocationManager.GeofenceTransitionEvent.GEOFENCE_TRANSITION_EVENT_EXIT,
      ];
      let notificationRequestList: Array<notificationManager.NotificationRequest> =
        [];
      let gnssGeofenceRequest: geoLocationManager.GnssGeofenceRequest = {
        geofence: geofence,
        monitorTransitionEvents: transitionStatusList,
        notifications: notificationRequestList,
        geofenceTransitionCallback: (err: BusinessError, transition: geoLocationManager.GeofenceTransition) => {
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
        geoLocationManager.addGnssGeofence(gnssGeofenceRequest).then((id) => {
          console.info("addGnssGeofence success, fence id: " + id);
          fenceId = id;
          expect(true).assertEqual(id != -1);
        }).catch((err: BusinessError) => {
          console.error("addGnssGeofence failed, promise errCode:" + (err as BusinessError).code +
            ",errMessage:" + (err as BusinessError).message);
          expect(err.code).assertEqual("401")
        });
      } catch (error) {
        console.error("addGnssGeofence failed, err:" + JSON.stringify(error));
        if (error.code == "401") {
          expect(error.code).assertEqual("401")
        } else {
          expect(true).assertFail();
        }
      }
      done();
    });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_REMOVE_GNSS_GEO_FENCE_0100
     * @tc.name      : testLocationRemoveGnssGeofence0001
     * @tc.desc      : When fenceId is an abnormal value (-1), call removeGnssGeofence and expect return of error code 3301602
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationRemoveGnssGeofence0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let fenceId = -1;
      try {
        await geoLocationManager.removeGnssGeofence(fenceId).then(() => {
          console.info("removeGnssGeofence success fenceId:" + fenceId);
        }).catch((error : BusinessError) => {
          expect(error.code).assertEqual(3301602)
          console.error("removeGnssGeofence: error=" + JSON.stringify(error));
        });
      } catch(error) {
        expect(error.code).assertEqual(3301602)
        console.error("removeGnssGeofence: error=" + JSON.stringify(error));
      }
      done();
    });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_DISTANCE_BETWEEN_LOCATIONS_0100
     * @tc.name      : testLocationGetDistanceBetweenLocations0001
     * @tc.desc      : When latitude in the first Location is an abnormal value, expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationGetDistanceBetweenLocations0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let location1: geoLocationManager.Location = {
            "latitude": -100,
            "longitude": 120.11,
            "altitude": 0,
            "accuracy": 0,
            "speed": 0,
            "timeStamp": 0,
            "direction": 0,
            "timeSinceBoot": 0,
            "additionSize": 0
          }
          let location2: geoLocationManager.Location = {
            "latitude": 30.12,
            "longitude": 120.11,
            "altitude": 0,
            "accuracy": 0,
            "speed": 0,
            "timeStamp": 0,
            "direction": 0,
            "timeSinceBoot": 0,
            "additionSize": 0
          }
          let distance: number = geoLocationManager.getDistanceBetweenLocations(location1, location2);
          console.info(`Distance between two points: ${distance} meters`);
          expect(true).assertFail();
        } catch (error) {
          console.error("testLocationGetDistanceBetweenLocations001: errCode" + error.code + ", errMessage" +
          error.message);
          if (error.code == "401") {
            expect(error.code).assertEqual("401")
          } else {
            expect(true).assertFail();
          }
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_DISTANCE_BETWEEN_LOCATIONS_0200
     * @tc.name      : testLocationGetDistanceBetweenLocations0002
     * @tc.desc      : When longitude in the first Location is an abnormal value, expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationGetDistanceBetweenLocations0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let location1: geoLocationManager.Location = {
            "latitude": 30.12,
            "longitude": -200,
            "altitude": 0,
            "accuracy": 0,
            "speed": 0,
            "timeStamp": 0,
            "direction": 0,
            "timeSinceBoot": 0,
            "additionSize": 0
          }
          let location2: geoLocationManager.Location = {
            "latitude": 30.12,
            "longitude": 120.11,
            "altitude": 0,
            "accuracy": 0,
            "speed": 0,
            "timeStamp": 0,
            "direction": 0,
            "timeSinceBoot": 0,
            "additionSize": 0
          }
          let distance: number = geoLocationManager.getDistanceBetweenLocations(location1, location2);
          console.info(`Distance between two points: ${distance} meters`);
          expect(true).assertFail();
        } catch (error) {
          console.error("testLocationGetDistanceBetweenLocations002: errCode" + error.code + ", errMessage" +
          error.message);
          if (error.code == "401") {
            expect(error.code).assertEqual("401")
          } else {
            expect(true).assertFail();
          }
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_DISTANCE_BETWEEN_LOCATIONS_0300
     * @tc.name      : testLocationGetDistanceBetweenLocations0003
     * @tc.desc      : When latitude in the second Location is an abnormal value, expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationGetDistanceBetweenLocations0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let location1: geoLocationManager.Location = {
            "latitude": 30.12,
            "longitude": 120.11,
            "altitude": 0,
            "accuracy": 0,
            "speed": 0,
            "timeStamp": 0,
            "direction": 0,
            "timeSinceBoot": 0,
            "additionSize": 0
          }
          let location2: geoLocationManager.Location = {
            "latitude": -100,
            "longitude": 120.11,
            "altitude": 0,
            "accuracy": 0,
            "speed": 0,
            "timeStamp": 0,
            "direction": 0,
            "timeSinceBoot": 0,
            "additionSize": 0
          }
          let distance: number = geoLocationManager.getDistanceBetweenLocations(location1, location2);
          console.info(`Distance between two points: ${distance} meters`);
          expect(true).assertFail();
        } catch (error) {
          console.error("testLocationGetDistanceBetweenLocations003: errCode" + error.code + ", errMessage" +
          error.message);
          if (error.code == "401") {
            expect(error.code).assertEqual("401")
          } else {
            expect(true).assertFail();
          }
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_DISTANCE_BETWEEN_LOCATIONS_0400
     * @tc.name      : testLocationGetDistanceBetweenLocations0004
     * @tc.desc      : When longitude in the second Location is an abnormal value, expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationGetDistanceBetweenLocations0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        try {
          let location1: geoLocationManager.Location = {
            "latitude": 30.12,
            "longitude": 120.11,
            "altitude": 0,
            "accuracy": 0,
            "speed": 0,
            "timeStamp": 0,
            "direction": 0,
            "timeSinceBoot": 0,
            "additionSize": 0
          }
          let location2: geoLocationManager.Location = {
            "latitude": 30.12,
            "longitude": -200,
            "altitude": 0,
            "accuracy": 0,
            "speed": 0,
            "timeStamp": 0,
            "direction": 0,
            "timeSinceBoot": 0,
            "additionSize": 0
          }
          let distance: number = geoLocationManager.getDistanceBetweenLocations(location1, location2);
          console.info(`Distance between two points: ${distance} meters`);
          expect(true).assertFail();
        } catch (error) {
          console.error("testLocationGetDistanceBetweenLocations004: errCode" + error.code + ", errMessage" +
          error.message);
          if (error.code == "401") {
            expect(error.code).assertEqual("401")
          } else {
            expect(true).assertFail();
          }
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_CURRENT_LOCATIONS_0100
     * @tc.name      : testLocationCurrentLocationCallback0001
     * @tc.desc      : Create CurrentLocationRequest without setting the priority value, verify no abnormality
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationCurrentLocationCallback0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let currentLocationRequest: geoLocationManager.CurrentLocationRequest =
          { "scenario": 0x300, "timeoutMs": 1000, "maxAccuracy": 0 };
        try {
          geoLocationManager.getCurrentLocation(currentLocationRequest, (err, result) => {
            if (err) {
              console.info("[lbs_js] testLocationCurrentLocationCallback001 callback err:  " + JSON.stringify(err));
              expect(true).assertFail();
            } else {
              console.info("[lbs_js] testLocationCurrentLocationCallback001 callback, result:  " +
              JSON.stringify(result));
            }
          });
        } catch (error) {
          console.info("[lbs_js] getCurrentLocation callback try err." + JSON.stringify(error));
          expect(true).assertFail();
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_CURRENT_LOCATIONS_0200
     * @tc.name      : testLocationCurrentLocationCallback0002
     * @tc.desc      : When priority in CurrentLocationRequest is an abnormal value (-1), expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationCurrentLocationCallback0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let currentLocationRequest: geoLocationManager.CurrentLocationRequest = {
          "priority": -1,
          "scenario": 0x300,
          "timeoutMs": 1000,
          "maxAccuracy": 0
        };
        try {
          geoLocationManager.getCurrentLocation(currentLocationRequest, (err, result) => {
            if (err) {
              console.info("[lbs_js] testLocationCurrentLocationCallback002 callback err:  " + JSON.stringify(err));
              expect(err.code).assertEqual("401");
            } else {
              console.info("[lbs_js] testLocationCurrentLocationCallback002 callback, result:  " +
              JSON.stringify(result));
              expect(true).assertFail();
            }
          });
        } catch (error) {
          console.error('[lbs_js] testLocationCurrentLocationCallback002 callback try err:' + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_CURRENT_LOCATIONS_0300
     * @tc.name      : testLocationCurrentLocationCallback0003
     * @tc.desc      : Create CurrentLocationRequest without setting the scenario value, verify no abnormality
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationCurrentLocationCallback0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let currentLocationRequest: geoLocationManager.CurrentLocationRequest = {
          "priority": 0x203, "timeoutMs": 1000, "maxAccuracy": 0
        };
        try {
          geoLocationManager.getCurrentLocation(currentLocationRequest, (err, result) => {
            if (err) {
              console.info("[lbs_js] testLocationCurrentLocationCallback003 callback err:  " + JSON.stringify(err));
              expect(true).assertFail();
            } else {
              console.info("[lbs_js] testLocationCurrentLocationCallback003 callback, result:  " +
              JSON.stringify(result));
              expect(result).assertNotNull();
            }
          });
        } catch (error) {
          console.info("[lbs_js] testLocationCurrentLocationCallback003 callback try err." + JSON.stringify(error));
          expect(true).assertFail();
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_CURRENT_LOCATIONS_0400
     * @tc.name      : testLocationCurrentLocationCallback0004
     * @tc.desc      : When scenario in CurrentLocationRequest is an abnormal value (-1), expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationCurrentLocationCallback0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let currentLocationRequest: geoLocationManager.CurrentLocationRequest = {
          "priority": 0x200,
          "scenario": -1,
          "timeoutMs": 1000,
          "maxAccuracy": 200
        };
        try {
          geoLocationManager.getCurrentLocation(currentLocationRequest, (err, result) => {
            if (err) {
              console.info("[lbs_js] testLocationCurrentLocationCallback004 callback err:  " + JSON.stringify(err));
              expect(err.code).assertEqual("401");
            } else {
              console.info("[lbs_js] testLocationCurrentLocationCallback004 callback, result:  " +
              JSON.stringify(result));
              expect(true).assertFalse();
            }
          });
        } catch (error) {
          console.error('[lbs_js] testLocationCurrentLocationCallback004 callback try err:' + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_CURRENT_LOCATIONS_0500
     * @tc.name      : testLocationCurrentLocationCallback0005
     * @tc.desc      : Create CurrentLocationRequest without setting the maxAccuracy value, verify no abnormality
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationCurrentLocationCallback0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let currentLocationRequest: geoLocationManager.CurrentLocationRequest = {
          "priority": 0x200, "scenario": 0x304, "timeoutMs": 1000
        };
        try {
          geoLocationManager.getCurrentLocation(currentLocationRequest, (err, result) => {
            if (err) {
              console.info("[lbs_js] testLocationCurrentLocationCallback005 callback err:  " + JSON.stringify(err));
              expect(true).assertFail();
            } else {
              console.info("[lbs_js] testLocationCurrentLocationCallback005 callback, result:  " +
              JSON.stringify(result));
              expect(result).assertNotNull();
            }
          });
        } catch (error) {
          console.info("[lbs_js] testLocationCurrentLocationCallback005 callback try err." + JSON.stringify(error));
          expect(true).assertFail();
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_CURRENT_LOCATIONS_0600
     * @tc.name      : testLocationCurrentLocationCallback0006
     * @tc.desc      : When maxAccuracy in CurrentLocationRequest is an abnormal value (-1), expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationCurrentLocationCallback0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let currentLocationRequest: geoLocationManager.CurrentLocationRequest = {
          "priority": 0x200,
          "scenario": 0x304,
          "timeoutMs": 1000,
          "maxAccuracy": -1
        };
        try {
          geoLocationManager.getCurrentLocation(currentLocationRequest, (err, result) => {
            if (err) {
              console.info("[lbs_js] testLocationCurrentLocationCallback006 callback err:  " + JSON.stringify(err));
              expect(err.code).assertEqual("401");
            } else {
              console.info("[lbs_js] testLocationCurrentLocationCallback006 callback, result:  " +
              JSON.stringify(result));
              expect(true).assertFail();
            }
          });
        } catch (error) {
          console.error('[lbs_js] testLocationCurrentLocationCallback006 callback try err:' + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_CURRENT_LOCATIONS_0700
     * @tc.name      : testLocationCurrentLocationCallback0007
     * @tc.desc      : Create CurrentLocationRequest without setting the timeoutMs value, verify no abnormality
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationCurrentLocationCallback0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let currentLocationRequest: geoLocationManager.CurrentLocationRequest = {
          "priority": 0x200, "scenario": 0x300, "maxAccuracy": 200
        };
        try {
          geoLocationManager.getCurrentLocation(currentLocationRequest, (err, result) => {
            if (err) {
              console.info("[lbs_js] testLocationCurrentLocationCallback007 callback err:  " + JSON.stringify(err));
              expect(true).assertFail();
            } else {
              console.info("[lbs_js] testLocationCurrentLocationCallback007 callback, result:  " +
              JSON.stringify(result));
            }
          });
        } catch (error) {
          console.info("[lbs_js] testLocationCurrentLocationCallback007 callback try err." + JSON.stringify(error));
          expect(true).assertFail();
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_CURRENT_LOCATIONS_0800
     * @tc.name      : testLocationCurrentLocationCallback0008
     * @tc.desc      : When timeoutMs in CurrentLocationRequest is an abnormal value (-1), expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationCurrentLocationCallback0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let currentLocationRequest: geoLocationManager.CurrentLocationRequest = {
          "priority": 0x200,
          "scenario": 0x300,
          "timeoutMs": -1,
          "maxAccuracy": 0
        };
        try {
          geoLocationManager.getCurrentLocation(currentLocationRequest, (err, result) => {
            if (err) {
              console.info("[lbs_js] testLocationCurrentLocationCallback008 callback err:  " + JSON.stringify(err));
              expect(err.code).assertEqual("401");
            } else {
              console.info("[lbs_js] testLocationCurrentLocationCallback008 callback, result:  " +
              JSON.stringify(result));
              expect(true).assertFail();
            }
          });
        } catch (error) {
          console.error('[lbs_js] testLocationCurrentLocationCallback008 callback try err:' + JSON.stringify(error) +
            "code" + error.code + "mes" + error.message);
          expect(error.code).assertEqual("401");
          console.info("error.code 是否为'401':", error.code === "401");
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_CURRENT_LOCATIONS_0900
     * @tc.name      : testLocationCurrentLocationCallback0009
     * @tc.desc      : When locatingPriority in SingleLocationRequest is an abnormal value (-1), expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationCurrentLocationCallback0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let singleLocationRequest: geoLocationManager.SingleLocationRequest =
          { 'locatingTimeoutMs': 1000, 'locatingPriority': -1, 'needPoi': false };
        try {
          geoLocationManager.getCurrentLocation(singleLocationRequest, (err, result) => {
            if (err) {
              console.info("[lbs_js] testLocationCurrentLocationCallback009 callback err:  " + JSON.stringify(err));
              expect(err.code).assertEqual("401");
            } else {
              console.info("[lbs_js] testLocationCurrentLocationCallback009 callback, result:  " +
              JSON.stringify(result));
              expect(true).assertFail();
            }
          });
        } catch (error) {
          console.error('[lbs_js] testLocationCurrentLocationCallback009 callback try err:' + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_CURRENT_LOCATIONS_1000
     * @tc.name      : testLocationCurrentLocationCallback0010
     * @tc.desc      : When locatingTimeoutMs in SingleLocationRequest is an abnormal value (-1), expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationCurrentLocationCallback0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let singleLocationRequest: geoLocationManager.SingleLocationRequest =
          { 'locatingTimeoutMs': -1, 'locatingPriority': 0x501, 'needPoi': false };
        try {
          geoLocationManager.getCurrentLocation(singleLocationRequest, (err, result) => {
            if (err) {
              console.info("[lbs_js] testLocationCurrentLocationCallback010 callback err:  " + JSON.stringify(err));
              expect(err.code).assertEqual("401");
            } else {
              console.info("[lbs_js] testLocationCurrentLocationCallback010 callback, result:  " +
              JSON.stringify(result));
              expect(true).assertFail();
            }
          });
        } catch (error) {
          console.error('[lbs_js] testLocationCurrentLocationCallback010 callback try err:' + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_CURRENT_LOCATIONS_1100
     * @tc.name      : testLocationCurrentLocationPromise0001
     * @tc.desc      : Create CurrentLocationRequest without setting the priority value, verify no abnormality
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationCurrentLocationPromise0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let currentLocationRequest: geoLocationManager.CurrentLocationRequest =
          { "scenario": 0x300, "timeoutMs": 1000, "maxAccuracy": 0 };
        try {
          await geoLocationManager.getCurrentLocation(currentLocationRequest).then((result) => {
            console.info('[lbs_js] testLocationCurrentLocationPromise001 promise result ' + JSON.stringify(result));
          }).catch((error: BusinessError) => {
            console.info('[lbs_js] testLocationCurrentLocationPromise001 promise err:' + JSON.stringify(error));
            expect(true).assertFail();
          })
        } catch (error) {
          console.info("[lbs_js] testLocationCurrentLocationPromise001 try err." + JSON.stringify(error));
          expect(true).assertFail();
        }
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_CURRENT_LOCATIONS_1200
     * @tc.name      : testLocationCurrentLocationPromise0002
     * @tc.desc      : When priority in CurrentLocationRequest is an abnormal value (-1), expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationCurrentLocationPromise0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let currentLocationRequest: geoLocationManager.CurrentLocationRequest =
          {
            "priority": -1,
            "scenario": 0x301,
            "timeoutMs": 1000,
            "maxAccuracy": 0
          };
        try {
          await geoLocationManager.getCurrentLocation(currentLocationRequest).then((result) => {
            console.info('[lbs_js] testLocationCurrentLocationPromise002 result272 ' + JSON.stringify(result));
            expect(true).assertFail();
          }).catch((error: BusinessError) => {
            console.info('[lbs_js] testLocationCurrentLocationPromise002:' + JSON.stringify(error));
            expect(error.code).assertEqual("401");
          })
        } catch (error) {
          console.info("[lbs_js] testLocationCurrentLocationPromise002 try err." + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        done();
      });


    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_CURRENT_LOCATIONS_1300
     * @tc.name      : testLocationCurrentLocationPromise0003
     * @tc.desc      : Create CurrentLocationRequest without setting the scenario value, verify no abnormality
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationCurrentLocationPromise0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let currentLocationRequest: geoLocationManager.CurrentLocationRequest =
          {
            "priority": 0x203,
            "timeoutMs": 1000,
            "maxAccuracy": 0
          };
        try {
          await geoLocationManager.getCurrentLocation(currentLocationRequest).then((result) => {
            console.info('[lbs_js] testLocationCurrentLocationPromise003 result ' + JSON.stringify(result));
          }).catch((error: BusinessError) => {
            console.info('[lbs_js] testLocationCurrentLocationPromise003 err:' + JSON.stringify(error));
            expect(true).assertFail();
          })
        } catch (error) {
          console.info("[lbs_js] testLocationCurrentLocationPromise003 try err." + JSON.stringify(error));
          expect(true).assertFail();
        }
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_CURRENT_LOCATIONS_1400
     * @tc.name      : testLocationCurrentLocationPromise0004
     * @tc.desc      : When scenario in CurrentLocationRequest is an abnormal value (-1), expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationCurrentLocationPromise0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let currentLocationRequest: geoLocationManager.CurrentLocationRequest =
          {
            "priority": 0x203,
            "scenario": -1,
            "timeoutMs": 1000,
            "maxAccuracy": 0
          };
        try {
          await geoLocationManager.getCurrentLocation(currentLocationRequest).then((result) => {
            console.info('[lbs_js] testLocationCurrentLocationPromise004 result272 ' + JSON.stringify(result));
            expect(true).assertFail();
          }).catch((error: BusinessError) => {
            console.info('[lbs_js] testLocationCurrentLocationPromise004 err272:' + JSON.stringify(error));
            expect(error.code).assertEqual("401");
          })
        } catch (error) {
          console.info("[lbs_js] testLocationCurrentLocationPromise004 try err." + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_CURRENT_LOCATIONS_1500
     * @tc.name      : testLocationCurrentLocationPromise0005
     * @tc.desc      : Create CurrentLocationRequest without setting the maxAccuracy value, verify no abnormality
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationCurrentLocationPromise0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let currentLocationRequest: geoLocationManager.CurrentLocationRequest =
          { "priority": 0x203, "scenario": 0x301, "timeoutMs": 1000 };
        try {
          await geoLocationManager.getCurrentLocation(currentLocationRequest).then((result) => {
            console.info('[lbs_js] testLocationCurrentLocationPromise005 result ' + JSON.stringify(result));
          }).catch((error: BusinessError) => {
            console.info('[lbs_js] testLocationCurrentLocationPromise005 err:' + JSON.stringify(error));
            expect(true).assertFail();
          })
        } catch (error) {
          console.info("[lbs_js] testLocationCurrentLocationPromise005 try err." + JSON.stringify(error));
          expect(true).assertFail();
        }
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_CURRENT_LOCATIONS_1600
     * @tc.name      : testLocationCurrentLocationPromise0006
     * @tc.desc      : When maxAccuracy in CurrentLocationRequest is an abnormal value (-1), expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationCurrentLocationPromise0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let currentLocationRequest: geoLocationManager.CurrentLocationRequest =
          {
            "priority": 0x203,
            "scenario": 0x301,
            "timeoutMs": 1000,
            "maxAccuracy": -1
          };
        try {
          await geoLocationManager.getCurrentLocation(currentLocationRequest).then((result) => {
            console.info('[lbs_js] testLocationCurrentLocationPromise006 result272 ' + JSON.stringify(result));
            expect(true).assertFail();
          }).catch((error: BusinessError) => {
            console.info('[lbs_js] testLocationCurrentLocationPromise006 err:' + JSON.stringify(error));
            expect(error.code).assertEqual("401");
          })
        } catch (error) {
          console.info("[lbs_js] testLocationCurrentLocationPromise006 try err." + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_CURRENT_LOCATIONS_1700
     * @tc.name      : testLocationCurrentLocationPromise0007
     * @tc.desc      : Create CurrentLocationRequest without setting the timeoutMs value, verify no abnormality
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationCurrentLocationPromise0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let currentLocationRequest: geoLocationManager.CurrentLocationRequest =
          { "priority": 0x203, "scenario": 0x301, "maxAccuracy": 0 };
        try {
          await geoLocationManager.getCurrentLocation(currentLocationRequest).then((result) => {
            console.info('[lbs_js] testLocationCurrentLocationPromise007 result ' + JSON.stringify(result));
          }).catch((error: BusinessError) => {
            console.info('[lbs_js] testLocationCurrentLocationPromise007 err:' + JSON.stringify(error));
            expect(true).assertFail();
          })
        } catch (error) {
          console.info("[lbs_js] testLocationCurrentLocationPromise007 try err." + JSON.stringify(error));
          expect(true).assertFail();
        }
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_CURRENT_LOCATIONS_1800
     * @tc.name      : testLocationCurrentLocationPromise0008
     * @tc.desc      : When timeoutMs in CurrentLocationRequest is an abnormal value (-1), expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationCurrentLocationPromise0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let currentLocationRequest: geoLocationManager.CurrentLocationRequest =
          {
            "priority": 0x203,
            "scenario": 0x301,
            "timeoutMs": -1,
            "maxAccuracy": 0
          };
        try {
          await geoLocationManager.getCurrentLocation(currentLocationRequest).then((result) => {
            console.info('[lbs_js] testLocationCurrentLocationPromise008 result ' + JSON.stringify(result));
            expect(true).assertFail();
          }).catch((error: BusinessError) => {
            console.info('[lbs_js] testLocationCurrentLocationPromise008 err:' + JSON.stringify(error));
            expect(error.code).assertEqual("401");
          })
        } catch (error) {
          console.info("[lbs_js] testLocationCurrentLocationPromise008 try err." + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_CURRENT_LOCATIONS_1900
     * @tc.name      : testLocationCurrentLocationPromise0009
     * @tc.desc      : When locatingPriority in SingleLocationRequest is an abnormal value (-1), expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationCurrentLocationPromise0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let singleLocationRequest: geoLocationManager.SingleLocationRequest =
          { 'locatingTimeoutMs': 1000, 'locatingPriority': -1 };
        try {
          await geoLocationManager.getCurrentLocation(singleLocationRequest).then((result) => {
            console.info('[lbs_js] testLocationCurrentLocationPromise009 result ' + JSON.stringify(result));
            expect(true).assertFail();
          }).catch((error: BusinessError) => {
            console.info('[lbs_js] testLocationCurrentLocationPromise009 err:' + JSON.stringify(error));
            expect(error.code).assertEqual("401");
          })
        } catch (error) {
          console.info("[lbs_js] testLocationCurrentLocationPromise009 try err." + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_CURRENT_LOCATIONS_2000
     * @tc.name      : testLocationCurrentLocationPromise0010
     * @tc.desc      : When locatingTimeoutMs in SingleLocationRequest is an abnormal value (-1), expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationCurrentLocationPromise0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let singleLocationRequest: geoLocationManager.SingleLocationRequest =
          { 'locatingTimeoutMs': -1, 'locatingPriority': 0x501 };
        try {
          await geoLocationManager.getCurrentLocation(singleLocationRequest).then((result) => {
            console.info('[lbs_js] testLocationCurrentLocationPromise010 result272 ' + JSON.stringify(result));
            expect(true).assertFail();
          }).catch((error: BusinessError) => {
            console.info('[lbs_js] testLocationCurrentLocationPromise010 err272:' + JSON.stringify(error));
            expect(error.code).assertEqual("401");
          })
        } catch (error) {
          console.info("[lbs_js] testLocationCurrentLocationPromise010 try err." + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_LOCATION_ERROR_ON_0100
     * @tc.name      : testLocationOnError0001
     * @tc.desc      : Register and unregister callback for 'locationError' event, verify normal execution
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationOnError0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let locationError1 = () => {
        console.log('[lbs_js] testLocationOnError001');
      };
      let isOnSuccess = false;
      try {
        geoLocationManager.on('locationError', locationError1);
        isOnSuccess = true;
        console.info("testLocationOnError001 Success");
      } catch (error) {
        console.info("[lbs_js] try error: " + JSON.stringify(error));
        expect(true).assertFalse();
      }
      expect(isOnSuccess).assertTrue();
      try {
        geoLocationManager.off('locationError', locationError1);
      } catch (error) {
        console.info("[lbs_js] try error: " + JSON.stringify(error));
        expect(true).assertFalse();
      }
      await sleep(2000);
      done();
    });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_LOCATION_ENABLE_CHANGE_ON_0100
     * @tc.name      : testLocationOnEnabledChange0001
     * @tc.desc      : Register and unregister callback for 'locationEnabledChange' event, verify no exception is thrown
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationOnEnabledChange0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let locationError1 = () => {
        console.log('[lbs_js] testLocationOnEnabledChange001');
      };
      let isOnSuccess = false;
      try {
        geoLocationManager.on('locationEnabledChange', locationError1);
        isOnSuccess = true;
        console.info("testLocationOnEnabledChange001 Success");
      } catch (error) {
        console.info("[lbs_js] try error: " + JSON.stringify(error));
        expect(true).assertFalse();
      }
      expect(isOnSuccess).assertTrue();
      try {
        geoLocationManager.off('locationEnabledChange', locationError1);
      } catch (error) {
        console.info("[lbs_js] try error: " + JSON.stringify(error));
        expect(true).assertFalse();
      }
      await sleep(2000);
      done();
    });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_COUNTRY_CODE_CHANGE_ON_0100
     * @tc.name      : testLocationOnCodeChange0001
     * @tc.desc      : Register and unregister callback for 'countryCodeChange' event, verify no exception is thrown
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testLocationOnCodeChange0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let locationError1 = () => {
        console.log('[lbs_js] testLocationOnCodeChange001');
      };
      let isOnSuccess = false;
      try {
        geoLocationManager.on('countryCodeChange', locationError1);
        isOnSuccess = true;
        console.info("testLocationOnCodeChange001 Success");
      } catch (error) {
        console.info("[lbs_js] try error: " + JSON.stringify(error));
        expect(true).assertFalse();
      }
      expect(isOnSuccess).assertTrue();
      try {
        geoLocationManager.off('countryCodeChange', locationError1);
      } catch (error) {
        console.info("[lbs_js] try error: " + JSON.stringify(error));
        expect(true).assertFalse();
      }
      await sleep(2000);
      done();
    });
    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_1100
     * @tc.name      : testLocationAddressesFromLocationPromise0006
     * @tc.desc      : When latitude in ReverseGeoCodeRequest are abnormal values, expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationAddressesFromLocationPromise0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let reverseGeocodeRequest: geoLocationManager.ReverseGeoCodeRequest =
          {
            "latitude": -100,
            "longitude": 121.62771,
            "locale": "zh",
            "country": "CN"
          };
        try {
          await geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest).then((data) => {
            console.info('[lbs_js] testLocationAddressesFromLocationPromise006 promise: ' + JSON.stringify(data));
            expect(true).assertFail();
          }).catch((error: BusinessError) => {
            console.info("[lbs_js] testLocationAddressesFromLocationPromise006 then error." + JSON.stringify(error));
            console.info('[lbs_js] not support now');
            expect(error.code).assertEqual("401");
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationPromise006 try err:" + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_1200
     * @tc.name      : testLocationAddressesFromLocationPromise0007
     * @tc.desc      : When longitude in ReverseGeoCodeRequest are abnormal values, expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationAddressesFromLocationPromise0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let reverseGeocodeRequest: geoLocationManager.ReverseGeoCodeRequest =
          {
            "latitude": 31.265496,
            "longitude": -200,
            "locale": "zh",
            "country": "CN"
          };
        try {
          await geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest).then((data) => {
            console.info('[lbs_js] testLocationAddressesFromLocationPromise007 promise: ' + JSON.stringify(data));
            expect(true).assertFail();
          }).catch((error: BusinessError) => {
            console.info("[lbs_js] testLocationAddressesFromLocationPromise007 then error." + JSON.stringify(error));
            console.info('[lbs_js] not support now');
            expect(error.code).assertEqual("401");
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationPromise007 try err:" + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_1300
     * @tc.name      : testLocationAddressesFromLocationPromise0008
     * @tc.desc      : When longitude in ReverseGeoCodeRequest are abnormal values, expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationAddressesFromLocationPromise0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let reverseGeocodeRequest: geoLocationManager.ReverseGeoCodeRequest =
          {
            "latitude": 31.265496,
            "longitude": 200,
            "locale": "zh",
            "country": "CN"
          };
        try {
          await geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest).then((data) => {
            console.info('[lbs_js] testLocationAddressesFromLocationPromise008 promise: ' + JSON.stringify(data));
            expect(true).assertFail();
          }).catch((error: BusinessError) => {
            console.info("[lbs_js] testLocationAddressesFromLocationPromise008 then error." + JSON.stringify(error));
            console.info('[lbs_js] not support now');
            expect(error.code).assertEqual("401");
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocationPromise008 try err:" + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_1400
     * @tc.name      : testLocationAddressesFromLocation0006
     * @tc.desc      : When longitude in ReverseGeoCodeRequest are abnormal values, expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationAddressesFromLocation0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let reverseGeocodeRequest: geoLocationManager.ReverseGeoCodeRequest =
          {
            "latitude": 31.265496,
            "longitude": 200,
            "locale": "zh",
            "country": "CN"
          };
        try {
          geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest, (err, data) => {
            if (err) {
              console.info('[lbs_js] testLocationAddressesFromLocation006 err is : ' + JSON.stringify(err));
              expect(err.code).assertEqual("401");
            } else {
              console.info("[lbs_js] testLocationAddressesFromLocation006 data is: " + JSON.stringify(data));
              expect(true).assertFail();
            }
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocation006 try err:" + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_1500
     * @tc.name      : testLocationAddressesFromLocation0007
     * @tc.desc      : When longitude in ReverseGeoCodeRequest are abnormal values, expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationAddressesFromLocation0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let reverseGeocodeRequest: geoLocationManager.ReverseGeoCodeRequest =
          {
            "latitude": -100,
            "longitude": 121.62771,
            "locale": "zh",
            "country": "CN"
          };
        try {
          geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest, (err, data) => {
            if (err) {
              console.info('[lbs_js] testLocationAddressesFromLocation007 err is : ' + JSON.stringify(err));
              expect(err.code).assertEqual("401");
            } else {
              console.info("[lbs_js] testLocationAddressesFromLocation007 data is: " + JSON.stringify(data));
              expect(true).assertFail();
            }
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocation007 try err:" + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        await sleep(2000);
        done();
      });

    /**
     * @tc.number    : SUB_HSS_LOCATIONSYSTEM_GET_ADDRESSES_FROM_LOCATION_1600
     * @tc.name      : testLocationAddressesFromLocation0008
     * @tc.desc      : When longitude in ReverseGeoCodeRequest are abnormal values, expect return of 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testLocationAddressesFromLocation0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let reverseGeocodeRequest: geoLocationManager.ReverseGeoCodeRequest =
          {
            "latitude": 31.265496,
            "longitude": -200,
            "locale": "zh",
            "country": "CN"
          };
        try {
          geoLocationManager.getAddressesFromLocation(reverseGeocodeRequest, (err, data) => {
            if (err) {
              console.info('[lbs_js] testLocationAddressesFromLocation008 err is : ' + JSON.stringify(err));
              expect(err.code).assertEqual("401");
            } else {
              console.info("[lbs_js] testLocationAddressesFromLocation008 data is: " + JSON.stringify(data));
              expect(true).assertFail();
            }
          });
        } catch (error) {
          console.info("[lbs_js] testLocationAddressesFromLocation008 try err:" + JSON.stringify(error));
          expect(error.code).assertEqual("401");
        }
        await sleep(2000);
        done();
      });
  })
}
