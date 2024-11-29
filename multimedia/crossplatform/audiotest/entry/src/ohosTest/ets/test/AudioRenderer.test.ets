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
const errCode_6800104 = 6800104;
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
    return androidVersion >= num ? true : false
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
  await (async (): Promise<boolean> => {
    return new Promise((resolve, reject) => {
      audioRenderer.start((err: BusinessError) => {
        err == undefined ? resolve(true) : reject(err)
      });
    });
  })().then(bool => {
    if(audioRenderer.state != audio.AudioState.STATE_RUNNING) {
      isPass = false;
    }
  }).catch((err: BusinessError) => {
    isPass = false;
    console.error('audioRenderer.start Invoked: Error: ' + JSON.stringify(err));
  });
  await sleep(waitReadyMs_100);
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
    afterEach(async () => {
      await sleep(waitReadyMs_300);
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
        await sleep(waitReadyMs_600);
        await startPromise(audioRenderer);
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_RUNNING);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererOnWriteData_Func_0100 error' + error);
      }
      await release(audioRenderer);
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
        await startPromise(audioRenderer);
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
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
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
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
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
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
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
          await (async (): Promise<audio.AudioRendererInfo> => {
            return new Promise((resolve, reject) => {
              audioRenderer.getRendererInfo((err, rendererInfo) => {
                err == undefined ? resolve(rendererInfo) : reject(err)
              });
            });
          })().then(rendererInfo => {
            if(rendererInfo.usage == audioRendererOptions.rendererInfo.usage &&
              rendererInfo.rendererFlags == audioRendererOptions.rendererInfo.rendererFlags) {
              isPass = true;
            }
          }).catch((err: BusinessError) => {
            console.error('getRendererInfo Invoked: Error: ' + JSON.stringify(err));
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getRendererInfo_Func_0100 error' + error);
        }
        await sleep(waitReadyMs_100);
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
        await (async (): Promise<audio.AudioStreamInfo> => {
          return new Promise((resolve, reject) => {
            audioRenderer.getStreamInfo((err, streamInfo) => {
              err == undefined ? resolve(streamInfo) : reject(err)
            });
          });
        })().then(streamInfo => {
          if(streamInfo.samplingRate == audioRendererOptions.streamInfo.samplingRate &&
            streamInfo.channels == audioRendererOptions.streamInfo.channels &&
            streamInfo.sampleFormat == audioRendererOptions.streamInfo.sampleFormat &&
            streamInfo.encodingType == audioRendererOptions.streamInfo.encodingType) {
            isPass = true;
          }
        }).catch((err: BusinessError) => {
          console.error('getStreamInfo Invoked: Error: ' + JSON.stringify(err));
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getStreamInfo_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_100);
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
        await (async (): Promise<number> => {
          return new Promise((resolve, reject) => {
            audioRenderer.getAudioStreamId((err, streamId) => {
              err == undefined ? resolve(streamId) : reject(err)
            });
          });
        })().then(streamId => {
          if(streamId >= 0) {
            isPass = true;
          }
        }).catch((err: BusinessError) => {
          console.error('getAudioStreamId Invoked: Error: ' + JSON.stringify(err));
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getAudioStreamId_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_100);
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
        await (async (): Promise<number> => {
          return new Promise((resolve, reject) => {
            audioRenderer.getAudioTime((err, timestamp) => {
              err == undefined ? resolve(timestamp) : reject(err)
            });
          });
        })().then(timestamp => {
          if(timestamp >= 0) {
            isPass = true;
          }
        }).catch((err: BusinessError) => {
          console.error('getAudioTime Invoked: Error: ' + JSON.stringify(err));
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getAudioTime_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_100);
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
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
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
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
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
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        await (async (): Promise<number> => {
          return new Promise((resolve, reject) => {
            audioRenderer.getBufferSize((err, data) => {
              err == undefined ? resolve(data) : reject(err)
            });
          });
        })().then(data => {
          if(data >= 0) {
            isPass = true;
          }
        }).catch((err: BusinessError) => {
          console.error('getBufferSize Invoked: Error: ' + JSON.stringify(err));
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getBufferSize_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_100);
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
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
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
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
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
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
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
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await (async (): Promise<boolean> => {
          return new Promise((resolve, reject) => {
            audioRenderer.setVolume(volume_normal, (err) => {
              err == undefined ? resolve(true) : reject(err)
            });
          });
        })().then(boolean => {
          isPass = true;
        }).catch((err: BusinessError) => {
          console.error('setVolume Invoked: Error: ' + JSON.stringify(err));
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
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
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
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await (async (): Promise<boolean> => {
          return new Promise((resolve, reject) => {
            audioRenderer.setVolume(volume_err, (err) => {
              err == undefined ? resolve(false) : reject(err)
            });
          });
        })().then(boolean => {
          console.error('setVolume Invoked: fail');
        }).catch((err: BusinessError) => {
          if(err.code == errCode_6800104) {
            isPass = true;
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
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
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
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
        await onWriteData(audioRenderer, fileDescriptor);
        await startCallback(audioRenderer);
        await (async (): Promise<boolean> => {
          return new Promise((resolve, reject) => {
            audioRenderer.setVolume(volume_2, (err) => {
              err == undefined ? resolve(false) : reject(err)
            });
          });
        })().then(boolean => {
          console.error('setVolume Invoked: fail');
        }).catch((err: BusinessError) => {
          if(err.code == errCode_6800104) {
            isPass = true;
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
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
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
        audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
        await (async (): Promise<number> => {
          return new Promise((resolve, reject) => {
            audioRenderer.getMinStreamVolume((err, minVolume) => {
              err == undefined ? resolve(minVolume) : reject(err)
            });
          });
        })().then(minVolume => {
          if(minVolume >= 0 && minVolume <= 1) {
            isPass = true;
          }
        }).catch((err: BusinessError) => {
          console.error('getMinStreamVolume Invoked: Error: ' + JSON.stringify(err));
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
        await (async (): Promise<number> => {
          return new Promise((resolve, reject) => {
            audioRenderer.getMaxStreamVolume((err, maxVolume) => {
              err == undefined ? resolve(maxVolume) : reject(err)
            });
          });
        })().then(maxVolume => {
          if(maxVolume >= 0 && maxVolume <= 1) {
            isPass = true;
          }
        }).catch((err: BusinessError) => {
          console.error('getMaxStreamVolume Invoked: Error: ' + JSON.stringify(err));
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
        await (async (): Promise<audio.AudioDeviceDescriptors> => {
          return new Promise((resolve, reject) => {
            audioRenderer.getCurrentOutputDevices((err, deviceDescriptors) => {
              err == undefined ? resolve(deviceDescriptors) : reject(err)
            });
          });
        })().then(deviceDescriptors => {
          if(deviceDescriptors.length != 0) {
            isPass = true;
          }
        }).catch((err: BusinessError) => {
          console.error('getCurrentOutputDevices Invoked: Error: ' + JSON.stringify(err));
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
      await release(audioRenderer);
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
        await (async (): Promise<boolean> => {
          return new Promise((resolve, reject) => {
            audioRenderer.start((err) => {
              err == undefined ? resolve(true) : reject(err)
            });
          });
        })().then(bool => {
          isPass = true;
        }).catch((err: BusinessError) => {
          console.error('audioRenderer.start Invoked: Error: ' + JSON.stringify(err));
        });
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_RUNNING);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererStart_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      await release(audioRenderer);
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
      await release(audioRenderer);
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
        await startPromise(audioRenderer);
        await (async (): Promise<boolean> => {
          return new Promise((resolve, reject) => {
            audioRenderer.pause((err) => {
              err == undefined ? resolve(true) : reject(err)
            });
          });
        })().then(bool => {
          isPass = true;
        }).catch((err: BusinessError) => {
          console.error('audioRenderer.pause Invoked: Error: ' + JSON.stringify(err));
        });
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_PAUSED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererPause_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      await release(audioRenderer);
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
        await audioRenderer.pause().then(() => {
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
      await release(audioRenderer);
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
      await release(audioRenderer);
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
        await startPromise(audioRenderer);
        await (async (): Promise<boolean> => {
          return new Promise((resolve, reject) => {
            audioRenderer.stop((err) => {
              err == undefined ? resolve(true) : reject(err)
            });
          });
        })().then(bool => {
          isPass = true;
        }).catch((err: BusinessError) => {
          console.error('audioRenderer.stop Invoked: Error: ' + JSON.stringify(err));
        });
        await sleep(waitReadyMs_300);
        expect(audioRenderer.state).assertEqual(audio.AudioState.STATE_STOPPED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererStop_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_400);
      expect(isPass).assertTrue();
      await release(audioRenderer);
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
      await release(audioRenderer);
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
        await (async (): Promise<boolean> => {
          return new Promise((resolve, reject) => {
            audioRenderer.release((err) => {
              err == undefined ? resolve(true) : reject(err)
            });
          });
        })().then(bool => {
          isPass = true;
        }).catch((err: BusinessError) => {
          console.error('audioRenderer.release Invoked: Error: ' + JSON.stringify(err));
        });
        await sleep(waitReadyMs_300);
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
          audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
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
          audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
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
          audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
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
          audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
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
          audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
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
          audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
          await (async (): Promise<number> => {
            return new Promise((resolve, reject) => {
              audioRenderer.getUnderflowCount((err, underflowCount) => {
                err == undefined ? resolve(underflowCount) : reject(err)
              });
            });
          })().then(underflowCount => {
            if(underflowCount >= 0) {
              isPass = true ;
            }
          }).catch((err: BusinessError) => {
            console.error('getUnderflowCount Invoked: Error: ' + JSON.stringify(err));
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getUnderflowCount_Func_0100 error' + error);
        }
        await sleep(waitReadyMs_100);
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
          await (async (): Promise<boolean> => {
            return new Promise((resolve, reject) => {
              audioRenderer.setInterruptMode(audio.InterruptMode.SHARE_MODE, (err) => {
                err == undefined ? resolve(true) : reject(err)
              });
            });
          })().then(bool => {
            isPass = true;
          }).catch((err: BusinessError) => {
            console.error('setInterruptMode Invoked: Error: ' + JSON.stringify(err));
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_setInterruptMode_Func_0100 error' + error);
        }
        await sleep(waitReadyMs_100);
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
          await (async (): Promise<boolean> => {
            return new Promise((resolve, reject) => {
              audioRenderer.setInterruptMode(audio.InterruptMode.INDEPENDENT_MODE, (err) => {
                err == undefined ? resolve(true) : reject(err)
              });
            });
          })().then(bool => {
            isPass = true;
          }).catch((err: BusinessError) => {
            console.error('setInterruptMode Invoked: Error: ' + JSON.stringify(err));
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_setInterruptMode_Func_0300 error' + error);
        }
        await sleep(waitReadyMs_100);
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
          audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
          fileDescriptor = await getContext().resourceManager.getRawFd('test.wav');
          await onWriteData(audioRenderer, fileDescriptor);
          await startCallback(audioRenderer);
          await sleep(waitReadyMs_300);
          await (async (): Promise<boolean> => {
            return new Promise((resolve, reject) => {
              audioRenderer.drain((err) => {
                err == undefined ? resolve(true) : reject(err)
              });
            });
          })().then(bool => {
            isPass = true;
          }).catch((err: BusinessError) => {
            console.error('audioRenderer.drain Invoked: Error: ' + JSON.stringify(err));
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
          audioRenderer = await createAudioRendererPromise(audioRenderer, audioRendererOptions);
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
  })
}