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
import audio from '@ohos.multimedia.audio';
import { describe, it, expect, Level } from '@ohos/hypium';

export default function audioEnumsTest() {
  describe('audioEnumsTest', () => {
    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ENUM_0100
     * @tc.name      : testMultimediaAudioEnum0100
     * @tc.desc      : test audio AudioErrors value
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testMultimediaAudioEnum0100', Level.LEVEL0, async (done: Function) => {
      expect(audio.AudioErrors.ERROR_INVALID_PARAM).assertEqual(6800101);
      expect(audio.AudioErrors.ERROR_NO_MEMORY).assertEqual(6800102);
      expect(audio.AudioErrors.ERROR_ILLEGAL_STATE).assertEqual(6800103);
      expect(audio.AudioErrors.ERROR_UNSUPPORTED).assertEqual(6800104);
      expect(audio.AudioErrors.ERROR_SYSTEM).assertEqual(6800301);
      done();
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ENUM_0200
     * @tc.name      : testMultimediaAudioEnum0200
     * @tc.desc      : test audio AudioState value
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testMultimediaAudioEnum0200', Level.LEVEL0, async (done: Function) => {
      expect(audio.AudioState.STATE_INVALID).assertEqual(-1);
      expect(audio.AudioState.STATE_NEW).assertEqual(0);
      done();
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ENUM_0300
     * @tc.name      : testMultimediaAudioEnum0300
     * @tc.desc      : test audio InterruptType value
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testMultimediaAudioEnum0300', Level.LEVEL0, async (done: Function) => {
      expect(audio.InterruptType.INTERRUPT_TYPE_BEGIN).assertEqual(1);
      expect(audio.InterruptType.INTERRUPT_TYPE_END).assertEqual(2);
      done();
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ENUM_0400
     * @tc.name      : testMultimediaAudioEnum0400
     * @tc.desc      : test audio DeviceType value
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testMultimediaAudioEnum0400', Level.LEVEL0, async (done: Function) => {
      expect(audio.DeviceType.DEFAULT).assertEqual(1000);
      done();
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ENUM_0500
     * @tc.name      : testMultimediaAudioEnum0500
     * @tc.desc      : test audio InterruptHint value
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testMultimediaAudioEnum0500', Level.LEVEL0, async (done: Function) => {
      expect(audio.InterruptHint.INTERRUPT_HINT_RESUME).assertEqual(1);
      done();
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ENUM_0600
     * @tc.name      : testMultimediaAudioEnum0600
     * @tc.desc      : test audio InterruptForceType value
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testMultimediaAudioEnum0600', Level.LEVEL0, async (done: Function) => {
      expect(audio.InterruptForceType.INTERRUPT_FORCE).assertEqual(0);
      done();
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ENUM_0700
     * @tc.name      : testMultimediaAudioEnum0700
     * @tc.desc      : test audio DeviceChangeType value
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testMultimediaAudioEnum0700', Level.LEVEL0, async (done: Function) => {
      expect(audio.DeviceChangeType.CONNECT).assertEqual(0);
      expect(audio.DeviceChangeType.DISCONNECT).assertEqual(1);
      done();
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ENUM_0800
     * @tc.name      : testMultimediaAudioEnum0800
     * @tc.desc      : test audio AudioScene value
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testMultimediaAudioEnum0800', Level.LEVEL0, async (done: Function) => {
      expect(audio.AudioScene.AUDIO_SCENE_DEFAULT).assertEqual(0);
      expect(audio.AudioScene.AUDIO_SCENE_VOICE_CHAT).assertEqual(3);
      done();
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ENUM_0900
     * @tc.name      : testMultimediaAudioEnum0900
     * @tc.desc      : test audio AudioConcurrencyMode value
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testMultimediaAudioEnum0900', Level.LEVEL0, async (done: Function) => {
      expect(audio.AudioConcurrencyMode.CONCURRENCY_DEFAULT).assertEqual(0);
      expect(audio.AudioConcurrencyMode.CONCURRENCY_MIX_WITH_OTHERS).assertEqual(1);
      expect(audio.AudioConcurrencyMode.CONCURRENCY_DUCK_OTHERS).assertEqual(2);
      expect(audio.AudioConcurrencyMode.CONCURRENCY_PAUSE_OTHERS).assertEqual(3);
      done();
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ENUM_1000
     * @tc.name      : testMultimediaAudioEnum1000
     * @tc.desc      : test audio AudioSessionDeactivatedReason value
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testMultimediaAudioEnum1000', Level.LEVEL0, async (done: Function) => {
      expect(audio.AudioSessionDeactivatedReason.DEACTIVATED_LOWER_PRIORITY).assertEqual(0);
      expect(audio.AudioSessionDeactivatedReason.DEACTIVATED_TIMEOUT).assertEqual(1);
      done();
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ENUM_1100
     * @tc.name      : testMultimediaAudioEnum1100
     * @tc.desc      : test audio AudioStreamDeviceChangeReason value
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testMultimediaAudioEnum1100', Level.LEVEL0, async (done: Function) => {
      expect(audio.AudioStreamDeviceChangeReason.REASON_UNKNOWN).assertEqual(0);
      expect(audio.AudioStreamDeviceChangeReason.REASON_NEW_DEVICE_AVAILABLE).assertEqual(1);
      expect(audio.AudioStreamDeviceChangeReason.REASON_OLD_DEVICE_UNAVAILABLE).assertEqual(2);
      expect(audio.AudioStreamDeviceChangeReason.REASON_OVERRODE).assertEqual(3);
      done();
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ENUM_1200
     * @tc.name      : testMultimediaAudioEnum1200
     * @tc.desc      : test audio AudioDataCallbackResult value
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testMultimediaAudioEnum1200', Level.LEVEL0, async (done: Function) => {
      expect(audio.AudioDataCallbackResult.INVALID).assertEqual(-1);
      expect(audio.AudioDataCallbackResult.VALID).assertEqual(0);
      done();
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ENUM_1300
     * @tc.name      : testMultimediaAudioEnum1300
     * @tc.desc      : test audio AudioChannelLayout value
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testMultimediaAudioEnum1300', Level.LEVEL0, async (done: Function) => {
      expect(audio.AudioChannelLayout.CH_LAYOUT_HEXADECAGONAL).assertEqual(0x18003F737);
      done();
    })
  })
}