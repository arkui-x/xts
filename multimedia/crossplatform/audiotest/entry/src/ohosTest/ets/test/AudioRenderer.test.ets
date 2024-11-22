import { BusinessError } from '@ohos.base';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import fs from '@ohos.file.fs';
import audio from '@ohos.multimedia.audio';
import deviceInfo from '@ohos.deviceInfo';
import resourceManager from '@ohos.resourceManager';

const speed_fast = 1.5;
const speed_5 = 5;
const speed_err = -1;
const volume_normal = 0.5;
const volume_2 = 2;
const volume_err = -1;
const position_1000 = 1000;
const position_err = -1000;
const enum_4 = 4;
const errCode_6800103 = 6800103;
const errCode_6800104 = 6800104;
const errCode_6800301 = 6800301;
const androidVersion_10 = 10;
const waitReadyMs_100 = 100;
const waitReadyMs_300 = 300;
const waitReadyMs_400 = 200;
const waitReadyMs_600 = 600;
const waitReadyMs_1000 = 1000;
let isPass = false;
let isCreated = true;
let audioRenderer: audio.AudioRenderer;
let androidVersion: number;
let osFullNameInfo: string = deviceInfo.osFullName;
console.info('the deviceInfo osFullName is :' + osFullNameInfo);
let platform = osFullNameInfo.split(' ')[0];
console.info('the device platform is :' + platform);
if (platform == 'Android') {
  androidVersion = Number(osFullNameInfo.split(' ')[1]);
}

let audioRendererOptions: audio.AudioRendererOptions = {
  streamInfo: {
    samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_44100,
    channels: audio.AudioChannel.CHANNEL_1,
    sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE,
    encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW,
  },
  rendererInfo: {
    usage: audio.StreamUsage.STREAM_USAGE_MUSIC,
    rendererFlags: 0
  }
}

class Options {
  offset?: number;
  length?: number;
}

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function isAndroidVersionGreater(num: number) {
  if (platform != 'Android') {
    return true;
  } else {
    if (androidVersion >= num) {
      return true;
    } else {
      return false;
    }
  }
}

async function createAudioRendererPromise(audioRenderer: audio.AudioRenderer,
                                   audioRendererOptions: audio.AudioRendererOptions) {
  await audio.createAudioRenderer(audioRendererOptions).then((data) => {
    if (data != null) {
      audioRenderer = data;
    } else {
      isPass = false;
      isCreated = false;
      console.error('AudioRenderer Created: Fail');
    }
  }).catch((err: BusinessError) => {
    isPass = false;
    isCreated = false;
    console.error('AudioRenderer Created: ERROR:' + err);
  });
  await sleep(waitReadyMs_100);
  if (isCreated == false) {
    isCreated = true;
    expect().assertFail();
  }
  return audioRenderer;
}

async function startCallback(audioRenderer: audio.AudioRenderer) {
  if (!audioRenderer) {
    console.warn('Renderer:audioRenderer is null');
    return;
  }
  audioRenderer.start((err: BusinessError) => {
    if (err) {
      isPass = false;
      console.error('audioRenderer.start Invoked: Error: ' + err);
    } else {
      if(audioRenderer.state != audio.AudioState.STATE_RUNNING) {
        isPass = false;
      }
    }
  });
  await sleep(waitReadyMs_600);
}

async function startPromise(audioRenderer: audio.AudioRenderer) {
  if (!audioRenderer) {
    console.warn('Renderer:audioRenderer is null');
    return;
  }
  await audioRenderer.start().then(() => {
    if(audioRenderer.state != audio.AudioState.STATE_RUNNING) {
      isPass = false;
    }
  }).catch((err: BusinessError) => {
    isPass = false;
    console.error('audioRenderer.start Invoked: Error: ' + err);
  });
  await sleep(waitReadyMs_100);
}

async function pauseCallback(audioRenderer: audio.AudioRenderer) {
  if (!audioRenderer) {
    console.warn('Renderer:audioRenderer is null');
    return;
  }
  audioRenderer.pause((err: BusinessError) => {
    if (err) {
      isPass = false;
      console.error('audioRenderer.pause Invoked: Error: ' + err);
    } else {
      if(audioRenderer.state != audio.AudioState.STATE_PAUSED) {
        isPass = false;
      }
    }
  });
  await sleep(waitReadyMs_600);
}

async function pausePromise(audioRenderer: audio.AudioRenderer) {
  if (!audioRenderer) {
    console.warn('Renderer:audioRenderer is null');
    return;
  }
  await audioRenderer.pause().then(() => {
    if(audioRenderer.state != audio.AudioState.STATE_PAUSED) {
      isPass = false;
    }
  }).catch((err: BusinessError) => {
    isPass = false;
    console.error('audioRenderer.pause Invoked: Error: ' + err);
  });
  await sleep(waitReadyMs_100);
}

async function stopCallback(audioRenderer: audio.AudioRenderer) {
  if (!audioRenderer) {
    console.warn('Renderer:audioRenderer is null');
    return;
  }
  audioRenderer.stop((err: BusinessError) => {
    if (err) {
      isPass = false;
      console.error('audioRenderer.stop Invoked: Error: ' + err);
    } else {
      if(audioRenderer.state != audio.AudioState.STATE_STOPPED) {
        isPass = false;
      }
    }
  });
  await sleep(waitReadyMs_600);
}

async function stopPromise(audioRenderer: audio.AudioRenderer) {
  if (!audioRenderer) {
    console.warn('Renderer:audioRenderer is null');
    return;
  }
  await audioRenderer.stop().then(() => {
    if(audioRenderer.state != audio.AudioState.STATE_STOPPED) {
      isPass = false;
    }
  }).catch((err: BusinessError) => {
    isPass = false;
    console.error('audioRenderer.stop Invoked: Error: ' + err);
  });
  await sleep(waitReadyMs_100);
}

async function releaseCallback(audioRenderer: audio.AudioRenderer) {
  if (!audioRenderer) {
    console.warn('Renderer:audioRenderer is null');
    return;
  }
  audioRenderer.release((err: BusinessError) => {
    if (err) {
      isPass = false;
      console.error('audioRenderer.release Invoked: Error: ' + err);
    } else {
      if(audioRenderer.state != audio.AudioState.STATE_RELEASED) {
        isPass = false;
      }
    }
  });
  await sleep(waitReadyMs_600);
}

async function releasePromise(audioRenderer: audio.AudioRenderer) {
  if (!audioRenderer) {
    console.warn('Renderer:audioRenderer is null');
    return;
  }
  await audioRenderer.release().then(() => {
    if(audioRenderer.state != audio.AudioState.STATE_RELEASED) {
      isPass = false;
    }
  }).catch((err: BusinessError) => {
    isPass = false;
    console.error('audioRenderer.release Invoked: Error: ' + err);
  });
  await sleep(waitReadyMs_100);
}

async function release(audioRenderer: audio.AudioRenderer) {
  if (!audioRenderer) {
    return;
  }
  await audioRenderer.release().then(() => {
  }).catch((err: BusinessError) => {
    console.error('audioRenderer.release Invoked: Error: ' + err);
  });
  await sleep(waitReadyMs_100);
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
    audioRenderer.on('writeData', writeDataCallback);
    await sleep(waitReadyMs_600);
  } catch (error) {
    expect().assertFail();
    console.error('Renderer:onWriteData fail:' + error);
  }
}

let fileDescriptor: resourceManager.RawFileDescriptor;

