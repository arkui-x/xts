import { BusinessError } from '@ohos.base';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import fs from '@ohos.file.fs';
import audio from '@ohos.multimedia.audio';
import deviceInfo from '@ohos.deviceInfo';
import resourceManager from '@ohos.resourceManager';
import { DisplayRotation, Driver, MatchPattern, ON, ResizeDirection, WindowMode } from '@ohos.UiTest'

const waitReadyMs_100 = 100;
const waitReadyMs_300 = 300;
const waitReadyMs_600 = 600;
const waitReadyMs_1000 = 1000;
const waitReadyMs_3000 = 3000;
let isPass = false;
let isSuccess = true;
let capturerOffsetStart = 0;
let audioRenderer: audio.AudioRenderer;
let audioCapturer: audio.AudioCapturer;
let audioManager: audio.AudioManager;
let audioStreamManager: audio.AudioStreamManager;
let fileDescriptor: resourceManager.RawFileDescriptor;
let osFullNameInfo: string = deviceInfo.osFullName;
console.info('the deviceInfo osFullName is :' + osFullNameInfo);
let platform = osFullNameInfo.split(' ')[0];
console.info('the device platform is :' + platform);

let audioRendererOptions: audio.AudioRendererOptions = {
  streamInfo: {
    samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_44100,
    channels: audio.AudioChannel.CHANNEL_1,
    sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE,
    encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW,
  },
  rendererInfo: {
    usage: audio.StreamUsage.STREAM_USAGE_VOICE_COMMUNICATION,
    rendererFlags: 0
  }
}

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
  },
}

class Options {
  offset?: number;
  length?: number;
}

async function createAudioRenderer() {
  await audio.createAudioRenderer(audioRendererOptions).then((data) => {
    audioRenderer = data;
  }).catch((err: BusinessError) => {
    isPass = false;
    isSuccess = false;
    console.error('AudioRenderer Created: ERROR:' + err);
  });
  await sleep(waitReadyMs_100);
  if (isSuccess == false) {
    isSuccess = true;
    expect().assertFail();
  }
  return audioRenderer;
}

async function createAudioCapturer() {
  await audio.createAudioCapturer(audioCapturerOptions).then((data) => {
    audioCapturer = data;
  }).catch((err: BusinessError) => {
    isPass = false;
    isSuccess = false;
    console.error('AudioCapturer Created: ERROR:' + err);
  });
  await sleep(waitReadyMs_100);
  if (isSuccess == false) {
    isSuccess = true;
    expect().assertFail();
  }
  return audioCapturer;
}

async function onWriteData(audioRenderer: audio.AudioRenderer, fileDescriptor: resourceManager.RawFileDescriptor) {
  if (!audioRenderer) {
    console.warn('Renderer:audioRenderer is null');
    return;
  }
  let bufferSize: number = 0;
  let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
  let writeDataCallback = (buffer: ArrayBuffer) => {
    let options: Options = {
      offset: bufferSize,
      length: buffer.byteLength
    }
    fs.readSync(fileFd, buffer, options)
    bufferSize += buffer.byteLength;
  }
  try{
    audioRenderer.on('writeData', writeDataCallback)
    await sleep(waitReadyMs_300);
  } catch (error) {
    expect().assertFail();
    console.error('Renderer:onWriteData fail:' + error);
  }
}

