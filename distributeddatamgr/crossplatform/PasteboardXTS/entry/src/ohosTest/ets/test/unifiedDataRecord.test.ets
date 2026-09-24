/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, Size, TestType } from "@ohos/hypium";
import { unifiedDataChannel } from '@kit.ArkData';

export default function unifiedDataRecordTest() {
  describe('unifiedDataRecordTest', () => {
    beforeAll(async () => {
      console.info('unifiedDataRecordTest beforeAll');
    })
    beforeEach(async () => {
    })
    afterEach(async () => {
    })
    afterAll(async () => {
      console.info('unifiedDataRecordTest afterAll');
    })

    /**
     * @tc.number ArKUIX_ArkTS_UnifiedDataRecord_PlainText_0100
     * @tc.name ArKUIX_ArkTS_UnifiedDataRecord_PlainText_0100
     * @tc.desc Test PlainText.textContent get/set
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     */
    it('ArKUIX_ArkTS_UnifiedDataRecord_PlainText_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_UnifiedDataRecord_PlainText_0100';
        console.info(`${caseName} start`);
        try {
          let text = new unifiedDataChannel.PlainText();
          text.textContent = 'this is textContent';
          expect(text.textContent).assertEqual('this is textContent');
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);

        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_UnifiedDataRecord_Html_0200
     * @tc.name ArKUIX_ArkTS_UnifiedDataRecord_Html_0200
     * @tc.desc Test HTML.htmlContent get/set
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     */
    it('ArKUIX_ArkTS_UnifiedDataRecord_Html_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_UnifiedDataRecord_Html_0200';
        console.info(`${caseName} start`);
        try {
          let html = new unifiedDataChannel.HTML();
          html.htmlContent = '<div><p>标题</p></div>';
          expect(html.htmlContent).assertEqual('<div><p>标题</p></div>');
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);

        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_UnifiedDataRecord_File_0300
     * @tc.name ArKUIX_ArkTS_UnifiedDataRecord_File_0300
     * @tc.desc Test File.uri get/set
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     */
    it('ArKUIX_ArkTS_UnifiedDataRecord_File_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_UnifiedDataRecord_File_0300';
        console.info(`${caseName} start`);
        try {
          let file = new unifiedDataChannel.File();
          file.uri = 'file://test.txt';
          expect(file.uri).assertEqual('file://test.txt');
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);

        done();
      })

    /**
     * @tc.number ArKUIX_ArkTS_UnifiedDataRecord_Image_0400
     * @tc.name ArKUIX_ArkTS_UnifiedDataRecord_Image_0400
     * @tc.desc Test Image.imageUri get/set
     * @tc.size MediumTest
     * @tc.type FUNCTION
     * @tc.level level3
     */
    it('ArKUIX_ArkTS_UnifiedDataRecord_Image_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_ArkTS_UnifiedDataRecord_Image_0400';
        console.info(`${caseName} start`);
        try {
          let image = new unifiedDataChannel.Image();
          image.imageUri = 'file://test.jpg';
          expect(image.imageUri).assertEqual('file://test.jpg');
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        console.info(`${caseName} end`);

        done();
      })
  })
}
