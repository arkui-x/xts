import resourceManager from '@ohos.resourceManager';
import { describe, beforeAll, afterAll, it, expect, afterEach } from '@ohos/hypium';
import { BusinessError } from '@ohos.base';
import common from '@ohos.app.ability.common';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';

let abilityDelegatorRegistry: AbilityDelegatorRegistry.AbilityDelegator =
  AbilityDelegatorRegistry.getAbilityDelegator();
let context: common.Context = abilityDelegatorRegistry.getAppContext().createModuleContext("entry_test");

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function resourceManagerTest() {
  describe('resourceManagerTest', () => {
    beforeAll(async () => {
      await sleep(1000);
      console.log('************* start resourceManagerTest2 *************');
    })

    afterEach(async () => {
      await sleep(500);
    });

    afterAll(async () => {
      console.log('************* end resourceManagerTest2 *************');
      await sleep(1000)
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0100
    * @tc.name:    test getMediaContent method in callback mode
    * @tc.desc:    get the media in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0100', 0, async (done: Function) => {
      context.resourceManager.getMediaContent($r('app.media.icon').id, 0, (err: BusinessError, value: Uint8Array) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0100 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0100 ${value.length}`);
          expect(value.length == 6790).assertTrue();
        } else {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0100 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0100 errMessage ${err.message}`);
          expect().assertFail();
        }
        done()
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0200
    * @tc.name:    test getMediaContent method in callback mode
    * @tc.desc:    get the media in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0200', 0, async (done: Function) => {
      context.resourceManager.getMediaContent($r('app.media.icon').id, 120, (err: BusinessError, value: Uint8Array) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0200 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0200 ${value.length}`);
          expect(value.length == 6790).assertTrue();
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0200 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0200 errMessage ${err.message}`);
          expect().assertFail();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0300
    * @tc.name:    test getMediaContent method in callback mode
    * @tc.desc:    get the media in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0300', 0, async (done: Function) => {
      context.resourceManager.getMediaContent($r('app.media.test').id, 0, (err: BusinessError, value: Uint8Array) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0300 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0300 ${value.length}`);
          expect(value.length == 128635).assertTrue();
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0300 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0300 errMessage ${err.message}`);
          expect().assertFail();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0400
    * @tc.name:    test getMediaContent method in callback mode throw 9001001 error code
    * @tc.desc:    get the media in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0400', 0, async (done: Function) => {
      context.resourceManager.getMediaContent(111, 0, (err: BusinessError, value: Uint8Array) => {
        if (err != null) {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0400 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0400 errMessage ${err.message}`);
          expect(err.code == 9001001).assertTrue();
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0400 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0400 ${typeof value}`);
          expect().assertFail();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0500
    * @tc.name:    test getMediaContent method in callback mode throw 9001002 error code
    * @tc.desc:    get the media in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0500', 0, async (done: Function) => {
      context.resourceManager.getMediaContent($r('app.string.test_1')
        .id, 0, (err: BusinessError, value: Uint8Array) => {
        if (err != null) {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0500 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0500 errMessage ${err.message}`);
          expect(err.code == 9001002).assertTrue();
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0500 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0500 ${typeof value}`);
          expect().assertFail();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0600
    * @tc.name:    test getMediaContent method in promise mode
    * @tc.desc:    get the media in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0600', 0, async (done: Function) => {
      context.resourceManager.getMediaContent($r('app.media.icon').id, 0).then((value: Uint8Array) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0600 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0600 ${typeof value}`);
        expect(value.length == 6790).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0600 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0600 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0700
    * @tc.name:    test getMediaContent method in promise mode
    * @tc.desc:    get the media in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0700', 0, async (done: Function) => {
      context.resourceManager.getMediaContent($r('app.media.icon').id, 120).then((value: Uint8Array) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0700 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0700 ${typeof value}`);
        expect(value.length == 6790).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0700 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0700 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0800
    * @tc.name:    test getMediaContent method in promise mode
    * @tc.desc:    get the media in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0800', 0, async (done: Function) => {
      context.resourceManager.getMediaContent($r('app.media.test').id, 0).then((value: Uint8Array) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0800 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0800 ${typeof value}`);
        expect(value.length == 128635).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0800 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0800 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0900
    * @tc.name:    test getMediaContent method in promise mode throw 9001001 code err
    * @tc.desc:    get the media in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0900', 0, async (done: Function) => {
      context.resourceManager.getMediaContent(111, 0).then((value: Uint8Array) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0900 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0900 ${typeof value}`);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0900 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_0900 errMessage ${err.message}`);
        expect(err.code == 9001001).assertTrue();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1000
    * @tc.name:    test getMediaContent method in promise mode throw 9001002 code err
    * @tc.desc:    get the media in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1000', 0, async (done: Function) => {
      context.resourceManager.getMediaContent($r('app.string.test_1').id, 0).then((value: Uint8Array) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1000 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1000 ${typeof value}`);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1000 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1000 errMessage ${err.message}`);
        expect(err.code == 9001002).assertTrue();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1100
    * @tc.name:    test getMediaContent method in callback mode
    * @tc.desc:    get the media in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1100', 0, async (done: Function) => {
      context.resourceManager.getMediaContent({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.media.icon').id
      }, 0, (err: BusinessError, value: Uint8Array) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1100 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1100 ${typeof value}`);
        expect(value.length == 6790).assertTrue();
        done();
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1200
    * @tc.name:    test getMediaContent method in callback mode
    * @tc.desc:    get the media in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1200', 0, async (done: Function) => {
      context.resourceManager.getMediaContent({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.media.icon').id
      }, 120, (err: BusinessError, value: Uint8Array) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1200 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1200 ${typeof value}`);
        expect(value.length == 6790).assertTrue();
        done();
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1300
    * @tc.name:    test getMediaContent method in callback mode
    * @tc.desc:    get the media in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1300', 0, async (done: Function) => {
      context.resourceManager.getMediaContent({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.media.test').id
      }, 0, (err: BusinessError, value: Uint8Array) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1300 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1300 ${typeof value}`);
        expect(value.length == 128635).assertTrue();
        done();
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1400
    * @tc.name:    test getMediaContent method in callback mode throw 9001001 error code
    * @tc.desc:    get the media in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1400', 0, async (done: Function) => {
      context.resourceManager.getMediaContent({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: 1111
      }, 0, (err: BusinessError, value: Uint8Array) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1400 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1400 ${typeof value}`);
          expect().assertFail();
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1400 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1400 errMessage ${err.message}`);
          expect(err.code == 9001001).assertTrue();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1500
    * @tc.name:    test getMediaContent method in callback mode throw 9001002 error code
    * @tc.desc:    get the media in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1500', 0, async (done: Function) => {
      context.resourceManager.getMediaContent({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.string.test_1').id
      }, 0, (err: BusinessError, value: Uint8Array) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1500 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1500 ${typeof value}`);
          expect().assertFail();
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1500 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1500 errMessage ${err.message}`);
          expect(err.code == 9001002).assertTrue();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1600
    * @tc.name:    test getMediaContent method in promise mode
    * @tc.desc:    get the media in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1600', 0, async (done: Function) => {
      context.resourceManager.getMediaContent({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.media.icon').id
      }, 0).then((value: Uint8Array) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1600 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1600 ${value.length}`);
        expect(value.length == 6790).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1600 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1600 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1700
    * @tc.name:    test getMediaContent method in promise mode
    * @tc.desc:    get the media in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1700', 0, async (done: Function) => {
      context.resourceManager.getMediaContent({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.media.icon').id
      }, 120).then((value: Uint8Array) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1700 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1700 ${typeof value}`);
        expect(value.length == 6790).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1700 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1700 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1800
    * @tc.name:    test getMediaContent method in promise mode
    * @tc.desc:    get the media in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1800', 0, async (done: Function) => {
      context.resourceManager.getMediaContent({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.media.test').id
      }, 0).then((value: Uint8Array) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1800 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1800 ${typeof value}`);
        expect(value.length == 128635).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1800 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1800 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1900
    * @tc.name:    test getMediaContent method in promise mode throw 9001001 error code
    * @tc.desc:    get the media in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1900', 0, async (done: Function) => {
      context.resourceManager.getMediaContent({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: 1111
      }, 0).then((value: Uint8Array) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1900 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1900 ${typeof value}`);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1900 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_1900 errMessage ${err.message}`);
        expect(err.code == 9001001).assertTrue();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContent_Func_2000
    * @tc.name:    test getMediaContent method in promise mode throw 9001002 error code
    * @tc.desc:    get the media in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContent_Func_2000', 0, async (done: Function) => {
      context.resourceManager.getMediaContent({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.string.test_1').id
      }, 0).then((value: Uint8Array) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_2000 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_2000 ${typeof value}`);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_2000 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContent_Func_2000 errMessage ${err.message}`);
        expect(err.code == 9001002).assertTrue();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2100
    * @tc.name:    test getMediaContentBase64 method in callback mode
    * @tc.desc:    get the media base64 in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2100', 0, async (done: Function) => {
      context.resourceManager.getMediaContentBase64($r('app.media.icon').id, 0, (err: BusinessError, value: string) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2100 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2100 ${value}`.slice(22, 50));
        expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAHIA');
        done();
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2200
    * @tc.name:    test getMediaContentBase64 method in callback mode
    * @tc.desc:    get the media base64 in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2200', 0, async (done: Function) => {
      context.resourceManager.getMediaContentBase64($r('app.media.icon')
        .id, 120, (err: BusinessError, value: string) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2200 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2200 ${typeof value}`);
        expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAHIA');
        done();
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2300
    * @tc.name:    test getMediaContentBase64 method in callback mode
    * @tc.desc:    get the media base64 in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2300', 0, async (done: Function) => {
      context.resourceManager.getMediaContentBase64($r('app.media.test')
        .id, 0, (err: BusinessError, value: string) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2300 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2300 ${typeof value}`);
        expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAs0A');
        done();
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2400
    * @tc.name:    test getMediaContentBase64 method in callback mode throw 9001001 error code
    * @tc.desc:    get the media base64 in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2400', 0, async (done: Function) => {
      context.resourceManager.getMediaContentBase64(1111, 0, (err: BusinessError, value: string) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2400 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2400 ${typeof value}`);
          expect().assertFail();
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2400 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2400 errMessage ${err.message}`);
          expect(err.code == 9001001).assertTrue();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2500
    * @tc.name:    test getMediaContentBase64 method in callback mode throw 9001002 error code
    * @tc.desc:    get the media base64 in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2500', 0, async (done: Function) => {
      context.resourceManager.getMediaContentBase64($r('app.string.test_1')
        .id, 0, (err: BusinessError, value: string) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2500 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2500 ${typeof value}`);
          expect().assertFail();
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2500 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2500 errMessage ${err.message}`);
          expect(err.code == 9001002).assertTrue();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2600
    * @tc.name:    test getMediaContentBase64 method in promise mode
    * @tc.desc:    get the media base64 in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2600', 0, async (done: Function) => {
      context.resourceManager.getMediaContentBase64($r('app.media.icon').id, 0).then((value: string) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2600 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2600 ${typeof value}`);
        expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAHIA');
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2600 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2600 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2700
    * @tc.name:    test getMediaContentBase64 method in promise mode
    * @tc.desc:    get the media base64 in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2700', 0, async (done: Function) => {
      context.resourceManager.getMediaContentBase64($r('app.media.icon').id, 120).then((value: string) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2700 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2700 ${value}`.slice(22, 50));
        expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAHIA');
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2700 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2700 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2800
    * @tc.name:    test getMediaContentBase64 method in promise mode
    * @tc.desc:    get the media base64 in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2800', 0, async (done: Function) => {
      context.resourceManager.getMediaContentBase64($r('app.media.test').id, 0).then((value: string) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2800 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2800 ${value}`.slice(22, 50));
        expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAs0A');
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2800 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2800 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2900
    * @tc.name:    test getMediaContentBase64 method in promise mode throw 9001001 error code
    * @tc.desc:    get the media base64 in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2900', 0, async (done: Function) => {
      context.resourceManager.getMediaContentBase64(1111, 0).then((value: string) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2900 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2900 ${typeof value}`);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2900 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_2900 errMessage ${err.message}`);
        expect(err.code == 9001001).assertTrue();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3000
    * @tc.name:    test getMediaContentBase64 method in promise mode throw 9001002 error code
    * @tc.desc:    get the media base64 in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3000', 0, async (done: Function) => {
      context.resourceManager.getMediaContentBase64($r('app.string.test_1').id, 0).then((value: string) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3000 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3000 ${typeof value}`);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3000 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3000 errMessage ${err.message}`);
        expect(err.code == 9001002).assertTrue();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3100
    * @tc.name:    test getMediaContentBase64 method in callback mode
    * @tc.desc:    get the media base64 in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3100', 0, async (done: Function) => {
      context.resourceManager.getMediaContentBase64({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.media.icon').id
      }, 0, (err: BusinessError, value: string) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3100 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3100 ${typeof value}`);
        expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAHIA');
        done();
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3200
    * @tc.name:    test getMediaContentBase64 method in callback mode
    * @tc.desc:    get the media base64 in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3200', 0, async (done: Function) => {
      context.resourceManager.getMediaContentBase64({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.media.icon').id
      }, 120, (err: BusinessError, value: string) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3200 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3200 ${typeof value}`);
        expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAHIA');
        done();
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3300
    * @tc.name:    test getMediaContentBase64 method in callback mode
    * @tc.desc:    get the media base64 in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3300', 0, async (done: Function) => {
      context.resourceManager.getMediaContentBase64({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.media.test').id
      }, 0, (err: BusinessError, value: string) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3300 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3300 ${typeof value}`);
        expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAs0A');
        done();
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3400
    * @tc.name:    test getMediaContentBase64 method in callback mode throw 9001001 error code
    * @tc.desc:    get the media base64 in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3400', 0, async (done: Function) => {
      context.resourceManager.getMediaContentBase64({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: 1111
      }, 0, (err: BusinessError, value: string) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3400 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3400 ${typeof value}`);
          expect().assertFail();
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3400 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3400 errMessage ${err.message}`);
          expect(err.code == 9001001).assertTrue();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3500
    * @tc.name:    test getMediaContentBase64 method in callback mode throw 9001002 error code
    * @tc.desc:    get the media base64 in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3500', 0, async (done: Function) => {
      context.resourceManager.getMediaContentBase64({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.string.test_1').id
      }, 0, (err: BusinessError, value: string) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3500 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3500 ${typeof value}`);
          expect().assertFail();
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3500 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3500 errMessage ${err.message}`);
          expect(err.code == 9001002).assertTrue();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3600
    * @tc.name:    test getMediaContentBase64 method in promise mode
    * @tc.desc:    get the media base64 in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3600', 0, async (done: Function) => {
      context.resourceManager.getMediaContentBase64({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.media.icon').id
      }, 0).then((value: string) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3600 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3600 ${typeof value}`);
        expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAHIA');
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3600 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3600 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3700
    * @tc.name:    test getMediaContentBase64 method in promise mode
    * @tc.desc:    get the media base64 in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3700', 0, async (done: Function) => {
      context.resourceManager.getMediaContentBase64({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.media.icon').id
      }, 120).then((value: string) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3700 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3700 ${typeof value}`);
        expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAHIA');
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3700 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3700 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3800
    * @tc.name:    test getMediaContentBase64 method in promise mode
    * @tc.desc:    get the media base64 in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3800', 0, async (done: Function) => {
      context.resourceManager.getMediaContentBase64({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.media.test').id
      }, 0).then((value: string) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3800 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3800 ${typeof value}`);
        expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAs0A');
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3800 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3800 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
   * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3900
   * @tc.name:    test getMediaContentBase64 method in promise mode throw 9001001 error code
   * @tc.desc:    get the media base64 in promise mode
   * @tc.size:    MediumTest
   * @tc.type:    method
   * @tc.level:   level 2
   */
    it('SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3900', 0, async (done: Function) => {
      context.resourceManager.getMediaContentBase64({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: 1111
      }, 0).then((value: string) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3900 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3900 ${typeof value}`);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3900 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_3900 errMessage ${err.message}`);
        expect(err.code == 9001001).assertTrue();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_4000
    * @tc.name:    test getMediaContentBase64 method in promise mode throw 9001002 error code
    * @tc.desc:    get the media base64 in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_4000', 0, async (done: Function) => {
      context.resourceManager.getMediaContentBase64({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.string.test_1').id
      }, 0).then((value: string) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_4000 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_4000 ${typeof value}`);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_4000 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaContentBase64_Func_4000 errMessage ${err.message}`);
        expect(err.code == 9001002).assertTrue();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4100
    * @tc.name:    test getMediaByName method in callback mode
    * @tc.desc:    get the media in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4100', 0, async (done: Function) => {
      context.resourceManager.getMediaByName('icon', 0, (err: BusinessError, value: Uint8Array) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4100 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4100 ${typeof value}`);
        expect(value.length == 6790).assertTrue();
        done();
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4200
    * @tc.name:    test getMediaByName method in callback mode
    * @tc.desc:    get the media in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4200', 0, async (done: Function) => {
      context.resourceManager.getMediaByName('icon', 120, (err: BusinessError, value: Uint8Array) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4200 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4200 ${typeof value}`);
        expect(value.length == 6790).assertTrue();
        done();
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4300
    * @tc.name:    test getMediaByName method in callback mode
    * @tc.desc:    get the media in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4300', 0, async (done: Function) => {
      context.resourceManager.getMediaByName('test', 0, (err: BusinessError, value: Uint8Array) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4300 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4300 ${typeof value}`);
        expect(value.length == 128635).assertTrue();
        done();
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4400
    * @tc.name:    test getMediaByName method in callback mode throw 9001003 error code
    * @tc.desc:    get the media in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4400', 0, async (done: Function) => {
      context.resourceManager.getMediaByName('notexist', 0, (err: BusinessError, value: Uint8Array) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4400 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4400 ${typeof value}`);
          expect().assertFail();
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4400 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4400 errMessage ${err.message}`);
          expect(err.code == 9001003).assertTrue();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4500
    * @tc.name:    test getMediaByName method in promise mode
    * @tc.desc:    get the media in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4500', 0, async (done: Function) => {
      context.resourceManager.getMediaByName('icon', 0).then((value: Uint8Array) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4500 ${value}`)
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4500 ${typeof value}`)
        expect(value.length == 6790).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4500 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4500 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4600
    * @tc.name:    test getMediaByName method in promise mode
    * @tc.desc:    get the media in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4600', 0, async (done: Function) => {
      context.resourceManager.getMediaByName('icon', 120).then((value: Uint8Array) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4600 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4600 ${typeof value}`);
        expect(value.length == 6790).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4600 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4600 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4700
    * @tc.name:    test getMediaByName method in promise mode
    * @tc.desc:    get the media in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4700', 0, async (done: Function) => {
      context.resourceManager.getMediaByName('test', 0).then((value: Uint8Array) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4700 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4700 ${typeof value}`);
        expect(value.length == 128635).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4700 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4700 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4800
    * @tc.name:    test getMediaByName method in promise mode throw 9001003 error code
    * @tc.desc:    get the media in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4800', 0, async (done: Function) => {
      context.resourceManager.getMediaByName('notexist', 0).then((value: Uint8Array) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4800 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4800 ${typeof value}`);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4800 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByName_Func_4800 errMessage ${err.message}`);
        expect(err.code == 9001003).assertTrue();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaByNameSync_Func_4900
    * @tc.name:    test getMediaByNameSync method
    * @tc.desc:    get the media in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaByNameSync_Func_4900', 0, async (done: Function) => {
      let value: Uint8Array = context.resourceManager.getMediaByNameSync('icon', 0);
      console.log(`SUB_Global_Resource_Manager_0100_GetMediaByNameSync_Func_4900 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0100_GetMediaByNameSync_Func_4900 ${typeof value}`);
      expect(value.length == 6790).assertTrue();
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaByNameSync_Func_5000
    * @tc.name:    test getMediaByNameSync method
    * @tc.desc:    get the media in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaByNameSync_Func_5000', 0, async (done: Function) => {
      let value: Uint8Array = context.resourceManager.getMediaByNameSync('icon', 120);
      console.log(`SUB_Global_Resource_Manager_0100_GetMediaByNameSync_Func_5000 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0100_GetMediaByNameSync_Func_5000 ${typeof value}`);
      expect(value.length == 6790).assertTrue();
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaByNameSync_Func_5100
    * @tc.name:    test getMediaByNameSync method
    * @tc.desc:    get the media in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaByNameSync_Func_5100', 0, async (done: Function) => {
      let value: Uint8Array = context.resourceManager.getMediaByNameSync('test', 0);
      console.log(`SUB_Global_Resource_Manager_0100_GetMediaByNameSync_Func_5100 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0100_GetMediaByNameSync_Func_5100 ${typeof value}`);
      expect(value.length == 128635).assertTrue();
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaByNameSync_Func_5200
    * @tc.name:    test getMediaByNameSync method throw 9001003 error code
    * @tc.desc:    get the media in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaByNameSync_Func_5200', 0, async (done: Function) => {
      try {
        let value: Uint8Array = context.resourceManager.getMediaByNameSync('notexist', 0);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByNameSync_Func_5200 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByNameSync_Func_5200 ${typeof value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByNameSync_Func_5200 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaByNameSync_Func_5200 errMessage ${err.message}`);
        expect(err.code == 9001003).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5300
    * @tc.name:    test getMediaBase64ByName method in callback mode
    * @tc.desc:    get the media base64 in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5300', 0, async (done: Function) => {
      context.resourceManager.getMediaBase64ByName('icon', 0, (err: BusinessError, value: string) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5300 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5300 ${typeof value}`);
        expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAHIA');
        done();
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5400
    * @tc.name:    test getMediaBase64ByName method in callback mode
    * @tc.desc:    get the media base64 in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5400', 0, async (done: Function) => {
      context.resourceManager.getMediaBase64ByName('icon', 120, (err: BusinessError, value: string) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5400 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5400 ${typeof value}`);
        expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAHIA');
        done();
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5500
    * @tc.name:    test getMediaBase64ByName method in callback mode
    * @tc.desc:    get the media base64 in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5500', 0, async (done: Function) => {
      context.resourceManager.getMediaBase64ByName('test', 0, (err: BusinessError, value: string) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5500 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5500 ${typeof value}`);
        expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAs0A');
        done();
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5600
    * @tc.name:    test getMediaBase64ByName method in callback mode throw 9001003 error code
    * @tc.desc:    get the media base64 in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5600', 0, async (done: Function) => {
      context.resourceManager.getMediaBase64ByName('notexist', 0, (err: BusinessError, value: string) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5600 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5600 ${typeof value}`);
          expect().assertFail();
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5600 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5600 errMessage ${err.message}`);
          expect(err.code == 9001003).assertTrue();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5700
    * @tc.name:    test getMediaBase64ByName method in promise mode
    * @tc.desc:    get the media base64 in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5700', 0, async (done: Function) => {
      context.resourceManager.getMediaBase64ByName('icon', 0).then((value: string) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5700 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5700 ${typeof value}`);
        expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAHIA');
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5700 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5700 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5800
    * @tc.name:    test getMediaBase64ByName method in promise mode
    * @tc.desc:    get the media base64 in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5800', 0, async (done: Function) => {
      context.resourceManager.getMediaBase64ByName('icon', 120).then((value: string) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5800 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5800 ${typeof value}`);
        expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAHIA');
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5800 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5800 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5900
    * @tc.name:    test getMediaBase64ByName method in promise mode
    * @tc.desc:    get the media base64 in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5900', 0, async (done: Function) => {
      context.resourceManager.getMediaBase64ByName('test', 0).then((value: string) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5900 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5900 ${typeof value}`);
        expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAs0A')
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5900 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_5900 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_6000
    * @tc.name:    test getMediaBase64ByName method in promise mode throw 9001003 error code
    * @tc.desc:    get the media base64 in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_6000', 0, async (done: Function) => {
      context.resourceManager.getMediaBase64ByName('notexist', 0).then((value: string) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_6000 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_6000 ${typeof value}`);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_6000 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByName_Func_6000 errMessage ${err.message}`);
        expect(err.code == 9001003).assertTrue();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaBase64ByNameSync_Func_6100
    * @tc.name:    test getMediaBase64ByNameSync method in sync mode
    * @tc.desc:    get the media base64 in Sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaBase64ByNameSync_Func_6100', 0, async (done: Function) => {
      let value: string = context.resourceManager.getMediaBase64ByNameSync('icon', 0);
      console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByNameSync_Func_6100 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByNameSync_Func_6100 ${typeof value}`);
      expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAHIA');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaBase64ByNameSync_Func_6200
    * @tc.name:    test getMediaBase64ByNameSync method in sync mode
    * @tc.desc:    get the media base64 in Sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaBase64ByNameSync_Func_6200', 0, async (done: Function) => {
      let value: string = context.resourceManager.getMediaBase64ByNameSync('icon', 120);
      console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByNameSync_Func_6200 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByNameSync_Func_6200 ${typeof value}`);
      expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAHIA');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaBase64ByNameSync_Func_6300
    * @tc.name:    test getMediaBase64ByNameSync method in sync mode
    * @tc.desc:    get the media base64 in Sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaBase64ByNameSync_Func_6300', 0, async (done: Function) => {
      let value: string = context.resourceManager.getMediaBase64ByNameSync('test', 0);
      console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByNameSync_Func_6300 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByNameSync_Func_6300 ${typeof value}`);
      expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAs0A');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetMediaBase64ByNameSync_Func_6400
    * @tc.name:    test getMediaBase64ByNameSync method in sync mode throw 9001003 error code
    * @tc.desc:    get the media base64 in Sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetMediaBase64ByNameSync_Func_6400', 0, async (done: Function) => {
      try {
        let value: string = context.resourceManager.getMediaBase64ByNameSync('notexist', 0);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByNameSync_Func_6400 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByNameSync_Func_6400 ${typeof value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByNameSync_Func_6400 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetMediaBase64ByNameSync_Func_6400 errMessage ${err.message}`);
        expect(err.code == 9001003).assertTrue();
        done();
      }
    })

    // /* *
    // * @tc.number:  SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_6500
    // * @tc.name:    test getDrawableDescriptor method
    // * @tc.desc:    get the drawable descriptor
    // * @tc.size:    MediumTest
    // * @tc.type:    method
    // * @tc.level:   level 2
    // */
    // it('SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_6500', 0, async () => {
    //   let value: DrawableDescriptor = context.resourceManager.getDrawableDescriptor($r('app.media.icon').id, 0);
    //   console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_6500 ${value}`);
    //   console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_6500 ${typeof value}`);
    //   expect(value !== undefined).assertTrue();
    // })
    //
    // /* *
    // * @tc.number:  SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_6600
    // * @tc.name:    test getDrawableDescriptor method
    // * @tc.desc:    get the drawable descriptor
    // * @tc.size:    MediumTest
    // * @tc.type:    method
    // * @tc.level:   level 2
    // */
    // it('SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_6600', 0, async () => {
    //   let value: DrawableDescriptor = context.resourceManager.getDrawableDescriptor($r('app.media.icon').id, 120);
    //   console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_6600 ${value}`);
    //   console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_6600 ${typeof value}`);
    //   expect(value !== undefined).assertTrue();
    // })
    //
    // /* *
    // * @tc.number:  SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_6700
    // * @tc.name:    test getDrawableDescriptor method
    // * @tc.desc:    get the drawable descriptor
    // * @tc.size:    MediumTest
    // * @tc.type:    method
    // * @tc.level:   level 2
    // */
    // it('SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_6700', 0, async () => {
    //   let value: DrawableDescriptor = context.resourceManager.getDrawableDescriptor($r('app.media.test').id, 0);
    //   console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_6700 ${value}`);
    //   console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_6700 ${typeof value}`);
    //   expect(value !== undefined).assertTrue();
    // })
    //
    // /* *
    // * @tc.number:  SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_6800
    // * @tc.name:    test getDrawableDescriptor method throw 9001001 error code
    // * @tc.desc:    get the drawable descriptor
    // * @tc.size:    MediumTest
    // * @tc.type:    method
    // * @tc.level:   level 2
    // */
    // it('SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_6800', 0, async (done: Function) => {
    //   try {
    //     let value: DrawableDescriptor = context.resourceManager.getDrawableDescriptor(1111, 0);
    //     console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_6800 ${value}`);
    //     console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_6800 ${typeof value}`);
    //   } catch (err) {
    //     console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_6800 errCode ${err.code}`);
    //     console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_6800 errMessage ${err.message}`);
    //     expect(err.code == 9001001).assertTrue();
    //     done();
    //   }
    // })
    //
    // /* *
    // * @tc.number:  SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_6900
    // * @tc.name:    test getDrawableDescriptor method
    // * @tc.desc:    get the drawable descriptor
    // * @tc.size:    MediumTest
    // * @tc.type:    method
    // * @tc.level:   level 2
    // */
    // it('SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_6900', 0, async () => {
    //   let value: DrawableDescriptor = context.resourceManager.getDrawableDescriptor({
    //     bundleName: "com.example.resourcemanagertest2",
    //     moduleName: "entry_test",
    //     id: $r('app.media.icon').id
    //   }, 0);
    //   console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_6900 ${value}`);
    //   console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_6900 ${typeof value}`);
    //   expect(value !== undefined).assertTrue();
    // })
    //
    // /* *
    // * @tc.number:  SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_7000
    // * @tc.name:    test getDrawableDescriptor method
    // * @tc.desc:    get the drawable descriptor
    // * @tc.size:    MediumTest
    // * @tc.type:    method
    // * @tc.level:   level 2
    // */
    // it('SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_7000', 0, async () => {
    //   let value: DrawableDescriptor = context.resourceManager.getDrawableDescriptor({
    //     bundleName: "com.example.resourcemanagertest2",
    //     moduleName: "entry_test",
    //     id: $r('app.media.icon').id
    //   }, 120);
    //   console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_7000 ${value}`);
    //   console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_7000 ${typeof value}`);
    //   expect(value !== undefined).assertTrue();
    // })
    //
    // /* *
    // * @tc.number:  SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_7100
    // * @tc.name:    test getDrawableDescriptor method
    // * @tc.desc:    get the drawable descriptor
    // * @tc.size:    MediumTest
    // * @tc.type:    method
    // * @tc.level:   level 2
    // */
    // it('SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_7100', 0, async () => {
    //   let value: DrawableDescriptor = context.resourceManager.getDrawableDescriptor({
    //     bundleName: "com.example.resourcemanagertest2",
    //     moduleName: "entry_test",
    //     id: $r('app.media.test').id
    //   }, 0);
    //   console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_7100 ${value}`);
    //   console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_7100 ${typeof value}`);
    //   expect(value !== undefined).assertTrue();
    // })
    //
    // /* *
    // * @tc.number:  SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_7200
    // * @tc.name:    test getDrawableDescriptor method throw 9001001 error code
    // * @tc.desc:    get the drawable descriptor
    // * @tc.size:    MediumTest
    // * @tc.type:    method
    // * @tc.level:   level 2
    // */
    // it('SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_7200', 0, async (done: Function) => {
    //   try {
    //     let value: DrawableDescriptor = context.resourceManager.getDrawableDescriptor({
    //       bundleName: "com.example.resourcemanagertest2",
    //       moduleName: "entry_test",
    //       id: 1111
    //     }, 120);
    //     console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_7200 ${value}`);
    //     console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_7200 ${typeof value}`);
    //   } catch (err) {
    //     console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_7200 errCode ${err.code}`);
    //     console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptor_Func_7200 errMessage ${err.message}`);
    //     expect(err.code == 9001001).assertTrue();
    //     done();
    //   }
    // })
    //
    // /* *
    // * @tc.number:  SUB_Global_Resource_Manager_0100_GetDrawableDescriptorByName_Func_7300
    // * @tc.name:    test getDrawableDescriptorByName method
    // * @tc.desc:    get the drawable descriptor by name
    // * @tc.size:    MediumTest
    // * @tc.type:    method
    // * @tc.level:   level 2
    // */
    // it('SUB_Global_Resource_Manager_0100_GetDrawableDescriptorByName_Func_7300', 0, async () => {
    //   let value: DrawableDescriptor = context.resourceManager.getDrawableDescriptorByName('icon', 0);
    //   console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptorByName_Func_7300 ${value}`);
    //   console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptorByName_Func_7300 ${typeof value}`);
    //   expect(value !== undefined).assertTrue();
    // })
    //
    // /* *
    // * @tc.number:  SUB_Global_Resource_Manager_0100_GetDrawableDescriptorByName_Func_7400
    // * @tc.name:    test getDrawableDescriptorByName method
    // * @tc.desc:    get the drawable descriptor by name
    // * @tc.size:    MediumTest
    // * @tc.type:    method
    // * @tc.level:   level 2
    // */
    // it('SUB_Global_Resource_Manager_0100_GetDrawableDescriptorByName_Func_7400', 0, async () => {
    //   let value: DrawableDescriptor = context.resourceManager.getDrawableDescriptorByName('icon', 120);
    //   console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptorByName_Func_7400 ${value}`);
    //   console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptorByName_Func_7400 ${typeof value}`);
    //   expect(value !== undefined).assertTrue();
    // })
    //
    // /* *
    // * @tc.number:  SUB_Global_Resource_Manager_0100_GetDrawableDescriptorByName_Func_7500
    // * @tc.name:    test getDrawableDescriptorByName method
    // * @tc.desc:    get the drawable descriptor by name
    // * @tc.size:    MediumTest
    // * @tc.type:    method
    // * @tc.level:   level 2
    // */
    // it('SUB_Global_Resource_Manager_0100_GetDrawableDescriptorByName_Func_7500', 0, async () => {
    //   let value: DrawableDescriptor = context.resourceManager.getDrawableDescriptorByName('test', 0);
    //   console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptorByName_Func_7500 ${value}`);
    //   console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptorByName_Func_7500 ${typeof value}`);
    //   expect(value !== undefined).assertTrue();
    // })
    //
    // /* *
    // * @tc.number:  SUB_Global_Resource_Manager_0100_GetDrawableDescriptorByName_Func_7600
    // * @tc.name:    test getDrawableDescriptorByName method throw 9001003 error code
    // * @tc.desc:    get the drawable descriptor by name
    // * @tc.size:    MediumTest
    // * @tc.type:    method
    // * @tc.level:   level 2
    // */
    // it('SUB_Global_Resource_Manager_0100_GetDrawableDescriptorByName_Func_7600', 0, async (done: Function) => {
    //   try {
    //     let value: DrawableDescriptor = context.resourceManager.getDrawableDescriptorByName('notexist', 0);
    //     console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptorByName_Func_7600 ${value}`);
    //     console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptorByName_Func_7600 ${typeof value}`);
    //   } catch (err) {
    //     console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptorByName_Func_7600 errCode ${err.code}`);
    //     console.log(`SUB_Global_Resource_Manager_0100_GetDrawableDescriptorByName_Func_7600 errMessage ${err.message}`);
    //     expect(err.code == 9001003).assertTrue();
    //     done();
    //   }
    // })
    //
    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetRawFileList_Func_7700
    * @tc.name:    test getRawFileList method in callback mode
    * @tc.desc:    get the rawFileList in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetRawFileList_Func_7700', 0, async (done: Function) => {
      context.resourceManager.getRawFileList('', (err: BusinessError, value: Array<string>) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_7700 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_7700 ${typeof value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_7700 value.length ${value.length}`);
        expect(value.length > 0).assertTrue();
        done();
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetRawFileList_Func_7800
    * @tc.name:    test getRawFileList method in callback mode
    * @tc.desc:    get the rawFileList in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetRawFileList_Func_7800', 0, async (done: Function) => {
      context.resourceManager.getRawFileList('test', (err: BusinessError, value: Array<string>) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_7800 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_7800 ${typeof value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_7800 value.length ${value.length}`);
        expect(value.length > 0).assertTrue();
        done();
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetRawFileList_Func_7900
    * @tc.name:    test getRawFileList method in callback mode
    * @tc.desc:    get the rawFileList in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetRawFileList_Func_7900', 0, async (done: Function) => {
      context.resourceManager.getRawFileList('test/rawfiletest.xml', (err: BusinessError, value: Array<string>) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_7900 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_7900 ${typeof value}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_7900 value.length ${value.length}`);
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_7900 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_7900 errMessage ${err.message}`);
          expect(err.code === 9001005).assertTrue();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8000
    * @tc.name:    test getRawFileList method in callback mode
    * @tc.desc:    get the rawFileList in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8000', 0, async (done: Function) => {
      context.resourceManager.getRawFileList('test/null.txt', (err: BusinessError, value: Array<string>) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8000 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8000 ${typeof value}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8000 value.length ${value.length}`);
          expect(value.length === 0).assertTrue();
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8000 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8000 errMessage ${err.message}`);
          expect(err.code == 9001005).assertTrue();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8100
    * @tc.name:    test getRawFileList method in callback mode throw 9001005 error code
    * @tc.desc:    get the rawFileList in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8100', 0, async (done: Function) => {
      context.resourceManager.getRawFileList('nullDir', (err: BusinessError, value: Array<string>) => {
        if (err) {
          console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8100 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8100 errMessage ${err.message}`);
          expect(err.code == 9001005).assertTrue();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8200
    * @tc.name:    test getRawFileList method in callback mode throw 9000605 error code
    * @tc.desc:    get the rawFileList in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8200', 0, async (done: Function) => {
      context.resourceManager.getRawFileList('notexist', (err: BusinessError, value: Array<string>) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8200 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8200 ${typeof value}`);
          expect(value.length > 0).assertTrue();
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8200 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8200 errMessage ${err.message}`);
          expect(err.code == 9001005).assertTrue();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8300
    * @tc.name:    test getRawFileList method in promise mode
    * @tc.desc:    get the rawFileList in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8300', 0, async (done: Function) => {
      context.resourceManager.getRawFileList('').then((value: Array<string>) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8300 ${value}}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8300 ${typeof value}`);
        expect(value.length > 0).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8300 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8300 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8400
    * @tc.name:    test getRawFileList method in promise mode
    * @tc.desc:    get the rawFileList in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8400', 0, async (done: Function) => {
      context.resourceManager.getRawFileList('test').then((value: Array<string>) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8400 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8400 ${typeof value}`);
        expect(value.length > 0).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8400 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8400 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8500
    * @tc.name:    test getRawFileList method in promise mode
    * @tc.desc:    get the rawFileList in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8500', 0, async (done: Function) => {
      context.resourceManager.getRawFileList('test/rawfiletest.xml').then((value: Array<string>) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8500 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8500 ${typeof value}`);
        expect(value.length === 0).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8500 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8500 errMessage ${err.message}`);
        expect(err.code === 9001005).assertTrue();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8600
    * @tc.name:    test getRawFileList method in promise mode
    * @tc.desc:    get the rawFileList in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8600', 0, async (done: Function) => {
      context.resourceManager.getRawFileList('test/null.txt').then((value: Array<string>) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8600 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8600 ${typeof value}`);
        expect(value.length === 0).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8600 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8600 errMessage ${err.message}`);
        expect(err.code == 9001005).assertTrue();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8700
    * @tc.name:    test getRawFileList method in promise mode throw 9001005 error code
    * @tc.desc:    get the rawFileList in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8700', 0, async (done: Function) => {
      context.resourceManager.getRawFileList('nullDir').then((value: Array<string>) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8700 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8700 ${typeof value}`);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8700 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8700 errMessage ${err.message}`);
        expect(err.code == 9001005).assertTrue();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8800
    * @tc.name:    test getRawFileList method in promise mode throw 9001005 error code
    * @tc.desc:    get the rawFileList in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8800', 0, async (done: Function) => {
      context.resourceManager.getRawFileList('notexist').then((value: Array<string>) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8800 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8800 ${typeof value}`);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8800 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileList_Func_8800 errMessage ${err.message}`);
        expect(err.code == 9001005).assertTrue();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_8900
    * @tc.name:    test getRawFileListSync method in sync mode
    * @tc.desc:    get the rawFileList in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_8900', 0, async (done: Function) => {
      let value: Array<string> = context.resourceManager.getRawFileListSync('');
      console.log(`SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_8900 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_8900 ${typeof value}`);
      expect(value.length > 0).assertTrue();
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9000
    * @tc.name:    test getRawFileListSync method in sync mode
    * @tc.desc:    get the rawFileList in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9000', 0, async (done: Function) => {
      let value: Array<string> = context.resourceManager.getRawFileListSync('test');
      console.log(`SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9000 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9000 ${typeof value}`);
      expect(value.length > 0).assertTrue();
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9100
    * @tc.name:    test getRawFileListSync method in sync mode
    * @tc.desc:    get the rawFileList in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9100', 0, async (done: Function) => {
      try {
        let value: Array<string> = context.resourceManager.getRawFileListSync('test/rawfiletest.xml');
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9100 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9100 ${typeof value}`);
        expect(value.length === 0).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9100 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9100 errMessage ${err.message}`);
        expect(err.code == 9001005).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9200
    * @tc.name:    test getRawFileListSync method in sync mode
    * @tc.desc:    get the rawFileList in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9200', 0, async (done: Function) => {
      try {
        let value: Array<string> = context.resourceManager.getRawFileListSync('test/null.txt');
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9200 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9200 ${typeof value}`);
        expect(value.length > 0).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9200 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9200 errMessage ${err.message}`);
        expect(err.code == 9001005).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9300
    * @tc.name:    test getRawFileListSync method in sync mode throw 9001005 error code
    * @tc.desc:    get the rawFileList in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9300', 0, async (done: Function) => {
      try {
        let value: Array<string> = context.resourceManager.getRawFileListSync('nullDir');
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9300 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9300 ${typeof value}`);
        expect(value.length > 0).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9300 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9300 errMessage ${err.message}`);
        expect(err.code == 9001005).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9400
    * @tc.name:    test getRawFileListSync method in sync mode throw 9001005 error code
    * @tc.desc:    get the rawFileList in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9400', 0, async (done: Function) => {
      try {
        let value: Array<string> = context.resourceManager.getRawFileListSync('notexist');
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9400 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9400 ${typeof value}`);
        expect(value.length > 0).assertTrue();
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9400 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0100_GetRawFileListSync_Func_9400 errMessage ${err.message}`);
        expect(err.code == 9001005).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetColor_Func_9500
    * @tc.name:    test getColor method in callback mode
    * @tc.desc:    get the color in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetColor_Func_9500', 0, async (done: Function) => {
      context.resourceManager.getColor($r('app.color.test1').id, (err: BusinessError, value: number) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0100_GetColor_Func_9500 ${JSON.stringify(value)}`);
          expect(value).assertEqual(4283047887);
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0100_GetColor_Func_9500 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetColor_Func_9500 errMessage ${err.message}`);
          expect().assertFail();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetColor_Func_9600
    * @tc.name:    test getColor method in callback mode
    * @tc.desc:    get the color in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetColor_Func_9600', 0, async (done: Function) => {
      context.resourceManager.getColor($r('app.color.test2').id, (err: BusinessError, value: number) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0100_GetColor_Func_9600 ${JSON.stringify(value)}`);
          expect(value).assertEqual(4281309688);
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0100_GetColor_Func_9600 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetColor_Func_9600 errMessage ${err.message}`);
          expect().assertFail();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetColor_Func_9700
    * @tc.name:    test getColor method in callback mode throw 9001001 error code
    * @tc.desc:    get the color in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetColor_Func_9700', 0, async (done: Function) => {
      context.resourceManager.getColor(1111, (err: BusinessError, value: number) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0100_GetColor_Func_9700 ${JSON.stringify(value)}`);
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0100_GetColor_Func_9700 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetColor_Func_9700 errMessage ${err.message}`);
          expect(err.code == 9001001).assertTrue();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetColor_Func_9800
    * @tc.name:    test getColor method in callback mode throw 9001002 error code
    * @tc.desc:    get the color in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetColor_Func_9800', 0, async (done: Function) => {
      context.resourceManager.getColor($r('app.string.test_1').id, (err: BusinessError, value: number) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0100_GetColor_Func_9800 ${JSON.stringify(value)}`);
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0100_GetColor_Func_9800 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetColor_Func_9800 errMessage ${err.message}`);
          expect(err.code == 9001002).assertTrue();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0100_GetColor_Func_9900
    * @tc.name:    test getColor method in callback mode throw 9001006 error code
    * @tc.desc:    get the color in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0100_GetColor_Func_9900', 0, async (done: Function) => {
      context.resourceManager.getColor($r('app.color.test3').id, (err: BusinessError, value: number) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0100_GetColor_Func_9900 ${JSON.stringify(value)}`);
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0100_GetColor_Func_9900 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0100_GetColor_Func_9900 errMessage ${err.message}`);
          expect(err.code == 9001006).assertTrue();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColor_Func_0100
    * @tc.name:    test getColor method in promise mode
    * @tc.desc:    get the color in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColor_Func_0100', 0, async (done: Function) => {
      context.resourceManager.getColor($r('app.color.test1').id).then((value: number) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0100 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0100 ${typeof value}`);
        expect(value).assertEqual(4283047887);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0100 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0100 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColor_Func_0200
    * @tc.name:    test getColor method in promise mode
    * @tc.desc:    get the color in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColor_Func_0200', 0, async (done: Function) => {
      context.resourceManager.getColor($r('app.color.test2').id).then((value: number) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0200 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0200 ${typeof value}`);
        expect(value).assertEqual(4281309688);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0200 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0200 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColor_Func_0300
    * @tc.name:    test getColor method in promise mode throw 9001001 error code
    * @tc.desc:    get the color in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColor_Func_0300', 0, async (done: Function) => {
      context.resourceManager.getColor(1111).then((value: number) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0300 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0300 ${typeof value}`);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0300 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0300 errMessage ${err.message}`);
        expect(err.code == 9001001).assertTrue();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColor_Func_0400
    * @tc.name:    test getColor method in promise mode throw 9001002 error code
    * @tc.desc:    get the color in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColor_Func_0400', 0, async (done: Function) => {
      context.resourceManager.getColor($r('app.string.test_1').id).then((value: number) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0400 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0400 ${typeof value}`);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0400 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0400 errMessage ${err.message}`);
        expect(err.code == 9001002).assertTrue();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColor_Func_0500
    * @tc.name:    test getColor method in promise mode throw 9001006 error code
    * @tc.desc:    get the color in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColor_Func_0500', 0, async (done: Function) => {
      context.resourceManager.getColor($r('app.color.test3').id).then((value: number) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0500 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0500 ${typeof value}`);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0200 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0200 errMessage ${err.message}`);
        expect(err.code == 9001006).assertTrue();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColor_Func_0600
    * @tc.name:    test getColor method in callback mode
    * @tc.desc:    get the color in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColor_Func_0600', 0, async (done: Function) => {
      context.resourceManager.getColor({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.color.test1').id
      }, (err: BusinessError, value: number) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0600 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0600 ${typeof value}`);
          expect(value).assertEqual(4283047887);
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0600 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0600 errMessage ${err.message}`);
          expect().assertFail();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColor_Func_0700
    * @tc.name:    test getColor method in callback mode
    * @tc.desc:    get the color in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColor_Func_0700', 0, async (done: Function) => {
      context.resourceManager.getColor({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.color.test2').id
      }, (err: BusinessError, value: number) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0700 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0700 ${typeof value}`);
          expect(value).assertEqual(4281309688);
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0700 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0700 errMessage ${err.message}`);
          expect().assertFail();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColor_Func_0800
    * @tc.name:    test getColor method in callback mode throw 9001001 error code
    * @tc.desc:    get the color in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColor_Func_0800', 0, async (done: Function) => {
      context.resourceManager.getColor({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: 1111
      }, (err: BusinessError, value: number) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0800 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0800 ${typeof value}`);
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0800 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0800 errMessage ${err.message}`);
          expect(err.code == 9001001).assertTrue();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColor_Func_0900
    * @tc.name:    test getColor method in callback mode throw 9001002 error code
    * @tc.desc:    get the color in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColor_Func_0900', 0, async (done: Function) => {
      context.resourceManager.getColor({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.string.test_1').id
      }, (err: BusinessError, value: number) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0900 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0900 ${typeof value}`);
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0900 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_0900 errMessage ${err.message}`);
          expect(err.code == 9001002).assertTrue();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColor_Func_1000
    * @tc.name:    test getColor method in callback mode throw 9001006 error code
    * @tc.desc:    get the color in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColor_Func_1000', 0, async (done: Function) => {
      context.resourceManager.getColor({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.color.test3').id
      }, (err: BusinessError, value: number) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1000 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1000 ${typeof value}`);
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1000 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1000 errMessage ${err.message}`);
          expect(err.code == 9001006).assertTrue();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColor_Func_1100
    * @tc.name:    test getColor method in promise mode
    * @tc.desc:    get the color in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColor_Func_1100', 0, async (done: Function) => {
      context.resourceManager.getColor({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.color.test1').id
      }).then((value: number) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1100 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1100 ${typeof value}`);
        expect(value).assertEqual(4283047887);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1100 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1100 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColor_Func_1200
    * @tc.name:    test getColor method in promise mode
    * @tc.desc:    get the color in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColor_Func_1200', 0, async (done: Function) => {
      context.resourceManager.getColor({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.color.test2').id
      }).then((value: number) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1200 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1200 ${typeof value}`);
        expect(value).assertEqual(4281309688);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1200 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1200 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColor_Func_1300
    * @tc.name:    test getColor method in promise mode throw 9001001 error code
    * @tc.desc:    get the color in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColor_Func_1300', 0, async (done: Function) => {
      context.resourceManager.getColor({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: 1111
      }).then((value: number) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1300 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1300 ${typeof value}`);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1300 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1300 errMessage ${err.message}`);
        expect(err.code == 9001001).assertTrue();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColor_Func_1400
    * @tc.name:    test getColor method in promise mode throw 9001002 error code
    * @tc.desc:    get the color in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColor_Func_1400', 0, async (done: Function) => {
      context.resourceManager.getColor({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.string.test_1').id
      }).then((value: number) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1400 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1400 ${typeof value}`);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1400 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1400 errMessage ${err.message}`);
        expect(err.code == 9001002).assertTrue();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColor_Func_1500
    * @tc.name:    test getColor method in promise mode throw 9001006 error code
    * @tc.desc:    get the color in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColor_Func_1500', 0, async (done: Function) => {
      context.resourceManager.getColor({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.color.test3').id
      }).then((value: number) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1500 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1500 ${typeof value}`);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1500 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColor_Func_1500 errMessage ${err.message}`);
        expect(err.code == 9001006).assertTrue();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColorByName_Func_1600
    * @tc.name:    test getColorByName method in callback mode
    * @tc.desc:    get the color in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColorByName_Func_1600', 0, async (done: Function) => {
      context.resourceManager.getColorByName("test1", (err: BusinessError, value: number) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_1600 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_1600 ${typeof value}`);
          expect(value).assertEqual(4283047887);
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_1600 errCode ${err.code}`)
          console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_1600 errMessage ${err.message}`)
          expect().assertFail();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColorByName_Func_1700
    * @tc.name:    test getColorByName method in callback mode
    * @tc.desc:    get the color in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColorByName_Func_1700', 0, async (done: Function) => {
      context.resourceManager.getColorByName("test2", (err: BusinessError, value: number) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_1700 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_1700 ${typeof value}`);
          expect(value).assertEqual(4281309688);
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_1700 errCode ${err.code}`)
          console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_1700 errMessage ${err.message}`)
          expect().assertFail();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColorByName_Func_1800
    * @tc.name:    test getColorByName method in callback mode throw 9001003 error code
    * @tc.desc:    get the color in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColorByName_Func_1800', 0, async (done: Function) => {
      context.resourceManager.getColorByName("notexist", (err: BusinessError, value: number) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_1800 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_1800 ${typeof value}`);
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_1800 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_1800 errMessage ${err.message}`);
          expect(err.code == 9001003).assertTrue();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColorByName_Func_1900
    * @tc.name:    test getColorByName method in callback mode throw 9001006 error code
    * @tc.desc:    get the color in callback mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColorByName_Func_1900', 0, async (done: Function) => {
      context.resourceManager.getColorByName("test3", (err: BusinessError, value: number) => {
        if (!err) {
          console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_1900 ${value}`);
          console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_1900 ${typeof value}`);
          done();
        } else {
          console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_1900 errCode ${err.code}`);
          console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_1900 errMessage ${err.message}`);
          expect(err.code == 9001006).assertTrue();
          done();
        }
      })
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColorByName_Func_2000
    * @tc.name:    test getColorByName method in promise mode
    * @tc.desc:    get the color in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColorByName_Func_2000', 0, async (done: Function) => {
      context.resourceManager.getColorByName("test1").then((value: number) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_2000 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_2000 ${typeof value}`);
        expect(value).assertEqual(4283047887);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_2000 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_2000 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColorByName_Func_2100
    * @tc.name:    test getColorByName method in promise mode
    * @tc.desc:    get the color in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColorByName_Func_2100', 0, async (done: Function) => {
      context.resourceManager.getColorByName("test2").then((value: number) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_2100 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_2100 ${typeof value}`);
        expect(value).assertEqual(4281309688);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_2100 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_2100 errMessage ${err.message}`);
        expect().assertFail();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColorByName_Func_2200
    * @tc.name:    test getColorByName method in promise mode throw 9001003 error code
    * @tc.desc:    get the color in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColorByName_Func_2200', 0, async (done: Function) => {
      context.resourceManager.getColorByName("notexist").then((value: number) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_2200 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_2200 ${typeof value}`);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_2200 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_2200 errMessage ${err.message}`);
        expect(err.code == 9001003).assertTrue();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColorByName_Func_2300
    * @tc.name:    test getColorByName method in promise mode throw 9001006 error code
    * @tc.desc:    get the color in promise mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColorByName_Func_2300', 0, async (done: Function) => {
      context.resourceManager.getColorByName("test3").then((value: number) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_2300 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_2300 ${typeof value}`);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_2300 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByName_Func_2300 errMessage ${err.message}`);
        expect(err.code == 9001006).assertTrue();
        done();
      });
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColorSync_Func_2400
    * @tc.name:    test getColorSync method in sync mode
    * @tc.desc:    get the color in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColorSync_Func_2400', 0, async (done: Function) => {
      let value: number = context.resourceManager.getColorSync($r('app.color.test1').id);
      console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_2400 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_2400 ${typeof value}`);
      expect(value).assertEqual(4283047887);
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColorSync_Func_2500
    * @tc.name:    test getColorSync method in sync mode
    * @tc.desc:    get the color in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColorSync_Func_2500', 0, async (done: Function) => {
      let value: number = context.resourceManager.getColorSync($r('app.color.test2').id);
      console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_2500 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_2500 ${typeof value}`);
      expect(value).assertEqual(4281309688);
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColorSync_Func_2600
    * @tc.name:    test getColorSync method in sync mode throw 9001001 error code
    * @tc.desc:    get the color in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColorSync_Func_2600', 0, async (done: Function) => {
      try {
        let value: number = context.resourceManager.getColorSync(1111);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_2600 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_2600 ${typeof value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_2600 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_2600 errMessage ${err.message}`);
        expect(err.code == 9001001).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColorSync_Func_2700
    * @tc.name:    test getColorSync method in sync mode throw 9001002 error code
    * @tc.desc:    get the color in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColorSync_Func_2700', 0, async (done: Function) => {
      try {
        let value: number = context.resourceManager.getColorSync($r('app.string.test_1').id);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_2700 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_2700 ${typeof value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_2700 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_2700 errMessage ${err.message}`);
        expect(err.code == 9001002).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColorSync_Func_2800
    * @tc.name:    test getColorSync method in sync mode throw 9001006 error code
    * @tc.desc:    get the color in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColorSync_Func_2800', 0, async (done: Function) => {
      try {
        let value: number = context.resourceManager.getColorSync($r('app.color.test3').id);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_2800 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_2800 ${typeof value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_2800 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_2800 errMessage ${err.message}`);
        expect(err.code == 9001006).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColorSync_Func_2900
    * @tc.name:    test getColorSync method in sync mode
    * @tc.desc:    get the color in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColorSync_Func_2900', 0, async (done: Function) => {
      let value: number = context.resourceManager.getColorSync({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.color.test1').id
      });
      console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_2900 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_2900 ${typeof value}`);
      expect(value).assertEqual(4283047887);
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColorSync_Func_3000
    * @tc.name:    test getColorSync method in sync mode
    * @tc.desc:    get the color in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColorSync_Func_3000', 0, async (done: Function) => {
      let value: number = context.resourceManager.getColorSync({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.color.test2').id
      });
      console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_3000 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_3000 ${typeof value}`);
      expect(value).assertEqual(4281309688);
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColorSync_Func_3100
    * @tc.name:    test getColorSync method in sync mode throw 9001001 error code
    * @tc.desc:    get the color in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColorSync_Func_3100', 0, async (done: Function) => {
      try {
        let value: number = context.resourceManager.getColorSync({
          bundleName: "com.example.resourcemanagertest2",
          moduleName: "entry_test",
          id: 1111
        });
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_3100 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_3100 ${typeof value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_3100 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_3100 errMessage ${err.message}`);
        expect(err.code == 9001001).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColorSync_Func_3200
    * @tc.name:    test getColorSync method in sync mode throw 9001002 error code
    * @tc.desc:    get the color in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColorSync_Func_3200', 0, async (done: Function) => {
      try {
        let value: number = context.resourceManager.getColorSync({
          bundleName: "com.example.resourcemanagertest2",
          moduleName: "entry_test",
          id: $r('app.string.test_1').id
        });
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_3200 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_3200 ${typeof value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_3200 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_3200 errMessage ${err.message}`);
        expect(err.code == 9001002).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColorSync_Func_3300
    * @tc.name:    test getColorSync method in sync mode throw 9001006 error code
    * @tc.desc:    get the color in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColorSync_Func_3300', 0, async (done: Function) => {
      try {
        let value: number = context.resourceManager.getColorSync({
          bundleName: "com.example.resourcemanagertest2",
          moduleName: "entry_test",
          id: $r('app.color.test3').id
        });
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_3300 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_3300 ${typeof value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_3300 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorSync_Func_3300 errMessage ${err.message}`);
        expect(err.code == 9001006).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColorByNameSync_Func_3400
    * @tc.name:    test getColorByNameSync method in sync mode
    * @tc.desc:    get the color in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColorByNameSync_Func_3400', 0, async (done: Function) => {
      let value: number = context.resourceManager.getColorByNameSync("test1");
      console.log(`SUB_Global_Resource_Manager_0200_GetColorByNameSync_Func_3400 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetColorByNameSync_Func_3400 ${typeof value}`);
      expect(value).assertEqual(4283047887);
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColorByNameSync_Func_3500
    * @tc.name:    test getColorByNameSync method in sync mode
    * @tc.desc:    get the color in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColorByNameSync_Func_3500', 0, async (done: Function) => {
      let value: number = context.resourceManager.getColorByNameSync("test2");
      console.log(`SUB_Global_Resource_Manager_0200_GetColorByNameSync_Func_3500 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetColorByNameSync_Func_3500 ${typeof value}`);
      expect(value).assertEqual(4281309688);
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColorByNameSync_Func_3600
    * @tc.name:    test getColorByNameSync method in sync mode throw 9001003 error code
    * @tc.desc:    get the color in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColorByNameSync_Func_3600', 0, async (done: Function) => {
      try {
        let value: number = context.resourceManager.getColorByNameSync("notexist");
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByNameSync_Func_3600 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByNameSync_Func_3600 ${typeof value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByNameSync_Func_3600 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByNameSync_Func_3600 errMessage ${err.message}`);
        expect(err.code == 9001003).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetColorByNameSync_Func_3700
    * @tc.name:    test getColorByNameSync method in sync mode throw 9001006 error code
    * @tc.desc:    get the color in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetColorByNameSync_Func_3700', 0, async (done: Function) => {
      try {
        let value: number = context.resourceManager.getColorByNameSync("test3");
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByNameSync_Func_3700 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByNameSync_Func_3700 ${typeof value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByNameSync_Func_3700 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetColorByNameSync_Func_3700 errMessage ${err.message}`);
        expect(err.code == 9001006).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetRawFdSync_Func_3800
    * @tc.name:    test getRawFdSync method
    * @tc.desc:    get the RawFileDescriptor in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetRawFdSync_Func_3800', 0, async (done: Function) => {
      let rawfile: resourceManager.RawFileDescriptor = context.resourceManager.getRawFdSync('rawfiletest.xml');
      console.log(`SUB_Global_Resource_Manager_0200_GetRawFdSync_Func_3800 rawfile =` + JSON.stringify(rawfile));
      expect(rawfile != null).assertTrue();
      done();
    })


    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetRawFdSync_Func_3900
    * @tc.name:    test getRawFdSync method
    * @tc.desc:    get the RawFileDescriptor in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetRawFdSync_Func_3900', 0, async (done: Function) => {
      let rawfile: resourceManager.RawFileDescriptor = context.resourceManager.getRawFdSync('test/test.png');
      console.log(`SUB_Global_Resource_Manager_0200_GetRawFdSync_Func_3900 rawfile =` + JSON.stringify(rawfile));
      expect(rawfile != null).assertTrue();
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetRawFdSync_Func_4000
    * @tc.name:    test getRawFdSync method throw 9001005 error code
    * @tc.desc:    get the RawFileDescriptor in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetRawFdSync_Func_4000', 0, async (done: Function) => {
      try {
        let rawfile: resourceManager.RawFileDescriptor = context.resourceManager.getRawFdSync('notexist.txt');
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetRawFdSync_Func_4000 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetRawFdSync_Func_4000 errMessage ${err.message}`);
        expect(err.code == 9001005).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetRawFileContentSync_Func_4100
    * @tc.name:    test getRawFileContentSync method in sync mode
    * @tc.desc:    get the rawFileContent in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetRawFileContentSync_Func_4100', 0, async (done: Function) => {
      let value: Uint8Array = context.resourceManager.getRawFileContentSync('rawfiletest.xml');
      console.log(`SUB_Global_Resource_Manager_0200_GetRawFileContentSync_Func_4100 ${value}`.slice(0, 10));
      console.log(`SUB_Global_Resource_Manager_0200_GetRawFileContentSync_Func_4100 ${value.length}`);
      expect(value.length != null).assertTrue();
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetRawFileContentSync_Func_4200
    * @tc.name:    test getRawFileContentSync method in sync mode
    * @tc.desc:    get the rawFileContent in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetRawFileContentSync_Func_4200', 0, async (done: Function) => {
      let value: Uint8Array = context.resourceManager.getRawFileContentSync('test/test.png');
      console.log(`SUB_Global_Resource_Manager_0200_GetRawFileContentSync_Func_4200 ${value}`.slice(0, 10));
      console.log(`SUB_Global_Resource_Manager_0200_GetRawFileContentSync_Func_4200 ${value.length}`);
      expect(value.length == 128635).assertTrue();
      expect(value[0] == 137).assertTrue();
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetRawFileContentSync_Func_4300
    * @tc.name:    test getRawFileContentSync method throw 9001005 error code
    * @tc.desc:    get the rawFileContent in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetRawFileContentSync_Func_4300', 0, async (done: Function) => {
      try {
        let value: Uint8Array = context.resourceManager.getRawFileContentSync('notexist.txt');
        console.log(`SUB_Global_Resource_Manager_0200_GetRawFileContentSync_Func_4300 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetRawFileContentSync_Func_4300 ${typeof value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetRawFileContentSync_Func_4300 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetRawFileContentSync_Func_4300 errMessage ${err.message}`);
        expect(err.code == 9001005).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4400
    * @tc.name:    test getMediaContentSync method
    * @tc.desc:    get the media in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4400', 0, async (done: Function) => {
      let value: Uint8Array = context.resourceManager.getMediaContentSync($r('app.media.icon').id, 0);
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4400 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4400 ${typeof value}`);
      expect(value.length == 6790).assertTrue();
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4500
    * @tc.name:    test getMediaContentSync method
    * @tc.desc:    get the media in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4500', 0, async (done: Function) => {
      let value: Uint8Array = context.resourceManager.getMediaContentSync($r('app.media.icon').id, 120);
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4500 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4500 ${typeof value}`);
      expect(value.length == 6790).assertTrue();
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4600
    * @tc.name:    test getMediaContentSync method
    * @tc.desc:    get the media in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4600', 0, async (done: Function) => {
      let value: Uint8Array = context.resourceManager.getMediaContentSync($r('app.media.test').id, 0);
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4600 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4600 ${typeof value}`);
      expect(value.length == 128635).assertTrue();
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4700
    * @tc.name:    test getMediaContentSync method throw 9001001 error code
    * @tc.desc:    get the media in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4700', 0, async (done: Function) => {
      try {
        let value: Uint8Array = context.resourceManager.getMediaContentSync(1111, 0);
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4700 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4700 ${typeof value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4700 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4700 errMessage ${err.message}`);
        expect(err.code == 9001001).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4800
    * @tc.name:    test getMediaContentSync method throw 9001002 error code
    * @tc.desc:    get the media in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4800', 0, async (done: Function) => {
      try {
        let value: Uint8Array = context.resourceManager.getMediaContentSync($r('app.string.test_1').id, 0);
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4800 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4800 ${typeof value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4800 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4800 errMessage ${err.message}`);
        expect(err.code == 9001002).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4900
    * @tc.name:    test getMediaContentSync method
    * @tc.desc:    get the media in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4900', 0, async (done: Function) => {
      let value: Uint8Array = context.resourceManager.getMediaContentSync({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.media.icon').id
      }, 0)
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4900 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_4900 ${typeof value}`);
      expect(value.length == 6790).assertTrue();
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_5000
    * @tc.name:    test getMediaContentSync method
    * @tc.desc:    get the media in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_5000', 0, async (done: Function) => {
      let value: Uint8Array = context.resourceManager.getMediaContentSync({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.media.icon').id
      }, 120)
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_5000 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_5000 ${typeof value}`);
      expect(value.length == 6790).assertTrue();
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_5100
    * @tc.name:    test getMediaContentSync method
    * @tc.desc:    get the media in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_5100', 0, async (done: Function) => {
      let value: Uint8Array = context.resourceManager.getMediaContentSync({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.media.test').id
      }, 0)
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_5100 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_5100 ${typeof value}`);
      expect(value.length == 128635).assertTrue();
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_5200
    * @tc.name:    test getMediaContentSync method throw 9001001 error code
    * @tc.desc:    get the media in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_5200', 0, async (done: Function) => {
      try {
        let value: Uint8Array = context.resourceManager.getMediaContentSync({
          bundleName: "com.example.resourcemanagertest2",
          moduleName: "entry_test",
          id: 1111
        }, 0)
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_5200 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_5200 ${typeof value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_5200 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_5200 errMessage ${err.message}`);
        expect(err.code == 9001001).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_5300
    * @tc.name:    test getMediaContentSync method throw 9001002 error code
    * @tc.desc:    get the media in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_5300', 0, async (done: Function) => {
      try {
        let value: Uint8Array = context.resourceManager.getMediaContentSync({
          bundleName: "com.example.resourcemanagertest2",
          moduleName: "entry_test",
          id: $r('app.string.test_1').id
        }, 0)
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_5300 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_5300 ${typeof value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_5300 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentSync_Func_5300 errMessage ${err.message}`);
        expect(err.code == 9001002).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5400
    * @tc.name:    test getMediaContentBase64Sync method
    * @tc.desc:    get the mediaBase64 in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5400', 0, async (done: Function) => {
      let value: string = context.resourceManager.getMediaContentBase64Sync($r('app.media.icon').id, 0);
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5400 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5400 ${typeof value}`);
      expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAHIA');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5500
    * @tc.name:    test getMediaContentBase64Sync method
    * @tc.desc:    get the mediaBase64 in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5500', 0, async (done: Function) => {
      let value: string = context.resourceManager.getMediaContentBase64Sync($r('app.media.icon').id, 120);
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5500 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5500 ${typeof value}`);
      expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAHIA');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5600
    * @tc.name:    test getMediaContentBase64Sync method
    * @tc.desc:    get the mediaBase64 in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5600', 0, async (done: Function) => {
      let value: string = context.resourceManager.getMediaContentBase64Sync($r('app.media.test').id, 0);
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5600 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5600 ${typeof value}`);
      expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAs0A');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5700
    * @tc.name:    test getMediaContentBase64Sync method throw 9001001 error code
    * @tc.desc:    get the mediaBase64 in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5700', 0, async (done: Function) => {
      try {
        let value: string = context.resourceManager.getMediaContentBase64Sync(1111, 0);
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5700 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5700 ${typeof value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5700 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5700 errMessage ${err.message}`);
        expect(err.code == 9001001).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5800
    * @tc.name:    test getMediaContentBase64Sync method throw 9001002 error code
    * @tc.desc:    get the mediaBase64 in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5800', 0, async (done: Function) => {
      try {
        let value: string = context.resourceManager.getMediaContentBase64Sync($r('app.string.test_1').id, 0);
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5800 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5800 ${typeof value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5800 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5800 errMessage ${err.message}`);
        expect(err.code == 9001002).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5900
    * @tc.name:    test getMediaContentBase64Sync method
    * @tc.desc:    get the mediaBase64 in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5900', 0, async (done: Function) => {
      let value: string = context.resourceManager.getMediaContentBase64Sync({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.media.icon').id
      }, 0)
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5900 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_5900 ${typeof value}`);
      expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAHIA');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_6000
    * @tc.name:    test getMediaContentBase64Sync method
    * @tc.desc:    get the mediaBase64 in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_6000', 0, async (done: Function) => {
      let value: string = context.resourceManager.getMediaContentBase64Sync({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.media.icon').id
      }, 120);
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_6000 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_6000 ${typeof value}`);
      expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAHIA');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_6100
    * @tc.name:    test getMediaContentBase64Sync method
    * @tc.desc:    get the mediaBase64 in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_6100', 0, async (done: Function) => {
      let value: string = context.resourceManager.getMediaContentBase64Sync({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.media.test').id
      }, 0);
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_6100 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_6100 ${typeof value}`);
      expect(value.slice(22, 50)).assertEqual('iVBORw0KGgoAAAANSUhEUgAAAs0A');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_6200
    * @tc.name:    test getMediaContentBase64Sync method throw 9001001 error code
    * @tc.desc:    get the mediaBase64 in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_6200', 0, async (done: Function) => {
      try {
        let value: string = context.resourceManager.getMediaContentBase64Sync({
          bundleName: "com.example.resourcemanagertest2",
          moduleName: "entry_test",
          id: 1111
        }, 0);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_6200 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_6200 errMessage ${err.message}`);
        expect(err.code == 9001001).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_6300
    * @tc.name:    test getMediaContentBase64Sync method throw 9001002 error code
    * @tc.desc:    get the mediaBase64 in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_6300', 0, async (done: Function) => {
      try {
        let value: string = context.resourceManager.getMediaContentBase64Sync({
          bundleName: "com.example.resourcemanagertest2",
          moduleName: "entry_test",
          id: $r('app.string.test_1').id
        }, 0);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_6300 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetMediaContentBase64Sync_Func_6300 errMessage ${err.message}`);
        expect(err.code == 9001002).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6400
    * @tc.name:    test getPluralStringValueSync method in sync mode
    * @tc.desc:    get the plural string in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6400', 0, async (done: Function) => {
      let value: string = context.resourceManager.getPluralStringValueSync($r('app.plural.plural_name').id, 1);
      console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6400 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6400 ${typeof value}`);
      expect(value).assertEqual('1 test other');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6500
    * @tc.name:    test getPluralStringValueSync method in sync mode
    * @tc.desc:    get the plural string in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6500', 0, async (done: Function) => {
      let value: string = context.resourceManager.getPluralStringValueSync($r('app.plural.plural_name').id, 2);
      console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6500 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6500 ${typeof value}`);
      expect(value).assertEqual('2 test other');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6600
    * @tc.name:    test getPluralStringValueSync method in sync mode
    * @tc.desc:    get the plural string in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6600', 0, async (done: Function) => {
      let value: string = context.resourceManager.getPluralStringValueSync($r('app.plural.plural_name2').id, 1);
      console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6600 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6600 ${typeof value}`);
      expect(value).assertEqual('1 test2 other');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6700
    * @tc.name:    test getPluralStringValueSync method in sync mode throw 9001001 error code
    * @tc.desc:    get the plural string in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6700', 0, async (done: Function) => {
      try {
        let value: string = context.resourceManager.getPluralStringValueSync(1111, 1);
        console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6700 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6700 ${typeof value}`);
        expect(value).assertEqual('1 test other');
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6700 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6700 errMessage ${err.message}`);
        expect(err.code == 9001001).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6800
    * @tc.name:    test getPluralStringValueSync method in sync mode throw 9001002 error code
    * @tc.desc:    get the plural string in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6800', 0, async (done: Function) => {
      try {
        let value: string = context.resourceManager.getPluralStringValueSync($r('app.string.test_1').id, 1);
        console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6800 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6800 ${typeof value}`);
        expect(value).assertEqual('1 test other');
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6800 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6800 errMessage ${err.message}`);
        expect(err.code == 9001002).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6900
    * @tc.name:    test getPluralStringValueSync method in sync mode
    * @tc.desc:    get the plural string in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6900', 0, async (done: Function) => {
      let value: string = context.resourceManager.getPluralStringValueSync({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.plural.plural_name').id
      }, 1);
      console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6900 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_6900 ${typeof value}`);
      expect(value).assertEqual('1 test other');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_7000
    * @tc.name:    test getPluralStringValueSync method in sync mode
    * @tc.desc:    get the plural string in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_7000', 0, async (done: Function) => {
      let value: string = context.resourceManager.getPluralStringValueSync({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.plural.plural_name').id
      }, 2);
      console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_7000 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_7000 ${typeof value}`);
      expect(value).assertEqual('2 test other');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_7100
    * @tc.name:    test getPluralStringValueSync method in sync mode
    * @tc.desc:    get the plural string in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_7100', 0, async (done: Function) => {
      let value: string = context.resourceManager.getPluralStringValueSync({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.plural.plural_name2').id
      }, 1);
      console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_7100 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_7100 ${typeof value}`);
      expect(value).assertEqual('1 test2 other');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_7200
    * @tc.name:    test getPluralStringValueSync method in sync mode throw 9001001 error code
    * @tc.desc:    get the plural string in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_7200', 0, async (done: Function) => {
      try {
        let value: string = context.resourceManager.getPluralStringValueSync({
          bundleName: "com.example.resourcemanagertest2",
          moduleName: "entry_test",
          id: 1111
        }, 1);
        console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_7200 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_7200 ${typeof value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_7200 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_7200 errMessage ${err.message}`);
        expect(err.code == 9001001).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_7300
    * @tc.name:    test getPluralStringValueSync method in sync mode throw 9001002 error code
    * @tc.desc:    get the plural string in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_7300', 0, async (done: Function) => {
      try {
        let value: string = context.resourceManager.getPluralStringValueSync({
          bundleName: "com.example.resourcemanagertest2",
          moduleName: "entry_test",
          id: $r('app.string.test_1').id
        }, 1);
        console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_7300 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_7300 ${typeof value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_7300 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringValueSync_Func_7300 errMessage ${err.message}`);
        expect(err.code == 9001002).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7400
    * @tc.name:    test getStringArrayValueSync method
    * @tc.desc:    get the string array in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7400', 0, async (done: Function) => {
      let value: Array<string> = context.resourceManager.getStringArrayValueSync($r('app.strarray.sizeList').id);
      console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7400 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7400 ${typeof value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7400 ${value.length}`);
      expect(value.length).assertEqual(4);
      expect(value[0]).assertEqual('small');
      expect(value[1]).assertEqual('middle');
      expect(value[2]).assertEqual('large');
      expect(value[3]).assertEqual('extra large');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7500
    * @tc.name:    test getStringArrayValueSync method
    * @tc.desc:    get the string array in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7500', 0, async (done: Function) => {
      let value: Array<string> = context.resourceManager.getStringArrayValueSync($r('app.strarray.sizeList2').id);
      console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7500 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7500 ${typeof value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7500 ${value.length}`);
      expect(value.length).assertEqual(2);
      expect(value[0]).assertEqual('little');
      expect(value[1]).assertEqual('much');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7600
    * @tc.name:    test getStringArrayValueSync method throw 9001001 error code
    * @tc.desc:    get the string array in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7600', 0, async (done: Function) => {
      try {
        let value: Array<string> = context.resourceManager.getStringArrayValueSync(1111);
        console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7600 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7600 ${typeof value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7600 ${value.length}`);
        expect(value.length).assertEqual(2);
        expect(value[0]).assertEqual('little');
        expect(value[1]).assertEqual('much');
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7600 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7600 errMessage ${err.message}`);
        expect(err.code == 9001001).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7700
    * @tc.name:    test getStringArrayValueSync method throw 9001002 error code
    * @tc.desc:    get the string array in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7700', 0, async (done: Function) => {
      try {
        let value: Array<string> = context.resourceManager.getStringArrayValueSync($r('app.string.test_1').id);
        console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7700 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7700 ${typeof value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7700 ${value.length}`);
        expect(value.length).assertEqual(2);
        expect(value[0]).assertEqual('little');
        expect(value[1]).assertEqual('much');
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7700 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7700 errMessage ${err.message}`);
        expect(err.code == 9001002).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7800
    * @tc.name:    test getStringArrayValueSync method
    * @tc.desc:    get the string array in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7800', 0, async (done: Function) => {
      let value: Array<string> = context.resourceManager.getStringArrayValueSync({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.strarray.sizeList').id
      });
      console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7800 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7800 ${typeof value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7800 ${value.length}`);
      expect(value.length).assertEqual(4);
      expect(value[0]).assertEqual('small');
      expect(value[1]).assertEqual('middle');
      expect(value[2]).assertEqual('large');
      expect(value[3]).assertEqual('extra large');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7900
    * @tc.name:    test getStringArrayValueSync method
    * @tc.desc:    get the string array in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7900', 0, async (done: Function) => {
      let value: Array<string> = context.resourceManager.getStringArrayValueSync({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.strarray.sizeList2').id
      });
      console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7900 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7900 ${typeof value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_7900 ${value.length}`);
      expect(value.length).assertEqual(2);
      expect(value[0]).assertEqual('little');
      expect(value[1]).assertEqual('much');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_8000
    * @tc.name:    test getStringArrayValueSync method throw 9001001 error code
    * @tc.desc:    get the string array in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_8000', 0, async (done: Function) => {
      try {
        let value: Array<string> = context.resourceManager.getStringArrayValueSync({
          bundleName: "com.example.resourcemanagertest2",
          moduleName: "entry_test",
          id: 1111
        });
        console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_8000 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_8000 ${typeof value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_8000 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_8000 errMessage ${err.message}`);
        expect(err.code == 9001001).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_8100
    * @tc.name:    test getStringArrayValueSync method throw 9001002 error code
    * @tc.desc:    get the string array in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_8100', 0, async (done: Function) => {
      try {
        let value: Array<string> = context.resourceManager.getStringArrayValueSync({
          bundleName: "com.example.resourcemanagertest2",
          moduleName: "entry_test",
          id: $r('app.string.test_1').id
        });
        console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_8100 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_8100 ${typeof value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_8100 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayValueSync_Func_8100 errMessage ${err.message}`);
        expect(err.code == 9001002).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetPluralStringByNameSync_Func_8200
    * @tc.name:    test getPluralStringByNameSync
    * @tc.desc:    get the plural string in Sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetPluralStringByNameSync_Func_8200', 0, async (done: Function) => {
      let value: string = context.resourceManager.getPluralStringByNameSync('plural_name', 1);
      console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringByNameSync_Func_8200 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringByNameSync_Func_8200 ${typeof value}`);
      expect(value).assertEqual('1 test other');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetPluralStringByNameSync_Func_8300
    * @tc.name:    test getPluralStringByNameSync
    * @tc.desc:    get the plural string in Sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetPluralStringByNameSync_Func_8300', 0, async (done: Function) => {
      let value: string = context.resourceManager.getPluralStringByNameSync('plural_name', 2);
      console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringByNameSync_Func_8300 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringByNameSync_Func_8300 ${typeof value}`);
      expect(value).assertEqual('2 test other');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetPluralStringByNameSync_Func_8400
    * @tc.name:    test getPluralStringByNameSync
    * @tc.desc:    get the plural string in Sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetPluralStringByNameSync_Func_8400', 0, async (done: Function) => {
      let value: string = context.resourceManager.getPluralStringByNameSync('plural_name2', 1);
      console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringByNameSync_Func_8400 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringByNameSync_Func_8400 ${typeof value}`);
      expect(value).assertEqual('1 test2 other');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetPluralStringByNameSync_Func_8500
    * @tc.name:    test getPluralStringByNameSync method throw 9001003 error code
    * @tc.desc:    get the plural string in Sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetPluralStringByNameSync_Func_8500', 0, async (done: Function) => {
      try {
        let value: string = context.resourceManager.getPluralStringByNameSync('notexist', 1);
        console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringByNameSync_Func_8500 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringByNameSync_Func_8500 ${typeof value}`);
        expect(value).assertEqual('1 test other');
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringByNameSync_Func_8500 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetPluralStringByNameSync_Func_8500 errMessage ${err.message}`);
        expect(err.code == 9001003).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetStringArrayByNameSync_Func_8600
    * @tc.name:    test getStringArrayByNameSync method
    * @tc.desc:    get the string array in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetStringArrayByNameSync_Func_8600', 0, async (done: Function) => {
      let value: Array<string> = context.resourceManager.getStringArrayByNameSync('sizeList');
      console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayByNameSync_Func_8600 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayByNameSync_Func_8600 ${typeof value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayByNameSync_Func_8600 ${value.length}`);
      expect(value.length).assertEqual(4);
      expect(value[0]).assertEqual('small');
      expect(value[1]).assertEqual('middle');
      expect(value[2]).assertEqual('large');
      expect(value[3]).assertEqual('extra large');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetStringArrayByNameSync_Func_8700
    * @tc.name:    test getStringArrayByNameSync method
    * @tc.desc:    get the string array in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetStringArrayByNameSync_Func_8700', 0, async (done: Function) => {
      let value: Array<string> = context.resourceManager.getStringArrayByNameSync('sizeList2');
      console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayByNameSync_Func_8700 ${value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayByNameSync_Func_8700 ${typeof value}`);
      console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayByNameSync_Func_8700 ${value.length}`);
      expect(value.length).assertEqual(2);
      expect(value[0]).assertEqual('little');
      expect(value[1]).assertEqual('much');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetStringArrayByNameSync_Func_8800
    * @tc.name:    test getStringArrayByNameSync method throw 9001003 error code
    * @tc.desc:    get the string array in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetStringArrayByNameSync_Func_8800', 0, async (done: Function) => {
      try {
        let value: Array<string> = context.resourceManager.getStringArrayByNameSync('notexist');
        console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayByNameSync_Func_8800 ${value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayByNameSync_Func_8800 ${typeof value}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayByNameSync_Func_8800 ${value.length}`);
        expect(value.length).assertEqual(2);
        expect(value[0]).assertEqual('little');
        expect(value[1]).assertEqual('much');
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayByNameSync_Func_8800 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_GetStringArrayByNameSync_Func_8800 errMessage ${err.message}`);
        expect(err.code == 9001003).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetConfigurationSync_Func_8900
    * @tc.name:    test getConfigurationSync method
    * @tc.desc:    get the configuration in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetConfigurationSync_Func_8900', 0, async (done: Function) => {
      let value: resourceManager.Configuration = context.resourceManager.getConfigurationSync();
      console.log(`SUB_Global_Resource_Manager_0200_GetConfigurationSync_Func_8900 ${JSON.stringify(value)}`);
      expect(value !== undefined).assertTrue();
      expect(value.direction !== null).assertTrue();
      expect(value.locale !== null).assertTrue();
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetDeviceCapabilitySync_Func_9000
    * @tc.name:    test getDeviceCapabilitySync method
    * @tc.desc:    get the device capability in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetDeviceCapabilitySync_Func_9000', 0, async (done: Function) => {
      let value: resourceManager.DeviceCapability = context.resourceManager.getDeviceCapabilitySync();
      console.log(`SUB_Global_Resource_Manager_0200_GetDeviceCapabilitySync_Func_9000 ${JSON.stringify(value)}`);
      expect(value !== undefined).assertTrue();
      expect(value.screenDensity !== null).assertTrue();
      expect(value.deviceType !== null).assertTrue();
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_AddResource_Func_9100
    * @tc.name:    test addResource method throw 9001010 error code
    * @tc.desc:    add resource
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_AddResource_Func_9100', 0, async (done: Function) => {
      try {
        // param not exist throw 9001010 error code
        context.resourceManager.addResource("notexist.xml");
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_AddResource_Func_9100 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_AddResource_Func_9100 errMessage ${err.message}`);
        expect(err.code == 9001010).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_AddResource_Func_9200
    * @tc.name:    test addResource method throw 401 error code
    * @tc.desc:    add resource
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_AddResource_Func_9200', 0, async (done: Function) => {
      try {
        let path: string = (1111 as string | number) as string;
        // param type not correct,throw 401 error code
        context.resourceManager.addResource(path);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_AddResource_Func_9200 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_AddResource_Func_9200 errMessage ${err.message}`);
        expect(err.code == 401).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_RemoveResource_Func_9300
    * @tc.name:    test removeResource method throw 9001010 error code
    * @tc.desc:    remove resource
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_RemoveResource_Func_9300', 0, async (done: Function) => {
      try {
        // param not exist throw 9001010 error code
        context.resourceManager.removeResource("notexist.xml");
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_RemoveResource_Func_9300 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_RemoveResource_Func_9300 errMessage ${err.message}`);
        expect(err.code == 9001010).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_RemoveResource_Func_9400
    * @tc.name:    test removeResource method throw 401 error code
    * @tc.desc:    remove resource
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_RemoveResource_Func_9400', 0, async (done: Function) => {
      try {
        let path: string = (1111 as string | number) as string;
        // param type not correct,throw 401 error code
        context.resourceManager.removeResource(path);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_RemoveResource_Func_9400 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_RemoveResource_Func_9400 errMessage ${err.message}`);
        expect(err.code == 401).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_CloseRawFdSync_Func_9500
    * @tc.name:    test closeRawFdSync method throw 9001005 error code
    * @tc.desc:    get the closeRawFd in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_CloseRawFdSync_Func_9500', 0, async (done: Function) => {
      try {
        // param not exist throw 9001005 error code
        context.resourceManager.closeRawFdSync('notexist.xml');
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_CloseRawFdSync_Func_9500 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_CloseRawFdSync_Func_9500 errMessage ${err.message}`);
        expect(err.code == 9001005).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_CloseRawFdSync_Func_9600
    * @tc.name:    test closeRawFdSync method throw 401 error code throw 401 error code
    * @tc.desc:    get the closeRawFd in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_CloseRawFdSync_Func_9600', 0, async (done: Function) => {
      try {
        let path: string = (1111 as string | number) as string;
        // param path not correct,throw 401 error code
        context.resourceManager.closeRawFdSync(path);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_CloseRawFdSync_Func_9600 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_CloseRawFdSync_Func_9600 errMessage ${err.message}`);
        expect(err.code == 401).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_CloseRawFdSync_Func_9700
    * @tc.name:    test closeRawFdSync method
    * @tc.desc:    get the closeRawFd in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_CloseRawFdSync_Func_9700', 0, () => {
      try {
        context.resourceManager.closeRawFdSync('rawfiletest.xml');
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0200_CloseRawFdSync_Func_9700 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0200_CloseRawFdSync_Func_9700 errMessage ${err.message}`);
        expect().assertFail();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_DeviceType_Func_9800
    * @tc.name:    test DEVICE_TYPE_TABLET
    * @tc.desc:    get the value of DEVICE_TYPE_TABLET
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 0
    */
    it('SUB_Global_Resource_Manager_0200_DeviceType_Func_9800', 0, async (done: Function) => {
      expect(resourceManager.DeviceType.DEVICE_TYPE_TABLET).assertEqual(0x01);
      expect(resourceManager.DeviceType.DEVICE_TYPE_CAR).assertEqual(0x02);
      expect(resourceManager.DeviceType.DEVICE_TYPE_PC).assertEqual(0x03);
      expect(resourceManager.DeviceType.DEVICE_TYPE_TV).assertEqual(0x04);
      expect(resourceManager.DeviceType.DEVICE_TYPE_WEARABLE).assertEqual(0x06);
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0200_GetStringSync_Func_9600
    * @tc.name:    test getStringSync method
    * @tc.desc:    get the string in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0200_GetStringSync_Func_9900', 0, async (done: Function) => {
      let value: string = context.resourceManager.getStringSync($r('app.string.test_1').id);
      console.log(`SUB_Global_Resource_Manager_0200_GetStringSync_Func_9900 ${value}`);
      expect(value).assertEqual('Test1');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetStringSync_Func_0100
    * @tc.name:    test getStringSync method
    * @tc.desc:    get the string in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetStringSync_Func_0100', 0, async (done: Function) => {
      let value: string = context.resourceManager.getStringSync($r('app.string.test_2').id, 3)
      console.log(`SUB_Global_Resource_Manager_0300_GetStringSync_Func_0100 ${value}`);
      expect(value).assertEqual('Test3');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetStringSync_Func_0200
    * @tc.name:    test getStringSync method throw 9001001 error code
    * @tc.desc:    get the string in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetStringSync_Func_0200', 0, async (done: Function) => {
      try {
        let value: string = context.resourceManager.getStringSync(111, 3);
        console.log(`SUB_Global_Resource_Manager_0300_GetStringSync_Func_0200 ${value}`);
        expect(value).assertEqual('Test3');
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0300_GetStringSync_Func_0200 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0300_GetStringSync_Func_0200 errMessage ${err.message}`);
        expect(err.code == 9001001).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetStringSync_Func_0300
    * @tc.name:    test getStringSync method throw 9001002 error code
    * @tc.desc:    get the string in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetStringSync_Func_0300', 0, async (done: Function) => {
      try {
        let value: string = context.resourceManager.getStringSync($r('app.media.icon').id, 3);
        console.log(`SUB_Global_Resource_Manager_0300_GetStringSync_Func_0300 ${value}`);
        expect(value).assertEqual('Test3');
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0300_GetStringSync_Func_0300 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0300_GetStringSync_Func_0300 errMessage ${err.message}`);
        expect(err.code == 9001002).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetStringSync_Func_0400
    * @tc.name:    test getStringSync method throw 9001006 error code
    * @tc.desc:    get the string in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetStringSync_Func_0400', 0, async (done: Function) => {
      try {
        let value: string = context.resourceManager.getStringSync($r('app.string.test_3').id, 3);
        console.log(`SUB_Global_Resource_Manager_0300_GetStringSync_Func_0400 ${value}`);
        expect(value).assertEqual('Test3');
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0300_GetStringSync_Func_0400 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0300_GetStringSync_Func_0400 errMessage ${err.message}`);
        expect(err.code == 9001006).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetStringSync_Func_0500
    * @tc.name:    test getStringSync method
    * @tc.desc:    get the string in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetStringSync_Func_0500', 0, async (done: Function) => {
      let value: string = context.resourceManager.getStringSync({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.string.test_1').id
      });
      console.log(`SUB_Global_Resource_Manager_0300_GetStringSync_Func_0500 ${value}`);
      expect(value).assertEqual('Test1');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetStringSync_Func_0600
    * @tc.name:    test getStringSync method
    * @tc.desc:    get the string in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetStringSync_Func_0600', 0, async (done: Function) => {
      let value: string = context.resourceManager.getStringSync({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: $r('app.string.test_2').id
      }, 3);
      console.log(`SUB_Global_Resource_Manager_0300_GetStringSync_Func_0600 ${value}`);
      expect(value).assertEqual('Test3');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetStringSync_Func_0700
    * @tc.name:    test getStringSync method throw 9001001 error code
    * @tc.desc:    get the string in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetStringSync_Func_0700', 0, async (done: Function) => {
      try {
        let value: string = context.resourceManager.getStringSync({
          bundleName: "com.example.resourcemanagertest2",
          moduleName: "entry_test",
          id: 1111
        }, 3);
        console.log(`SUB_Global_Resource_Manager_0300_GetStringSync_Func_0700 ${value}`);
        expect(value).assertEqual('Test3');
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0300_GetStringSync_Func_0700 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0300_GetStringSync_Func_0700 errMessage ${err.message}`);
        expect(err.code == 9001001).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetStringSync_Func_0800
    * @tc.name:    test getStringSync method throw 9001002 error code
    * @tc.desc:    get the string in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetStringSync_Func_0800', 0, async (done: Function) => {
      try {
        let value: string = context.resourceManager.getStringSync({
          bundleName: "com.example.resourcemanagertest2",
          moduleName: "entry_test",
          id: $r('app.media.icon').id
        }, 3);
        console.log(`SUB_Global_Resource_Manager_0300_GetStringSync_Func_0800 ${value}`);
        expect(value).assertEqual('Test3');
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0300_GetStringSync_Func_0800 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0300_GetStringSync_Func_0800 errMessage ${err.message}`);
        expect(err.code == 9001002).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetStringSync_Func_0900
    * @tc.name:    test getStringSync method throw 9001006 error code
    * @tc.desc:    get the string in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetStringSync_Func_0900', 0, async (done: Function) => {
      try {
        let value: string = context.resourceManager.getStringSync({
          bundleName: "com.example.resourcemanagertest2",
          moduleName: "entry_test",
          id: $r('app.string.test_3').id
        }, 3);
        console.log(`SUB_Global_Resource_Manager_0300_GetStringSync_Func_0900 ${value}`);
        expect(value).assertEqual('Test3');
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0300_GetStringSync_Func_0900 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0300_GetStringSync_Func_0900 errMessage ${err.message}`);
        expect(err.code == 9001006).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetStringByNameSync_Func_1000
    * @tc.name:    test getStringByNameSync method
    * @tc.desc:    get the string by name in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetStringByNameSync_Func_1000', 0, async (done: Function) => {
      let value: string = context.resourceManager.getStringByNameSync('test_1');
      console.log(`SUB_Global_Resource_Manager_0300_GetStringByNameSync_Func_1000 ${value}`);
      expect(value).assertEqual('Test1');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetStringByNameSync_Func_1100
    * @tc.name:    test getStringSync method
    * @tc.desc:    get the string by name in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetStringByNameSync_Func_1100', 0, async (done: Function) => {
      let value: string = context.resourceManager.getStringByNameSync('test_2', 3);
      console.log(`SUB_Global_Resource_Manager_0300_GetStringByNameSync_Func_1100 ${value}`);
      expect(value).assertEqual('Test3');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetStringByNameSync_Func_1200
    * @tc.name:    test getStringSync method throw 9001003 error code
    * @tc.desc:    get the string by name in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetStringByNameSync_Func_1200', 0, async (done: Function) => {
      try {
        let value: string = context.resourceManager.getStringByNameSync('notexist', 3);
        console.log(`SUB_Global_Resource_Manager_0300_GetStringByNameSync_Func_1200 ${value}`);
        expect(value).assertEqual('Test3');
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0300_GetStringByNameSync_Func_1200 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0300_GetStringByNameSync_Func_1200 errMessage ${err.message}`);
        expect(err.code == 9001003).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetStringByNameSync_Func_1300
    * @tc.name:    test getStringSync method throw 9001006 error code
    * @tc.desc:    get the string by name in sync mode
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetStringByNameSync_Func_1300', 0, async (done: Function) => {
      try {
        let value: string = context.resourceManager.getStringByNameSync('test_3', 3);
        console.log(`SUB_Global_Resource_Manager_0300_GetStringByNameSync_Func_1300 ${value}`);
        expect(value).assertEqual('Test3');
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0300_GetStringByNameSync_Func_1300 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0300_GetStringByNameSync_Func_1300 errMessage ${err.message}`);
        expect(err.code == 9001006).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetLocales_Func_1400
    * @tc.name:    test getLocales method
    * @tc.desc:    get the locales
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetLocales_Func_1400', 0, async (done: Function) => {
      let value: Array<string> = context.resourceManager.getLocales(false);
      console.log(`SUB_Global_Resource_Manager_0300_GetLocales_Func_1400 ${value}`);
      expect(value).assertInstanceOf('Array');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetLocales_Func_1500
    * @tc.name:    test getLocales method
    * @tc.desc:    get the locales
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetLocales_Func_1500', 0, async (done: Function) => {
      let value: Array<string> = context.resourceManager.getLocales(true);
      console.log(`SUB_Global_Resource_Manager_0300_GetLocales_Func_1500 ${value}`);
      expect(value).assertInstanceOf('Array');
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetSymbol_Func_1600
    * @tc.name:    test getSymbol method
    * @tc.desc:    get the symbol
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetSymbol_Func_1600', 0, async (done: Function) => {
      let value: number = context.resourceManager.getSymbol(0x02000018);
      console.log(`SUB_Global_Resource_Manager_0300_GetSymbol_Func_1600 ${value}`);
      expect(value == 983041).assertTrue();
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetSymbol_Func_1700
    * @tc.name:    test getSymbol method  throw 9001006 error code
    * @tc.desc:    get the symbol
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetSymbol_Func_1700', 0, async (done: Function) => {
      try {
        let value: number = context.resourceManager.getSymbol(0x02000016);
        console.log(`SUB_Global_Resource_Manager_0300_GetSymbol_Func_1700 ${value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0300_GetSymbol_Func_1700 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0300_GetSymbol_Func_1700 errMessage ${err.message}`);
        expect(err.code == 9001006).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetSymbol_Func_1800
    * @tc.name:    test getSymbol method
    * @tc.desc:    get the symbol
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetSymbol_Func_1800', 0, async (done: Function) => {
      let value: number = context.resourceManager.getSymbol(0x02000015);
      console.log(`SUB_Global_Resource_Manager_0300_GetSymbol_Func_1800 ${value}`);
      expect(value == 983041).assertTrue();
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetSymbol_Func_1900
    * @tc.name:    test getSymbol method  throw 9001001 error code
    * @tc.desc:    get the symbol
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetSymbol_Func_1900', 0, async (done: Function) => {
      try {
        let value: number = context.resourceManager.getSymbol(1111);
        console.log(`SUB_Global_Resource_Manager_0300_GetSymbol_Func_1900 ${value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0300_GetSymbol_Func_1900 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0300_GetSymbol_Func_1900 errMessage ${err.message}`);
        expect(err.code == 9001001).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetSymbol_Func_2000
    * @tc.name:    test getSymbol method
    * @tc.desc:    get the symbol
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetSymbol_Func_2000', 0, async (done: Function) => {
      let value: number = context.resourceManager.getSymbol({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: 0x02000018
      });
      console.log(`SUB_Global_Resource_Manager_0300_GetSymbol_Func_2000 ${value}`);
      expect(value == 983041).assertTrue();
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetSymbol_Func_2100
    * @tc.name:    test getSymbol method  throw 9001006 error code
    * @tc.desc:    get the symbol
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetSymbol_Func_2100', 0, async (done: Function) => {
      try {
        let value: number = context.resourceManager.getSymbol({
          bundleName: "com.example.resourcemanagertest2",
          moduleName: "entry_test",
          id: 0x02000016
        });
        console.log(`SUB_Global_Resource_Manager_0300_GetSymbol_Func_2100 ${value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0300_GetSymbol_Func_2100 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0300_GetSymbol_Func_2100 errMessage ${err.message}`);
        expect(err.code == 9001006).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetSymbol_Func_2200
    * @tc.name:    test getSymbol method
    * @tc.desc:    get the symbol
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetSymbol_Func_2200', 0, async (done: Function) => {
      let value: number = context.resourceManager.getSymbol({
        bundleName: "com.example.resourcemanagertest2",
        moduleName: "entry_test",
        id: 0x02000015
      });
      console.log(`SUB_Global_Resource_Manager_0300_GetSymbol_Func_2200 ${value}`);
      expect(value == 983041).assertTrue();
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetSymbol_Func_2300
    * @tc.name:    test getSymbol method  throw 9001001 error code
    * @tc.desc:    get the symbol
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetSymbol_Func_2300', 0, async (done: Function) => {
      try {
        let value: number = context.resourceManager.getSymbol({
          bundleName: "com.example.resourcemanagertest2",
          moduleName: "entry_test",
          id: 1111
        });
        console.log(`SUB_Global_Resource_Manager_0300_GetSymbol_Func_2300 ${value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0300_GetSymbol_Func_2300 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0300_GetSymbol_Func_2300 errMessage ${err.message}`);
        expect(err.code == 9001001).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetSymbolByName_Func_2400
    * @tc.name:    test getSymbolByName method
    * @tc.desc:    get the Symbol By Name
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetSymbolByName_Func_2400', 0, async (done: Function) => {
      let value: number = context.resourceManager.getSymbolByName('test_1');
      console.log(`SUB_Global_Resource_Manager_0300_GetSymbolByName_Func_2400 ${value}`);
      expect(value == 983041).assertTrue();
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetSymbolByName_Func_2500
    * @tc.name:    test getSymbolByName method throw 9001006 error code
    * @tc.desc:    get the Symbol By Name
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetSymbolByName_Func_2500', 0, async (done: Function) => {
      try {
        let value: number = context.resourceManager.getSymbolByName('test_2');
        console.log(`SUB_Global_Resource_Manager_0300_GetSymbolByName_Func_2500 ${value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0300_GetSymbolByName_Func_2500 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0300_GetSymbolByName_Func_2500 errMessage ${err.message}`);
        expect(err.code == 9001006).assertTrue();
        done();
      }
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetSymbolByName_Func_2600
    * @tc.name:    test getSymbolByName method
    * @tc.desc:    get the Symbol By Name
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetSymbolByName_Func_2600', 0, async (done: Function) => {
      let value: number = context.resourceManager.getSymbolByName('test_4');
      console.log(`SUB_Global_Resource_Manager_0300_GetSymbolByName_Func_2600 ${value}`);
      expect(value == 983041).assertTrue();
      done();
    })

    /* *
    * @tc.number:  SUB_Global_Resource_Manager_0300_GetSymbolByName_Func_2700
    * @tc.name:    test getSymbolByName method throw 9001003 error code
    * @tc.desc:    get the Symbol By Name
    * @tc.size:    MediumTest
    * @tc.type:    method
    * @tc.level:   level 2
    */
    it('SUB_Global_Resource_Manager_0300_GetSymbolByName_Func_2700', 0, async (done: Function) => {
      try {
        let value: number = context.resourceManager.getSymbolByName('notexist');
        console.log(`SUB_Global_Resource_Manager_0300_GetSymbolByName_Func_2700 ${value}`);
        done();
      } catch (err) {
        console.log(`SUB_Global_Resource_Manager_0300_GetSymbolByName_Func_2700 errCode ${err.code}`);
        console.log(`SUB_Global_Resource_Manager_0300_GetSymbolByName_Func_2700 errMessage ${err.message}`);
        expect(err.code == 9001003).assertTrue();
        done();
      }
    })

    console.log('*************end resourceManagerTest2*************');
  })
}


