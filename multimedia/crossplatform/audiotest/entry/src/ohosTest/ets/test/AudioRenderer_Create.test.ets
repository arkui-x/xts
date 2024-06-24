import { BusinessError } from '@ohos.base';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import audio from '@ohos.multimedia.audio';
import deviceInfo from '@ohos.deviceInfo';

const enum_2 = 2;
const enum_5 = 5;
const enum_20 = 20;
const enum_100000 = 100000;
const errCode_6800301 = 6800301;
const channelLayout_err = 0x1000000033333;
const waitReadyMs_100 = 100;
const waitReadyMs_400 = 400;
const waitReadyMs_800 = 800;
let isPass = false;
let isErr = false;
let audioRenderer: audio.AudioRenderer;
let channelLayoutArray1: Array<audio.AudioChannelLayout>;
let channelLayoutArray2: Array<audio.AudioChannelLayout>;
let channelLayoutArray3: Array<audio.AudioChannelLayout>;
let osFullNameInfo: string = deviceInfo.osFullName;
console.info('the deviceInfo osFullName is :' + osFullNameInfo);
let platform = osFullNameInfo.split(' ')[0];
console.info('the device platform is :' + platform);

let audioRendererOptions: audio.AudioRendererOptions = {
  streamInfo: {
    samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_48000,
    channels: audio.AudioChannel.CHANNEL_2,
    sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE,
    encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW,
  },
  rendererInfo: {
    usage: audio.StreamUsage.STREAM_USAGE_MUSIC,
    rendererFlags: 0
  }
}

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function resetAudioRendererOptions() {
  audioRendererOptions = {
    streamInfo: {
      samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_48000,
      channels: audio.AudioChannel.CHANNEL_2,
      sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE,
      encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW,
    },
    rendererInfo: {
      usage: audio.StreamUsage.STREAM_USAGE_MUSIC,
      rendererFlags: 0
    }
  }
  await sleep(waitReadyMs_100);
}

