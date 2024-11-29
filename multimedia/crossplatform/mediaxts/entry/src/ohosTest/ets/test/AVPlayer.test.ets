/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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

import { BusinessError } from '@ohos.base';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import media from '@ohos.multimedia.media'
import common from '@ohos.app.ability.common';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import fs from '@ohos.file.fs'
import deviceInfo from '@ohos.deviceInfo';

let osFullNameInfo: string = deviceInfo.osFullName;
console.info('the deviceInfo osFullName is :' + osFullNameInfo);
let platform = osFullNameInfo.split(' ')[0];
console.info('the device platform is :' + platform)

let abilityDelegatorRegistry: AbilityDelegatorRegistry.AbilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
let context: common.Context = abilityDelegatorRegistry.getAppContext().createModuleContext("entry_test");

enum AVPlayerState {
  IDLE = 'idle',
  INITIALIZED = 'initialized',
  PREPARED = 'prepared',
  PLAYING = 'playing',
  PAUSED = 'paused',
  COMPLETED = 'completed',
  STOPPED = 'stopped',
  RELEASED = 'released',
  ERROR = 'error',
};

async function idle(avPlayer: media.AVPlayer) {
  console.info('case createAVPlayer called');
  await media.createAVPlayer().then((video: media.AVPlayer) => {
    if (video != null) {
      avPlayer = video;
      console.info('createAVPlayer success');
    } else {
      console.info('createAVPlayer fail');
    }
  }).catch((err: BusinessError) => {
    console.info(`createAVPlayer catchCallback, error:${err}`);
  });
  return avPlayer;
}

function prepareCallback(avPlayer: media.AVPlayer) {
  if (typeof (avPlayer) == 'undefined') {
    return;
  }
  avPlayer.prepare((err: BusinessError) => {
    console.info('prepare prepareCallback called' + err);
    if (err == null) {
      console.error(`prepare avPlayer success, state is ${avPlayer.state}`);
      expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED);
    } else {
      console.error(`prepare avPlayer error, errMessage is ${err.message}`);
    }
  })
}

async function playCallback(avPlayer: media.AVPlayer) {
  if (typeof (avPlayer) == 'undefined') {
    return;
  }
  avPlayer.play((err: BusinessError) => {
    console.info('case play called');
    if (err == null) {
      expect(avPlayer.state).assertEqual(AVPlayerState.PLAYING);
      console.info('play avPlayer success');
    } else {
      console.info('play avPlayer failed and error is ' + err.message);
    }
  })
}

async function pauseCallback(avPlayer: media.AVPlayer) {
  if (typeof (avPlayer) == 'undefined') {
    return;
  }
  avPlayer.pause((err: BusinessError) => {
    console.info('case pause called');
    if (err == null) {
      expect(avPlayer.state).assertEqual(AVPlayerState.PAUSED);
      console.info('pause avPlayer success');
    } else {
      console.info('pause avPlayer failed and error is ' + err.message);
    }
  })
}

async function stopCallback(avPlayer: media.AVPlayer) {
  if (typeof (avPlayer) == 'undefined') {
    return;
  }
  avPlayer.stop((err: BusinessError) => {
    console.info('case stop called');
    if (err == null) {
      expect(avPlayer.state).assertEqual(AVPlayerState.STOPPED);
      console.info('stop avPlayer success');
    } else {
      console.info('stop avPlayer failed and error is ' + err.message);
    }
  })
}

async function preparePromise(avPlayer: media.AVPlayer) {
  if (typeof (avPlayer) == 'undefined') {
    return;
  }
  await avPlayer.prepare().then(() => {
    expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED);
    console.info('prepare success');
  }).catch((err: BusinessError) => {
    console.info('prepare failed and catch error is ' + err.message);
  });
}

async function pausePromise(avPlayer: media.AVPlayer) {
  if (typeof (avPlayer) == 'undefined') {
    return;
  }
  await avPlayer.pause().then(() => {
    expect(avPlayer.state).assertEqual(AVPlayerState.PAUSED);
    console.info('pause success');
  }).catch((err: BusinessError) => {
    console.info('pause failed and catch error is ' + err.message);
  });
}

async function playPromise(avPlayer: media.AVPlayer) {
  if (typeof (avPlayer) == 'undefined') {
    return;
  }
  await avPlayer.play().then(() => {
    expect(avPlayer.state).assertEqual(AVPlayerState.PLAYING);
    console.info('stop success');
  }).catch((err: BusinessError) => {
    console.info('stop failed and catch error is ' + err.message);
  });
}

async function stopPromise(avPlayer: media.AVPlayer) {
  if (typeof (avPlayer) == 'undefined') {
    return;
  }
  await avPlayer.stop().then(() => {
    expect(avPlayer.state).assertEqual(AVPlayerState.STOPPED);
    console.info('stop success');
  }).catch((err: BusinessError) => {
    console.info('stop failed and catch error is ' + err.message);
  });
}

