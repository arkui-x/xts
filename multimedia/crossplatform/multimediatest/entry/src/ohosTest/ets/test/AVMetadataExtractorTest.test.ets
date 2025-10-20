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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, Level, Size, TestType } from "@ohos/hypium";
import { media } from "@kit.MediaKit";
import { BusinessError } from "@kit.BasicServicesKit";
import { image } from "@kit.ImageKit";
import MediaTestBase from "./MediaTestBase.test";
import { LOG_TAG, MediaErrorCode, SLEEP_TIME_200 } from "./Constants.test";
import { sleep } from './Common.test';
import { common } from "@kit.AbilityKit";

const TAG = LOG_TAG + 'AVMetadataExtractorTest';
const AUDIO_SOURCE = 'mjpeg_mp3.mp3';
const VIDEO_SOURCE = 'H264_AAC_Matedata.mp4';

let mediaTestBase = new MediaTestBase();
let fileDescriptor: media.AVFileDescriptor;
let fileDescriptor2: media.AVFileDescriptor;
let mMetadataExtractor: media.AVMetadataExtractor | undefined;

function openFileFailed() {
  console.info(TAG, 'openFileFailed case file fail');
}

async function fetchAlbumCoverCallback(done: Function, testName: string, descriptor: media.AVFileDescriptor) {
  console.info(TAG, testName + ' begin.');
  mMetadataExtractor = await media.createAVMetadataExtractor();
  if (mMetadataExtractor) {
    console.info(TAG, testName + ' Succeeded in creating AVMetadataExtractor.');
    mMetadataExtractor.fdSrc = descriptor;

    mMetadataExtractor.fetchAlbumCover(async (error: BusinessError, pixelMap: image.PixelMap) => {
      if (pixelMap !== undefined) {
        console.info(TAG,
          testName + ' isEditable: ' + pixelMap.isEditable);
        let imageInfo = await pixelMap.getImageInfo();
        expect(imageInfo.size.height > 0).assertTrue();
        expect(imageInfo.size.width > 0).assertTrue();
      } else {
        console.error(TAG, testName + ' Failed to fetch AlbumCover, code: ' + error.code + ', msg: ' + error.message);
        expect().assertFail();
      }
      done();
    });
  }
  done();
}

async function fetchAlbumCoverCallbackAbnormal(done: Function, testName: string, fileName: string) {
  console.info(TAG, testName + ' begin.');
  mMetadataExtractor = await media.createAVMetadataExtractor();
  if (mMetadataExtractor) {
    console.info(TAG, testName + ' Succeeded in creating AVMetadataExtractor.');
    if (fileName !== '') {
      let testContext: common.UIAbilityContext = AppStorage.get('testContext') as common.UIAbilityContext;
      try {
        mMetadataExtractor.fdSrc = await testContext.resourceManager.getRawFd(fileName);
      } catch (error) {
      }
    }
    mMetadataExtractor.fetchAlbumCover(async (error: BusinessError, pixelMap: image.PixelMap) => {
      if (pixelMap) {
        console.info(TAG,
          testName + ' isEditable: ' + pixelMap.isEditable);
        let imageInfo = await pixelMap.getImageInfo();
        expect(imageInfo.size.height > 0).assertTrue();
        expect(imageInfo.size.width > 0).assertTrue();
      } else {
        console.error(TAG, testName + ' Failed to fetch AlbumCover, code: ' + error.code + ', msg: ' + error.message);
        expect(error.code == MediaErrorCode.OPERATE_NOT_PERMIT || error.code == MediaErrorCode.AVERR_UNSUPPORT_FORMAT)
          .assertTrue();
      }
    });
  }
  done();
}

async function releaseCallback(done: Function, testName: string, descriptor: media.AVFileDescriptor) {
  console.info(TAG, testName + ' begin.');
  mMetadataExtractor = await media.createAVMetadataExtractor();
  if (mMetadataExtractor) {
    console.info(TAG, testName + ' Succeeded in creating AVMetadataExtractor.');
    mMetadataExtractor.fdSrc = descriptor;
    mMetadataExtractor.release(async (error: BusinessError) => {
      if (error) {
        console.error(TAG,
          testName + ' Failed to release AVMetadataExtractor, code: ' + error.code + ', msg: ' + error.message);
        expect().assertFail();
        done();
      } else {
        console.info(TAG, testName + ' release AVMetadataExtractor success.');
        mMetadataExtractor = undefined;
        expect(true).assertTrue();
      }
    });
  }
  done();
}

