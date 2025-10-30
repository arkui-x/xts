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
import photoAccessHelper from '@ohos.file.photoAccessHelper';
import { describe, it, expect, Level, Size, TestType } from '@ohos/hypium';

export default function photoAccessHelperEnumsTest() {
  describe('photoAccessHelperEnumsTest', () => {
    /**
     * @tc.number    : SUB_FILE_PHOTOACCESSHELPER_ENUM_0100
     * @tc.name      : testPhotoAccessHelperEnum0100
     * @tc.desc      : test photoAccessHelper PhotoType value
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPhotoAccessHelperEnum0100', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL0, async (done: Function) => {
      expect(photoAccessHelper.PhotoType.IMAGE).assertEqual(1);
      expect(photoAccessHelper.PhotoType.VIDEO).assertEqual(2);
      done();
    })

    /**
     * @tc.number    : SUB_FILE_PHOTOACCESSHELPER_ENUM_0200
     * @tc.name      : testPhotoAccessHelperEnum0200
     * @tc.desc      : test photoAccessHelper AlbumKeys value
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testPhotoAccessHelperEnum0200', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL0, async (done: Function) => {
      expect(photoAccessHelper.AlbumKeys.ALBUM_NAME).assertEqual('album_name');
      done();
    })
  })
}