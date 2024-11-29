/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License")
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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import { BusinessError } from '@ohos.base';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry'
import common from '@ohos.app.ability.common'
import image from '@ohos.multimedia.image';
import { fileIo as fs } from '@kit.CoreFileKit';

import { prepareImageFileFd } from './Common'
import { testPng, testJpg, testGif, testBmp } from './ImageResource'

let abilityDelegatorRegistry: AbilityDelegatorRegistry.AbilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator()
let context: common.Context = abilityDelegatorRegistry.getAppContext().createModuleContext("entry_test")

async function releaseImagePacker(ImagePacker: image.ImagePacker): Promise<void> {
  return new Promise((resolve, reject) => {
    ImagePacker.release((err) => {
      err == undefined ? resolve() : resolve()
    })
  });
}

async function releaseImageSource(imageSource: image.ImageSource): Promise<void> {
  return new Promise((resolve, reject) => {
    imageSource.release((err) => {
      err == undefined ? resolve() : resolve()
    })
  });
}

async function releasePixelmap(pixelmap: image.PixelMap): Promise<void> {
  return new Promise((resolve, reject) => {
    pixelmap.release((err) => {
      err == undefined ? resolve() : resolve()
    })
  });
}

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

let color = new ArrayBuffer(96)
let size: image.Size = {
  width: 4, height: 6
}
let initializationOptions: image.InitializationOptions = {
  editable: true,
  pixelFormat: image.PixelMapFormat.BGRA_8888,
  size: size,
  scaleMode: image.ScaleMode.CENTER_CROP,
  alphaType: image.AlphaType.UNPREMUL,
}
let filePath: string = context.cacheDir + '/' + 'test.png'
let fileFd: number | null

