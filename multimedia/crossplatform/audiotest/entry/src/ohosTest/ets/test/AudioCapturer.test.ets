import { BusinessError } from '@ohos.base';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import fs from '@ohos.file.fs';
import audio from '@ohos.multimedia.audio';
import deviceInfo from '@ohos.deviceInfo';
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry'

const position_1000 = 1000;
const position_err = -1000;
const errCode_6800301 = 6800301;
const waitReadyMs_100 = 100;
const waitReadyMs_300 = 300;
const waitReadyMs_600 = 600;
const waitReadyMs_1000 = 1000;
const waitReadyMs_1500 = 1500;
const waitReadyMs_5000 = 5000;
let capturerOffsetStart = 0;
let isPass = false;
let isCreated = true;
let audioCapturer: audio.AudioCapturer;
let osFullNameInfo: string = deviceInfo.osFullName;
console.info('the deviceInfo osFullName is :' + osFullNameInfo);
const platform = osFullNameInfo.split(' ')[0];
console.info('the device platform is :' + platform);

let audioStreamInfo: audio.AudioStreamInfo = {
  samplingRate: audio.AudioSamplingRate.SAMPLE_RATE_44100,
  channels: audio.AudioChannel.CHANNEL_1,
  sampleFormat: audio.AudioSampleFormat.SAMPLE_FORMAT_S16LE,
  encodingType: audio.AudioEncodingType.ENCODING_TYPE_RAW
}
let audioCapturerInfo: audio.AudioCapturerInfo = {
  source: audio.SourceType.SOURCE_TYPE_MIC,
  capturerFlags: 0
}
let audioCapturerOptions: audio.AudioCapturerOptions = {
  streamInfo: audioStreamInfo,
  capturerInfo: audioCapturerInfo,
}
const delegator = abilityDelegatorRegistry.getAbilityDelegator();

class Options {
  offset?: number;
  length?: number;
}

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
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

async function startCallback(audioCapturer: audio.AudioCapturer) {
  if (!audioCapturer) {
    console.warn('Capturer:audioCapturer is null');
    return;
  }
  await (async (): Promise<boolean> => {
    return new Promise((resolve, reject) => {
      audioCapturer.start((err: BusinessError) => {
        err == undefined ? resolve(true) : reject(err)
      });
    });
  })().then(bool => {
    if (audioCapturer.state != audio.AudioState.STATE_RUNNING) {
      isPass = false;
    }
  }).catch((err: BusinessError) => {
    isPass = false;
    console.error('audioCapturer.start Invoked: Error: ' + JSON.stringify(err));
  });
  await sleep(waitReadyMs_1000);
}

async function startPromise(audioCapturer: audio.AudioCapturer) {
  if (!audioCapturer) {
    console.warn('Capturer:audioCapturer is null');
    return;
  }
  await audioCapturer.start().then(() => {
    if (audioCapturer.state != audio.AudioState.STATE_RUNNING) {
      isPass = false;
    }
  }).catch((err: BusinessError) => {
    isPass = false;
    console.error('audioCapturer.start Invoked: Error: ' + err);
  });
  await sleep(waitReadyMs_1000);
}

async function stopCallback(audioCapturer: audio.AudioCapturer) {
  if (!audioCapturer) {
    console.warn('Capturer:audioCapturer is null');
    return;
  }
  await (async (): Promise<boolean> => {
    return new Promise((resolve, reject) => {
      audioCapturer.stop((err: BusinessError) => {
        err == undefined ? resolve(true) : reject(err)
      });
    });
  })().then(bool => {
    if (audioCapturer.state != audio.AudioState.STATE_STOPPED) {
      isPass = false;
    }
  }).catch((err: BusinessError) => {
    isPass = false;
    console.error('audioCapturer.stop Invoked: Error: ' + JSON.stringify(err));
  });
  await sleep(waitReadyMs_100);
}

async function stopPromise(audioCapturer: audio.AudioCapturer) {
  if (!audioCapturer) {
    console.warn('Capturer:audioCapturer is null');
    return;
  }
  await audioCapturer.stop().then(() => {
    if (audioCapturer.state != audio.AudioState.STATE_STOPPED) {
      isPass = false;
    }
  }).catch((err: BusinessError) => {
    isPass = false;
    console.error('audioCapturer.stop Invoked: Error: ' + err);
  });
  await sleep(waitReadyMs_100);
}

