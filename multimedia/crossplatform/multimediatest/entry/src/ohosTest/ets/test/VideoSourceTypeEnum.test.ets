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

import media from '@ohos.multimedia.media'
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, TestType, Size } from '@ohos/hypium'

export default function VideoSourceTypeEnumTest() {
  describe('VideoSourceTypeEnumTest', () => {
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
     * @tc.number    : SUB_MULTIMEDIA_MEDIA_VIDEO_PLAYER_ENUM_QUALITY_LEVEL_0100
     * @tc.name      : testVideoSourceTypeEnum001
     * @tc.desc      : VideoSourceType Enumeration test
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testVideoSourceTypeEnum001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      expect(media.VideoSourceType.VIDEO_SOURCE_TYPE_SURFACE_ES).assertEqual(1);
      expect(media.VideoSourceType.VIDEO_SOURCE_TYPE_SURFACE_YUV).assertEqual(0);
      done();
    });
  })
}