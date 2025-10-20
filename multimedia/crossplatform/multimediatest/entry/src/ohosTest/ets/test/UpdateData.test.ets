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

import { image } from '@kit.ImageKit';
import common from '@ohos.app.ability.common';
import { describe, it, expect, Level, beforeAll, beforeEach, afterEach, afterAll, TestType, Size } from '@ohos/hypium';
import { LOG_TAG, copyImageToSandbox } from './UpdateDataCommon.test';
import { BusinessError } from '@kit.BasicServicesKit';

const TAG = LOG_TAG + 'updateData';

async function updateDataCallbackTest(done: Function, testName: string, pathUri: string, array: ArrayBuffer,
  isFinished: boolean, offset: number, length: number) {
  try {
    let testContext: common.UIAbilityContext = AppStorage.get('testContext') as common.UIAbilityContext;
    const path = 'file://' + testContext.filesDir + "/" + pathUri;
    const imageSourceApi: image.ImageSource = await image.createImageSource(path);
    imageSourceApi.updateData(array, isFinished, offset, length, (error: BusinessError) => {
      imageSourceApi.release();
      if (error) {
        expect().assertFail();
      } else {
        console.info(`release success`);
      }
      done();
    })
  } catch (error) {
    console.info(TAG, `failed; error: ${error},${error.code}`, testName);
    expect().assertFail();
    done();
  }
}

export default function imageSourceUpdateDataPropertyTest() {
  describe('imageSourceUpdateDataPropertyTest', () => {

    beforeAll(async () => {
      console.info(TAG, 'beforeAll case.');
    });

    beforeEach(() => {
      console.info(TAG, 'beforeEach case.');
    });

    afterEach(() => {
      console.info(TAG, 'afterEach case.');
    });

    afterAll(() => {
      console.info(TAG, 'afterAll case.');
    });

    /**
     * @tc.number    : SUB_MULTIMEDIA_IMAGE_SOURCE_UPDATE_DATA_0100
     * @tc.name      : testImageSourceUpdateDataCallback0001
     * @tc.desc      : imageSource_updateData - callback with jpeg file, unfilled data (isFinished=false)
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testImageSourceUpdateDataCallback0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let testName = 'testImageSourceUpdateDataCallback0001';
        let fileName = 'test.jpeg';
        let path = new Date().getTime() + 'test.jpeg';
        let array: ArrayBuffer = new ArrayBuffer(100);
        let isFinished = false;
        let offset = 0;
        let length = 10;
        await copyImageToSandbox(fileName, path);
        await updateDataCallbackTest(done, testName, path, array, isFinished, offset, length);
      })

    /**
     * @tc.number    : SUB_MULTIMEDIA_IMAGE_SOURCE_UPDATE_DATA_0200
     * @tc.name      : testImageSourceUpdateDataCallback0002
     * @tc.desc      : imageSource_updateData - callback with jpeg file, completed data (isFinished=true)
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testImageSourceUpdateDataCallback0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let testName = 'testImageSourceUpdateDataCallback0002';
        let fileName = 'test.jpeg';
        let path = new Date().getTime() + 'test.jpeg';
        let array: ArrayBuffer = new ArrayBuffer(100);
        let isFinished = true;
        let offset = 0;
        let length = 10;
        await copyImageToSandbox(fileName, path);
        await updateDataCallbackTest(done, testName, path, array, isFinished, offset, length);
      })

    /**
     * @tc.number    : SUB_MULTIMEDIA_IMAGE_SOURCE_UPDATE_DATA_0300
     * @tc.name      : testImageSourceUpdateDataCallback0003
     * @tc.desc      : imageSource_updateData - callback with jpg file, large offset & length (100/100)
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testImageSourceUpdateDataCallback0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let testName = 'testImageSourceUpdateDataCallback0003';
        let fileName = 'test.jpg';
        let path = new Date().getTime() + 'test.jpg';
        let array: ArrayBuffer = new ArrayBuffer(100);
        let isFinished = true;
        let offset = 100;
        let length = 100;
        await copyImageToSandbox(fileName, path);
        await updateDataCallbackTest(done, testName, path, array, isFinished, offset, length);
      })

    /**
     * @tc.number    : SUB_MULTIMEDIA_IMAGE_SOURCE_UPDATE_DATA_0400
     * @tc.name      : testImageSourceUpdateDataCallback0004
     * @tc.desc      : imageSource_updateData - callback with jpg file, extra-large data (9999 bytes)
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testImageSourceUpdateDataCallback0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let testName = 'testImageSourceUpdateDataCallback0004';
        let fileName = 'test.jpg';
        let path = new Date().getTime() + 'test.jpg';
        let array: ArrayBuffer = new ArrayBuffer(9999);
        let isFinished = true;
        let offset = 9999;
        let length = 9999;
        await copyImageToSandbox(fileName, path);
        await updateDataCallbackTest(done, testName, path, array, isFinished, offset, length);
      })

    /**
     * @tc.number    : SUB_MULTIMEDIA_IMAGE_SOURCE_UPDATE_DATA_0500
     * @tc.name      : testImageSourceUpdateDataCallback0005
     * @tc.desc      : imageSource_updateData - callback with jpg file, empty data (0-byte buffer)
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testImageSourceUpdateDataCallback0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let testName = 'testImageSourceUpdateDataCallback0005';
        let fileName = 'test.jpg';
        let path = new Date().getTime() + 'test.jpg';
        let array: ArrayBuffer = new ArrayBuffer(0);
        let isFinished = true;
        let offset = 0;
        let length = 0;
        await copyImageToSandbox(fileName, path);
        await updateDataCallbackTest(done, testName, path, array, isFinished, offset, length);
      })
  })
}