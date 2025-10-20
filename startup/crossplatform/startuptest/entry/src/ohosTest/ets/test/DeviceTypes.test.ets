/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, Level, Size, TestType } from '@ohos/hypium';
import deviceinfo from '@ohos.deviceInfo';

export default function DeviceTypesTest() {
  describe('DeviceTypesTest', () => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(() => {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    })
    beforeEach(() => {
      // Presets an action, which is performed before each unit test case starts.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: preset action function.
    })
    afterEach(() => {
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    })
    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    })
    /**
     * @tc.number    : SUB_STARTUP_DEVCEINFO_DEVICETYPES_0100
     * @tc.name      : testGetDeviceTypes0001
     * @tc.desc      : Get DeviceTypes.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testGetDeviceTypes0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      console.info('testGetDeviceTypes start');
      let deviceTypes = deviceinfo.DeviceTypes.TYPE_DEFAULT;
      console.info('the value of the deviceinfo DeviceTypes.TYPE_DEFAULT is :' + deviceTypes);
      expect(deviceTypes).assertEqual('default');
      deviceTypes = deviceinfo.DeviceTypes.TYPE_PHONE;
      console.info('the value of the deviceinfo DeviceTypes.TYPE_PHONE is :' + deviceTypes);
      expect(deviceTypes).assertEqual('phone');
      deviceTypes = deviceinfo.DeviceTypes.TYPE_TABLET;
      console.info('the value of the deviceinfo DeviceTypes.TYPE_TABLET is :' + deviceTypes);
      expect(deviceTypes).assertEqual('tablet');
      deviceTypes = deviceinfo.DeviceTypes.TYPE_2IN1;
      console.info('the value of the deviceinfo DeviceTypes.TYPE_2IN1 is :' + deviceTypes);
      expect(deviceTypes).assertEqual('2in1');
      deviceTypes = deviceinfo.DeviceTypes.TYPE_TV;
      console.info('the value of the deviceinfo DeviceTypes.TYPE_TV is :' + deviceTypes);
      expect(deviceTypes).assertEqual('tv');
      deviceTypes = deviceinfo.DeviceTypes.TYPE_WEARABLE;
      console.info('the value of the deviceinfo DeviceTypes.TYPE_WEARABLE is :' + deviceTypes);
      expect(deviceTypes).assertEqual('wearable');
      deviceTypes = deviceinfo.DeviceTypes.TYPE_CAR;
      console.info('the value of the deviceinfo DeviceTypes.TYPE_CAR is :' + deviceTypes);
      expect(deviceTypes).assertEqual('car');
      console.info('testGetDeviceTypes : end');
    })
  })
}