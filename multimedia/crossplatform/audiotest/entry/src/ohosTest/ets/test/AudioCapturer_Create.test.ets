import { BusinessError } from '@ohos.base';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import audio from '@ohos.multimedia.audio';
import deviceInfo from '@ohos.deviceInfo';

const enum_2 = 2;
const enum_5 = 5;
const enum_20 = 20;
const enum_100000 = 100000;
const channelLayout_err = 0x1000000033333;
const errCode_6800101 = 6800101;
const errCode_6800301 = 6800301;
const waitReadyMs_100 = 100;
const waitReadyMs_300 = 300;
const waitReadyMs_400 = 400;
const waitReadyMs_5000 = 5000;
let isPass = false;
let isCreated = true;
let audioCapturer: audio.AudioCapturer;
let channelLayoutArray1: Array<audio.AudioChannelLayout>;
let channelLayoutArray2: Array<audio.AudioChannelLayout>;
let channelLayoutArray3: Array<audio.AudioChannelLayout>;
let osFullNameInfo: string = deviceInfo.osFullName;
console.info('the deviceInfo osFullName is :' + osFullNameInfo);
const platform = osFullNameInfo.split(' ')[0];
console.info('the device platform is :' + platform);

let audioCapturerOptions: audio.AudioCapturerOptions = {
  streamInfo: {
    samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_44100,
    channels: audio.AudioChannel.CHANNEL_1,
    sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE,
    encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW
  },
  capturerInfo: {
    source: audio.SourceType.SOURCE_TYPE_MIC,
    capturerFlags: 0
  }
}

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function resetAudioCapturerOptions() {
  audioCapturerOptions = {
    streamInfo: {
      samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_48000,
      channels: audio.AudioChannel.CHANNEL_2,
      sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE,
      encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW,
    },
    capturerInfo: {
      source: audio.SourceType.SOURCE_TYPE_MIC,
      capturerFlags: 0
    }
  }
}

async function createAudioCapturerCallback(audioCapturer: audio.AudioCapturer,
                                           audioCapturerOptions: audio.AudioCapturerOptions) {
  audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
    if (err) {
      isPass = false;
      isCreated = false;
      console.error('AudioCapturer Created: ERROR:' + err);
    } else {
      if (data != null) {
        audioCapturer = data;
      } else {
        isPass = false;
        isCreated = false;
        console.error('AudioCapturer Created: Fail');
      }
    }
  });
  await sleep(waitReadyMs_400);
  if (isCreated == false) {
    isCreated = true;
    expect().assertFail();
  }
  return audioCapturer;
}

async function createAudioCapturerPromise(audioCapturer: audio.AudioCapturer,
                                          audioCapturerOptions: audio.AudioCapturerOptions) {
  await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
    if (data != null) {
      audioCapturer = data;
    } else {
      isPass = false;
      isCreated = false;
      console.error('AudioCapturer Created: Fail');
    }
  }).catch((err: BusinessError) => {
    isPass = false;
    isCreated = false;
    console.error('AudioCapturer Created: ERROR:' + err);
  });
  if (isCreated == false) {
    isCreated = true;
    expect().assertFail();
  }
  return audioCapturer;
}

