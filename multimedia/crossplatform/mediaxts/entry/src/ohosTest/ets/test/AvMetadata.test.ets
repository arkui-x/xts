/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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
import { BusinessError } from '@ohos.base';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import common from '@ohos.app.ability.common';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import image from "@ohos.multimedia.image";

let abilityDelegatorRegistry: AbilityDelegatorRegistry.AbilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
let context: common.Context = abilityDelegatorRegistry.getAppContext().createModuleContext("entry_test");

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function closeFileDescriptor(fileName: string) {
  try {
    context.resourceManager.closeRawFd(fileName);
  } catch (error) {
    let code = (error as BusinessError).code;
    let message = (error as BusinessError).message;
    console.error(`promise closeRawFd failed, error code: ${code}, message: ${message}.`);
  }
}

export default function AvMetadataTest() {
  describe('AvMetadataTest', () => {
    beforeAll(() => {
      console.info('beforeAll case');
    })

    beforeEach(() => {
      console.info('beforeEach case');
    })

    afterEach(() => {
      console.info('afterEach case');
    })

    afterAll(() => {
      closeFileDescriptor('mjpeg_mp3.mp3');
      closeFileDescriptor('test2.mp4');
      console.info('afterAll case');
    })
    let avMetadataExtractor: media.AVMetadataExtractor;
    const TAG = "MetadataDemo"
    const WAIT_TIME = 600;
    const WAIT_THOUSAND = 1000;

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_0100
     * @tc.name   : createAVMetadataExtractor
     * @tc.desc   : Test createAVMetadataExtractor interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_0100', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_0100 createAVMetadataExtractor success');
          expect(avMetadataExtractor != null).assertTrue();
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_0100 createAVMetadataExtractor fail');
        }
        done();
      })
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_0200
     * @tc.name   : createAVMetadataExtractor
     * @tc.desc   : Test createAVMetadataExtractor interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_0200', 0, async (done: Function) => {
      media.createAVMetadataExtractor((error, extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_0200 createAVRecorder  success');
          expect(avMetadataExtractor != null).assertTrue();
        } else {
          console.info(`SUB_ArkUIX_Media_TestAVMetadata_Func_0200 createAVRecorder fail, error:${error}`);
        }
      })
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_0300
     * @tc.name   : fetchMetadata
     * @tc.desc   : test AVmetadata album
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_0300', 0, async (done: Function) => {
      let avMetadataExtractor: media.AVMetadataExtractor = await media.createAVMetadataExtractor();
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('test2.mp4');
      await sleep(WAIT_TIME)
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_0300 callback success, album: ${metadata.album}`);
        if (metadata.album = undefined) {
          expect(metadata.album).assertUndefined();
        } else if (metadata.album = "") {
          expect(metadata.album).assertEqual("");
        }
        avMetadataExtractor.release();
        ;
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_0300 catchCallback, error:${error}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_0400
     * @tc.name   : fetchMetadata
     * @tc.desc   : Local Video playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_0400', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_0400 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_0400 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_0400 error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('test2.mp4');
      console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_0400 success, fdSrc:` + avMetadataExtractor.fdSrc);
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_0400 Video albumArtist: ${metadata.albumArtist}`);
        if (metadata.albumArtist = undefined) {
          expect(metadata.albumArtist).assertUndefined();
        } else if (metadata.albumArtist = "") {
          expect(metadata.albumArtist).assertEqual("");
        }
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_0400 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_0500
     * @tc.name   : test AVmetadata artist
     * @tc.desc   : Local Video playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_0500', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_0500 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_0500 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_0500 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('test2.mp4');
      await sleep(WAIT_TIME)
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_0500 Video artist: ${metadata.artist}`);
        if (metadata.artist = undefined) {
          expect(metadata.artist).assertUndefined();
        } else if (metadata.artist = "") {
          expect(metadata.artist).assertEqual("");
        }
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_0500 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_0600
     * @tc.name   : test AVmetadata author
     * @tc.desc   : Local Video playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_0600', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_0600 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_0600 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_0600 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('test2.mp4');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_0600 Video author: ${metadata.author}`);
        if (metadata.author = undefined) {
          expect(metadata.author).assertUndefined();
        } else if (metadata.author = "") {
          expect(metadata.author).assertEqual("");
        }
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_0600 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_0700
     * @tc.name   : test AVmetadata dateTime
     * @tc.desc   : Local Video playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_0700', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_0700 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_0700 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_0700 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('test2.mp4');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_0700 Video dateTime: ${metadata.dateTime}`);
        if (metadata.dateTime = undefined) {
          expect(metadata.dateTime).assertUndefined();
        } else if (metadata.dateTime = "") {
          expect(metadata.dateTime).assertEqual("");
        }
        avMetadataExtractor.release();
        done()
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_0700 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_0800
     * @tc.name   : test AVmetadata videoHeight
     * @tc.desc   : Local Video playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_0800', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_0800 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_0800 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_0800 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('test2.mp4');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_0800 Video videoHeight: ${metadata.videoHeight}`);
        expect(metadata.videoHeight).assertEqual("720");
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_0800 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_0900
     * @tc.name   : test AVmetadata videoWidth
     * @tc.desc   : Local Video playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_0900', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_0900 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_0900 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_0900 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('test2.mp4');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_0900Video videoWidth: ${metadata.videoWidth}`);
        expect(metadata.videoWidth).assertEqual("1280");
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_0900 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_01000
     * @tc.name   : test AVmetadata duration
     * @tc.desc   : Local Video playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_01000', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_01000 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_01000 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_01000 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('test2.mp4');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_01000 Video duration: ${metadata.duration}`);
        if (metadata.author = "11827") {
          expect(metadata.author).assertEqual("11827");
        } else if (metadata.author = "11828") {
          expect(metadata.author).assertEqual("11828");
        }
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_01000 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_01100
     * @tc.name   : test AVmetadata hasAudio
     * @tc.desc   : Local Video playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_01100', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_01100 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_01100 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_01100 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('test2.mp4');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_01100 Video hasAudio: ${metadata.hasAudio}`);
        expect(metadata.hasAudio).assertEqual("yes")
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_01100 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })
    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_01200
     * @tc.name   : test AVmetadata hasAudio
     * @tc.desc   : Local Video playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_01200', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_01200 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_01200 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_01200 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('test2.mp4');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_01200 Video hasVideo: ${metadata.hasVideo}`);
        expect(metadata.hasVideo).assertEqual("yes")
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_01200 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_01300
     * @tc.name   : test AVmetadata trackCount
     * @tc.desc   : Local Video playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_01300', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_01300 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_01300 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_01300 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('test2.mp4');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_01300 Video trackCount: ${metadata.trackCount}`);
        expect(metadata.trackCount).assertEqual("2");
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_01300 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_01400
     * @tc.name   : test AVmetadata videoOrientation
     * @tc.desc   : Local Video playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_01400', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_01400 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_01400 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_01400 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('test2.mp4');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_01400 Video videoOrientation: ${metadata.videoOrientation}`);
        if (metadata.videoOrientation = "0") {
          expect(metadata.videoOrientation).assertEqual("0");
        } else if (metadata.videoOrientation = "") {
          expect(metadata.videoOrientation).assertEqual("");
        }
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_01400 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_01500
     * @tc.name   : test AVmetadata title
     * @tc.desc   : Local Video playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_01500', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_01500 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_01500 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_01500 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('test2.mp4');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_01500 Video title: ${metadata.title}`);
        if (metadata.title = undefined) {
          expect(metadata.title).assertUndefined();
        } else if (metadata.title = "") {
          expect(metadata.title).assertEqual("");
        }
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_01500 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_01600
     * @tc.name   : test AVmetadata composer
     * @tc.desc   : Local Video playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_01600', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_01600 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_01600 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_01600 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('test2.mp4');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_01600 Video composer: ${metadata.composer}`);
        if (metadata.composer = undefined) {
          expect(metadata.composer).assertUndefined();
        } else if (metadata.composer = "") {
          expect(metadata.composer).assertEqual("");
        }
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_01600 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_01700
     * @tc.name   : test AVmetadata genre
     * @tc.desc   : Local Video playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_01700', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_01700 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_01700 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_01700 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('test2.mp4');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_01700 Video genre: ${metadata.genre}`);
        if (metadata.genre = undefined) {
          expect(metadata.genre).assertUndefined();
        } else if (metadata.genre = "") {
          expect(metadata.genre).assertEqual("");
        }
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_01700 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_01800
     * @tc.name   : test AVmetadata mimeType
     * @tc.desc   : Local Video playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_01800', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_01800 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_01800 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_01800 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('test2.mp4');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_01800 Video mimeType: ${metadata.mimeType}`);
        if (metadata.mimeType = undefined) {
          expect(metadata.mimeType).assertUndefined();
        } else if (metadata.mimeType = "video/mp4") {
          expect(metadata.mimeType).assertEqual("video/mp4");
        }
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_01800 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_01900
     * @tc.name   : test AVmetadata sampleRate
     * @tc.desc   : Local Video playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_01900', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_01900 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_01900 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_01900 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('test2.mp4');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_01900 Video sampleRate: ${metadata.sampleRate}`);
        if (metadata.sampleRate = undefined) {
          expect(metadata.sampleRate).assertUndefined();
        } else if (metadata.sampleRate = "48000") {
          expect(metadata.sampleRate).assertEqual("48000");
        }
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_01900 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_02000
     * @tc.name   : test AVmetadata sampleRate
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_02000', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_02000 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_02000 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_02000 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_02000 Video sampleRate: ${metadata.sampleRate}`);
        if (metadata.sampleRate = undefined) {
          expect(metadata.sampleRate).assertUndefined();
        } else if (metadata.sampleRate = "48000") {
          expect(metadata.sampleRate).assertEqual("48000");
        }
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_02000 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_02100
     * @tc.name   : test AVmetadata album
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_02100', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_02100 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_02100 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_02100 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_02100 audio album: ${metadata.album}`);
        expect(metadata.album).assertEqual("media");
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_02100 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_02200
     * @tc.name   : test AVmetadata albumArtist
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_02200', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_02200 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_02200 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_02200 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_02200 audio albumArtist: ${metadata.albumArtist}`);
        if (metadata.albumArtist = undefined) {
          expect(metadata.albumArtist).assertUndefined();
        } else if (metadata.albumArtist = "media_test") {
          expect(metadata.albumArtist).assertEqual("media_test");
        }
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_02200 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_02300
     * @tc.name   : test AVmetadata artist
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_02300', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_02300 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_02300 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_02300 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_02300 audio artist: ${metadata.artist}`);
        expect(metadata.artist).assertEqual("元数据测试");
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_02300 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_02400
     * @tc.name   : test AVmetadata author
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_02400', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_02400 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_02400 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_02400 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_02400 audio author: ${metadata.author}`);
        if (metadata.author = undefined) {
          expect(metadata.author).assertUndefined();
        } else if (metadata.author = "media") {
          expect(metadata.author).assertEqual("media");
        }
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_02400 catchCallback, error message:${error.message}`);
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_02500
     * @tc.name   : test AVmetadata dateTime
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_02500', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_02500 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_02500 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_02500 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_02500 audio dateTime: ${metadata.dateTime}`);
        if (metadata.dateTime = undefined) {
          expect(metadata.dateTime).assertUndefined();
        } else if (metadata.dateTime = "2015-11-23") {
          expect(metadata.dateTime).assertEqual("2015-11-23");
        }
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_02500 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_02600
     * @tc.name   : test AVmetadata duration
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_02600', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_02600 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_02600 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_02600 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_02600 audio duration: ${metadata.duration}`);
        if (metadata.duration = undefined) {
          expect(metadata.duration).assertUndefined();
        } else if (metadata.duration = "219600") {
          expect(metadata.duration).assertEqual("219600");
        }
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_02600 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_02700
     * @tc.name   : test AVmetadata videoHeight
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_02700', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_02700 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_02700 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_02700 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_02700 audio videoHeight: ${metadata.videoHeight}`);
        if (metadata.videoHeight = undefined) {
          expect(metadata.videoHeight).assertUndefined();
        } else if (metadata.videoHeight = "") {
          expect(metadata.videoHeight).assertEqual("");
        }
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_02700 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_02800
     * @tc.name   : test AVmetadata videoWidth
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_02800', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_02800 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_02800 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_02800 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_02800 audio videoWidth: ${metadata.videoWidth}`);
        if (metadata.videoWidth = undefined) {
          expect(metadata.videoWidth).assertUndefined();
        } else if (metadata.videoWidth = "") {
          expect(metadata.videoWidth).assertEqual("");
        }
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_02800 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_02900
     * @tc.name   : test AVmetadata hasAudio
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_02900', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_02900 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_02900 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_02900 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_02900 audio hasAudio: ${metadata.hasAudio}`);
        expect(metadata.hasAudio).assertEqual("yes");
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_02900 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_03000
     * @tc.name   : test AVmetadata hasVideo
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_03000', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_03000 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_03000 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_03000 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_03000 audio hasVideo: ${metadata.hasVideo}`);
        if (metadata.hasVideo = undefined) {
          expect(metadata.hasVideo).assertUndefined();
        } else if (metadata.hasVideo = "") {
          expect(metadata.hasVideo).assertEqual("");
        }
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_03000 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_03100
     * @tc.name   : test AVmetadata trackCount
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_03100', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_03100 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_03100 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_03100 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_03100 audio trackCount: ${metadata.trackCount}`);
        expect(metadata.trackCount).assertEqual("1")
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_03100 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_03200
     * @tc.name   : test AVmetadata videoOrientation
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_03200', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_03200 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_03200 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_03200 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3')
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG,`SUB_ArkUIX_Media_TestAVMetadata_Func_03200 videoOrientation: ${metadata.videoOrientation}`);
        if (metadata.videoOrientation = undefined) {
          expect(metadata.videoOrientation).assertUndefined();
        } else if (metadata.videoOrientation = "") {
          expect(metadata.videoOrientation).assertEqual("");
        }
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_03200 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_03300
     * @tc.name   : test AVmetadata title
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_03300', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_03300 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_03300 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_03300 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_03300 audio title: ${metadata.title}`);
        expect(metadata.title).assertEqual("test");
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_03300 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_03400
     * @tc.name   : test AVmetadata dateTimeFormat
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_03400', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_03400 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_03400 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_03400 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG,`SUB_ArkUIX_Media_TestAVMetadata_Func_03400 audio dateTimeFormat: ${metadata.dateTimeFormat}`);
        if (metadata.dateTimeFormat = undefined) {
          expect(metadata.dateTimeFormat).assertUndefined();
        } else if (metadata.dateTimeFormat = "2015-11-23 00:00:00") {
          expect(metadata.dateTimeFormat).assertEqual("2015-11-23 00:00:00");
        }
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_03400 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_03500
     * @tc.name   : test AVmetadata composer
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_03500', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_03500 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_03500 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_03500 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_TIME);
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_03500 audio composer: ${metadata.composer}`);
        expect(metadata.composer).assertEqual("测试");
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_03500 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_03600
     * @tc.name   : test AVmetadata genre
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_03600', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_03600 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_03600 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_03600 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_TIME)
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_03600 audio composer: ${metadata.genre}`);
        if (metadata.genre = undefined) {
          expect(metadata.genre).assertUndefined();
        } else if (metadata.genre = "Lyrical") {
          expect(metadata.genre).assertEqual("Lyrical");
        }
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_03600 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();

      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_03700
     * @tc.name   : test AVmetadata mimeType
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_03700', 0, async (done: Function) => {
      await media.createAVMetadataExtractor().then((extractor) => {
        if (extractor != null) {
          avMetadataExtractor = extractor;
          console.info('SUB_ArkUIX_Media_TestAVMetadata_Func_03700 createAVMetadataExtractor success');
        } else {
          console.error('SUB_ArkUIX_Media_TestAVMetadata_Func_03700 createAVMetadataExtractor fail');
        }
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_03700 catchCallback, error message:${error.message}`);
      });
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_TIME)
      await avMetadataExtractor.fetchMetadata().then((metadata: media.AVMetadata) => {
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_03700 audio mimeType: ${metadata.mimeType}`);
        if (metadata.mimeType = undefined) {
          expect(metadata.mimeType).assertUndefined();
        } else if (metadata.mimeType = " audio/mpeg") {
          expect(metadata.mimeType).assertEqual(" audio/mpeg");
        }
        avMetadataExtractor.release();
        done();
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_03700 catchCallback, error message:${error.message}`);
        expect().assertFail();
        done();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_03800
     * @tc.name   : test callback AVmetadata composer
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_03800', 0, async (done: Function) => {
      let avMetadataExtractor: media.AVMetadataExtractor = await media.createAVMetadataExtractor();
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_THOUSAND);
      avMetadataExtractor.fetchMetadata((err, metadata) => {
        if (err) {
          console.error(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_03800 failed, err = ${JSON.stringify(err)}`);
          expect().assertFail();
          return
        }
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_03800 success composer :${metadata.composer}}`);
        expect(metadata.composer).assertEqual("测试");
        avMetadataExtractor.release();
        done();
      })
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_03900
     * @tc.name   : test callback AVmetadata album
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_03900', 0, async (done: Function) => {
      let avMetadataExtractor: media.AVMetadataExtractor = await media.createAVMetadataExtractor();
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_THOUSAND);
      avMetadataExtractor.fetchMetadata((err: BusinessError, metadata: media.AVMetadata) => {
        if (err) {
          console.error(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_03900 failed, err = ${JSON.stringify(err)}`);
          expect().assertFail();
          return;
        }
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_03900 success  album :${metadata.album}}`);
        expect(metadata.album).assertEqual("media");
        avMetadataExtractor.release();
      })
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_04000
     * @tc.name   : test callback AVmetadata albumArtist
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_04000', 0, async (done: Function) => {
      let avMetadataExtractor: media.AVMetadataExtractor = await media.createAVMetadataExtractor();
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_THOUSAND);
      avMetadataExtractor.fetchMetadata((err: BusinessError, metadata: media.AVMetadata) => {
        if (err) {
          console.error(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_04000 failed, err = ${JSON.stringify(err)}`);
          expect().assertFail();
          return;
        }
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_04000 success albumArtist :${metadata.albumArtist}}`);
        if (metadata.albumArtist = undefined) {
          expect(metadata.albumArtist).assertUndefined();
        } else if (metadata.albumArtist = "media_test") {
          expect(metadata.albumArtist).assertEqual("media_test");
        }
        avMetadataExtractor.release();
      })
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_04100
     * @tc.name   : test callback AVmetadata mimeType
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_04100', 0, async (done: Function) => {
      let avMetadataExtractor: media.AVMetadataExtractor = await media.createAVMetadataExtractor();
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_THOUSAND);
      avMetadataExtractor.fetchMetadata((err, metadata) => {
        if (err) {
          console.error(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_04100 failed, err = ${JSON.stringify(err)}`);
          return;
        }
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_04100 success mimeType :${metadata.mimeType}}`);
        if (metadata.mimeType = undefined) {
          expect(metadata.mimeType).assertUndefined();
        } else if (metadata.mimeType = " audio/mpeg") {
          expect(metadata.mimeType).assertEqual(" audio/mpeg");
        }
        avMetadataExtractor.release();
      })
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_04200
     * @tc.name   : test callback AVmetadata sampleRate
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_04200', 0, async (done: Function) => {
      let avMetadataExtractor: media.AVMetadataExtractor = await media.createAVMetadataExtractor();
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_THOUSAND);
      avMetadataExtractor.fetchMetadata((err, metadata) => {
        if (err) {
          console.error(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_04200 failed, err = ${JSON.stringify(err)}`);
          return;
        }
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_04200 success sampleRate :${metadata.sampleRate}}`);
        if (metadata.sampleRate = undefined) {
          expect(metadata.sampleRate).assertUndefined();
        } else if (metadata.sampleRate = "48000") {
          expect(metadata.sampleRate).assertEqual("48000");
        }
        avMetadataExtractor.release();
      })
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_04300
     * @tc.name   : test callback AVmetadata hasAudio
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_04300', 0, async (done: Function) => {
      let avMetadataExtractor: media.AVMetadataExtractor = await media.createAVMetadataExtractor();
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_THOUSAND);
      avMetadataExtractor.fetchMetadata((err, metadata) => {
        if (err) {
          console.error(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_04300 failed, err = ${JSON.stringify(err)}`);
          return;
        }
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_04300 success  hasAudio :${metadata.hasAudio}}`);
        expect(metadata.hasAudio).assertEqual("yes");
        avMetadataExtractor.release();
      })
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_04400
     * @tc.name   : test callback AVmetadata trackCount
     * @tc.desc   : Local audio playback control test
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_04400', 0, async (done: Function) => {
      let avMetadataExtractor: media.AVMetadataExtractor = await media.createAVMetadataExtractor();
      avMetadataExtractor.fdSrc = await context.resourceManager.getRawFd('mjpeg_mp3.mp3');
      await sleep(WAIT_THOUSAND);
      avMetadataExtractor.fetchMetadata((err, metadata) => {
        if (err) {
          console.error(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_04400 failed, err = ${JSON.stringify(err)}`);
          return;
        }
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_04400 success trackCount :${metadata.trackCount}}`);
        expect(metadata.trackCount).assertEqual("1");
        avMetadataExtractor.release();
      })
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVMetadata_Func_04500
     * @tc.name   : testAVMeta PixelMap
     * @tc.desc   : Test AVMetadataExtractor fetchAlbumCover interface
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Media_TestAVMetadata_Func_04500', 0, async (done: Function) => {
      let pixel_map: image.PixelMap | undefined = undefined;
      let avMetadataExtractor: media.AVMetadataExtractor = await media.createAVMetadataExtractor()
      await sleep(WAIT_THOUSAND)
      await avMetadataExtractor.fetchAlbumCover().then((pixelMap: image.PixelMap) => {
        pixel_map = pixelMap;
        console.info(TAG, `SUB_ArkUIX_Media_TestAVMetadata_Func_04500 callback success video PixelMap :${pixel_map}}`)
      }).catch((error: BusinessError) => {
        console.error(`SUB_ArkUIX_Media_TestAVMetadata_Func_04500 catchCallback, error message:${error.message}`)
        expect(error.code == 5400102).assertTrue();
        avMetadataExtractor.release();
      });
      done();
    })
  })
}