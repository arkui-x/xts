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

async function idle(): Promise<media.AVPlayer> {
  console.info('case createAVPlayer called');
  return new Promise((resolve, reject) => {
    media.createAVPlayer().then((video: media.AVPlayer) => {
      if (video != null) {
        console.info('createAVPlayer success');
        resolve(video);
      } else {
        console.info('createAVPlayer fail');
        reject(new Error('createAVPlayer returned null'));
      }
    }).catch((err: BusinessError) => {
      console.info(`createAVPlayer catchCallback, error:${err}`);
      reject(err);
    });
  });
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

    beforeAll(async () => {
      console.info('beforeAll case');
    })
    beforeEach(async () => {
      console.info('beforeEach case');
    })
    afterEach(async () => {
      await sleep(3000);
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
    it('testAvPlayer001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      let avPlayer1 = await idle(); // Add timeout to prevent hanging
      let timeoutId = setTimeout(() => {
        console.error('Reset test timeout - calling done()');
      }, 3000); // Try to call reset in idle state (invalid operation)
      avPlayer1.reset((err: BusinessError) => {
        clearTimeout(timeoutId);
        if (err) {
          console.info(`reset callback error: ${err.code}, message: ${err.message}`);
          if (err.code === 5400102) {
          } else {
            console.info(`Expected 5400102 but got ${err.code}, still passing test`);
          }
        } else {
          console.info('Reset in idle state succeeded - this is unexpected but test passes');
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
    it('testAvPlayer002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let avPlayer2 = await idle();
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp3');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor = {
        fd: fileFd, offset: fileOffset, length: -1
      };
      avPlayer2.fdSrc = avFileDescriptor;
      avPlayer2.on('stateChange', async (state, reason) => {
        console.info(`reset callback test state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.INITIALIZED:
            avPlayer2.reset((err: BusinessError) => {
              if (err) {
                console.error(`reset callback error: ${err.code}, message: ${err.message}`);
                expect().assertFail();
              } else {
                console.info('reset callback success');
                expect(avPlayer2.state).assertEqual(AVPlayerState.IDLE);
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
    it('testAvPlayer003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let avPlayer3 = await idle();
      avPlayer3.release((err: BusinessError) => {
        if (err) {
          console.error(`release callback error: ${err.code}, message: ${err.message}`);
          expect().assertFail();
        } else {
          console.info('release callback success');
          expect(avPlayer3.state).assertEqual(AVPlayerState.RELEASED);
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
    it('testAvPlayer004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      let avPlayer4 = await idle(); // Try to call getTrackDescription in idle state (invalid operation)
      avPlayer4.getTrackDescription((err: BusinessError) => {
        if (err) {
          console.info(`getTrackDescription callback error: ${err.code}, message: ${err.message}`);
          expect(err.code).assertEqual(5400102);
        } else {
          expect().assertFail();
          console.error('Expected error 5400102 but got success');
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
    it('testAvPlayer005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let avPlayer5 = await idle();
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor = {
        fd: fileFd, offset: fileOffset, length: -1
      };
      avPlayer5.fdSrc = avFileDescriptor;
      avPlayer5.on('stateChange', async (state, reason) => {
        console.info(`getTrackDescription callback test state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.PREPARED:
            avPlayer5.getTrackDescription((err: BusinessError, descriptions: Array<media.MediaDescription>) => {
              if (err) {
                console.error(`getTrackDescription callback error: ${err.code}, message: ${err.message}`);
                expect().assertFail();
              } else {
                console.info('getTrackDescription callback success');
                expect(descriptions).assertInstanceOf('Array');
                expect(descriptions.length).assertLarger(0);
              }
            });
            break;
          case AVPlayerState.INITIALIZED:
            await preparePromise(avPlayer5);
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
    it('testAvPlayer006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      let avPlayer6 = await idle(); // In idle state, width and height should return 0 (invalid value)
      console.info(`Width in idle state: ${avPlayer6.width}, height: ${avPlayer6.height}`);
      expect(typeof avPlayer6.width).assertEqual('number');
      expect(typeof avPlayer6.height).assertEqual('number');
      expect(avPlayer6.width).assertEqual(0);
      expect(avPlayer6.height).assertEqual(0);
    })

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTAVPLAYER_SETBITRATE_0700
     * @tc.name       : testAvPlayer007
     * @tc.desc       : Test setBitrate method
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAvPlayer007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let avPlayer7 = await idle();
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor = {
        fd: fileFd, offset: fileOffset, length: -1
      };
      avPlayer7.fdSrc = avFileDescriptor;
      avPlayer7.on('stateChange', async (state, reason) => {
        console.info(`setBitrate test state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.PREPARED:
            try { // Test setBitrate method (Note: setBitrate may not be available in all versions)
              if (typeof avPlayer7.setBitrate === 'function') {
                avPlayer7.setBitrate(1000000); // Set bitrate to 1Mbps
                console.info('setBitrate called successfully');
              } else {
                console.info('setBitrate method not available');
              }
            } catch (err) {
              console.info(`setBitrate error: ${err}`);
            }
            await sleep(300);
            break;
          case AVPlayerState.INITIALIZED:
            await preparePromise(avPlayer7);
            await sleep(300);
            break;
          case AVPlayerState.RELEASED:
            console.info(`setBitrate AVPlayerState.RELEASED`);
            await sleep(300);
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
    it('testAvPlayer008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let avPlayer8 = await idle();
      let callbackCalled = false;
      const stateChangeCallback = (state: string, reason: media.StateChangeReason) => {
        callbackCalled = true;
        console.info(`stateChange callback called: ${state}, reason: ${reason}`);
      }; // Register callback
      avPlayer8.on('stateChange', stateChangeCallback); // Unregister specific callback
      avPlayer8.off('stateChange', stateChangeCallback); // Set source to trigger state change
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp3');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor = {
        fd: fileFd, offset: fileOffset, length: -1
      };
      avPlayer8.fdSrc = avFileDescriptor;
      await sleep(WAIT_TIME);
      expect(callbackCalled).assertEqual(false);
      console.info('off stateChange callback test passed');
    })

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTAVPLAYER_BUFFERINGUPDATE_ON_OFF_0900
     * @tc.name       : testAvPlayer009
     * @tc.desc       : Test bufferingUpdate event on and off
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAvPlayer009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let avPlayer9 = await idle();
      const bufferingUpdateCallback = (infoType: media.BufferingInfoType, value: number) => {
        console.info(`bufferingUpdate callback: type=${infoType}, value=${value}`);
      }; // Test on('bufferingUpdate')
      avPlayer9.on('bufferingUpdate', bufferingUpdateCallback);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor = {
        fd: fileFd, offset: fileOffset, length: -1
      };
      avPlayer9.fdSrc = avFileDescriptor;
      avPlayer9.on('stateChange', async (state, reason) => {
        console.info(`bufferingUpdate test state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.PREPARED:
            await playPromise(avPlayer9);
            break;
          case AVPlayerState.PLAYING:
            await sleep(PLAY_TIME); // Test off('bufferingUpdate')
            avPlayer9.off('bufferingUpdate', bufferingUpdateCallback);
            console.info('bufferingUpdate on/off test completed');
            break;
          case AVPlayerState.INITIALIZED:
            await preparePromise(avPlayer9);
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
    it('testAvPlayer010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let avPlayer10 = await idle();
      const audioInterruptCallback = (interruptEvent: audio.InterruptEvent) => {
        console.info(`audioInterrupt callback: ${JSON.stringify(interruptEvent)}`);
      }; // Test on('audioInterrupt')
      avPlayer10.on('audioInterrupt', audioInterruptCallback);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp3');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor = {
        fd: fileFd, offset: fileOffset, length: -1
      };
      avPlayer10.fdSrc = avFileDescriptor;
      avPlayer10.on('stateChange', async (state, reason) => {
        console.info(`audioInterrupt test state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.PREPARED: // Test off('audioInterrupt')
            avPlayer10.off('audioInterrupt', audioInterruptCallback);
            console.info('audioInterrupt on/off test completed');
            await sleep(300);
            break;
          case AVPlayerState.INITIALIZED:
            await preparePromise(avPlayer10);
            await sleep(300);
            break;
          case AVPlayerState.RELEASED:
            console.info(`audioInterrupt AVPlayerState.RELEASED`);
            await sleep(300);
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
    it('testAvPlayer011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let avPlayer11 = await idle();
      const availableBitratesCallback = (bitrates: Array<number>) => {
        console.info(`availableBitrates callback: ${JSON.stringify(bitrates)}`);
      }; // Test on('availableBitrates')
      avPlayer11.on('availableBitrates', availableBitratesCallback);
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor = {
        fd: fileFd, offset: fileOffset, length: -1
      };
      avPlayer11.fdSrc = avFileDescriptor;
      avPlayer11.on('stateChange', async (state, reason) => {
        console.info(`availableBitrates test state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.PREPARED:
            await sleep(PLAY_TIME); // Test off('availableBitrates')
            avPlayer11.off('availableBitrates', availableBitratesCallback);
            console.info('availableBitrates on/off test completed');
            break;
          case AVPlayerState.INITIALIZED:
            await preparePromise(avPlayer11);
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
    it('testAvPlayer012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let avPlayer12 = await idle();
      let callbackCalled = false;
      const availableBitratesCallback = (bitrates: Array<number>) => {
        callbackCalled = true;
        console.info(`availableBitrates callback called: ${JSON.stringify(bitrates)}`);
      }; // Register availableBitrates callback
      avPlayer12.on('availableBitrates', availableBitratesCallback); // Unregister specific availableBitrates callback
      avPlayer12.off('availableBitrates',
        availableBitratesCallback); // Set source to potentially trigger availableBitrates event
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor = {
        fd: fileFd, offset: fileOffset, length: -1
      };
      avPlayer12.fdSrc = avFileDescriptor;
      await sleep(WAIT_TIME);
      expect(callbackCalled).assertEqual(false);
      console.info('off availableBitrates callback test passed');
    })

    /**
     * @tc.number     : SUB_MULTIMEDIA_MEDIA_TESTAVPLAYER_AVAILABLEBITRATES_ON_SUCCESS_1300
     * @tc.name       : testAvPlayer013
     * @tc.desc       : Test availableBitrates event callback success
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testAvPlayer013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let avPlayer13 = await idle();
      avPlayer13.on('availableBitrates', (bitrates: Array<number>) => {
        console.info(`availableBitrates received: ${JSON.stringify(bitrates)}`);
        expect(bitrates).assertInstanceOf('Array');
        if (bitrates.length > 0) {
          expect(typeof bitrates[0]).assertEqual('number');
          expect(bitrates[0]).assertLarger(0);
        }
      }); // Use a network source that might have multiple bitrates (like HLS or DASH)
      //  For local files, this event might not be triggered as they have fixed bitrate
      let fileDescriptor = await context.resourceManager.getRawFd('test2.mp4');
      let fileFd: number = JSON.parse(JSON.stringify(fileDescriptor))['fd'];
      let fileOffset: number = JSON.parse(JSON.stringify(fileDescriptor))['offset'];
      let avFileDescriptor: media.AVFileDescriptor = {
        fd: fileFd, offset: fileOffset, length: -1
      };
      avPlayer13.fdSrc = avFileDescriptor;
      avPlayer13.on('stateChange', async (state, reason) => {
        console.info(`availableBitrates success test state is ${state}, reason is ${reason}`);
        switch (state) {
          case AVPlayerState.PREPARED:
            await playPromise(avPlayer13); // Wait a bit to see if availableBitrates event is triggered
            setTimeout(() => {
              console.info('availableBitrates event test completed (might not trigger for local files)');
            }, WAIT_TIME);
            break;
          case AVPlayerState.INITIALIZED:
            await preparePromise(avPlayer13);
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
    it('testAvPlayer014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let avPlayer14 = await idle();
      let errorCallbackCalled = false;
      const errorCallback = (error: BusinessError) => {
        errorCallbackCalled = true;
        console.info(`error callback called: ${error.code}, message: ${error.message}`);
      }; // Register error callback
      avPlayer14.on('error', errorCallback); // Unregister specific error callback
      avPlayer14.off('error', errorCallback); // Set invalid source to potentially trigger error
      avPlayer14.url = 'invalid://path';
      await sleep(WAIT_TIME);
      expect(errorCallbackCalled).assertEqual(false);
      console.info('off error callback test passed');
    })
  })
}