/*
 * Copyright (c) 2024-2025 Huawei Device Co., Ltd.
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
import media from '@ohos.multimedia.media'
import { BusinessError } from '@ohos.base';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import common from '@ohos.app.ability.common';
import fs from '@ohos.file.fs';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import { Driver, ON, } from '@ohos.UiTest';

let abilityDelegatorRegistry: AbilityDelegatorRegistry.AbilityDelegator =
  AbilityDelegatorRegistry.getAbilityDelegator();
let context: common.Context = abilityDelegatorRegistry.getAppContext().createModuleContext("entry_test");

enum AvRecorderState {
  IDLE = 'idle',
  PREPARED = 'prepared',
  STARTED = 'started',
  PAUSED = 'paused',
  STOPPED = 'stopped',
  RELEASED = 'released',
  ERROR = 'error',
};

async function idle(avRecorder: media.AVRecorder) {
  console.info('case createAVRecorder called');
  await media.createAVRecorder().then((recorder) => {
    if (recorder != null) {
      avRecorder = recorder;
      console.info('createAVRecorder success');
    } else {
      console.info('createAVRecorder fail');
    }
  }).catch((err: BusinessError) => {
    console.info(`createAVRecorder catchCallback, error:${err}`);
  });
  return avRecorder;
}

async function preparePromise(avRecorder: media.AVRecorder, avConfig: media.AVRecorderConfig) {
  if (typeof (avRecorder) == 'undefined') {
    return;
  }
  await avRecorder.prepare(avConfig).then(() => {
    expect(avRecorder.state).assertEqual(AvRecorderState.PREPARED);
    console.info('prepare success');
  }).catch((err: BusinessError) => {
    console.info('prepare failed and catch error is ' + err.message);
  });
}

async function prepareCallback(avRecorder: media.AVRecorder, avConfig: media.AVRecorderConfig) {
  if (typeof (avRecorder) === 'undefined') {
    return;
  }
  avRecorder.prepare(avConfig, (err: BusinessError) => {
    console.info('case prepareCallback called' + err);
    if (err == null) {
      console.error(`case prepareCallback success, state is ${avRecorder.state}`);
      expect(avRecorder.state).assertEqual(AvRecorderState.PREPARED);
    } else {
      console.error(`case prepareCallback error, errMessage is ${err.message}`);
    }
  })
}

async function startPromise(avRecorder: media.AVRecorder, recorderTime: number) {
  if (typeof (avRecorder) == 'undefined') {
    return;
  }
  await avRecorder.start().then(() => {
    expect(avRecorder.state).assertEqual(AvRecorderState.STARTED);
    console.info('start success');
    if (recorderTime != undefined) {
      setTimeout(() => {
        console.info('startPromise setTimeout success');
      }, recorderTime);
    }
  }).catch((err: BusinessError) => {
    console.info('start failed and catch error is ' + err.message);
  });
}

async function startCallback(avRecorder: media.AVRecorder, recorderTime: number) {
  if (typeof (avRecorder) == 'undefined') {
    return;
  }
  await avRecorder.start((err: BusinessError) => {
    console.info('case start called');
    if (err == null) {
      expect(avRecorder.state).assertEqual(AvRecorderState.STARTED);
      console.info('start AVRecorder success');
      if (recorderTime != undefined) {
        setTimeout(() => {
          console.info('startCallback setTimeout success');
        }, recorderTime);
      }
    } else {
      console.info('start AVRecorder failed and error is ' + err.message);
    }
  })
}

async function pausePromise(avRecorder: media.AVRecorder) {
  if (typeof (avRecorder) == 'undefined') {
    return;
  }
  await avRecorder.pause().then(() => {
    expect(avRecorder.state).assertEqual(AvRecorderState.PAUSED);
    console.info('pause success');
  }).catch((err: BusinessError) => {
    console.info('pause failed and catch error is ' + err.message);
  });
}

async function pauseCallback(avRecorder: media.AVRecorder) {
  if (typeof (avRecorder) == 'undefined') {
    return;
  }
  await avRecorder.pause((err: BusinessError) => {
    console.info('case pause called');
    if (err == null) {
      expect(avRecorder.state).assertEqual(AvRecorderState.PAUSED);
      console.info('pause AVRecorder success');
    } else {
      console.info('pause AVRecorder failed and error is ' + err.message);
    }
  })
}

async function stopPromise(avRecorder: media.AVRecorder) {
  if (typeof (avRecorder) == 'undefined') {
    return;
  }
  await avRecorder.stop().then(() => {
    expect(avRecorder.state).assertEqual(AvRecorderState.STOPPED);
    console.info('stop success');
  }).catch((err: BusinessError) => {
    console.info('stop failed and catch error is ' + err.message);
  });
}

async function stopCallback(avRecorder: media.AVRecorder) {
  if (typeof (avRecorder) == 'undefined') {
    return;
  }
  avRecorder.stop((err: BusinessError) => {
    console.info('case stop called');
    if (err == null) {
      expect(avRecorder.state).assertEqual(AvRecorderState.STOPPED);
      console.info('stop AVRecorder success');
    } else {
      console.info('stop AVRecorder failed and error is ' + err.message);
    }
  })
}

async function resetPromise(avRecorder: media.AVRecorder) {
  if (typeof (avRecorder) == 'undefined') {
    return;
  }
  await avRecorder.reset().then(() => {
    expect(avRecorder.state).assertEqual(AvRecorderState.IDLE);
  }).catch((err: BusinessError) => {
    console.info('reset AVRecorder failed and catch error is ' + err.message);
  });
}

async function resumePromise(avRecorder: media.AVRecorder) {
  if (typeof (avRecorder) == 'undefined') {
    return;
  }
  await avRecorder.resume().then(() => {
    console.info('resume success');
  }).catch((err: BusinessError) => {
    console.info('resume AVRecorder failed and catch error is ' + err.message);
  });
}

export async function resumeCallback(avRecorder: media.AVRecorder) {
  if (typeof (avRecorder) == 'undefined') {
    return;
  }
  await avRecorder.resume((err: BusinessError) => {
    console.info('case resume called');
    if (err == null) {
      console.info('resume AVRecorder success');
    } else {
      console.info('resume AVRecorder failed and error is ' + err.message);
    }
  })
}

async function releaseCallback(avRecorder: media.AVRecorder) {
  if (typeof (avRecorder) == 'undefined') {
    return;
  }
  avRecorder.release((err: BusinessError) => {
    console.info('case release called');
    if (err == null) {
      expect(avRecorder.state).assertEqual(AvRecorderState.RELEASED);
      console.info('release AVRecorder success');
    } else {
      console.info('release AVRecorder failed and error is ' + err.message);
    }
  })
}

async function releaseDone(avRecorder: media.AVRecorder, done: Function) {
  await avRecorder.release().then(() => {
    console.info('releaseDone avRecorder.state is ' + avRecorder.state);
    expect(avRecorder.state).assertEqual(AvRecorderState.RELEASED);
    done();
  }).catch((err: BusinessError) => {
    console.info('release releaseDone failed and catch error is ' + err.message);
  });
}

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function failureCallback(error: BusinessError) {
  expect().assertFail();
  console.info(`case error called,errMessage is ${error.message}`);
}

function catchCallback(error: BusinessError) {
  expect().assertFail();
  console.info(`case error called,errMessage is ${error.message}`)
}

function closeFileDescriptor(fileName: string) {
  try {
    context.resourceManager.closeRawFd(fileName);
  } catch (error) {
    let code = (error as BusinessError).code;
    let message = (error as BusinessError).message;
    console.error(`promise closeRawFd failed, error code: ${code}, message: ${message}.`);
  }
}

export default function avRecorderTest() {
  describe('avRecorderTest', () => {
    beforeAll(async () => {
      let driver = Driver.create();
      await sleep(1500);
      let button = await driver.findComponent(ON.text('允许'));
      if (button != null) {
        await driver.delayMs(1500);
        await button.click();
        await sleep(1500);
      }
    })
    beforeEach(async () => {
      console.info('beforeEach case');
    })

    afterEach(async () => {
      console.info('afterEach case');
      if (avRecorder != null) {
        avRecorder.release().then(() => {
          console.info('this testCase execution completed');
        }, failureCallback).catch(catchCallback);
      }
      await sleep(WAIT_THOUSAND);
      console.info('afterEach case');
    })

    afterAll(async () => {
      closeFileDescriptor('test2.mp3');
      closeFileDescriptor('test4.m4a');
      console.info('afterAll case');
    })

    let avRecorder: media.AVRecorder;
    const RECORDER_TIME = 3000;
    const PLAY_TIME = 300;
    const WAIT_TIME = 600;
    const WAIT_THOUSAND = 1000;

    let avProfile: media.AVRecorderProfile = {
      audioBitrate: 48000,
      audioChannels: 2,
      audioCodec: media.CodecMimeType.AUDIO_AAC,
      audioSampleRate: 48000,
      fileFormat: media.ContainerFormatType.CFT_MPEG_4A,
    }
    let avConfig: media.AVRecorderConfig = {
      audioSourceType: media.AudioSourceType.AUDIO_SOURCE_TYPE_DEFAULT,
      profile: avProfile,
      url: 'fd://',
    }

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_0100
     * @tc.name   : createAVRecorder
     * @tc.desc   : Test avRecorder createAVRecorder interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_0100', 0, async (done: Function) => {
      let avRecorder: media.AVRecorder;
      await media.createAVRecorder().then((recorder: media.AVRecorder) => {
        if (recorder != null) {
          avRecorder = recorder;
          console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_0200 createAVRecorder success');
          expect(avRecorder != null).assertTrue();
        } else {
          console.error('SUB_ArkUIX_Media_TestAVRecorders_Func_0200 createAVRecorder fail');
        }
        done();
      })
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_0200
     * @tc.name   : createAVRecorder
     * @tc.desc   : Test avRecorder createAVRecorder interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_0200', 0, async (done: Function) => {
      let avRecorder: media.AVRecorder;
      media.createAVRecorder((error, recorder: media.AVRecorder) => {
        if (recorder != null) {
          avRecorder = recorder;
          console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_0200 createAVRecorder success');
          expect(avRecorder != null).assertTrue();
        } else {
          console.info(`SUB_ArkUIX_Media_TestAVRecorders_Func_0200 createAVRecorder fail, error:${error}`);
        }
      })
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_0300
     * @tc.name   : prepare
     * @tc.desc   : Test avRecorder prepare interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_0300', 0, async (done: Function) => {
      let fdPath = 'fd://';
      let filesDir = context.filesDir;
      let file = fs.openSync(filesDir + '/test2.mp3', fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
      console.log('filedir = ' + filesDir);
      fdPath += file.fd.toString();
      avConfig.url = fdPath;
      avRecorder = await idle(avRecorder);
      await avRecorder.prepare(avConfig).then(() => {
        expect(avRecorder.state).assertEqual(AvRecorderState.PREPARED);
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_0300 prepare success and catch  is ' +
        avRecorder.state);
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_0300 prepare success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_0300 prepare failed and catch error is ' +
        err.message);
      });
      await releaseDone(avRecorder, done);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_0400
     * @tc.name   : prepare
     * @tc.desc   : Test avRecorder prepare interface
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_0400', 0, async (done: Function) => {
      let result = true;
      let fdPath = 'fd://';
      let filesDir = context.filesDir;
      let file = fs.openSync(filesDir + '/test2.mp3', fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
      console.log('filedir = ' + filesDir);
      fdPath += file.fd.toString();
      avConfig.url = fdPath;
      avRecorder = await idle(avRecorder);
      await sleep(WAIT_TIME);
      await avRecorder.resume().then(() => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_0400 resume  success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_0400 resume failed and catch error is ' +
        err.message);
        result = false;
      });
      expect(result).assertEqual(false);
      await preparePromise(avRecorder, avConfig);
      await releaseDone(avRecorder, done);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_0500
     * @tc.name   : start
     * @tc.desc   : Test avRecorder start interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_0500', 0, async (done: Function) => {
      let result = true;
      let fdPath = 'fd://'
      let filesDir = context.filesDir;
      let file = fs.openSync(filesDir + '/test2.mp3', fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
      console.log('filedir = ' + filesDir)
      fdPath += file.fd.toString();
      avConfig.url = fdPath;
      avRecorder = await idle(avRecorder);
      await preparePromise(avRecorder, avConfig);
      await sleep(WAIT_TIME);
      await avRecorder.start().then(() => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_0500 start AVRecorder success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_0500 start AVRecorder failed is ' + err.message);
        result = false;
      });
      expect(result).assertEqual(true);
      await releaseDone(avRecorder, done);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_0600
     * @tc.name   : start
     * @tc.desc   : Test avRecorder state start->pause->start
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_0600', 0, async (done: Function) => {
      let result = true;
      let fdPath = 'fd://';
      let filesDir = context.filesDir;
      let file = fs.openSync(filesDir + '/test2.mp3', fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
      console.log('filedir = ' + filesDir);
      fdPath += file.fd.toString();
      avConfig.url = fdPath;
      avRecorder = await idle(avRecorder);
      await preparePromise(avRecorder, avConfig);
      await startPromise(avRecorder, RECORDER_TIME);
      await sleep(WAIT_TIME);
      await pausePromise(avRecorder);
      await avRecorder.start().then(() => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_0600 start AVRecorder success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_0600 start AVRecorder error is ' + err.message);
        result = false
      });
      expect(result).assertEqual(false);
      await releaseDone(avRecorder, done);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_0700
     * @tc.name   : start
     * @tc.desc   : Test avRecorder state start->resume->start
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_0700', 0, async (done: Function) => {
      let result = true;
      let fdPath = 'fd://';
      let filesDir = context.filesDir;
      let file = fs.openSync(filesDir + '/test2.mp3', fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
      console.log('filedir = ' + filesDir)
      fdPath += file.fd.toString();
      avConfig.url = fdPath;
      avRecorder = await idle(avRecorder);
      await preparePromise(avRecorder, avConfig);
      await startPromise(avRecorder, RECORDER_TIME);
      await sleep(WAIT_TIME);
      await pausePromise(avRecorder);
      await resumePromise(avRecorder);
      await avRecorder.start().then(() => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_0700 start AVRecorder success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_0700 start AVRecorder error is ' + err.message);
        result = false
      });
      expect(result).assertEqual(true);
      await releaseDone(avRecorder, done);
    })
    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_0800
     * @tc.name   : pause
     * @tc.desc   : Test avRecorder state createAVRecorder->pause
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_0800', 0, async (done: Function) => {
      let result = true;
      let fdPath = 'fd://'
      let fileDescriptor = await context.resourceManager.getRawFd('test4.m4a');
      fdPath += JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      avConfig.url = fdPath
      avRecorder = await idle(avRecorder);
      await sleep(WAIT_TIME);
      await avRecorder.pause().then(() => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_0800 pause AVRecorder success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_0800 pause error is ' + err.message);
        result = false
      });
      expect(result).assertEqual(false);
      await releaseDone(avRecorder, done);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_0900
     * @tc.name   : pause
     * @tc.desc   : Test avRecorder state prepare->pause
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_0900', 0, async (done: Function) => {
      let result = true;
      let fdPath = 'fd://'
      let fileDescriptor = await context.resourceManager.getRawFd('test4.m4a');
      fdPath += JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      avConfig.url = fdPath
      avRecorder = await idle(avRecorder);
      await preparePromise(avRecorder, avConfig);
      await sleep(WAIT_TIME);
      await avRecorder.pause().then(() => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_0900 pause AVRecorder success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_0900 pause error is ' + err.message);
        result = false;
      });
      expect(result).assertEqual(false);
      await releaseDone(avRecorder, done);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_01000
     * @tc.name   : pause
     * @tc.desc   : Test avRecorder state prepare->start->pause
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_01000', 0, async (done: Function) => {
      let result = true;
      let fdPath = 'fd://';
      let filesDir = context.filesDir;
      let file = fs.openSync(filesDir + '/test2.mp3', fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
      console.log('filedir = ' + filesDir);
      fdPath += file.fd.toString();
      avConfig.url = fdPath;
      avRecorder = await idle(avRecorder);
      await preparePromise(avRecorder, avConfig);
      await startPromise(avRecorder, RECORDER_TIME);
      await sleep(WAIT_TIME)
      await avRecorder.pause().then(() => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_01000 pause AVRecorder success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_01000 pause AVRecorder error is ' + err.message);
        result = false;
      });
      expect(result).assertEqual(true);
      await releaseDone(avRecorder, done);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_01100
     * @tc.name   : pause
     * @tc.desc   : Test avRecorder state prepare->start->resume->pause
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_01100', 0, async (done: Function) => {
      let result = true;
      let fdPath = 'fd://'
      let filesDir = context.filesDir;
      let file = fs.openSync(filesDir + '/test2.mp3', fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
      console.log('filedir = ' + filesDir);
      fdPath += file.fd.toString();
      avConfig.url = fdPath;
      avRecorder = await idle(avRecorder);
      await preparePromise(avRecorder, avConfig);
      await startPromise(avRecorder, RECORDER_TIME);
      await sleep(WAIT_TIME);
      await resumePromise(avRecorder);
      await avRecorder.pause().then(() => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_01100 pause AVRecorder success');
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_01100 pause success state is ' + avRecorder.state);
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_01100 pause AVRecorder error is ' + err.message);
        result = false
      });
      expect(result).assertEqual(true);
      await releaseDone(avRecorder, done);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_01200
     * @tc.name   : pause
     * @tc.desc   : Test avRecorder state prepare->start->stop->pause
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_01200', 0, async (done: Function) => {
      let result = true;
      let fdPath = 'fd://'
      let fileDescriptor = await context.resourceManager.getRawFd('test4.m4a');
      fdPath += JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      avConfig.url = fdPath
      avRecorder = await idle(avRecorder);
      await preparePromise(avRecorder, avConfig);
      await startPromise(avRecorder, RECORDER_TIME);
      await sleep(WAIT_TIME);
      await stopPromise(avRecorder);
      await avRecorder.pause().then(() => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_01200 pause AVRecorder success');
      }).catch((err: BusinessError) => {
        console.info('pause SUB_ArkUIX_Media_TestAVRecorders_Func_01200 failed and catch error is ' +
        err.message);
        result = false;
      });
      expect(result).assertEqual(false);
      await releaseDone(avRecorder, done);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_01300
     * @tc.name   : pause
     * @tc.desc   : Test avRecorder state prepare->start->reset->pause
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_01300', 0, async (done: Function) => {
      let result = true;
      let fdPath = 'fd://'
      let fileDescriptor = await context.resourceManager.getRawFd('test4.m4a');
      fdPath += JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      avConfig.url = fdPath
      avRecorder = await idle(avRecorder);
      await preparePromise(avRecorder, avConfig);
      await startPromise(avRecorder, RECORDER_TIME);
      await sleep(WAIT_TIME);
      await stopPromise(avRecorder);
      await resetPromise(avRecorder);
      await avRecorder.pause().then(() => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_01300 pause AVRecorder success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_01300 pause failed and catch error is ' +
        err.message);
        result = false;
      });
      expect(result).assertEqual(false);
      await releaseDone(avRecorder, done);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_01400
     * @tc.name   : resume
     * @tc.desc   : Test avRecorder state createAVRecorder->resume
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_01400', 0, async (done: Function) => {
      let result = true;
      let fdPath = 'fd://'
      let fileDescriptor = await context.resourceManager.getRawFd('test4.m4a');
      fdPath += JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      avConfig.url = fdPath
      avRecorder = await idle(avRecorder);
      await sleep(WAIT_TIME);
      await avRecorder.resume().then(() => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_01400 resume AVRecorder success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_01400 resume AVRecorder error is ' + err.message);
        result = false;
      });
      expect(result).assertEqual(false);
      await releaseDone(avRecorder, done);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_01500
     * @tc.name   : resume
     * @tc.desc   : Test avRecorder state prepare->resume
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_01500', 0, async (done: Function) => {
      let result = true;
      avRecorder = await idle(avRecorder);
      await preparePromise(avRecorder, avConfig)
      await sleep(WAIT_TIME);
      await avRecorder.resume().then(() => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_01500 resume AVRecorder success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_01500 resume AVRecorder error is ' + err.message);
        result = false;
      });
      expect(result).assertEqual(false);
      await releaseDone(avRecorder, done);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_01600
     * @tc.name   : resume
     * @tc.desc   : Test avRecorder state prepare->start->resume
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_01600', 0, async (done: Function) => {
      let result = true;
      let fdPath = 'fd://';
      let filesDir = context.filesDir;
      let file = fs.openSync(filesDir + '/test2.mp3', fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
      console.log('filedir = ' + filesDir);
      fdPath += file.fd.toString();
      avConfig.url = fdPath;
      avRecorder = await idle(avRecorder);
      await preparePromise(avRecorder, avConfig);
      await startPromise(avRecorder, RECORDER_TIME);
      await avRecorder.resume().then(() => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_01600 resume AVRecorder success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_01600 resume AVRecorder error is ' + err.message);
        result = false;
      });
      expect(result).assertEqual(true);
      await releaseDone(avRecorder, done);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_01700
     * @tc.name   : resume
     * @tc.desc   : Test avRecorder state prepare->start->pause->resume
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_01700', 0, async (done: Function) => {
      let result = true;
      avRecorder = await idle(avRecorder);
      let fdPath = 'fd://';
      console.info('demo3  1111');
      let filesDir = context.filesDir;
      let file = fs.openSync(filesDir + '/test4.m4a', fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
      ;
      console.log('filedir = ' + filesDir);
      fdPath += file.fd.toString();
      avConfig.url = fdPath;
      await preparePromise(avRecorder, avConfig);
      await startPromise(avRecorder, RECORDER_TIME);
      await sleep(WAIT_TIME);
      await pausePromise(avRecorder);
      await avRecorder.resume().then(() => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_01700 resume AVRecorder success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_01700 resume AVRecorder error is ' + err.message);
        result = false;
      });
      expect(result).assertEqual(true);
      await releaseDone(avRecorder, done);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_01800
     * @tc.name   : resume
     * @tc.desc   : Test avRecorder state prepare->start->stop->resume
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_01800', 0, async (done: Function) => {
      let result = true;
      let fdPath = 'fd://'
      let fileDescriptor = await context.resourceManager.getRawFd('test4.m4a');
      fdPath += JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      avConfig.url = fdPath
      avRecorder = await idle(avRecorder);
      await preparePromise(avRecorder, avConfig);
      await startPromise(avRecorder, RECORDER_TIME);
      await sleep(WAIT_TIME);
      await stopPromise(avRecorder);
      await avRecorder.resume().then(() => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_01800 resume AVRecorder success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_01800 resume AVRecorder error is ' + err.message);
        result = false;
      });
      expect(result).assertEqual(false);
      await releaseDone(avRecorder, done);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_01900
     * @tc.name   : resume
     * @tc.desc   : Test avRecorder state prepare->start->pause->reset->resume
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_01900', 0, async (done: Function) => {
      let result = true;
      let fdPath = 'fd://'
      let fileDescriptor = await context.resourceManager.getRawFd('test4.m4a');
      fdPath += JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      avConfig.url = fdPath
      avRecorder = await idle(avRecorder);
      await preparePromise(avRecorder, avConfig);
      await startPromise(avRecorder, RECORDER_TIME);
      await sleep(WAIT_TIME);
      await pausePromise(avRecorder);
      await resetPromise(avRecorder);
      await avRecorder.resume().then(() => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_01900 resume AVRecorder success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_01900 resume AVRecorder error is ' + err.message);
        result = false;
      });
      expect(result).assertEqual(false);
      await releaseDone(avRecorder, done);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_02000
     * @tc.name   : reset
     * @tc.desc   : Test avRecorder state prepare->start->pause->reset
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_02000', 0, async (done: Function) => {
      let result = true;
      let fdPath = 'fd://';
      let filesDir = context.filesDir;
      let file = fs.openSync(filesDir + '/test2.mp3', fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
      console.log('filedir = ' + filesDir);
      fdPath += file.fd.toString();
      avConfig.url = fdPath;
      avRecorder = await idle(avRecorder);
      await preparePromise(avRecorder, avConfig);
      await startPromise(avRecorder, RECORDER_TIME);
      await sleep(WAIT_TIME);
      await pausePromise(avRecorder);
      await avRecorder.reset().then(() => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_02000 reset avRecorder success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_02000 reset avRecorder error is ' + err.message);
        result = false;
      });
      expect(result).assertEqual(true);
      await releaseDone(avRecorder, done);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_02100
     * @tc.name   : reset
     * @tc.desc   : Test avRecorder state prepare->start->pause->resume->reset
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_02100', 0, async (done: Function) => {
      let result = true;
      let fdPath = 'fd://';
      let filesDir = context.filesDir;
      let file = fs.openSync(filesDir + '/test2.mp3', fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
      console.log('filedir = ' + filesDir);
      fdPath += file.fd.toString();
      avConfig.url = fdPath;
      avRecorder = await idle(avRecorder);
      await preparePromise(avRecorder, avConfig);
      await startPromise(avRecorder, RECORDER_TIME);
      await sleep(WAIT_TIME);
      await pausePromise(avRecorder);
      await resumePromise(avRecorder);
      await avRecorder.reset().then(() => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_02100 reset avRecorder success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_02100 reset avRecorder error is ' + err.message);
        result = false;
      });
      expect(result).assertEqual(true);
      await releaseDone(avRecorder, done);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_02200
     * @tc.name   : reset
     * @tc.desc   : Test avRecorder state prepare->reset->prepare
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_02200', 0, async (done: Function) => {
      let result = true;
      let fdPath = 'fd://'
      let filesDir = context.filesDir;
      let file = fs.openSync(filesDir + '/test2.mp3', fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
      console.log('filedir = ' + filesDir);
      fdPath += file.fd.toString();
      avConfig.url = fdPath;
      avRecorder = await idle(avRecorder);
      await preparePromise(avRecorder, avConfig);
      await startPromise(avRecorder, RECORDER_TIME);
      await sleep(WAIT_TIME);
      await resetPromise(avRecorder);
      await avRecorder.prepare(avConfig).then(() => {
        expect(avRecorder.state).assertEqual(AvRecorderState.PREPARED);
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_02200 prepare success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_02200 prepare avRecorder error is ' + err.message);
        result = false;
      });
      expect(result).assertEqual(true);
      await releaseDone(avRecorder, done);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_02300
     * @tc.name   : release
     * @tc.desc   : Test avRecorder state prepare->start->pause->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_02300', 0, async (done: Function) => {
      let result = true;
      let fdPath = 'fd://';
      let filesDir = context.filesDir;
      let file = fs.openSync(filesDir + '/test2.mp3', fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
      console.log('filedir = ' + filesDir);
      fdPath += file.fd.toString();
      avConfig.url = fdPath;
      avRecorder = await idle(avRecorder);
      await preparePromise(avRecorder, avConfig);
      await startPromise(avRecorder, RECORDER_TIME);
      await sleep(WAIT_TIME);
      await pausePromise(avRecorder);
      await avRecorder.release().then(() => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_02300 release avRecorder success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_02300 release avRecorder error is' + err.message);
        result = false;
      });
      expect(result).assertEqual(true);
      await releaseDone(avRecorder, done);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_02400
     * @tc.name   : release
     * @tc.desc   : Test avRecorder state prepare->start->pause->resume->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_02400', 0, async (done: Function) => {
      let result = true;
      let fdPath = 'fd://';
      let filesDir = context.filesDir;
      let file = fs.openSync(filesDir + '/test2.mp3', fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
      console.log('filedir = ' + filesDir);
      fdPath += file.fd.toString();
      avConfig.url = fdPath;
      avRecorder = await idle(avRecorder);
      await preparePromise(avRecorder, avConfig);
      await startPromise(avRecorder, RECORDER_TIME);
      await sleep(WAIT_TIME);
      await pausePromise(avRecorder);
      await resumePromise(avRecorder);
      await avRecorder.release().then(() => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_02400 release avRecorder success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_02400 release avRecorder error is' + err.message);
        result = false;
      });
      expect(result).assertEqual(true);
      await releaseDone(avRecorder, done);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_02500
     * @tc.name   : release
     * @tc.desc   : Test avRecorder state prepare->start->stop->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_02500', 0, async (done: Function) => {
      let result = true;
      let fdPath = 'fd://';
      let filesDir = context.filesDir;
      let file = fs.openSync(filesDir + '/test2.mp3', fs.OpenMode.READ_WRITE | fs.OpenMode.CREATE);
      console.log('filedir = ' + filesDir);
      fdPath += file.fd.toString();
      avConfig.url = fdPath;
      avRecorder = await idle(avRecorder);
      await preparePromise(avRecorder, avConfig);
      await startPromise(avRecorder, RECORDER_TIME);
      await sleep(WAIT_TIME);
      await avRecorder.stop().then(() => {
        expect(avRecorder.state).assertEqual(AvRecorderState.STOPPED);
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_02500 stop success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_02500 stop error is ' + err.message);
        result = false;
      });
      expect(result).assertEqual(true);
      await releaseDone(avRecorder, done);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_02600
     * @tc.name   : reset
     * @tc.desc   : Test avRecorder state prepare->start->resume->stop->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_02600', 0, async (done: Function) => {
      let fdPath = 'fd://'
      let fileDescriptor = await context.resourceManager.getRawFd('test4.m4a');
      fdPath += JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      avConfig.url = fdPath;
      avRecorder = await idle(avRecorder);
      await preparePromise(avRecorder, avConfig);
      await startPromise(avRecorder, RECORDER_TIME);
      await resumePromise(avRecorder);
      await sleep(WAIT_TIME);
      await stopPromise(avRecorder);
      await avRecorder.reset().then(() => {
        console.info('reset SUB_ArkUIX_Media_TestAVRecorders_Func_02600 success');
        expect(avRecorder.state).assertEqual(AvRecorderState.IDLE);
      }).catch((err: BusinessError) => {
        console.info('reset SUB_ArkUIX_Media_TestAVRecorders_Func_02600 error is ' + err.message);
      });
      await releaseDone(avRecorder, done)
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_02700
     * @tc.name   : reset
     * @tc.desc   : Test avRecorder state prepare->start->resume->stop->reset->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_02700', 0, async (done: Function) => {
      let fdPath = 'fd://'
      let fileDescriptor = await context.resourceManager.getRawFd('test4.m4a');
      fdPath += JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      avConfig.url = fdPath;
      avRecorder = await idle(avRecorder);
      await preparePromise(avRecorder, avConfig);
      await startPromise(avRecorder, RECORDER_TIME);
      await pausePromise(avRecorder);
      await resumePromise(avRecorder);
      await sleep(WAIT_TIME);
      await stopPromise(avRecorder);
      await avRecorder.reset().then(() => {
        console.info('reset SUB_ArkUIX_Media_TestAVRecorders_Func_02700 success');
        expect(avRecorder.state).assertEqual(AvRecorderState.IDLE);
      }).catch((err: BusinessError) => {
        console.info('reset SUB_ArkUIX_Media_TestAVRecorders_Func_02700 error is ' + err.message);
      });
      await releaseDone(avRecorder, done)
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_02800
     * @tc.name   : reset
     * @tc.desc   : Test avRecorder state prepare->start->pause->start->reset->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_02800', 0, async (done: Function) => {
      let fdPath = 'fd://'
      let fileDescriptor = await context.resourceManager.getRawFd('test4.m4a');
      fdPath += JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      avConfig.url = fdPath;
      avRecorder = await idle(avRecorder);
      console.info('case avConfig.url is ' + avConfig.url);
      await preparePromise(avRecorder, avConfig);
      await startPromise(avRecorder, RECORDER_TIME);
      await pausePromise(avRecorder);
      await sleep(PLAY_TIME);
      await startPromise(avRecorder, RECORDER_TIME);
      await avRecorder.reset().then(() => {
        console.info('reset SUB_ArkUIX_Media_TestAVRecorders_Func_02800 success');
        expect(avRecorder.state).assertEqual(AvRecorderState.IDLE);
      }).catch((err: BusinessError) => {
        console.info('reset SUB_ArkUIX_Media_TestAVRecorders_Func_02800 error is ' + err.message);
      });
      await releaseDone(avRecorder, done)

    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_02900
     * @tc.name   : reset
     * @tc.desc   : Test avRecorder state prepare->start->pause->resume->pause->reset
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_02900', 0, async (done: Function) => {
      let fdPath = 'fd://'
      let fileDescriptor = await context.resourceManager.getRawFd('test4.m4a');
      fdPath += JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      avConfig.url = fdPath;
      avRecorder = await idle(avRecorder);
      console.info('case avConfig.url is ' + avConfig.url);
      await preparePromise(avRecorder, avConfig);
      await startPromise(avRecorder, RECORDER_TIME);
      await pausePromise(avRecorder);
      await sleep(PLAY_TIME);
      await resumePromise(avRecorder);
      await pausePromise(avRecorder);
      await avRecorder.reset().then(() => {
        console.info('reset SUB_ArkUIX_Media_TestAVRecorders_Func_02900 success');
        expect(avRecorder.state).assertEqual(AvRecorderState.IDLE);
      }).catch((err: BusinessError) => {
        console.info('reset SUB_ArkUIX_Media_TestAVRecorders_Func_02900 error is ' + err.message);
      });
      await releaseDone(avRecorder, done)
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_03000
     * @tc.name   : reset
     * @tc.desc   : Test avRecorder state start->pause->stop->start->pause->reset
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_03000', 0, async (done: Function) => {
      let fdPath = 'fd://'
      let fileDescriptor = await context.resourceManager.getRawFd('test4.m4a');
      fdPath += JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      avConfig.url = fdPath;
      avRecorder = await idle(avRecorder);
      console.info('case avConfig.url is ' + avConfig.url);
      await preparePromise(avRecorder, avConfig);
      await startPromise(avRecorder, RECORDER_TIME);
      await pausePromise(avRecorder);
      await sleep(WAIT_TIME);
      await stopPromise(avRecorder);
      await startPromise(avRecorder, RECORDER_TIME);
      await pausePromise(avRecorder);
      await avRecorder.reset().then(() => {
        console.info('reset SUB_ArkUIX_Media_TestAVRecorders_Func_03000 success');
        expect(avRecorder.state).assertEqual(AvRecorderState.IDLE);
      }).catch((err: BusinessError) => {
        console.info('reset SUB_ArkUIX_Media_TestAVRecorders_Func_03000 error is ' + err.message);
      });
      await releaseDone(avRecorder, done)
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_03100
     * @tc.name   : prepare->release
     * @tc.desc   : Test avRecorder prepare->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_03100', 0, async (done: Function) => {
      let fdPath = 'fd://'
      let fileDescriptor = await context.resourceManager.getRawFd('test4.m4a');
      fdPath += JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      avConfig.url = fdPath;
      avRecorder = await idle(avRecorder);
      console.info('case avConfig.url is ' + avConfig.url);
      avRecorder = await idle(avRecorder);
      await preparePromise(avRecorder, avConfig);
      await releaseDone(avRecorder, done);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_03200
     * @tc.name   : on('stateChange')
     * @tc.desc   : Test avRecorder Using callback state prepare->on('stateChange')->start->pause->stop->error->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_03200', 0, async (done: Function) => {
      let fdPath = 'fd://'
      let fileDescriptor = await context.resourceManager.getRawFd('test4.m4a');
      fdPath += JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      avConfig.url = fdPath;
      avRecorder = await idle(avRecorder);
      avRecorder.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAVRecorders_Func_03200 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AvRecorderState.PREPARED:
            console.info(`case SUB_ArkUIX_Media_TestAVRecorders_Func_03200 state is PREPARED`);
            expect(avRecorder.state).assertEqual(AvRecorderState.PREPARED);
            await sleep(PLAY_TIME);
            await startCallback(avRecorder, RECORDER_TIME)
            break;
          case AvRecorderState.STARTED:
            console.info(`case SUB_ArkUIX_Media_TestAVRecorders_Func_03200 state is STARTED`);
            expect(avRecorder.state).assertEqual(AvRecorderState.STARTED);
            await sleep(PLAY_TIME)
            await pauseCallback(avRecorder)
            break;
          case AvRecorderState.PAUSED:
            console.info(`case SUB_ArkUIX_Media_TestAVRecorders_Func_03200 state is PAUSED`)
            expect(avRecorder.state).assertEqual(AvRecorderState.PAUSED);
            await stopCallback(avRecorder);
            break;
          case AvRecorderState.STOPPED:
            console.info(`case SUB_ArkUIX_Media_TestAVRecorders_Func_03200 state is STOPPED`)
            expect(avRecorder.state).assertEqual(AvRecorderState.STOPPED);
            await sleep(WAIT_TIME);
            await releaseCallback(avRecorder);
            break;
          case AvRecorderState.RELEASED:
            console.info(`case SUB_ArkUIX_Media_TestAVRecorders_Func_03200 state is RELEASED`);
            expect(avRecorder.state).assertEqual(AvRecorderState.RELEASED);
            done();
            break;
          case AvRecorderState.ERROR:
            console.info(`case SUB_ArkUIX_Media_TestAVRecorders_Func_03200 state is ERROR`)
            expect(avRecorder.state).assertEqual(AvRecorderState.ERROR);
            break;
          default:
            console.info('case SUB_ArkUIX_Media_TestAVRecorders_Func_03200 state is unknown');
        }
      });
      avRecorder.on('error', (err) => {
        console.info('case avRecorder.on(error) called, errMessage is ' + err.message);
        done();
      });
      await prepareCallback(avRecorder, avConfig);
      console.info('case SUB_ArkUIX_Media_TestAVRecorders_Func_03200 preparePromise state is :' +
      avRecorder.state);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_03300
     * @tc.name   : on('stateChange')
     * @tc.desc   : Test avRecorder Using callback state prepare->on('stateChange')->start->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_03300', 0, async (done: Function) => {
      let fdPath = 'fd://';
      let fileDescriptor = await context.resourceManager.getRawFd('test4.m4a');
      fdPath += JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      avConfig.url = fdPath;
      avRecorder = await idle(avRecorder);
      avRecorder.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAVRecorders_Func_03300  state is ${state}, reason is ${reason}`);
        switch (state) {
          case AvRecorderState.PREPARED:
            console.info(`case SUB_ArkUIX_Media_TestAVRecorders_Func_03300 state is PREPARED`);
            expect(avRecorder.state).assertEqual(AvRecorderState.PREPARED);
            await sleep(PLAY_TIME);
            await startPromise(avRecorder, RECORDER_TIME);
            break;
          case AvRecorderState.STARTED:
            console.info(`case SUB_ArkUIX_Media_TestAVRecorders_Func_03300 state is STARTED`);
            expect(avRecorder.state).assertEqual(AvRecorderState.STARTED);
            await sleep(PLAY_TIME);
            await releaseCallback(avRecorder);
            break;
          case AvRecorderState.RELEASED:
            console.info(`case SUB_ArkUIX_Media_TestAVRecorders_Func_03300 state is RELEASED`);
            expect(avRecorder.state).assertEqual(AvRecorderState.RELEASED);
            done();
            break;
          case AvRecorderState.ERROR:
            console.info(`case SUB_ArkUIX_Media_TestAVRecorders_Func_03300 state is ERROR`);
            expect(avRecorder.state).assertEqual(AvRecorderState.ERROR);
            break;
          default:
            console.info('case state is unknown');
        }
      });
      avRecorder.on('error', (err) => {
        console.info('case avRecorder.on(error) called, errMessage is ' + err.message);
        done();
      });
      await prepareCallback(avRecorder, avConfig);
      console.info('case SUB_ArkUIX_Media_TestAVRecorders_Func_03300 preparePromise state is :' +
      avRecorder.state);
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAVRecorders_Func_03400
     * @tc.name   : on('stateChange')
     * @tc.desc   : Test avRecorder Using callback state prepare->on('stateChange')->start->pause->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_03400', 0, async (done: Function) => {
      let fdPath = 'fd://';
      let fileDescriptor = await context.resourceManager.getRawFd('test4.m4a');
      fdPath += JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      avConfig.url = fdPath;
      avRecorder = await idle(avRecorder);
      avRecorder.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAVRecorders_Func_03400 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AvRecorderState.PREPARED:
            console.info(`case SUB_ArkUIX_Media_TestAVRecorders_Func_03400 state is PREPARED`);
            expect(avRecorder.state).assertEqual(AvRecorderState.PREPARED);
            await sleep(PLAY_TIME);
            await startCallback(avRecorder, RECORDER_TIME);
            break;
          case AvRecorderState.STARTED:
            console.info(`case SUB_ArkUIX_Media_TestAVRecorders_Func_03400 state is STARTED`);
            expect(avRecorder.state).assertEqual(AvRecorderState.STARTED);
            await sleep(PLAY_TIME);
            await pauseCallback(avRecorder);
            break;
          case AvRecorderState.PAUSED:
            console.info(`case SUB_ArkUIX_Media_TestAVRecorders_Func_03400 state is PAUSED`);
            expect(avRecorder.state).assertEqual(AvRecorderState.PAUSED);
            await sleep(WAIT_TIME);
            await releaseCallback(avRecorder);
            break;
          case AvRecorderState.RELEASED:
            console.info(`case SUB_ArkUIX_Media_TestAVRecorders_Func_03400 state is RELEASED`);
            expect(avRecorder.state).assertEqual(AvRecorderState.RELEASED);
            done();
            break;
          case AvRecorderState.ERROR:
            console.info(`case SUB_ArkUIX_Media_TestAVRecorders_Func_03400 state is ERROR`);
            expect(avRecorder.state).assertEqual(AvRecorderState.ERROR);
            break;
          default:
            console.info('case SUB_ArkUIX_Media_TestAVRecorders_Func_03400 is unknown');
        }
      });
      avRecorder.on('error', (err) => {
        console.info('case avRecorder.on(error) called, errMessage is ' + err.message);
        done();
      });
      await prepareCallback(avRecorder, avConfig);
      console.info('case SUB_ArkUIX_Media_TestAVRecorders_Func_03400 preparePromise state is :' +
      avRecorder.state);
    })

    /**
     * @tc.number: SUB_ArkUIX_Media_TestAVRecorders_Func_03500
     * @tc.name: test release threee times
     * @tc.desc: Recorder audio release threee times
     * @tc.level: Level1
     */
    it('SUB_ArkUIX_Media_TestAVRecorders_Func_03500', 0, async (done: Function) => {
      let result1 = true;
      let result2 = true;
      let result3 = true;

      avRecorder = await idle(avRecorder);
      await preparePromise(avRecorder, avConfig)
      await startPromise(avRecorder, RECORDER_TIME)
      await pausePromise(avRecorder)
      await avRecorder.release().then(() => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_03500 release success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_03500 release failed and catch error is ' +
        err.message);
        result1 = false
      });
      expect(result1).assertEqual(true);

      await avRecorder.release().then(() => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_03500 release success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_03500 release failed and catch error is ' +
        err.message);
        result2 = false
      });
      expect(result2).assertEqual(true);

      await avRecorder.release().then(() => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_03500 release success');
      }).catch((err: BusinessError) => {
        console.info('SUB_ArkUIX_Media_TestAVRecorders_Func_03500 release failed and catch error is ' +
        err.message);
        result3 = false
      });
      expect(result3).assertEqual(true);
      done();
    })
  })
}