import { BusinessError } from '@ohos.base';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import fs from '@ohos.file.fs';
import audio from '@ohos.multimedia.audio';
import deviceInfo from '@ohos.deviceInfo';
import resourceManager from '@ohos.resourceManager';

const errCode_6800103 = 6800103;
const errCode_6800301 = 6800301;
const waitReadyMs_100 = 100;
const waitReadyMs_300 = 300;
const waitReadyMs_600 = 600;
const waitReadyMs_1000 = 1000;
let isPass = false;
let isCreated = true;
let audioRenderer: audio.AudioRenderer;

let osFullNameInfo: string = deviceInfo.osFullName;
console.info('the deviceInfo osFullName is :' + osFullNameInfo);
let platform = osFullNameInfo.split(' ')[0];

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

async function pauseCallback(audioRenderer: audio.AudioRenderer) {
  if (!audioRenderer) {
    console.warn('Renderer:audioRenderer is null');
    return;
  }
  await (async (): Promise<boolean> => {
    return new Promise((resolve, reject) => {
      audioRenderer.pause((err: BusinessError) => {
        err == undefined ? resolve(true) : reject(err)
      });
    });
  })().then(bool => {
    if(audioRenderer.state != audio.AudioState.STATE_PAUSED) {
      isPass = false;
    }
  }).catch((err: BusinessError) => {
    isPass = false;
    console.error('audioRenderer.pause Invoked: Error: ' + JSON.stringify(err));
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

async function stopCallback(audioRenderer: audio.AudioRenderer) {
  if (!audioRenderer) {
    console.warn('Renderer:audioRenderer is null');
    return;
  }
  await (async (): Promise<boolean> => {
    return new Promise((resolve, reject) => {
      audioRenderer.stop((err: BusinessError) => {
        err == undefined ? resolve(true) : reject(err)
      });
    });
  })().then(bool => {
    if(audioRenderer.state != audio.AudioState.STATE_STOPPED) {
      isPass = false;
    }
  }).catch((err: BusinessError) => {
    isPass = false;
    console.error('audioRenderer.stop Invoked: Error: ' + JSON.stringify(err));
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

async function releaseCallback(audioRenderer: audio.AudioRenderer) {
  if (!audioRenderer) {
    console.warn('Renderer:audioRenderer is null');
    return;
  }
  await (async (): Promise<boolean> => {
    return new Promise((resolve, reject) => {
      audioRenderer.release((err: BusinessError) => {
        err == undefined ? resolve(true) : reject(err)
      });
    });
  })().then(bool => {
    if(audioRenderer.state != audio.AudioState.STATE_RELEASED) {
      isPass = false;
    }
  }).catch((err: BusinessError) => {
    isPass = false;
    console.error('audioRenderer.release Invoked: Error: ' + JSON.stringify(err));
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
    await sleep(waitReadyMs_1000);
  } catch (error) {
    expect().assertFail();
    console.error('Renderer:onWriteData fail:' + error);
  }
}

let fileDescriptor: resourceManager.RawFileDescriptor;

export default function audioRendererCombinedTest() {
  describe('audioRendererCombinedTest', () => {
    afterEach(async () => {
      await sleep(waitReadyMs_300);
    })

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
      await release(audioRenderer);
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
        await (async (): Promise<boolean> => {
          return new Promise((resolve, reject) => {
            audioRenderer.pause((err: BusinessError) => {
              err == undefined ? resolve(false) : reject(err)
            });
          });
        })().then(bool => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0200 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      await release(audioRenderer);
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
        await (async (): Promise<boolean> => {
          return new Promise((resolve, reject) => {
            audioRenderer.stop((err: BusinessError) => {
              err == undefined ? resolve(false) : reject(err)
            });
          });
        })().then(bool => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0300 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0300 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      await release(audioRenderer);
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
      await release(audioRenderer);
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
        await sleep(waitReadyMs_600);
        await (async (): Promise<boolean> => {
          return new Promise((resolve, reject) => {
            audioRenderer.start((err: BusinessError) => {
              err == undefined ? resolve(false) : reject(err)
            });
          });
        })().then(bool => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0600 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_0600 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      await release(audioRenderer);
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
      await release(audioRenderer);
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
      await release(audioRenderer);
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
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      await release(audioRenderer);
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
      await release(audioRenderer);
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
        await (async (): Promise<boolean> => {
          return new Promise((resolve, reject) => {
            audioRenderer.pause((err: BusinessError) => {
              err == undefined ? resolve(false) : reject(err)
            });
          });
        })().then(bool => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1200 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1200 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      await release(audioRenderer);
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
      await release(audioRenderer);
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
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      await release(audioRenderer);
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
        await sleep(waitReadyMs_100);
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
      await release(audioRenderer);
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
        await (async (): Promise<boolean> => {
          return new Promise((resolve, reject) => {
            audioRenderer.pause((err: BusinessError) => {
              err == undefined ? resolve(false) : reject(err)
            });
          });
        })().then(bool => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1700 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1700 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      await release(audioRenderer);
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
          await (async (): Promise<boolean> => {
            return new Promise((resolve, reject) => {
              audioRenderer.stop((err: BusinessError) => {
                err == undefined ? resolve(true) : reject(err)
              });
            });
          })().then(bool => {
            if (audioRenderer.state == audio.AudioState.STATE_STOPPED) {
              isPass = true;
            }
          }).catch((err: BusinessError) => {
            console.error('audioRenderer.stop Invoked: Error: ' + JSON.stringify(err));
          });
        } else {
          await (async (): Promise<boolean> => {
            return new Promise((resolve, reject) => {
              audioRenderer.stop((err: BusinessError) => {
                err == undefined ? resolve(false) : reject(err)
              });
            });
          })().then(bool => {
            console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1800 fail');
          }).catch((err: BusinessError) => {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          });
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_1800 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      await release(audioRenderer);
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
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      await release(audioRenderer);
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
        await sleep(waitReadyMs_100);
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
        await (async (): Promise<boolean> => {
          return new Promise((resolve, reject) => {
            audioRenderer.start((err: BusinessError) => {
              err == undefined ? resolve(false) : reject(err)
            });
          });
        })().then(bool => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2100 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2100 error' + error);
      }
      await sleep(waitReadyMs_100);
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
        await (async (): Promise<boolean> => {
          return new Promise((resolve, reject) => {
            audioRenderer.pause((err: BusinessError) => {
              err == undefined ? resolve(false) : reject(err)
            });
          });
        })().then(bool => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2200 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2200 error' + error);
      }
      await sleep(waitReadyMs_100);
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
        await (async (): Promise<boolean> => {
          return new Promise((resolve, reject) => {
            audioRenderer.stop((err: BusinessError) => {
              err == undefined ? resolve(false) : reject(err)
            });
          });
        })().then(bool => {
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2300 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2300 error' + error);
      }
      await sleep(waitReadyMs_100);
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
          await (async (): Promise<boolean> => {
            return new Promise((resolve, reject) => {
              audioRenderer.release((err: BusinessError) => {
                err == undefined ? resolve(true) : reject(err)
              });
            });
          })().then(bool => {
            if (audioRenderer.state == audio.AudioState.STATE_RELEASED) {
              isPass = true;
            }
          }).catch((err: BusinessError) => {
            console.error('audioRenderer.release Invoked: Error: ' + JSON.stringify(err));
          });
        } else {
          await (async (): Promise<boolean> => {
            return new Promise((resolve, reject) => {
              audioRenderer.release((err: BusinessError) => {
                err == undefined ? resolve(false) : reject(err)
              });
            });
          })().then(bool => {
            console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2500 fail');
          }).catch((err: BusinessError) => {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          });
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_2500 error' + error);
      }
      await sleep(waitReadyMs_100);
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
      await release(audioRenderer);
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
        await audioRenderer.pause().then(() => {
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
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      await release(audioRenderer);
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
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      await release(audioRenderer);
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
      await release(audioRenderer);
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
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      await release(audioRenderer);
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
      await release(audioRenderer);
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
      await release(audioRenderer);
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
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      await release(audioRenderer);
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
      await release(audioRenderer);
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
        await audioRenderer.pause().then(() => {
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
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      await release(audioRenderer);
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
      await release(audioRenderer);
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
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      await release(audioRenderer);
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
      await release(audioRenderer);
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
        await audioRenderer.pause().then(() => {
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
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      await release(audioRenderer);
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
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      await release(audioRenderer);
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
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      await release(audioRenderer);
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
        await sleep(waitReadyMs_100);
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
      await sleep(waitReadyMs_100);
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
        await audioRenderer.pause().then(() => {
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
      await sleep(waitReadyMs_100);
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
      await sleep(waitReadyMs_100);
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
      await sleep(waitReadyMs_100);
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
          await (async (): Promise<boolean> => {
            return new Promise((resolve, reject) => {
              audioRenderer.drain((err: BusinessError) => {
                err == undefined ? resolve(false) : reject(err)
              });
            });
          })().then(bool => {
            console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5100 fail');
          }).catch((err: BusinessError) => {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5100 error' + error);
        }
        await sleep(waitReadyMs_100);
        expect(isPass).assertTrue();
        await release(audioRenderer);
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
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5200 error' + error);
        }
        await sleep(waitReadyMs_100);
        expect(isPass).assertTrue();
        await release(audioRenderer);
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
          await (async (): Promise<boolean> => {
            return new Promise((resolve, reject) => {
              audioRenderer.drain((err: BusinessError) => {
                err == undefined ? resolve(false) : reject(err)
              });
            });
          })().then(bool => {
            console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5300 fail');
          }).catch((err: BusinessError) => {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5300 error' + error);
        }
        await sleep(waitReadyMs_100);
        expect(isPass).assertTrue();
        await release(audioRenderer);
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
          await (async (): Promise<boolean> => {
            return new Promise((resolve, reject) => {
              audioRenderer.drain((err: BusinessError) => {
                err == undefined ? resolve(false) : reject(err)
              });
            });
          })().then(bool => {
            console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5400 fail');
          }).catch((err: BusinessError) => {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5400 error' + error);
        }
        await sleep(waitReadyMs_100);
        expect(isPass).assertTrue();
        await release(audioRenderer);
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
          await (async (): Promise<boolean> => {
            return new Promise((resolve, reject) => {
              audioRenderer.drain((err: BusinessError) => {
                err == undefined ? resolve(false) : reject(err)
              });
            });
          })().then(bool => {
            console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5500 fail');
          }).catch((err: BusinessError) => {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_rendererCombinedScene_Func_5500 error' + error);
        }
        await sleep(waitReadyMs_100);
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
        await sleep(waitReadyMs_100);
        expect(isPass).assertTrue();
        await release(audioRenderer);
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
        await sleep(waitReadyMs_100);
        expect(isPass).assertTrue();
        await release(audioRenderer);
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
        await sleep(waitReadyMs_100);
        expect(isPass).assertTrue();
        await release(audioRenderer);
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
        await sleep(waitReadyMs_100);
        expect(isPass).assertTrue();
        await release(audioRenderer);
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
        await sleep(waitReadyMs_100);
        expect(isPass).assertTrue();
        done();
      })
    }
  })
}