async function resetPromise(avPlayer: media.AVPlayer) {
  if (typeof (avPlayer) == 'undefined') {
    return;
  }
  await sleep(1000);
  await avPlayer.reset().then(() => {
    console.info('reset success');
  }).catch((err: BusinessError) => {
    console.info('reset AVRecorder failed and catch error is ' + err.message);
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
  console.info(`case error called,errMessage is ${error.message}`);
}

function closeFileDescriptor(fileName: string) {
  try {
    context.resourceManager.closeRawFd(fileName);
  } catch (error) {
    let code = (error as BusinessError).code;
    let message = (error as BusinessError).message;
    console.error(`promise closeRawFd failed, error code: ${code}, message: ${message}`);
  }
}

export default function AVPlayerTest() {
  describe('AVPlayerTest', () => {
    const PLAY_TIME = 300;
    const WAIT_TIME = 600;
    const WAIT_THOUSAND = 1000;
    let avPlayer: media.AVPlayer;
    let surfaceID = "";

    beforeAll(async () => {
      console.info('beforeAll case');
    })

    beforeEach(async () => {
      console.info('beforeEach case');
    })

    afterEach(async () => {
      if (avPlayer != null) {
        avPlayer.release().then(() => {
          console.info('this testCase execution completed');
        }, failureCallback).catch(catchCallback);
      }
      await sleep(WAIT_THOUSAND);
      console.info('afterEach case');
    })

    afterAll(async () => {
      closeFileDescriptor('test2.mp3');
      closeFileDescriptor('test2.mp4');
      closeFileDescriptor('test4.m4a');
      closeFileDescriptor('test5.mkv');
      closeFileDescriptor('test6.aac');
      closeFileDescriptor('test9.ogg');
      console.info('afterAll case');
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_0100
     * @tc.name   : on('stateChange')->INITIALIZED->reset->release
     * @tc.desc   : Test audio state INITIALIZED->reset->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_0100', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp3');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0100 fdSrc ' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_Media_TesetAvPlayer_Func_0100  state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.IDLE:
            expect(avPlayer.state).assertEqual(AVPlayerState.IDLE);
            await sleep(WAIT_TIME);
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0100 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          case AVPlayerState.INITIALIZED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0100 play state is INITIALIZED');
            await sleep(WAIT_TIME);
            await resetPromise(avPlayer);
            break;
          default:
            break;
        }
      })
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_0200
     * @tc.name   : on('stateChange')->prepared->stop->release
     * @tc.desc   : Test audio state prepared->stop->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_0200', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp3');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0200 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_Media_TesetAvPlayer_Func_0200 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.IDLE:
            expect(avPlayer.state).assertEqual(AVPlayerState.IDLE);
            break;
          case AVPlayerState.INITIALIZED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0200 prepare state is INITIALIZED');
            avPlayer.prepare((err) => {
              if (err != null) {
                console.error(`case SUB_Media_TesetAvPlayer_Func_0200 prepare errMessage is ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0200 prepare state PREPARED');
              }
            });
            break;
          case AVPlayerState.PREPARED:
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED);
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0200 avPlayer state is prepared');
            await stopPromise(avPlayer);
            break;
          case AVPlayerState.STOPPED:
            expect(avPlayer.state).assertEqual(AVPlayerState.STOPPED);
            await sleep(WAIT_TIME);
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0200 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_0300
     * @tc.name   : on('stateChange')->prepare->release
     * @tc.desc   : Test audio state INITIALIZED->prepare->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_0300', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp3');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0300 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state: string, reason: media.StateChangeReason) => {
        console.info(`case SUB_Media_TesetAvPlayer_Func_0300 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.IDLE:
            break;
          case AVPlayerState.INITIALIZED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0300 state initialized called.')
            await preparePromise(avPlayer);
            break;
          case AVPlayerState.PREPARED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0300 state prepared called.')
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED);
            await sleep(WAIT_TIME)
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0300 avPlayer is release')
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_0400
     * @tc.name   : on('stateChange')->prepare->play->release
     * @tc.desc   : Test audio state INITIALIZED->prepare->play->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_0400', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp3');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0400 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state: string, reason: media.StateChangeReason) => {
        console.info(`case SUB_Media_TesetAvPlayer_Func_0400 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0400 state initialized called.');
            await preparePromise(avPlayer);
          case AVPlayerState.PREPARED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0400 state prepared called.');
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED);
            await playPromise(avPlayer);
            break;
          case AVPlayerState.PLAYING:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0400 state playing called.');
            expect(avPlayer.state).assertEqual(AVPlayerState.PLAYING);
            await sleep(WAIT_TIME);
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0400 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_0500
     * @tc.name   : on('stateChange')->prepare->play->pause->reset->release
     * @tc.desc   : Test audio state INITIALIZED->prepare->play->pause->reset->release;
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_0500', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_Media_AVPlayer_0500 createAVPlayer' + avPlayer.state);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp3');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0500 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state: string, reason: media.StateChangeReason) => {
        console.info(`case SUB_Media_TesetAvPlayer_Func_0500 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.IDLE:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0500 state idle called.');
            await sleep(WAIT_TIME);
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0500 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          case AVPlayerState.INITIALIZED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0500 state initialized called.');
            await preparePromise(avPlayer);
            break;
          case AVPlayerState.PREPARED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0500 state prepared called.');
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED);
            await sleep(PLAY_TIME);
            await playPromise(avPlayer);
            break;
          case AVPlayerState.PLAYING:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0500 state playing called.');
            expect(avPlayer.state).assertEqual(AVPlayerState.PLAYING);
            await sleep(PLAY_TIME);
            await pausePromise(avPlayer);
            break;
          case AVPlayerState.PAUSED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0500 state paused called.');
            expect(avPlayer.state).assertEqual(AVPlayerState.PAUSED);
            await sleep(WAIT_TIME);
            await resetPromise(avPlayer);
            break
          default:
            break;
        }
      })
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_0600
     * @tc.name   : on('stateChange')->prepare->play->pause->release
     * @tc.desc   : Test audio state INITIALIZED->prepare->play->pause->release;
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_0600', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0600  createAVPlayer' + avPlayer.state);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp3');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0600 fdSrc ' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state: string, reason: media.StateChangeReason) => {
        console.info(`case SUB_Media_TesetAvPlayer_Func_0600 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0600 state initialized called.');
            await preparePromise(avPlayer)
            break;
          case AVPlayerState.PREPARED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0600 state prepared called.');
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED);
            await playPromise(avPlayer)
            break;
          case AVPlayerState.PLAYING:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0600 state playing called.');
            expect(avPlayer.state).assertEqual(AVPlayerState.PLAYING);
            await sleep(WAIT_TIME)
            await pausePromise(avPlayer)
            break;
          case AVPlayerState.PAUSED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0600 avPlayer is paused');
            expect(avPlayer.state).assertEqual(AVPlayerState.PAUSED);
            await sleep(WAIT_TIME)
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0600 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_0700
     * @tc.name   : on('stateChange')->prepare->play->pause->stop->release
     * @tc.desc   : Test audio state INITIALIZED->prepare->play->pause->stop->release;
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_0700', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0700 createAVPlayer ' + avPlayer.state);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp3');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0700 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state: string, reason: media.StateChangeReason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_0700 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0700 state initialized called.');
            await preparePromise(avPlayer);
            break;
          case AVPlayerState.PREPARED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0700 state prepared called.');
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED);
            await playPromise(avPlayer);
            break;
          case AVPlayerState.PLAYING:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0700 state playing called.');
            expect(avPlayer.state).assertEqual(AVPlayerState.PLAYING);
            await pausePromise(avPlayer);
            break;
          case AVPlayerState.PAUSED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0700 state paused called.');
            expect(avPlayer.state).assertEqual(AVPlayerState.PAUSED);
            await sleep(WAIT_TIME);
            await stopPromise(avPlayer);
            break;
          case AVPlayerState.STOPPED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0700 state stopped called.');
            expect(avPlayer.state).assertEqual(AVPlayerState.STOPPED);
            await sleep(WAIT_TIME);
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0700 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
          default:
            break;
        }
      })
      avPlayer.on('error', async (err) => {
        console.error(`case SUB_ArkUIX_Media_TestAvPlayer_Func_0700 error called, errMessage is ${err.message}`);
        await avPlayer.release().then(() => {
          done();
        });
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_0800
     * @tc.name   : on('stateChange')->ERROR->release
     * @tc.desc   : Test video state INITIALIZED->ERROR->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_0800', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0800 createAVPlayer' + avPlayer.state);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0800 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_0800 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            avPlayer.surfaceId = surfaceID;
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0800 state is INITIALIZED');
            avPlayer.prepare().then(() => {
            }, failureCallback).catch(catchCallback);
            break;
          case AVPlayerState.RELEASED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0800 state is RELEASED');
            expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
            done();
            break;
          case AVPlayerState.ERROR:
            console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_0800 error`);
            break;
          default:
            break;
        }
      });
      avPlayer.on('error', async (err) => {
        console.error(`case SUB_ArkUIX_Media_TestAvPlayer_Func_0800 error called, errMessage is ${err.message}`);
        await avPlayer.release().then(() => {
          console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0800 avPlayer is release');
          expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
        }, failureCallback).catch(catchCallback);
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_0900
     * @tc.name   : on('volumeChange')
     * @tc.desc   : Test video state INITIALIZED->prepared->play->setVolume->on('volumeChange')->pause->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_0900', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0900 createAVPlayer' + avPlayer.state);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0900 fdSrc' + avPlayer.fdSrc);
      let loopTime = 0;
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`SUB_ArkUIX_Media_TestAvPlayer_Func_0900  state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            avPlayer.surfaceId = surfaceID;
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0900 state is INITIALIZED');
            avPlayer.prepare((err) => {
              if (err != null) {
                console.error(`SUB_ArkUIX_Media_TestAvPlayer_Func_0900  prepare errMessage is ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0900 state is prepared');
              }
            });
            break;
          case AVPlayerState.PREPARED:
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED);
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0900 state is PREPARED');
            await playPromise(avPlayer);
            break;
          case AVPlayerState.PLAYING:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0900 play state is PLAYING');
            expect(avPlayer.state).assertEqual(AVPlayerState.PLAYING);
            if (loopTime == 5) {
              avPlayer.off('volumeChange');
              await avPlayer.release().then(() => {
                console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0900 avPlayer is release');
                expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
                done();
              }, failureCallback).catch(catchCallback);
            } else {
              console.info(`SUB_ArkUIX_Media_TestAvPlayer_Func_0900 start setVolume`);
              loopTime++;
              let volume = 1.0;
              await sleep(PLAY_TIME);
              avPlayer.setVolume(volume);
            }
            break;
          case AVPlayerState.PAUSED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0900 state is PAUSED');
            expect(avPlayer.state).assertEqual(AVPlayerState.PAUSED);
            await avPlayer.play().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0900 avPlayer from pause to play');
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      });
      avPlayer.on('volumeChange', (vol) => {
        console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0900 volumeChange success,and new volume is :' + vol);
        avPlayer.pause()
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_01000
     * @tc.name   : on('seekDone')
     * @tc.desc   : Test video state INITIALIZED->prepared->play->seek->on('seekDone')->pause->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_01000', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01000 createAVPlayer' + avPlayer.state);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01000 fdSrc' + avPlayer.fdSrc);
      let loopTime = 0;
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_01000 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            avPlayer.surfaceId = surfaceID;
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01000 state is INITIALIZED');
            avPlayer.prepare((err) => {
              if (err != null) {
                console.error(`case SUB_ArkUIX_Media_TestAvPlayer_Func_01000 prepare errMessage is ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01000 state is prepared');
              }
            });
            break;
          case AVPlayerState.PREPARED:
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED);
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01000 avPlayer state is PREPARED');
            avPlayer.play();
            break;
          case AVPlayerState.PLAYING:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01000 state is PLAYING');
            expect(avPlayer.state).assertEqual(AVPlayerState.PLAYING);
            loopTime += 20;
            if (loopTime == 220) {
              avPlayer.off('seekDone');
              await avPlayer.release().then(() => {
                console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01000 avPlayer is release');
                expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
                done();
              }, failureCallback).catch(catchCallback);
            } else {
              avPlayer.seek(loopTime);
            }
            break;
          case AVPlayerState.PAUSED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01000 state is PAUSED');
            expect(avPlayer.state).assertEqual(AVPlayerState.PAUSED);
            await sleep(WAIT_TIME)
            await avPlayer.play().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01000 avPlayer from pause to play');
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      });
      avPlayer.on('seekDone', async (seekDoneTime) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_01000 seekDone called seekDoneTime is ${seekDoneTime}`);
        avPlayer.pause();
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_01100
     * @tc.name   : on('speedDone')
     * @tc.desc   : Test video state INITIALIZED->prepared->play->setspeed->on('speedDone')->pause->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_01100', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01100 createAVPlayer' + avPlayer.state)
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01100 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_01100 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            avPlayer.surfaceId = surfaceID;
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01100 state is INITIALIZED');
            avPlayer.prepare((err) => {
              if (err != null) {
                console.error(`SUB_ArkUIX_Media_TestAvPlayer_Func_01100 prepare errMessage is ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01100 state is prepared');
              }
            });
            break;
          case AVPlayerState.PREPARED:
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED)
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01100 avPlayer state is PREPARED');
            await playPromise(avPlayer);
            break;
          case AVPlayerState.PLAYING:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01100 play state is PLAYING');
            expect(avPlayer.state).assertEqual(AVPlayerState.PLAYING);
            avPlayer.setSpeed(media.PlaybackSpeed.SPEED_FORWARD_1_00_X);
            await sleep(WAIT_TIME);
            avPlayer.pause();
            break;
          case AVPlayerState.PAUSED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01100 state is PAUSED');
            expect(avPlayer.state).assertEqual(AVPlayerState.PAUSED);
            avPlayer.off('speedDone');
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01100 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
      avPlayer.on('speedDone', async (speed) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_01100 setSpeedTimeCallback22222 called  is ${speed}`);
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_01200
     * @tc.name   : getTrackDescription
     * @tc.desc   : Test video state INITIALIZED->prepared->play->getTrackDescription->pause->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_01200', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01200 createAVPlayer' + avPlayer.state);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01200 fdSrc' + avPlayer.fdSrc)
      let loopTime = 0;
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_01200 called, state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            avPlayer.surfaceId = surfaceID;
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01200 state is INITIALIZED');
            avPlayer.prepare((err) => {
              if (err != null) {
                console.error(`case SUB_ArkUIX_Media_TestAvPlayer_Func_01200 prepare errMessage is ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01200 play state is prepared');
              }
            });
            break;
          case AVPlayerState.PREPARED:
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED);
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01200 avPlayer state is PREPARED');
            await playPromise(avPlayer);
            break;
          case AVPlayerState.PLAYING:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01200 state is PLAYING');
            expect(avPlayer.state).assertEqual(AVPlayerState.PLAYING);
            if (loopTime == 4) {
              await avPlayer.release().then(() => {
                console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01200 avPlayer is release');
                expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
                done();
              }, failureCallback).catch(catchCallback);
            } else {
              loopTime++;
              await avPlayer.getTrackDescription().then((arrList) => {
                if (arrList != null) {
                  let arrayDescription = arrList;
                  console.info(`SUB_ArkUIX_Media_TestAvPlayer_Func_01200 arrayDescription is ` + arrayDescription);
                } else {
                  console.log('video SUB_ArkUIX_Media_TestAvPlayer_Func_01200 fail');
                }
              }).catch((error: BusinessError) => {
                console.info(`video SUB_ArkUIX_Media_TestAvPlayer_Func_01200, error:${error}`);
              });
              await sleep(PLAY_TIME);
              avPlayer.pause();
            }
            break;
          case AVPlayerState.PAUSED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01200 play state is PAUSED');
            expect(avPlayer.state).assertEqual(AVPlayerState.PAUSED);
            await avPlayer.play().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01200 avPlayer from pause to play');
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_01300
     * @tc.name   : prepared->play->pause->release
     * @tc.desc   : Test video state INITIALIZED->prepared->play->pause->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_01300', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01300 createAVPlayer' + avPlayer.state);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01300 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_01300 called, state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            avPlayer.surfaceId = surfaceID;
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01300 state is INITIALIZED');
            avPlayer.prepare((err) => {
              if (err != null) {
                console.error(`SUB_ArkUIX_Media_TestAvPlayer_Func_01300 prepare errMessage is ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01300 state is prepared');
              }
            });
            break;
          case AVPlayerState.PREPARED:
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED);
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01300 avPlayer state is PREPARED');
            await playPromise(avPlayer);
            break;
          case AVPlayerState.PLAYING:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01300 play state is PLAYING');
            expect(avPlayer.state).assertEqual(AVPlayerState.PLAYING);
            await sleep(WAIT_TIME);
            await pausePromise(avPlayer);
            break;
          case AVPlayerState.PAUSED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01300 play state is PAUSED');
            expect(avPlayer.state).assertEqual(AVPlayerState.PAUSED);
            await sleep(WAIT_TIME)
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01300 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_01400
     * @tc.name   : on('stateChange')->prepare->release
     * @tc.desc   : Test video state INITIALIZED->prepare->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_01400', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info(' SUB_ArkUIX_Media_TestAvPlayer_Func_01400 createAVPlayer' + avPlayer.state);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01400 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_01400 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            avPlayer.surfaceId = surfaceID;
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01400 play state is INITIALIZED');
            avPlayer.prepare((err) => {
              if (err != null) {
                console.error(`SUB_ArkUIX_Media_TestAvPlayer_Func_01400 prepare errMessage is ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01400 play state is prepared');
              }
            });
            break;
          case AVPlayerState.PREPARED:
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED);
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01400 avPlayer state is PREPARED');
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01400 avPlayer is released');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_01500
     * @tc.name   : on('stateChange')
     * @tc.desc   : Test video state INITIALIZED->prepared->play->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_01500', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01500 createAVPlayer' + avPlayer.state)
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01500 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_01500 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            avPlayer.surfaceId = surfaceID;
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01500 state is INITIALIZED');
            avPlayer.prepare((err) => {
              if (err != null) {
                console.error(`SUB_ArkUIX_Media_TestAvPlayer_Func_01500 prepare errMessage is ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01500 play state is prepared');
              }
            });
            break;
          case AVPlayerState.PREPARED:
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED);
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01500 avPlayer state is PREPARED');
            await playPromise(avPlayer);
            break;
          case AVPlayerState.PLAYING:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01500 state is PLAYING');
            expect(avPlayer.state).assertEqual(AVPlayerState.PLAYING);
            await sleep(WAIT_TIME);
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01500 avPlayer is released');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_01600
     * @tc.name   : on('stateChange')->prepare->play->pause->stop->release
     * @tc.desc   : Test video state INITIALIZED->prepare->play->pause->stop->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_01600', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01600  createAVPlayer' + avPlayer.state);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01600 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_01600  state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            avPlayer.surfaceId = surfaceID;
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01600 state is INITIALIZED');
            avPlayer.prepare((err) => {
              if (err != null) {
                console.error(`SUB_ArkUIX_Media_TestAvPlayer_Func_01600 prepare errMessage is ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01600 state is prepared');
              }
            });
            break;
          case AVPlayerState.PREPARED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01600 avPlayer state is PREPARED');
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED);
            await playPromise(avPlayer);
            break;
          case AVPlayerState.PLAYING:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01600 state is PLAYING');
            expect(avPlayer.state).assertEqual(AVPlayerState.PLAYING);
            await sleep(WAIT_TIME);
            await pausePromise(avPlayer);
            break;
          case AVPlayerState.PAUSED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01600 state is PAUSED');
            expect(avPlayer.state).assertEqual(AVPlayerState.PAUSED);
            await stopPromise(avPlayer);
            break;
          case AVPlayerState.STOPPED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01600 state is STOPPED');
            expect(avPlayer.state).assertEqual(AVPlayerState.STOPPED);
            await sleep(WAIT_TIME);
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01600 avPlayer is release')
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_01700
     * @tc.name   : on('stateChange')
     * @tc.desc   : Test video state INITIALIZED->prepare->play->pause->reset->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_01700', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01700 createAVPlayer' + avPlayer.state);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info(' SUB_ArkUIX_Media_TestAvPlayer_Func_01700 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_01700 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.IDLE:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01700 state idle called.');
            await sleep(PLAY_TIME)
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01700 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          case AVPlayerState.INITIALIZED:
            avPlayer.surfaceId = surfaceID;
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01700 state is INITIALIZED');
            avPlayer.prepare((err) => {
              if (err != null) {
                console.error(`SUB_ArkUIX_Media_TestAvPlayer_Func_01700 prepare errMessage is ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01700 state is prepared');
              }
            });
            break;
          case AVPlayerState.PREPARED:
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED);
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01700 state is PREPARED');
            await playPromise(avPlayer);
            break;
          case AVPlayerState.PLAYING:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01700 state is PLAYING');
            expect(avPlayer.state).assertEqual(AVPlayerState.PLAYING);
            await pausePromise(avPlayer);
            break;
          case AVPlayerState.PAUSED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01700 state is PAUSED')
            expect(avPlayer.state).assertEqual(AVPlayerState.PAUSED);
            await sleep(WAIT_THOUSAND);
            await resetPromise(avPlayer);
            break;
          default:
            break;
        }
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_01800
     * @tc.name   : on('speedDone')
     * @tc.desc   : Test set Speed SPEED_FORWARD_1_25_X
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_01800', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01800 createAVPlayer' + avPlayer.state)
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01800 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_01800 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            avPlayer.surfaceId = surfaceID;
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01800 state is INITIALIZED');
            avPlayer.prepare((err) => {
              if (err != null) {
                console.error(`SUB_ArkUIX_Media_TestAvPlayer_Func_01800 prepare error, errMessage is ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01800 state is prepared');
              }
            });
            break;
          case AVPlayerState.PREPARED:
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED)
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01800 avPlayer state is PREPARED');
            await playPromise(avPlayer);
            break;
          case AVPlayerState.PLAYING:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01800 play state is PLAYING');
            expect(avPlayer.state).assertEqual(AVPlayerState.PLAYING);
            avPlayer.setSpeed(media.PlaybackSpeed.SPEED_FORWARD_1_25_X);
            await sleep(WAIT_TIME);
            avPlayer.pause();
            break;
          case AVPlayerState.PAUSED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01800 state is PAUSED');
            expect(avPlayer.state).assertEqual(AVPlayerState.PAUSED);
            avPlayer.off('speedDone');
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01800 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
      avPlayer.on('speedDone', async (speed) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_01800 setSpeedTimeCallback called  is ${speed}`);
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_01900
     * @tc.name   : on('speedDone')
     * @tc.desc   : Test set Speed SPEED_FORWARD_1_75_X
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_01900', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01900 createAVPlayer' + avPlayer.state)
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01900 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_01900 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            avPlayer.surfaceId = surfaceID;
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01900 state is INITIALIZED');
            avPlayer.prepare((err) => {
              if (err != null) {
                console.error(`SUB_ArkUIX_Media_TestAvPlayer_Func_01900 prepare error, errMessage is ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01900 state is prepared');
              }
            });
            break;
          case AVPlayerState.PREPARED:
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED)
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01900 avPlayer state is PREPARED');
            await playPromise(avPlayer);
            break;
          case AVPlayerState.PLAYING:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01900 play state is PLAYING');
            expect(avPlayer.state).assertEqual(AVPlayerState.PLAYING);
            avPlayer.setSpeed(media.PlaybackSpeed.SPEED_FORWARD_1_75_X);
            await sleep(WAIT_TIME);
            avPlayer.pause();
            break;
          case AVPlayerState.PAUSED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01900 state is PAUSED');
            expect(avPlayer.state).assertEqual(AVPlayerState.PAUSED);
            avPlayer.off('speedDone');
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_01900 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
      avPlayer.on('speedDone', async (speed) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_01900 setSpeedTimeCallback called  is ${speed}`);
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_02000
     * @tc.name   : on('speedDone')
     * @tc.desc   : Test set Speed SPEED_FORWARD_2_00_X
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_02000', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02000 createAVPlayer' + avPlayer.state)
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02000 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_02000  state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            avPlayer.surfaceId = surfaceID;
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02000 state is initialized called`');
            avPlayer.prepare((err) => {
              if (err != null) {
                console.error(`SUB_ArkUIX_Media_TestAvPlayer_Func_02000 prepare error, errMessage is ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02000 state is prepared');
              }
            });
            break;
          case AVPlayerState.PREPARED:
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED)
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02000 avPlayer state is PREPARED');
            await playPromise(avPlayer);
            break;
          case AVPlayerState.PLAYING:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02000 play state is PLAYING');
            expect(avPlayer.state).assertEqual(AVPlayerState.PLAYING);
            avPlayer.setSpeed(media.PlaybackSpeed.SPEED_FORWARD_2_00_X);
            await sleep(WAIT_TIME);
            avPlayer.pause();
            break;
          case AVPlayerState.PAUSED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02000 state is PAUSED');
            expect(avPlayer.state).assertEqual(AVPlayerState.PAUSED);
            avPlayer.off('speedDone');
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02000 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
      avPlayer.on('speedDone', async (speed) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_02000 setSpeedTimeCallback called  is ${speed}`);
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_02100
     * @tc.name   : on('speedDone')
     * @tc.desc   : Test set Speed SPEED_FORWARD_0_75_X
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_02100', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02100 createAVPlayer' + avPlayer.state)
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02100 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_02100 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            avPlayer.surfaceId = surfaceID;
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02100 state is initialized called`');
            avPlayer.prepare((err) => {
              if (err != null) {
                console.error(`SUB_ArkUIX_Media_TestAvPlayer_Func_02100 prepare error, errMessage is ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02100 state is prepared');
              }
            });
            break;
          case AVPlayerState.PREPARED:
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED)
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02100 avPlayer state is PREPARED');
            await playPromise(avPlayer);
            break;
          case AVPlayerState.PLAYING:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02100 play state is PLAYING');
            expect(avPlayer.state).assertEqual(AVPlayerState.PLAYING);
            avPlayer.setSpeed(media.PlaybackSpeed.SPEED_FORWARD_0_75_X);
            await sleep(WAIT_TIME);
            avPlayer.pause();
            break;
          case AVPlayerState.PAUSED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02100 state is PAUSED');
            expect(avPlayer.state).assertEqual(AVPlayerState.PAUSED);
            avPlayer.off('speedDone');
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02100 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
      avPlayer.on('speedDone', async (speed) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_02100 setSpeedTimeCallback called  is ${speed}`);
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_02200
     * @tc.name   :  on('stateChange')
     * @tc.desc   :Test video state prepare->reset->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_02200', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp3');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0200 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_Media_TesetAvPlayer_Func_0200 stateChange, state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.IDLE:
            await sleep(WAIT_TIME);
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0200 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          case AVPlayerState.INITIALIZED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0200 state is initialized called`');
            avPlayer.prepare((err) => {
              if (err != null) {
                console.error(`case SUB_Media_TesetAvPlayer_Func_0200 error, errMessage is ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0200 play state PREPARED');
              }
            });
            break;
          case AVPlayerState.PREPARED:
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED);
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_0200 avPlayer state is prepared');
            await sleep(WAIT_THOUSAND);
            await resetPromise(avPlayer);
            break;
          default:
            break;
        }
      })
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_02300
     * @tc.name   : on('stateChange')
     * @tc.desc   :Test video state INITIALIZED->reset->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_02300', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02300 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_02300 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.IDLE:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02300 state is IDLE');
            expect(avPlayer.state).assertEqual(AVPlayerState.IDLE);
            await sleep(PLAY_TIME);
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02300 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          case AVPlayerState.INITIALIZED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02300 state is initialized called');
            avPlayer.surfaceId = surfaceID;
            avPlayer.reset().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02300 reset success');
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_02400
     * @tc.name   : on('stateChange')->prepared->stop->release
     * @tc.desc   :Test video avPlayer state INITIALIZED->prepared->stop->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_02400', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02400 fdSrc ' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_02400  state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.IDLE:
            expect(avPlayer.state).assertEqual(AVPlayerState.IDLE);
            break;
          case AVPlayerState.INITIALIZED:
            avPlayer.surfaceId = surfaceID;
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02400 play state is initialized called');
            avPlayer.prepare((err: BusinessError) => {
              if (err != null) {
                console.error(`case SUB_ArkUIX_Media_TestAvPlayer_Func_02400 error, errMessage is ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02400 play state is prepared');
              }
            });
            break;
          case AVPlayerState.PREPARED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02400 avPlayer state is PREPARED');
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED);
            await sleep(PLAY_TIME);
            avPlayer.stop();
            break;
          case AVPlayerState.STOPPED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02400 avPlayer state is STOPPED');
            expect(avPlayer.state).assertEqual(AVPlayerState.STOPPED);
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02400 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
    })

    /**
     * @tc.number : SUB_Media_AVPlayer_02500
     * @tc.name   : on('timeUpdate')
     * @tc.desc   :Test video timeUpdate event
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_02500', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_Media_AVPlayer_02500  createAVPlayer ' + avPlayer.state);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_Media_AVPlayer_02500 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_Media_AVPlayer_02500 stateChange, state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            avPlayer.surfaceId = surfaceID;
            console.info('SUB_Media_AVPlayer_02500 state is initialized called');
            avPlayer.prepare((err) => {
              if (err != null) {
                console.error(`SUB_Media_AVPlayer_02500  prepare error, errMessage is ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info('SUB_Media_AVPlayer_02500 state is prepared');
              }
            });
            break;
          case AVPlayerState.PREPARED:
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED);
            console.info('SUB_Media_AVPlayer_02500 avPlayer state is prepared');
            avPlayer.play()
            break;
          case AVPlayerState.PLAYING:
            avPlayer.on('timeUpdate', async (time) => {
              console.info(`case SUB_Media_AVPlayer_02500 timeUpdate called ${time}`);
            });
            await sleep(PLAY_TIME);
            avPlayer.pause();
            break;
          case AVPlayerState.PAUSED:
            console.info('SUB_Media_AVPlayer_02500 state is PAUSED');
            expect(avPlayer.state).assertEqual(AVPlayerState.PAUSED);
            avPlayer.off('timeUpdate');
            await avPlayer.release().then(() => {
              console.info('SUB_Media_AVPlayer_02500 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
    })

    /**
     * @tc.number : SUB_Media_AVPlayer_02600
     * @tc.name   : on('videoSizeChange')
     * @tc.desc   :Test video videoSizeChange event
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_02600', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_Media_AVPlayer_02600  createAVPlayer ' + avPlayer.state);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_Media_AVPlayer_02600 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_Media_AVPlayer_02600 stateChange, state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            avPlayer.surfaceId = surfaceID;
            console.info('SUB_Media_AVPlayer_02600 state is initialized called');
            avPlayer.prepare((err) => {
              if (err != null) {
                console.error(`SUB_Media_AVPlayer_02600  prepare error, errMessage is ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info('SUB_Media_AVPlayer_02600 state is prepared');
              }
            });
            avPlayer.on('videoSizeChange', async (width, height) => {
              console.info(`case SUB_Media_AVPlayer_02600 videoSizeChange called ${width},${height}`);
            });
            break;
          case AVPlayerState.PREPARED:
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED);
            console.info('SUB_Media_AVPlayer_02600 avPlayer state is prepared')
            avPlayer.play();
            break;
          case AVPlayerState.PLAYING:
            expect(avPlayer.state).assertEqual(AVPlayerState.PLAYING);
            setTimeout(() => {
              avPlayer.pause();
            }, PLAY_TIME);
            break;
          case AVPlayerState.PAUSED:
            console.info('SUB_Media_AVPlayer_02600 state is PAUSED')
            expect(avPlayer.state).assertEqual(AVPlayerState.PAUSED);
            avPlayer.off('videoSizeChange');
            await avPlayer.release().then(() => {
              console.info('SUB_Media_AVPlayer_02600 avPlayer is release')
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
    })

    /**
     * @tc.number : SUB_Media_AVPlayer_02700
     * @tc.name   : on('durationUpdate')
     * @tc.desc   : Test video durationUpdate event
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_02700', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_Media_AVPlayer_02700 createAVPlayer ' + avPlayer.state);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_Media_AVPlayer_02700 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_Media_AVPlayer_02700 stateChange, state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            avPlayer.surfaceId = surfaceID;
            console.info('SUB_Media_AVPlayer_02700 state is initialized called');
            avPlayer.prepare((err) => {
              if (err != null) {
                console.error(`SUB_Media_AVPlayer_02700  prepare error, errMessage is ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info('SUB_Media_AVPlayer_02700 state is prepared');
              }
            });
            avPlayer.on('durationUpdate', async (duration) => {
              console.info(`case SUB_Media_AVPlayer_02700 durationUpdate !!!!!called ${duration}`);
            });
            break;
          case AVPlayerState.PREPARED:
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED);
            console.info('SUB_Media_AVPlayer_02700 avPlayer state is prepared');
            avPlayer.play();
            break;
          case AVPlayerState.PLAYING:
            expect(avPlayer.state).assertEqual(AVPlayerState.PLAYING);
            avPlayer.pause()
            break;
          case AVPlayerState.PAUSED:
            console.info('SUB_Media_AVPlayer_02700 state is PAUSED');
            expect(avPlayer.state).assertEqual(AVPlayerState.PAUSED);
            avPlayer.off('durationUpdate');
            await avPlayer.release().then(() => {
              console.info('SUB_Media_AVPlayer_02700 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
    })

    /**
     * @tc.number : SUB_Media_AVPlayer_02800
     * @tc.name   : on('endOfStream')
     * @tc.desc   : Test video audioInterrupt event
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_02800', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02800  createAVPlayer ' + avPlayer.state);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02800 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('endOfStream', () => {
        console.info(' SUB_ArkUIX_Media_TestAvPlayer_Func_02800 called endOfStream');
      })
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_02800  state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_02800 initialized called`);
            expect(avPlayer.state).assertEqual(AVPlayerState.INITIALIZED);
            avPlayer.surfaceId = surfaceID;
            avPlayer.prepare();
            break;
          case AVPlayerState.PREPARED:
            console.info('case SUB_ArkUIX_Media_TestAvPlayer_Func_02800 prepared called');
            avPlayer.play();
            break;
          case AVPlayerState.PLAYING:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02800 playing called');
            await sleep(WAIT_TIME);
            avPlayer.loop = false;
            avPlayer.seek(avPlayer.duration, media.SeekMode.SEEK_NEXT_SYNC)
            break;
          case AVPlayerState.COMPLETED:
            console.info('case SUB_ArkUIX_Media_TestAvPlayer_Func_02800 completed called');
            expect(avPlayer.state).assertEqual(AVPlayerState.COMPLETED);
            expect(avPlayer.currentTime).assertEqual(avPlayer.duration);
            avPlayer.off('endOfStream');
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_02800 avPlayer is released')
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
      avPlayer.on('error', async (err) => {
        console.error(`case SUB_ArkUIX_Media_TestAvPlayer_Func_02800 error called, errMessage is ${err.message}`);
        await avPlayer.release().then(() => {
          done();
        });
      });
    })

    /**
     * @tc.number : SUB_Media_AVPlayer_02900
     * @tc.name   : videoScaleType
     * @tc.desc   : Test video videoScaleType
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_02900', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_Media_AVPlayer_02900 createAVPlayer ' + avPlayer.state);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_Media_AVPlayer_02900 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_Media_AVPlayer_02900 stateChange, state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            console.info(`case SUB_Media_AVPlayer_02900 AV_PLAYER_STATE.INITIALIZED`);
            expect(avPlayer.state).assertEqual(AVPlayerState.INITIALIZED);
            avPlayer.surfaceId = surfaceID;
            avPlayer.prepare()
            break;
          case AVPlayerState.PREPARED:
            console.info('case SUB_Media_AVPlayer_02900 prepare called');
            avPlayer.play();
            break;
          case AVPlayerState.PLAYING:
            console.info('case SUB_Media_AVPlayer_02900 playing called');
            await sleep(WAIT_THOUSAND)
            avPlayer.videoScaleType = media.VideoScaleType.VIDEO_SCALE_TYPE_FIT;
            avPlayer.pause();
            break;
          case AVPlayerState.PAUSED:
            console.info('case SUB_Media_AVPlayer_02900 state is PAUSED');
            expect(avPlayer.state).assertEqual(AVPlayerState.PAUSED);
            expect(avPlayer.videoScaleType).assertEqual(0);
            await avPlayer.release().then(() => {
              console.info('SUB_Media_AVPlayer_02900 avPlayer is released')
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_03000
     * @tc.name   : prepare->pause->release
     * @tc.desc   : Test avPlayer Using callback interface prepare->play->pause->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_03000', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_03000 createAVPlayer' + avPlayer.state);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp3');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_03000 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state: string, reason: media.StateChangeReason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_03000  state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_03000 avPlayer is initialized.');
            prepareCallback(avPlayer);
            break;
          case AVPlayerState.PREPARED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_03000 avPlayer is prepared.');
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED);
            await playCallback(avPlayer);
            break;
          case AVPlayerState.PLAYING:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_03000 avPlayer is playing.');
            expect(avPlayer.state).assertEqual(AVPlayerState.PLAYING);
            await sleep(WAIT_TIME);
            await pauseCallback(avPlayer);
            break;
          case AVPlayerState.PAUSED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_03000 avPlayer is paused.');
            expect(avPlayer.state).assertEqual(AVPlayerState.PAUSED);
            await sleep(WAIT_TIME);
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_03000 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_03100
     * @tc.name   : prepare->play->pause->stop->release
     * @tc.desc   : Test avPlayer Using callback interface prepare->play->pause->stop->release
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_03100', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_03100 createAVPlayer ' + avPlayer.state);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp3');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_03100 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state: string, reason: media.StateChangeReason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_03100  state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_03100 state initialized called.');
            prepareCallback(avPlayer);
            break;
          case AVPlayerState.PREPARED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_03100 state prepared called.');
            expect(avPlayer.state).assertEqual(AVPlayerState.PREPARED);
            await playCallback(avPlayer);
            break;
          case AVPlayerState.PLAYING:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_03100 state playing called.');
            expect(avPlayer.state).assertEqual(AVPlayerState.PLAYING);
            await sleep(PLAY_TIME);
            await pauseCallback(avPlayer);
            break;
          case AVPlayerState.PAUSED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_03100 state paused called.');
            expect(avPlayer.state).assertEqual(AVPlayerState.PAUSED);
            await stopCallback(avPlayer);
            break;
          case AVPlayerState.STOPPED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_03100 state stopped called.');
            expect(avPlayer.state).assertEqual(AVPlayerState.STOPPED);
            await sleep(WAIT_TIME);
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_03100 state released called');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
          default:
            break;
        }
      })
    })

    /**
     * @tc.number : SUB_Media_AVPlayer_03200
     * @tc.name   : createAVPlayer
     * @tc.desc   : Test avplayer createAVPlayer interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_03200', 0, async (done: Function) => {
      let avplayer: media.AVPlayer;
      await media.createAVPlayer().then((video: media.AVPlayer) => {
        if (video != null) {
          avplayer = video;
          console.info('SUB_Media_AVPlayer_03200 createAVRecorder success');
          expect(avplayer != null).assertTrue();
        } else {
          console.error('SUB_Media_AVPlayer_03200 createAVRecorder fail');
        }
        done();
      })
    })

    /**
     * @tc.number : SUB_Media_AVPlayer_03300
     * @tc.name   : createAVPlayer
     * @tc.desc   : Test avplayer createAVPlayer interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_03300', 0, async (done: Function) => {
      let avplayer: media.AVPlayer;
      media.createAVPlayer((error, video: media.AVPlayer) => {
        if (video != null) {
          avplayer = video;
          console.info('SUB_Media_AVPlayer_03300 createAVRecorder success');
          expect(avplayer != null).assertTrue();
        } else {
          console.info(`SUB_Media_AVPlayer_03300 createAVRecorder fail, error:${error}`);
        }
      })
      done();
    })

    /**
     * @tc.number : SUB_Media_AVPlayer_03400
     * @tc.name   : prepare
     * @tc.desc   : Test avPlayer prepare interface
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_03400', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      await avPlayer.prepare().then(() => {
        console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_03400 prepare create success');
        expect().assertFail();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_ArkUIX_Media_TestAvPlayer_Func_03400 create fail ${err.code},message is ${err.message}`);
        expect(err.code == 5400102).assertTrue();
        done();
      });
    })

    /**
     * @tc.number : SUB_Media_AVPlayer_03500
     * @tc.name   : prepare
     * @tc.desc   : Test avPlayer prepare interface
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_03500', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      avPlayer.prepare((err) => {
        if (err == null) {
          expect().assertFail();
          done();
          console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_03500 prepare success');
        } else {
          console.log(`SUB_ArkUIX_Media_TestAvPlayer_Func_03500 create fail ${err.code},message is ${err.message}`);
          expect(err.code == 5400102).assertTrue();
        }
      })
      done();
    })

    /**
     * @tc.number : SUB_Media_AVPlayer_03600
     * @tc.name   : play
     * @tc.desc   : Test avPlayer play interface
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_03600', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      await avPlayer.play().then(() => {
        console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_03600 play create success');
        expect().assertFail();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_ArkUIX_Media_TestAvPlayer_Func_03600 create fail ${err.code},message is ${err.message}`);
        expect(err.code == 5400102).assertTrue();
        done();
      });
    })

    /**
     * @tc.number : SUB_Media_AVPlayer_03700
     * @tc.name   : play
     * @tc.desc   : Test avPlayer play interface
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_03700', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      avPlayer.play((err) => {
        if (err == null) {
          console.error(`case SUB_ArkUIX_Media_TestAvPlayer_Func_03700 play success state is ${avPlayer.state}`);
          expect().assertFail();
          done();
        } else {
          console.log(`SUB_ArkUIX_Media_TestAvPlayer_Func_03700 create fail ${err.code},message is ${err.message}`);
          expect(err.code == 5400102).assertTrue();
        }
      })
      done();
    })

    /**
     * @tc.number : SUB_Media_AVPlayer_03800
     * @tc.name   : pause
     * @tc.desc   : Test avPlayer pause interface
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_03800', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      await avPlayer.pause().then(() => {
        console.error(`case SUB_ArkUIX_Media_TestAvPlayer_Func_03800 create pause success state is ${avPlayer.state}`);
        expect().assertFail();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_ArkUIX_Media_TestAvPlayer_Func_03800 create fail ${err.code},message is ${err.message}`);
        expect(err.code == 5400102).assertTrue();
        done();
      });
    })

    /**
     * @tc.number : SUB_Media_AVPlayer_03900
     * @tc.name   : pause
     * @tc.desc   : Test avPlayer pause interface
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_03900', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      avPlayer.pause((err) => {
        if (err == null) {
          console.error(`case SUB_ArkUIX_Media_TestAvPlayer_Func_03900 create pause success state is ${avPlayer.state}`);
          expect().assertFail();
          done();
        } else {
          console.log(`SUB_ArkUIX_Media_TestAvPlayer_Func_03900 create fail ${err.code},message is ${err.message}`);
          expect(err.code == 5400102).assertTrue();
        }
      })
      done();
    })

    /**
     * @tc.number : SUB_Media_AVPlayer_04000
     * @tc.name   : stop
     * @tc.desc   : Test avPlayer stop interface
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_04000', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      await avPlayer.stop().then(() => {
        console.error(`case SUB_ArkUIX_Media_TestAvPlayer_Func_04000 create stop success state is ${avPlayer.state}`);
        expect().assertFail();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_ArkUIX_Media_TestAvPlayer_Func_04000 create fail ${err.code},message is ${err.message}`);
        expect(err.code == 5400102).assertTrue();
        done();
      });
    })

    /**
     * @tc.number : SUB_Media_AVPlayer_04100
     * @tc.name   : stop
     * @tc.desc   : Test avPlayer stop interface
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_04100', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      avPlayer.stop((err) => {
        if (err == null) {
          console.error(`case SUB_ArkUIX_Media_TestAvPlayer_Func_04100 create stop success state is ${avPlayer.state}`);
          expect().assertFail();
          done();
        } else {
          console.log(`SUB_ArkUIX_Media_TestAvPlayer_Func_04100 create fail ${err.code},message is ${err.message}`);
          expect(err.code == 5400102).assertTrue();
        }
      })
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_04200
     * @tc.name   : test play source
     * @tc.desc   : Http playback control test
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_04200', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04200 createAVPlayer' + avPlayer.state);
      avPlayer.url = 'http://stream4.iqilu.com/ksd/video/2020/02/17/87d03387a05a0e8aa87370fb4c903133.mp4';
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04200 fdSrc' + avPlayer.url);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_04200 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04200 state initialized called.');
            avPlayer.surfaceId = surfaceID;
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04200 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_04300
     * @tc.name   : test play source
     * @tc.desc   : Https playback control test
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_04300', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      avPlayer.url =
        'https://vd4.bdstatic.com/mda-qbsawcwu6nereq3z/540p/h264_cae/1709019683474692407/mda-qbsawcwu6nereq3z.mp4';
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04300 fdSrc' + avPlayer.url);
      avPlayer.on('stateChange', async (state: string, reason: media.StateChangeReason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_04300 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04300 state initialized called.');
            avPlayer.surfaceId = surfaceID;
            await sleep(WAIT_TIME);
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04300 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_04400
     * @tc.name   : test play source
     * @tc.desc   : Https playback control test
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_04400', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      avPlayer.url =
        'https://vd4.bdstatic.com/mda-qbsawcwu6nereq3z/540p/h264_cae/1709019683474692407/mda-qbsawcwu6nereq3z.mp4';
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04400 fdSrc' + avPlayer.url)
      avPlayer.on('stateChange', async (state: string, reason: media.StateChangeReason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_04400 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.IDLE:
            break;
          case AVPlayerState.INITIALIZED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04400 state initialized called.');
            avPlayer.surfaceId = surfaceID;
            await sleep(WAIT_THOUSAND)
            await avPlayer.prepare().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04400 prepare success');
            }).catch((err: BusinessError) => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04400 prepare failed and catch error is ' + err.message);
              expect().assertFail();
              done();
            });
            break;
          case AVPlayerState.PREPARED:
            await sleep(WAIT_THOUSAND)
            await avPlayer.release().then(() => {
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04400 avPlayer is release');
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_04500
     * @tc.name   : test play source
     * @tc.desc   : http playback control test
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_04500', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04500  createAVPlayer ' + avPlayer.state);
      avPlayer.url = 'http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8';
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04500 fdSrc' + avPlayer.url)
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_04500 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.IDLE:
            break;
          case AVPlayerState.INITIALIZED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04500 state initialized called.');
            avPlayer.surfaceId = surfaceID;
            await avPlayer.release().then(() => {
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04500 avPlayer is release');
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
    })


    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_04600
     * @tc.name   : dataSrc
     * @tc.desc   : Test avPlayer dataSrc
     * @tc.level  : Level 1
     */
    /* IOS does not support dataSrc (IOS不支持dataSrc功能) */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_04600', 0, async (done: Function) => {
      if (platform == "Android") {
        avPlayer = await idle(avPlayer);
        console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04600 createAVPlayer' + avPlayer.state);
        let src: media.AVDataSrcDescriptor = {
          fileSize: -1,
          callback: (buf: ArrayBuffer, length: number) => {
            console.info('readAt length:' + length);
            let num = 0;
            if (buf == undefined || length == undefined) {
              expect().assertFail();
              return -1;
            }
            num = fs.readSync(fd, buf, {
              offset: offsetValue, length: length
            });
            console.info('readAt num:' + num);
            if (num > 0) {
              return num;
            }
            return -1;
          }
        }
        let fileDescriptor = await context.resourceManager.getRawFd('test2.mp3');
        let fd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
        let offsetValue: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
        let fileSize: number = JSON.parse(JSON.stringify(fileDescriptor))['length'];
        src.fileSize = fileSize;
        avPlayer.dataSrc = src;
        console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04600 fdSrc' + avPlayer.dataSrc);
        avPlayer.on('stateChange', async (state, reason) => {
          console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_04600  state is ${state}, reason is ${reason}`);
          switch (state) {
            case AVPlayerState.IDLE:
              break;
            case AVPlayerState.INITIALIZED:
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04600 state is INITIALIZED');
              await avPlayer.release().then(() => {
                console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04600 avPlayer is release');
                expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
                done();
              }, failureCallback).catch(catchCallback);
              break;
            default:
              break;
          }
        });
      } else if (platform == "iOS") {
        done()
      } else {
        done()
      }
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_04700
     * @tc.name   : videoScaleType
     * @tc.desc   : Test video videoScaleType:VIDEO_SCALE_TYPE_FIT_CROP
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_04700', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04700 createAVPlayer ' + avPlayer.state);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor =
        {
          fd: fileFd, offset: fileOffset, length: -1
        };
      avPlayer.fdSrc = avFileDescriptor;
      console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04700 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_04700 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_04700 AV_PLAYER_STATE.INITIALIZED`);
            expect(avPlayer.state).assertEqual(AVPlayerState.INITIALIZED);
            avPlayer.surfaceId = surfaceID;
            avPlayer.prepare()
            break;
          case AVPlayerState.PREPARED:
            console.info('case SUB_ArkUIX_Media_TestAvPlayer_Func_04700 prepare called');
            avPlayer.play();
            break;
          case AVPlayerState.PLAYING:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04700 playing called');
            await sleep(WAIT_THOUSAND)
            avPlayer.videoScaleType = media.VideoScaleType.VIDEO_SCALE_TYPE_FIT_CROP;
            avPlayer.pause();
            break;
          case AVPlayerState.PAUSED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04700 state is PAUSED');
            expect(avPlayer.state).assertEqual(AVPlayerState.PAUSED);
            expect(avPlayer.videoScaleType).assertEqual(1);
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04700 avPlayer is released')
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      });
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_04800
     * @tc.name   : url
     * @tc.desc   : Test avPlayer Supports audio formats m4a
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_04800', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      let fdPath = 'fd://';
      let fileDescriptor = await context.resourceManager.getRawFd('test4.m4a');
      fdPath += JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      avPlayer.url = fdPath;
      console.info(' SUB_ArkUIX_Media_TestAvPlayer_Func_04800 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_04800 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.IDLE:
            break;
          case AVPlayerState.INITIALIZED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04800 state is INITIALIZED');
            await sleep(WAIT_TIME);
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04800 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_04900
     * @tc.name   : url
     * @tc.desc   : Test avPlayer Supports Video formats mkv
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_04900', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      let fdPath = 'fd://';
      let fileDescriptor = await context.resourceManager.getRawFd('test5.mkv');
      fdPath += JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      avPlayer.url = fdPath;
      console.info(' SUB_ArkUIX_Media_TestAvPlayer_Func_04900 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_04900 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.IDLE:
            break;
          case AVPlayerState.INITIALIZED:
            avPlayer.surfaceId = surfaceID;
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04900 state is INITIALIZED');
            await sleep(WAIT_TIME);
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_04900 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_05000
     * @tc.name   : url
     * @tc.desc   : Test avPlayer Supports audio formats aac
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_05000', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      let fdPath = 'fd://';
      let fileDescriptor = await context.resourceManager.getRawFd('test6.aac');
      fdPath += JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      avPlayer.url = fdPath;
      console.info(' SUB_ArkUIX_Media_TestAvPlayer_Func_05000 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_05000 state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.IDLE:
            break;
          case AVPlayerState.INITIALIZED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_05000 state is INITIALIZED');
            await sleep(WAIT_TIME);
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_05000 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
    })

    /**
     * @tc.number : SUB_ArkUIX_Media_TestAvPlayer_Func_05100
     * @tc.name   : url
     * @tc.desc   : Test avPlayer Supports audio formats ogg
     * @tc.level  : Level 1
     */
    it('SUB_ArkUIX_Media_TestAvPlayer_Func_05100', 0, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      let fdPath = 'fd://';
      let fileDescriptor = await context.resourceManager.getRawFd('test9.ogg');
      fdPath += JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      avPlayer.url = fdPath;
      console.info(' SUB_ArkUIX_Media_TestAvPlayer_Func_05100 fdSrc' + avPlayer.fdSrc);
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`case SUB_ArkUIX_Media_TestAvPlayer_Func_05100  state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.IDLE:
            break;
          case AVPlayerState.INITIALIZED:
            console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_05100 state is INITIALIZED');
            await avPlayer.release().then(() => {
              console.info('SUB_ArkUIX_Media_TestAvPlayer_Func_05100 avPlayer is release');
              expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
              done();
            }, failureCallback).catch(catchCallback);
            break;
          default:
            break;
        }
      })
    })
  })
}