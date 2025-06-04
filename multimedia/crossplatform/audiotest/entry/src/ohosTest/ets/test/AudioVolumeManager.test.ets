import { BusinessError } from '@ohos.base';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import audio from '@ohos.multimedia.audio';
import deviceInfo from '@ohos.deviceInfo';

const enum_err = -99;
const volume_7 = 7;
const volume_12 = 12;
const volume_15 = 15;
const errCode_6800101 = 6800101;
const errCode_6800301 = 6800301;
const waitReadyMs_100 = 100;
const waitReadyMs_300 = 300;
const waitReadyMs_1000 = 1000;
let isPass = false;
let isSuccess = true;
let getSystemVolumeInDb_ErrorCode: number|null;
let audioManager: audio.AudioManager;
let audioVolumeManager: audio.AudioVolumeManager;
let audioVolumeGroupManager: audio.AudioVolumeGroupManager;
let volume: number;
let minVolume: number;
let maxVolume: number;
let isMute: boolean|null;
let systemVolumeInDb: number|null;
let osFullNameInfo: string = deviceInfo.osFullName;
console.info('the deviceInfo osFullName is :' + osFullNameInfo);
let platform = osFullNameInfo.split(' ')[0];
console.info('the device platform is :' + platform);

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

async function getVolumeCallback(volumeType: audio.AudioVolumeType) {
  if(audioVolumeGroupManager == null) {
    isPass = false;
    isSuccess = false;
    return -1;
  }
  await (async (): Promise<number> => {
    return new Promise((resolve, reject) => {
      audioVolumeGroupManager.getVolume(volumeType, (err, value) => {
        err == undefined ? resolve(value) : reject(err)
      });
    });
  })().then(value => {
    volume = value;
  }).catch((err: BusinessError) => {
    isPass = false;
    isSuccess = false;
  });
  await sleep(waitReadyMs_100);
  if (isSuccess == false) {
    isSuccess = true;
    expect().assertFail();
  }
  return volume;
}

async function getVolumePromise(volumeType: audio.AudioVolumeType) {
  if(audioVolumeGroupManager == null) {
    isPass = false;
    isSuccess = false;
    return -1;
  }
  await audioVolumeGroupManager.getVolume(volumeType).then((value) => {
    volume = value;
  }).catch((err: BusinessError) => {
    isPass = false;
    isSuccess = false;
    console.error('audioVolumeGroupManager.getVolume Invoked: Error: ' + err);
  })
  await sleep(waitReadyMs_100);
  if (isSuccess == false) {
    isSuccess = true;
    expect().assertFail();
  }
  return volume;
}

async function getMinVolumeCallback(volumeType: audio.AudioVolumeType) {
  if(audioVolumeGroupManager == null) {
    isPass = false;
    isSuccess = false;
    return -1;
  }
  await (async (): Promise<number> => {
    return new Promise((resolve, reject) => {
      audioVolumeGroupManager.getMinVolume(volumeType, (err, value) => {
        err == undefined ? resolve(value) : reject(err)
      });
    });
  })().then(value => {
    minVolume = value;
  }).catch((err: BusinessError) => {
    isPass = false;
    isSuccess = false;
  });
  await sleep(waitReadyMs_100);
  if (isSuccess == false) {
    isSuccess = true;
    expect().assertFail();
  }
  return minVolume;
}

async function getMinVolumePromise(volumeType: audio.AudioVolumeType) {
  if(audioVolumeGroupManager == null) {
    isPass = false;
    isSuccess = false;
    return -1;
  }
  await audioVolumeGroupManager.getMinVolume(volumeType).then((value: number) => {
    minVolume = value;
  }).catch((err: BusinessError) => {
    isPass = false;
    isSuccess = false;
    console.error('audioVolumeGroupManager.getMinVolume Invoked: Error: ' + err);
  })
  await sleep(waitReadyMs_100);
  if (isSuccess == false) {
    isSuccess = true;
    expect().assertFail();
  }
  return minVolume;
}

async function getMaxVolumeCallback(volumeType: audio.AudioVolumeType) {
  if(audioVolumeGroupManager == null) {
    isPass = false;
    isSuccess = false;
    return -1;
  }
  await (async (): Promise<number> => {
    return new Promise((resolve, reject) => {
      audioVolumeGroupManager.getMaxVolume(volumeType, (err, value) => {
        err == undefined ? resolve(value) : reject(err)
      });
    });
  })().then(value => {
    maxVolume = value;
  }).catch((err: BusinessError) => {
    isPass = false;
    isSuccess = false;
  });
  await sleep(waitReadyMs_100);
  if (isSuccess == false) {
    isSuccess = true;
    expect().assertFail();
  }
  return maxVolume;
}

async function getMaxVolumePromise(volumeType: audio.AudioVolumeType) {
  if(audioVolumeGroupManager == null) {
    isPass = false;
    isSuccess = false;
    return -1;
  }
  await audioVolumeGroupManager.getMaxVolume(volumeType).then((value) => {
    maxVolume = value;
  }).catch((err: BusinessError) => {
    isPass = false;
    isSuccess = false;
    console.error('audioVolumeGroupManager.getMaxVolume Invoked: Error: ' + err);
  })
  await sleep(waitReadyMs_100);
  if (isSuccess == false) {
    isSuccess = true;
    expect().assertFail();
  }
  return maxVolume;
}

async function isMuteCallback(volumeType: audio.AudioVolumeType) {
  if(audioVolumeGroupManager == null) {
    isPass = false;
    isSuccess = false;
    return null;
  }
  await (async (): Promise<boolean> => {
    return new Promise((resolve, reject) => {
      audioVolumeGroupManager.isMute(volumeType, (err, value) => {
        err == undefined ? resolve(value) : reject(err)
      });
    });
  })().then(value => {
    isMute = value;
  }).catch((err: BusinessError) => {
    isPass = false;
    isSuccess = false;
  });
  await sleep(waitReadyMs_100);
  if (isSuccess == false) {
    isSuccess = true;
    expect().assertFail();
  }
  return isMute;
}

