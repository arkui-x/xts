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
import { describe, it, expect, TestType, Size, Level } from '@ohos/hypium';
import audio from '@ohos.multimedia.audio';

let Tag = 'AudioStreamDeviceChangeInfoTest'

let mockDevices: audio.AudioDeviceDescriptor[] = [
  {
    deviceRole: audio.DeviceRole.INPUT_DEVICE,
    deviceType: audio.DeviceType.SPEAKER,
    id: 1,
    name: 'Test Speaker',
    address: 'default',
    sampleRates: [audio.AudioSamplingRate.SAMPLE_RATE_48000],
    channelCounts: [audio.AudioChannel.CHANNEL_2],
    channelMasks: [0, 1],
    displayName: 'Test',
    encodingTypes: [audio.AudioEncodingType.ENCODING_TYPE_RAW]
  }
];

export default function propertiesTest() {
  describe('propertiesTest', () => {
    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_AudioStreamDeviceChangeInfo_0100
     * @tc.name      : testAudioDeviceDescriptor0100
     * @tc.desc      : test AudioDeviceDescriptor properties exist
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testAudioDeviceDescriptor0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let audioDeviceDescriptor: audio.AudioDeviceDescriptor = mockDevices[0]

        expect(audioDeviceDescriptor.deviceRole).not().assertUndefined();
        expect(audioDeviceDescriptor.deviceRole).not().assertNull();
        expect(audioDeviceDescriptor.deviceRole).assertEqual(audio.DeviceRole.INPUT_DEVICE);

        expect(audioDeviceDescriptor.deviceType).not().assertUndefined();
        expect(audioDeviceDescriptor.deviceType).not().assertNull();
        expect(audioDeviceDescriptor.deviceType).assertEqual(audio.DeviceType.SPEAKER);

        expect(audioDeviceDescriptor.id).not().assertUndefined();
        expect(audioDeviceDescriptor.id).not().assertNull();
        expect(audioDeviceDescriptor.id).assertEqual(1);

        expect(audioDeviceDescriptor.name).not().assertUndefined();
        expect(audioDeviceDescriptor.name).not().assertNull();
        expect(audioDeviceDescriptor.name).assertEqual('Test Speaker');

        expect(audioDeviceDescriptor.address).not().assertUndefined();
        expect(audioDeviceDescriptor.address).not().assertNull();
        expect(audioDeviceDescriptor.address).assertEqual('default');

        expect(audioDeviceDescriptor.sampleRates).not().assertUndefined();
        expect(audioDeviceDescriptor.sampleRates).not().assertNull();
        expect(audioDeviceDescriptor.sampleRates[0]).assertEqual(audio.AudioSamplingRate.SAMPLE_RATE_48000);

        expect(audioDeviceDescriptor.channelCounts).not().assertUndefined();
        expect(audioDeviceDescriptor.channelCounts).not().assertNull();
        expect(audioDeviceDescriptor.channelCounts[0]).assertEqual(audio.AudioChannel.CHANNEL_2);

        expect(audioDeviceDescriptor.channelMasks).not().assertUndefined();
        expect(audioDeviceDescriptor.channelMasks).not().assertNull();
        expect(audioDeviceDescriptor.channelMasks[0]).assertEqual(0);

        expect(audioDeviceDescriptor.displayName).not().assertUndefined();
        expect(audioDeviceDescriptor.displayName).not().assertNull();
        expect(audioDeviceDescriptor.displayName).assertEqual('Test');

        expect(audioDeviceDescriptor.encodingTypes).not().assertUndefined();
        expect(audioDeviceDescriptor.encodingTypes).not().assertNull();
        if (audioDeviceDescriptor.encodingTypes != undefined) {
          expect(audioDeviceDescriptor.encodingTypes[0]).assertEqual(audio.AudioEncodingType.ENCODING_TYPE_RAW);
        }
        done();
      });

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_AudioStreamDeviceChangeInfo_0100
     * @tc.name      : testAudioStreamDeviceChangeInfo0100
     * @tc.desc      : test AudioStreamDeviceChangeInfo properties exist
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testAudioStreamDeviceChangeInfo0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const deviceChangeInfo: audio.AudioStreamDeviceChangeInfo = {
          devices: mockDevices,
          changeReason: audio.AudioStreamDeviceChangeReason.REASON_NEW_DEVICE_AVAILABLE
        };

        expect(deviceChangeInfo.devices).not().assertUndefined();
        expect(deviceChangeInfo.devices).not().assertNull();
        expect(deviceChangeInfo.devices.length).assertEqual(1);

        expect(deviceChangeInfo.changeReason).not().assertUndefined();
        expect(deviceChangeInfo.changeReason).not().assertNull();
        expect(deviceChangeInfo.changeReason)
          .assertEqual(audio.AudioStreamDeviceChangeReason.REASON_NEW_DEVICE_AVAILABLE);
        done();
      });

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_VOLUMEEVENT_0100
     * @tc.name      : testVolumeEvent0100
     * @tc.desc      : test VolumeEvent properties exist
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testVolumeEvent0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let volumeEvent: audio.VolumeEvent = {
          volume: 10,
          volumeType: audio.AudioVolumeType.VOICE_CALL,
          updateUi: false
        }
        expect(volumeEvent.volume).not().assertUndefined();
        expect(volumeEvent.volume).not().assertNull();
        expect(volumeEvent.volume).assertEqual(10);
        done();
      });

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_DEVICECHANGEACTION_0100
     * @tc.name      : testDeviceChangeAction0100
     * @tc.desc      : test DeviceChangeAction properties exist
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testDeviceChangeAction0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let deviceChangeAction: audio.DeviceChangeAction = {
          type: audio.DeviceChangeType.CONNECT,
          deviceDescriptors: mockDevices
        }
        expect(deviceChangeAction.type).not().assertUndefined();
        expect(deviceChangeAction.type).not().assertNull();
        expect(deviceChangeAction.type).assertEqual(audio.DeviceChangeType.CONNECT);

        expect(deviceChangeAction.deviceDescriptors).not().assertUndefined();
        expect(deviceChangeAction.deviceDescriptors).not().assertNull();
        expect(deviceChangeAction.deviceDescriptors.length).assertEqual(1);
        done();
      });

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_AUDIOSESSIONSTRATEGY_0100
     * @tc.name      : testAudioSessionStrategy0100
     * @tc.desc      : test AudioSessionStrategy properties exist
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testAudioSessionStrategy0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let audioSessionStrategy: audio.AudioSessionStrategy = {
          concurrencyMode: audio.AudioConcurrencyMode.CONCURRENCY_DEFAULT
        }
        expect(audioSessionStrategy.concurrencyMode).not().assertUndefined();
        expect(audioSessionStrategy.concurrencyMode).not().assertNull();
        expect(audioSessionStrategy.concurrencyMode).assertEqual(audio.AudioConcurrencyMode.CONCURRENCY_DEFAULT);
        done();
      });

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_AUDIOSESSIONDEACTIVATEDEVENT_0100
     * @tc.name      : testAudioSessionDeactivatedEvent0100
     * @tc.desc      : test AudioSessionDeactivatedEvent properties exist
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testAudioSessionDeactivatedEvent0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let audioSessionDeactivatedEvent: audio.AudioSessionDeactivatedEvent = {
          reason: audio.AudioSessionDeactivatedReason.DEACTIVATED_LOWER_PRIORITY
        }
        expect(audioSessionDeactivatedEvent.reason).not().assertUndefined();
        expect(audioSessionDeactivatedEvent.reason).not().assertNull();
        expect(audioSessionDeactivatedEvent.reason)
          .assertEqual(audio.AudioSessionDeactivatedReason.DEACTIVATED_LOWER_PRIORITY);
        done();
      });

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_AUDIORENDERERCHANGEINFO_0100
     * @tc.name      : testAudioRendererChangeInfo0100
     * @tc.desc      : test AudioRendererChangeInfo properties exist
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testAudioRendererChangeInfo0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let audioRendererChangeInfo: audio.AudioRendererChangeInfo = {
          streamId: 0,
          rendererInfo: {
            usage: audio.StreamUsage.STREAM_USAGE_MUSIC,
            rendererFlags: 0,
          },
          deviceDescriptors: mockDevices
        }
        expect(audioRendererChangeInfo.streamId).not().assertUndefined();
        expect(audioRendererChangeInfo.streamId).not().assertNull();
        expect(audioRendererChangeInfo.streamId).assertEqual(0);

        expect(audioRendererChangeInfo.rendererInfo).not().assertUndefined();
        expect(audioRendererChangeInfo.rendererInfo).not().assertNull();
        expect(audioRendererChangeInfo.rendererInfo.usage).assertEqual(audio.StreamUsage.STREAM_USAGE_MUSIC);

        expect(audioRendererChangeInfo.deviceDescriptors).not().assertUndefined();
        expect(audioRendererChangeInfo.deviceDescriptors).not().assertNull();
        expect(audioRendererChangeInfo.deviceDescriptors.length).assertEqual(1);
        done();
      });

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_AUDIOCAPTURERCHANGEINFO_0100
     * @tc.name      : testAudioCapturerChangeInfo0100
     * @tc.desc      : test AudioCapturerChangeInfo properties exist
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testAudioCapturerChangeInfo0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let audioCapturerChangeInfo: audio.AudioCapturerChangeInfo = {
          capturerInfo: {
            source: audio.SourceType.SOURCE_TYPE_MIC,
            capturerFlags: 0,
          },
          deviceDescriptors: mockDevices,
          streamId: 0,
          muted: true
        }
        expect(audioCapturerChangeInfo.streamId).not().assertUndefined();
        expect(audioCapturerChangeInfo.streamId).not().assertNull();
        expect(audioCapturerChangeInfo.streamId).assertEqual(0);

        expect(audioCapturerChangeInfo.muted).not().assertUndefined();
        expect(audioCapturerChangeInfo.muted).not().assertNull();
        expect(audioCapturerChangeInfo.muted).assertEqual(true);

        expect(audioCapturerChangeInfo.deviceDescriptors).not().assertUndefined();
        expect(audioCapturerChangeInfo.deviceDescriptors).not().assertNull();
        expect(audioCapturerChangeInfo.deviceDescriptors.length).assertEqual(1);
        done();
      });

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_INTERRUPTEVENT_0100
     * @tc.name      : testInterruptEvent0100
     * @tc.desc      : test InterruptEvent properties exist
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testInterruptEvent0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let interruptEvent: audio.InterruptEvent = {
          eventType: audio.InterruptType.INTERRUPT_TYPE_BEGIN,
          forceType: audio.InterruptForceType.INTERRUPT_FORCE,
          hintType: audio.InterruptHint.INTERRUPT_HINT_RESUME
        }
        expect(interruptEvent).not().assertUndefined();
        expect(interruptEvent).not().assertNull();

        expect(interruptEvent.eventType).not().assertUndefined();
        expect(interruptEvent.eventType).not().assertNull();
        expect(interruptEvent.eventType).assertEqual(audio.InterruptType.INTERRUPT_TYPE_BEGIN);

        expect(interruptEvent.forceType).not().assertUndefined();
        expect(interruptEvent.forceType).not().assertNull();
        expect(interruptEvent.forceType).assertEqual(audio.InterruptForceType.INTERRUPT_FORCE);

        expect(interruptEvent.hintType).not().assertUndefined();
        expect(interruptEvent.hintType).not().assertNull();
        expect(interruptEvent.hintType).assertEqual(audio.InterruptHint.INTERRUPT_HINT_RESUME);
        done();
      });
  })
}
