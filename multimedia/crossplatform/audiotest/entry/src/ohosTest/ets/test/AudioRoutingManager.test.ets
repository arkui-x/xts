import { BusinessError } from '@ohos.base';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import audio from '@ohos.multimedia.audio';
import deviceInfo from '@ohos.deviceInfo';

const enum_err = -99;
const errCode_6800104 = 6800104;
const errCode_6800301 = 6800301;
const waitReadyMs_100 = 100;
const waitReadyMs_600 = 600;
const waitReadyMs_1000 = 1000;
const waitReadyMs_5000 = 5000;
let isPass = false;
let isSuccess = true;
let audioDeviceDescriptors: audio.AudioDeviceDescriptors;
let audioRenderer: audio.AudioRenderer;
let audioManager: audio.AudioManager;
let audioRoutingManager: audio.AudioRoutingManager;
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
    usage: audio.StreamUsage.STREAM_USAGE_VOICE_COMMUNICATION,
    rendererFlags: 0
  }
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

async function resetOptions() {
  audioRendererOptions = {
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
}

async function getDevicesCallback(deviceFlag: audio.DeviceFlag) {
  await (async (): Promise<audio.AudioDeviceDescriptors> => {
    return new Promise((resolve, reject) => {
      audioRoutingManager.getDevices(deviceFlag, (err: BusinessError, data: audio.AudioDeviceDescriptors) => {
        err == undefined ? resolve(data) : reject(err)
      });
    });
  })().then(data => {
    audioDeviceDescriptors = data;
  }).catch((err: BusinessError) => {
    isPass = false;
    isSuccess = false;
  });
  await sleep(waitReadyMs_100);
  if (isSuccess == false) {
    isSuccess = true;
    expect().assertFail();
  }
  return audioDeviceDescriptors;
}

async function getDevicesPromise(deviceFlag: audio.DeviceFlag) {
  await audioRoutingManager.getDevices(deviceFlag).then((data: audio.AudioDeviceDescriptors) => {
    audioDeviceDescriptors = data;
  }).catch((err: BusinessError) => {
    isPass = false;
    isSuccess = false;
    console.error('getDevices Invoked: ERROR:' + err);
  });
  await sleep(waitReadyMs_100);
  if (isSuccess == false) {
    isSuccess = true;
    expect().assertFail();
  }
  return audioDeviceDescriptors;
}

async function createAudioRenderer(audioRendererOptions: audio.AudioRendererOptions) {
  await audio.createAudioRenderer(audioRendererOptions).then((data) => {
    audioRenderer = data;
  })
  await sleep(waitReadyMs_100);
  return audioRenderer;
}

async function rendererStart(audioRenderer: audio.AudioRenderer) {
  await audioRenderer.start().then(() => {
  }).catch((err: BusinessError) => {
    console.error('audioRenderer.start Invoked: Error: ' + err);
  });
  await sleep(waitReadyMs_600);
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

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function audioRoutingManagerTest() {
  describe('audioRoutingManagerTest', () => {
    beforeAll(async () => {
      if (platform.startsWith('OpenHarmony')) {
        await sleep(waitReadyMs_5000);
      }
      audioManager = audio.getAudioManager();
      audioRoutingManager = audioManager.getRoutingManager();
      await sleep(waitReadyMs_1000);
    })
    beforeEach(async () => {
      isPass = false;
      await sleep(waitReadyMs_100);
    })
    afterEach(async () => {
      if (audioRenderer.state == audio.AudioState.STATE_RUNNING) {
        await stopPromise(audioRenderer);
      }
      await release(audioRenderer);
    })

    /**
     * @tc.number : SUB_ArkUIX_Audio_getDevices_Func_0100
     * @tc.name   : getDevices
     * @tc.desc   : Test getDevices - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getDevices_Func_0100', 0, async (done: Function) => {
      try{
        if (platform != 'iOS') {
          audioDeviceDescriptors = await getDevicesCallback(audio.DeviceFlag.OUTPUT_DEVICES_FLAG);
          expect(audioDeviceDescriptors.length != 0).assertTrue();
          for (let i = 0; i < audioDeviceDescriptors.length; i++) {
            if (audioDeviceDescriptors[i].deviceRole == audio.DeviceRole.OUTPUT_DEVICE &&
              audioDeviceDescriptors[i].deviceType == audio.DeviceType.SPEAKER) {
              isPass = true;
            }
          }
        } else {
          audioDeviceDescriptors = await getDevicesCallback(audio.DeviceFlag.INPUT_DEVICES_FLAG);
          expect(audioDeviceDescriptors.length != 0).assertTrue();
          for (let i = 0; i < audioDeviceDescriptors.length; i++) {
            if (audioDeviceDescriptors[i].deviceRole == audio.DeviceRole.INPUT_DEVICE &&
              audioDeviceDescriptors[i].deviceType == audio.DeviceType.MIC) {
              isPass = true;
            }
          }
        }
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getDevices_Func_0100 error' + error);
      }
      expect(isPass).assertTrue();
      done();
    })

    if (platform != 'iOS') {
      /**
       * @tc.number : SUB_ArkUIX_Audio_getDevices_Func_0200
       * @tc.name   : getDevices
       * @tc.desc   : Test getDevices - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getDevices_Func_0200', 0, async (done: Function) => {
        try{
          audioDeviceDescriptors = await getDevicesCallback(audio.DeviceFlag.INPUT_DEVICES_FLAG);
          expect(audioDeviceDescriptors.length != 0).assertTrue();
          for (let i = 0; i < audioDeviceDescriptors.length; i++) {
            if (audioDeviceDescriptors[i].deviceRole == audio.DeviceRole.INPUT_DEVICE &&
              audioDeviceDescriptors[i].deviceType == audio.DeviceType.MIC) {
              isPass = true;
            }
          }
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getDevices_Func_0200 error' + error);
        }
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getDevices_Func_0300
       * @tc.name   : getDevices
       * @tc.desc   : Test getDevices - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getDevices_Func_0300', 0, async (done: Function) => {
        try{
          audioDeviceDescriptors = await getDevicesCallback(audio.DeviceFlag.ALL_DEVICES_FLAG);
          expect(audioDeviceDescriptors.length != 0).assertTrue();
          for (let i = 0; i < audioDeviceDescriptors.length; i++) {
            if (audioDeviceDescriptors[i].deviceRole == audio.DeviceRole.OUTPUT_DEVICE &&
              audioDeviceDescriptors[i].deviceType == audio.DeviceType.SPEAKER) {
              isPass = true;
            }
          }
          expect(isPass).assertTrue();
          isPass = false;
          for (let i = 0; i < audioDeviceDescriptors.length; i++) {
            if (audioDeviceDescriptors[i].deviceRole == audio.DeviceRole.INPUT_DEVICE &&
              audioDeviceDescriptors[i].deviceType == audio.DeviceType.MIC) {
              isPass = true;
            }
          }
          expect(isPass).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getDevices_Func_0300 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getDevices_Func_0400
       * @tc.name   : getDevices
       * @tc.desc   : Test getDevices - Callback
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getDevices_Func_0400', 0, async (done: Function) => {
        try{
          audioRoutingManager.getDevices(enum_err, (err, data) => {
            if (err) {
              isPass = true;
            }
          });
          await sleep(waitReadyMs_600);
          expect(isPass).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getDevices_Func_0400 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getDevices_Func_0500
       * @tc.name   : getDevices
       * @tc.desc   : Test getDevices - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getDevices_Func_0500', 0, async (done: Function) => {
        try{
          audioDeviceDescriptors = await getDevicesPromise(audio.DeviceFlag.OUTPUT_DEVICES_FLAG);
          expect(audioDeviceDescriptors.length != 0).assertTrue();
          for (let i = 0; i < audioDeviceDescriptors.length; i++) {
            if (audioDeviceDescriptors[i].deviceRole == audio.DeviceRole.OUTPUT_DEVICE &&
              audioDeviceDescriptors[i].deviceType == audio.DeviceType.SPEAKER) {
              isPass = true;
            }
          }
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getDevices_Func_0500 error' + error);
        }
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getDevices_Func_0600
       * @tc.name   : getDevices
       * @tc.desc   : Test getDevices - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getDevices_Func_0600', 0, async (done: Function) => {
        try{
          audioDeviceDescriptors = await getDevicesPromise(audio.DeviceFlag.INPUT_DEVICES_FLAG);
          expect(audioDeviceDescriptors.length != 0).assertTrue();
          for (let i = 0; i < audioDeviceDescriptors.length; i++) {
            if (audioDeviceDescriptors[i].deviceRole == audio.DeviceRole.INPUT_DEVICE &&
              audioDeviceDescriptors[i].deviceType == audio.DeviceType.MIC) {
              isPass = true;
            }
          }
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getDevices_Func_0600 error' + error);
        }
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getDevices_Func_0700
       * @tc.name   : getDevices
       * @tc.desc   : Test getDevices - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getDevices_Func_0700', 0, async (done: Function) => {
        try{
          audioDeviceDescriptors = await getDevicesPromise(audio.DeviceFlag.ALL_DEVICES_FLAG);
          expect(audioDeviceDescriptors.length != 0).assertTrue();
          for (let i = 0; i < audioDeviceDescriptors.length; i++) {
            if (audioDeviceDescriptors[i].deviceRole == audio.DeviceRole.OUTPUT_DEVICE &&
              audioDeviceDescriptors[i].deviceType == audio.DeviceType.SPEAKER) {
              isPass = true;
            }
          }
          expect(isPass).assertTrue();
          isPass = false;
          for (let i = 0; i < audioDeviceDescriptors.length; i++) {
            if (audioDeviceDescriptors[i].deviceRole == audio.DeviceRole.INPUT_DEVICE &&
              audioDeviceDescriptors[i].deviceType == audio.DeviceType.MIC) {
              isPass = true;
            }
          }
          expect(isPass).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getDevices_Func_0700 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getDevices_Func_0800
       * @tc.name   : getDevices
       * @tc.desc   : Test getDevices - Promise
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getDevices_Func_0800', 0, async (done: Function) => {
        try{
          await audioRoutingManager.getDevices(enum_err).then((data) => {
          }).catch((err: BusinessError) => {
            if (err) {
              isPass = true;
            }
          });
          expect(isPass).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getDevices_Func_0800 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getDevicesSync_Func_0900
       * @tc.name   : getDevicesSync
       * @tc.desc   : Test getDevicesSync - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getDevicesSync_Func_0900', 0, async (done: Function) => {
        try{
          audioDeviceDescriptors = audioRoutingManager.getDevicesSync(audio.DeviceFlag.OUTPUT_DEVICES_FLAG);
          expect(audioDeviceDescriptors.length != 0).assertTrue();
          for (let i = 0; i < audioDeviceDescriptors.length; i++) {
            if (audioDeviceDescriptors[i].deviceRole == audio.DeviceRole.OUTPUT_DEVICE &&
              audioDeviceDescriptors[i].deviceType == audio.DeviceType.SPEAKER) {
              isPass = true;
            }
          }
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getDevicesSync_Func_0900 error' + error);
        }
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getDevicesSync_Func_1000
       * @tc.name   : getDevicesSync
       * @tc.desc   : Test getDevicesSync - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getDevicesSync_Func_1000', 0, async (done: Function) => {
        try{
          audioDeviceDescriptors = audioRoutingManager.getDevicesSync(audio.DeviceFlag.INPUT_DEVICES_FLAG);
          expect(audioDeviceDescriptors.length != 0).assertTrue();
          for (let i = 0; i < audioDeviceDescriptors.length; i++) {
            if (audioDeviceDescriptors[i].deviceRole == audio.DeviceRole.INPUT_DEVICE &&
              audioDeviceDescriptors[i].deviceType == audio.DeviceType.MIC) {
              isPass = true;
            }
          }
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getDevicesSync_Func_1000 error' + error);
        }
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getDevicesSync_Func_1100
       * @tc.name   : getDevicesSync
       * @tc.desc   : Test getDevicesSync - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getDevicesSync_Func_1100', 0, async (done: Function) => {
        try{
          audioDeviceDescriptors = audioRoutingManager.getDevicesSync(audio.DeviceFlag.ALL_DEVICES_FLAG);
          expect(audioDeviceDescriptors.length != 0).assertTrue();
          for (let i = 0; i < audioDeviceDescriptors.length; i++) {
            if (audioDeviceDescriptors[i].deviceRole == audio.DeviceRole.OUTPUT_DEVICE &&
              audioDeviceDescriptors[i].deviceType == audio.DeviceType.SPEAKER) {
              isPass = true;
            }
          }
          expect(isPass).assertTrue();
          isPass = false;
          for (let i = 0; i < audioDeviceDescriptors.length; i++) {
            if (audioDeviceDescriptors[i].deviceRole == audio.DeviceRole.INPUT_DEVICE &&
              audioDeviceDescriptors[i].deviceType == audio.DeviceType.MIC) {
              isPass = true;
            }
          }
          expect(isPass).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getDevicesSync_Func_1100 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getDevicesSync_Func_1200
       * @tc.name   : getDevicesSync
       * @tc.desc   : Test getDevicesSync - Sync
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getDevicesSync_Func_1200', 0, async (done: Function) => {
        try{
          audioDeviceDescriptors = audioRoutingManager.getDevicesSync(enum_err);
          expect().assertFail();
        }
        catch (error) {
          expect(error.code).assertEqual("6800101");
          console.error('SUB_ArkUIX_Audio_getDevicesSync_Func_1200 error' + error);
        }
        done();
      })

      if (isAndroidVersionGreater(12)) {
        /**
         * @tc.number : SUB_ArkUIX_Audio_setCommunicationDevice_Func_0100
         * @tc.name   : setCommunicationDevice
         * @tc.desc   : Test setCommunicationDevice - Callback
         * @tc.level  : Level 0
         */
        it('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0100', 0, async (done: Function) => {
          isPass = true;
          try{
            audioRenderer = await createAudioRenderer(audioRendererOptions);
            await rendererStart(audioRenderer);
            await (async (): Promise<boolean> => {
              return new Promise((resolve, reject) => {
                audioRoutingManager.setCommunicationDevice(audio.CommunicationDeviceType.SPEAKER, true,
                  (err: BusinessError) => {
                    err == undefined ? resolve(true) : reject(err)
                  });
              });
            })().catch((err: BusinessError) => {
              isPass = false;
            });
            await sleep(waitReadyMs_100);
            let isCommunicationDeviceActive = audioRoutingManager.isCommunicationDeviceActiveSync(
              audio.CommunicationDeviceType.SPEAKER);
            expect(isCommunicationDeviceActive).assertTrue();
          }
          catch (error) {
            expect(error).assertFail();
            console.error('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0100 error' + error);
          }
          expect(isPass).assertTrue();
          done();
        })
        /**
         * @tc.number : SUB_ArkUIX_Audio_setCommunicationDevice_Func_0200
         * @tc.name   : setCommunicationDevice
         * @tc.desc   : Test setCommunicationDevice - Callback
         * @tc.level  : Level 0
         */
        it('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0200', 0, async (done: Function) => {
          isPass = true;
          try{
            audioRenderer = await createAudioRenderer(audioRendererOptions);
            await rendererStart(audioRenderer);
            await (async (): Promise<boolean> => {
              return new Promise((resolve, reject) => {
                audioRoutingManager.setCommunicationDevice(audio.CommunicationDeviceType.SPEAKER, false,
                  (err: BusinessError) => {
                    err == undefined ? resolve(false) : reject(err)
                  });
              });
            })().catch((err: BusinessError) => {
              isPass = false;
            });
            await sleep(waitReadyMs_100);
            let isCommunicationDeviceActive = audioRoutingManager.isCommunicationDeviceActiveSync(
              audio.CommunicationDeviceType.SPEAKER);
            if (platform.startsWith('OpenHarmony')) {
              expect(isCommunicationDeviceActive).assertTrue();
            } else {
              expect(isCommunicationDeviceActive).assertFalse();
            }
          }
          catch (error) {
            expect(error).assertFail();
            console.error('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0200 error' + error);
          }
          expect(isPass).assertTrue();
          done();
        })
        /**
         * @tc.number : SUB_ArkUIX_Audio_setCommunicationDevice_Func_0300
         * @tc.name   : setCommunicationDevice
         * @tc.desc   : Test setCommunicationDevice - Promise
         * @tc.level  : Level 0
         */
        it('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0300', 0, async (done: Function) => {
          try{
            audioRenderer = await createAudioRenderer(audioRendererOptions);
            await rendererStart(audioRenderer);
            await audioRoutingManager.setCommunicationDevice(audio.CommunicationDeviceType.SPEAKER, true).then(() => {
            }).catch((err: BusinessError) => {
              expect().assertFail();
            });
            await sleep(waitReadyMs_100);
            let isCommunicationDeviceActive = audioRoutingManager.isCommunicationDeviceActiveSync(
              audio.CommunicationDeviceType.SPEAKER);
            expect(isCommunicationDeviceActive).assertTrue();
          }
          catch (error) {
            expect(error).assertFail();
            console.error('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0300 error' + error);
          }
          done();
        })
        /**
         * @tc.number : SUB_ArkUIX_Audio_setCommunicationDevice_Func_0400
         * @tc.name   : setCommunicationDevice
         * @tc.desc   : Test setCommunicationDevice - Promise
         * @tc.level  : Level 0
         */
        it('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0400', 0, async (done: Function) => {
          try{
            audioRenderer = await createAudioRenderer(audioRendererOptions);
            await rendererStart(audioRenderer);
            await audioRoutingManager.setCommunicationDevice(audio.CommunicationDeviceType.SPEAKER, false).then(() => {
            }).catch((err: BusinessError) => {
              expect().assertFail();
            });
            await sleep(waitReadyMs_100);
            let isCommunicationDeviceActive = audioRoutingManager.isCommunicationDeviceActiveSync(
              audio.CommunicationDeviceType.SPEAKER);
            if (platform.startsWith('OpenHarmony')) {
              expect(isCommunicationDeviceActive).assertTrue();
            } else {
              expect(isCommunicationDeviceActive).assertFalse();
            }
          }
          catch (error) {
            expect(error).assertFail();
            console.error('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0400 error' + error);
          }
          done();
        })
        /**
         * @tc.number : SUB_ArkUIX_Audio_setCommunicationDevice_Func_0500
         * @tc.name   : setCommunicationDevice
         * @tc.desc   : Test setCommunicationDevice - Callback
         * @tc.level  : Level 2
         */
        it('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0500', 0, async (done: Function) => {
          try{
            await (async (): Promise<boolean> => {
              return new Promise((resolve, reject) => {
                audioRoutingManager.setCommunicationDevice(enum_err, false, (err: BusinessError) => {
                  err == undefined ? resolve(false) : reject(err)
                });
              });
            })().catch((err: BusinessError) => {
              if (err.code == errCode_6800301) {
                isPass = true;
              }
            });
            await sleep(waitReadyMs_100);
          }
          catch (error) {
            expect(error).assertFail();
            console.error('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0500 error' + error);
          }
          expect(isPass).assertTrue();
          done();
        })
        /**
         * @tc.number : SUB_ArkUIX_Audio_setCommunicationDevice_Func_0600
         * @tc.name   : setCommunicationDevice
         * @tc.desc   : Test setCommunicationDevice - Promise
         * @tc.level  : Level 2
         */
        it('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0600', 0, async (done: Function) => {
          try{
            await audioRoutingManager.setCommunicationDevice(enum_err, false).then(() => {
              console.error('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0600 fail');
            }).catch((err: BusinessError) => {
              expect(err.code == errCode_6800301).assertTrue();
            });
          }
          catch (error) {
            expect(error).assertFail();
            console.error('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0600 error' + error);
          }
          done();
        })
        /**
         * @tc.number : SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0100
         * @tc.name   : isCommunicationDeviceActive
         * @tc.desc   : Test isCommunicationDeviceActive - Callback
         * @tc.level  : Level 0
         */
        it('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0100', 0, async (done: Function) => {
          try{
            audioRenderer = await createAudioRenderer(audioRendererOptions);
            await rendererStart(audioRenderer);
            await audioRoutingManager.setCommunicationDevice(audio.CommunicationDeviceType.SPEAKER, true);
            await sleep(waitReadyMs_600);
            await (async (): Promise<boolean> => {
              return new Promise((resolve, reject) => {
                audioRoutingManager.isCommunicationDeviceActive(audio.CommunicationDeviceType.SPEAKER, (err, value) => {
                  err == undefined ? resolve(value) : reject(err)
                });
              });
            })().then(value => {
              if (value == true) {
                isPass = true;
              }
            }).catch((err: BusinessError) => {
              console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0100 fail');
            });
            await sleep(waitReadyMs_100);
          }
          catch (error) {
            expect(error).assertFail();
            console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0100 error' + error);
          }
          expect(isPass).assertTrue();
          done();
        })
        /**
         * @tc.number : SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0200
         * @tc.name   : isCommunicationDeviceActive
         * @tc.desc   : Test isCommunicationDeviceActive - Callback
         * @tc.level  : Level 0
         */
        it('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0200', 0, async (done: Function) => {
          try{
            audioRenderer = await createAudioRenderer(audioRendererOptions);
            await rendererStart(audioRenderer);
            await audioRoutingManager.setCommunicationDevice(audio.CommunicationDeviceType.SPEAKER, false);
            await sleep(waitReadyMs_100);
            await (async (): Promise<boolean> => {
              return new Promise((resolve, reject) => {
                audioRoutingManager.isCommunicationDeviceActive(audio.CommunicationDeviceType.SPEAKER, (err, value) => {
                  err == undefined ? resolve(value) : reject(err)
                });
              });
            })().then(value => {
              if (platform.startsWith('OpenHarmony')) {
                if (value == true) {
                  isPass = true;
                }
              } else {
                if (value == false) {
                  isPass = true;
                }
              }
            }).catch((err: BusinessError) => {
              console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0200 fail');
            });
            await sleep(waitReadyMs_100);
          }
          catch (error) {
            expect(error).assertFail();
            console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0200 error' + error);
          }
          expect(isPass).assertTrue();
          done();
        })
        /**
         * @tc.number : SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0300
         * @tc.name   : isCommunicationDeviceActive
         * @tc.desc   : Test isCommunicationDeviceActive - Callback
         * @tc.level  : Level 2
         */
        it('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0300', 0, async (done: Function) => {
          try{
            await (async (): Promise<boolean> => {
              return new Promise((resolve, reject) => {
                audioRoutingManager.isCommunicationDeviceActive(enum_err, (err, value) => {
                  err == undefined ? resolve(value) : reject(err)
                });
              });
            })().catch((err: BusinessError) => {
              if (err.code == 6800104) {
                isPass = true;
              }
            });
            await sleep(waitReadyMs_100);
          }
          catch (error) {
            expect(error).assertFail();
            console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0300 error' + error);
          }
          expect(isPass).assertTrue();
          done();
        })
        /**
         * @tc.number : SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0400
         * @tc.name   : isCommunicationDeviceActive
         * @tc.desc   : Test isCommunicationDeviceActive - Promise
         * @tc.level  : Level 0
         */
        it('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0400', 0, async (done: Function) => {
          try{
            audioRenderer = await createAudioRenderer(audioRendererOptions);
            await rendererStart(audioRenderer);
            await audioRoutingManager.setCommunicationDevice(audio.CommunicationDeviceType.SPEAKER, true);
            await sleep(waitReadyMs_100);
            await audioRoutingManager.isCommunicationDeviceActive(audio.CommunicationDeviceType.SPEAKER).then((value) => {
              expect(value).assertTrue();
            }).catch((err: BusinessError) => {
              expect().assertFail();
              console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0400 fail');
            });
          }
          catch (error) {
            expect(error).assertFail();
            console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0400 error' + error);
          }
          done();
        })
        /**
         * @tc.number : SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0500
         * @tc.name   : isCommunicationDeviceActive
         * @tc.desc   : Test isCommunicationDeviceActive - Promise
         * @tc.level  : Level 0
         */
        it('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0500', 0, async (done: Function) => {
          try{
            audioRenderer = await createAudioRenderer(audioRendererOptions);
            await rendererStart(audioRenderer);
            await audioRoutingManager.setCommunicationDevice(audio.CommunicationDeviceType.SPEAKER, false);
            await sleep(waitReadyMs_100);
            await audioRoutingManager.isCommunicationDeviceActive(audio.CommunicationDeviceType.SPEAKER).then((value) => {
              if (platform.startsWith('OpenHarmony')) {
                expect(value).assertTrue();
              } else {
                expect(value).assertFalse();
              }
            }).catch((err: BusinessError) => {
              expect().assertFail();
              console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0500 fail');
            });
          }
          catch (error) {
            expect(error).assertFail();
            console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0500 error' + error);
          }
          done();
        })
        /**
         * @tc.number : SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0600
         * @tc.name   : isCommunicationDeviceActive
         * @tc.desc   : Test isCommunicationDeviceActive - Promise
         * @tc.level  : Level 2
         */
        it('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0600', 0, async (done: Function) => {
          try{
            await audioRoutingManager.isCommunicationDeviceActive(enum_err).then((value) => {
              console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0600 fail');
            }).catch((err: BusinessError) => {
              expect(err.code == 6800104).assertTrue();
            });
          }
          catch (error) {
            expect(error).assertFail();
            console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0600 error' + error);
          }
          done();
        })
        /**
         * @tc.number : SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0700
         * @tc.name   : isCommunicationDeviceActive
         * @tc.desc   : Test isCommunicationDeviceActive - Sync
         * @tc.level  : Level 0
         */
        it('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0700', 0, async (done: Function) => {
          try{
            audioRenderer = await createAudioRenderer(audioRendererOptions);
            await rendererStart(audioRenderer);
            await audioRoutingManager.setCommunicationDevice(audio.CommunicationDeviceType.SPEAKER, true);
            await sleep(waitReadyMs_100);
            let isCommunicationDeviceActive = audioRoutingManager.isCommunicationDeviceActiveSync(
              audio.CommunicationDeviceType.SPEAKER);
            expect(isCommunicationDeviceActive).assertTrue();
          }
          catch (error) {
            expect(error).assertFail();
            console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0700 error' + error);
          }
          done();
        })
        /**
         * @tc.number : SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0800
         * @tc.name   : isCommunicationDeviceActive
         * @tc.desc   : Test isCommunicationDeviceActive - Sync
         * @tc.level  : Level 0
         */
        it('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0800', 0, async (done: Function) => {
          try{
            audioRenderer = await createAudioRenderer(audioRendererOptions);
            await rendererStart(audioRenderer);
            await audioRoutingManager.setCommunicationDevice(audio.CommunicationDeviceType.SPEAKER, false);
            await sleep(waitReadyMs_100);
            let isCommunicationDeviceActive = audioRoutingManager.isCommunicationDeviceActiveSync(
              audio.CommunicationDeviceType.SPEAKER);
            if (platform.startsWith('OpenHarmony')) {
              expect(isCommunicationDeviceActive).assertTrue();
            } else {
              expect(isCommunicationDeviceActive).assertFalse();
            }
          }
          catch (error) {
            expect(error).assertFail();
            console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0800 error' + error);
          }
          done();
        })
        /**
         * @tc.number : SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0900
         * @tc.name   : isCommunicationDeviceActive
         * @tc.desc   : Test isCommunicationDeviceActive - Sync
         * @tc.level  : Level 2
         */
        it('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0900', 0, async (done: Function) => {
          try{
            let isCommunicationDeviceActive = audioRoutingManager.isCommunicationDeviceActiveSync(enum_err);
            expect().assertFail();
          }
          catch (error) {
            expect(error.code == '6800101').assertTrue();
            console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0900 error' + error);
          }
          done();
        })
      }
    } else {
      /**
       * @tc.number : SUB_ArkUIX_Audio_getDevices_Func_0200
       * @tc.name   : getDevices
       * @tc.desc   : Test getDevices - Callback
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getDevices_Func_0200', 0, async (done: Function) => {
        try {
          audioRoutingManager.getDevices(enum_err, (err, data) => {
            if (err) {
              isPass = true;
            }
          });
          await sleep(waitReadyMs_600);
          expect(isPass).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getDevices_Func_0200 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getDevices_Func_0300
       * @tc.name   : getDevices
       * @tc.desc   : Test getDevices - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getDevices_Func_0300', 0, async (done: Function) => {
        try {
          audioDeviceDescriptors = await getDevicesPromise(audio.DeviceFlag.INPUT_DEVICES_FLAG);
          expect(audioDeviceDescriptors.length != 0).assertTrue();
          for (let i = 0; i < audioDeviceDescriptors.length; i++) {
            if (audioDeviceDescriptors[i].deviceRole == audio.DeviceRole.INPUT_DEVICE &&
              audioDeviceDescriptors[i].deviceType == audio.DeviceType.MIC) {
              isPass = true;
            }
          }
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getDevices_Func_0300 error' + error);
        }
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getDevices_Func_0400
       * @tc.name   : getDevices
       * @tc.desc   : Test getDevices - Promise
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getDevices_Func_0400', 0, async (done: Function) => {
        try {
          await audioRoutingManager.getDevices(enum_err).then((data) => {
          }).catch((err: BusinessError) => {
            if (err) {
              isPass = true;
            }
          });
          expect(isPass).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getDevices_Func_0400 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getDevicesSync_Func_0500
       * @tc.name   : getDevicesSync
       * @tc.desc   : Test getDevicesSync - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getDevicesSync_Func_0500', 0, async (done: Function) => {
        try {
          audioDeviceDescriptors = audioRoutingManager.getDevicesSync(audio.DeviceFlag.INPUT_DEVICES_FLAG);
          expect(audioDeviceDescriptors.length != 0).assertTrue();
          for (let i = 0; i < audioDeviceDescriptors.length; i++) {
            if (audioDeviceDescriptors[i].deviceRole == audio.DeviceRole.INPUT_DEVICE &&
              audioDeviceDescriptors[i].deviceType == audio.DeviceType.MIC) {
              isPass = true;
            }
          }
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getDevicesSync_Func_0500 error' + error);
        }
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getDevicesSync_Func_0600
       * @tc.name   : getDevicesSync
       * @tc.desc   : Test getDevicesSync - Sync
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getDevicesSync_Func_0600', 0, async (done: Function) => {
        try {
          audioDeviceDescriptors = audioRoutingManager.getDevicesSync(enum_err);
          expect().assertFail();
        }
        catch (error) {
          expect(error.code).assertEqual("6800101");
          console.error('SUB_ArkUIX_Audio_getDevicesSync_Func_0600 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_setCommunicationDevice_Func_0100
       * @tc.name   : setCommunicationDevice
       * @tc.desc   : Test setCommunicationDevice - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0100', 0, async (done: Function) => {
        isPass = true;
        try {
          await resetOptions();
          audioRenderer = await createAudioRenderer(audioRendererOptions);
          await rendererStart(audioRenderer);
          await (async (): Promise<boolean> => {
            return new Promise((resolve, reject) => {
              audioRoutingManager.setCommunicationDevice(audio.CommunicationDeviceType.SPEAKER, true,
                (err: BusinessError) => {
                  err == undefined ? resolve(true) : reject(err)
                });
            });
          })().catch((err: BusinessError) => {
            isPass = false;
          });
          await sleep(waitReadyMs_100);
          let isCommunicationDeviceActive = audioRoutingManager.isCommunicationDeviceActiveSync(
            audio.CommunicationDeviceType.SPEAKER);
          expect(isCommunicationDeviceActive).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0100 error' + error);
        }
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_setCommunicationDevice_Func_0200
       * @tc.name   : setCommunicationDevice
       * @tc.desc   : Test setCommunicationDevice - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0200', 0, async (done: Function) => {
        isPass = true;
        try {
          audioRenderer = await createAudioRenderer(audioRendererOptions);
          await rendererStart(audioRenderer);
          await (async (): Promise<boolean> => {
            return new Promise((resolve, reject) => {
              audioRoutingManager.setCommunicationDevice(audio.CommunicationDeviceType.SPEAKER, false,
                (err: BusinessError) => {
                  err == undefined ? resolve(false) : reject(err)
                });
            });
          })().catch((err: BusinessError) => {
            isPass = false;
          });
          await sleep(waitReadyMs_100);
          let isCommunicationDeviceActive = audioRoutingManager.isCommunicationDeviceActiveSync(
            audio.CommunicationDeviceType.SPEAKER);
          expect(isCommunicationDeviceActive).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0200 error' + error);
        }
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_setCommunicationDevice_Func_0300
       * @tc.name   : setCommunicationDevice
       * @tc.desc   : Test setCommunicationDevice - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0300', 0, async (done: Function) => {
        try {
          audioRenderer = await createAudioRenderer(audioRendererOptions);
          await rendererStart(audioRenderer);
          await audioRoutingManager.setCommunicationDevice(audio.CommunicationDeviceType.SPEAKER, true).then(() => {
          }).catch((err: BusinessError) => {
            expect().assertFail();
          });
          await sleep(waitReadyMs_100);
          let isCommunicationDeviceActive = audioRoutingManager.isCommunicationDeviceActiveSync(
            audio.CommunicationDeviceType.SPEAKER);
          expect(isCommunicationDeviceActive).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0300 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_setCommunicationDevice_Func_0400
       * @tc.name   : setCommunicationDevice
       * @tc.desc   : Test setCommunicationDevice - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0400', 0, async (done: Function) => {
        try {
          audioRenderer = await createAudioRenderer(audioRendererOptions);
          await rendererStart(audioRenderer);
          await audioRoutingManager.setCommunicationDevice(audio.CommunicationDeviceType.SPEAKER, false).then(() => {
          }).catch((err: BusinessError) => {
            expect().assertFail();
          });
          await sleep(waitReadyMs_100);
          let isCommunicationDeviceActive = audioRoutingManager.isCommunicationDeviceActiveSync(
            audio.CommunicationDeviceType.SPEAKER);
          expect(isCommunicationDeviceActive).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0400 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_setCommunicationDevice_Func_0500
       * @tc.name   : setCommunicationDevice
       * @tc.desc   : Test setCommunicationDevice - Callback
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0500', 0, async (done: Function) => {
        try{
          await (async (): Promise<boolean> => {
            return new Promise((resolve, reject) => {
              audioRoutingManager.setCommunicationDevice(enum_err, false, (err: BusinessError) => {
                err == undefined ? resolve(false) : reject(err)
              });
            });
          })().catch((err: BusinessError) => {
            if (err.code == 6800301) {
              isPass = true;
            }
          });
          await sleep(waitReadyMs_100);
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0500 error' + error);
        }
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_setCommunicationDevice_Func_0600
       * @tc.name   : setCommunicationDevice
       * @tc.desc   : Test setCommunicationDevice - Promise
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0600', 0, async (done: Function) => {
        try{
          await audioRoutingManager.setCommunicationDevice(enum_err, false).then(() => {
            console.error('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0600 fail');
          }).catch((err: BusinessError) => {
            expect(err.code == 6800301).assertTrue();
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_setCommunicationDevice_Func_0600 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0100
       * @tc.name   : isCommunicationDeviceActive
       * @tc.desc   : Test isCommunicationDeviceActive - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0100', 0, async (done: Function) => {
        try {
          audioRenderer = await createAudioRenderer(audioRendererOptions);
          await rendererStart(audioRenderer);
          await audioRoutingManager.setCommunicationDevice(audio.CommunicationDeviceType.SPEAKER, true);
          await sleep(waitReadyMs_100);
          await (async (): Promise<boolean> => {
            return new Promise((resolve, reject) => {
              audioRoutingManager.isCommunicationDeviceActive(audio.CommunicationDeviceType.SPEAKER, (err, value) => {
                err == undefined ? resolve(value) : reject(err)
              });
            });
          })().then(value => {
            if (value == true) {
              isPass = true;
            }
          }).catch((err: BusinessError) => {
            console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0100 fail');
          });
          await sleep(waitReadyMs_100);
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0100 error' + error);
        }
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0200
       * @tc.name   : isCommunicationDeviceActive
       * @tc.desc   : Test isCommunicationDeviceActive - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0200', 0, async (done: Function) => {
        try {
          audioRenderer = await createAudioRenderer(audioRendererOptions);
          await rendererStart(audioRenderer);
          await audioRoutingManager.setCommunicationDevice(audio.CommunicationDeviceType.SPEAKER, false);
          await sleep(waitReadyMs_100);
          await (async (): Promise<boolean> => {
            return new Promise((resolve, reject) => {
              audioRoutingManager.isCommunicationDeviceActive(audio.CommunicationDeviceType.SPEAKER, (err, value) => {
                err == undefined ? resolve(value) : reject(err)
              });
            });
          })().then(value => {
            if (value == true) {
              isPass = true;
            }
          }).catch((err: BusinessError) => {
            console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0100 fail');
          });
          await sleep(waitReadyMs_100);
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0200 error' + error);
        }
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0300
       * @tc.name   : isCommunicationDeviceActive
       * @tc.desc   : Test isCommunicationDeviceActive - Callback
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0300', 0, async (done: Function) => {
        try{
          await (async (): Promise<boolean> => {
            return new Promise((resolve, reject) => {
              audioRoutingManager.isCommunicationDeviceActive(enum_err, (err, value) => {
                err == undefined ? resolve(value) : reject(err)
              });
            });
          })().catch((err: BusinessError) => {
            if (err.code == errCode_6800104) {
              isPass = true;
            }
          });
          await sleep(waitReadyMs_100);
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0300 error' + error);
        }
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0400
       * @tc.name   : isCommunicationDeviceActive
       * @tc.desc   : Test isCommunicationDeviceActive - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0400', 0, async (done: Function) => {
        try {
          audioRenderer = await createAudioRenderer(audioRendererOptions);
          await rendererStart(audioRenderer);
          await audioRoutingManager.setCommunicationDevice(audio.CommunicationDeviceType.SPEAKER, true);
          await sleep(waitReadyMs_100);
          await audioRoutingManager.isCommunicationDeviceActive(audio.CommunicationDeviceType.SPEAKER).then((value) => {
            expect(value).assertTrue();
          }).catch((err: BusinessError) => {
            expect().assertFail();
            console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0400 fail');
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0400 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0500
       * @tc.name   : isCommunicationDeviceActive
       * @tc.desc   : Test isCommunicationDeviceActive - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0500', 0, async (done: Function) => {
        try {
          audioRenderer = await createAudioRenderer(audioRendererOptions);
          await rendererStart(audioRenderer);
          await audioRoutingManager.setCommunicationDevice(audio.CommunicationDeviceType.SPEAKER, false);
          await sleep(waitReadyMs_100);
          await audioRoutingManager.isCommunicationDeviceActive(audio.CommunicationDeviceType.SPEAKER).then((value) => {
            expect(value).assertTrue();
          }).catch((err: BusinessError) => {
            expect().assertFail();
            console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0500 fail');
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0500 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0600
       * @tc.name   : isCommunicationDeviceActive
       * @tc.desc   : Test isCommunicationDeviceActive - Promise
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0600', 0, async (done: Function) => {
        try{
          await audioRoutingManager.isCommunicationDeviceActive(enum_err).then((value) => {
            console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0600 fail');
          }).catch((err: BusinessError) => {
            expect(err.code == errCode_6800104).assertTrue();
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0600 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0700
       * @tc.name   : isCommunicationDeviceActiveSync
       * @tc.desc   : Test isCommunicationDeviceActiveSync - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0700', 0, async (done: Function) => {
        try {
          audioRenderer = await createAudioRenderer(audioRendererOptions);
          await rendererStart(audioRenderer);
          await audioRoutingManager.setCommunicationDevice(audio.CommunicationDeviceType.SPEAKER, true);
          await sleep(waitReadyMs_100);
          let isCommunicationDeviceActive = audioRoutingManager.isCommunicationDeviceActiveSync(
            audio.CommunicationDeviceType.SPEAKER);
          expect(isCommunicationDeviceActive).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0700 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0800
       * @tc.name   : isCommunicationDeviceActiveSync
       * @tc.desc   : Test isCommunicationDeviceActiveSync - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0800', 0, async (done: Function) => {
        try {
          audioRenderer = await createAudioRenderer(audioRendererOptions);
          await rendererStart(audioRenderer);
          await audioRoutingManager.setCommunicationDevice(audio.CommunicationDeviceType.SPEAKER, false);
          await sleep(waitReadyMs_100);
          let isCommunicationDeviceActive = audioRoutingManager.isCommunicationDeviceActiveSync(
            audio.CommunicationDeviceType.SPEAKER);
          expect(isCommunicationDeviceActive).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0800 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0900
       * @tc.name   : isCommunicationDeviceActive
       * @tc.desc   : Test isCommunicationDeviceActive - Sync
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0900', 0, async (done: Function) => {
        try{
          let isCommunicationDeviceActive = audioRoutingManager.isCommunicationDeviceActiveSync(enum_err);
          expect().assertFail();
        }
        catch (error) {
          expect(error.code == '6800101').assertTrue();
          console.error('SUB_ArkUIX_Audio_isCommunicationDeviceActive_Func_0900 error' + error);
        }
        done();
      })
    }
  })
}