async function isMutePromise(volumeType: audio.AudioVolumeType) {
  if(audioVolumeGroupManager == null) {
    isPass = false;
    isSuccess = false;
    return null;
  }
  await audioVolumeGroupManager.isMute(volumeType).then((value) => {
    isMute = value;
  }).catch((err: BusinessError) => {
    isPass = false;
    isSuccess = false;
    console.error('audioVolumeGroupManager.isMute Invoked: Error: ' + err);
  })
  await sleep(waitReadyMs_100);
  if (isSuccess == false) {
    isSuccess = true;
    expect().assertFail();
  }
  return isMute;
}

async function getSystemVolumeInDbCallback(volumeType: audio.AudioVolumeType, deviceType: audio.DeviceType) {
  if(audioVolumeGroupManager == null) {
    isPass = false;
    isSuccess = false;
    return null;
  }
  await (async (): Promise<number> => {
    return new Promise((resolve, reject) => {
      audioVolumeGroupManager.getSystemVolumeInDb(volumeType, 7, deviceType, (err, dB) => {
        err == undefined ? resolve(dB) : reject(err)
      });
    });
  })().then(dB => {
    systemVolumeInDb = dB;
    getSystemVolumeInDb_ErrorCode = null;
  }).catch((err: BusinessError) => {
    systemVolumeInDb = null;
    getSystemVolumeInDb_ErrorCode = err.code;
  });
  await sleep(waitReadyMs_100);
  if (isSuccess == false) {
    isSuccess = true;
    expect().assertFail();
  }
  return systemVolumeInDb;
}

async function getSystemVolumeInDbPromise(volumeType: audio.AudioVolumeType, deviceType: audio.DeviceType) {
  if(audioVolumeGroupManager == null) {
    isPass = false;
    isSuccess = false;
    return null;
  }
  await audioVolumeGroupManager.getSystemVolumeInDb(volumeType, 7, deviceType).then((dB) => {
    systemVolumeInDb = dB;
    getSystemVolumeInDb_ErrorCode = null;
  }).catch((err: BusinessError) => {
    systemVolumeInDb = null;
    getSystemVolumeInDb_ErrorCode = err.code;
  })
  await sleep(waitReadyMs_100);
  if (isSuccess == false) {
    isSuccess = true;
    expect().assertFail();
  }
  return systemVolumeInDb;
}

async function getSystemVolumeInDbSync(volumeType: audio.AudioVolumeType, deviceType: audio.DeviceType) {
  if(audioVolumeGroupManager == null) {
    isPass = false;
    isSuccess = false;
    return null;
  }
  try {
    systemVolumeInDb = audioVolumeGroupManager.getSystemVolumeInDbSync(volumeType, 7, deviceType);
    getSystemVolumeInDb_ErrorCode = null;
  }
  catch (error) {
    systemVolumeInDb = null;
    getSystemVolumeInDb_ErrorCode = Number(error.code);
  }
  await sleep(waitReadyMs_100);
  if (isSuccess == false) {
    isSuccess = true;
    expect().assertFail();
  }
  return systemVolumeInDb;
}