async function releaseCallback(audioCapturer: audio.AudioCapturer) {
  if (!audioCapturer) {
    console.warn('Capturer:audioCapturer is null');
    return;
  }
  await (async (): Promise<boolean> => {
    return new Promise((resolve, reject) => {
      audioCapturer.release((err: BusinessError) => {
        err == undefined ? resolve(true) : reject(err)
      });
    });
  })().then(bool => {
    if (audioCapturer.state != audio.AudioState.STATE_RELEASED) {
      isPass = false;
    }
  }).catch((err: BusinessError) => {
    isPass = false;
    console.error('audioCapturer.release Invoked: Error: ' + JSON.stringify(err));
  });
  await sleep(waitReadyMs_100);
}

async function releasePromise(audioCapturer: audio.AudioCapturer) {
  if (!audioCapturer) {
    console.warn('Capturer:audioCapturer is null');
    return;
  }
  await audioCapturer.release().then(() => {
    if (audioCapturer.state != audio.AudioState.STATE_RELEASED) {
      isPass = false;
    }
  }).catch((err: BusinessError) => {
    isPass = false;
    console.error('audioCapturer.release Invoked: Error: ' + err);
  });
  await sleep(waitReadyMs_100);
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
  try {
    audioCapturer.on('readData', readDataCallback);
    await sleep(waitReadyMs_600);
  } catch (error) {
    expect().assertFail();
    console.error('Capturer:onReadData fail:' + error);
  }
}

