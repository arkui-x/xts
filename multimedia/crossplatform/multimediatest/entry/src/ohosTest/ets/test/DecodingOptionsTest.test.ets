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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, Size, TestType } from '@ohos/hypium'
import { image } from '@kit.ImageKit';
import { colorSpaceManager } from '@kit.ArkGraphics2D';

export default function DecodingOptionsTest() {
  describe('DecodingOptionsTest', () => {
    beforeAll(() => {
      console.info('beforeAll case');
    });
    beforeEach(() => {
      console.info('beforeEach case');
    });
    afterEach(() => {
      console.info('afterEach case');
    });
    afterAll(() => {
      console.info('afterAll case');
    });

    /**
    * @tc.number    : SUB_MULTIMEDIA_Image_Decoding_Options0100
    * @tc.name      : TestDesiredColorSpace0001
    * @tc.desc      : Test DecodingOptions property desiredColorSpace
    * @tc.size      : MediumTest
    * @tc.type      : Function
    * @tc.level     : Level 0
    */
    it('TestDesiredColorSpace0001',TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let options: image.DecodingOptions =
        { desiredColorSpace: colorSpaceManager.create(colorSpaceManager.ColorSpace.ADOBE_RGB_1998) };
      expect(options.desiredColorSpace?.getColorSpaceName()).assertEqual(1);
      let gamma = options.desiredColorSpace?.getGamma();
      if (gamma != undefined) {
        expect(gamma > 2.1 && gamma < 2.3).assertTrue();
      } else {
        expect().assertFail();
      }
      done();
    })
  })
}