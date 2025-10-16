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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, TestType, Size } from '@ohos/hypium'
import { media } from '@kit.MediaKit';

export default function AVMetadataTest() {
  describe('AVMetadataTest', () => {
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
     * @tc.number    : SUB_MULTIMEDIA_MEDIA_AV_METADATA_TEST_0100
     * @tc.name      : TestAVMetadataHdrType0001
     * @tc.desc      : test property hdrType of AVMetadata (AV_HDR_TYPE_NONE)
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('TestAVMetadataHdrType0001', Level.LEVEL0, async (done: Function) => {
      let options: media.AVMetadata = { hdrType: media.HdrType.AV_HDR_TYPE_NONE }
      expect(options.hdrType).assertEqual(0);
      done();
    });

    /**
     * @tc.number    : SUB_MULTIMEDIA_MEDIA_AV_METADATA_TEST_0200
     * @tc.name      : TestAVMetadataHdrType0002
     * @tc.desc      : test property hdrType of AVMetadata (AV_HDR_TYPE_VIVID)
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('TestAVMetadataHdrType0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let options: media.AVMetadata = { hdrType: media.HdrType.AV_HDR_TYPE_VIVID }
      expect(options.hdrType).assertEqual(1);
      done();
    });
  })
}