async function releaseCallbackNoFdSrc(done: Function, testName: string) {
  console.info(TAG, testName + ' begin.');
  mMetadataExtractor = await media.createAVMetadataExtractor();
  if (mMetadataExtractor) {
    console.info(TAG, testName + ' Succeeded in creating AVMetadataExtractor.');
    mMetadataExtractor.release(async (error: BusinessError) => {
      if (error) {
        console.error(TAG,
          testName + ' Failed to release AVMetadataExtractor, code: ' + error.code + ', msg: ' + error.message);
        expect().assertFail();
        done();
      } else {
        console.info(TAG, testName + ' release AVMetadataExtractor success.');
        mMetadataExtractor = undefined;
        expect(true).assertTrue();
      }
    });
  }
  done();
}

export default function AVMetadataExtractorTest() {
  describe('AVMetadataExtractorTest', () => {
    beforeAll(async () => {
      console.info(TAG, 'beforeAll case');
      await mediaTestBase.getFileDescriptorFromFileDir(VIDEO_SOURCE, openFileFailed).then((res) => {
        fileDescriptor = res;
      });
      await mediaTestBase.getFileDescriptorFromFileDir(AUDIO_SOURCE, openFileFailed).then((res) => {
        fileDescriptor2 = res;
      });
    });

    beforeEach(async () => {
      console.info(TAG, 'beforeEach case');
    });

    afterEach(async () => {
      console.info(TAG, 'afterEach case');
      await sleep(SLEEP_TIME_200);
      if (mMetadataExtractor !== undefined) {
        await mMetadataExtractor.release();
        mMetadataExtractor = undefined;
      }
    });

    afterAll(async () => {
      console.info(TAG, 'afterAll case');
      await mediaTestBase.closeFdNumber(fileDescriptor.fd);
      await mediaTestBase.closeFdNumber(fileDescriptor2.fd);
    });

    /**
     * @tc.number    : SUB_MULTIMEDIA_MEDIA_AV_METADATA_EXTRACTOR_TEST_0200
     * @tc.name      : testFetchAlbumCoverCallbackAbnormal0001
     * @tc.desc      : fetch AlbumCover callback-unSupported file type
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFetchAlbumCoverCallbackAbnormal0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const testName = 'testFetchAlbumCoverCallbackAbnormal0001';
        let fileName: string = 'test.jpg';
        await fetchAlbumCoverCallbackAbnormal(done, testName, fileName);
      })

    /**
     * @tc.number    : SUB_MULTIMEDIA_MEDIA_AV_METADATA_EXTRACTOR_TEST_0300
     * @tc.name      : testFetchAlbumCoverCallbackAbnormal0002
     * @tc.desc      : fetch AlbumCover callback-no fdSrc
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFetchAlbumCoverCallbackAbnormal0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const testName = 'testFetchAlbumCoverCallbackAbnormal0002';
        let fileName: string = '';
        await fetchAlbumCoverCallbackAbnormal(done, testName, fileName);
      })

    /**
     * @tc.number    : SUB_MULTIMEDIA_MEDIA_AV_METADATA_EXTRACTOR_TEST_0400
     * @tc.name      : testReleaseVideoCallback0001
     * @tc.desc      : release callback-mp4
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testReleaseVideoCallback0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const testName = 'testReleaseVideoCallback0001';
      await releaseCallback(done, testName, fileDescriptor);
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_MEDIA_AV_METADATA_EXTRACTOR_TEST_0500
     * @tc.name      : testReleaseAudioCallback001
     * @tc.desc      : release callback-mp3
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testReleaseAudioCallback0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const testName = 'testReleaseAudioCallback0001';
      await releaseCallback(done, testName, fileDescriptor2);
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_MEDIA_AV_METADATA_EXTRACTOR_TEST_0600
     * @tc.name      : testReleaseNoFdSrcCallback0001
     * @tc.desc      : release callback-no fdSrc
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testReleaseNoFdSrcCallback0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      const testName = 'testReleaseNoFdSrcCallback0001';
      await releaseCallbackNoFdSrc(done, testName);
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_MEDIA_AV_METADATA_EXTRACTOR_TEST_0700
     * @tc.name      : testDataSrc0001
     * @tc.desc      : verify dataSrc descriptor
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testDataSrc0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let testObject: media.AVMetadataExtractor = await media.createAVMetadataExtractor()
      let testDataSrc: media.AVDataSrcDescriptor = {
        fileSize: 5,
        callback: (buffer: ArrayBuffer, length: number): number => {
          return length;
        }
      }
      testObject.dataSrc = testDataSrc
      expect(testObject.dataSrc.fileSize).assertEqual(5);
      const buffer = new ArrayBuffer(10);
      expect(testObject.dataSrc.callback(buffer, 10)).assertEqual(10);
      done();
    })
  })
}