/*
 * Copyright (C) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the 'License');
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an 'AS IS' BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, TestType, Size } from '@ohos/hypium';
import { SLEEP_TIME_3000, SLEEP_TIME_100 } from "./Constants.test";
import { image } from '@kit.ImageKit';
import { sleep } from './Common.test';

export default function ImagePropertyOptionsTest() {
  describe('GetImagePropertyOptionsTest', () => {
    beforeAll(async () => {
      console.info('beforeAll case');
    });
    beforeEach(async () => {
      await sleep(SLEEP_TIME_100);
      console.info('beforeEach case');
    });
    afterEach(() => {
      console.info('afterEach case');
    });
    afterAll(async () => {
      await sleep(SLEEP_TIME_3000);
      console.info('afterAll case');
    });

    /**
     * @tc.number    : SUB_MULTIMEDIA_GET_IMAGE_PROPERTY_OPTIONS_0100
     * @tc.name      : testImagePropertyOptionsIndex0001
     * @tc.desc      : Verify ImagePropertyOptions index value setting and getting
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testGetImagePropertyOptionsIndex0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let options: image.GetImagePropertyOptions = { index: 10, defaultValue: '5' };
        expect(options.index).assertEqual(10);
        done();
      });

    /**
     * @tc.number    : SUB_MULTIMEDIA_GET_IMAGE_PROPERTY_OPTIONS_0200
     * @tc.name      : testImagePropertyOptionsDefaultValue0001
     * @tc.desc      : Verify ImagePropertyOptions defaultValue setting and getting
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testGetImagePropertyOptionsDefaultValue0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let options: image.GetImagePropertyOptions = { index: 5, defaultValue: '15' };
        expect(options.defaultValue).assertEqual('15');
        done();
      });

  })
}