export default function audioRenderer_CreateTest() {
  describe('audioRenderer_CreateTest', () => {
    beforeEach(async () => {
      isPass = false;
      await sleep(waitReadyMs_100);
    })

    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0100
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0100', 0, async (done: Function) => {
      isPass = true;
      try{
        await sleep(waitReadyMs_400);
        audioRendererOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_8000;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          err ? isPass = false : audioRenderer = data;
        });
        await sleep(waitReadyMs_400);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_11025;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          err ? isPass = false : audioRenderer = data;
        });
        await sleep(waitReadyMs_400);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_12000;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          err ? isPass = false : audioRenderer = data;
        });
        await sleep(waitReadyMs_400);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_16000;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          err ? isPass = false : audioRenderer = data;
        });
        await sleep(waitReadyMs_400);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_22050;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          err ? isPass = false : audioRenderer = data;
        });
        await sleep(waitReadyMs_400);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_24000;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          err ? isPass = false : audioRenderer = data;
        });
        await sleep(waitReadyMs_400);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_32000;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          err ? isPass = false : audioRenderer = data;
        });
        await sleep(waitReadyMs_400);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_44100;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          err ? isPass = false : audioRenderer = data;
        });
        await sleep(waitReadyMs_400);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_48000;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          err ? isPass = false : audioRenderer = data;
        });
        await sleep(waitReadyMs_400);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_64000;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          err ? isPass = false : audioRenderer = data;
        });
        await sleep(waitReadyMs_400);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_96000;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          err ? isPass = false : audioRenderer = data;
        });
        await sleep(waitReadyMs_400);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0200
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0200', 0, async (done: Function) => {
      isPass = true;
      try{
        await sleep(waitReadyMs_400);
        audioRendererOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_8000;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          audioRenderer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_11025;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          audioRenderer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_12000;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          audioRenderer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_16000;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          audioRenderer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_22050;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          audioRenderer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_24000;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          audioRenderer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_32000;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          audioRenderer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_44100;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          audioRenderer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_48000;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          audioRenderer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_64000;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          audioRenderer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.samplingRate = audio.AudioSamplingRate.SAMPLE_RATE_96000;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          audioRenderer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0200 error' + error);
      }
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0300
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Callback
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0300', 0, async (done: Function) => {
      try{
        audioRendererOptions.streamInfo.samplingRate = enum_100000;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          if (err) {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0300 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0300 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0400
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Promise
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0400', 0, async (done: Function) => {
      try{
        audioRendererOptions.streamInfo.samplingRate = enum_100000;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0400 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0400 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0500
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0500', 0, async (done: Function) => {
      isPass = true;
      try{
        await resetAudioRendererOptions();
        audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_1;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          err ? isPass = false : audioRenderer = data;
        });
        await sleep(waitReadyMs_400);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_2;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          err ? isPass = false : audioRenderer = data;
        });
        await sleep(waitReadyMs_400);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_3;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          err ? isPass = false : audioRenderer = data;
        });
        await sleep(waitReadyMs_400);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_4;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          err ? isPass = false : audioRenderer = data;
        });
        await sleep(waitReadyMs_400);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_5;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          err ? isPass = false : audioRenderer = data;
        });
        await sleep(waitReadyMs_400);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_6;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          err ? isPass = false : audioRenderer = data;
        });
        await sleep(waitReadyMs_400);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_7;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          err ? isPass = false : audioRenderer = data;
        });
        await sleep(waitReadyMs_400);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_8;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          err ? isPass = false : audioRenderer = data;
        });
        await sleep(waitReadyMs_400);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        if (platform != 'Android') {
          audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_10;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            err ? isPass = false : audioRenderer = data;
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_12;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            err ? isPass = false : audioRenderer = data;
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_14;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            err ? isPass = false : audioRenderer = data;
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_16;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            err ? isPass = false : audioRenderer = data;
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_9;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            err ? isPass = false : audioRenderer = data;
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();
        } else {
          audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_10;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            if (err) {
              expect(true).assertTrue();
            } else {
              expect(data.state).assertEqual(audio.AudioState.STATE_PREPARED);
            }
          });

          audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_12;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            if (err) {
              expect(true).assertTrue();
            } else {
              expect(data.state).assertEqual(audio.AudioState.STATE_PREPARED);
            }
          });

          audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_14;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            if (err) {
              expect(true).assertTrue();
            } else {
              expect(data.state).assertEqual(audio.AudioState.STATE_PREPARED);
            }
          });

          audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_16;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            if (err) {
              expect(true).assertTrue();
            } else {
              expect(data.state).assertEqual(audio.AudioState.STATE_PREPARED);
            }
          });
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0500 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0600
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0600', 0, async (done: Function) => {
      isPass = true;
      try{
        await resetAudioRendererOptions();
        audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_1;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          audioRenderer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_2;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          audioRenderer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_3;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          audioRenderer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_4;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          audioRenderer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_5;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          audioRenderer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_6;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          audioRenderer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_7;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          audioRenderer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_8;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          audioRenderer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        if (platform != 'Android') {
          audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_10;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_12;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_14;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_16;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_9;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();
        } else {
          audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_10;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            expect(data.state).assertEqual(audio.AudioState.STATE_PREPARED);
          }).catch((err: BusinessError) => {
            expect(true).assertTrue();
          });

          audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_12;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            expect(data.state).assertEqual(audio.AudioState.STATE_PREPARED);
          }).catch((err: BusinessError) => {
            expect(true).assertTrue();
          });

          audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_14;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            expect(data.state).assertEqual(audio.AudioState.STATE_PREPARED);
          }).catch((err: BusinessError) => {
            expect(true).assertTrue();
          });

          audioRendererOptions.streamInfo.channels = audio.AudioChannel.CHANNEL_16;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            expect(data.state).assertEqual(audio.AudioState.STATE_PREPARED);
          }).catch((err: BusinessError) => {
            expect(true).assertTrue();
          });
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0600 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0700
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Callback
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0700', 0, async (done: Function) => {
      try{
        audioRendererOptions.streamInfo.channels = enum_20;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          if (err) {
            console.error('AudioRenderer Created: Error: ' + err);
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0700 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0700 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0800
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Promise
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0800', 0, async (done: Function) => {
      try{
        audioRendererOptions.streamInfo.channels = enum_20;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0800 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0800 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0900
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0900', 0, async (done: Function) => {
      isPass = true;
      try{
        await resetAudioRendererOptions();
        audioRendererOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_U8;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          err ? isPass = false : audioRenderer = data;
        });
        await sleep(waitReadyMs_800);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          err ? isPass = false : audioRenderer = data;
        });
        await sleep(waitReadyMs_800);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        if (platform == 'iOS') {
          audioRendererOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_S24LE;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            err ? isPass = false : audioRenderer = data;
          });
          await sleep(waitReadyMs_800);
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_S32LE;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            err ? isPass = false : audioRenderer = data;
          });
          await sleep(waitReadyMs_800);
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();
        } else {
          audioRendererOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_S24LE;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            if (err) {
              isErr = true;
            } else {
              isErr = false;
              audioRenderer = data;
            }
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state == audio.AudioState.STATE_PREPARED || isErr).assertTrue();

          audioRendererOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_S32LE;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            if (err) {
              isErr = true;
            } else {
              isErr = false;
              audioRenderer = data;
            }
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state == audio.AudioState.STATE_PREPARED || isErr).assertTrue();
        }

        audioRendererOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_INVALID;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          if (err) {
            if (err.code != errCode_6800301) {
              isPass = false;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0900 fail');
          }
        });
        await sleep(waitReadyMs_400);

        audioRendererOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_F32LE;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          if (err) {
            if (err.code != errCode_6800301) {
              isPass = false;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0900 fail');
          }
        });
        await sleep(waitReadyMs_400);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_0900 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1000
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1000', 0, async (done: Function) => {
      isPass = true;
      try{
        await resetAudioRendererOptions();
        audioRendererOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_U8;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          audioRenderer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        await sleep(waitReadyMs_100);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          audioRenderer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        await sleep(waitReadyMs_100);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        if (platform == 'iOS') {
          audioRendererOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_S24LE;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_S32LE;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();
        } else {
          audioRendererOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_S24LE;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            isErr = false;
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isErr = true;
          });
          await sleep(waitReadyMs_100);
          expect(audioRenderer.state == audio.AudioState.STATE_PREPARED || isErr).assertTrue();

          audioRendererOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_S32LE;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            isErr = false;
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isErr = true;
          });
          await sleep(waitReadyMs_100);
          expect(audioRenderer.state == audio.AudioState.STATE_PREPARED || isErr).assertTrue();
        }

        audioRendererOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_INVALID;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1000 fail');
        }).catch((err: BusinessError) => {
          if (err.code != errCode_6800301) {
            isPass = false;
          }
        });
        await sleep(waitReadyMs_100);

        audioRendererOptions.streamInfo.sampleFormat = audio.AudioSampleFormat.SAMPLE_FORMAT_F32LE;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1000 fail');
        }).catch((err: BusinessError) => {
          if (err.code != errCode_6800301) {
            isPass = false;
          }
        });
        await sleep(waitReadyMs_100);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1000 error' + error);
      }
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1100
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Callback
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1100', 0, async (done: Function) => {
      try{
        audioRendererOptions.streamInfo.sampleFormat = enum_5;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          if (err) {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1100 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1100 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1200
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Promise
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1200', 0, async (done: Function) => {
      try{
        audioRendererOptions.streamInfo.sampleFormat = enum_5;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1200 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1200 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1300
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1300', 0, async (done: Function) => {
      isPass = true;
      try{
        await resetAudioRendererOptions();
        audioRendererOptions.streamInfo.encodingType = audio.AudioEncodingType.ENCODING_TYPE_RAW;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          err ? isPass = false : audioRenderer = data;
        });
        await sleep(waitReadyMs_400);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.encodingType = audio.AudioEncodingType.ENCODING_TYPE_INVALID;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          if (err) {
            if (err.code != errCode_6800301) {
              isPass = false;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1300 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1300 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1400
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1400', 0, async (done: Function) => {
      try{
        await resetAudioRendererOptions();
        audioRendererOptions.streamInfo.encodingType = audio.AudioEncodingType.ENCODING_TYPE_RAW;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          audioRenderer = data;
        }).catch((err: BusinessError) => {
          isPass = false;
        });
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
        await audioRenderer.release();

        audioRendererOptions.streamInfo.encodingType = audio.AudioEncodingType.ENCODING_TYPE_INVALID;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1400 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1400 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1500
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Callback
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1500', 0, async (done: Function) => {
      try{
        audioRendererOptions.streamInfo.encodingType = enum_2;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          if (err) {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1500 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1500 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1600
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Promise
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1600', 0, async (done: Function) => {
      try{
        audioRendererOptions.streamInfo.encodingType = enum_2;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1600 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1600 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1700
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1700', 0, async (done: Function) => {
      isPass = true;
      await resetAudioRendererOptions();
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

      try {
        if (platform.startsWith('OpenHarmony')) {
          audioRendererOptions.streamInfo.channelLayout = audio.AudioChannelLayout.CH_LAYOUT_UNKNOWN;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            if (err) {
              isPass = false;
            } else {
              audioRenderer = data;
            }
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state == audio.AudioState.STATE_PREPARED).assertTrue();
          await audioRenderer.release();

          audioRendererOptions.streamInfo.channelLayout = audio.AudioChannelLayout.CH_LAYOUT_STEREO;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            if (err) {
              isPass = false;
            } else {
              audioRenderer = data;
            }
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state == audio.AudioState.STATE_PREPARED).assertTrue();
          await audioRenderer.release();
        }
        for (let i = 0; i < channelLayoutArray1.length; i++) {
          if (platform.startsWith('OpenHarmony')) {
            if (channelLayoutArray1[i] != audio.AudioChannelLayout.CH_LAYOUT_UNKNOWN &&
              channelLayoutArray1[i] != audio.AudioChannelLayout.CH_LAYOUT_STEREO) {
                audioRendererOptions.streamInfo.channelLayout = channelLayoutArray1[i];
                audio.createAudioRenderer(audioRendererOptions, (err, data) => {
                  if (err) {
                    if (err.code != errCode_6800301) {
                      isPass = false;
                    }
                  }
                });
                await sleep(waitReadyMs_400);
            }
          } else {
            audioRendererOptions.streamInfo.channelLayout = channelLayoutArray1[i];
            audio.createAudioRenderer(audioRendererOptions, (err, data) => {
              if (err) {
                isPass = false
              } else {
                audioRenderer = data;
              }
            });
            await sleep(waitReadyMs_400);
            expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
            await audioRenderer.release();
          }
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1700 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1800
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1800', 0, async (done: Function) => {
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
        await resetAudioRendererOptions();
        for (let i = 0; i < channelLayoutArray2.length; i++) {
          if (platform.startsWith('OpenHarmony')) {
            audioRendererOptions.streamInfo.channelLayout = channelLayoutArray2[i];
            audio.createAudioRenderer(audioRendererOptions, (err, data) => {
              if (err) {
                if (err.code != errCode_6800301) {
                  isPass = false;
                }
              }
            });
            await sleep(waitReadyMs_400);
          } else {
            audioRendererOptions.streamInfo.channelLayout = channelLayoutArray2[i];
            audio.createAudioRenderer(audioRendererOptions, (err, data) => {
              if (err) {
                isPass = false
              } else {
                audioRenderer = data;
              }
            });
            await sleep(waitReadyMs_400);
            expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
            await audioRenderer.release();
          }
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1800 error' + error);
      }
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1900
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1900', 0, async (done: Function) => {
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
        await resetAudioRendererOptions();
        for (let i = 0; i < channelLayoutArray3.length; i++) {
          if (platform.startsWith('OpenHarmony')) {
            audioRendererOptions.streamInfo.channelLayout = channelLayoutArray3[i];
            audio.createAudioRenderer(audioRendererOptions, (err, data) => {
              if (err) {
                if (err.code != errCode_6800301) {
                  isPass = false;
                }
              }
            });
            await sleep(waitReadyMs_400);
          } else {
            audioRendererOptions.streamInfo.channelLayout = channelLayoutArray3[i];
            audio.createAudioRenderer(audioRendererOptions, (err, data) => {
              if (err) {
                isPass = false
              } else {
                audioRenderer = data;
              }
            });
            await sleep(waitReadyMs_400);
            expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
            await audioRenderer.release();
          }
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_1900 error' + error);
      }
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2000
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2000', 0, async (done: Function) => {
      isPass = true;
      await resetAudioRendererOptions();
      try {
        if (platform.startsWith('OpenHarmony')) {
          audioRendererOptions.streamInfo.channelLayout = audio.AudioChannelLayout.CH_LAYOUT_UNKNOWN;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state == audio.AudioState.STATE_PREPARED).assertTrue();
          await audioRenderer.release();

          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state == audio.AudioState.STATE_PREPARED).assertTrue();
          await audioRenderer.release();

          audioRendererOptions.streamInfo.channelLayout = audio.AudioChannelLayout.CH_LAYOUT_STEREO;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state == audio.AudioState.STATE_PREPARED).assertTrue();
          await audioRenderer.release();
        }
        for (let i = 0; i < channelLayoutArray1.length; i++) {
          if (platform.startsWith('OpenHarmony')) {
            if (channelLayoutArray1[i] != audio.AudioChannelLayout.CH_LAYOUT_UNKNOWN &&
              channelLayoutArray1[i] != audio.AudioChannelLayout.CH_LAYOUT_STEREO) {
              audioRendererOptions.streamInfo.channelLayout = channelLayoutArray1[i];
              await audio.createAudioRenderer(audioRendererOptions).then((data) => {
                audioRenderer = data;
              }).catch((err: BusinessError) => {
                if (err.code != errCode_6800301) {
                  isPass = false;
                }
              });
              await sleep(waitReadyMs_400);
            }
          } else {
            audioRendererOptions.streamInfo.channelLayout = channelLayoutArray1[i];
            await audio.createAudioRenderer(audioRendererOptions).then((data) => {
              audioRenderer = data;
            }).catch((err: BusinessError) => {
              isPass = false;
            });
            await sleep(waitReadyMs_100);
            expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
            await audioRenderer.release();
          }
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2000 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2100
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2100', 0, async (done: Function) => {
      isPass = true;
      try{
        await resetAudioRendererOptions();
        for (let i = 0; i < channelLayoutArray2.length; i++) {
          if (platform.startsWith('OpenHarmony')) {
            audioRendererOptions.streamInfo.channelLayout = channelLayoutArray2[i];
            await audio.createAudioRenderer(audioRendererOptions).then((data) => {
              audioRenderer = data;
            }).catch((err: BusinessError) => {
              if (err.code != errCode_6800301) {
                isPass = false;
              }
            });
            await sleep(waitReadyMs_400);
          } else {
            audioRendererOptions.streamInfo.channelLayout = channelLayoutArray2[i];
            await audio.createAudioRenderer(audioRendererOptions).then((data) => {
              audioRenderer = data;
            }).catch((err: BusinessError) => {
              isPass = false;
            });
            await sleep(waitReadyMs_100);
            expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
            await audioRenderer.release();
          }
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2100 error' + error);
      }
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2200
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2200', 0, async (done: Function) => {
      isPass = true;
      try{
        await resetAudioRendererOptions();
        for (let i = 0; i < channelLayoutArray3.length; i++) {
          if (platform.startsWith('OpenHarmony')) {
            audioRendererOptions.streamInfo.channelLayout = channelLayoutArray3[i];
            await audio.createAudioRenderer(audioRendererOptions).then((data) => {
              audioRenderer = data;
            }).catch((err: BusinessError) => {
              if (err.code != errCode_6800301) {
                isPass = false;
              }
            });
            await sleep(waitReadyMs_400);
          } else {
            audioRendererOptions.streamInfo.channelLayout = channelLayoutArray3[i];
            await audio.createAudioRenderer(audioRendererOptions).then((data) => {
              audioRenderer = data;
            }).catch((err: BusinessError) => {
              isPass = false;
            });
            await sleep(waitReadyMs_100);
            expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
            await audioRenderer.release();
          }
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2200 error' + error);
      }
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2300
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Callback
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2300', 0, async (done: Function) => {
      try{
        await sleep(waitReadyMs_400);
        audioRendererOptions.streamInfo.channelLayout = channelLayout_err;
        audio.createAudioRenderer(audioRendererOptions, (err, data) => {
          if (err) {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2300 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2300 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2400
     * @tc.name   : CreateAudioRenderer
     * @tc.desc   : Test CreateAudioRenderer - Promise
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2400', 0, async (done: Function) => {
      try{
        audioRendererOptions.streamInfo.channelLayout = channelLayout_err;
        await audio.createAudioRenderer(audioRendererOptions).then((data) => {
          console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2400 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2400 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })

    if (platform != 'iOS') {
      /**
       * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2500
       * @tc.name   : CreateAudioRenderer
       * @tc.desc   : Test CreateAudioRenderer - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2500', 0, async (done: Function) => {
        isPass = true;
        try{
          await resetAudioRendererOptions();
          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_UNKNOWN;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            err ? isPass = false : audioRenderer = data;
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_MUSIC;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            err ? isPass = false : audioRenderer = data;
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_VOICE_COMMUNICATION;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            err ? isPass = false : audioRenderer = data;
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_VOICE_ASSISTANT;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            err ? isPass = false : audioRenderer = data;
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_ALARM;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            err ? isPass = false : audioRenderer = data;
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_RINGTONE;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            err ? isPass = false : audioRenderer = data;
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_NOTIFICATION;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            err ? isPass = false : audioRenderer = data;
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_ACCESSIBILITY;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            err ? isPass = false : audioRenderer = data;
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_MOVIE;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            err ? isPass = false : audioRenderer = data;
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_GAME;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            err ? isPass = false : audioRenderer = data;
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_AUDIOBOOK;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            err ? isPass = false : audioRenderer = data;
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_NAVIGATION;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            err ? isPass = false : audioRenderer = data;
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2500 error' + error);
        }
        await sleep(waitReadyMs_400);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2600
       * @tc.name   : CreateAudioRenderer
       * @tc.desc   : Test CreateAudioRenderer - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2600', 0, async (done: Function) => {
        isPass = true;
        try{
          await sleep(waitReadyMs_400);
          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_UNKNOWN;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_MUSIC;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_VOICE_COMMUNICATION;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_VOICE_ASSISTANT;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_ALARM;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_RINGTONE;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_NOTIFICATION;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_ACCESSIBILITY;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_MOVIE;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_GAME;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_AUDIOBOOK;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.rendererInfo.usage = audio.StreamUsage.STREAM_USAGE_NAVIGATION;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2600 error' + error);
        }
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2700
       * @tc.name   : CreateAudioRenderer
       * @tc.desc   : Test CreateAudioRenderer - Callback
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2700', 0, async (done: Function) => {
        try{
          await sleep(waitReadyMs_400);
          audioRendererOptions.rendererInfo.usage = enum_20;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            if (err) {
              if (err.code == errCode_6800301) {
                isPass = true;
              }
            } else {
              console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2700 fail');
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2700 error' + error);
        }
        await sleep(waitReadyMs_400);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2800
       * @tc.name   : CreateAudioRenderer
       * @tc.desc   : Test CreateAudioRenderer - Promise
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2800', 0, async (done: Function) => {
        try{
          audioRendererOptions.rendererInfo.usage = enum_20;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2800 fail');
          }).catch((err: BusinessError) => {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2800 error' + error);
        }
        await sleep(waitReadyMs_400);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2900
       * @tc.name   : CreateAudioRenderer
       * @tc.desc   : Test CreateAudioRenderer - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2900', 0, async (done: Function) => {
        isPass = true;
        try{
          await resetAudioRendererOptions();
          audioRendererOptions = {
            streamInfo: {
              samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_44100,
              channels: audio.AudioChannel.CHANNEL_1,
              sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE,
              encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW,
            },
            rendererInfo: {
              usage: audio.StreamUsage.STREAM_USAGE_MUSIC,
              rendererFlags: 0
            },
            privacyType: audio.AudioPrivacyType.PRIVACY_TYPE_PUBLIC
          }
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            err ? isPass = false : audioRenderer = data;
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.privacyType = audio.AudioPrivacyType.PRIVACY_TYPE_PRIVATE;
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            err ? isPass = false : audioRenderer = data;
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_2900 error' + error);
        }
        await sleep(waitReadyMs_400);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_3000
       * @tc.name   : CreateAudioRenderer
       * @tc.desc   : Test CreateAudioRenderer - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_3000', 0, async (done: Function) => {
        isPass = true;
        try{
          audioRendererOptions = {
            streamInfo: {
              samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_44100,
              channels: audio.AudioChannel.CHANNEL_1,
              sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE,
              encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW,
            },
            rendererInfo: {
              usage: audio.StreamUsage.STREAM_USAGE_MUSIC,
              rendererFlags: 0
            },
            privacyType: audio.AudioPrivacyType.PRIVACY_TYPE_PUBLIC
          }
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();

          audioRendererOptions.privacyType = audio.AudioPrivacyType.PRIVACY_TYPE_PRIVATE;
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_3000 error' + error);
        }
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_3100
       * @tc.name   : CreateAudioRenderer
       * @tc.desc   : Test CreateAudioRenderer - Callback
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_3100', 0, async (done: Function) => {
        isPass = true;
        try{
          audioRendererOptions = {
            streamInfo: {
              samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_44100,
              channels: audio.AudioChannel.CHANNEL_1,
              sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE,
              encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW,
            },
            rendererInfo: {
              usage: audio.StreamUsage.STREAM_USAGE_MUSIC,
              rendererFlags: 0
            },
            privacyType: enum_2
          }
          audio.createAudioRenderer(audioRendererOptions, (err, data) => {
            err ? isPass = false : audioRenderer = data;
          });
          await sleep(waitReadyMs_400);
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_3100 error' + error);
        }
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_CreateAudioRenderer_Func_3200
       * @tc.name   : CreateAudioRenderer
       * @tc.desc   : Test CreateAudioRenderer - Promise
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_3200', 0, async (done: Function) => {
        isPass = true;
        try{
          audioRendererOptions = {
            streamInfo: {
              samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_44100,
              channels: audio.AudioChannel.CHANNEL_1,
              sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE,
              encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW,
            },
            rendererInfo: {
              usage: audio.StreamUsage.STREAM_USAGE_MUSIC,
              rendererFlags: 0
            },
            privacyType: enum_2
          }
          await audio.createAudioRenderer(audioRendererOptions).then((data) => {
            audioRenderer = data;
          }).catch((err: BusinessError) => {
            isPass = false;
          });
          expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PREPARED);
          await audioRenderer.release();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_CreateAudioRenderer_Func_3200 error' + error);
        }
        expect(isPass).assertTrue();
        done();
      })
    }
  })
}