export default function ImagePackerTest() {
  describe('ImagePackerTest', () => {
    beforeAll(async () => {
      fileFd = await prepareImageFileFd(filePath, testPng)
      await sleep(1000);
    })
    afterEach(async () => {
      await sleep(50);
    })
    afterAll(async () => {
      await sleep(2000);
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToData_Func_0010
     * @tc.name   : packToData
     * @tc.desc   : Test Func packToData Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToData_Func_0010', 0, async (done: Function) => {
      let imageSourceApi: image.ImageSource = image.createImageSource(fileFd)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: 5120000 };
      try {
        await imagePackerApi.packToData(imageSourceApi, packOpts).then((data) => {
          expect(data.byteLength > 0).assertTrue();
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      await releaseImagePacker(imagePackerApi)
      await releaseImageSource(imageSourceApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToData_Func_0020
     * @tc.name   : packToData
     * @tc.desc   : Test Func packToData Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToData_Func_0020', 0, async (done: Function) => {
      let imageSourceApi: image.ImageSource = image.createImageSource(fileFd)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/webp", quality: 99, bufferSize: 5120000 };
      try {
        await imagePackerApi.packToData(imageSourceApi, packOpts).then((data) => {
          expect(data.byteLength > 0).assertTrue();
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      await releaseImagePacker(imagePackerApi)
      await releaseImageSource(imageSourceApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToData_Func_0030
     * @tc.name   : packToData
     * @tc.desc   : Test Func packToData Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToData_Func_0030', 0, async (done: Function) => {
      let imageSourceApi: image.ImageSource = image.createImageSource(fileFd)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/png", quality: 99, bufferSize: 5120000 };
      try {
        await imagePackerApi.packToData(imageSourceApi, packOpts).then((data) => {
          expect(data.byteLength > 0).assertTrue();
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      await releaseImagePacker(imagePackerApi)
      await releaseImageSource(imageSourceApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToData_Func_0040
     * @tc.name   : packToData
     * @tc.desc   : Test Func packToData Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToData_Func_0040', 0, async (done: Function) => {
      let imageSourceApi: image.ImageSource = image.createImageSource(fileFd)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/heif", quality: 99, bufferSize: 5120000 };
      try {
        await imagePackerApi.packToData(imageSourceApi, packOpts).then((data) => {
          expect(data.byteLength > 0).assertTrue();
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(true).assertTrue()
        })
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      await releaseImagePacker(imagePackerApi)
      await releaseImageSource(imageSourceApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToData_Func_0050
     * @tc.name   : packToData
     * @tc.desc   : Test Func packToData Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToData_Func_0050', 0, async (done: Function) => {
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: 5120000 };
      try {
        await imagePackerApi.packToData(undefined, packOpts).then((data) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          expect(JSON.stringify(err)).assertContain("401")
        })
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      await releaseImagePacker(imagePackerApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToData_Func_0060
     * @tc.name   : packToData
     * @tc.desc   : Test Func packToData Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToData_Func_0060', 0, async (done: Function) => {
      let imageSourceApi: image.ImageSource = image.createImageSource(fileFd)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "", quality: 99, bufferSize: 5120000 };
      try {
        await imagePackerApi.packToData(imageSourceApi, packOpts).then((data) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          expect(JSON.stringify(err)).assertContain("401")
        })
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      await releaseImagePacker(imagePackerApi)
      await releaseImageSource(imageSourceApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToData_Func_0070
     * @tc.name   : packToData
     * @tc.desc   : Test Func packToData Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToData_Func_0070', 0, async (done: Function) => {
      let imageSourceApi: image.ImageSource = image.createImageSource(fileFd)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: -1, bufferSize: 5120000 };
      try {
        await imagePackerApi.packToData(imageSourceApi, packOpts).then((data) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          expect(JSON.stringify(err)).assertContain("401")
        })
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      await releaseImagePacker(imagePackerApi)
      await releaseImageSource(imageSourceApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToData_Func_0080
     * @tc.name   : packToData
     * @tc.desc   : Test Func packToData Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToData_Func_0080', 0, async (done: Function) => {
      let imageSourceApi: image.ImageSource = image.createImageSource(fileFd)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: -1 };
      try {
        await imagePackerApi.packToData(imageSourceApi, packOpts).then((data) => {
          expect(data.byteLength > 0).assertTrue();
        }).catch((err: BusinessError) => {
          expect().assertFail()
        })
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      await releaseImagePacker(imagePackerApi)
      await releaseImageSource(imageSourceApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToData_Func_1010
     * @tc.name   : packToData
     * @tc.desc   : Test Func packToData Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToData_Func_1010', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: 5120000 }
      await imagePackerApi.packToData(pixelmap, packOpts).then((data: ArrayBuffer) => {
        expect(data.byteLength > 0).assertTrue();
      }).catch((err: BusinessError) => {
        expect().assertFail()
      })
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToData_Func_1020
     * @tc.name   : packToData
     * @tc.desc   : Test Func packToData Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToData_Func_1020', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/webp", quality: 99, bufferSize: 5120000 }
      await imagePackerApi.packToData(pixelmap, packOpts).then((data: ArrayBuffer) => {
        expect(data.byteLength > 0).assertTrue();
      }).catch((err: BusinessError) => {
        expect().assertFail()
      })
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToData_Func_1030
     * @tc.name   : packToData
     * @tc.desc   : Test Func packToData Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToData_Func_1030', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/png", quality: 99, bufferSize: 5120000 }
      await imagePackerApi.packToData(pixelmap, packOpts).then((data: ArrayBuffer) => {
        expect(data.byteLength > 0).assertTrue();
      }).catch((err: BusinessError) => {
        expect().assertFail()
      })
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToData_Func_1040
     * @tc.name   : packToData
     * @tc.desc   : Test Func packToData Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToData_Func_1040', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/heif", quality: 99, bufferSize: 5120000 }
      await imagePackerApi.packToData(pixelmap, packOpts).then((data: ArrayBuffer) => {
        expect(data.byteLength > 0).assertTrue();
      }).catch((err: BusinessError) => {
        expect(true).assertTrue()
      })
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToData_Func_1050
     * @tc.name   : packToData
     * @tc.desc   : Test Func packToData
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToData_Func_1050', 0, async (done: Function) => {
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: 5120000 }
      await imagePackerApi.packToData(undefined, packOpts).then((data: ArrayBuffer) => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain("401")
      })
      await releaseImagePacker(imagePackerApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToData_Func_1060
     * @tc.name   : packToData
     * @tc.desc   : Test Func packToData Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToData_Func_1060', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "", quality: 99, bufferSize: 5120000 };
      try {
        await imagePackerApi.packToData(pixelmap, packOpts).then((data) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          expect(JSON.stringify(err)).assertContain("401")
        })
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToData_Func_1070
     * @tc.name   : packToData
     * @tc.desc   : Test Func packToData Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToData_Func_1070', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: -1, bufferSize: 5120000 };
      try {
        await imagePackerApi.packToData(pixelmap, packOpts).then((data) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          expect(JSON.stringify(err)).assertContain("401")
        })
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToData_Func_1080
     * @tc.name   : packToData
     * @tc.desc   : Test Func packToData Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToData_Func_1080', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: -1 };
      try {
        await imagePackerApi.packToData(pixelmap, packOpts).then((data) => {
          expect(data.byteLength > 0).assertTrue();
        }).catch((err: BusinessError) => {
          expect().assertFail()
        })
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packing_Func_0010
     * @tc.name   : packing
     * @tc.desc   : Test Func packing Callback
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packing_Func_0010', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: 5120000 }
      await (async (): Promise<ArrayBuffer> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packing(pixelmap, packOpts, (err: BusinessError, data: ArrayBuffer) => {
            err == undefined ? resolve(data) : reject(err)
          })
        });
      })().then(async (data) => {
        expect(data.byteLength > 0).assertTrue();
      }).catch((err: BusinessError) => {
        expect().assertFail()
      });
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packing_Func_0020
     * @tc.name   : packing
     * @tc.desc   : Test Func packing Callback
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packing_Func_0020', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/webp", quality: 99, bufferSize: 5120000 }
      await (async (): Promise<ArrayBuffer> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packing(pixelmap, packOpts, (err: BusinessError, data: ArrayBuffer) => {
            err == undefined ? resolve(data) : reject(err)
          })
        });
      })().then(async (data) => {
        expect(data.byteLength > 0).assertTrue();
      }).catch((err: BusinessError) => {
        expect().assertFail()
      });
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packing_Func_0030
     * @tc.name   : packing
     * @tc.desc   : Test Func packing Callback
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packing_Func_0030', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/png", quality: 99, bufferSize: 5120000 }
      await (async (): Promise<ArrayBuffer> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packing(pixelmap, packOpts, (err: BusinessError, data: ArrayBuffer) => {
            err == undefined ? resolve(data) : reject(err)
          })
        });
      })().then(async (data) => {
        expect(data.byteLength > 0).assertTrue();
      }).catch((err: BusinessError) => {
        expect().assertFail()
      });
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packing_Func_0040
     * @tc.name   : packing
     * @tc.desc   : Test Func packing Callback
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packing_Func_0040', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/heif", quality: 99, bufferSize: 5120000 }
      await (async (): Promise<ArrayBuffer> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packing(pixelmap, packOpts, (err: BusinessError, data: ArrayBuffer) => {
            err == undefined ? resolve(data) : reject(err)
          })
        });
      })().then(async (data) => {
        expect(data.byteLength > 0).assertTrue();
      }).catch((err: BusinessError) => {
        expect(true).assertTrue()
      });
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packing_Func_0050
     * @tc.name   : packing
     * @tc.desc   : Test Func packing Callback
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packing_Func_0050', 0, async (done: Function) => {
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: 5120000 }
      await (async (): Promise<ArrayBuffer> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packing(undefined, packOpts, (err: BusinessError, data: ArrayBuffer) => {
            err == undefined ? resolve(data) : reject(err)
          })
        });
      })().then(async (data) => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain("ImageSource mismatch")
      });
      await releaseImagePacker(imagePackerApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packing_Func_0060
     * @tc.name   : packing
     * @tc.desc   : Test Func packing Callback
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packing_Func_0060', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "", quality: 99, bufferSize: 5120000 }
      await (async (): Promise<ArrayBuffer> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packing(pixelmap, packOpts, (err: BusinessError, data: ArrayBuffer) => {
            err == undefined ? resolve(data) : reject(err)
          })
        });
      })().then(async (data) => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain("Packing start packing failed")
      });
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packing_Func_0070
     * @tc.name   : packing
     * @tc.desc   : Test Func packing Callback
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packing_Func_0070', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: -1, bufferSize: 5120000 }
      await (async (): Promise<ArrayBuffer> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packing(pixelmap, packOpts, (err: BusinessError, data: ArrayBuffer) => {
            err == undefined ? resolve(data) : reject(err)
          })
        });
      })().then(async (data) => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain("Packing start packing failed")
      });
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packing_Func_0080
     * @tc.name   : packing
     * @tc.desc   : Test Func packing Callback
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packing_Func_0080', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: -1 }
      await (async (): Promise<ArrayBuffer> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packing(pixelmap, packOpts, (err: BusinessError, data: ArrayBuffer) => {
            err == undefined ? resolve(data) : reject(err)
          })
        });
      })().then(async (data) => {
        expect(data.byteLength > 0).assertTrue();
      }).catch((err: BusinessError) => {
        expect().assertFail()
      });
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packing_Func_0090
     * @tc.name   : packing
     * @tc.desc   : Test Func packing Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packing_Func_0090', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: 5120000 }
      await imagePackerApi.packing(pixelmap, packOpts).then((data: ArrayBuffer) => {
        expect(data.byteLength > 0).assertTrue();
      }).catch((err: BusinessError) => {
        expect().assertFail()
      })
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packing_Func_0100
     * @tc.name   : packing
     * @tc.desc   : Test Func packing Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packing_Func_0100', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/webp", quality: 99, bufferSize: 5120000 }
      await imagePackerApi.packing(pixelmap, packOpts).then((data: ArrayBuffer) => {
        expect(data.byteLength > 0).assertTrue();
      }).catch((err: BusinessError) => {
        expect().assertFail()
      })
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packing_Func_0110
     * @tc.name   : packing
     * @tc.desc   : Test Func packing Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packing_Func_0110', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/png", quality: 99, bufferSize: 5120000 }
      await imagePackerApi.packing(pixelmap, packOpts).then((data: ArrayBuffer) => {
        expect(data.byteLength > 0).assertTrue();
      }).catch((err: BusinessError) => {
        expect().assertFail()
      })
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packing_Func_0120
     * @tc.name   : packing
     * @tc.desc   : Test Func packing Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packing_Func_0120', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/heif", quality: 99, bufferSize: 5120000 }
      await imagePackerApi.packing(pixelmap, packOpts).then((data: ArrayBuffer) => {
        expect(data.byteLength > 0).assertTrue();
      }).catch((err: BusinessError) => {
        expect(true).assertTrue()
      })
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packing_Func_0130
     * @tc.name   : packing
     * @tc.desc   : Test Func packing Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packing_Func_0130', 0, async (done: Function) => {
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: 5120000 }
      await imagePackerApi.packing(undefined, packOpts).then((data: ArrayBuffer) => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain("ImageSource mismatch")
      })
      await releaseImagePacker(imagePackerApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packing_Func_0140
     * @tc.name   : packing
     * @tc.desc   : Test Func packing Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packing_Func_0140', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "", quality: 99, bufferSize: 5120000 }
      await imagePackerApi.packing(pixelmap, packOpts).then((data: ArrayBuffer) => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain("Packing start packing failed")
      })
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packing_Func_0150
     * @tc.name   : packing
     * @tc.desc   : Test Func packing Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packing_Func_0150', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: -1, bufferSize: 5120000 }
      await imagePackerApi.packing(pixelmap, packOpts).then((data: ArrayBuffer) => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain("Packing start packing failed")
      })
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packing_Func_0160
     * @tc.name   : packing
     * @tc.desc   : Test Func packing Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packing_Func_0160', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: -1 }
      await imagePackerApi.packing(pixelmap, packOpts).then((data: ArrayBuffer) => {
        expect(data.byteLength > 0).assertTrue();
      }).catch((err: BusinessError) => {
        expect().assertFail()
      })
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_0010
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Callback
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_0010', 0, async (done: Function) => {
      let imageSourceApi: image.ImageSource = image.createImageSource(filePath);
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: 5120000 };
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packToFile(imageSourceApi, file.fd, packOpts, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect((await fs.stat(file.fd)).size != 0).assertTrue()
      }).catch((err: BusinessError) => {
        expect().assertFail()
      });
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releaseImageSource(imageSourceApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_0020
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Callback
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_0020', 0, async (done: Function) => {
      let imageSourceApi: image.ImageSource = image.createImageSource(filePath);
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/webp", quality: 99, bufferSize: 5120000 };
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packToFile(imageSourceApi, file.fd, packOpts, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect((await fs.stat(file.fd)).size != 0).assertTrue()
      }).catch((err: BusinessError) => {
        expect().assertFail()
      });
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releaseImageSource(imageSourceApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_0030
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Callback
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_0030', 0, async (done: Function) => {
      let imageSourceApi: image.ImageSource = image.createImageSource(filePath);
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/png", quality: 99, bufferSize: 5120000 };
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packToFile(imageSourceApi, file.fd, packOpts, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect((await fs.stat(file.fd)).size != 0).assertTrue()
      }).catch((err: BusinessError) => {
        expect().assertFail()
      });
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releaseImageSource(imageSourceApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_0040
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Callback
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_0040', 0, async (done: Function) => {
      let imageSourceApi: image.ImageSource = image.createImageSource(filePath);
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/heif", quality: 99, bufferSize: 5120000 };
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packToFile(imageSourceApi, file.fd, packOpts, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect((await fs.stat(file.fd)).size != 0).assertTrue()
      }).catch((err: BusinessError) => {
        expect(true).assertTrue()
      });
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releaseImageSource(imageSourceApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_0050
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Callback
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_0050', 0, async (done: Function) => {
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: 5120000 };
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packToFile(undefined, file.fd, packOpts, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain("ImageSource mismatch")
      });
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_0060
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Callback
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_0060', 0, async (done: Function) => {
      let imageSourceApi: image.ImageSource = image.createImageSource(filePath);
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "", quality: 99, bufferSize: 5120000 };
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packToFile(imageSourceApi, file.fd, packOpts, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain("62980115")
      });
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releaseImageSource(imageSourceApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_0070
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Callback
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_0070', 0, async (done: Function) => {
      let imageSourceApi: image.ImageSource = image.createImageSource(filePath);
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: -1, bufferSize: 5120000 };
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packToFile(imageSourceApi, file.fd, packOpts, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain("62980115")
      });
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releaseImageSource(imageSourceApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_0080
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Callback
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_0080', 0, async (done: Function) => {
      let imageSourceApi: image.ImageSource = image.createImageSource(filePath);
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: -1 };
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packToFile(imageSourceApi, file.fd, packOpts, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect((await fs.stat(file.fd)).size != 0).assertTrue()
      }).catch((err: BusinessError) => {
        expect().assertFail()
      });
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releaseImageSource(imageSourceApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_0090
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_0090', 0, async (done: Function) => {
      let imageSourceApi: image.ImageSource = image.createImageSource(filePath);
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: 5120000 };
      await imagePackerApi.packToFile(imageSourceApi, file.fd, packOpts).then(() => {
      }).catch((err: BusinessError) => {
        expect().assertFail()
      });
      expect((await fs.stat(file.fd)).size != 0).assertTrue()
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releaseImageSource(imageSourceApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_0100
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_0100', 0, async (done: Function) => {
      let imageSourceApi: image.ImageSource = image.createImageSource(filePath);
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/webp", quality: 99, bufferSize: 5120000 };
      await imagePackerApi.packToFile(imageSourceApi, file.fd, packOpts).then(() => {
      }).catch((err: BusinessError) => {
        expect().assertFail()
      });
      expect((await fs.stat(file.fd)).size != 0).assertTrue()
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releaseImageSource(imageSourceApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_0110
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_0110', 0, async (done: Function) => {
      let imageSourceApi: image.ImageSource = image.createImageSource(filePath);
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/png", quality: 99, bufferSize: 5120000 };
      await imagePackerApi.packToFile(imageSourceApi, file.fd, packOpts).then(() => {
      }).catch((err: BusinessError) => {
        expect().assertFail()
      });
      expect((await fs.stat(file.fd)).size != 0).assertTrue()
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releaseImageSource(imageSourceApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_0120
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_0120', 0, async (done: Function) => {
      let imageSourceApi: image.ImageSource = image.createImageSource(filePath);
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/heif", quality: 99, bufferSize: 5120000 };
      let res = true
      await imagePackerApi.packToFile(imageSourceApi, file.fd, packOpts).then(() => {
      }).catch((err: BusinessError) => {
        res = false
        expect(true).assertTrue()
      });
      if (res) {
        expect((await fs.stat(file.fd)).size != 0).assertTrue()
      }
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releaseImageSource(imageSourceApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_0130
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_0130', 0, async (done: Function) => {
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: 5120000 };
      await imagePackerApi.packToFile(undefined, file.fd, packOpts).then(() => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain("ImageSource mismatch")
      });
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_0140
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_0140', 0, async (done: Function) => {
      let imageSourceApi: image.ImageSource = image.createImageSource(filePath);
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "", quality: 99, bufferSize: 5120000 };
      await imagePackerApi.packToFile(imageSourceApi, file.fd, packOpts).then(() => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain("62980115")
      });
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releaseImageSource(imageSourceApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_0150
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_0150', 0, async (done: Function) => {
      let imageSourceApi: image.ImageSource = image.createImageSource(filePath);
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: -1, bufferSize: 5120000 };
      await imagePackerApi.packToFile(imageSourceApi, file.fd, packOpts).then(() => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain("62980115")
      });
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releaseImageSource(imageSourceApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_0160
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_0160', 0, async (done: Function) => {
      let imageSourceApi: image.ImageSource = image.createImageSource(filePath);
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: -1 };
      let res = true
      await imagePackerApi.packToFile(imageSourceApi, file.fd, packOpts).then(() => {
      }).catch((err: BusinessError) => {
        res = false
        expect().assertFail()
      });
      if (res) {
        expect((await fs.stat(file.fd)).size != 0).assertTrue()
      }
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releaseImageSource(imageSourceApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_1010
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Callback
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_1010', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: 5120000 };
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packToFile(pixelmap, file.fd, packOpts, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect((await fs.stat(file.fd)).size != 0).assertTrue()
      }).catch((err: BusinessError) => {
        expect().assertFail()
      });
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_1020
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Callback
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_1020', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/webp", quality: 99, bufferSize: 5120000 };
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packToFile(pixelmap, file.fd, packOpts, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect((await fs.stat(file.fd)).size != 0).assertTrue()
      }).catch((err: BusinessError) => {
        expect().assertFail()
      });
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_1030
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Callback
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_1030', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/png", quality: 99, bufferSize: 5120000 };
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packToFile(pixelmap, file.fd, packOpts, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect((await fs.stat(file.fd)).size != 0).assertTrue()
      }).catch((err: BusinessError) => {
        expect().assertFail()
      });
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_1040
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Callback
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_1040', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/heif", quality: 99, bufferSize: 5120000 };
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packToFile(pixelmap, file.fd, packOpts, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect((await fs.stat(file.fd)).size != 0).assertTrue()
      }).catch((err: BusinessError) => {
        expect(true).assertTrue()
      });
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_1050
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Callback
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_1050', 0, async (done: Function) => {
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: 5120000 };
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packToFile(undefined, file.fd, packOpts, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain("ImageSource mismatch")
      });
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_1060
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Callback
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_1060', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "", quality: 99, bufferSize: 5120000 };
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packToFile(pixelmap, file.fd, packOpts, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain("62980115")
      });
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_1070
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Callback
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_1070', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: -1, bufferSize: 5120000 };
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packToFile(pixelmap, file.fd, packOpts, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain("62980115")
      });
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_1080
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Callback
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_1080', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: -1 };
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          imagePackerApi.packToFile(pixelmap, file.fd, packOpts, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect((await fs.stat(file.fd)).size != 0).assertTrue()
      }).catch((err: BusinessError) => {
        expect().assertFail()
      });
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_1090
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_1090', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: 5120000 };
      await imagePackerApi.packToFile(pixelmap, file.fd, packOpts).then(() => {
      }).catch((err: BusinessError) => {
        expect().assertFail()
      });
      expect((await fs.stat(file.fd)).size != 0).assertTrue()
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_1100
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_1100', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/webp", quality: 99, bufferSize: 5120000 };
      await imagePackerApi.packToFile(pixelmap, file.fd, packOpts).then(() => {
      }).catch((err: BusinessError) => {
        expect().assertFail()
      });
      expect((await fs.stat(file.fd)).size != 0).assertTrue()
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_1110
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_1110', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/png", quality: 99, bufferSize: 5120000 };
      await imagePackerApi.packToFile(pixelmap, file.fd, packOpts).then(() => {
      }).catch((err: BusinessError) => {
        expect().assertFail()
      });
      expect((await fs.stat(file.fd)).size != 0).assertTrue()
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_1120
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_1120', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/heif", quality: 99, bufferSize: 5120000 };
      await imagePackerApi.packToFile(pixelmap, file.fd, packOpts).then(async () => {
        expect((await fs.stat(file.fd)).size != 0).assertTrue()
      }).catch((err: BusinessError) => {
        expect(true).assertTrue()
      });
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_1130
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_1130', 0, async (done: Function) => {
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: 5120000 };
      await imagePackerApi.packToFile(undefined, file.fd, packOpts).then(() => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain("ImageSource mismatch")
      });
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_1140
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_1140', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "", quality: 99, bufferSize: 5120000 };
      await imagePackerApi.packToFile(pixelmap, file.fd, packOpts).then(() => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain("62980115")
      });
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_1150
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_1150', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: -1, bufferSize: 5120000 };
      await imagePackerApi.packToFile(pixelmap, file.fd, packOpts).then(() => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain("62980115")
      });
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImagePacker_packToFile_Func_1160
     * @tc.name   : packToFile
     * @tc.desc   : Test Func packToFile Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImagePacker_packToFile_Func_1160', 0, async (done: Function) => {
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      let imagePackerApi = image.createImagePacker();
      let resFilePath: string = context.filesDir + "/image_source.jpg";
      let file = fs.openSync(resFilePath, fs.OpenMode.CREATE | fs.OpenMode.READ_WRITE);
      let packOpts: image.PackingOption = { format: "image/jpeg", quality: 99, bufferSize: -1 };
      let res = true
      await imagePackerApi.packToFile(pixelmap, file.fd, packOpts).then(() => {
      }).catch((err: BusinessError) => {
        res = false
        expect().assertFail()
      });
      if (res) {
        expect((await fs.stat(file.fd)).size != 0).assertTrue()
      }
      fs.closeSync(file);
      await releaseImagePacker(imagePackerApi)
      await releasePixelmap(pixelmap)
      done()
    })

  })
}