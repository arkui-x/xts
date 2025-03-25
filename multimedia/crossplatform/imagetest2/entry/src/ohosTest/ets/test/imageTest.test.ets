/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
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

import { describe, it, afterEach, expect } from '@ohos/hypium';
import image from '@ohos.multimedia.image';
import { BusinessError } from '@ohos.base';
import resourceManager from '@ohos.resourceManager';
import common from '@ohos.app.ability.common';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';

let abilityDelegatorRegistry: AbilityDelegatorRegistry.AbilityDelegator =
  AbilityDelegatorRegistry.getAbilityDelegator();
let context: common.Context = abilityDelegatorRegistry.getAppContext().createModuleContext("entry_test");

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function ImageTest() {
  describe('ImageTest', async () => {

    afterEach(async () => {
      await sleep(1000);
    })

    /**
     * @tc.number : SUB_Image_CreatePixelMapList_Func_0100
     * @tc.name   : createPixelMapList
     * @tc.desc   : test createPixelMapList with Options and not gif picture in Promise mode
     * @tc.size   : MediumTest
     * @tc.type   : Constant
     * @tc.level  : Level 1
     */
    it('SUB_Image_CreatePixelMapList_Func_0100', 0, async (done: Function) => {
      let rawfile: resourceManager.RawFileDescriptor = context.resourceManager.getRawFdSync("001test.jpg");
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 120
      };
      const imageSourceApi: image.ImageSource = image.createImageSource(rawfile, sourceOptions);
      let decodeOpts: image.DecodingOptions = {
        sampleSize: 1,
        editable: true,
        desiredSize: {
          width: 198, height: 202
        },
        rotate: 0,
        desiredPixelFormat: 3,
        index: 0,
      };
      imageSourceApi.createPixelMapList(decodeOpts).then((res) => {
        console.log(`SUB_Image_CreatePixelMapList_Func_0100 ${res}`);
        console.log(`length${res.length}`);
        expect(res).assertInstanceOf('Array');
        expect(res.length == 1).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Image_CreatePixelMapList_Func_0100 ${err.code},message is ${err.message}`);
        expect(err).assertFail();
        done();
      })
    })

    /**
     * @tc.number : SUB_Image_CreatePixelMapList_Func_0200
     * @tc.name   ：createPixelMapList
     * @tc.desc   ：test createPixelMapList with Options and gif picture in Promise mode
     * @tc.size   : MediumTest
     * @tc.type   : Constant
     * @tc.level  : Level 1
     */
    it('SUB_Image_CreatePixelMapList_Func_0200', 0, async (done: Function) => {
      let rawfile: resourceManager.RawFileDescriptor = context.resourceManager.getRawFdSync("001test.gif");
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 120
      };
      const imageSourceApi: image.ImageSource = image.createImageSource(rawfile, sourceOptions);
      let decodeOpts: image.DecodingOptions = {
        sampleSize: 1,
        editable: true,
        desiredSize: {
          width: 198, height: 202
        },
        rotate: 0,
        desiredPixelFormat: 3,
        index: 0,
      };
      imageSourceApi.createPixelMapList(decodeOpts).then((res) => {
        console.log(`SUB_Image_CreatePixelMapList_Func_0200 ${res}`);
        expect(res).assertInstanceOf('Array');
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Image_CreatePixelMapList_Func_0200 ${err.code},message is ${err.message}`);
        expect(err).assertFail();
        done();
      })
    })

    /**
     * @tc.number : SUB_Image_CreatePixelMapList_Func_0300
     * @tc.name   : createPixelMapList
     * @tc.desc   : test createPixelMapList with no Options and not gif picture in Promise mode
     * @tc.size   : MediumTest
     * @tc.type   : Constant
     * @tc.level  : Level 1
     */
    it('SUB_Image_CreatePixelMapList_Func_0300', 0, async (done: Function) => {
      let rawfile: resourceManager.RawFileDescriptor = context.resourceManager.getRawFdSync("001test.jpg");
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 120
      };
      const imageSourceApi: image.ImageSource = image.createImageSource(rawfile, sourceOptions);
      imageSourceApi.createPixelMapList().then((res) => {
        console.log(`SUB_Image_CreatePixelMapList_Func_0300 ${res}`);
        expect(res).assertInstanceOf('Array');
        expect(res.length == 1).assertTrue();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Image_CreatePixelMapList_Func_0300 ${err.code},message is ${err.message}`);
        expect(err).assertFail();
        done();
      })
    })

    /**
     * @tc.number : SUB_Image_CreatePixelMapList_Func_0400
     * @tc.name   : createPixelMapList
     * @tc.desc   : test createPixelMapList with no Options and gif picture in Promise mode
     * @tc.size   : MediumTest
     * @tc.type   : Constant
     * @tc.level  : Level 1
     */
    it('SUB_Image_CreatePixelMapList_Func_0400', 0, async (done: Function) => {
      let rawfile: resourceManager.RawFileDescriptor = context.resourceManager.getRawFdSync("001test.gif");
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 120
      };
      const imageSourceApi: image.ImageSource = image.createImageSource(rawfile, sourceOptions);
      imageSourceApi.createPixelMapList().then((res) => {
        console.log(`SUB_Image_CreatePixelMapList_Func_0400 ${res}`);
        expect(res).assertInstanceOf('Array');
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Image_CreatePixelMapList_Func_0400 ${err.code},message is ${err.message}`);
        expect(err).assertFail();
        done();
      })
    })

    /**
     * @tc.number : SUB_Image_CreatePixelMapList_Func_0500
     * @tc.name   : createPixelMapList
     * @tc.desc   : test createPixelMapList with invalid Options and not gif picture in Promise mode
     * @tc.size   : MediumTest
     * @tc.type   : Constant
     * @tc.level  : Level 2
     */
    it('SUB_Image_CreatePixelMapList_Func_0500', 0, async (done: Function) => {
      let rawfile: resourceManager.RawFileDescriptor = context.resourceManager.getRawFdSync("001test.jpg");
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 120
      };
      const imageSourceApi: image.ImageSource = image.createImageSource(rawfile, sourceOptions);
      let decodeOpts: image.DecodingOptions = {
        sampleSize: 99,
        editable: true,
        desiredSize: {
          width: 198, height: 202
        },
        rotate: 0,
        desiredPixelFormat: 3,
        index: 0,
      };
      imageSourceApi.createPixelMapList(decodeOpts).then((res) => {
        console.log(`SUB_Image_CreatePixelMapList_Func_0500 ${res}`);
        expect().assertFail();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Image_CreatePixelMapList_Func_0500 ${err.code},message is ${err.message}`);
        expect(err.code == 62980118).assertTrue();
        done();
      })
    })

    /**
     * @tc.number : SUB_Image_CreatePixelMapList_Func_0600
     * @tc.name   : createPixelMapList
     * @tc.desc   : test createPixelMapList with default Options and not gif picture in callback mode
     * @tc.size   : MediumTest
     * @tc.type   : Constant
     * @tc.level  : Level 1
     */
    it('SUB_Image_CreatePixelMapList_Func_0600', 0, async (done: Function) => {
      let rawfile: resourceManager.RawFileDescriptor = context.resourceManager.getRawFdSync("001test.jpg");
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 120
      };
      const imageSourceApi: image.ImageSource = image.createImageSource(rawfile, sourceOptions);
      imageSourceApi.createPixelMapList((err: BusinessError, pixelmaplist: Array<image.PixelMap>) => {
        if (err != undefined) {
          console.log(`SUB_Image_CreatePixelMapList_Func_0600 ${err.code},message is ${err.message}`);
          expect(err).assertFail();
          done();
        } else {
          console.log(`SUB_Image_CreatePixelMapList_Func_0600 ${pixelmaplist}`);
          expect(pixelmaplist).assertInstanceOf('Array');
          expect(pixelmaplist.length == 1).assertTrue();
          done();
        }
      })
    })

    /**
     * @tc.number : SUB_Image_CreatePixelMapList_Func_0700
     * @tc.name   : createPixelMapList
     * @tc.desc   : test createPixelMapList with default Options and gif picture in callback mode
     * @tc.size   : MediumTest
     * @tc.type   : Constant
     * @tc.level  : Level 1
     */
    it('SUB_Image_CreatePixelMapList_Func_0700', 0, async (done: Function) => {
      let rawfile: resourceManager.RawFileDescriptor = context.resourceManager.getRawFdSync("001test.gif");
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 120
      };
      const imageSourceApi: image.ImageSource = image.createImageSource(rawfile, sourceOptions);
      imageSourceApi.createPixelMapList((err: BusinessError, pixelmaplist: Array<image.PixelMap>) => {
        if (err != undefined) {
          console.log(`SUB_Image_CreatePixelMapList_Func_0700 ${err.code},message is ${err.message}`);
          expect(err).assertFail();
          done();
        } else {
          console.log(`SUB_Image_CreatePixelMapList_Func_0700 ${pixelmaplist}`);
          expect(pixelmaplist).assertInstanceOf('Array');
          done();
        }
      })
    })

    /**
     * @tc.number : SUB_Image_CreatePixelMapList_Func_0800
     * @tc.name   : createPixelMapList
     * @tc.desc   : test createPixelMapList with Options and not gif picture in callback mode
     * @tc.size   : MediumTest
     * @tc.type   : Constant
     * @tc.level  : Level 1
     */
    it('SUB_Image_CreatePixelMapList_Func_0800', 0, async (done: Function) => {
      let rawfile: resourceManager.RawFileDescriptor = context.resourceManager.getRawFdSync("001test.jpg");
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 120
      };
      const imageSourceApi: image.ImageSource = image.createImageSource(rawfile, sourceOptions);
      let decodeOpts: image.DecodingOptions = {
        sampleSize: 1,
        editable: true,
        desiredSize: {
          width: 198, height: 202
        },
        rotate: 0,
        desiredPixelFormat: 3,
        index: 0,
      };
      imageSourceApi.createPixelMapList(decodeOpts, (err: BusinessError, pixelmaplist: Array<image.PixelMap>) => {
        if (err != undefined) {
          console.log(`SUB_Image_CreatePixelMapList_Func_0800 ${err.code},message is ${err.message}`);
          expect(err).assertFail();
          done();
        } else {
          console.log(`SUB_Image_CreatePixelMapList_Func_0800 ${pixelmaplist}`);
          expect(pixelmaplist).assertInstanceOf('Array');
          expect(pixelmaplist.length == 1).assertTrue();
          done();
        }
      })
    })

    /**
     * @tc.number : SUB_Image_CreatePixelMapList_Func_0900
     * @tc.name   : createPixelMapList
     * @tc.desc   : test createPixelMapList with Options and gif picture in callback mode
     * @tc.size   : MediumTest
     * @tc.type   : Constant
     * @tc.level  : Level 1
     */
    it('SUB_Image_CreatePixelMapList_Func_0900', 0, async (done: Function) => {
      let rawfile: resourceManager.RawFileDescriptor = context.resourceManager.getRawFdSync("001test.gif");
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 120
      };
      const imageSourceApi: image.ImageSource = image.createImageSource(rawfile, sourceOptions);
      let decodeOpts: image.DecodingOptions = {
        sampleSize: 1,
        editable: true,
        desiredSize: {
          width: 198, height: 202
        },
        rotate: 0,
        desiredPixelFormat: 3,
        index: 0,
      };
      imageSourceApi.createPixelMapList(decodeOpts, (err: BusinessError, pixelmaplist: Array<image.PixelMap>) => {
        if (err != undefined) {
          console.log(`SUB_Image_CreatePixelMapList_Func_0900 ${err.code},message is ${err.message}`);
          expect(err).assertFail();
          done();
        } else {
          console.log(`SUB_Image_CreatePixelMapList_Func_0900 ${pixelmaplist}`);
          expect(pixelmaplist).assertInstanceOf('Array');
          done();
        }
      })
    })

    /**
     * @tc.number : SUB_Image_CreatePixelMapList_Func_1000
     * @tc.name   : createPixelMapList
     * @tc.desc   : test createPixelMapList with invalid Options and not gif picture in callback mode
     * @tc.size   : MediumTest
     * @tc.type   : Constant
     * @tc.level  : Level 2
     */
    it('SUB_Image_CreatePixelMapList_Func_1000', 0, async (done: Function) => {
      let rawfile: resourceManager.RawFileDescriptor = context.resourceManager.getRawFdSync("001test.jpg");
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 120
      };
      const imageSourceApi: image.ImageSource = image.createImageSource(rawfile, sourceOptions);
      let decodeOpts: image.DecodingOptions = {
        sampleSize: 99,
        editable: true,
        desiredSize: {
          width: 198, height: 202
        },
        rotate: 0,
        desiredPixelFormat: 3,
        index: 0,
      };
      imageSourceApi.createPixelMapList(decodeOpts, (err: BusinessError, pixelmaplist: Array<image.PixelMap>) => {
        if (err != undefined) {
          console.log(`SUB_Image_CreatePixelMapList_Func_1000 ${err.code},message is ${err.message}`);
          expect(err.code == 62980118).assertTrue();
          done();
        } else {
          console.log(`SUB_Image_CreatePixelMapList_Func_1000 ${pixelmaplist}`);
          expect(pixelmaplist).assertInstanceOf('Array');
          done();
        }
      })
    })

    /**
     * @tc.number : SUB_Image_GetDelayTimeList_Func_1100
     * @tc.name   : getDelayTimeList
     * @tc.desc   : test getDelayTimeList with not gif picture in callback mode
     * @tc.size   : MediumTest
     * @tc.type   : Constant
     * @tc.level  : Level 2
     */
    it('SUB_Image_GetDelayTimeList_Func_1100', 0, async (done: Function) => {
      let rawfile: resourceManager.RawFileDescriptor = context.resourceManager.getRawFdSync("001test.jpg");
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 120
      };
      const imageSourceApi: image.ImageSource = image.createImageSource(rawfile, sourceOptions);
      imageSourceApi.getDelayTimeList((err: BusinessError, delayTimes: Array<number>) => {
        if (err != undefined) {
          console.log(`SUB_Image_GetDelayTimeList_Func_1100 ${err.code},message is ${err.message}`);
          expect(err.code == 62980149).assertTrue();
          done();
        } else {
          console.log(`SUB_Image_GetDelayTimeList_Func_1100 ${delayTimes}`);
          expect().assertFail();
          done();
        }
      })
    })

    /**
     * @tc.number : SUB_Image_GetDelayTimeList_Func_1200
     * @tc.name   : getDelayTimeList
     * @tc.desc   : test getDelayTimeList with gif picture in callback mode
     * @tc.size   : MediumTest
     * @tc.type   : Constant
     * @tc.level  : Level 1
     */
    it('SUB_Image_GetDelayTimeList_Func_1200', 0, async (done: Function) => {
      let rawfile: resourceManager.RawFileDescriptor = context.resourceManager.getRawFdSync("001test.gif");
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 120
      };
      const imageSourceApi: image.ImageSource = image.createImageSource(rawfile, sourceOptions);
      imageSourceApi.getDelayTimeList((err: BusinessError, delayTimes: Array<number>) => {
        if (err != undefined) {
          console.log(`SUB_Image_GetDelayTimeList_Func_1200 ${err.code},message is ${err.message}`);
          expect(err).assertFail();
          done();
        } else {
          console.log(`SUB_Image_GetDelayTimeList_Func_1200 ${delayTimes}`);
          expect(delayTimes).assertInstanceOf('Array');
          done();
        }
      })
    })

    /**
     * @tc.number : SUB_Image_GetDelayTimeList_Func_1300
     * @tc.name   : getDelayTimeList
     * @tc.desc   : test getDelayTimeList with not gif picture in Promise mode
     * @tc.size   : MediumTest
     * @tc.type   : Constant
     * @tc.level  : Level 2
     */
    it('SUB_Image_GetDelayTimeList_Func_1300', 0, async (done: Function) => {
      let rawfile: resourceManager.RawFileDescriptor = context.resourceManager.getRawFdSync("001test.jpg");
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 120
      };
      const imageSourceApi: image.ImageSource = image.createImageSource(rawfile, sourceOptions);
      imageSourceApi.getDelayTimeList().then((delayTimes: Array<number>) => {
        console.log(`SUB_Image_GetDelayTimeList_Func_1300 ${delayTimes}`);
        expect().assertFail();
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Image_GetDelayTimeList_Func_1300 ${err.code},message is ${err.message}`);
        expect(err.code == 62980149).assertTrue();
        done();
      })
    })

    /**
     * @tc.number : SUB_Image_GetDelayTimeList_Func_1400
     * @tc.name   : getDelayTimeList
     * @tc.desc   : test getDelayTimeList with gif picture in Promise mode
     * @tc.size   : MediumTest
     * @tc.type   : Constant
     * @tc.level  : Level 1
     */
    it('SUB_Image_GetDelayTimeList_Func_1400', 0, async (done: Function) => {
      let rawfile: resourceManager.RawFileDescriptor = context.resourceManager.getRawFdSync("001test.gif");
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 120
      };
      const imageSourceApi: image.ImageSource = image.createImageSource(rawfile, sourceOptions);
      imageSourceApi.getDelayTimeList().then((delayTimes: Array<number>) => {
        console.log(`SUB_Image_GetDelayTimeList_Func_1400 ${delayTimes}`);
        expect(delayTimes).assertInstanceOf('Array');
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Image_GetDelayTimeList_Func_1400 ${err.code},message is ${err.message}`);
        expect(err).assertFail();
        done();
      })
    })

    /**
     * @tc.number : SUB_Image_GetFrameCount_Func_1500
     * @tc.name   : getFrameCount
     * @tc.desc   : test getFrameCount with not gif picture in callback mode
     * @tc.size   : MediumTest
     * @tc.type   : Constant
     * @tc.level  : Level 1
     */
    it('SUB_Image_GetFrameCount_Func_1500', 0, async (done: Function) => {
      let rawfile: resourceManager.RawFileDescriptor = context.resourceManager.getRawFdSync("001test.jpg");
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 120
      };
      const imageSourceApi: image.ImageSource = image.createImageSource(rawfile, sourceOptions);
      imageSourceApi.getFrameCount((err: BusinessError, frameCount: number) => {
        if (err != undefined) {
          console.log(`SUB_Image_GetFrameCount_Func_1500 ${err.code},message is ${err.message}`);
          expect(err).assertFail();
          done();
        } else {
          console.log(`SUB_Image_GetFrameCount_Func_1500 ${frameCount}`);
          expect(frameCount).assertEqual(1);
          done();
        }
      })
    })

    /**
     * @tc.number : SUB_Image_GetFrameCount_Func_1600
     * @tc.name   : getFrameCount
     * @tc.desc   : test getFrameCount with gif picture in callback mode
     * @tc.size   : MediumTest
     * @tc.type   : Constant
     * @tc.level  : Level 1
     */
    it('SUB_Image_GetFrameCount_Func_1600', 0, async (done: Function) => {
      let rawfile: resourceManager.RawFileDescriptor = context.resourceManager.getRawFdSync("001test.gif");
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 120
      };
      const imageSourceApi: image.ImageSource = image.createImageSource(rawfile, sourceOptions);
      imageSourceApi.getFrameCount((err: BusinessError, frameCount: Number) => {
        if (err != undefined) {
          console.log(`SUB_Image_GetFrameCount_Func_1600 ${err.code},message is ${err.message}`);
          expect(err).assertFail();
          done();
        } else {
          console.log(`SUB_Image_GetFrameCount_Func_1600 ${frameCount}`);
          expect(frameCount).assertInstanceOf('Number');
          done();
        }
      })
    })

    /**
     * @tc.number : SUB_Image_GetFrameCount_Func_1700
     * @tc.name   : getFrameCount
     * @tc.desc   : test getFrameCount with not gif picture in Promise mode
     * @tc.size   : MediumTest
     * @tc.type   : Constant
     * @tc.level  : Level 1
     */
    it('SUB_Image_GetFrameCount_Func_1700', 0, async (done: Function) => {
      let rawfile: resourceManager.RawFileDescriptor = context.resourceManager.getRawFdSync("001test.jpg");
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 120
      };
      const imageSourceApi: image.ImageSource = image.createImageSource(rawfile, sourceOptions);
      imageSourceApi.getFrameCount().then((frameCount: number) => {
        console.log(`SUB_Image_GetFrameCount_Func_1700 ${frameCount}`);
        expect(frameCount).assertEqual(1);
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Image_GetFrameCount_Func_1700 ${err.code},message is ${err.message}`);
        expect(err).assertFail();
        done();
      })
    })

    /**
     * @tc.number : SUB_Image_GetFrameCount_Func_1800
     * @tc.name   : getFrameCount
     * @tc.desc   : test getFrameCount with gif picture in Promise mode
     * @tc.size   : MediumTest
     * @tc.type   : Constant
     * @tc.level  : Level 1
     */
    it('SUB_Image_GetFrameCount_Func_1800', 0, async (done: Function) => {
      let rawfile: resourceManager.RawFileDescriptor = context.resourceManager.getRawFdSync("001test.gif");
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 120
      };
      const imageSourceApi: image.ImageSource = image.createImageSource(rawfile, sourceOptions);
      imageSourceApi.getFrameCount().then((frameCount: Number) => {
        console.log(`SUB_Image_GetFrameCount_Func_1800 ${frameCount}`);
        expect(frameCount).assertInstanceOf('Number');
        done();
      }).catch((err: BusinessError) => {
        console.log(`SUB_Image_GetFrameCount_Func_1800 ${err.code},message is ${err.message}`);
        expect(err).assertFail();
        done();
      })
    })
  })
}