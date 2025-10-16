/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, TestType, Size, Level } from '@ohos/hypium';
import audio from '@ohos.multimedia.audio';
import { BusinessError } from '@ohos.base';

export function sleep(ms: number): Promise<string> {
  return new Promise((resolve) => {
    setTimeout(() => {
      resolve('');
    }, ms);
  });
}

export default function audioRoutingManager() {
  const TAG = "[AudioRoutingManagerJsTest]";
  const stringParameter: ESObject = 'stringParameter';
  const params: ESObject = '';
  const numberParameter = 12345678;

  describe("AudioRoutingManagerJsTest", () => {
    beforeAll(async () => {
      console.info(TAG + "beforeAll called");
    })

    afterAll(() => {
      console.info(TAG + 'afterAll called')
    })

    beforeEach(() => {
      console.info(TAG + 'beforeEach called')
    })

    afterEach(() => {
      console.info(TAG + 'afterEach called')
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ON_REFEROUTPUTDEVICEFORRENDERERINFOTEST_0100
     * @tc.name      : testOnPreferOutputDeviceChangeForRendererInfo0100
     * @tc.desc      : Get prefer output device check number parameter- callback --6800101
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it("testOnPreferOutputDeviceChangeForRendererInfo0100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let rendererInfo: ESObject = {
          usage: 123,
        };
        let routingManager = audio.getAudioManager().getRoutingManager();
        try {
          routingManager.on('preferOutputDeviceChangeForRendererInfo', rendererInfo, (data) => {
          });
          expect().assertFail();
          done();
        } catch (e) {
          console.error(`${TAG} SUB_MULTIMEDIA_AUDIO_ON_REFEROUTPUTDEVICEFORRENDERERINFOTEST_0100 ERROR: ${e.message},Code:${e.code}`);
          expect(Number(e.code)).assertEqual(audio.AudioErrors.ERROR_INVALID_PARAM);
          done();
        }
      })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ON_REFEROUTPUTDEVICEFORRENDERERINFOTEST_0200
     * @tc.name      : testOnPreferOutputDeviceChangeForRendererInfo0200
     * @tc.desc      : On prefer output device check string parameter- callback
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it("testOnPreferOutputDeviceChangeForRendererInfo0200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let routingManager = audio.getAudioManager().getRoutingManager();
        try {
          routingManager.on('preferOutputDeviceChangeForRendererInfo', stringParameter, (data) => {
          });
          expect().assertFail();
          done();
        } catch (e) {
          console.info(`${TAG} SUB_MULTIMEDIA_AUDIO_ON_REFEROUTPUTDEVICEFORRENDERERINFOTEST_0200 PASS: ${e.message},Code:${e.code}`);
          expect(Number(e.code)).assertEqual(401);
          done();
        }
      })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ON_REFEROUTPUTDEVICEFORRENDERERINFOTEST_0300
     * @tc.name      : testOnPreferOutputDeviceChangeForRendererInfo0300
     * @tc.desc      : On prefer output device check null parameter- callback
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it("testOnPreferOutputDeviceChangeForRendererInfo0300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let routingManager = audio.getAudioManager().getRoutingManager();
        try {
          routingManager.on('preferOutputDeviceChangeForRendererInfo', params, (data) => {
          });
          expect(false).assertTrue();
          done();
        } catch (e) {
          console.info(`${TAG} SUB_MULTIMEDIA_AUDIO_ON_REFEROUTPUTDEVICEFORRENDERERINFOTEST_0300 PASS: ${e.message},Code:${e.code}`);
          expect(Number(e.code)).assertEqual(401);
          done();
        }
      })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_OFF_REFEROUTPUTDEVICEFORRENDERERINFOTEST_0100
     * @tc.name      : testOffPreferOutputDeviceChangeForRendererInfo0100
     * @tc.desc      : Off prefer output device - callback
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it("testOffPreferOutputDeviceChangeForRendererInfo0100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let routingManager = audio.getAudioManager().getRoutingManager();
        try {
          routingManager.off('preferOutputDeviceChangeForRendererInfo', (data) => {
          });
          console.info(`${TAG} SUB_MULTIMEDIA_AUDIO_OFF_REFEROUTPUTDEVICEFORRENDERERINFOTEST_0100 SUCCESS`);
          done();
        } catch (e) {
          console.error(`${TAG} SUB_MULTIMEDIA_AUDIO_OFF_REFEROUTPUTDEVICEFORRENDERERINFOTEST_0100 ERROR: ${e.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ON_PREFERREDINPUTDEVICEFORCAPTURERINFO_0100
     * @tc.name      : testOnPreferredInputDeviceChangeForCapturerInfo0100
     * @tc.desc      : On preferred input devicechangeinfo - Null_Parameters - 401
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it("testOnPreferredInputDeviceChangeForCapturerInfo0100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let audioRoutingManager = audio.getAudioManager().getRoutingManager();
        try {
          audioRoutingManager.on('preferredInputDeviceChangeForCapturerInfo', undefined, (desc: ESObject) => {
            console.info(`device descriptor: ${desc}`);
            expect(false).assertTrue();
            done();
          });
        } catch (e) {
          console.error(`${TAG} SUB_MULTIMEDIA_AUDIO_ON_PREFERREDINPUTDEVICEFORCAPTURERINFO_0100 ERROR: ${e.message},Code:${e.code}`);
          expect(Number(e.code)).assertEqual(401);
          done();
        }
      })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ON_PREFERREDINPUTDEVICEFORCAPTURERINFO_0200
     * @tc.name      : testOnPreferredInputDeviceChangeForCapturerInfo0200
     * @tc.desc      : On preferred input devicechangeinfo - Number_Invalid_Parameters - 6800101
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it("testOnPreferredInputDeviceChangeForCapturerInfo0200", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let audioRoutingManager = audio.getAudioManager().getRoutingManager();
        let capturerInfo: audio.AudioCapturerInfo = {
          source: 123,
          capturerFlags: 0
        };
        try {
          audioRoutingManager.on('preferredInputDeviceChangeForCapturerInfo', capturerInfo, (desc: ESObject) => {
            console.info(`device descriptor: ${desc}`);
            expect(false).assertTrue();
            done();
          });
        } catch (e) {
          console.error(`${TAG} SUB_MULTIMEDIA_AUDIO_ON_PREFERREDINPUTDEVICEFORCAPTURERINFO_0200 ERROR: ${e.message},Code:${e.code}`);
          expect(Number(e.code)).assertEqual(audio.AudioErrors.ERROR_INVALID_PARAM);
          done();
        }
      })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ON_PREFERREDINPUTDEVICEFORCAPTURERINFO_0300
     * @tc.name      : testOnPreferredInputDeviceChangeForCapturerInfo0300
     * @tc.desc      : On preferred input devicechangeinfo - String_Parameters - 401
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it("testOnPreferredInputDeviceChangeForCapturerInfo0300", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let audioRoutingManager = audio.getAudioManager().getRoutingManager();
        let rendererInfo: ESObject = '123';
        try {
          audioRoutingManager.on('preferredInputDeviceChangeForCapturerInfo', rendererInfo, (desc: ESObject) => {
            console.info(`device descriptor: ${desc}`);
            expect(false).assertTrue();
            done();
          });
        } catch (e) {
          console.error(`${TAG} SUB_MULTIMEDIA_AUDIO_ON_PREFERREDINPUTDEVICEFORCAPTURERINFO_0300 ERROR: ${e.message},Code:${e.code}`);
          expect(Number(e.code)).assertEqual(401);
          done();
        }
        done();
      })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_OFF_PREFERREDINPUTDEVICEFORCAPTURERINFO_0100
     * @tc.name      : testOffPreferredInputDeviceChangeForCapturerInfo0100
     * @tc.desc      : Off preferred input devicechangeinfo
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it("testOffPreferredInputDeviceChangeForCapturerInfo0100", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        let audioRoutingManager = audio.getAudioManager().getRoutingManager();
        try {
          audioRoutingManager.off('preferredInputDeviceChangeForCapturerInfo', (desc: ESObject) => {
          });
          done()
        } catch (e) {
          console.error(`${TAG} SUB_MULTIMEDIA_AUDIO_ON_PREFERREDINPUTDEVICEFORCAPTURERINFO_0300 ERROR: ${e.message},Code:${e.code}`);
          expect().assertFail()
          done();
        }
      })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ROUTING_MANAGER_ON_DEVICECHANGE_0100
     * @tc.name      : testOnDeviceChange0100
     * @tc.desc      : on_DeviceChange - ErrorCode - Null-Parameters - 401
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testOnDeviceChange0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let audioRoutingManager = audio.getAudioManager().getRoutingManager();
      try {
        audioRoutingManager.on('deviceChange', null!, (deviceChanged) => {
        });
        expect().assertFail();
        done();
      } catch (error) {
        console.info(`on('deviceChange') Fail,error:${error},ErrorCode:${error.code},${typeof (error.code)}`);
        expect(Number(error.code)).assertEqual(401);
        done();
      }
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ROUTING_MANAGER_ON_DEVICECHANGE_0200
     * @tc.name      : testOnDeviceChange0200
     * @tc.desc      : on_DeviceChange - ErrorCode - Number-Parameters - 6800101
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testOnDeviceChange0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let audioRoutingManager = audio.getAudioManager().getRoutingManager();
      try {
        audioRoutingManager.on('deviceChange', -123, (deviceChanged) => {
        });
        expect().assertFail();
        done();
      } catch (error) {
        console.info(`on('deviceChange') Fail,error:${error},ErrorCode:${error.code},${typeof (error.code)}`);
        expect(Number(error.code)).assertEqual(audio.AudioErrors.ERROR_INVALID_PARAM);
        done();
      }
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ROUTING_MANAGER_ON_DEVICECHANGE_0300
     * @tc.name      : testOnDeviceChange0300
     * @tc.desc      : on_DeviceChange - ErrorCode - Number-Parameters - 6800101
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testOnDeviceChange0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let audioRoutingManager = audio.getAudioManager().getRoutingManager();
      try {
        audioRoutingManager.on('deviceChange', 333,
          (deviceChanged: audio.DeviceChangeAction) => {
          });
        expect().assertFail();
        done();
      } catch (error) {
        console.info(`on('deviceChange') Fail,error:${error},ErrorCode:${error.code},${typeof (error.code)}`);
        expect(Number(error.code)).assertEqual(audio.AudioErrors.ERROR_INVALID_PARAM);
        done();
      }
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ROUTING_MANAGER_ON_DEVICECHANGE_0400
     * @tc.name      : testOnDeviceChange0400
     * @tc.desc      : on_DeviceChange - ErrorCode - String -Parameters - 401
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testOnDeviceChange0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let audioRoutingManager = audio.getAudioManager().getRoutingManager();
      try {
        let deviceFlag: ESObject = '123';
        audioRoutingManager.on('deviceChange', deviceFlag,
          (deviceChanged: audio.DeviceChangeAction) => {
          });
        expect().assertFail();
        done();
      } catch (error) {
        console.info(`on('deviceChange') Fail,error:${error},ErrorCode:${error.code},${typeof (error.code)}`);
        expect(Number(error.code)).assertEqual(401);
        done();
      }
    })

    /**
     * @tc.number    : SUB_MULTIMEDIA_AUDIO_ROUTING_MANAGER_OFF_DEVICECHANGE_0100
     * @tc.name      : testOffDeviceChange0100
     * @tc.desc      : off_DeviceChange
     * @tc.size      : MEDIUM
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testOffDeviceChange0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      let audioRoutingManager = audio.getAudioManager().getRoutingManager();
      try {
        audioRoutingManager.off('deviceChange',
          (deviceChanged: audio.DeviceChangeAction) => {
          });
        done();
      } catch (error) {
        console.info(`on('deviceChange') Fail,error:${error},ErrorCode:${error.code},${typeof (error.code)}`);
        expect().assertFail();
        done();
      }
    })
  })
}