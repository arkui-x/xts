import { BusinessError } from '@ohos.base';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import audio from '@ohos.multimedia.audio';

const waitReadyMs_100 = 100;
const waitReadyMs_600 = 600;
const waitReadyMs_5000 = 5000;
let isPass = false;
let audioManager: audio.AudioManager;

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function audioManagerTest() {
  describe('audioManagerTest', () => {
    beforeAll(async() => {
      audioManager = audio.getAudioManager();
      await sleep(waitReadyMs_600);
    })
    beforeEach(async() => {
      isPass = false;
      await sleep(waitReadyMs_100);
    })
	  afterAll(async() => {
      await sleep(waitReadyMs_5000);
    })

    /**
     * @tc.number : SUB_ArkUIX_Audio_getAudioManager_Func_0100
     * @tc.name   : getAudioManager
     * @tc.desc   : Test getAudioManager - Sync
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getAudioManager_Func_0100', 0, async (done: Function) => {
      try{
        audioManager = audio.getAudioManager();
        expect(audioManager != null).assertTrue();
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getAudioManager_Func_0100 error' + error);
      }
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getAudioScene_Func_0100
     * @tc.name   : getAudioScene
     * @tc.desc   : Test getAudioScene - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getAudioScene_Func_0100', 0, async (done: Function) => {
      try{
        await (async (): Promise<audio.AudioScene> => {
          return new Promise((resolve, reject) => {
            audioManager.getAudioScene((err, value) => {
              err == undefined ? resolve(value) : reject(err)
            });
          });
        })().then(value => {
          if(value == 0) {
            isPass = true;
          }
        }).catch((err: BusinessError) => {
          console.error('SUB_ArkUIX_Audio_getAudioScene_Func_0100 fail');
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getAudioScene_Func_0100 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getAudioScene_Func_0200
     * @tc.name   : getAudioScene
     * @tc.desc   : Test getAudioScene - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getAudioScene_Func_0200', 0, async (done: Function) => {
      try{
        await audioManager.getAudioScene().then((value) => {
          isPass = true;
          expect(value).assertEqual(0);
        }).catch ((err: BusinessError) => {
          console.error('SUB_ArkUIX_Audio_getAudioScene_Func_0200 fail');
        });
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getAudioScene_Func_0200 error' + error);
      }
      await sleep(waitReadyMs_100);
      expect(isPass).assertTrue();
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getAudioScene_Func_0300
     * @tc.name   : getAudioSceneSync
     * @tc.desc   : Test getAudioSceneSync - Sync
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getAudioScene_Func_0300', 0, async (done: Function) => {
      try{
        let AudioScene = audioManager.getAudioSceneSync();
        expect(AudioScene).assertEqual(0);
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getAudioScene_Func_0300 error' + error);
      }
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getVolumeManager_Func_0100
     * @tc.name   : getVolumeManager
     * @tc.desc   : Test getVolumeManager - Sync
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getVolumeManager_Func_0100', 0, async (done: Function) => {
      try{
        let audioVolumeManager = audioManager.getVolumeManager();
        expect(audioVolumeManager != null).assertTrue();
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getVolumeManager_Func_0100 error' + error);
      }
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getStreamManager_Func_0100
     * @tc.name   : getStreamManager
     * @tc.desc   : Test getStreamManager - Sync
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getStreamManager_Func_0100', 0, async (done: Function) => {
      try{
        let audioStreamManager = audioManager.getStreamManager();
        expect(audioStreamManager != null).assertTrue();
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getStreamManager_Func_0100 error' + error);
      }
      done();
    })
    /**
     * @tc.number : SUB_ArkUIX_Audio_getRoutingManager_Func_0100
     * @tc.name   : getRoutingManager
     * @tc.desc   : Test getRoutingManager - Sync
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_Audio_getRoutingManager_Func_0100', 0, async (done: Function) => {
      try{
        let audioRoutingManager = audioManager.getRoutingManager();
        expect(audioRoutingManager != null).assertTrue();
      }
      catch (error) {
        expect(error).assertFail();
        console.error('SUB_ArkUIX_Audio_getRoutingManager_Func_0100 error' + error);
      }
      done();
    })
  })
}