/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

import { describe, it, expect, TestType, Size, Level } from '@ohos/hypium';
import resourceManager from '@ohos.resourceManager';
import { BusinessError } from '@ohos.base';
import common from '@ohos.app.ability.common';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';

let abilityDelegatorRegistry = AbilityDelegatorRegistry.getAbilityDelegator();
let context: common.Context = abilityDelegatorRegistry.getAppContext();

export default function resourcePropertyTest() {
  describe('resourcePropertyTest', () => {

    /**
     * @tc.number resourceProperty_test_0100
     * @tc.name   resourceProperty_test_0100
     * @tc.desc   Resource property test rewritten as a dynamic case: construct Resource
     *            with params (mixed any[] array) and verify all five fields, especially
     *            params?: any[] field assignment and readability.
     * @tc.size   MediumTest
     * @tc.type   Function
     * @tc.level  Level 0
     */
    it('resourceProperty_test_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        try {
          let resource: resourceManager.Resource = {
            bundleName: 'com.example.resourcemanagertest',
            moduleName: 'entry',
            id: 0x01234567,
            params: ["sdfd", 123],
            type: 10001,
          }
          console.info('resourceProperty_test_0100 resource: ' + JSON.stringify(resource));
          expect(resource.bundleName).assertEqual('com.example.resourcemanagertest');
          expect(resource.moduleName).assertEqual('entry');
          expect(resource.id).assertEqual(0x01234567);
          expect(resource.params != null).assertTrue();
          expect(resource.params!.length).assertEqual(2);
          expect(resource.params![0]).assertEqual('sdfd');
          expect(resource.params![1]).assertEqual(123);
          expect(resource.type).assertEqual(10001);
          console.info(`resourceProperty_test_0100 succeed`);
          done();
        } catch (err) {
          console.error(`resourceProperty_test_0100 failed, error: ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number getConfiguration_stage_test_0500
     * @tc.name   getConfiguration_stage_test_0500
     * @tc.desc   with callback colorMode. Rewritten as a dynamic case: get
     *            Configuration via callback, assign ColorMode.DARK/LIGHT to
     *            cfg.colorMode in turn and read back, covering enum member
     *            ColorMode.LIGHT = 1 assignment and readability.
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL3
     */
    it('getConfiguration_stage_test_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        try {
          context.resourceManager.getConfiguration((error: BusinessError, value: resourceManager.Configuration) => {
            try {
              console.info('getConfiguration_stage_test_0500 colorMode initial: ' + value.colorMode);
              value.colorMode = resourceManager.ColorMode.DARK;
              console.log('getConfiguration_stage_test_0500 DARK:' + value.colorMode);
              expect(value.colorMode).assertEqual(resourceManager.ColorMode.DARK);
              value.colorMode = resourceManager.ColorMode.LIGHT;
              console.log('getConfiguration_stage_test_0500 LIGHT:' + value.colorMode);
              expect(value.colorMode).assertEqual(resourceManager.ColorMode.LIGHT);
              expect(value.colorMode).assertEqual(1);
            } catch (err) {
              console.error(`getConfiguration_stage_test_0500 inner failed, error: ${JSON.stringify(err)}`);
              expect().assertFail();
            }
            done();
          });
        } catch (err) {
          console.error(`getConfiguration_stage_test_0500 failed, error: ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        }
      })
  })
}
