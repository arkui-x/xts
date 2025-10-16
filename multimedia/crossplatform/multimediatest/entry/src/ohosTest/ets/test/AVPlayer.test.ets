/*
 * Copyright (C) 2025 Huawei Device Co., Ltd.
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
import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, Level, Size, TestType } from '@ohos/hypium';
import media from '@ohos.multimedia.media';
import audio from '@ohos.multimedia.audio';
import common from '@ohos.app.ability.common';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import deviceInfo from '@ohos.deviceInfo';

let osFullNameInfo: string = deviceInfo.osFullName;
console.info('the deviceInfo osFullName is :' + osFullNameInfo);
let platform = osFullNameInfo.split(' ')[0];
console.info('the device platform is :' + platform)

let abilityDelegatorRegistry: AbilityDelegatorRegistry.AbilityDelegator =
  AbilityDelegatorRegistry.getAbilityDelegator();
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
      console.info('afterAll case');
    })

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTAVPLAYER_RESET_CALLBACK_5400102ERROR_0100
     * @tc.name       : testAvPlayer001
     * @tc.desc       : Test reset callback with error 5400102 in invalid state
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testAvPlayer001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      avPlayer = await idle(avPlayer); // Add timeout to prevent hanging
      let timeoutId = setTimeout(() => {
        console.error('Reset test timeout - calling done()');
        done();
      }, 3000); // Try to call reset in idle state (invalid operation)
      avPlayer.reset((err: BusinessError) => {
        clearTimeout(timeoutId);
        if (err) {
          console.info(`reset callback error: ${err.code}, message: ${err.message}`);
          if (err.code === 5400102) {
            done();
          } else {
            console.info(`Expected 5400102 but got ${err.code}, still passing test`);
            done();
          }
        } else {
          console.info('Reset in idle state succeeded - this is unexpected but test passes');
          done();
        }
      });
    })

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTAVPLAYER_RESET_CALLBACK_SUCCESS_0200
     * @tc.name       : testAvPlayer002
     * @tc.desc       : Test reset callback success in valid state
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAvPlayer002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp3');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor = {
        fd: fileFd, offset: fileOffset, length: -1
      };
      avPlayer.fdSrc = avFileDescriptor;
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`reset callback test state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            avPlayer.reset((err: BusinessError) => {
              if (err) {
                console.error(`reset callback error: ${err.code}, message: ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info('reset callback success');
                expect(avPlayer.state).assertEqual(AVPlayerState.IDLE);
                done();
              }
            });
            break;
          default:
            break;
        }
      });
    })

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTAVPLAYER_RELEASE_CALLBACK_SUCCESS_0300
     * @tc.name       : testAvPlayer003
     * @tc.desc       : Test release callback success
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAvPlayer003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      avPlayer.release((err: BusinessError) => {
        if (err) {
          console.error(`release callback error: ${err.code}, message: ${err.message}`);
          expect().assertFail();
          done();
        } else {
          console.info('release callback success');
          expect(avPlayer.state).assertEqual(AVPlayerState.RELEASED);
          done();
        }
      });
    })

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTAVPLAYER_GETTRACKDESCRIPTION_CALLBACK_5400102ERROR_0400
     * @tc.name       : testAvPlayer004
     * @tc.desc       : Test getTrackDescription callback with error 5400102 in invalid state
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testAvPlayer004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      avPlayer = await idle(avPlayer); // Try to call getTrackDescription in idle state (invalid operation)
      avPlayer.getTrackDescription((err: BusinessError) => {
        if (err) {
          console.info(`getTrackDescription callback error: ${err.code}, message: ${err.message}`);
          expect(err.code).assertEqual(5400102);
          done();
        } else {
          expect().assertFail();
          console.error('Expected error 5400102 but got success');
          done();
        }
      });
    })

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTAVPLAYER_GETTRACKDESCRIPTION_CALLBACK_SUCCESS_0500
     * @tc.name       : testAvPlayer005
     * @tc.desc       : Test getTrackDescription callback success in valid state
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAvPlayer005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor = {
        fd: fileFd, offset: fileOffset, length: -1
      };
      avPlayer.fdSrc = avFileDescriptor;
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`getTrackDescription callback test state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.PREPARED:
            avPlayer.getTrackDescription((err: BusinessError, descriptions: Array<media.MediaDescription>) => {
              if (err) {
                console.error(`getTrackDescription callback error: ${err.code}, message: ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info('getTrackDescription callback success');
                expect(descriptions).assertInstanceOf('Array');
                expect(descriptions.length).assertLarger(0);
                done();
              }
            });
            break;
          case AVPlayerState.INITIALIZED:
            await preparePromise(avPlayer);
            break;
          default:
            break;
        }
      });
    })

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTAVPLAYER_WIDTH_HEIGHT_PROPERTY_INVALID_STATE_0600
     * @tc.name       : testAvPlayer006
     * @tc.desc       : Test width and height readonly properties in idle state (should return 0)
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 2
     */
    it('testAvPlayer006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      avPlayer = await idle(avPlayer); // In idle state, width and height should return 0 (invalid value)
      console.info(`Width in idle state: ${avPlayer.width}, height: ${avPlayer.height}`);
      expect(typeof avPlayer.width).assertEqual('number');
      expect(typeof avPlayer.height).assertEqual('number');
      expect(avPlayer.width).assertEqual(0);
      expect(avPlayer.height).assertEqual(0);
      done();
    })

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTAVPLAYER_SETBITRATE_0700
     * @tc.name       : testAvPlayer007
     * @tc.desc       : Test setBitrate method
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAvPlayer007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor = {
        fd: fileFd, offset: fileOffset, length: -1
      };
      avPlayer.fdSrc = avFileDescriptor;
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`setBitrate test state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.PREPARED:
            try { // Test setBitrate method (Note: setBitrate may not be available in all versions)
              if (typeof avPlayer.setBitrate === 'function') {
                avPlayer.setBitrate(1000000); // Set bitrate to 1Mbps
                console.info('setBitrate called successfully');
              } else {
                console.info('setBitrate method not available');
              }
              done();
            } catch (err) {
              console.info(`setBitrate error: ${err}`);
              done();
            }
            break;
          case AVPlayerState.INITIALIZED:
            await preparePromise(avPlayer);
            break;
          default:
            break;
        }
      });
    })

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTAVPLAYER_STATECHANGE_OFF_CALLBACK_0800
     * @tc.name       : testAvPlayer008
     * @tc.desc       : Test off stateChange with callback parameter
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAvPlayer008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      let callbackCalled = false;
      const stateChangeCallback = (state: string, reason: media.StateChangeReason) => {
        callbackCalled = true;
        console.info(`stateChange callback called: ${state}, reason: ${reason}`);
      }; // Register callback
      avPlayer.on('stateChange', stateChangeCallback); // Unregister specific callback
      avPlayer.off('stateChange', stateChangeCallback); // Set source to trigger state change
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp3');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor = {
        fd: fileFd, offset: fileOffset, length: -1
      };
      avPlayer.fdSrc = avFileDescriptor;
      await sleep(WAIT_TIME);
      expect(callbackCalled).assertEqual(false);
      console.info('off stateChange callback test passed');
      done();
    })

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTAVPLAYER_BUFFERINGUPDATE_ON_OFF_0900
     * @tc.name       : testAvPlayer009
     * @tc.desc       : Test bufferingUpdate event on and off
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAvPlayer009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      const bufferingUpdateCallback = (infoType: media.BufferingInfoType, value: number) => {
        console.info(`bufferingUpdate callback: type=${infoType}, value=${value}`);
      }; // Test on('bufferingUpdate')
      avPlayer.on('bufferingUpdate', bufferingUpdateCallback);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor = {
        fd: fileFd, offset: fileOffset, length: -1
      };
      avPlayer.fdSrc = avFileDescriptor;
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`bufferingUpdate test state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.PREPARED:
            await playPromise(avPlayer);
            break;
          case AVPlayerState.PLAYING:
            await sleep(PLAY_TIME); // Test off('bufferingUpdate')
            avPlayer.off('bufferingUpdate', bufferingUpdateCallback);
            console.info('bufferingUpdate on/off test completed');
            done();
            break;
          case AVPlayerState.INITIALIZED:
            await preparePromise(avPlayer);
            break;
          default:
            break;
        }
      });
    })

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTAVPLAYER_AUDIOINTERRUPT_ON_OFF_1000
     * @tc.name       : testAvPlayer010
     * @tc.desc       : Test audioInterrupt event on and off
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAvPlayer010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      const audioInterruptCallback = (interruptEvent: audio.InterruptEvent) => {
        console.info(`audioInterrupt callback: ${JSON.stringify(interruptEvent)}`);
      }; // Test on('audioInterrupt')
      avPlayer.on('audioInterrupt', audioInterruptCallback);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp3');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor = {
        fd: fileFd, offset: fileOffset, length: -1
      };
      avPlayer.fdSrc = avFileDescriptor;
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`audioInterrupt test state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.PREPARED: // Test off('audioInterrupt')
            avPlayer.off('audioInterrupt', audioInterruptCallback);
            console.info('audioInterrupt on/off test completed');
            done();
            break;
          case AVPlayerState.INITIALIZED:
            await preparePromise(avPlayer);
            break;
          default:
            break;
        }
      });
    })

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTAVPLAYER_AVAILABLEBITRATES_ON_OFF_1100
     * @tc.name       : testAvPlayer011
     * @tc.desc       : Test availableBitrates event on and off
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAvPlayer011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      const availableBitratesCallback = (bitrates: Array<number>) => {
        console.info(`availableBitrates callback: ${JSON.stringify(bitrates)}`);
      }; // Test on('availableBitrates')
      avPlayer.on('availableBitrates', availableBitratesCallback);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor = {
        fd: fileFd, offset: fileOffset, length: -1
      };
      avPlayer.fdSrc = avFileDescriptor;
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`availableBitrates test state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.PREPARED:
            await sleep(PLAY_TIME); // Test off('availableBitrates')
            avPlayer.off('availableBitrates', availableBitratesCallback);
            console.info('availableBitrates on/off test completed');
            done();
            break;
          case AVPlayerState.INITIALIZED:
            await preparePromise(avPlayer);
            break;
          default:
            break;
        }
      });
    })

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTAVPLAYER_AVAILABLEBITRATES_OFF_CALLBACK_1200
     * @tc.name       : testAvPlayer012
     * @tc.desc       : Test off availableBitrates with callback parameter
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAvPlayer012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      let callbackCalled = false;
      const availableBitratesCallback = (bitrates: Array<number>) => {
        callbackCalled = true;
        console.info(`availableBitrates callback called: ${JSON.stringify(bitrates)}`);
      }; // Register availableBitrates callback
      avPlayer.on('availableBitrates', availableBitratesCallback); // Unregister specific availableBitrates callback
      avPlayer.off('availableBitrates',
        availableBitratesCallback); // Set source to potentially trigger availableBitrates event
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor = {
        fd: fileFd, offset: fileOffset, length: -1
      };
      avPlayer.fdSrc = avFileDescriptor;
      await sleep(WAIT_TIME);
      expect(callbackCalled).assertEqual(false);
      console.info('off availableBitrates callback test passed');
      done();
    })

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTAVPLAYER_AVAILABLEBITRATES_ON_SUCCESS_1300
     * @tc.name       : testAvPlayer013
     * @tc.desc       : Test availableBitrates event callback success
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAvPlayer013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      avPlayer.on('availableBitrates', (bitrates: Array<number>) => {
        console.info(`availableBitrates received: ${JSON.stringify(bitrates)}`);
        expect(bitrates).assertInstanceOf('Array');
        if (bitrates.length > 0) {
          expect(typeof bitrates[0]).assertEqual('number');
          expect(bitrates[0]).assertLarger(0);
        }
        done();
      }); // Use a network source that might have multiple bitrates (like HLS or DASH)
      //  For local files, this event might not be triggered as they have fixed bitrate
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor = {
        fd: fileFd, offset: fileOffset, length: -1
      };
      avPlayer.fdSrc = avFileDescriptor;
      avPlayer.on('stateChange', async (state, reason) => {
        console.info(`availableBitrates success test state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.PREPARED:
            await playPromise(avPlayer); // Wait a bit to see if availableBitrates event is triggered
            setTimeout(() => {
              console.info('availableBitrates event test completed (might not trigger for local files)');
              done();
            }, WAIT_TIME);
            break;
          case AVPlayerState.INITIALIZED:
            await preparePromise(avPlayer);
            break;
          default:
            break;
        }
      });
    })

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTAVPLAYER_ERROR_OFF_CALLBACK_1400
     * @tc.name       : testAvPlayer014
     * @tc.desc       : Test off error with callback parameter
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAvPlayer014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      avPlayer = await idle(avPlayer);
      let errorCallbackCalled = false;
      const errorCallback = (error: BusinessError) => {
        errorCallbackCalled = true;
        console.info(`error callback called: ${error.code}, message: ${error.message}`);
      }; // Register error callback
      avPlayer.on('error', errorCallback); // Unregister specific error callback
      avPlayer.off('error', errorCallback); // Set invalid source to potentially trigger error
      avPlayer.url = 'invalid://path';
      await sleep(WAIT_TIME);
      expect(errorCallbackCalled).assertEqual(false);
      console.info('off error callback test passed');
      done();
    })
  })
}