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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Size, Level } from '@ohos/hypium';
import audio from '@ohos.multimedia.audio';

let Tag: string = "AudioStreamManager";

export function sleep(ms: number): Promise<string> {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve('');
    }, ms);
  });
}

interface renderInfoType {
  MUSIC: audio.AudioRendererInfo,
  RINGTONE: audio.AudioRendererInfo,
  VOICE_ASSISTANT: audio.AudioRendererInfo,
  ALARM: audio.AudioRendererInfo,
  ACCESSIBILITY: audio.AudioRendererInfo,
  MOVIE: audio.AudioRendererInfo,
  GAME: audio.AudioRendererInfo,
  VOICE_COMMUNICATION: audio.AudioRendererInfo,
  NOTIFICATION: audio.AudioRendererInfo,
}

interface streamInfoType {
  A16000: audio.AudioStreamInfo,
  A44100: audio.AudioStreamInfo,
  A48000: audio.AudioStreamInfo
}

let rendererInfo: renderInfoType = {
  MUSIC: {
    usage: audio.StreamUsage.STREAM_USAGE_MUSIC,
    rendererFlags: 0,
  },
  VOICE_COMMUNICATION: {
    usage: audio.StreamUsage.STREAM_USAGE_VOICE_COMMUNICATION,
    rendererFlags: 0
  },
  RINGTONE: {
    usage: audio.StreamUsage.STREAM_USAGE_RINGTONE,
    rendererFlags: 0,
  },
  VOICE_ASSISTANT: {
    usage: audio.StreamUsage.STREAM_USAGE_VOICE_ASSISTANT,
    rendererFlags: 0
  },
  ALARM: {
    usage: audio.StreamUsage.STREAM_USAGE_ALARM,
    rendererFlags: 0
  },
  ACCESSIBILITY: {
    usage: audio.StreamUsage.STREAM_USAGE_ACCESSIBILITY,
    rendererFlags: 0
  },
  MOVIE: {
    usage: audio.StreamUsage.STREAM_USAGE_MOVIE,
    rendererFlags: 0
  },
  GAME: {
    usage: audio.StreamUsage.STREAM_USAGE_GAME,
    rendererFlags: 0
  },
  NOTIFICATION: {
    usage: audio.StreamUsage.STREAM_USAGE_NOTIFICATION,
    rendererFlags: 0
  }
}
let streamInfo: streamInfoType = {
  A16000: {
    samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_16000,
    channels: audio.AudioChannel.CHANNEL_2,
    sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE,
    encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW
  },
  A44100: {
    samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_44100,
    channels: audio.AudioChannel.CHANNEL_2,
    sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE,
    encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW
  },
  A48000: {
    samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_48000,
    channels: audio.AudioChannel.CHANNEL_2,
    sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S32LE,
    encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW
  },
}