export default function audioCapturer_CreateTest() {
  describe('audioCapturer_CreateTest', () => {
    beforeAll(async () => {
      if (platform.startsWith('OpenHarmony')) {
        await sleep(waitReadyMs_5000);
      }
    })
    beforeEach(async () => {
      isPass = false;
      await sleep(waitReadyMs_100);
    })

    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0100
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0100', 0, async (done: Function) => {
      try{
        await sleep(waitReadyMs_300);
        audioCapturerOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_8000;
        audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_11025;
        audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_12000;
        audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_16000;
        audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_22050;
        audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_24000;
        audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_32000;
        audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_44100;
        audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_48000;
        audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_64000;
        audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_96000;
        audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0100 error' + error);
      }
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0200
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0200', 0, async (done: Function) => {
      try{
        await sleep(waitReadyMs_300);
        audioCapturerOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_8000;
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_11025;
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_12000;
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_16000;
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_22050;
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_24000;
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_32000;
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_44100;
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_48000;
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_64000;
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_96000;
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0200 error' + error);
      }
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0300
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Callback
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0300', 0, async (done: Function) => {
      try{
        audioCapturerOptions.streamInfo.samplingRate = enum_100000;
        audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
          if (err) {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0300 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0300 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0400
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Promise
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0400', 0, async (done: Function) => {
      try{
        audioCapturerOptions.streamInfo.samplingRate = enum_100000;
        await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
          console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0400 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0400 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0500
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0500', 0, async (done: Function) => {
      isPass = true;
      try{
        await resetAudioCapturerOptions();
        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_1;
        audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_2;
        audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_3;
        audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_4;
        audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_5;
        audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_6;
        audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_7;
        audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
          if (err) {
            if (err.code != errCode_6800301) {
              isPass = false;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0500 fail');
          }
        });

        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_8;
        audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
          if (err) {
            if (err.code != errCode_6800301) {
              isPass = false;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0500 fail');
          }
        });

        if (platform != 'Android') {
          audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_9;
          audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
            if (err) {
              if (err.code != errCode_6800301) {
                isPass = false;
              }
            } else {
              console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0500 fail');
            }
          });
        }

        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_10;
        audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
          if (err) {
            if (err.code != errCode_6800301) {
              isPass = false;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0500 fail');
          }
        });

        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_12;
        audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
          if (err) {
            if (err.code != errCode_6800301) {
              isPass = false;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0500 fail');
          }
        });

        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_14;
        audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
          if (err) {
            if (err.code != errCode_6800301) {
              isPass = false;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0500 fail');
          }
        });

        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_16;
        audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
          if (err) {
            if (err.code != errCode_6800301) {
              isPass = false;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0500 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0500 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0600
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0600', 0, async (done: Function) => {
      isPass = true;
      try{
        await resetAudioCapturerOptions();
        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_1;
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_2;
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_3;
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_4;
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_5;
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_6;
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_7;
        await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
          console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0600 fail');
        }).catch((err: BusinessError) => {
          if (err.code != errCode_6800301) {
            isPass = false;
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0600 fail');
          }
        });

        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_8;
        await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
          console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0600 fail');
        }).catch((err: BusinessError) => {
          if (err.code != errCode_6800301) {
            isPass = false;
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0600 fail');
          }
        });

        if (platform != 'Android') {
          audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_9;
          await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
            console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0600 fail');
          }).catch((err: BusinessError) => {
            if (err.code != errCode_6800301) {
              isPass = false;
            } else {
              console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0600 fail');
            }
          });
        }

        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_10;
        await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
          console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0600 fail');
        }).catch((err: BusinessError) => {
          if (err.code != errCode_6800301) {
            isPass = false;
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0600 fail');
          }
        });

        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_12;
        await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
          console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0600 fail');
        }).catch((err: BusinessError) => {
          if (err.code != errCode_6800301) {
            isPass = false;
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0600 fail');
          }
        });

        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_14;
        await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
          console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0600 fail');
        }).catch((err: BusinessError) => {
          if (err.code != errCode_6800301) {
            isPass = false;
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0600 fail');
          }
        });

        audioCapturerOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_16;
        await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
          console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0600 fail');
        }).catch((err: BusinessError) => {
          if (err.code != errCode_6800301) {
            isPass = false;
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0600 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0600 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0700
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Callback
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0700', 0, async (done: Function) => {
      try{
        audioCapturerOptions.streamInfo.channels = enum_20;
        audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
          if (err) {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0700 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0700 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0800
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Promise
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0800', 0, async (done: Function) => {
      try{
        audioCapturerOptions.streamInfo.channels = enum_20;
        await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
          console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0800 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0800 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0900
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0900', 0, async (done: Function) => {
      isPass = true;
      try{
        await resetAudioCapturerOptions();
        audioCapturerOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_U8;
        audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE;
        audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        if (platform != 'Android') {
          audioCapturerOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_S24LE;
          audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
          expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioCapturer.release();

          audioCapturerOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_S32LE;
          audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
          expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioCapturer.release();
        } else {
          audioCapturerOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_S24LE;
          audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
            if (err) {
              expect(true).assertTrue();
            } else {
              expect(data.state).assertEqual(audio.AudioState.STATE_PREPARED);
            }
          });

          audioCapturerOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_S32LE;
          audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
            if (err) {
              expect(true).assertTrue();
            } else {
              expect(data.state).assertEqual(audio.AudioState.STATE_PREPARED);
            }
          });
        }

        audioCapturerOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_INVALID;
        audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
          if (err) {
            if (err.code != errCode_6800301) {
              isPass = false;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0900 fail');
          }
        });

        audioCapturerOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_F32LE;
        audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
          if (err) {
            if (err.code != errCode_6800301) {
              isPass = false;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0900 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_0900 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1000
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1000', 0, async (done: Function) => {
      isPass = true;
      try{
        await resetAudioCapturerOptions();
        audioCapturerOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_U8;
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE;
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        if (platform != 'Android') {
          audioCapturerOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_S24LE;
          audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
          expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioCapturer.release();

          audioCapturerOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_S32LE;
          audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
          expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioCapturer.release();
        } else {
          audioCapturerOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_S24LE;
          await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
            expect(data.state).assertEqual(audio.AudioState.STATE_PREPARED);
          }).catch((err: BusinessError) => {
            expect(true).assertTrue();
          });

          audioCapturerOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_S32LE;
          await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
            expect(data.state).assertEqual(audio.AudioState.STATE_PREPARED);
          }).catch((err: BusinessError) => {
            expect(true).assertTrue();
          });
        }

        audioCapturerOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_INVALID;
        await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
          console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1000 fail');
        }).catch((err: BusinessError) => {
          if (err.code != errCode_6800301) {
            isPass = false;
          }
        });

        audioCapturerOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_F32LE;
        await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
          console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1000 fail');
        }).catch((err: BusinessError) => {
          if (err.code != errCode_6800301) {
            isPass = false;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1000 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1100
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Callback
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1100', 0, async (done: Function) => {
      try{
        audioCapturerOptions.streamInfo.sampleFormat = enum_5;
        audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
          if (err) {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1100 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1100 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1200
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Promise
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1200', 0, async (done: Function) => {
      try{
        audioCapturerOptions.streamInfo.sampleFormat = enum_5;
        await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
          console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1200 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1200 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1300
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1300', 0, async (done: Function) => {
      try{
        await resetAudioCapturerOptions();
        audioCapturerOptions.streamInfo.encodingType = audio.AudioEncodingType.ENCODING_TYPE_RAW;
        audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.encodingType = audio.AudioEncodingType.ENCODING_TYPE_INVALID;
        audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
          if (err) {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1300 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1300 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1400
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1400', 0, async (done: Function) => {
      try{
        await resetAudioCapturerOptions();
        audioCapturerOptions.streamInfo.encodingType = audio.AudioEncodingType.ENCODING_TYPE_RAW;
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.encodingType = audio.AudioEncodingType.ENCODING_TYPE_INVALID;
        await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
          console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1400 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1400 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1500
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Callback
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1500', 0, async (done: Function) => {
      try{
        audioCapturerOptions.streamInfo.encodingType = enum_2;
        audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
          if (err) {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1500 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1500 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1600
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Promise
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1600', 0, async (done: Function) => {
      try{
        audioCapturerOptions.streamInfo.encodingType = enum_2;
        await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
          console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1600 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1600 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1700
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1700', 0, async (done: Function) => {
      isPass = true;
      if (platform != 'Android') {
        channelLayoutArray1 = [audio.AudioChannelLayout.CH_LAYOUT_UNKNOWN,
          audio.AudioChannelLayout.CH_LAYOUT_MONO, audio.AudioChannelLayout.CH_LAYOUT_STEREO,
          audio.AudioChannelLayout.CH_LAYOUT_2POINT1, audio.AudioChannelLayout.CH_LAYOUT_2POINT0POINT2,
          audio.AudioChannelLayout.CH_LAYOUT_3POINT0, audio.AudioChannelLayout.CH_LAYOUT_SURROUND,
          audio.AudioChannelLayout.CH_LAYOUT_3POINT1, audio.AudioChannelLayout.CH_LAYOUT_4POINT0,
          audio.AudioChannelLayout.CH_LAYOUT_QUAD,audio.AudioChannelLayout.CH_LAYOUT_4POINT1];
      } else {
        channelLayoutArray1 = [audio.AudioChannelLayout.CH_LAYOUT_UNKNOWN,
          audio.AudioChannelLayout.CH_LAYOUT_MONO, audio.AudioChannelLayout.CH_LAYOUT_STEREO,
          audio.AudioChannelLayout.CH_LAYOUT_SURROUND, audio.AudioChannelLayout.CH_LAYOUT_QUAD,];
      }

      await resetAudioCapturerOptions();
      if (platform.startsWith('OpenHarmony')) {
        audioCapturerOptions.streamInfo.channelLayout = audio.AudioChannelLayout.CH_LAYOUT_UNKNOWN;
        audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
          if (err) {
            isPass = false;
          } else {
            audioCapturer = data;
          }
        });
        await sleep(waitReadyMs_400);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.channelLayout = audio.AudioChannelLayout.CH_LAYOUT_STEREO;
        audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
          if (err) {
            isPass = false;
          } else {
            audioCapturer = data;
          }
        });
        await sleep(waitReadyMs_400);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();
      }
      try {
        for (let i = 0; i < channelLayoutArray1.length; i++) {
          if (platform.startsWith('OpenHarmony')) {
            if (channelLayoutArray1[i] != audio.AudioChannelLayout.CH_LAYOUT_UNKNOWN &&
              channelLayoutArray1[i] != audio.AudioChannelLayout.CH_LAYOUT_STEREO) {
              audioCapturerOptions.streamInfo.channelLayout = channelLayoutArray1[i];
              audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
                if (err) {
                  if (err.code != errCode_6800301) {
                    isPass = false;
                  }
                }
              });
              await sleep(waitReadyMs_400);
            }
          } else {
            audioCapturerOptions.streamInfo.channelLayout = channelLayoutArray1[i];
            audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
              if (err) {
                isPass = false
              } else {
                audioCapturer = data;
              }
            });
            await sleep(waitReadyMs_400);
            expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
            await audioCapturer.release();
          }
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1700 error' + error);
      }
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1800
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1800', 0, async (done: Function) => {
      isPass = true;
      if (platform != 'Android') {
        channelLayoutArray2 = [audio.AudioChannelLayout.CH_LAYOUT_5POINT0,
          audio.AudioChannelLayout.CH_LAYOUT_5POINT1, audio.AudioChannelLayout.CH_LAYOUT_6POINT0,
          audio.AudioChannelLayout.CH_LAYOUT_HEXAGONAL, audio.AudioChannelLayout.CH_LAYOUT_6POINT1,
          audio.AudioChannelLayout.CH_LAYOUT_7POINT0, audio.AudioChannelLayout.CH_LAYOUT_7POINT0_FRONT,
          audio.AudioChannelLayout.CH_LAYOUT_7POINT1];
      } else {
        channelLayoutArray2 = [audio.AudioChannelLayout.CH_LAYOUT_5POINT1,
          audio.AudioChannelLayout.CH_LAYOUT_6POINT1, audio.AudioChannelLayout.CH_LAYOUT_7POINT1,
          audio.AudioChannelLayout.CH_LAYOUT_5POINT1POINT2, audio.AudioChannelLayout.CH_LAYOUT_5POINT1POINT4];
      }

      try{
        await resetAudioCapturerOptions();
        for (let i = 0; i < channelLayoutArray2.length; i++) {
          if (platform.startsWith('OpenHarmony')) {
            audioCapturerOptions.streamInfo.channelLayout = channelLayoutArray2[i];
            audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
              if (err) {
                if (err.code != errCode_6800301) {
                  isPass = false;
                }
              }
            });
            await sleep(waitReadyMs_400);
          } else {
            audioCapturerOptions.streamInfo.channelLayout = channelLayoutArray2[i];
            audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
              if (err) {
                isPass = false
              } else {
                audioCapturer = data;
              }
            });
            await sleep(waitReadyMs_400);
            expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
            await audioCapturer.release();
          }
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1800 error' + error);
      }
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1900
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1900', 0, async (done: Function) => {
      isPass = true;
      if (platform != 'Android') {
        channelLayoutArray3 = [audio.AudioChannelLayout.CH_LAYOUT_OCTAGONAL,
          audio.AudioChannelLayout.CH_LAYOUT_5POINT1POINT2,
          audio.AudioChannelLayout.CH_LAYOUT_5POINT1POINT4, audio.AudioChannelLayout.CH_LAYOUT_7POINT1POINT2,
          audio.AudioChannelLayout.CH_LAYOUT_7POINT1POINT4, audio.AudioChannelLayout.CH_LAYOUT_10POINT2,
          audio.AudioChannelLayout.CH_LAYOUT_9POINT1POINT6, audio.AudioChannelLayout.CH_LAYOUT_AMB_ORDER3_ACN_N3D,
          audio.AudioChannelLayout.CH_LAYOUT_9POINT1POINT6, audio.AudioChannelLayout.CH_LAYOUT_AMB_ORDER3_ACN_SN3D];
      } else {
        channelLayoutArray3 = [audio.AudioChannelLayout.CH_LAYOUT_7POINT1POINT2,
          audio.AudioChannelLayout.CH_LAYOUT_7POINT1POINT4, audio.AudioChannelLayout.CH_LAYOUT_9POINT1POINT6,];
      }

      try{
        await resetAudioCapturerOptions();
        for (let i = 0; i < channelLayoutArray3.length; i++) {
          if (platform.startsWith('OpenHarmony')) {
            audioCapturerOptions.streamInfo.channelLayout = channelLayoutArray3[i];
            audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
              if (err) {
                if (err.code != errCode_6800301) {
                  isPass = false;
                }
              }
            });
            await sleep(waitReadyMs_400);
          } else {
            audioCapturerOptions.streamInfo.channelLayout = channelLayoutArray3[i];
            audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
              if (err) {
                isPass = false
              } else {
                audioCapturer = data;
              }
            });
            await sleep(waitReadyMs_400);
            expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
            await audioCapturer.release();
          }
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_1900 error' + error);
      }
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2000
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2000', 0, async (done: Function) => {
      isPass = true;
      await resetAudioCapturerOptions();
      if (platform.startsWith('OpenHarmony')) {
        audioCapturerOptions.streamInfo.channelLayout = audio.AudioChannelLayout.CH_LAYOUT_UNKNOWN;
        await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
          audioCapturer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        await sleep(waitReadyMs_400);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();

        audioCapturerOptions.streamInfo.channelLayout = audio.AudioChannelLayout.CH_LAYOUT_STEREO;
        await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
          audioCapturer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        await sleep(waitReadyMs_400);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioCapturer.release();
      }
      try {
        for (let i = 0; i < channelLayoutArray1.length; i++) {
          if (platform.startsWith('OpenHarmony')) {
            if (channelLayoutArray1[i] != audio.AudioChannelLayout.CH_LAYOUT_UNKNOWN &&
              channelLayoutArray1[i] != audio.AudioChannelLayout.CH_LAYOUT_STEREO) {
              audioCapturerOptions.streamInfo.channelLayout = channelLayoutArray1[i];
              await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
                isPass = false;
              }).catch((err: BusinessError) => {
                expect(err.code == errCode_6800301).assertTrue();
              });
              await sleep(waitReadyMs_100);
            }
          } else {
            audioCapturerOptions.streamInfo.channelLayout = channelLayoutArray1[i];
            await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
              audioCapturer = data;
            }).catch((err: BusinessError) => {
              isPass = false
            });
            await sleep(waitReadyMs_100);
            expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
            await audioCapturer.release();
          }
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2000 error' + error);
      }
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2100
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2100', 0, async (done: Function) => {
      isPass = true;
      try{
        await resetAudioCapturerOptions();
        for (let i = 0; i < channelLayoutArray2.length; i++) {
          if (platform.startsWith('OpenHarmony')) {
            audioCapturerOptions.streamInfo.channelLayout = channelLayoutArray2[i];
            await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
              isPass = false;
            }).catch((err: BusinessError) => {
              expect(err.code == errCode_6800301).assertTrue();
            });
          } else {
            audioCapturerOptions.streamInfo.channelLayout = channelLayoutArray2[i];
            await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
              audioCapturer = data;
            }).catch((err: BusinessError) => {
              isPass = false;
            });
            await sleep(waitReadyMs_100);
            expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
            await audioCapturer.release();
          }
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2100 error' + error);
      }
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2200
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2200', 0, async (done: Function) => {
      isPass = true;
      try{
        await resetAudioCapturerOptions();
        for (let i = 0; i < channelLayoutArray3.length; i++) {
          if (platform.startsWith('OpenHarmony')) {
            audioCapturerOptions.streamInfo.channelLayout = channelLayoutArray3[i];
            await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
              isPass = false;
            }).catch((err: BusinessError) => {
              expect(err.code == errCode_6800301).assertTrue();
            });
          } else {
            audioCapturerOptions.streamInfo.channelLayout = channelLayoutArray3[i];
            await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
              audioCapturer = data;
            }).catch((err: BusinessError) => {
              isPass = false;
            });
            await sleep(waitReadyMs_100);
            expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
            await audioCapturer.release();
          }
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2200 error' + error);
      }
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2300
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Callback
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2300', 0, async (done: Function) => {
      try{
        audioCapturerOptions.streamInfo.channelLayout = channelLayout_err;
        audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
          if (err) {
            if (platform.startsWith('OpenHarmony')) {
              if (err.code == errCode_6800301) {
                isPass = true;
              }
            }
            console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2300 fail');
          } else {
            audioCapturer = data;
          }
        });
        await sleep(waitReadyMs_400);
        if (platform == 'Android' || platform == 'iOS') {
          expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2300 error' + error);
      }
      if (platform.startsWith('OpenHarmony')) {
        expect(isPass).assertTrue();
      }
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2400
     * @tc.name   : CreateAudioCapturer
     * @tc.desc   : Test CreateAudioCapturer - Promise
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2400', 0, async (done: Function) => {
      try{
        audioCapturerOptions.streamInfo.channelLayout = channelLayout_err;
        await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
          audioCapturer = data;
        }).catch((err: BusinessError) => {
          expect(err.code == errCode_6800301).assertTrue();
          console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2400 fail');
        });
        if (platform == 'Android' || platform == 'iOS') {
          expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2400 error' + error);
      }
      done();
    })

    if (platform != 'iOS') {
      /**
       * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2500
       * @tc.name   : CreateAudioCapturer
       * @tc.desc   : Test CreateAudioCapturer - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2500', 0, async (done: Function) => {
        try{
          await resetAudioCapturerOptions();
          audioCapturerOptions.capturerInfo.source = audio.SourceType.SOURCE_TYPE_MIC;
          audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
          expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioCapturer.release();

          audioCapturerOptions.capturerInfo.source = audio.SourceType.SOURCE_TYPE_VOICE_RECOGNITION;
          audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
          expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioCapturer.release();

          audioCapturerOptions.capturerInfo.source = audio.SourceType.SOURCE_TYPE_VOICE_COMMUNICATION;
          audioCapturer = await createAudioCapturerCallback(audioCapturer, audioCapturerOptions);
          expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioCapturer.release();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2500 error' + error);
        }
        await sleep(waitReadyMs_400);
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2600
       * @tc.name   : CreateAudioCapturer
       * @tc.desc   : Test CreateAudioCapturer - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2600', 0, async (done: Function) => {
        try{
          await resetAudioCapturerOptions();
          audioCapturerOptions.capturerInfo.source = audio.SourceType.SOURCE_TYPE_MIC;
          audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
          expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioCapturer.release();

          audioCapturerOptions.capturerInfo.source = audio.SourceType.SOURCE_TYPE_VOICE_RECOGNITION;
          audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
          expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioCapturer.release();

          audioCapturerOptions.capturerInfo.source = audio.SourceType.SOURCE_TYPE_VOICE_COMMUNICATION;
          audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
          expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioCapturer.release();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2600 error' + error);
        }
        await sleep(waitReadyMs_400);
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2700
       * @tc.name   : CreateAudioCapturer
       * @tc.desc   : Test CreateAudioCapturer - Callback
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2700', 0, async (done: Function) => {
        try{
          await resetAudioCapturerOptions();
          audioCapturerOptions.capturerInfo.source = enum_5;
          audio.createAudioCapturer(audioCapturerOptions, (err, data) => {
            if (err) {
              if (err.code == errCode_6800101) {
                isPass = true;
              }
            } else {
              console.info('AudioCapturer Created: Success');
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2700 error' + error);
        }
        await sleep(waitReadyMs_400);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2800
       * @tc.name   : CreateAudioCapturer
       * @tc.desc   : Test CreateAudioCapturer - Promise
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2800', 0, async (done: Function) => {
        try{
          audioCapturerOptions.capturerInfo.source = enum_5;
          await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
            console.info('AudioCapturer Created: Success');
          }).catch((err: BusinessError) => {
            if (err.code == errCode_6800101) {
              isPass = true;
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_CreateAudioCapturer_Func_2800 error' + error);
        }
        await sleep(waitReadyMs_400);
        expect(isPass).assertTrue();
        done();
      })
    }
  })
}