export default function audioRendererTest() {
  describe('audioRendererTest', () => {
    beforeAll(async () => {
      audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
      await sleep(waitReadyMs_1000);
    })
    beforeEach(async () => {
      isPass = false;
      if (audioRenderer.state == audio.AudioState.STATE_RELEASED) {
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
      }
      await sleep(waitReadyMs_100);
    })
    afterEach(async () => {
      if (audioRenderer.state == audio.AudioState.STATE_RUNNING) {
        await stopPromise(audioRenderer);
      }
    })

    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererOnWriteData_Func_0100
     * @tc.name   : renderer.on('writeData')
     * @tc.desc   : Test renderer.on('writeData') - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_rendererOnWriteData_Func_0100', 0, async (done: Function) => {
      let bufferSize: number = 0;
      fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      try {
        let writeDataCallback = (buffer: ArrayBuffer) => {
          let options: Options = {
            offset: bufferSize,
            length: buffer.byteLength
          }
          fs.readSync(fileFd, buffer, options)
          bufferSize += buffer.byteLength;
        }
        audioRenderer.on('writeData', writeDataCallback);
        await sleep(waitReadyMs_300);
        await startPromise(audioRenderer);
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_RUNNING);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererOnWriteData_Func_0100 error' + error);
      }
      await audioRenderer.release();
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererOnStateChange_Func_0100
     * @tc.name   : renderer.on('stateChange')
     * @tc.desc   : Test renderer.on('stateChange') - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_rendererOnStateChange_Func_0100', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        audioRenderer.on('stateChange', (state) => {
          if(state == audio.AudioState.STATE_RUNNING) {
            isPass = true;
          }
        });
        await sleep(waitReadyMs_300);
        await startPromise(audioRenderer);
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_RUNNING);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererOnStateChange_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererOnStateChange_Func_0200
     * @tc.name   : renderer.on('stateChange')
     * @tc.desc   : Test renderer.on('stateChange') - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_rendererOnStateChange_Func_0200', 0, async (done: Function) => {
      try{
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        audioRenderer.on('stateChange', (state) => {
          if(state == audio.AudioState.STATE_PAUSED) {
            isPass = true;
          }
        });
        await startPromise(audioRenderer);
        await pausePromise(audioRenderer);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererOnStateChange_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererOnStateChange_Func_0300
     * @tc.name   : renderer.on('stateChange')
     * @tc.desc   : Test renderer.on('stateChange') - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_rendererOnStateChange_Func_0300', 0, async (done: Function) => {
      try{
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        audioRenderer.on('stateChange', (state) => {
          if(state == audio.AudioState.STATE_STOPPED) {
            isPass = true;
          }
        });
        await startPromise(audioRenderer);
        await stopPromise(audioRenderer);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererOnStateChange_Func_0300 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererOnStateChange_Func_0400
     * @tc.name   : renderer.on('stateChange')
     * @tc.desc   : Test renderer.on('stateChange') - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_rendererOnStateChange_Func_0400', 0, async (done: Function) => {
      try{
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        audioRenderer.on('stateChange', (state) => {
          if(state == audio.AudioState.STATE_RELEASED) {
            isPass = true;
          }
        });
        await releasePromise(audioRenderer);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererOnStateChange_Func_0400 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await release(audioRenderer);
      done();
    })

    if (isAndroidVersionGreater(androidVersion_10)) {
      /**
       * @tc.number : SUB_ArkUIX_Audio_getRendererInfo_Func_0100
       * @tc.name   : getRendererInfo
       * @tc.desc   : Test getRendererInfo - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getRendererInfo_Func_0100', 0, async (done: Function) => {
        try{
          audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
          audioRenderer.getRendererInfo((err, rendererInfo) => {
            if (err) {
              console.error('getRendererInfo Invoked: Error: ' + err.code);
            } else {
              if(rendererInfo.usage == audioRendererOptions.rendererInfo.usage &&
                rendererInfo.rendererFlags == audioRendererOptions.rendererInfo.rendererFlags) {
                isPass = true;
              }
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getRendererInfo_Func_0100 error' + error);
        }
        await sleep(waitReadyMs_400);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getRendererInfo_Func_0200
       * @tc.name   : getRendererInfo
       * @tc.desc   : Test getRendererInfo - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getRendererInfo_Func_0200', 0, async (done: Function) => {
        try{
          await audioRenderer.getRendererInfo().then((rendererInfo) => {
            if(rendererInfo.usage == audioRendererOptions.rendererInfo.usage &&
              rendererInfo.rendererFlags == audioRendererOptions.rendererInfo.rendererFlags) {
              isPass = true;
            }
          }).catch((err: BusinessError) => {
            expect(err).assertFail();
            console.error('getRendererInfo Invoked: Error: ' + err);
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getRendererInfo_Func_0200 error' + error);
        }
        await sleep(waitReadyMs_100);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getRendererInfoSync_Func_0300
       * @tc.name   : getRendererInfoSync
       * @tc.desc   : Test getRendererInfoSync - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getRendererInfoSync_Func_0300', 0, async (done: Function) => {
        try{
          let rendererInfo: audio.AudioRendererInfo = audioRenderer.getRendererInfoSync();
          if(rendererInfo.usage == audioRendererOptions.rendererInfo.usage &&
            rendererInfo.rendererFlags == audioRendererOptions.rendererInfo.rendererFlags) {
            isPass = true;
          }
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getRendererInfoSync_Func_0300 error' + error);
        }
        await sleep(waitReadyMs_100);
        expect(isPass).assertTrue();
        done();
      })
    }
    /**
     * @tc.number : SUB_ArkUIX_Audio_getStreamInfo_Func_0100
     * @tc.name   : getStreamInfo
     * @tc.desc   : Test getStreamInfo - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getStreamInfo_Func_0100', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        audioRenderer.getStreamInfo((err, streamInfo) => {
          if (err) {
            console.error('getStreamInfo Invoked: Error: ' + err.code);
          } else {
            if(streamInfo.samplingRate == audioRendererOptions.streamInfo.samplingRate &&
              streamInfo.channels == audioRendererOptions.streamInfo.channels &&
              streamInfo.sampleFormat == audioRendererOptions.streamInfo.sampleFormat &&
              streamInfo.encodingType == audioRendererOptions.streamInfo.encodingType) {
              isPass = true;
            }
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getStreamInfo_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getStreamInfo_Func_0200
     * @tc.name   : getStreamInfo
     * @tc.desc   : Test getStreamInfo - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getStreamInfo_Func_0200', 0, async (done: Function) => {
      try{
        await audioRenderer.getStreamInfo().then((streamInfo) => {
          if(streamInfo.samplingRate == audioRendererOptions.streamInfo.samplingRate &&
            streamInfo.channels == audioRendererOptions.streamInfo.channels &&
            streamInfo.sampleFormat == audioRendererOptions.streamInfo.sampleFormat &&
            streamInfo.encodingType == audioRendererOptions.streamInfo.encodingType) {
            isPass = true;
          }
        }).catch((err: BusinessError) => {
          expect(err).assertFail();
          console.error('getStreamInfo Invoked: Error: ' + err);
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getStreamInfo_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getStreamInfoSync_Func_0300
     * @tc.name   : getStreamInfoSync
     * @tc.desc   : Test getStreamInfoSync - Sync
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getStreamInfoSync_Func_0300', 0, async (done: Function) => {
      try{
        let streamInfo: audio.AudioStreamInfo = audioRenderer.getStreamInfoSync();
        if(streamInfo.samplingRate == audioRendererOptions.streamInfo.samplingRate &&
          streamInfo.channels == audioRendererOptions.streamInfo.channels &&
          streamInfo.sampleFormat == audioRendererOptions.streamInfo.sampleFormat &&
          streamInfo.encodingType == audioRendererOptions.streamInfo.encodingType) {
          isPass = true;
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getStreamInfoSync_Func_0300 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getAudioStreamId_Func_0100
     * @tc.name   : getAudioStreamId
     * @tc.desc   : Test getAudioStreamId - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getAudioStreamId_Func_0100', 0, async (done: Function) => {
      try{
        audioRenderer.getAudioStreamId((err, streamId) => {
          if (err) {
            console.error('getAudioStreamId Invoked: Error: ' + err);
          } else {
            if(streamId >= 0) {
              isPass = true;
            }
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getAudioStreamId_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getAudioStreamId_Func_0200
     * @tc.name   : getAudioStreamId
     * @tc.desc   : Test getAudioStreamId - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getAudioStreamId_Func_0200', 0, async (done: Function) => {
      try{
        await audioRenderer.getAudioStreamId().then((streamId) => {
          if(streamId >= 0) {
            isPass = true;
          }
        }).catch((err: BusinessError) => {
          expect(err).assertFail();
          console.error('getAudioStreamId Invoked: Error: ' + err);
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getAudioStreamId_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getAudioStreamIdSync_Func_0300
     * @tc.name   : getAudioStreamIdSync
     * @tc.desc   : Test getAudioStreamIdSync - Sync
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getAudioStreamIdSync_Func_0300', 0, async (done: Function) => {
      try{
        let streamId: number = audioRenderer.getAudioStreamIdSync();
        if(streamId >= 0) {
          isPass = true;
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getAudioStreamIdSync_Func_0300 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getAudioTime_Func_0100
     * @tc.name   : getAudioTime
     * @tc.desc   : Test getAudioTime - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getAudioTime_Func_0100', 0, async (done: Function) => {
      try{
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await sleep(waitReadyMs_1000);
        audioRenderer.getAudioTime((err, timestamp) => {
          if (err) {
            console.error('getAudioTime Invoked: Error: ' + err.code);
          } else {
            if(timestamp >= 0) {
              isPass = true;
            }
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getAudioTime_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_1000);
      expect(isPass).assertTrue();
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getAudioTime_Func_0200
     * @tc.name   : getAudioTime
     * @tc.desc   : Test getAudioTime - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getAudioTime_Func_0200', 0, async (done: Function) => {
      try{
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await sleep(waitReadyMs_600);
        await audioRenderer.getAudioTime().then((timestamp: number) => {
          if(timestamp >= 0) {
            isPass = true;
          }
        }).catch((err: BusinessError) => {
          expect().assertFail();
          console.error('getAudioTime Invoked: Error: ' + err.code);
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getAudioTime_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getAudioTimeSync_Func_0300
     * @tc.name   : getAudioTimeSync
     * @tc.desc   : Test getAudioTimeSync - Sync
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getAudioTimeSync_Func_0300', 0, async (done: Function) => {
      try{
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await sleep(waitReadyMs_600);
        let timestamp: number = audioRenderer.getAudioTimeSync();
        if(timestamp >= 0) {
          isPass = true;
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getAudioTimeSync_Func_0300 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getBufferSize_Func_0100
     * @tc.name   : getBufferSize
     * @tc.desc   : Test getBufferSize - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getBufferSize_Func_0100', 0, async (done: Function) => {
      try{
        audioRenderer.getBufferSize((err, data) => {
          if (err) {
            console.error('getBufferSize Invoked: Error: ' + err);
          } else {
            if(data >= 0) {
              isPass = true;
            }
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getBufferSize_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getBufferSize_Func_0200
     * @tc.name   : getBufferSize
     * @tc.desc   : Test getBufferSize - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getBufferSize_Func_0200', 0, async (done: Function) => {
      try{
        await audioRenderer.getBufferSize().then((data) => {
          if(data >= 0) {
            isPass = true;
          }
        }).catch((err: BusinessError) => {
          expect(err).assertFail();
          console.error('getBufferSize Invoked: Error: ' + err);
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getBufferSize_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getBufferSizeSync_Func_0300
     * @tc.name   : getBufferSizeSync
     * @tc.desc   : Test getBufferSizeSync - Sync
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getBufferSizeSync_Func_0300', 0, async (done: Function) => {
      try{
        let bufferSize = audioRenderer.getBufferSizeSync();
        if(bufferSize >= 0) {
          isPass = true;
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getBufferSizeSync_Func_0300 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_setSpeed_Func_0100
     * @tc.name   : setSpeed
     * @tc.desc   : Test setSpeed - Sync
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_setSpeed_Func_0100', 0, async (done: Function) => {
      try{
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        audioRenderer.setSpeed(speed_fast);
        let speed = audioRenderer.getSpeed();
        expect(speed).assertEqual(speed_fast)
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_setSpeed_Func_0100 error' + error);
      }
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_setSpeed_Func_0200
     * @tc.name   : setSpeed
     * @tc.desc   : Test setSpeed - Sync
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_setSpeed_Func_0200', 0, async (done: Function) => {
      try{
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        audioRenderer.setSpeed(speed_err);
        console.info('SUB_ArkUIX_Audio_setSpeed_Func_0200 fail');
      }
      catch (error) {
        expect(error.code).assertEqual('6800101');
      }
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_setSpeed_Func_0300
     * @tc.name   : setSpeed
     * @tc.desc   : Test setSpeed - Sync
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_setSpeed_Func_0300', 0, async (done: Function) => {
      try{
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        audioRenderer.setSpeed(speed_5);
        console.info('SUB_ArkUIX_Audio_setSpeed_Func_0300 fail');
      }
      catch (error) {
        expect(error.code).assertEqual('6800101');
      }
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getSpeed_Func_0100
     * @tc.name   : getSpeed
     * @tc.desc   : Test getSpeed - Sync
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getSpeed_Func_0100', 0, async (done: Function) => {
      try{
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        audioRenderer.setSpeed(speed_fast);
        let speed = audioRenderer.getSpeed();
        expect(speed).assertEqual(speed_fast)
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getSpeed_Func_0100 error' + error);
      }
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_setVolume_Func_0100
     * @tc.name   : setVolume
     * @tc.desc   : Test setVolume - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_setVolume_Func_0100', 0, async (done: Function) => {
      try{
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        audioRenderer.setVolume(volume_normal, (err) => {
          if (err) {
            console.error('setVolume Invoked: Error: ' + err);
          } else {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_setVolume_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_setVolume_Func_0200
     * @tc.name   : setVolume
     * @tc.desc   : Test setVolume - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_setVolume_Func_0200', 0, async (done: Function) => {
      try{
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await audioRenderer.setVolume(volume_normal).then(() => {
          isPass = true;
        }).catch((err: BusinessError) => {
          expect(err).assertFail();
          console.error('setVolume Invoked: Error: ' + err);
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_setVolume_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_setVolume_Func_0300
     * @tc.name   : setVolume
     * @tc.desc   : Test setVolume - Callback
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_setVolume_Func_0300', 0, async (done: Function) => {
      try{
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        audioRenderer.setVolume(volume_err, (err: BusinessError) => {
          if (err) {
            if(err.code == errCode_6800104) {
              isPass = true;
            }
          } else {
            console.info('SUB_ArkUIX_Audio_setVolume_Func_0300 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_setVolume_Func_0300 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_setVolume_Func_0400
     * @tc.name   : setVolume
     * @tc.desc   : Test setVolume - Promise
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_setVolume_Func_0400', 0, async (done: Function) => {
      try{
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await audioRenderer.setVolume(volume_err).then(() => {
          console.info('SUB_ArkUIX_Audio_setVolume_Func_0400 fail');
        }).catch((err: BusinessError) => {
          if(err.code == errCode_6800104) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_setVolume_Func_0400 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_setVolume_Func_0500
     * @tc.name   : setVolume
     * @tc.desc   : Test setVolume - Callback
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_setVolume_Func_0500', 0, async (done: Function) => {
      try{
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        audioRenderer.setVolume(volume_2, (err: BusinessError) => {
          if (err) {
            if(err.code == errCode_6800104) {
              isPass = true;
            }
          } else {
            console.info('SUB_ArkUIX_Audio_setVolume_Func_0500 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_setVolume_Func_0500 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_setVolume_Func_0600
     * @tc.name   : setVolume
     * @tc.desc   : Test setVolume - Promise
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Audio_setVolume_Func_0600', 0, async (done: Function) => {
      try{
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await audioRenderer.setVolume(volume_2).then(() => {
          console.info('SUB_ArkUIX_Audio_setVolume_Func_0600 fail');
        }).catch((err: BusinessError) => {
          if(err.code == errCode_6800104) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_setVolume_Func_0600 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getMinStreamVolume_Func_0100
     * @tc.name   : getMinStreamVolume
     * @tc.desc   : Test getMinStreamVolume - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getMinStreamVolume_Func_0100', 0, async (done: Function) => {
      try{
        await sleep(waitReadyMs_300);
        audioRenderer.getMinStreamVolume((err, minVolume) => {
          if (err) {
            expect(err).assertFail();
            console.error('getMinStreamVolume Invoked: Error: ' + err);
          } else {
            if(minVolume >= 0 && minVolume <= 1) {
              isPass = true;
            }
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getMinStreamVolume_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getMinStreamVolume_Func_0200
     * @tc.name   : getMinStreamVolume
     * @tc.desc   : Test getMinStreamVolume - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getMinStreamVolume_Func_0200', 0, async (done: Function) => {
      try{
        await audioRenderer.getMinStreamVolume().then((minVolume) => {
          if(minVolume >= 0 && minVolume <= 1) {
            isPass = true;
          }
        }).catch((err: BusinessError) => {
          expect(err).assertFail();
          console.error('getMinStreamVolume Invoked: Error: ' + err);
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getMinStreamVolume_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getMinStreamVolumeSync_Func_0300
     * @tc.name   : getMinStreamVolumeSync
     * @tc.desc   : Test getMinStreamVolumeSync - Sync
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getMinStreamVolumeSync_Func_0300', 0, async (done: Function) => {
      try{
        let minVolume = audioRenderer.getMinStreamVolumeSync();
        if(minVolume >= 0 && minVolume <= 1) {
          isPass = true;
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getMinStreamVolumeSync_Func_0300 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getMaxStreamVolume_Func_0100
     * @tc.name   : getMaxStreamVolume
     * @tc.desc   : Test getMaxStreamVolume - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getMaxStreamVolume_Func_0100', 0, async (done: Function) => {
      try{
        audioRenderer.getMaxStreamVolume((err, maxVolume) => {
          if (err) {
            expect(err).assertFail();
            console.error('getMaxStreamVolume Invoked: Error: ' + err);
          } else {
            if(maxVolume >= 0 && maxVolume <= 1) {
              isPass = true;
            }
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getMaxStreamVolume_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getMaxStreamVolume_Func_0200
     * @tc.name   : getMaxStreamVolume
     * @tc.desc   : Test getMaxStreamVolume - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getMaxStreamVolume_Func_0200', 0, async (done: Function) => {
      try{
        await audioRenderer.getMaxStreamVolume().then((maxVolume) => {
          if(maxVolume >= 0 && maxVolume <= 1) {
            isPass = true;
          }
        }).catch((err: BusinessError) => {
          expect(err).assertFail();
          console.error('getMaxStreamVolume Invoked: Error: ' + err);
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getMaxStreamVolume_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getMaxStreamVolumeSync_Func_0300
     * @tc.name   : getMaxStreamVolumeSync
     * @tc.desc   : Test getMaxStreamVolumeSync - Sync
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getMaxStreamVolumeSync_Func_0300', 0, async (done: Function) => {
      try{
        let maxVolume = audioRenderer.getMaxStreamVolumeSync();
        if(maxVolume >= 0 && maxVolume <= 1) {
          isPass = true;
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getMaxStreamVolumeSync_Func_0300 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getCurrentOutputDevices_Func_0100
     * @tc.name   : getCurrentOutputDevices
     * @tc.desc   : Test getCurrentOutputDevices - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getCurrentOutputDevices_Func_0100', 0, async (done: Function) => {
      try{
        audioRenderer.getCurrentOutputDevices((err, deviceDescriptors) => {
          if (err) {
            console.error('getCurrentOutputDevices Invoked: Error: ' + err);
          } else {
            if(deviceDescriptors.length != 0) {
              isPass = true;
            }
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getCurrentOutputDevices_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getCurrentOutputDevices_Func_0200
     * @tc.name   : getCurrentOutputDevices
     * @tc.desc   : Test getCurrentOutputDevices - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getCurrentOutputDevices_Func_0200', 0, async (done: Function) => {
      try{
        await audioRenderer.getCurrentOutputDevices().then((deviceDescriptors) => {
          if(deviceDescriptors.length != 0) {
            isPass = true;
          }
        }).catch((err: BusinessError) => {
          expect(err).assertFail();
          console.error('getCurrentOutputDevices Invoked: Error: ' + err);
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getCurrentOutputDevices_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getCurrentOutputDevicesSync_Func_0300
     * @tc.name   : getCurrentOutputDevicesSync
     * @tc.desc   : Test getCurrentOutputDevicesSync - Sync
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getCurrentOutputDevicesSync_Func_0300', 0, async (done: Function) => {
      try{
        let deviceDescriptors = audioRenderer.getCurrentOutputDevicesSync();
        if(deviceDescriptors.length != 0) {
          isPass = true;
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getCurrentOutputDevicesSync_Func_0300 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererStart_Func_0100
     * @tc.name   : audioRenderer.start
     * @tc.desc   : Test audioRenderer.start - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_rendererStart_Func_0100', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        audioRenderer.start((err) => {
          if (err) {
            console.error('audioRenderer.start Invoked: Error: ' + err);
          } else {
            isPass = true;
          }
        });
        await sleep(waitReadyMs_600);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_RUNNING);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererStart_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererStart_Func_0200
     * @tc.name   : audioRenderer.start
     * @tc.desc   : Test audioRenderer.start - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_rendererStart_Func_0200', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await audioRenderer.start().then(() => {
          isPass = true;
        }).catch((err: BusinessError) => {
          console.error('audioRenderer.start Invoked: Error: ' + err);
        });
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_RUNNING);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererStart_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererPause_Func_0100
     * @tc.name   : audioRenderer.pause
     * @tc.desc   : Test audioRenderer.pause - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_rendererPause_Func_0100', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        audioRenderer.pause((err) => {
          if (err) {
            console.error('audioRenderer.pause Invoked: Error: ' + err);
          } else {
            isPass = true;
          }
        });
        await sleep(waitReadyMs_600);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PAUSED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererPause_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererPause_Func_0200
     * @tc.name   : audioRenderer.pause
     * @tc.desc   : Test audioRenderer.pause - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_rendererPause_Func_0200', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        audioRenderer.pause().then(() => {
          isPass = true;
        }).catch((err: BusinessError) => {
          expect(err).assertFail();
          console.error('audioRenderer.pause Invoked: Error: ' + err);
        });
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PAUSED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererPause_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_flush_Func_0100
     * @tc.name   : flush
     * @tc.desc   : Test flush - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_flush_Func_0100', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await sleep(waitReadyMs_300);
        await audioRenderer.flush().then(() => {
          isPass = true;
        }).catch((err: BusinessError) => {
          expect(err).assertFail();
          console.error('flush Invoked: Error: ' + err.code);
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_flush_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererStop_Func_0100
     * @tc.name   : audioRenderer.stop
     * @tc.desc   : Test audioRenderer.stop - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_rendererStop_Func_0100', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        audioRenderer.stop((err) => {
          if (err) {
            console.error('audioRenderer.stop Invoked: Error: ' + err);
          } else {
            isPass = true;
          }
        });
        await sleep(waitReadyMs_600);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_STOPPED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererStop_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererStop_Func_0200
     * @tc.name   : audioRenderer.stop
     * @tc.desc   : Test audioRenderer.stop - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_rendererStop_Func_0200', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await audioRenderer.stop().then(() => {
          isPass = true;
        }).catch((err: BusinessError) => {
          expect(err).assertFail();
          console.error('audioRenderer.stop Invoked: Error: ' + err);
        });
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_STOPPED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererStop_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererRelease_Func_0100
     * @tc.name   : audioRenderer.release
     * @tc.desc   : Test audioRenderer.release - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_rendererRelease_Func_0100', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        audioRenderer.release((err) => {
          if (err) {
            console.error('audioRenderer.release Invoked: Error: ' + err);
          } else {
            isPass = true;
          }
        });
        await sleep(waitReadyMs_600);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_RELEASED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererRelease_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererRelease_Func_0200
     * @tc.name   : audioRenderer.release
     * @tc.desc   : Test audioRenderer.release - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_rendererRelease_Func_0200', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        await audioRenderer.release().then(() => {
          isPass = true;
        }).catch((err: BusinessError) => {
          expect(err).assertFail();
          console.error('audioRenderer.release Invoked: Error: ' + err);
        });
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_RELEASED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererRelease_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      done();
    })

    if(platform != 'iOS') {
      /**
       * @tc.number : SUB_ArkUIX_Audio_rendererOnMarkReach_Func_0100
       * @tc.name   : renderer.on('markReach')
       * @tc.desc   : Test renderer.on('markReach') - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_rendererOnMarkReach_Func_0100', 0, async (done: Function) => {
        try{
          audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
          fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
          await onWriteData(audioRenderer, fileDescriptor);
          audioRenderer.on('markReach', position_1000, (position) => {
            if (position == position_1000) {
              isPass = true;
            }
          });
          await startCallback(audioRenderer);
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_rendererOnMarkReach_Func_0100 error' + error);
        }
        await sleep(waitReadyMs_1000);
        expect(isPass).assertTrue();
        await release(audioRenderer);
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_rendererOnMarkReach_Func_0200
       * @tc.name   : renderer.on('markReach')
       * @tc.desc   : Test renderer.on('markReach') - Callback
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_rendererOnMarkReach_Func_0200', 0, async (done: Function) => {
        isPass = true;
        try{
          fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
          await onWriteData(audioRenderer, fileDescriptor);
          audioRenderer.on('markReach', position_err, (position) => {
            isPass = false;
            console.info('SUB_ArkUIX_Audio_rendererOnMarkReach_Func_0200 fail');
          });
          await startCallback(audioRenderer);
          await sleep(waitReadyMs_300);
        }
        catch (error) {
          expect(error.code).assertEqual('401');
        }
        await sleep(waitReadyMs_100);
        expect(isPass).assertTrue();
        await release(audioRenderer);
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_rendererOffMarkReach_Func_0100
       * @tc.name   : renderer.off('markReach')
       * @tc.desc   : Test renderer.off('markReach') - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_rendererOffMarkReach_Func_0100', 0, async (done: Function) => {
        isPass = true;
        try{
          fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
          await onWriteData(audioRenderer, fileDescriptor);
          audioRenderer.on('markReach', position_1000, (position) => {
            isPass = false;
          });
          audioRenderer.off('markReach');
          await startCallback(audioRenderer);
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_rendererOffMarkReach_Func_0100 error' + error);
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        await release(audioRenderer);
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_rendererOnPeriodReach_Func_0100
       * @tc.name   : renderer.on('periodReach')
       * @tc.desc   : Test renderer.on('periodReach') - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_rendererOnPeriodReach_Func_0100', 0, async (done: Function) => {
        try{
          fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
          await onWriteData(audioRenderer, fileDescriptor);
          audioRenderer.on('periodReach', position_1000, (position) => {
            if (position == position_1000) {
              isPass = true;
            }
          });
          await startCallback(audioRenderer);
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_rendererOnPeriodReach_Func_0100 error' + error);
        }
        await sleep(waitReadyMs_1000);
        expect(isPass).assertTrue();
        await release(audioRenderer);
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_rendererOnPeriodReach_Func_0200
       * @tc.name   : renderer.on('periodReach')
       * @tc.desc   : Test renderer.on('periodReach') - Callback
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_rendererOnPeriodReach_Func_0200', 0, async (done: Function) => {
        isPass = true;
        try{
          fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
          await onWriteData(audioRenderer, fileDescriptor);
          audioRenderer.on('periodReach', position_err, (position) => {
            isPass = false;
            console.info('SUB_ArkUIX_Audio_rendererOnPeriodReach_Func_0200 fail');
          });
        }
        catch (error) {
          expect(error.code).assertEqual('401');
        }
        await sleep(waitReadyMs_100);
        expect(isPass).assertTrue();
        await release(audioRenderer);
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_rendererOffPeriodReach_Func_0100
       * @tc.name   : renderer.off('periodReach')
       * @tc.desc   : Test renderer.off('periodReach') - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_rendererOffPeriodReach_Func_0100', 0, async (done: Function) => {
        isPass = true;
        try{
          fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
          await onWriteData(audioRenderer, fileDescriptor);
          audioRenderer.on('periodReach', position_1000, (position) => {
            isPass = false;
          });
          audioRenderer.off('periodReach');
          await startCallback(audioRenderer);
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_rendererOffPeriodReach_Func_0100 error' + error);
        }
        await sleep(waitReadyMs_1000);
        expect(isPass).assertTrue();
        await release(audioRenderer);
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getUnderflowCount_Func_0100
       * @tc.name   : getUnderflowCount
       * @tc.desc   : Test getUnderflowCount - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getUnderflowCount_Func_0100', 0, async (done: Function) => {
        try{
          audioRenderer.getUnderflowCount((err, underflowCount) => {
            if (err) {
              console.error('getUnderflowCount Invoked: Error: ' + err);
            } else {
              if(underflowCount >= 0) {
                isPass = true ;
              }
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getUnderflowCount_Func_0100 error' + error);
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getUnderflowCount_Func_0200
       * @tc.name   : getUnderflowCount
       * @tc.desc   : Test getUnderflowCount - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getUnderflowCount_Func_0200', 0, async (done: Function) => {
        try{
          await audioRenderer.getUnderflowCount().then((underflowCount) => {
            if(underflowCount >= 0) {
              isPass = true ;
            }
          }).catch((err: BusinessError) => {
            expect(err).assertFail();
            console.error('getUnderflowCount Invoked: Error: ' + err);
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getUnderflowCount_Func_0200 error' + error);
        }
        await sleep(waitReadyMs_100);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getUnderflowCountSync_Func_0300
       * @tc.name   : getUnderflowCountSync
       * @tc.desc   : Test getUnderflowCountSync - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getUnderflowCountSync_Func_0300', 0, async (done: Function) => {
        try{
          let underflowCount = audioRenderer.getUnderflowCountSync();
          if(underflowCount >= 0) {
            isPass = true ;
          }
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getUnderflowCountSync_Func_0300 error' + error);
        }
        await sleep(waitReadyMs_100);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_setChannelBlendMode_Func_0100
       * @tc.name   : setChannelBlendMode
       * @tc.desc   : Test setChannelBlendMode - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_setChannelBlendMode_Func_0100', 0, async (done: Function) => {
        try{
          audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
          audioRenderer.setChannelBlendMode(audio.ChannelBlendMode.MODE_DEFAULT);
          await sleep(waitReadyMs_100);
          expect(true).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_setChannelBlendMode_Func_0100 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_setChannelBlendMode_Func_0200
       * @tc.name   : setChannelBlendMode
       * @tc.desc   : Test setChannelBlendMode - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_setChannelBlendMode_Func_0200', 0, async (done: Function) => {
        try{
          audioRenderer.setChannelBlendMode(audio.ChannelBlendMode.MODE_BLEND_LR);
          await sleep(waitReadyMs_100);
          expect(true).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_setChannelBlendMode_Func_0200 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_setChannelBlendMode_Func_0300
       * @tc.name   : setChannelBlendMode
       * @tc.desc   : Test setChannelBlendMode - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_setChannelBlendMode_Func_0300', 0, async (done: Function) => {
        try{
          audioRenderer.setChannelBlendMode(audio.ChannelBlendMode.MODE_ALL_LEFT);
          await sleep(waitReadyMs_100);
          expect(true).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_setChannelBlendMode_Func_0300 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_setChannelBlendMode_Func_0400
       * @tc.name   : setChannelBlendMode
       * @tc.desc   : Test setChannelBlendMode - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_setChannelBlendMode_Func_0400', 0, async (done: Function) => {
        try{
          audioRenderer.setChannelBlendMode(audio.ChannelBlendMode.MODE_ALL_RIGHT);
          await sleep(waitReadyMs_100);
          expect(true).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_setChannelBlendMode_Func_0400 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_setChannelBlendMode_Func_0500
       * @tc.name   : setChannelBlendMode
       * @tc.desc   : Test setChannelBlendMode - Sync
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_setChannelBlendMode_Func_0500', 0, async (done: Function) => {
        try{
          audioRenderer.setChannelBlendMode(enum_4);
          await sleep(waitReadyMs_100);
          expect().assertFail()
          console.info('SUB_ArkUIX_Audio_setChannelBlendMode_Func_0500 fail');
        }
        catch (error) {
          expect(error.code).assertEqual('6800101');
        }
        done();
      })
    }

    if(platform != 'Android') {
      /**
       * @tc.number : SUB_ArkUIX_Audio_setInterruptMode_Func_0100
       * @tc.name   : setInterruptMode
       * @tc.desc   : Test setInterruptMode - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_setInterruptMode_Func_0100', 0, async (done: Function) => {
        try{
          audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
          audioRenderer.setInterruptMode(audio.InterruptMode.SHARE_MODE, (err) => {
            if (err) {
              console.error('setInterruptMode Invoked: Error: ' + err);
            } else {
              isPass = true ;
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_setInterruptMode_Func_0100 error' + error);
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_setInterruptMode_Func_0200
       * @tc.name   : setInterruptMode
       * @tc.desc   : Test setInterruptMode - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_setInterruptMode_Func_0200', 0, async (done: Function) => {
        try{
          await audioRenderer.setInterruptMode(audio.InterruptMode.SHARE_MODE).then(() => {
            isPass = true ;
          }).catch((err: BusinessError) => {
            expect(err).assertFail();
            console.error('setInterruptMode Invoked: Error: ' + err);
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_setInterruptMode_Func_0200 error' + error);
        }
        await sleep(waitReadyMs_100);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_setInterruptMode_Func_0300
       * @tc.name   : setInterruptMode
       * @tc.desc   : Test setInterruptMode - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_setInterruptMode_Func_0300', 0, async (done: Function) => {
        try{
          audioRenderer.setInterruptMode(audio.InterruptMode.INDEPENDENT_MODE, (err) => {
            if (err) {
              console.error('setInterruptMode Invoked: Error: ' + err);
            } else {
              isPass = true ;
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_setInterruptMode_Func_0300 error' + error);
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_setInterruptMode_Func_0400
       * @tc.name   : setInterruptMode
       * @tc.desc   : Test setInterruptMode - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_setInterruptMode_Func_0400', 0, async (done: Function) => {
        try{
          await audioRenderer.setInterruptMode(audio.InterruptMode.INDEPENDENT_MODE).then(() => {
            isPass = true ;
          }).catch((err: BusinessError) => {
            expect(err).assertFail();
            console.error('setInterruptMode Invoked: Error: ' + err);
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_setInterruptMode_Func_0400 error' + error);
        }
        await sleep(waitReadyMs_100);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_setInterruptModeSync_Func_0100
       * @tc.name   : setInterruptModeSync
       * @tc.desc   : Test setInterruptModeSync - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_setInterruptModeSync_Func_0100', 0, async (done: Function) => {
        try{
          audioRenderer.setInterruptModeSync(audio.InterruptMode.SHARE_MODE);
          expect(true).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_setInterruptModeSync_Func_0100 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_setInterruptModeSync_Func_0200
       * @tc.name   : setInterruptModeSync
       * @tc.desc   : Test setInterruptModeSync - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_setInterruptModeSync_Func_0200', 0, async (done: Function) => {
        try{
          audioRenderer.setInterruptModeSync(audio.InterruptMode.INDEPENDENT_MODE);
          expect(true).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_setInterruptModeSync_Func_0200 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_setVolumeWithRamp_Func_0100
       * @tc.name   : setVolumeWithRamp
       * @tc.desc   : Test setVolumeWithRamp - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_setVolumeWithRamp_Func_0100', 0, async (done: Function) => {
        try{
          audioRenderer.setVolumeWithRamp(volume_normal, position_1000);
          expect(true).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_setVolumeWithRamp_Func_0100 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_setVolumeWithRamp_Func_0200
       * @tc.name   : setVolumeWithRamp
       * @tc.desc   : Test setVolumeWithRamp - Sync
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_setVolumeWithRamp_Func_0200', 0, async (done: Function) => {
        try{
          audioRenderer.setVolumeWithRamp(volume_err, position_1000);
          expect().assertFail();
          console.error('SUB_ArkUIX_Audio_setVolumeWithRamp_Func_0200 fail');
        }
        catch (error) {
          expect(error.code).assertEqual('6800101');
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_setVolumeWithRamp_Func_0300
       * @tc.name   : setVolumeWithRamp
       * @tc.desc   : Test setVolumeWithRamp - Sync
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_setVolumeWithRamp_Func_0300', 0, async (done: Function) => {
        try{
          audioRenderer.setVolumeWithRamp(volume_2, position_1000);
          expect().assertFail();
          console.error('SUB_ArkUIX_Audio_setVolumeWithRamp_Func_0300 fail');
        }
        catch (error) {
          expect(error.code).assertEqual('6800101');
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_rendererDrain_Func_0100
       * @tc.name   : audioRenderer.drain
       * @tc.desc   : Test audioRenderer.drain - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_rendererDrain_Func_0100', 0, async (done: Function) => {
        try{
          fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
          await onWriteData(audioRenderer, fileDescriptor);
          await startCallback(audioRenderer);
          await sleep(waitReadyMs_300);
          audioRenderer.drain((err) => {
            if (err) {
              console.error('audioRenderer.drain Invoked: Error: ' + err);
            } else {
              isPass = true;
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_rendererDrain_Func_0100 error' + error);
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        await release(audioRenderer);
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_rendererDrain_Func_0200
       * @tc.name   : audioRenderer.drain
       * @tc.desc   : Test audioRenderer.drain - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_rendererDrain_Func_0200', 0, async (done: Function) => {
        try{
          fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
          await onWriteData(audioRenderer, fileDescriptor);
          await startCallback(audioRenderer);
          await sleep(waitReadyMs_300);
          await audioRenderer.drain().then(() => {
            isPass = true;
          }).catch((err: BusinessError) => {
            console.error('audioRenderer.drain Invoked: Error: ' + err);
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_rendererDrain_Func_0200 error' + error);
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        await release(audioRenderer);
        done();
      })
    }
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_0100
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0100', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_RUNNING);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0100 error' + error);
      }
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_0200
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0200', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        audioRenderer.pause((err: BusinessError) => {
          if (err) {
            console.error('audioRenderer.pause Invoked: Error: ' + err);
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0200 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_0300
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0300', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        audioRenderer.stop((err: BusinessError) => {
          if (err) {
            console.error('audioRenderer.stop Invoked: Error: ' + err);
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0300 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0300 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_0400
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0400', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await audioRenderer.flush().then(() => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0400 fail');
        }).catch((err: BusinessError) => {
          expect(err.code).assertEqual(errCode_6800103);
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0400 error' + error);
      }
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_0500
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0500', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await releaseCallback(audioRenderer);
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_RELEASED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0500 error' + error);
      }
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_0600
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0600', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await sleep(waitReadyMs_300);
        audioRenderer.start((err: BusinessError) => {
          if (err) {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0600 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0600 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_0700
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0700', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await pauseCallback(audioRenderer);
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PAUSED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0700 error' + error);
      }
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_0800
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0800', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await stopCallback(audioRenderer);
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_STOPPED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0800 error' + error);
      }
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_0900
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0900', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await sleep(waitReadyMs_300);
        await audioRenderer.flush().then(() => {
          isPass = true;
        }).catch((err: BusinessError) => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0900 fail');
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0900 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_1000
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1000', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await releaseCallback(audioRenderer);
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_RELEASED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1000 error' + error);
      }
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_1100
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1100', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await pauseCallback(audioRenderer);
        await startCallback(audioRenderer);
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_RUNNING);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1100 error' + error);
      }
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_1200
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1200', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await pauseCallback(audioRenderer);
        audioRenderer.pause((err: BusinessError) => {
          if (err) {
            console.error('audioRenderer.pause Invoked: Error: ' + err);
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1200 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1200 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_1300
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1300', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await pauseCallback(audioRenderer);
        await stopCallback(audioRenderer);
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_STOPPED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1300 error' + error);
      }
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_1400
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1400', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await pauseCallback(audioRenderer);
        await sleep(waitReadyMs_300);
        await audioRenderer.flush().then(() => {
          isPass = true;
        }).catch((err: BusinessError) => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1400 fail');
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1400 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_1500
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1500', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await pauseCallback(audioRenderer);
        await releaseCallback(audioRenderer);
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_RELEASED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1500 error' + error);
      }
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_1600
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1600', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await stopCallback(audioRenderer);
        await startCallback(audioRenderer);
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_RUNNING);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1600 error' + error);
      }
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_1700
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1700', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await stopCallback(audioRenderer);
        audioRenderer.pause((err: BusinessError) => {
          if (err) {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1700 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1700 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_1800
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1800', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await stopCallback(audioRenderer);
        if (platform.startsWith('OpenHarmony')) {
          audioRenderer.stop((err: BusinessError) => {
            if (err) {
              console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1800 fail');
            } else {
              if (audioRenderer.state == audio.AudioState.STATE_STOPPED) {
                isPass = true;
              }
            }
          });
        } else {
          audioRenderer.stop((err: BusinessError) => {
            if (err) {
              if (err.code == errCode_6800301) {
                isPass = true;
              }
            } else {
              console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1800 fail');
            }
          });
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1800 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_1900
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1900', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await stopCallback(audioRenderer);
        await sleep(waitReadyMs_300);
        await audioRenderer.flush().then(() => {
          isPass = true;
        }).catch((err: BusinessError) => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1900 fail');
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1900 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_2000
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2000', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await stopCallback(audioRenderer);
        await releaseCallback(audioRenderer);
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_RELEASED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2000 error' + error);
      }
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_2100
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2100', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await releaseCallback(audioRenderer);
        audioRenderer.start((err: BusinessError) => {
          if (err) {
            console.error('audioRenderer.start Invoked: Error: ' + err);
            if(err.code == errCode_6800301) {
              isPass = true;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2100 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2100 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_2200
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2200', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await releaseCallback(audioRenderer);
        audioRenderer.pause((err: BusinessError) => {
          if (err) {
            if(err.code == errCode_6800301) {
              isPass = true;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2200 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2200 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_2300
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2300', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await releaseCallback(audioRenderer);
        audioRenderer.stop((err: BusinessError) => {
          if (err) {
            if(err.code == errCode_6800301) {
              isPass = true;
            }
          } else {
            console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2300 fail');
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2300 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_2400
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2400', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await releaseCallback(audioRenderer);
        await audioRenderer.flush().then(() => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2400 fail');
        }).catch((err: BusinessError) => {
          expect(err.code).assertEqual(errCode_6800103);
        });

      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2400 error' + error);
      }
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_2500
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2500', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await releaseCallback(audioRenderer);
        if (platform.startsWith('OpenHarmony')) {
          audioRenderer.release((err: BusinessError) => {
            if (err) {
              console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2500 fail');
            } else {
              if (audioRenderer.state == audio.AudioState.STATE_RELEASED) {
                isPass = true;
              }
            }
          });
        } else {
          audioRenderer.release((err: BusinessError) => {
            if (err) {
              if (err.code == errCode_6800301) {
                isPass = true;
              }
            } else {
              console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2500 fail');
            }
          });
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2500 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_2600
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2600', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startPromise(audioRenderer);
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_RUNNING);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2600 error' + error);
      }
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_2700
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2700', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        audioRenderer.pause().then(() => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2700 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2700 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_2800
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2800', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await audioRenderer.stop().then(() => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2800 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2800 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_2900
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2900', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await audioRenderer.flush().then(() => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2900 fail');
        }).catch((err: BusinessError) => {
          expect(err.code).assertEqual(errCode_6800103);
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2900 error' + error);
      }
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_3000
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3000', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await releasePromise(audioRenderer);
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_RELEASED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3000 error' + error);
      }
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_3100
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3100', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startPromise(audioRenderer);
        await audioRenderer.start().then(() => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3100 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3100 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_3200
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3200', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startPromise(audioRenderer);
        await pausePromise(audioRenderer);
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PAUSED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3200 error' + error);
      }
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_3300
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3300', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startPromise(audioRenderer);
        await stopPromise(audioRenderer);
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_STOPPED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3300 error' + error);
      }
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_3400
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3400', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startPromise(audioRenderer);
        await sleep(waitReadyMs_300);
        await audioRenderer.flush().then(() => {
          isPass = true;
        }).catch((err: BusinessError) => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3400 fail');
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3400 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_3500
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3500', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startPromise(audioRenderer);
        await releasePromise(audioRenderer);
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_RELEASED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3500 error' + error);
      }
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_3600
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3600', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startPromise(audioRenderer);
        await pausePromise(audioRenderer);
        await startPromise(audioRenderer);
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_RUNNING);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3600 error' + error);
      }
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_3700
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3700', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startPromise(audioRenderer);
        await pausePromise(audioRenderer);
        audioRenderer.pause().then(() => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3700 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3700 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_3800
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3800', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startPromise(audioRenderer);
        await pausePromise(audioRenderer);
        await stopPromise(audioRenderer);
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_STOPPED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3800 error' + error);
      }
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_3900
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3900', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startPromise(audioRenderer);
        await pausePromise(audioRenderer);
        await audioRenderer.flush().then(() => {
          isPass = true;
        }).catch((err: BusinessError) => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3900 fail');
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_3900 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_4000
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4000', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startPromise(audioRenderer);
        await pausePromise(audioRenderer);
        await releasePromise(audioRenderer);
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_RELEASED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4000 error' + error);
      }
      await release(audioRenderer);
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_4100
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4100', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startPromise(audioRenderer);
        await stopPromise(audioRenderer);
        await startPromise(audioRenderer);
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_RUNNING);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4100 error' + error);
      }
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_4200
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4200', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startPromise(audioRenderer);
        await stopPromise(audioRenderer);
        audioRenderer.pause().then(() => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4200 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4200 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_4300
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4300', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startPromise(audioRenderer);
        await stopPromise(audioRenderer);
        if (platform.startsWith('OpenHarmony')) {
          await audioRenderer.stop().then(() => {
            if (audioRenderer.state == audio.AudioState.STATE_STOPPED) {
              isPass = true;
            }
          }).catch((err: BusinessError) => {
            console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4300 fail');
          });
        } else {
          await audioRenderer.stop().then(() => {
            console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4300 fail');
          }).catch((err: BusinessError) => {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          });
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4300 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_4400
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4400', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startPromise(audioRenderer);
        await stopPromise(audioRenderer);
        await sleep(waitReadyMs_300);
        await audioRenderer.flush().then(() => {
          isPass = true;
        }).catch((err: BusinessError) => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4400 fail');
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4400 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioRenderer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_4500
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4500', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startPromise(audioRenderer);
        await stopPromise(audioRenderer);
        await releasePromise(audioRenderer);
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_RELEASED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4500 error' + error);
      }
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_4600
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4600', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await releasePromise(audioRenderer);
        await audioRenderer.start().then(() => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4600 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4600 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_4700
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4700', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await releasePromise(audioRenderer);
        audioRenderer.pause().then(() => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4700 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4700 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_4800
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4800', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await releasePromise(audioRenderer);
        await audioRenderer.stop().then(() => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4800 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4800 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_4900
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4900', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await releasePromise(audioRenderer);
        await audioRenderer.flush().then(() => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4900 fail');
        }).catch((err: BusinessError) => {
          expect(err.code).assertEqual(errCode_6800103);
        });

      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_4900 error' + error);
      }
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_5000
     * @tc.name   : audioRenderer Combined interface
     * @tc.desc   : Test audioRenderer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5000', 0, async (done: Function) => {
      try{
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await releasePromise(audioRenderer);
        if (platform.startsWith('OpenHarmony')) {
          await audioRenderer.release().then(() => {
            if (audioRenderer.state == audio.AudioState.STATE_RELEASED) {
              isPass = true;
            }
          }).catch((err: BusinessError) => {
            console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5000 fail');
          });
        } else {
          await audioRenderer.release().then(() => {
            console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5000 fail');
          }).catch((err: BusinessError) => {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          });
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5000 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      done();
    })

    if(platform != 'Android') {
      /**
       * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_5100
       * @tc.name   : audioRenderer Combined interface
       * @tc.desc   : Test audioRenderer Combined interface - Callback
       * @tc.level  : Level 1
       */
      it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5100', 0, async (done: Function) => {
        try{
          audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
          fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
          await onWriteData(audioRenderer, fileDescriptor);
          audioRenderer.drain((err) => {
            if (err) {
              if(err.code == errCode_6800301) {
                isPass = true;
              }
            } else {
              console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5100 fail');
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5100 error' + error);
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        await audioRenderer.release();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_5200
       * @tc.name   : audioRenderer Combined interface
       * @tc.desc   : Test audioRenderer Combined interface - Callback
       * @tc.level  : Level 1
       */
      it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5200', 0, async (done: Function) => {
        try{
          audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
          fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
          await onWriteData(audioRenderer, fileDescriptor);
          await startCallback(audioRenderer);
          await sleep(waitReadyMs_300);
          audioRenderer.drain((err) => {
            if (err) {
              console.error('audioRenderer.drain Invoked: Error: ' + err);
            } else {
              isPass = true;
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5200 error' + error);
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        await audioRenderer.release();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_5300
       * @tc.name   : audioRenderer Combined interface
       * @tc.desc   : Test audioRenderer Combined interface - Callback
       * @tc.level  : Level 1
       */
      it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5300', 0, async (done: Function) => {
        try{
          audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
          fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
          await onWriteData(audioRenderer, fileDescriptor);
          await startCallback(audioRenderer);
          await pauseCallback(audioRenderer);
          await sleep(waitReadyMs_300);
          audioRenderer.drain((err) => {
            if (err) {
              if(err.code == errCode_6800301) {
                isPass = true;
              }
            } else {
              console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5300 fail');
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5300 error' + error);
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        await audioRenderer.release();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_5400
       * @tc.name   : audioRenderer Combined interface
       * @tc.desc   : Test audioRenderer Combined interface - Callback
       * @tc.level  : Level 1
       */
      it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5400', 0, async (done: Function) => {
        try{
          audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
          fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
          await onWriteData(audioRenderer, fileDescriptor);
          await startCallback(audioRenderer);
          await stopCallback(audioRenderer);
          await sleep(waitReadyMs_300);
          audioRenderer.drain((err) => {
            if (err) {
              if(err.code == errCode_6800301) {
                isPass = true;
              }
            } else {
              console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5400 fail');
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5400 error' + error);
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        await audioRenderer.release();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_5500
       * @tc.name   : audioRenderer Combined interface
       * @tc.desc   : Test audioRenderer Combined interface - Callback
       * @tc.level  : Level 1
       */
      it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5500', 0, async (done: Function) => {
        try{
          audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
          fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
          await onWriteData(audioRenderer, fileDescriptor);
          await releaseCallback(audioRenderer);
          audioRenderer.drain((err) => {
            if (err) {
              if(err.code == errCode_6800301) {
                isPass = true;
              }
            } else {
              console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5500 fail');
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5500 error' + error);
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_5600
       * @tc.name   : audioRenderer Combined interface
       * @tc.desc   : Test audioRenderer Combined interface - Promise
       * @tc.level  : Level 1
       */
      it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5600', 0, async (done: Function) => {
        try{
          audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
          fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
          await onWriteData(audioRenderer, fileDescriptor);
          await audioRenderer.drain().then(() => {
            console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5600 fail');
          }).catch((err: BusinessError) => {
            if(err.code == errCode_6800301) {
              isPass = true;
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5600 error' + error);
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        await audioRenderer.release();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_5700
       * @tc.name   : audioRenderer Combined interface
       * @tc.desc   : Test audioRenderer Combined interface - Promise
       * @tc.level  : Level 1
       */
      it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5700', 0, async (done: Function) => {
        try{
          audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
          fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
          await onWriteData(audioRenderer, fileDescriptor);
          await startPromise(audioRenderer);
          await audioRenderer.drain().then(() => {
            isPass = true;
          }).catch((err: BusinessError) => {
            console.error('audioRenderer.drain Invoked: Error: ' + err);
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5700 error' + error);
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        await audioRenderer.release();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_5800
       * @tc.name   : audioRenderer Combined interface
       * @tc.desc   : Test audioRenderer Combined interface - Promise
       * @tc.level  : Level 1
       */
      it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5800', 0, async (done: Function) => {
        try{
          audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
          fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
          await onWriteData(audioRenderer, fileDescriptor);
          await startPromise(audioRenderer);
          await pausePromise(audioRenderer);
          await audioRenderer.drain().then(() => {
            console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5800 fail');
          }).catch((err: BusinessError) => {
            if(err.code == errCode_6800301) {
              isPass = true;
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5800 error' + error);
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        await audioRenderer.release();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_5900
       * @tc.name   : audioRenderer Combined interface
       * @tc.desc   : Test audioRenderer Combined interface - Promise
       * @tc.level  : Level 1
       */
      it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5900', 0, async (done: Function) => {
        try{
          audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
          fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
          await onWriteData(audioRenderer, fileDescriptor);
          await startPromise(audioRenderer);
          await stopPromise(audioRenderer);
          await audioRenderer.drain().then(() => {
            console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5900 fail');
          }).catch((err: BusinessError) => {
            if(err.code == errCode_6800301) {
              isPass = true;
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5900 error' + error);
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        await audioRenderer.release();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_rendererCombinedScene_Func_6000
       * @tc.name   : audioRenderer Combined interface
       * @tc.desc   : Test audioRenderer Combined interface - Promise
       * @tc.level  : Level 1
       */
      it('SUB_ArkUIX_Audio_rendererCombinedScene_Func_6000', 0, async (done: Function) => {
        try{
          audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
          fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
          await onWriteData(audioRenderer, fileDescriptor);
          await releasePromise(audioRenderer);
          await audioRenderer.drain().then(() => {
            console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_6000 fail');
          }).catch((err: BusinessError) => {
            if(err.code == errCode_6800301) {
              isPass = true;
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_6000 error' + error);
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        done();
      })
    }
  })
}