async function onReadData(audioCapturer: audio.AudioCapturer) {
  if (!audioCapturer) {
    console.warn('Capturer:audioCapturer is null');
    return;
  }
  let startOffset: number = capturerOffsetStart;
  let filesDir = getContext().filesDir + '/testCapturer.wav';
  let file = fs.openSync(filesDir, fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
  let readDataCallback = (buffer: ArrayBuffer) => {
    let options: Options = {
      offset: startOffset,
      length: buffer.byteLength
    }
    fs.writeSync(file.fd, buffer, options);
    startOffset += buffer.byteLength;
    capturerOffsetStart = startOffset;
  }
  try{
    audioCapturer.on('readData', readDataCallback);
    await sleep(waitReadyMs_300);
  } catch (error) {
    expect().assertFail();
    console.error('Capturer:onReadData fail:' + error);
  }
}

async function startRenderer(audioRenderer: audio.AudioRenderer) {
  if (!audioRenderer) {
    console.warn('Renderer:audioRenderer is null');
    return;
  }
  await audioRenderer.start().then(() => {
  }).catch((err: BusinessError) => {
    console.error('audioRenderer.start Invoked: Error: ' + err);
  });
}

async function stopPromise(audioRenderer: audio.AudioRenderer) {
  if (!audioRenderer) {
    console.warn('Renderer:audioRenderer is null');
    return;
  }
  await audioRenderer.stop().then(() => {

  }).catch((err: BusinessError) => {
    console.error('audioRenderer.stop Invoked: Error: ' + err);
  });
  await sleep(waitReadyMs_100);
}

async function startCapturer(audioCapturer: audio.AudioCapturer) {
  if (!audioCapturer) {
    console.warn('Capturer:audioCapturer is null');
    return;
  }
  await audioCapturer.start().then(() => {
  }).catch((err: BusinessError) => {
    isPass = false;
    console.error('audioCapturer.start Invoked: Error: ' + err);
  });
  await sleep(waitReadyMs_1000);
}

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function audioStreamManagerTest() {
  describe('audioStreamManagerTest', () => {
    beforeAll(async () => {
      let driver = Driver.create();
      await sleep(waitReadyMs_3000);
      let button = await driver.findComponent(ON.text('允许'));
      if (button != null) {
        await driver.delayMs(waitReadyMs_600);
        await button.click();
        await sleep(waitReadyMs_3000);
      }
      audioManager = audio.getAudioManager();
      audioStreamManager = audioManager.getStreamManager();
      await sleep(waitReadyMs_3000);
    })
    beforeEach(async () => {
      isPass = false;
      await sleep(waitReadyMs_300);
    })
    afterEach(async () => {
      if (audioRenderer.state == audio.AudioState.STATE_RUNNING) {
        await stopPromise(audioRenderer);
      }
    })

    /**
     * @tc.number : SUB_ArkUIX_Audio_getCurrentAudioCapturerInfoArray_Func_0100
     * @tc.name   : getCurrentAudioCapturerInfoArray
     * @tc.desc   : Test getCurrentAudioCapturerInfoArray - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getCurrentAudioCapturerInfoArray_Func_0100', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturer();
        await onReadData(audioCapturer);
        await startCapturer(audioCapturer);
        await sleep(waitReadyMs_1000);
        audioStreamManager.getCurrentAudioCapturerInfoArray(async (err, AudioCapturerChangeInfoArray) => {
          if (err) {
            console.error('SUB_ArkUIX_Audio_getCurrentAudioCapturerInfoArray_Func_0100 fail');
          } else {
            if (AudioCapturerChangeInfoArray.length > 0) {
              if (AudioCapturerChangeInfoArray[0].capturerInfo.source == audioCapturerOptions.capturerInfo.source &&
                AudioCapturerChangeInfoArray[0].capturerInfo.capturerFlags ==
                audioCapturerOptions.capturerInfo.capturerFlags) {
                isPass = true;
              }
            }
          }
        });
        await sleep(waitReadyMs_1000);
        await audioCapturer.release();
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getCurrentAudioCapturerInfoArray_Func_0100 error' + error);
      }
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getCurrentAudioCapturerInfoArray_Func_0200
     * @tc.name   : getCurrentAudioCapturerInfoArray
     * @tc.desc   : Test getCurrentAudioCapturerInfoArray - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getCurrentAudioCapturerInfoArray_Func_0200', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturer();
        await onReadData(audioCapturer);
        await startCapturer(audioCapturer);
        await sleep(waitReadyMs_1000);
        await audioStreamManager.getCurrentAudioCapturerInfoArray().then((AudioCapturerChangeInfoArray) => {
          if (AudioCapturerChangeInfoArray.length > 0) {
            if (AudioCapturerChangeInfoArray[0].capturerInfo.source == audioCapturerOptions.capturerInfo.source &&
              AudioCapturerChangeInfoArray[0].capturerInfo.capturerFlags ==
              audioCapturerOptions.capturerInfo.capturerFlags) {
              isPass = true;
            }
          }
        }).catch((err: BusinessError) => {
          console.error('SUB_ArkUIX_Audio_getCurrentAudioCapturerInfoArray_Func_0200 fail');
        });
        await sleep(waitReadyMs_300);
        await audioCapturer.release();
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getCurrentAudioCapturerInfoArray_Func_0200 error' + error);
      }
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getCurrentAudioCapturerInfoArraySync_Func_0300
     * @tc.name   : getCurrentAudioCapturerInfoArraySync
     * @tc.desc   : Test getCurrentAudioCapturerInfoArraySync - Sync
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getCurrentAudioCapturerInfoArraySync_Func_0300', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturer();
        await onReadData(audioCapturer);
        await startCapturer(audioCapturer);
        await sleep(waitReadyMs_1000);
        let audioCapturerChangeInfoArray = audioStreamManager.getCurrentAudioCapturerInfoArraySync();
        if (audioCapturerChangeInfoArray.length > 0) {
          if (audioCapturerChangeInfoArray[0].capturerInfo.source == audioCapturerOptions.capturerInfo.source &&
            audioCapturerChangeInfoArray[0].capturerInfo.capturerFlags ==
            audioCapturerOptions.capturerInfo.capturerFlags) {
            isPass = true;
          }
        }
        await sleep(waitReadyMs_300);
        await audioCapturer.release();
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getCurrentAudioCapturerInfoArraySync_Func_0300 error' + error);
      }
      expect(isPass).assertTrue();
      done();
    })

    if (platform != 'Android') {
      /**
       * @tc.number : SUB_ArkUIX_Audio_onAudioRendererChange_Func_0100
       * @tc.name   : on('audioRendererChange')
       * @tc.desc   : Test on('audioRendererChange') - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_onAudioRendererChange_Func_0100', 0, async (done: Function) => {
        try {
          audioStreamManager.on('audioRendererChange', (AudioRendererChangeInfoArray) => {
            if (AudioRendererChangeInfoArray.length > 0) {
              if (AudioRendererChangeInfoArray[0].rendererInfo.usage == audioRendererOptions.rendererInfo.usage &&
                AudioRendererChangeInfoArray[0].rendererInfo.rendererFlags ==
                audioRendererOptions.rendererInfo.rendererFlags) {
                isPass = true;
              }
            }
          });
          await createAudioRenderer();
          fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
          await onWriteData(audioRenderer, fileDescriptor);
          await startRenderer(audioRenderer);
          await sleep(waitReadyMs_1000);
          await audioRenderer.release();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_onAudioRendererChange_Func_0100 error' + error);
        }
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_offAudioRendererChange_Func_0100
       * @tc.name   : off('audioRendererChange')
       * @tc.desc   : Test off('audioRendererChange') - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_offAudioRendererChange_Func_0100', 0, async (done: Function) => {
        isPass = true;
        try {
          audioStreamManager.on('audioRendererChange', (AudioRendererChangeInfoArray) => {
            isPass = false;
          });
          audioStreamManager.off('audioRendererChange');
          await startRenderer(audioRenderer);
          await sleep(waitReadyMs_600);
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_offAudioRendererChange_Func_0100 error' + error);
        }
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_onAudioCapturerChange_Func_0100
       * @tc.name   : on('audioCapturerChange')
       * @tc.desc   : Test on('audioCapturerChange') - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_onAudioCapturerChange_Func_0100', 0, async (done: Function) => {
        try{
          audioStreamManager.on('audioCapturerChange', (AudioCapturerChangeInfoArray) => {
            if(AudioCapturerChangeInfoArray.length != 0) {
              isPass = true;
            }
          });
          audioCapturer = await createAudioCapturer();
          await onReadData(audioCapturer);
          await startCapturer(audioCapturer);
          await sleep(waitReadyMs_1000);
          await audioCapturer.release();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_onAudioCapturerChange_Func_0100 error' + error);
        }
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_offAudioCapturerChange_Func_0100
       * @tc.name   : off('audioCapturerChange')
       * @tc.desc   : Test off('audioCapturerChange') - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_offAudioCapturerChange_Func_0100', 0, async (done: Function) => {
        isPass = true;
        try{
          audioStreamManager.on('audioCapturerChange', (AudioCapturerChangeInfoArray) => {
            isPass = false;
          });
          audioStreamManager.off('audioCapturerChange');
          audioCapturer = await createAudioCapturer();
          await onReadData(audioCapturer);
          await startCapturer(audioCapturer);
          await sleep(waitReadyMs_1000);
          await audioCapturer.release();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_offAudioCapturerChange_Func_0100 error' + error);
        }
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getCurrentAudioRendererInfoArray_Func_0100
       * @tc.name   : getCurrentAudioRendererInfoArray
       * @tc.desc   : Test getCurrentAudioRendererInfoArray - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getCurrentAudioRendererInfoArray_Func_0100', 0, async (done: Function) => {
        try {
		     audioRenderer = await createAudioRenderer();
		      fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
          await onWriteData(audioRenderer, fileDescriptor);
          await startRenderer(audioRenderer);
          await sleep(waitReadyMs_600);
          audioStreamManager.getCurrentAudioRendererInfoArray((err, AudioRendererChangeInfoArray) => {
            if (err) {
              console.error('SUB_ArkUIX_Audio_getCurrentAudioRendererInfoArray_Func_0100 fail');
            } else {
              if (AudioRendererChangeInfoArray.length > 0) {
                if (AudioRendererChangeInfoArray[0].rendererInfo.usage == audioRendererOptions.rendererInfo.usage &&
                  AudioRendererChangeInfoArray[0].rendererInfo.rendererFlags ==
                  audioRendererOptions.rendererInfo.rendererFlags) {
                  isPass = true;
                }
              }
            }
          });
          await sleep(waitReadyMs_600);
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getCurrentAudioRendererInfoArray_Func_0100 error' + error);
        }
        expect(isPass).assertTrue();
		    await audioRenderer.release();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getCurrentAudioRendererInfoArray_Func_0200
       * @tc.name   : getCurrentAudioRendererInfoArray
       * @tc.desc   : Test getCurrentAudioRendererInfoArray - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getCurrentAudioRendererInfoArray_Func_0200', 0, async (done: Function) => {
        try {
		      audioRenderer = await createAudioRenderer();
		      fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
          await onWriteData(audioRenderer, fileDescriptor);
          await startRenderer(audioRenderer);
          await sleep(waitReadyMs_600);
          await audioStreamManager.getCurrentAudioRendererInfoArray().then((AudioRendererChangeInfoArray) => {
            if (AudioRendererChangeInfoArray.length > 0) {
              if (AudioRendererChangeInfoArray[0].rendererInfo.usage == audioRendererOptions.rendererInfo.usage &&
                AudioRendererChangeInfoArray[0].rendererInfo.rendererFlags ==
                audioRendererOptions.rendererInfo.rendererFlags) {
                isPass = true;
              }
            }
          }).catch((err: BusinessError) => {
            console.error('SUB_ArkUIX_Audio_getCurrentAudioRendererInfoArray_Func_0200 fail');
          });
          await sleep(waitReadyMs_300);
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getCurrentAudioRendererInfoArray_Func_0200 error' + error);
        }
        expect(isPass).assertTrue();
		    await audioRenderer.release();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getCurrentAudioRendererInfoArraySync_Func_0300
       * @tc.name   : getCurrentAudioRendererInfoArraySync
       * @tc.desc   : Test getCurrentAudioRendererInfoArraySync - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getCurrentAudioRendererInfoArraySync_Func_0300', 0, async (done: Function) => {
        try {
		      audioRenderer = await createAudioRenderer();
		      fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
          await onWriteData(audioRenderer, fileDescriptor);
          await startRenderer(audioRenderer);
          await sleep(waitReadyMs_600);
          let audioRendererChangeInfoArray = audioStreamManager.getCurrentAudioRendererInfoArraySync();
          if (audioRendererChangeInfoArray.length > 0) {
            if (audioRendererChangeInfoArray[0].rendererInfo.usage == audioRendererOptions.rendererInfo.usage &&
              audioRendererChangeInfoArray[0].rendererInfo.rendererFlags ==
              audioRendererOptions.rendererInfo.rendererFlags) {
              isPass = true;
            }
          }
          await sleep(waitReadyMs_300);
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getCurrentAudioRendererInfoArraySync_Func_0300 error' + error);
        }
        expect(isPass).assertTrue();
        await audioRenderer.release();
        done();
      })
    }
  })
}