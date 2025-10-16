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

export default function AvPlayerEnumTest() {
  describe('AvPlayerEnumTest', () => {
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
     * @tc.number    : SUB_MULTIMEDIA_MEDIA_AVPLAYER_ENUM_0100
     * @tc.name      : testAvPlayerEnum001
     * @tc.desc      : AVPlayer Enumeration test - StateChangeReason
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testAvPlayerEnum001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      expect(media.StateChangeReason.USER).assertEqual(1);
      expect(media.StateChangeReason.BACKGROUND).assertEqual(2);
      done();
    });
    /**
     * @tc.number    : SUB_MULTIMEDIA_MEDIA_AVPLAYER_ENUM_0200
     * @tc.name      : testAvPlayerEnum002
     * @tc.desc      : AVPlayer Enumeration test - AVErrorCode
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testAvPlayerEnum002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      expect(media.AVErrorCode.AVERR_OK).assertEqual(0);
      expect(media.AVErrorCode.AVERR_NO_PERMISSION).assertEqual(201);
      expect(media.AVErrorCode.AVERR_INVALID_PARAMETER).assertEqual(401);
      expect(media.AVErrorCode.AVERR_UNSUPPORT_CAPABILITY).assertEqual(801);
      expect(media.AVErrorCode.AVERR_NO_MEMORY).assertEqual(5400101);
      expect(media.AVErrorCode.AVERR_OPERATE_NOT_PERMIT).assertEqual(5400102);
      expect(media.AVErrorCode.AVERR_IO).assertEqual(5400103);
      expect(media.AVErrorCode.AVERR_TIMEOUT).assertEqual(5400104);
      expect(media.AVErrorCode.AVERR_SERVICE_DIED).assertEqual(5400105);
      expect(media.AVErrorCode.AVERR_UNSUPPORT_FORMAT).assertEqual(5400106);
      expect(media.AVErrorCode.AVERR_AUDIO_INTERRUPTED).assertEqual(5400107);
      expect(media.AVErrorCode.AVERR_IO_HOST_NOT_FOUND).assertEqual(5411001);
      expect(media.AVErrorCode.AVERR_IO_CONNECTION_TIMEOUT).assertEqual(5411002);
      expect(media.AVErrorCode.AVERR_IO_NETWORK_ABNORMAL).assertEqual(5411003);
      expect(media.AVErrorCode.AVERR_IO_NETWORK_UNAVAILABLE).assertEqual(5411004);
      expect(media.AVErrorCode.AVERR_IO_NO_PERMISSION).assertEqual(5411005);
      done();
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_MEDIA_AVPLAYER_ENUM_0300
     * @tc.name      : testAvPlayerEnum003
     * @tc.desc      : AVPlayer Enumeration test - HdrType
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testAvPlayerEnum003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      expect(media.HdrType.AV_HDR_TYPE_NONE).assertEqual(0);
      expect(media.HdrType.AV_HDR_TYPE_VIVID).assertEqual(1);
      done();
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_MEDIA_AVPLAYER_ENUM_0400
     * @tc.name      : testAvPlayerEnum004
     * @tc.desc      : AVPlayer Enumeration test - AVErrorCode
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testAvPlayerEnum004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      expect(media.AVErrorCode.AVERR_IO_REQUEST_DENIED).assertEqual(5411006);
      expect(media.AVErrorCode.AVERR_IO_RESOURCE_NOT_FOUND).assertEqual(5411007);
      expect(media.AVErrorCode.AVERR_IO_SSL_CLIENT_CERT_NEEDED).assertEqual(5411008);
      expect(media.AVErrorCode.AVERR_IO_SSL_CONNECTION_FAILED).assertEqual(5411009);
      expect(media.AVErrorCode.AVERR_IO_SSL_SERVER_CERT_UNTRUSTED).assertEqual(5411010);
      expect(media.AVErrorCode.AVERR_IO_UNSUPPORTED_REQUEST).assertEqual(5411011);
      done();
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_MEDIA_AVPLAYER_ENUM_0500
     * @tc.name      : testAvPlayerEnum005
     * @tc.desc      : AVPlayer Enumeration test - BufferingInfoType
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testAvPlayerEnum005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      expect(media.BufferingInfoType.BUFFERING_START).assertEqual(1);
      expect(media.BufferingInfoType.BUFFERING_END).assertEqual(2);
      expect(media.BufferingInfoType.BUFFERING_PERCENT).assertEqual(3);
      expect(media.BufferingInfoType.CACHED_DURATION).assertEqual(4);
      done();
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_MEDIA_AVPLAYER_ENUM_0600
     * @tc.name      : testAvPlayerEnum006
     * @tc.desc      : AVPlayer Enumeration test - VideoScaleType
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testAvPlayerEnum006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      expect(media.VideoScaleType.VIDEO_SCALE_TYPE_SCALED_ASPECT).assertEqual(2);
      done();
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_MEDIA_AVPLAYER_ENUM_0700
     * @tc.name      : testAvPlayerEnum007
     * @tc.desc      : AVPlayer Enumeration test - MediaType
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testAvPlayerEnum007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      expect(media.MediaType.MEDIA_TYPE_AUD).assertEqual(0);
      expect(media.MediaType.MEDIA_TYPE_VID).assertEqual(1);
      done();
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_MEDIA_AVPLAYER_ENUM_0800
     * @tc.name      : testAvPlayerEnum008
     * @tc.desc      : AVPlayer Enumeration test - MediaDescriptionKey
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testAvPlayerEnum008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      expect(media.MediaDescriptionKey.MD_KEY_TRACK_INDEX).assertEqual("track_index");
      expect(media.MediaDescriptionKey.MD_KEY_TRACK_TYPE).assertEqual("track_type");
      expect(media.MediaDescriptionKey.MD_KEY_CODEC_MIME).assertEqual("codec_mime");
      expect(media.MediaDescriptionKey.MD_KEY_DURATION).assertEqual("duration");
      expect(media.MediaDescriptionKey.MD_KEY_BITRATE).assertEqual("bitrate");
      expect(media.MediaDescriptionKey.MD_KEY_WIDTH).assertEqual("width");
      expect(media.MediaDescriptionKey.MD_KEY_HEIGHT).assertEqual("height");
      expect(media.MediaDescriptionKey.MD_KEY_FRAME_RATE).assertEqual("frame_rate");
      expect(media.MediaDescriptionKey.MD_KEY_AUD_CHANNEL_COUNT).assertEqual("channel_count");
      expect(media.MediaDescriptionKey.MD_KEY_AUD_SAMPLE_RATE).assertEqual("sample_rate");
      done();
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_MEDIA_AVPLAYER_ENUM_0900
     * @tc.name      : testAvPlayerEnum009
     * @tc.desc      : AVPlayer Enumeration test - AudioSourceType
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testAvPlayerEnum009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      expect(media.AudioSourceType.AUDIO_SOURCE_TYPE_MIC).assertEqual(1);
      done();
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_MEDIA_AVPLAYER_ENUM_1000
     * @tc.name      : testAvPlayerEnum010
     * @tc.desc      : AVPlayer Enumeration test - SeekMode
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testAvPlayerEnum010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      expect(media.SeekMode.SEEK_PREV_SYNC).assertEqual(1);
      done();
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_MEDIA_AVPLAYER_ENUM_1100
     * @tc.name      : testAvPlayerEnum011
     * @tc.desc      : AVPlayer Enumeration test - SwitchMode
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testAvPlayerEnum011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      expect(media.SwitchMode.SMOOTH).assertEqual(0);
      expect(media.SwitchMode.SEGMENT).assertEqual(1);
      done();
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_MEDIA_AVPLAYER_ENUM_1200
     * @tc.name      : testAvPlayerEnum012
     * @tc.desc      : AVPlayer Enumeration test - CodecMimeType
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testAvPlayerEnum012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      expect(media.CodecMimeType.VIDEO_H263).assertEqual('video/h263');
      expect(media.CodecMimeType.VIDEO_AVC).assertEqual('video/avc');
      expect(media.CodecMimeType.VIDEO_MPEG2).assertEqual('video/mpeg2');
      expect(media.CodecMimeType.VIDEO_MPEG4).assertEqual('video/mp4v-es');
      expect(media.CodecMimeType.VIDEO_VP8).assertEqual('video/x-vnd.on2.vp8');
      expect(media.CodecMimeType.VIDEO_HEVC).assertEqual('video/hevc');
      expect(media.CodecMimeType.AUDIO_VORBIS).assertEqual('audio/vorbis');
      expect(media.CodecMimeType.AUDIO_FLAC).assertEqual('audio/flac');
      done();
    })
  })
}