export default function audioVolumeManagerTest() {
  describe('audioVolumeManagerTest', () => {
    beforeAll(async() => {
      audioManager = audio.getAudioManager();
      audioVolumeManager = audioManager.getVolumeManager();
      audioVolumeGroupManager = audioVolumeManager.getVolumeGroupManagerSync(audio.DEFAULT_VOLUME_GROUP_ID);
      await sleep(waitReadyMs_1000);
    })
    beforeEach(async() => {
      isPass = false;
      await sleep(waitReadyMs_100);
    })

    /**
     * @tc.number : SUB_ArkUIX_Audio_getVolumeGroupManager_Func_0100
     * @tc.name   : getVolumeGroupManager
     * @tc.desc   : Test getVolumeGroupManager - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getVolumeGroupManager_Func_0100', 0, async (done: Function) => {
      try{
        await (async (): Promise<audio.AudioVolumeGroupManager> => {
          return new Promise((resolve, reject) => {
            audioVolumeManager.getVolumeGroupManager(audio.DEFAULT_VOLUME_GROUP_ID, (err, value) => {
              err == undefined ? resolve(value) : reject(err)
            });
          });
        })().then(value => {
          if(value != null) {
            isPass = true;
          }
        }).catch((err: BusinessError) => {
          console.error('SUB_ArkUIX_Audio_getVolumeGroupManager_Func_0100 fail');
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getVolumeGroupManager_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_300);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getVolumeGroupManager_Func_0200
     * @tc.name   : getVolumeGroupManager
     * @tc.desc   : Test getVolumeGroupManager - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getVolumeGroupManager_Func_0200', 0, async (done: Function) => {
      try{
        await audioVolumeManager.getVolumeGroupManager(audio.DEFAULT_VOLUME_GROUP_ID).then((value) => {
          isPass = true;
          expect(value != null).assertTrue();
        }).catch ((err: BusinessError) => {
          console.error('SUB_ArkUIX_Audio_getVolumeGroupManager_Func_0200 fail');
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getVolumeGroupManager_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_300);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getVolumeGroupManager_Func_0300
     * @tc.name   : getVolumeGroupManagerSync
     * @tc.desc   : Test getVolumeGroupManagerSync - Sync
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getVolumeGroupManager_Func_0300', 0, async (done: Function) => {
      try{
        audioVolumeGroupManager = audioVolumeManager.getVolumeGroupManagerSync(audio.DEFAULT_VOLUME_GROUP_ID);
        expect(audioVolumeGroupManager != null).assertTrue();
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getVolumeGroupManager_Func_0300 error' + error);
      }
      done();
    })

    if (platform != 'iOS') {
      /**
       * @tc.number : SUB_ArkUIX_Audio_getRingerMode_Func_0100
       * @tc.name   : getRingerMode
       * @tc.desc   : Test getRingerMode - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getRingerMode_Func_0100', 0, async (done: Function) => {
        try{
          await (async (): Promise<audio.AudioRingMode> => {
            return new Promise((resolve, reject) => {
              audioVolumeGroupManager.getRingerMode((err, value) => {
                err == undefined ? resolve(value) : reject(err)
              });
            });
          })().then(value => {
            if(value == audio.AudioRingMode.RINGER_MODE_SILENT ||
              value == audio.AudioRingMode.RINGER_MODE_VIBRATE || value == audio.AudioRingMode.RINGER_MODE_NORMAL) {
              isPass = true;
            }
          }).catch((err: BusinessError) => {
            console.error('SUB_ArkUIX_Audio_getRingerMode_Func_0100 fail');
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getRingerMode_Func_0100 error' + error);
        }
        await sleep(waitReadyMs_300);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getRingerMode_Func_0200
       * @tc.name   : getRingerMode
       * @tc.desc   : Test getRingerMode - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getRingerMode_Func_0200', 0, async (done: Function) => {
        try{
          await audioVolumeGroupManager.getRingerMode().then((value) => {
            isPass = true;
            expect(value == audio.AudioRingMode.RINGER_MODE_SILENT ||
              value == audio.AudioRingMode.RINGER_MODE_VIBRATE ||
              value == audio.AudioRingMode.RINGER_MODE_NORMAL).assertTrue();
          }).catch ((err: BusinessError) => {
            console.error('SUB_ArkUIX_Audio_getRingerMode_Func_0200 fail');
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getRingerMode_Func_0200 error' + error);
        }
        await sleep(waitReadyMs_300);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getRingerMode_Func_0300
       * @tc.name   : getRingerModeSync
       * @tc.desc   : Test getRingerModeSync - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getRingerMode_Func_0300', 0, async (done: Function) => {
        try{
          let AudioRingMode = audioVolumeGroupManager.getRingerModeSync();
          expect(AudioRingMode == audio.AudioRingMode.RINGER_MODE_SILENT ||
            AudioRingMode == audio.AudioRingMode.RINGER_MODE_VIBRATE ||
            AudioRingMode == audio.AudioRingMode.RINGER_MODE_NORMAL).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getRingerMode_Func_0300 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_isMicrophoneMute_Func_0100
       * @tc.name   : isMicrophoneMute
       * @tc.desc   : Test isMicrophoneMute - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_isMicrophoneMute_Func_0100', 0, async (done: Function) => {
        try{
          await (async (): Promise<boolean> => {
            return new Promise((resolve, reject) => {
              audioVolumeGroupManager.isMicrophoneMute((err, value) => {
                err == undefined ? resolve(value) : reject(err)
              });
            });
          })().then(value => {
            if(value == false) {
              isPass = true;
            }
          }).catch((err: BusinessError) => {
            console.error('SUB_ArkUIX_Audio_isMicrophoneMute_Func_0100 fail');
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_isMicrophoneMute_Func_0100 error' + error);
        }
        await sleep(waitReadyMs_300);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_isMicrophoneMute_Func_0200
       * @tc.name   : isMicrophoneMute
       * @tc.desc   : Test isMicrophoneMute - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_isMicrophoneMute_Func_0200', 0, async (done: Function) => {
        try{
          await audioVolumeGroupManager.isMicrophoneMute().then((value) => {
            isPass = true;
            expect(value).assertFalse();
          }).catch ((err: BusinessError) => {
            console.error('SUB_ArkUIX_Audio_isMicrophoneMute_Func_0200 fail');
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_isMicrophoneMute_Func_0200 error' + error);
        }
        await sleep(waitReadyMs_300);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_isMicrophoneMute_Func_0300
       * @tc.name   : isMicrophoneMuteSync
       * @tc.desc   : Test isMicrophoneMuteSync - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_isMicrophoneMute_Func_0300', 0, async (done: Function) => {
        try{
          let isMicrophoneMute = audioVolumeGroupManager.isMicrophoneMuteSync();
          expect(isMicrophoneMute).assertFalse();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_isMicrophoneMute_Func_0300 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_isVolumeUnadjustable_Func_0100
       * @tc.name   : isVolumeUnadjustable
       * @tc.desc   : Test isVolumeUnadjustable - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_isVolumeUnadjustable_Func_0100', 0, async (done: Function) => {
        try{
          let isVolumeUnadjustable = audioVolumeGroupManager.isVolumeUnadjustable();
          expect(isVolumeUnadjustable).assertFalse();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_isVolumeUnadjustable_Func_0100 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_isMute_Func_0100
       * @tc.name   : isMute
       * @tc.desc   : Test isMute - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_isMute_Func_0100', 0, async (done: Function) => {
        try{
          isMute = await isMuteCallback(audio.AudioVolumeType.VOICE_CALL);
          expect(isMute != null).assertTrue();

          isMute = await isMuteCallback(audio.AudioVolumeType.RINGTONE);
          expect(isMute != null).assertTrue();

          isMute = await isMuteCallback(audio.AudioVolumeType.MEDIA);
          expect(isMute != null).assertTrue();

          isMute = await isMuteCallback(audio.AudioVolumeType.ALARM);
          expect(isMute != null).assertTrue();

          isMute = await isMuteCallback(audio.AudioVolumeType.ACCESSIBILITY);
          expect(isMute != null).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_isMute_Func_0100 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_isMute_Func_0200
       * @tc.name   : isMute
       * @tc.desc   : Test isMute - Callback
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_isMute_Func_0200', 0, async (done: Function) => {
        try{
          await (async (): Promise<boolean> => {
            return new Promise((resolve, reject) => {
              audioVolumeGroupManager.isMute(enum_err, (err, value) => {
                err == undefined ? resolve(value) : reject(err)
              });
            });
          })().then(value => {
            console.error('SUB_ArkUIX_Audio_isMute_Func_0200 fail');
          }).catch((err: BusinessError) => {
            if (err) {
              isPass = true;
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_isMute_Func_0200 error' + error);
        }
        await sleep(waitReadyMs_300);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_isMute_Func_0300
       * @tc.name   : isMute
       * @tc.desc   : Test isMute - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_isMute_Func_0300', 0, async (done: Function) => {
        try{
          isMute = await isMutePromise(audio.AudioVolumeType.VOICE_CALL);
          expect(isMute != null).assertTrue();

          isMute = await isMutePromise(audio.AudioVolumeType.RINGTONE);
          expect(isMute != null).assertTrue();

          isMute = await isMutePromise(audio.AudioVolumeType.MEDIA);
          expect(isMute != null).assertTrue();

          isMute = await isMutePromise(audio.AudioVolumeType.ALARM);
          expect(isMute != null).assertTrue();

          isMute = await isMutePromise(audio.AudioVolumeType.ACCESSIBILITY);
          expect(isMute != null).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_isMute_Func_0300 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_isMute_Func_0400
       * @tc.name   : isMute
       * @tc.desc   : Test isMute - Promise
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_isMute_Func_0400', 0, async (done: Function) => {
        try{
          await audioVolumeGroupManager.isMute(enum_err).then((value) => {
            console.error('SUB_ArkUIX_Audio_isMute_Func_0400 fail');
          }).catch((err: BusinessError) => {
            if (err) {
              isPass = true;
            }
          })
          expect(isPass).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_isMute_Func_0400 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_isMuteSync_Func_0500
       * @tc.name   : isMuteSync
       * @tc.desc   : Test isMuteSync - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_isMuteSync_Func_0500', 0, async (done: Function) => {
        try{
          isMute = audioVolumeGroupManager.isMuteSync(audio.AudioVolumeType.VOICE_CALL);
          expect(isMute != null).assertTrue();

          isMute = audioVolumeGroupManager.isMuteSync(audio.AudioVolumeType.RINGTONE);
          expect(isMute != null).assertTrue();

          isMute = audioVolumeGroupManager.isMuteSync(audio.AudioVolumeType.MEDIA);
          expect(isMute != null).assertTrue();

          isMute = audioVolumeGroupManager.isMuteSync(audio.AudioVolumeType.ALARM);
          expect(isMute != null).assertTrue();

          isMute = audioVolumeGroupManager.isMuteSync(audio.AudioVolumeType.ACCESSIBILITY);
          expect(isMute != null).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_isMuteSync_Func_0500 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_isMuteSync_Func_0600
       * @tc.name   : isMuteSync
       * @tc.desc   : Test isMuteSync - Sync
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_isMuteSync_Func_0600', 0, async (done: Function) => {
        try{
          isMute = audioVolumeGroupManager.isMuteSync(enum_err);
        }
        catch (error) {
          expect(error.code == errCode_6800101).assertTrue();
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0100
       * @tc.name   : getSystemVolumeInDb
       * @tc.desc   : Test getSystemVolumeInDb.volumeType - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0100', 0, async (done: Function) => {
        try{
          systemVolumeInDb = await getSystemVolumeInDbCallback(audio.AudioVolumeType.VOICE_CALL, audio.DeviceType.SPEAKER);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbCallback(audio.AudioVolumeType.RINGTONE, audio.DeviceType.SPEAKER);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbCallback(audio.AudioVolumeType.MEDIA, audio.DeviceType.SPEAKER);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbCallback(audio.AudioVolumeType.ALARM, audio.DeviceType.SPEAKER);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbCallback(audio.AudioVolumeType.ACCESSIBILITY, audio.DeviceType.SPEAKER);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0100 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0200
       * @tc.name   : getSystemVolumeInDb
       * @tc.desc   : Test getSystemVolumeInDb.volumeType - Callback
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0200', 0, async (done: Function) => {
        try{
          systemVolumeInDb = await getSystemVolumeInDbCallback(enum_err, audio.DeviceType.SPEAKER);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb == 0 : false)).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0200 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0300
       * @tc.name   : getSystemVolumeInDb
       * @tc.desc   : Test getSystemVolumeInDb.volumeType - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0300', 0, async (done: Function) => {
        try{
          systemVolumeInDb = await getSystemVolumeInDbPromise(audio.AudioVolumeType.VOICE_CALL, audio.DeviceType.SPEAKER);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbPromise(audio.AudioVolumeType.RINGTONE, audio.DeviceType.SPEAKER);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbPromise(audio.AudioVolumeType.MEDIA, audio.DeviceType.SPEAKER);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbPromise(audio.AudioVolumeType.ALARM, audio.DeviceType.SPEAKER);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbPromise(audio.AudioVolumeType.ACCESSIBILITY, audio.DeviceType.SPEAKER);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0300 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0400
       * @tc.name   : getSystemVolumeInDb
       * @tc.desc   : Test getSystemVolumeInDb.volumeType - Promise
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0400', 0, async (done: Function) => {
        try{
          systemVolumeInDb = await getSystemVolumeInDbPromise(enum_err, audio.DeviceType.SPEAKER);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb == 0 : false)).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0400 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0500
       * @tc.name   : getSystemVolumeInDb
       * @tc.desc   : Test getSystemVolumeInDb.device - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0500', 0, async (done: Function) => {
        try{
          systemVolumeInDb = await getSystemVolumeInDbCallback(audio.AudioVolumeType.MEDIA, audio.DeviceType.INVALID);
          expect((getSystemVolumeInDb_ErrorCode != null ? getSystemVolumeInDb_ErrorCode == errCode_6800101 : false) ||
            (getSystemVolumeInDb_ErrorCode != null ? getSystemVolumeInDb_ErrorCode != errCode_6800101 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbCallback(audio.AudioVolumeType.MEDIA, audio.DeviceType.EARPIECE);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbCallback(audio.AudioVolumeType.MEDIA, audio.DeviceType.SPEAKER);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbCallback(audio.AudioVolumeType.MEDIA, audio.DeviceType.WIRED_HEADSET);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbCallback(audio.AudioVolumeType.MEDIA, audio.DeviceType.WIRED_HEADPHONES);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbCallback(audio.AudioVolumeType.MEDIA, audio.DeviceType.BLUETOOTH_SCO);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbCallback(audio.AudioVolumeType.MEDIA, audio.DeviceType.BLUETOOTH_A2DP);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbCallback(audio.AudioVolumeType.MEDIA, audio.DeviceType.MIC);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbCallback(audio.AudioVolumeType.MEDIA, audio.DeviceType.USB_HEADSET);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0500 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0600
       * @tc.name   : getSystemVolumeInDb
       * @tc.desc   : Test getSystemVolumeInDb.device - Callback
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0600', 0, async (done: Function) => {
        try{
          systemVolumeInDb = await getSystemVolumeInDbCallback(audio.AudioVolumeType.MEDIA, enum_err);
          expect((getSystemVolumeInDb_ErrorCode != null ? getSystemVolumeInDb_ErrorCode == errCode_6800101 : false) ||
            (systemVolumeInDb != null ? getSystemVolumeInDb_ErrorCode != errCode_6800101 : false)).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0600 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0700
       * @tc.name   : getSystemVolumeInDb
       * @tc.desc   : Test getSystemVolumeInDb.device - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0700', 0, async (done: Function) => {
        try{
          systemVolumeInDb = await getSystemVolumeInDbPromise(audio.AudioVolumeType.MEDIA, audio.DeviceType.INVALID);
          expect((getSystemVolumeInDb_ErrorCode != null ? getSystemVolumeInDb_ErrorCode == errCode_6800101 : false) ||
            (getSystemVolumeInDb_ErrorCode != null ? getSystemVolumeInDb_ErrorCode != errCode_6800101 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbPromise(audio.AudioVolumeType.MEDIA, audio.DeviceType.EARPIECE);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbPromise(audio.AudioVolumeType.MEDIA, audio.DeviceType.SPEAKER);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbPromise(audio.AudioVolumeType.MEDIA, audio.DeviceType.WIRED_HEADSET);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbPromise(audio.AudioVolumeType.MEDIA, audio.DeviceType.WIRED_HEADPHONES);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbPromise(audio.AudioVolumeType.MEDIA, audio.DeviceType.BLUETOOTH_SCO);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbPromise(audio.AudioVolumeType.MEDIA, audio.DeviceType.BLUETOOTH_A2DP);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbPromise(audio.AudioVolumeType.MEDIA, audio.DeviceType.MIC);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbPromise(audio.AudioVolumeType.MEDIA, audio.DeviceType.USB_HEADSET);
          expect(getSystemVolumeInDb_ErrorCode != null ||
            (systemVolumeInDb != null ? systemVolumeInDb >= 0 : false)).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0700 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0800
       * @tc.name   : getSystemVolumeInDb
       * @tc.desc   : Test getSystemVolumeInDb.device - Promise
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0800', 0, async (done: Function) => {
        try{
          systemVolumeInDb = await getSystemVolumeInDbPromise(audio.AudioVolumeType.MEDIA, enum_err);
          expect((getSystemVolumeInDb_ErrorCode != null ? getSystemVolumeInDb_ErrorCode == errCode_6800101 : false) ||
            (getSystemVolumeInDb_ErrorCode != null ? getSystemVolumeInDb_ErrorCode != errCode_6800101 : false)).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0800 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0900
       * @tc.name   : getSystemVolumeInDb
       * @tc.desc   : Test getSystemVolumeInDb.volumeLevel - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0900', 0, async (done: Function) => {
        try{
          await (async (): Promise<audio.DeviceType> => {
            return new Promise((resolve, reject) => {
              audioVolumeGroupManager.getSystemVolumeInDb(audio.AudioVolumeType.MEDIA, volume_12, audio.DeviceType.SPEAKER,
                (err, dB) => {
                  err == undefined ? resolve(dB) : reject(err)
                });
            });
          })().then(dB => {
            if (dB >= 0) {
              isPass = true;
            }
          }).catch((err: BusinessError) => {
            isPass = true;
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_0900 error' + error);
        }
        await sleep(waitReadyMs_300);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_1000
       * @tc.name   : getSystemVolumeInDb
       * @tc.desc   : Test getSystemVolumeInDb.volumeLevel - Callback
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_1000', 0, async (done: Function) => {
        try{
          await (async (): Promise<audio.DeviceType> => {
            return new Promise((resolve, reject) => {
              audioVolumeGroupManager.getSystemVolumeInDb(audio.AudioVolumeType.MEDIA, -1, audio.DeviceType.SPEAKER,
                (err, dB) => {
                  err == undefined ? resolve(dB) : reject(err)
                });
            });
          })().then(dB => {
            if (dB >= 0) {
              isPass = true;
            }
          }).catch((err: BusinessError) => {
            isPass = true;
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_1000 error' + error);
        }
        await sleep(waitReadyMs_300);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_1100
       * @tc.name   : getSystemVolumeInDb
       * @tc.desc   : Test getSystemVolumeInDb.volumeLevel - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_1100', 0, async (done: Function) => {
        try{
          await audioVolumeGroupManager.getSystemVolumeInDb(audio.AudioVolumeType.MEDIA, volume_12, audio.DeviceType.SPEAKER)
            .then((dB) => {
              if (dB >= 0) {
                isPass = true;
              }
            }).catch((err: BusinessError) => {
              isPass = true;
              expect(true).assertTrue();
            })
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_1100 error' + error);
        }
        await sleep(waitReadyMs_300);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_1200
       * @tc.name   : getSystemVolumeInDb
       * @tc.desc   : Test getSystemVolumeInDb.volumeLevel - Promise
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_1200', 0, async (done: Function) => {
        try{
          await audioVolumeGroupManager.getSystemVolumeInDb(audio.AudioVolumeType.MEDIA, -1, audio.DeviceType.SPEAKER)
            .then((dB) => {
              expect(dB >= 0).assertTrue();
            }).catch((err: BusinessError) => {
              if (platform.startsWith('OpenHarmony')) {
                expect(err.code == 6800101).assertTrue();
              } else {
                expect(true).assertTrue();
              }
            })
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getSystemVolumeInDb_Func_1200 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getSystemVolumeInDbSync_Func_1300
       * @tc.name   : getSystemVolumeInDbSync
       * @tc.desc   : Test getSystemVolumeInDbSync.volumeType - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getSystemVolumeInDbSync_Func_1300', 0, async (done: Function) => {
        try{
          systemVolumeInDb = await getSystemVolumeInDbSync(audio.AudioVolumeType.VOICE_CALL, audio.DeviceType.SPEAKER);
          expect((systemVolumeInDb != null ? systemVolumeInDb >= 0 : false) ||
            (systemVolumeInDb != null ? systemVolumeInDb < 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbSync(audio.AudioVolumeType.RINGTONE, audio.DeviceType.SPEAKER);
          expect((systemVolumeInDb != null ? systemVolumeInDb >= 0 : false) ||
            (systemVolumeInDb != null ? systemVolumeInDb < 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbSync(audio.AudioVolumeType.MEDIA, audio.DeviceType.SPEAKER);
          expect((systemVolumeInDb != null ? systemVolumeInDb >= 0 : false) ||
            (systemVolumeInDb != null ? systemVolumeInDb < 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbSync(audio.AudioVolumeType.ALARM, audio.DeviceType.SPEAKER);
          expect((systemVolumeInDb != null ? systemVolumeInDb >= 0 : false) ||
            (systemVolumeInDb != null ? systemVolumeInDb < 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbSync(audio.AudioVolumeType.ACCESSIBILITY, audio.DeviceType.SPEAKER);
          expect((systemVolumeInDb != null ? systemVolumeInDb >= 0 : false) ||
            (systemVolumeInDb != null ? systemVolumeInDb < 0 : false)).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getSystemVolumeInDbSync_Func_1300 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getSystemVolumeInDbSync_Func_1400
       * @tc.name   : getSystemVolumeInDbSync
       * @tc.desc   : Test getSystemVolumeInDbSync.volumeType - Sync
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getSystemVolumeInDbSync_Func_1400', 0, async (done: Function) => {
        try{
          systemVolumeInDb = await getSystemVolumeInDbSync(enum_err, audio.DeviceType.SPEAKER);
          expect((systemVolumeInDb != null ? systemVolumeInDb <= 0 : false) ||
            (getSystemVolumeInDb_ErrorCode != null ? getSystemVolumeInDb_ErrorCode == errCode_6800101 : false)).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getSystemVolumeInDbSync_Func_1400 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getSystemVolumeInDbSync_Func_1500
       * @tc.name   : getSystemVolumeInDbSync
       * @tc.desc   : Test getSystemVolumeInDbSync.device - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getSystemVolumeInDbSync_Func_1500', 0, async (done: Function) => {
        try{
          systemVolumeInDb = await getSystemVolumeInDbSync(audio.AudioVolumeType.MEDIA, audio.DeviceType.INVALID);
          expect((getSystemVolumeInDb_ErrorCode != null ? getSystemVolumeInDb_ErrorCode == errCode_6800101 : false) ||
            (systemVolumeInDb != null ? systemVolumeInDb < 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbSync(audio.AudioVolumeType.MEDIA, audio.DeviceType.EARPIECE);
          expect((systemVolumeInDb != null ? systemVolumeInDb >= 0 : false) ||
            (systemVolumeInDb != null ? systemVolumeInDb < 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbSync(audio.AudioVolumeType.MEDIA, audio.DeviceType.SPEAKER);
          expect((systemVolumeInDb != null ? systemVolumeInDb >= 0 : false) ||
            (systemVolumeInDb != null ? systemVolumeInDb < 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbSync(audio.AudioVolumeType.MEDIA, audio.DeviceType.WIRED_HEADSET);
          expect((systemVolumeInDb != null ? systemVolumeInDb >= 0 : false) ||
            (systemVolumeInDb != null ? systemVolumeInDb < 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbSync(audio.AudioVolumeType.MEDIA, audio.DeviceType.WIRED_HEADPHONES);
          expect((systemVolumeInDb != null ? systemVolumeInDb >= 0 : false) ||
            (systemVolumeInDb != null ? systemVolumeInDb < 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbSync(audio.AudioVolumeType.MEDIA, audio.DeviceType.BLUETOOTH_SCO);
          expect((systemVolumeInDb != null ? systemVolumeInDb >= 0 : false) ||
            (systemVolumeInDb != null ? systemVolumeInDb < 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbSync(audio.AudioVolumeType.MEDIA, audio.DeviceType.BLUETOOTH_A2DP);
          expect((systemVolumeInDb != null ? systemVolumeInDb >= 0 : false) ||
            (systemVolumeInDb != null ? systemVolumeInDb < 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbSync(audio.AudioVolumeType.MEDIA, audio.DeviceType.MIC);
          expect((systemVolumeInDb != null ? systemVolumeInDb >= 0 : false) ||
            (systemVolumeInDb != null ? systemVolumeInDb < 0 : false)).assertTrue();

          systemVolumeInDb = await getSystemVolumeInDbSync(audio.AudioVolumeType.MEDIA, audio.DeviceType.USB_HEADSET);
          expect((systemVolumeInDb != null ? systemVolumeInDb >= 0 : false) ||
            (systemVolumeInDb != null ? systemVolumeInDb < 0 : false)).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getSystemVolumeInDbSync_Func_1500 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getSystemVolumeInDbSync_Func_1600
       * @tc.name   : getSystemVolumeInDbSync
       * @tc.desc   : Test getSystemVolumeInDbSync.device - Sync
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getSystemVolumeInDbSync_Func_1600', 0, async (done: Function) => {
        try{
          systemVolumeInDb = audioVolumeGroupManager.getSystemVolumeInDbSync(audio.AudioVolumeType.MEDIA, volume_7, enum_err);
          expect(systemVolumeInDb < 0).assertTrue();
        }
        catch (error) {
          expect(error.code == '6800101').assertTrue();
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getSystemVolumeInDbSync_Func_1700
       * @tc.name   : getSystemVolumeInDbSync
       * @tc.desc   : Test getSystemVolumeInDbSync.volumeLevel - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getSystemVolumeInDbSync_Func_1700', 0, async (done: Function) => {
        try{
          systemVolumeInDb = audioVolumeGroupManager.getSystemVolumeInDbSync(audio.AudioVolumeType.MEDIA, volume_12,
            audio.DeviceType.SPEAKER);
          expect(systemVolumeInDb >= 0 || systemVolumeInDb < 0).assertTrue();
        }
        catch (error) {
          expect(true).assertTrue();
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getSystemVolumeInDbSync_Func_1800
       * @tc.name   : getSystemVolumeInDbSync
       * @tc.desc   : Test getSystemVolumeInDbSync.volumeLevel - Sync
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getSystemVolumeInDbSync_Func_1800', 0, async (done: Function) => {
        try{
          systemVolumeInDb = audioVolumeGroupManager.getSystemVolumeInDbSync(audio.AudioVolumeType.MEDIA, -1,
            audio.DeviceType.SPEAKER);
          expect(systemVolumeInDb >= 0 || systemVolumeInDb < 0).assertTrue();
        }
        catch (error) {
          if (platform.startsWith('OpenHarmony')) {
            expect(error.code == '6800101').assertTrue();
          } else {
            expect().assertFail();
          }
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getVolume_Func_0100
       * @tc.name   : getVolume
       * @tc.desc   : Test getVolume - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getVolume_Func_0100', 0, async (done: Function) => {
        try{
          volume = await getVolumeCallback(audio.AudioVolumeType.VOICE_CALL);
          expect(volume >= 0).assertTrue();

          volume = await getVolumeCallback(audio.AudioVolumeType.RINGTONE);
          expect(volume >= 0).assertTrue();

          volume = await getVolumeCallback(audio.AudioVolumeType.MEDIA);
          expect(volume >= 0).assertTrue();

          volume = await getVolumeCallback(audio.AudioVolumeType.ALARM);
          expect(volume >= 0).assertTrue();

          volume = await getVolumeCallback(audio.AudioVolumeType.ACCESSIBILITY);
          expect(volume >= 0).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getVolume_Func_0100 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getVolume_Func_0200
       * @tc.name   : getVolume
       * @tc.desc   : Test getVolume - Callback
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getVolume_Func_0200', 0, async (done: Function) => {
        try{
          await (async (): Promise<number> => {
            return new Promise((resolve, reject) => {
              audioVolumeGroupManager.getVolume(enum_err, (err, value) => {
                err == undefined ? resolve(value) : reject(err)
              });
            });
          })().then(value => {
          }).catch((err: BusinessError) => {
            if (err) {
              isPass = true;
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getVolume_Func_0200 error' + error);
        }
        await sleep(waitReadyMs_300);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getVolume_Func_0300
       * @tc.name   : getVolume
       * @tc.desc   : Test getVolume - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getVolume_Func_0300', 0, async (done: Function) => {
        try{
          volume = await getVolumePromise(audio.AudioVolumeType.VOICE_CALL);
          expect(volume >= 0).assertTrue();

          volume = await getVolumePromise(audio.AudioVolumeType.RINGTONE);
          expect(volume >= 0).assertTrue();

          volume = await getVolumePromise(audio.AudioVolumeType.MEDIA);
          expect(volume >= 0).assertTrue();

          volume = await getVolumePromise(audio.AudioVolumeType.ALARM);
          expect(volume >= 0).assertTrue();

          volume = await getVolumePromise(audio.AudioVolumeType.ACCESSIBILITY);
          expect(volume >= 0).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getVolume_Func_0300 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getVolume_Func_0400
       * @tc.name   : getVolume
       * @tc.desc   : Test getVolume - Promise
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getVolume_Func_0400', 0, async (done: Function) => {
        try{
          await audioVolumeGroupManager.getVolume(enum_err).then((value) => {
            expect().assertFail();
          }).catch((err: BusinessError) => {
            if (err) {
              isPass = true;
            }
          })
          expect(isPass).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getVolume_Func_0400 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getVolumeSync_Func_0500
       * @tc.name   : getVolumeSync
       * @tc.desc   : Test getVolumeSync - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getVolumeSync_Func_0500', 0, async (done: Function) => {
        try{
          volume = audioVolumeGroupManager.getVolumeSync(audio.AudioVolumeType.VOICE_CALL);
          expect(volume >= 0).assertTrue();

          volume = audioVolumeGroupManager.getVolumeSync(audio.AudioVolumeType.RINGTONE);
          expect(volume >= 0).assertTrue();

          volume = audioVolumeGroupManager.getVolumeSync(audio.AudioVolumeType.MEDIA);
          expect(volume >= 0).assertTrue();

          volume = audioVolumeGroupManager.getVolumeSync(audio.AudioVolumeType.ALARM);
          expect(volume >= 0).assertTrue();

          volume = audioVolumeGroupManager.getVolumeSync(audio.AudioVolumeType.ACCESSIBILITY);
          expect(volume >= 0).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getVolumeSync_Func_0500 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getVolumeSync_Func_0600
       * @tc.name   : getVolumeSync
       * @tc.desc   : Test getVolumeSync - Sync
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getVolumeSync_Func_0600', 0, async (done: Function) => {
        try{
          volume = audioVolumeGroupManager.getVolumeSync(enum_err);
          expect().assertFail();
        }
        catch (error) {
          expect(error.code == '6800101').assertTrue();
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getMinVolume_Func_0100
       * @tc.name   : getMinVolume
       * @tc.desc   : Test getMinVolume - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getMinVolume_Func_0100', 0, async (done: Function) => {
        try{
          volume = await getMinVolumeCallback(audio.AudioVolumeType.VOICE_CALL);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = await getMinVolumeCallback(audio.AudioVolumeType.RINGTONE);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = await getMinVolumeCallback(audio.AudioVolumeType.MEDIA);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = await getMinVolumeCallback(audio.AudioVolumeType.ALARM);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = await getMinVolumeCallback(audio.AudioVolumeType.ACCESSIBILITY);
          expect(volume >= 0 && volume <= volume_15).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getMinVolume_Func_0100 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getMinVolume_Func_0200
       * @tc.name   : getMinVolume
       * @tc.desc   : Test getMinVolume - Callback
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getMinVolume_Func_0200', 0, async (done: Function) => {
        try{
          await (async (): Promise<number> => {
            return new Promise((resolve, reject) => {
              audioVolumeGroupManager.getMinVolume(enum_err, (err, value) => {
                err == undefined ? resolve(value) : reject(err)
              });
            });
          })().then(value => {
          }).catch((err: BusinessError) => {
            if (err) {
              isPass = true;
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getMinVolume_Func_0200 error' + error);
        }
        await sleep(waitReadyMs_300);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getMinVolume_Func_0300
       * @tc.name   : getMinVolume
       * @tc.desc   : Test getMinVolume - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getMinVolume_Func_0300', 0, async (done: Function) => {
        try{
          volume = await getMinVolumePromise(audio.AudioVolumeType.VOICE_CALL);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = await getMinVolumePromise(audio.AudioVolumeType.RINGTONE);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = await getMinVolumePromise(audio.AudioVolumeType.MEDIA);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = await getMinVolumePromise(audio.AudioVolumeType.ALARM);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = await getMinVolumePromise(audio.AudioVolumeType.ACCESSIBILITY);
          expect(volume >= 0 && volume <= volume_15).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getMinVolume_Func_0300 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getMinVolume_Func_0400
       * @tc.name   : getMinVolume
       * @tc.desc   : Test getMinVolume - Promise
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getMinVolume_Func_0400', 0, async (done: Function) => {
        try{
          await audioVolumeGroupManager.getMinVolume(enum_err).then((value) => {
            expect().assertFail();
          }).catch((err: BusinessError) => {
            if (err) {
              isPass = true;
            }
          })
          expect(isPass).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getMinVolume_Func_0400 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getMinVolumeSync_Func_0500
       * @tc.name   : getMinVolumeSync
       * @tc.desc   : Test getMinVolumeSync - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getMinVolumeSync_Func_0500', 0, async (done: Function) => {
        try{
          volume = audioVolumeGroupManager.getMinVolumeSync(audio.AudioVolumeType.VOICE_CALL);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = audioVolumeGroupManager.getMinVolumeSync(audio.AudioVolumeType.RINGTONE);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = audioVolumeGroupManager.getMinVolumeSync(audio.AudioVolumeType.MEDIA);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = audioVolumeGroupManager.getMinVolumeSync(audio.AudioVolumeType.ALARM);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = audioVolumeGroupManager.getMinVolumeSync(audio.AudioVolumeType.ACCESSIBILITY);
          expect(volume >= 0 && volume <= volume_15).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getMinVolumeSync_Func_0500 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getMinVolumeSync_Func_0600
       * @tc.name   : getMinVolumeSync
       * @tc.desc   : Test getMinVolumeSync - Sync
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getMinVolumeSync_Func_0600', 0, async (done: Function) => {
        try{
          volume = audioVolumeGroupManager.getMinVolumeSync(enum_err);
          expect().assertFail();
        }
        catch (error) {
          expect(error.code == '6800101').assertTrue();
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getMaxVolume_Func_0100
       * @tc.name   : getMaxVolume
       * @tc.desc   : Test getMaxVolume - Callback
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getMaxVolume_Func_0100', 0, async (done: Function) => {
        try{
          volume = await getMaxVolumeCallback(audio.AudioVolumeType.VOICE_CALL);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = await getMaxVolumeCallback(audio.AudioVolumeType.RINGTONE);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = await getMaxVolumeCallback(audio.AudioVolumeType.MEDIA);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = await getMaxVolumeCallback(audio.AudioVolumeType.ALARM);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = await getMaxVolumeCallback(audio.AudioVolumeType.ACCESSIBILITY);
          expect(volume >= 0 && volume <= volume_15).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getMaxVolume_Func_0100 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getMaxVolume_Func_0200
       * @tc.name   : getMaxVolume
       * @tc.desc   : Test getMaxVolume - Callback
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getMaxVolume_Func_0200', 0, async (done: Function) => {
        try{
          await (async (): Promise<number> => {
            return new Promise((resolve, reject) => {
              audioVolumeGroupManager.getMaxVolume(enum_err, (err, value) => {
                err == undefined ? resolve(value) : reject(err)
              });
            });
          })().then(value => {
          }).catch((err: BusinessError) => {
            if (err) {
              isPass = true;
            }
          });
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getMaxVolume_Func_0200 error' + error);
        }
        await sleep(waitReadyMs_300);
        expect(isPass).assertTrue();
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getMaxVolume_Func_0300
       * @tc.name   : getMaxVolume
       * @tc.desc   : Test getMaxVolume - Promise
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getMaxVolume_Func_0300', 0, async (done: Function) => {
        try{
          volume = await getMaxVolumePromise(audio.AudioVolumeType.VOICE_CALL);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = await getMaxVolumePromise(audio.AudioVolumeType.RINGTONE);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = await getMaxVolumePromise(audio.AudioVolumeType.MEDIA);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = await getMaxVolumePromise(audio.AudioVolumeType.ALARM);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = await getMaxVolumePromise(audio.AudioVolumeType.ACCESSIBILITY);
          expect(volume >= 0 && volume <= volume_15).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getMaxVolume_Func_0300 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getMaxVolume_Func_0400
       * @tc.name   : getMaxVolume
       * @tc.desc   : Test getMaxVolume - Promise
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getMaxVolume_Func_0400', 0, async (done: Function) => {
        try{
          await audioVolumeGroupManager.getMaxVolume(enum_err).then((value) => {
            expect().assertFail();
          }).catch((err: BusinessError) => {
            if (err) {
              isPass = true;
            }
          })
          expect(isPass).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getMaxVolume_Func_0400 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getMaxVolumeSync_Func_0500
       * @tc.name   : getMaxVolumeSync
       * @tc.desc   : Test getMaxVolumeSync - Sync
       * @tc.level  : Level 0
       */
      it('SUB_ArkUIX_Audio_getMaxVolumeSync_Func_0500', 0, async (done: Function) => {
        try{
          volume = audioVolumeGroupManager.getMaxVolumeSync(audio.AudioVolumeType.VOICE_CALL);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = audioVolumeGroupManager.getMaxVolumeSync(audio.AudioVolumeType.RINGTONE);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = audioVolumeGroupManager.getMaxVolumeSync(audio.AudioVolumeType.MEDIA);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = audioVolumeGroupManager.getMaxVolumeSync(audio.AudioVolumeType.ALARM);
          expect(volume >= 0 && volume <= volume_15).assertTrue();

          volume = audioVolumeGroupManager.getMaxVolumeSync(audio.AudioVolumeType.ACCESSIBILITY);
          expect(volume >= 0 && volume <= volume_15).assertTrue();
        }
        catch (error) {
          expect(error).assertFail();
          console.error('SUB_ArkUIX_Audio_getMaxVolumeSync_Func_0500 error' + error);
        }
        done();
      })
      /**
       * @tc.number : SUB_ArkUIX_Audio_getMaxVolumeSync_Func_0600
       * @tc.name   : getMaxVolumeSync
       * @tc.desc   : Test getMaxVolumeSync - Sync
       * @tc.level  : Level 2
       */
      it('SUB_ArkUIX_Audio_getMaxVolumeSync_Func_0600', 0, async (done: Function) => {
        try{
          volume = audioVolumeGroupManager.getMaxVolumeSync(enum_err);
          expect().assertFail();
        }
        catch (error) {
          expect(error.code == '6800101').assertTrue();
        }
        done();
      })
    }
  })
}