export default function audioRendererTest() {
  describe('audioRendererTest', () => {
    beforeAll(async () => {
      console.info('TestLog: Start Testing AudioFrameworkTest Interfaces');
    })

    beforeEach(async () => {
      console.info(`${Tag}: beforeEach: Prerequisites at the test case level`);
      await sleep(100);
    })

    afterEach(async () => {
      console.info(`${Tag}: afterEach: Test case-level clearance conditions`);
      await sleep(100);
    })

    afterAll(() => {
      console.info(`${Tag}: afterAll: Test suite-level cleanup condition`);
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ON_OFF_OUTPUTDEVICECHANGE_0100
     * @tc.name      : testOnOffOutputDeviceChange0100
     * @tc.desc      : on_outputDeviceChange INPUT_INVALID_TYPE --401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it("testOnOffOutputDeviceChange0100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let audioRendererOptions: audio.AudioRendererOptions = {
          streamInfo: streamInfo.A48000,
          rendererInfo: rendererInfo.VOICE_COMMUNICATION
        };
        let audioRenderer = await audio.createAudioRenderer(audioRendererOptions);
        let flag: boolean = false;
        try {
          let para: ESObject = 1;
          audioRenderer.on('outputDeviceChange', para);
          expect(flag).assertTrue();
        } catch (error) {
          console.error(`ERROR Code: ${error.code},${error.massage}`);
          expect(Number(error.code) == 401).assertTrue();
          flag = true;
        }
        await audioRenderer.release();
        expect(flag).assertTrue();
        done();
      })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ON_OFF_OUTPUTDEVICECHANGE_0200
     * @tc.name      : testOnOffOutputDeviceChange0200
     * @tc.desc      : on_outputDeviceChange INPUT_INVALID_PARAMETER --6800101
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it("testOnOffOutputDeviceChange0200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let audioRendererOptions: audio.AudioRendererOptions = {
          streamInfo: streamInfo.A48000,
          rendererInfo: rendererInfo.VOICE_COMMUNICATION
        };
        let audioRenderer = await audio.createAudioRenderer(audioRendererOptions);
        let flag: boolean = false;
        try {
          let para: ESObject = '1';
          audioRenderer.on(para, () => {
          });
          expect(flag).assertTrue();
        } catch (error) {
          console.error(`ERROR Code: ${error.code},${error.massage}`);
          expect(Number(error.code) == 6800101).assertTrue();
          flag = true;
        }
        await audioRenderer.release();
        expect(flag).assertTrue();
        done();
      })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ON_OFF_OUTPUTDEVICECHANGE_0300
     * @tc.name      : testOnOffOutputDeviceChange0300
     * @tc.desc      : off[outputDeviceChange] INPUT_INVALID_TYPE 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it("testOnOffOutputDeviceChange0300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let audioRendererOptions: audio.AudioRendererOptions = {
          streamInfo: streamInfo.A48000,
          rendererInfo: rendererInfo.VOICE_COMMUNICATION
        };
        let audioRenderer = await audio.createAudioRenderer(audioRendererOptions);
        audioRenderer.on('outputDeviceChange', (deviceInfo: audio.AudioDeviceDescriptors) => {
          console.info(`DeviceInfo id: ${deviceInfo[0].id}`);
          console.info(`DeviceInfo name: ${deviceInfo[0].name}`);
          console.info(`DeviceInfo address: ${deviceInfo[0].address}`);
        });
        try {
          let para: ESObject = '1';
          audioRenderer.off('outputDeviceChange', para);
          await audioRenderer.release();
        } catch (error) {
          console.log(`error : ${error.message},Code:${error.code}`);
          expect(Number(error.code)).assertEqual(401);
        }
        done();
      })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ON_OFF_OUTPUTDEVICECHANGEWITHINFO_0100
     * @tc.name      : testOnOffOutputDeviceChangeWithInfo0100
     * @tc.desc      : on_outputDeviceChangeWithInfo
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it("testOnOffOutputDeviceChangeWithInfo0100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let audioRendererOptions: audio.AudioRendererOptions = {
          streamInfo: streamInfo.A48000,
          rendererInfo: rendererInfo.VOICE_COMMUNICATION
        };
        let audioRenderer = await audio.createAudioRenderer(audioRendererOptions);
        try {
          audioRenderer.on('outputDeviceChangeWithInfo', (AudioStreamDeviceChangeInfo) => {
            console.info(`devices: ${JSON.stringify(AudioStreamDeviceChangeInfo.devices)}`);
            console.info(`changeReason: ${JSON.stringify(AudioStreamDeviceChangeInfo.changeReason)}`);
          });
          audioRenderer.off('outputDeviceChangeWithInfo', (AudioStreamDeviceChangeInfo) => {
            console.info(`devices: ${JSON.stringify(AudioStreamDeviceChangeInfo.devices)}`);
            console.info(`changeReason: ${JSON.stringify(AudioStreamDeviceChangeInfo.changeReason)}`);
          });
          await audioRenderer.release();
        } catch {
          expect().assertFail()
        }
        done();
      })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ON_OFF_OUTPUTDEVICECHANGEWITHINFO_0200
     * @tc.name      : testOnOffOutputDeviceChangeWithInfo0200
     * @tc.desc      : on_outputDeviceChange 401
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testOnOffOutputDeviceChangeWithInfo0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let audioRendererOptions: audio.AudioRendererOptions = {
          streamInfo: streamInfo.A48000,
          rendererInfo: rendererInfo.VOICE_COMMUNICATION
        };

        let audioRenderer: audio.AudioRenderer = await audio.createAudioRenderer(audioRendererOptions);

        try {
          let para: ESObject = '1';
          audioRenderer.on('outputDeviceChangeWithInfo', para);
        } catch (error) {
          console.log(`error : ${error.message},Code:${error.code}`);
          expect(Number(error.code)).assertEqual(401);
        }
        done();
      })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ON_OFF_WriteData_0100
     * @tc.name      : testOnOffWriteData0100
     * @tc.desc      : off [writeData] invalid_type 401
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it("testOnOffWriteData0100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let audioRendererOptions: audio.AudioRendererOptions = {
          streamInfo: streamInfo.A48000,
          rendererInfo: rendererInfo.VOICE_COMMUNICATION
        };
        let audioRenderer = await audio.createAudioRenderer(audioRendererOptions);
        audioRenderer.on('writeData', (eventAudioDataCallbackResult: ArrayBuffer) => {
          console.log("eventAudioDataCallbackResult:" + 'SUCCESS')
        })
        try {
          let para: ESObject = '1';
          audioRenderer.off('writeData', para);
        } catch (error) {
          console.log(`error : ${error.message},Code:${error.code}`);
          expect(Number(error.code)).assertEqual(401);
        }
        done();
      })
  })
}