export default function audioCapturerTest() {
  describe('audioCapturerTest', () => {
    beforeAll(async () => {
      if (platform.startsWith('OpenHarmony')) {
        await sleep(waitReadyMs_5000);
      }
      audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
      await sleep(waitReadyMs_1000);
    })
    beforeEach(async () => {
      isPass = false;
      await sleep(waitReadyMs_100);
    })
    afterEach(async () => {
      if (audioCapturer.state == audio.AudioState.STATE_RUNNING) {
        await stopPromise(audioCapturer);
        await sleep(waitReadyMs_100);
      }
    })

    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerOnReadData_Func_0100
     * @tc.name   : capturer.on('readData')
     * @tc.desc   : Test capturer.on('readData') - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_capturerOnReadData_Func_0100', 0, async (done: Function) => {
      let startOffset: number = capturerOffsetStart;
      let filesDir = getContext().filesDir + '/testCapturer.wav';
      try {
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
        audioCapturer.on('readData', readDataCallback);
        await sleep(waitReadyMs_600);
        await startPromise(audioCapturer);
        await sleep(waitReadyMs_300);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_RUNNING);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerOnReadData_Func_0100 error' + error);
      }
      done();
    })

    if (platform != 'iOS') {
      /**
       * @tc.number : SUB_ArkUIX_Audio_capturerOnMarkReach_Func_0100
       * @tc.name   : capturer.on('markReach')
       * @tc.desc   : Test capturer.on('markReach') - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_capturerOnMarkReach_Func_0100', 0, async (done: Function) => {
        try{
          audioCapturer.on('markReach', position_1000, (position) => {
            if (position == position_1000) {
              isPass = true;
            }
          });
          await onReadData(audioCapturer);
          await startPromise(audioCapturer);
          await sleep(waitReadyMs_600);
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_capturerOnMarkReach_Func_0100 error' + error);
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_capturerOnMarkReach_Func_0200
       * @tc.name   : capturer.on('markReach')
       * @tc.desc   : Test capturer.on('markReach') - Callback
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_capturerOnMarkReach_Func_0200', 0, async (done: Function) => {
        isPass = true;
        try{
          await onReadData(audioCapturer);
          audioCapturer.on('markReach', position_err, (position) => {
            isPass = false;
            console.info('SUB_ArkUIX_Audio_capturerOnMarkReach_Func_0200 fail');
          });
          await startCallback(audioCapturer);
          await sleep(waitReadyMs_600);
        }
        catch (error) {
          expect(true).assertTrue();
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_capturerOffMarkReach_Func_0100
       * @tc.name   : capturer.off('markReach')
       * @tc.desc   : Test capturer.off('markReach') - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_capturerOffMarkReach_Func_0100', 0, async (done: Function) => {
        isPass = true;
        try{
          await onReadData(audioCapturer);
          audioCapturer.on('markReach', position_1000, (position) => {
            isPass = false;
            console.error('SUB_ArkUIX_Audio_capturerOffMarkReach_Func_0100 fail');
          });
          audioCapturer.off('markReach');
          await startCallback(audioCapturer);
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_capturerOffMarkReach_Func_0100 error' + error);
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_capturerOffPeriodReach_Func_0100
       * @tc.name   : capturer.off('periodReach')
       * @tc.desc   : Test capturer.off('periodReach') - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_capturerOffPeriodReach_Func_0100', 0, async (done: Function) => {
        isPass = true;
        try{
          audioCapturer.on('periodReach', position_1000, (position) => {
            isPass = false;
            console.info('SUB_ArkUIX_Audio_capturerOffPeriodReach_Func_0100 fail');
          });
          audioCapturer.off('periodReach');
          await sleep(waitReadyMs_600);
          await startCallback(audioCapturer);
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_capturerOffPeriodReach_Func_0100 error' + error);
        }
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_capturerOnPeriodReach_Func_0100
       * @tc.name   : capturer.on('periodReach')
       * @tc.desc   : Test capturer.on('periodReach') - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_capturerOnPeriodReach_Func_0100', 0, async (done: Function) => {
        try{
          await audioCapturer.release();
          audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
          await onReadData(audioCapturer);
          audioCapturer.on('periodReach', position_1000, (position) => {
            if (position == position_1000) {
              isPass = true;
            }
          });
          await startCallback(audioCapturer);
          await sleep(waitReadyMs_600);
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_capturerOnPeriodReach_Func_0100 error' + error);
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_capturerOnPeriodReach_Func_0200
       * @tc.name   : capturer.on('periodReach')
       * @tc.desc   : Test capturer.on('periodReach') - Callback
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_capturerOnPeriodReach_Func_0200', 0, async (done: Function) => {
        isPass = true;
        try{
          await onReadData(audioCapturer);
          audioCapturer.on('periodReach', position_err, (position) => {
            isPass = false;
            console.info('SUB_ArkUIX_Audio_capturerOnPeriodReach_Func_0200 fail');
          });
        }
        catch (error) {
          expect(true).assertTrue();
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        done();
      })
    }
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerOnStateChange_Func_0100
     * @tc.name   : capturer.on('stateChange')
     * @tc.desc   : Test capturer.on('stateChange') - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_capturerOnStateChange_Func_0100', 0, async (done: Function) => {
      try{
        await onReadData(audioCapturer);
        audioCapturer.on('stateChange', (state) => {
          if(state == audio.AudioState.STATE_RUNNING) {
            isPass = true;
          }
        });
        await startCallback(audioCapturer);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerOnStateChange_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerOnStateChange_Func_0200
     * @tc.name   : capturer.on('stateChange')
     * @tc.desc   : Test capturer.on('stateChange') - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_capturerOnStateChange_Func_0200', 0, async (done: Function) => {
      try{
        await onReadData(audioCapturer);
        audioCapturer.on('stateChange', (state) => {
          if(state == audio.AudioState.STATE_STOPPED) {
            isPass = true;
          }
        });
        await startCallback(audioCapturer);
        await stopCallback(audioCapturer);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerOnStateChange_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerOnStateChange_Func_0300
     * @tc.name   : capturer.on('stateChange')
     * @tc.desc   : Test capturer.on('stateChange') - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_capturerOnStateChange_Func_0300', 0, async (done: Function) => {
      try{
        await onReadData(audioCapturer);
        audioCapturer.on('stateChange', (state) => {
          if(state == audio.AudioState.STATE_RELEASED) {
            isPass = true;
          }
        });
        await releaseCallback(audioCapturer);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerOnStateChange_Func_0300 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getCapturerInfo_Func_0100
     * @tc.name   : getCapturerInfo
     * @tc.desc   : Test getCapturerInfo - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getCapturerInfo_Func_0100', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await (async (): Promise<audio.AudioCapturerInfo> => {
          return new Promise((resolve, reject) => {
            audioCapturer.getCapturerInfo((err, capturerInfo) => {
              err == undefined ? resolve(capturerInfo) : reject(err)
            });
          });
        })().then(capturerInfo => {
          if(capturerInfo.source == audioCapturerInfo.source &&
            capturerInfo.capturerFlags == audioCapturerInfo.capturerFlags) {
            isPass = true;
          }
        }).catch((err: BusinessError) => {
          console.error('getCapturerInfo Invoked: Error: ' + JSON.stringify(err));
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getCapturerInfo_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getCapturerInfo_Func_0200
     * @tc.name   : getCapturerInfo
     * @tc.desc   : Test getCapturerInfo - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getCapturerInfo_Func_0200', 0, async (done: Function) => {
      try{
        await audioCapturer.getCapturerInfo().then((capturerInfo) => {
          if(capturerInfo.source == audioCapturerInfo.source &&
            capturerInfo.capturerFlags == audioCapturerInfo.capturerFlags) {
            isPass = true;
          }
        }).catch((err: BusinessError) => {
          expect(err).assertFail();
          console.error('getCapturerInfo Invoked: Error: ' + err);
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getCapturerInfo_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getCapturerInfoSync_Func_0300
     * @tc.name   : getCapturerInfoSync
     * @tc.desc   : Test getCapturerInfoSync - Sync
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getCapturerInfoSync_Func_0300', 0, async (done: Function) => {
      try{
        let capturerInfo: audio.AudioCapturerInfo = audioCapturer.getCapturerInfoSync();
        if(capturerInfo.source == audioCapturerInfo.source &&
          capturerInfo.capturerFlags == audioCapturerInfo.capturerFlags) {
          isPass = true;
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getCapturerInfoSync_Func_0300 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerGetStreamInfo_Func_0100
     * @tc.name   : capturer.getStreamInfo
     * @tc.desc   : Test capturer.getStreamInfo - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_capturerGetStreamInfo_Func_0100', 0, async (done: Function) => {
      try{
        await (async (): Promise<audio.AudioStreamInfo> => {
          return new Promise((resolve, reject) => {
            audioCapturer.getStreamInfo((err, streamInfo) => {
              err == undefined ? resolve(streamInfo) : reject(err)
            });
          });
        })().then(streamInfo => {
          if(streamInfo.samplingRate == audioStreamInfo.samplingRate &&
            streamInfo.channels == audioStreamInfo.channels &&
            streamInfo.sampleFormat == audioStreamInfo.sampleFormat &&
            streamInfo.encodingType == audioStreamInfo.encodingType) {
            isPass = true;
          }
        }).catch((err: BusinessError) => {
          console.error('getStreamInfo Invoked: Error: ' + JSON.stringify(err));
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerGetStreamInfo_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerGetStreamInfo_Func_0200
     * @tc.name   : capturer.getStreamInfo
     * @tc.desc   : Test capturer.getStreamInfo - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_capturerGetStreamInfo_Func_0200', 0, async (done: Function) => {
      try{
        await audioCapturer.getStreamInfo().then((streamInfo) => {
          if(streamInfo.samplingRate == audioStreamInfo.samplingRate &&
            streamInfo.channels == audioStreamInfo.channels &&
            streamInfo.sampleFormat == audioStreamInfo.sampleFormat &&
            streamInfo.encodingType == audioStreamInfo.encodingType) {
            isPass = true;
          }
        }).catch((err: BusinessError) => {
          expect(err).assertFail();
          console.error('getStreamInfo Invoked: Error: ' + err);
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerGetStreamInfo_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerGetStreamInfoSync_Func_0300
     * @tc.name   : capturer.getStreamInfoSync
     * @tc.desc   : Test capturer.getStreamInfoSync - Sync
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_capturerGetStreamInfoSync_Func_0300', 0, async (done: Function) => {
      try{
        let streamInfo: audio.AudioStreamInfo = audioCapturer.getStreamInfoSync();
        if(streamInfo.samplingRate == audioStreamInfo.samplingRate &&
          streamInfo.channels == audioStreamInfo.channels &&
          streamInfo.sampleFormat == audioStreamInfo.sampleFormat &&
          streamInfo.encodingType == audioStreamInfo.encodingType) {
          isPass = true;
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerGetStreamInfoSync_Func_0300 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerGetAudioStreamId_Func_0100
     * @tc.name   : capturer.getAudioStreamId
     * @tc.desc   : Test capturer.getAudioStreamId - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_capturerGetAudioStreamId_Func_0100', 0, async (done: Function) => {
      try{
        await (async (): Promise<number> => {
          return new Promise((resolve, reject) => {
            audioCapturer.getAudioStreamId((err, streamId) => {
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
        console.error('SUB_ArkUIX_Audio_capturerGetAudioStreamId_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerGetAudioStreamId_Func_0200
     * @tc.name   : capturer.getAudioStreamId
     * @tc.desc   : Test capturer.getAudioStreamId - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_capturerGetAudioStreamId_Func_0200', 0, async (done: Function) => {
      try{
        await audioCapturer.getAudioStreamId().then((streamId) => {
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
        console.error('SUB_ArkUIX_Audio_capturerGetAudioStreamId_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerGetAudioStreamIdSync_Func_0300
     * @tc.name   : capturer.getAudioStreamIdSync
     * @tc.desc   : Test capturer.getAudioStreamIdSync - Sync
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_capturerGetAudioStreamIdSync_Func_0300', 0, async (done: Function) => {
      try{
        let streamId: number = audioCapturer.getAudioStreamIdSync();
        if(streamId >= 0) {
          isPass = true;
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerGetAudioStreamIdSync_Func_0300 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      done();
    })

    if (platform != 'Android') {
      /**
       * @tc.number : SUB_ArkUIX_Audio_capturerGetAudioTime_Func_0100
       * @tc.name   : capturer.getAudioTime
       * @tc.desc   : Test capturer.getAudioTime - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_capturerGetAudioTime_Func_0100', 0, async (done: Function) => {
        try{
          await onReadData(audioCapturer);
          await startCallback(audioCapturer);
          await sleep(waitReadyMs_300);
          await (async (): Promise<number> => {
            return new Promise((resolve, reject) => {
              audioCapturer.getAudioTime((err, timestamp) => {
                err == undefined ? resolve(timestamp) : reject(err)
              });
            });
          })().then(timestamp => {
            if(timestamp != null) {
              isPass = true;
            }
          }).catch((err: BusinessError) => {
            console.error('getAudioTime Invoked: Error: ' + JSON.stringify(err));
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_capturerGetAudioTime_Func_0100 error' + error);
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_capturerGetAudioTime_Func_0200
       * @tc.name   : capturer.getAudioTime
       * @tc.desc   : Test capturer.getAudioTime - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_capturerGetAudioTime_Func_0200', 0, async (done: Function) => {
        try{
          await onReadData(audioCapturer);
          await startCallback(audioCapturer);
          await sleep(waitReadyMs_300);
          await audioCapturer.getAudioTime().then((timestamp: number) => {
            if(timestamp != null) {
              isPass = true;
            }
          }).catch((err: BusinessError) => {
            expect().assertFail();
            console.error('getAudioTime Invoked: Error: ' + err.code);
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_capturerGetAudioTime_Func_0200 error' + error);
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_capturerGetAudioTimeSync_Func_0300
       * @tc.name   : capturer.getAudioTimeSync
       * @tc.desc   : Test capturer.getAudioTimeSync - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_capturerGetAudioTimeSync_Func_0300', 0, async (done: Function) => {
        try{
          await onReadData(audioCapturer);
          await startCallback(audioCapturer);
          await sleep(waitReadyMs_300);
          let timestamp: number = audioCapturer.getAudioTimeSync();
          if(timestamp != null) {
            isPass = true;
          }
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_capturerGetAudioTimeSync_Func_0300 error' + error);
        }
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        done();
      })
    }
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerGetBufferSize_Func_0100
     * @tc.name   : capturer.getBufferSize
     * @tc.desc   : Test capturer.getBufferSize - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_capturerGetBufferSize_Func_0100', 0, async (done: Function) => {
      try{
        await (async (): Promise<number> => {
          return new Promise((resolve, reject) => {
            audioCapturer.getBufferSize((err, data) => {
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
        console.error('SUB_ArkUIX_Audio_capturerGetBufferSize_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerGetBufferSize_Func_0200
     * @tc.name   : capturer.getBufferSize
     * @tc.desc   : Test capturer.getBufferSize - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_capturerGetBufferSize_Func_0200', 0, async (done: Function) => {
      try{
        await audioCapturer.getBufferSize().then((data) => {
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
        console.error('SUB_ArkUIX_Audio_capturerGetBufferSize_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerGetBufferSizeSync_Func_0300
     * @tc.name   : capturer.getBufferSizeSync
     * @tc.desc   : Test capturer.getBufferSizeSync - Sync
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_capturerGetBufferSizeSync_Func_0300', 0, async (done: Function) => {
      try{
        let bufferSize = audioCapturer.getBufferSizeSync();
        if(bufferSize >= 0) {
          isPass = true;
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerGetBufferSizeSync_Func_0300 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getCurrentInputDevices_Func_0100
     * @tc.name   : getCurrentInputDevices
     * @tc.desc   : Test getCurrentInputDevices - Sync
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getCurrentInputDevices_Func_0100', 0, async (done: Function) => {
      try{
        let deviceDescriptors = audioCapturer.getCurrentInputDevices();
        if(deviceDescriptors.length != 0) {
          isPass = true;
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getCurrentInputDevices_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getCurrentAudioCapturerChangeInfo_Func_0100
     * @tc.name   : getCurrentAudioCapturerChangeInfo
     * @tc.desc   : Test getCurrentAudioCapturerChangeInfo - Sync
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getCurrentAudioCapturerChangeInfo_Func_0100', 0, async (done: Function) => {
      try{
        let info = audioCapturer.getCurrentAudioCapturerChangeInfo();
        if(info.capturerInfo.source == audioCapturerInfo.source &&
          info.capturerInfo.capturerFlags == audioCapturerInfo.capturerFlags) {
          isPass = true;
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getCurrentAudioCapturerChangeInfo_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerStart_Func_0100
     * @tc.name   : audioCapturer.start
     * @tc.desc   : Test audioCapturer.start - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_capturerStart_Func_0100', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await (async (): Promise<boolean> => {
          return new Promise((resolve, reject) => {
            audioCapturer.start((err) => {
              err == undefined ? resolve(true) : reject(err)
            });
          });
        })().then(bool => {
          isPass = true;
        }).catch((err: BusinessError) => {
          console.error('audioCapturer.start Invoked: Error: ' + JSON.stringify(err));
        });
        await sleep(waitReadyMs_300);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_RUNNING);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerStart_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioCapturer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerStart_Func_0200
     * @tc.name   : audioCapturer.start
     * @tc.desc   : Test audioCapturer.start - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_capturerStart_Func_0200', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await audioCapturer.start().then(() => {
          isPass = true;
        }).catch((err: BusinessError) => {
          console.error('audioCapturer.start Invoked: Error: ' + err);
        });
        await sleep(waitReadyMs_1000);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_RUNNING);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerStart_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioCapturer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerStop_Func_0100
     * @tc.name   : audioCapturer.stop
     * @tc.desc   : Test audioCapturer.stop - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_capturerStop_Func_0100', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await startCallback(audioCapturer);
        await sleep(waitReadyMs_300);
        await (async (): Promise<boolean> => {
          return new Promise((resolve, reject) => {
            audioCapturer.stop((err) => {
              err == undefined ? resolve(true) : reject(err)
            });
          });
        })().then(bool => {
          isPass = true;
        }).catch((err: BusinessError) => {
          console.error('audioCapturer.stop Invoked: Error: ' + JSON.stringify(err));
        });
        await sleep(waitReadyMs_300);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_STOPPED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerStop_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioCapturer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerStop_Func_0200
     * @tc.name   : audioCapturer.stop
     * @tc.desc   : Test audioCapturer.stop - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_capturerStop_Func_0200', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await startCallback(audioCapturer);
        await sleep(waitReadyMs_300);
        await audioCapturer.stop().then(() => {
          isPass = true;
        }).catch((err: BusinessError) => {
          expect(err).assertFail();
          console.error('audioCapturer.stop Invoked: Error: ' + err);
        });
        await sleep(waitReadyMs_300);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_STOPPED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerStop_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioCapturer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerRelease_Func_0100
     * @tc.name   : audioCapturer.release
     * @tc.desc   : Test audioCapturer.release - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_capturerRelease_Func_0100', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await (async (): Promise<boolean> => {
          return new Promise((resolve, reject) => {
            audioCapturer.release((err) => {
              err == undefined ? resolve(true) : reject(err)
            });
          });
        })().then(bool => {
          isPass = true;
        }).catch((err: BusinessError) => {
          console.error('audioCapturer.release Invoked: Error: ' + JSON.stringify(err));
        });
        await sleep(waitReadyMs_300);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_RELEASED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerRelease_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerRelease_Func_0200
     * @tc.name   : audioCapturer.release
     * @tc.desc   : Test audioCapturer.release - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_capturerRelease_Func_0200', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await audioCapturer.release().then(() => {
          isPass = true;
        }).catch((err: BusinessError) => {
          expect(err).assertFail();
          console.error('audioCapturer.release Invoked: Error: ' + err);
        });
        await sleep(waitReadyMs_300);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_RELEASED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerRelease_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_0100
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_0100', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await startCallback(audioCapturer);
        await sleep(waitReadyMs_1000);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_RUNNING);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_600);
      await audioCapturer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_0200
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_0200', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await (async (): Promise<boolean> => {
          return new Promise((resolve, reject) => {
            audioCapturer.stop((err: BusinessError) => {
              err == undefined ? resolve(false) : reject(err)
            });
          });
        })().then(bool => {
          console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_0200 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_300);
      expect(isPass).assertTrue();
      await audioCapturer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_0300
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_0300', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await releaseCallback(audioCapturer);
        await sleep(waitReadyMs_300);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_RELEASED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_0300 error' + error);
      }
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_0400
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_0400', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await startCallback(audioCapturer);
        await (async (): Promise<boolean> => {
          return new Promise((resolve, reject) => {
            audioCapturer.start((err: BusinessError) => {
              err == undefined ? resolve(false) : reject(err)
            });
          });
        })().then(bool => {
          console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_0400 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_0400 error' + error);
      }
      await sleep(waitReadyMs_300);
      expect(isPass).assertTrue();
      await audioCapturer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_0500
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_0500', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await startCallback(audioCapturer);
        await stopCallback(audioCapturer);
        await sleep(waitReadyMs_300);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_STOPPED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_0500 error' + error);
      }
      await audioCapturer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_0600
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_0600', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await startCallback(audioCapturer);
        await releaseCallback(audioCapturer);
        await sleep(waitReadyMs_300);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_RELEASED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_0600 error' + error);
      }
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_0700
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_0700', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await startCallback(audioCapturer);
        await stopCallback(audioCapturer);
        await onReadData(audioCapturer);
        await startCallback(audioCapturer);
        await sleep(waitReadyMs_300);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_RUNNING);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_0700 error' + error);
      }
      await audioCapturer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_0800
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_0800', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await startCallback(audioCapturer);
        await stopCallback(audioCapturer);
        if (platform.startsWith('OpenHarmony')) {
          await (async (): Promise<boolean> => {
            return new Promise((resolve, reject) => {
              audioCapturer.stop((err: BusinessError) => {
                err == undefined ? resolve(true) : reject(err)
              });
            });
          })().then(bool => {
            if (audioCapturer.state == audio.AudioState.STATE_STOPPED) {
              isPass = true;
            }
          }).catch((err: BusinessError) => {
            console.error('audioCapturer.stop Invoked: Error: ' + JSON.stringify(err));
          });
        } else {
          await (async (): Promise<boolean> => {
            return new Promise((resolve, reject) => {
              audioCapturer.stop((err: BusinessError) => {
                err == undefined ? resolve(false) : reject(err)
              });
            });
          })().then(bool => {
            console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_0800 fail');
          }).catch((err: BusinessError) => {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          });
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_0800 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioCapturer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_0900
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_0900', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await startCallback(audioCapturer);
        await stopCallback(audioCapturer);
        await releaseCallback(audioCapturer);
        await sleep(waitReadyMs_300);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_RELEASED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_0900 error' + error);
      }
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_1000
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1000', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await releaseCallback(audioCapturer);
        await (async (): Promise<boolean> => {
          return new Promise((resolve, reject) => {
            audioCapturer.start((err: BusinessError) => {
              err == undefined ? resolve(false) : reject(err)
            });
          });
        })().then(bool => {
          console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1000 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1000 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_1100
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1100', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await releaseCallback(audioCapturer);
        await (async (): Promise<boolean> => {
          return new Promise((resolve, reject) => {
            audioCapturer.stop((err: BusinessError) => {
              err == undefined ? resolve(false) : reject(err)
            });
          });
        })().then(bool => {
          console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1100 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1100 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_1200
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Callback
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1200', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await releaseCallback(audioCapturer);
        if (platform.startsWith('OpenHarmony')) {
          await (async (): Promise<boolean> => {
            return new Promise((resolve, reject) => {
              audioCapturer.release((err: BusinessError) => {
                err == undefined ? resolve(true) : reject(err)
              });
            });
          })().then(bool => {
            if (audioCapturer.state == audio.AudioState.STATE_RELEASED) {
              isPass = true;
            }
          }).catch((err: BusinessError) => {
            console.error('audioCapturer.release Invoked: Error: ' + JSON.stringify(err));
          });
        } else {
          await (async (): Promise<boolean> => {
            return new Promise((resolve, reject) => {
              audioCapturer.release((err: BusinessError) => {
                err == undefined ? resolve(false) : reject(err)
              });
            });
          })().then(bool => {
            console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1200 fail');
          }).catch((err: BusinessError) => {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          });
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1200 error' + error);
      }
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_1300
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1300', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await startPromise(audioCapturer);
        await sleep(waitReadyMs_300);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_RUNNING);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1300 error' + error);
      }
      await audioCapturer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_1400
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1400', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await audioCapturer.stop().then(() => {
          console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1400 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1400 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioCapturer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_1500
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1500', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await releasePromise(audioCapturer);
        await sleep(waitReadyMs_300);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_RELEASED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1500 error' + error);
      }
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_1600
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1600', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await startPromise(audioCapturer);
        await audioCapturer.start().then(() => {
          console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1600 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1600 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioCapturer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_1700
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1700', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await startPromise(audioCapturer);
        await stopPromise(audioCapturer);
        await sleep(waitReadyMs_300);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_STOPPED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1700 error' + error);
      }
      await audioCapturer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_1800
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1800', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await startPromise(audioCapturer);
        await releasePromise(audioCapturer);
        await sleep(waitReadyMs_300);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_RELEASED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1800 error' + error);
      }
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_1900
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1900', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await startPromise(audioCapturer);
        await stopPromise(audioCapturer);
        await onReadData(audioCapturer);
        await startPromise(audioCapturer);
        await sleep(waitReadyMs_300);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_RUNNING);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_1900 error' + error);
      }
      await audioCapturer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_2000
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_2000', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await startPromise(audioCapturer);
        await stopPromise(audioCapturer);
        if (platform.startsWith('OpenHarmony')) {
          await audioCapturer.stop().then(() => {
            if (audioCapturer.state == audio.AudioState.STATE_STOPPED) {
              isPass = true;
            }
          }).catch((err: BusinessError) => {
            console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_2000 fail');
          });
        } else {
          await audioCapturer.stop().then(() => {
            console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_2000 fail');
          }).catch((err: BusinessError) => {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          });
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_2000 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      await audioCapturer.release();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_2100
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_2100', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await startPromise(audioCapturer);
        await stopPromise(audioCapturer);
        await releasePromise(audioCapturer);
        await sleep(waitReadyMs_300);
        expect(audioCapturer.state).assertEqual(audio.AudioState.STATE_RELEASED);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_2100 error' + error);
      }
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_2200
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_2200', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await releasePromise(audioCapturer);
        await audioCapturer.start().then(() => {
          console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_2200 fail');
        }).catch((err: BusinessError) => {
          if(err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_2200 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_2300
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_2300', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await releasePromise(audioCapturer);
        await audioCapturer.stop().then(() => {
          console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_2300 fail');
        }).catch((err: BusinessError) => {
          if (err.code == errCode_6800301) {
            isPass = true;
          }
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_2300 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_capturerCombinedScene_Func_2400
     * @tc.name   : audioCapturer Combined interface
     * @tc.desc   : Test audioCapturer Combined interface - Promise
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Audio_capturerCombinedScene_Func_2400', 0, async (done: Function) => {
      try{
        audioCapturer = await createAudioCapturerPromise(audioCapturer, audioCapturerOptions);
        await onReadData(audioCapturer);
        await releasePromise(audioCapturer);
        if (platform.startsWith('OpenHarmony')) {
          await audioCapturer.release().then(() => {
            if (audioCapturer.state == audio.AudioState.STATE_RELEASED) {
              isPass = true;
            }
          }).catch((err: BusinessError) => {
            console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_2400 fail');
          });
        } else {
          await audioCapturer.release().then(() => {
            console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_2400 fail');
          }).catch((err: BusinessError) => {
            if (err.code == errCode_6800301) {
              isPass = true;
            }
          });
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_capturerCombinedScene_Func_2400 error' + error);
      }
      await sleep(waitReadyMs_600);
      expect(isPass).assertTrue();
      done();
    })
  })
}