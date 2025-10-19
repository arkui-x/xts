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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Size, Level } from '@ohos/hypium';
import { abilityAccessCtrl, common, Permissions } from '@kit.AbilityKit';
import AtManager from '@ohos.abilityAccessCtrl'
import { BusinessError } from '@ohos.base';

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

export default function geolocationTest_GeoErr() {
  describe('geolocationTest_GeoErr', () => {
    console.log('#start AccessTokenTests#');
    beforeAll(async (done:Function) => {
      context = globalThis.abilityContext;
      const isAllGranted = await reqPermissionsFromUser(LOCATION_PERMISSIONS, context);
      if (!isAllGranted) {
        console.error('no permission');
        throw new Error('no permission');
      }
      console.info('beforeAll case');
      done();
    });
    beforeEach(async (done:Function) => {
      console.info('beforeEach case');
      done();
    });

    /**
     * @tc.number SUB_HSS_LocationSystem_GeoErr_0100
     * @tc.name testGetAddressesFromLocationName0001
     * @tc.desc Invoke the geocoding service with incorrect input parameters.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('testGetAddressesFromLocationName0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      try {
        let geocodeRequest : geolocationm.GeoCodeRequest = {
          description : ""
        };
        geolocationm.getAddressesFromLocationName(geocodeRequest, (err, data) => {
          if (err) {
            console.info('[lbs_js] getAddressesFromLocationName6 callback err is:' + JSON.stringify(err));
            expect(err.code).assertEqual(401);
            return;
          } else {
            console.info("[lbs_js] getAddressesFromLocationName6 callback data is: " + JSON.stringify(data));
            expect(true).assertFalse();
          }
        });
      } catch (error) {
        console.info("[lbs_js] getAddressesFromLocationName6 try err." + JSON.stringify(error) + "code" + error.code +
          "mes" + error.message);
        expect(error.code).assertEqual("401");
      }
      await sleep(1000);
      done();
    });
    /**
     * @tc.number SUB_HSS_LocationSystem_GeoErr_0200
     * @tc.name testGetAddressesFromLocationName0002
     * @tc.desc Invoke the geocoding service with incorrect input parameters.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('testGetAddressesFromLocationName0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done:Function) => {
      (async () => {
        try {
          let geocodeRequest:geolocationm.GeoCodeRequest = {
            description:""
          };
          let result = await geolocationm.getAddressesFromLocationName(geocodeRequest);
          console.info("[lbs_js] getAddressesFromLocationName7 promise successful:" + JSON.stringify(result));
        } catch (error) {
          console.info('[lbs_js] getAddressesFromLocationName7 promise err:' + JSON.stringify(error) + "code" +
          error.code + "mes" + error.message);
          expect(error.code).assertEqual("401");
        }
      })();
      await sleep(1000);
      done();
    });
  })
}

