/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License")
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http:www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium'
import { BusinessError } from '@ohos.base'
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry'
import common from '@ohos.app.ability.common'
import image from '@ohos.multimedia.image'

import { prepareImageFileFd } from './Common'
import { testPng, testJpg, testGif, testBmp } from './ImageResource'
import { PropertyBuf } from './ImageResource2'

let abilityDelegatorRegistry: AbilityDelegatorRegistry.AbilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator()
let context: common.Context = abilityDelegatorRegistry.getAppContext().createModuleContext("entry_test")

async function releasePixelmap(pixelmap: image.PixelMap): Promise<void> {
  return new Promise((resolve, reject) => {
    pixelmap.release((err) => {
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

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function ImageSourceTest() {
  describe('ImageSourceTest', () => {
    beforeAll(async () => {
      await sleep(1000)
    })
    afterEach(async () => {
      await sleep(50)
    })
    afterAll(async () => {
      await sleep(2000)
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_getImageInfoSync_Func_0010
     * @tc.name   : getImageInfoSync
     * @tc.desc   : Test Func getImageInfoSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_getImageInfoSync_Func_0010', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      try {
        let imageSourceApi = image.createImageSource(data)
        let imageInfo: image.ImageInfo = imageSourceApi.getImageInfoSync(0)
        if (imageInfo == undefined) {
          console.info('getImageInfoSync failed.')
          expect().assertFail()
        } else {
          expect(imageInfo.size.width >= 0).assertTrue()
          expect(imageInfo.size.height >= 0).assertTrue()
          await releaseImageSource(imageSourceApi)
        }
      } catch (err) {
        console.info('err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_getImageInfoSync_Func_0020
     * @tc.name   : getImageInfoSync
     * @tc.desc   : Test Func getImageInfoSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_getImageInfoSync_Func_0020', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      try {
        let imageSourceApi = image.createImageSource(data)
        let imageInfo: image.ImageInfo = imageSourceApi.getImageInfoSync(0)
        if (imageInfo == undefined) {
          console.info('getImageInfoSync failed.')
          expect().assertFail()
        } else {
          expect(imageInfo.size.width >= 0).assertTrue()
          expect(imageInfo.size.height >= 0).assertTrue()
          await releaseImageSource(imageSourceApi)
        }
      } catch (err) {
        console.info('err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_getImageInfoSync_Func_0030
     * @tc.name   : getImageInfoSync
     * @tc.desc   : Test Func getImageInfoSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_getImageInfoSync_Func_0030', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      try {
        let imageSourceApi = image.createImageSource(data)
        let imageInfo: image.ImageInfo = imageSourceApi.getImageInfoSync(0)
        if (imageInfo == undefined) {
          console.info('getImageInfoSync failed.')
          expect().assertFail()
        } else {
          expect(imageInfo.size.width >= 0).assertTrue()
          expect(imageInfo.size.height >= 0).assertTrue()
          await releaseImageSource(imageSourceApi)
        }
      } catch (err) {
        console.info('err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_getImageInfoSync_Func_0040
     * @tc.name   : getImageInfoSync
     * @tc.desc   : Test Func getImageInfoSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_getImageInfoSync_Func_0040', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      try {
        let imageSourceApi = image.createImageSource(data)
        let imageInfo: image.ImageInfo = imageSourceApi.getImageInfoSync(0)
        if (imageInfo == undefined) {
          console.info('getImageInfoSync failed.')
          expect().assertFail()
        } else {
          expect(imageInfo.size.width >= 0).assertTrue()
          expect(imageInfo.size.height >= 0).assertTrue()
          await releaseImageSource(imageSourceApi)
        }
      } catch (err) {
        console.info('err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_getImageInfoSync_Func_0050
     * @tc.name   : getImageInfoSync
     * @tc.desc   : Test Func getImageInfoSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_getImageInfoSync_Func_0050', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      try {
        let imageSourceApi = image.createImageSource(data)
        let imageInfo: image.ImageInfo = imageSourceApi.getImageInfoSync(1)
        expect(imageInfo).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })
    
    /**
     * @tc.number : SUB_ARKUIX_ImageSource_getImageInfoSync_Func_0060
     * @tc.name   : getImageInfoSync
     * @tc.desc   : Test Func getImageInfoSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_getImageInfoSync_Func_0060', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      try {
        let imageSourceApi = image.createImageSource(data)
        let imageInfo: image.ImageInfo = imageSourceApi.getImageInfoSync(-1)
        expect(imageInfo).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_0010
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_0010', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_0020
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_0020', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: false,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertFalse()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_0030
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_0030', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.RGBA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_0040
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_0040', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.RGB_565,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_0050
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_0050', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 0,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("Create PixelMap error")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_0060
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_0060', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: -1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("Create PixelMap error")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_0070
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_0070', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 0, height: 0 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_0080
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_0080', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: -1, height: -1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain('Create PixelMap error')
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_0090
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_0090', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: -10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("DecodeOptions mismatch")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_0100
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_0100', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 500,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("DecodeOptions mismatch")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_0110
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_0110', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 10000, y: 10000 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("Create PixelMap error")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_0120
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_0120', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 0, height: 0 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_0130
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_0130', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: -1, height: -1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_0140
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_0140', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 1,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("Create PixelMap error")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_0150
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_0150', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: -1,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("Create PixelMap error")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_0160
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_0160', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 0,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_0170
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_0170', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: -1,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_1010
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_1010', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_1020
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_1020', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: false,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertFalse()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_1030
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_1030', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.RGBA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_1040
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_1040', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.RGB_565,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("Create PixelMap error")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_1050
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_1050', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 0,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("Create PixelMap error")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_1060
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_1060', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: -1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("Create PixelMap error")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_1070
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_1070', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 0, height: 0 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_1080
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_1080', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: -1, height: -1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain('Create PixelMap error')
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_1090
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_1090', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: -10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("DecodeOptions mismatch")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_1100
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_1100', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 500,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("DecodeOptions mismatch")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_1110
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_1110', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 10000, y: 10000 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("Create PixelMap error")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_1120
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_1120', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 0, height: 0 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_1130
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_1130', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: -1, height: -1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_1140
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_1140', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 1,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("Create PixelMap error")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_1150
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_1150', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: -1,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("Create PixelMap error")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_1160
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_1160', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 0,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_1170
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_1170', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: -1,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_2010
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_2010', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_2020
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_2020', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: false,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertFalse()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_2030
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_2030', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.RGBA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_2040
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_2040', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.RGB_565,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_2050
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_2050', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 0,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("Create PixelMap error")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_2060
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_2060', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: -1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("Create PixelMap error")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_2070
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_2070', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 0, height: 0 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_2080
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_2080', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: -1, height: -1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain('Create PixelMap error')
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_2090
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_2090', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: -10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("DecodeOptions mismatch")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_2100
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_2100', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 500,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("DecodeOptions mismatch")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_2110
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_2110', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 10000, y: 10000 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("Create PixelMap error")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_2120
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_2120', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 0, height: 0 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_2130
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_2130', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: -1, height: -1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_2140
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_2140', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 1,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("Create PixelMap error")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_2150
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_2150', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: -1,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("Create PixelMap error")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_2160
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_2160', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 0,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_2170
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_2170', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: -1,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_3010
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_3010', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_3020
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_3020', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: false,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertFalse()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_3030
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_3030', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.RGBA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_3040
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_3040', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.RGB_565,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_3050
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_3050', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 0,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("Create PixelMap error")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_3060
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_3060', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: -1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("Create PixelMap error")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_3070
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_3070', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 0, height: 0 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_3080
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_3080', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: -1, height: -1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain('Create PixelMap error')
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_3090
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_3090', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: -10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("DecodeOptions mismatch")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_3100
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_3100', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 500,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("DecodeOptions mismatch")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_3110
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_3110', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 10000, y: 10000 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("Create PixelMap error")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_3120
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_3120', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 0, height: 0 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_3130
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_3130', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: -1, height: -1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_3140
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_3140', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 1,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("Create PixelMap error")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_3150
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_3150', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: -1,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then((pixelMap: image.PixelMap) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("Create PixelMap error")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_3160
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_3160', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 0,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMap_Func_3170
     * @tc.name   : createPixelMap
     * @tc.desc   : Test Func createPixelMap with (options?: DecodingOptions): Promise<PixelMap>
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMap_Func_3170', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: -1,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.createPixelMap(decodingOptions).then(async (pixelMap: image.PixelMap) => {
          expect(pixelMap.isEditable).assertTrue()
          await releasePixelmap(pixelMap)
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0010
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0010', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0020
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0020', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: false,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertFalse()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0030
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0030', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.RGBA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0040
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0040', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.RGB_565,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0050
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0050', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 0,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0060
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0060', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: -1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0070
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0070', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 0, height: 0 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0080
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0080', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: -1, height: -1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0090
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0090', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: -10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0100
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0100', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 500,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0110
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0110', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 10000, y: 10000 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0120
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0120', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 0, height: 0 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0130
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0130', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: -1, height: -1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0140
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0140', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 1,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0150
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0150', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: -1,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0160
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0160', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 0,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0170
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_0170', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: -1,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1010
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1010', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1020
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1020', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: false,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertFalse()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1030
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1030', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.RGBA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1040
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1040', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.RGB_565,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1050
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1050', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 0,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1060
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1060', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: -1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1070
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1070', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 0, height: 0 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1080
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1080', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: -1, height: -1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1090
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1090', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: -10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1100
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1100', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 500,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1110
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1110', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 10000, y: 10000 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1120
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1120', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 0, height: 0 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1130
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1130', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: -1, height: -1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1140
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1140', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 1,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1150
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1150', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: -1,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1160
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1160', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 0,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1170
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_1170', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: -1,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2010
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2010', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2020
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2020', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: false,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertFalse()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2030
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2030', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.RGBA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2040
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2040', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.RGB_565,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2050
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2050', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 0,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2060
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2060', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: -1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2070
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2070', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 0, height: 0 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2080
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2080', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: -1, height: -1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2090
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2090', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: -10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2100
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2100', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 500,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2110
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2110', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 10000, y: 10000 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2120
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2120', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 0, height: 0 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2130
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2130', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: -1, height: -1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2140
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2140', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 1,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2150
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2150', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: -1,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2160
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2160', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 0,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2170
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_2170', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: -1,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3010
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3010', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3020
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3020', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: false,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertFalse()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3030
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3030', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.RGBA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3040
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3040', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.RGB_565,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3050
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3050', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 0,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3060
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3060', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: -1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3070
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3070', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 0, height: 0 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3080
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3080', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: -1, height: -1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3090
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3090', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: -10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3100
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3100', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 500,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3110
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3110', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 10000, y: 10000 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3120
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3120', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 0, height: 0 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3130
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3130', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: -1, height: -1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3140
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3140', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 1,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3150
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3150', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: -1,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 240,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap).assertUndefined()
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3160
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3160', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: 0,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3170
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_createPixelMapSync_Func_3170', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      let desiredSize: image.Size = { width: 1, height: 1 }
      let desiredRegion: image.Region = { size: { width: 1, height: 1 }, x: 0, y: 0 }
      let decodingOptions: image.DecodingOptions = {
        index: 0,
        sampleSize: 1,
        rotate: 10,
        editable: true,
        desiredSize: desiredSize,
        desiredRegion: desiredRegion,
        desiredPixelFormat: image.PixelMapFormat.BGRA_8888,
        fitDensity: -1,
      }
      try {
        let imageSourceApi = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_getDisposalTypeList_Func_0010
     * @tc.name   : getDisposalTypeList
     * @tc.desc   : Test Func getDisposalTypeList
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_getDisposalTypeList_Func_0010', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.getDisposalTypeList().then((disposalTypes: Array<number>) => {
          expect(disposalTypes.length >= 0).assertTrue()
        }).catch((err: BusinessError) => {
          console.info(`Failed to get disposalTypes object.code ${err.code},message is ${err.message}`)
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_getDisposalTypeList_Func_0020
     * @tc.name   : getDisposalTypeList
     * @tc.desc   : Test Func getDisposalTypeList
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_getDisposalTypeList_Func_0020', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      try {
        let imageSourceApi = image.createImageSource(data)
        await imageSourceApi.getDisposalTypeList().then((disposalTypes: Array<number>) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info(`Failed to get disposalTypes object.code ${err.code},message is ${err.message}`)
          expect(JSON.stringify(err)).assertContain("62980149")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_getImageProperties_Func_0010
     * @tc.name   : getImageProperties
     * @tc.desc   : Test Func getImageProperties
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_getImageProperties_Func_0010', 0, async (done: Function) => {
      let filePath: string = context.cacheDir + '/' + 'test.jpg'
      let key: Array<image.PropertyKey> = [ image.PropertyKey.DATE_TIME_ORIGINAL ]
      try {
        let fileFd: number | null = await prepareImageFileFd(filePath, PropertyBuf)
        let imageSourceApi: image.ImageSource = image.createImageSource(fileFd)
        await imageSourceApi.getImageProperties(key).then((data) => {
          expect(JSON.stringify(data)).assertContain("2022:06:02 15:51:35")
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_getImageProperties_Func_0020
     * @tc.name   : getImageProperties
     * @tc.desc   : Test Func getImageProperties
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_getImageProperties_Func_0020', 0, async (done: Function) => {
      let filePath: string = context.cacheDir + '/' + 'test.jpg'
      let key: Array<image.PropertyKey> = []
      try {
        let fileFd: number | null = await prepareImageFileFd(filePath, PropertyBuf)
        let imageSourceApi: image.ImageSource = image.createImageSource(fileFd)
        await imageSourceApi.getImageProperties(key).then((data) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect(JSON.stringify(err)).assertContain("401")
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_getImageProperties_Func_0030
     * @tc.name   : getImageProperties
     * @tc.desc   : Test Func getImageProperties
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_getImageProperties_Func_0030', 0, async (done: Function) => {
      let filePath: string = context.cacheDir + '/' + 'test.jpg'
      let key: Array<image.PropertyKey> = [ image.PropertyKey.DATE_TIME_ORIGINAL ]
      try {
        let fileFd: number | null = await prepareImageFileFd(filePath, testJpg)
        let imageSourceApi: image.ImageSource = image.createImageSource(fileFd)
        await imageSourceApi.getImageProperties(key).then((data) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("62980096")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_modifyImageProperties_Func_0010
     * @tc.name   : modifyImageProperties
     * @tc.desc   : Test Func modifyImageProperties
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_modifyImageProperties_Func_0010', 0, async (done: Function) => {
      let filePath: string = context.cacheDir + '/' + 'test.jpg'
      let key: Record<PropertyKey, string | null> = {
        'ImageWidth': "1024"
      }
      let checkKey = [image.PropertyKey.IMAGE_WIDTH]
      try {
        let fileFd: number | null = await prepareImageFileFd(filePath, PropertyBuf)
        let imageSourceApi: image.ImageSource = image.createImageSource(fileFd)
        await imageSourceApi.modifyImageProperties(key).then(async () => {
          await imageSourceApi.getImageProperties(checkKey).then(async (data) => {
            expect(JSON.stringify(data)).assertContain("ImageWidth\":\"1024\"")
          }).catch((err: BusinessError) => {
            console.info('getImageProperties err is ' + JSON.stringify(err))
            expect().assertFail()
          })
        }).catch((err: BusinessError) => {
          console.info('modifyImageProperty err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_modifyImageProperties_Func_0020
     * @tc.name   : modifyImageProperties
     * @tc.desc   : Test Func modifyImageProperties
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_modifyImageProperties_Func_0020', 0, async (done: Function) => {
      let filePath: string = context.cacheDir + '/' + 'test.jpg'
      let key: Record<PropertyKey, string | null> = {
        'ImageWidth': "1024"
      }
      try {
        let fileFd: number | null = await prepareImageFileFd(filePath, testBmp)
        let imageSourceApi: image.ImageSource = image.createImageSource(fileFd)
        await imageSourceApi.modifyImageProperties(key).then(async () => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("62980096")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_modifyImageProperties_Func_0030
     * @tc.name   : modifyImageProperties
     * @tc.desc   : Test Func modifyImageProperties
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_modifyImageProperties_Func_0030', 0, async (done: Function) => {
      let filePath: string = context.cacheDir + '/' + 'test.jpg'
      try {
        let fileFd: number | null = await prepareImageFileFd(filePath, PropertyBuf)
        let imageSourceApi: image.ImageSource = image.createImageSource(fileFd)
        imageSourceApi.modifyImageProperties(undefined).then(async () => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('modifyImageProperty err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect(JSON.stringify(err)).assertContain("401")
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_getImageProperty_Func_0010
     * @tc.name   : getImageProperty
     * @tc.desc   : Test Func getImageProperty
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_getImageProperty_Func_0010', 0, async (done: Function) => {
      let filePath: string = context.cacheDir + '/' + 'test.jpg'
      let key: image.PropertyKey = image.PropertyKey.DATE_TIME_ORIGINAL
      let options: image.ImagePropertyOptions = { index: 0, defaultValue: '2024' }
      try {
        let fileFd: number | null = await prepareImageFileFd(filePath, PropertyBuf)
        let imageSourceApi: image.ImageSource = image.createImageSource(fileFd)
        await imageSourceApi.getImageProperty(key, options).then((data) => {
          expect(JSON.stringify(data)).assertContain("2022:06:02 15:51:35")
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_getImageProperty_Func_0020
     * @tc.name   : getImageProperty
     * @tc.desc   : Test Func getImageProperty
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_getImageProperty_Func_0020', 0, async (done: Function) => {
      let filePath: string = context.cacheDir + '/' + 'test.jpg'
      let options: image.ImagePropertyOptions = { index: 0, defaultValue: '2024' }
      try {
        let fileFd: number | null = await prepareImageFileFd(filePath, PropertyBuf)
        let imageSourceApi: image.ImageSource = image.createImageSource(fileFd)
        await imageSourceApi.getImageProperty(undefined, options).then((data) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        expect(JSON.stringify(err)).assertContain("401")
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_getImageProperty_Func_0030
     * @tc.name   : getImageProperty
     * @tc.desc   : Test Func getImageProperty
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_getImageProperty_Func_0030', 0, async (done: Function) => {
      let filePath: string = context.cacheDir + '/' + 'test.jpg'
      let key: image.PropertyKey = image.PropertyKey.DATE_TIME_ORIGINAL
      let options: image.ImagePropertyOptions = { index: -1, defaultValue: '2024' }
      try {
        let fileFd: number | null = await prepareImageFileFd(filePath, PropertyBuf)
        let imageSourceApi: image.ImageSource = image.createImageSource(fileFd)
        await imageSourceApi.getImageProperty(key, options).then((data) => {
          expect(JSON.stringify(data)).assertContain("2022:06:02 15:51:35")
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_getImageProperty_Func_0040
     * @tc.name   : getImageProperty
     * @tc.desc   : Test Func getImageProperty
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_getImageProperty_Func_0040', 0, async (done: Function) => {
      let filePath: string = context.cacheDir + '/' + 'test.jpg'
      let key: image.PropertyKey = image.PropertyKey.DATE_TIME_ORIGINAL
      let options: image.ImagePropertyOptions = { index: undefined, defaultValue: '2024' }
      try {
        let fileFd: number | null = await prepareImageFileFd(filePath, PropertyBuf)
        let imageSourceApi: image.ImageSource = image.createImageSource(fileFd)
        await imageSourceApi.getImageProperty(key, options).then((data) => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        expect(JSON.stringify(err)).assertContain("401")
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_getImageProperty_Func_0050
     * @tc.name   : getImageProperty
     * @tc.desc   : Test Func getImageProperty
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_getImageProperty_Func_0050', 0, async (done: Function) => {
      let filePath: string = context.cacheDir + '/' + 'test.jpg'
      let key: image.PropertyKey = image.PropertyKey.DATE_TIME_ORIGINAL
      let options: image.ImagePropertyOptions = { index: 0, defaultValue: '' }
      try {
        let fileFd: number | null = await prepareImageFileFd(filePath, PropertyBuf)
        let imageSourceApi: image.ImageSource = image.createImageSource(fileFd)
        await imageSourceApi.getImageProperty(key, options).then((data) => {
          expect(JSON.stringify(data)).assertContain("2022:06:02 15:51:35")
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_getImageProperty_Func_0060
     * @tc.name   : getImageProperty
     * @tc.desc   : Test Func getImageProperty
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_getImageProperty_Func_0060', 0, async (done: Function) => {
      let filePath: string = context.cacheDir + '/' + 'test.jpg'
      let key: image.PropertyKey = image.PropertyKey.DATE_TIME_ORIGINAL
      let options: image.ImagePropertyOptions = { index: 0, defaultValue: undefined }
      try {
        let fileFd: number | null = await prepareImageFileFd(filePath, PropertyBuf)
        let imageSourceApi: image.ImageSource = image.createImageSource(fileFd)
        await imageSourceApi.getImageProperty(key, options).then((data) => {
          expect(JSON.stringify(data)).assertContain("2022:06:02 15:51:35")
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_modifyImageProperty_Func_0010
     * @tc.name   : modifyImageProperty
     * @tc.desc   : Test Func modifyImageProperty
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_ImageSource_modifyImageProperty_Func_0010', 0, async (done: Function) => {
      let filePath: string = context.cacheDir + '/' + 'test.jpg'
      let checkKey = [image.PropertyKey.IMAGE_WIDTH]
      try {
        let fileFd: number | null = await prepareImageFileFd(filePath, PropertyBuf)
        let imageSourceApi: image.ImageSource = image.createImageSource(fileFd)
        await imageSourceApi.modifyImageProperty(image.PropertyKey.IMAGE_WIDTH, "1024").then(async () => {
          await imageSourceApi.getImageProperties(checkKey).then(async (data) => {
            expect(JSON.stringify(data)).assertContain("ImageWidth\":\"1024\"")
          }).catch((err: BusinessError) => {
            console.info('getImageProperties err is ' + JSON.stringify(err))
            expect().assertFail()
          })
        }).catch((err: BusinessError) => {
          console.info('modifyImageProperty err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_modifyImageProperty_Func_0020
     * @tc.name   : modifyImageProperty
     * @tc.desc   : Test Func modifyImageProperty
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_modifyImageProperty_Func_0020', 0, async (done: Function) => {
      let filePath: string = context.cacheDir + '/' + 'test.jpg'
      try {
        let fileFd: number | null = await prepareImageFileFd(filePath, PropertyBuf)
        let imageSourceApi: image.ImageSource = image.createImageSource(fileFd)
        await imageSourceApi.modifyImageProperty(undefined, "1024").then(async () => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('modifyImageProperty err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect(JSON.stringify(err)).assertContain("401")
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_modifyImageProperty_Func_0030
     * @tc.name   : modifyImageProperty
     * @tc.desc   : Test Func modifyImageProperty
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_modifyImageProperty_Func_0030', 0, async (done: Function) => {
      let filePath: string = context.cacheDir + '/' + 'test.jpg'
      try {
        let fileFd: number | null = await prepareImageFileFd(filePath, PropertyBuf)
        let imageSourceApi: image.ImageSource = image.createImageSource(fileFd)
        await imageSourceApi.modifyImageProperty(image.PropertyKey.IMAGE_WIDTH, "").then(async () => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          expect(JSON.stringify(err)).assertContain("62980135")
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_ImageSource_modifyImageProperty_Func_0040
     * @tc.name   : modifyImageProperty
     * @tc.desc   : Test Func modifyImageProperty
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_ImageSource_modifyImageProperty_Func_0040', 0, async (done: Function) => {
      let filePath: string = context.cacheDir + '/' + 'test.jpg'
      try {
        let fileFd: number | null = await prepareImageFileFd(filePath, PropertyBuf)
        let imageSourceApi: image.ImageSource = image.createImageSource(fileFd)
        await imageSourceApi.modifyImageProperty(image.PropertyKey.IMAGE_WIDTH, undefined).then(async () => {
          expect().assertFail()
        }).catch((err: BusinessError) => {
          console.info('modifyImageProperty err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releaseImageSource(imageSourceApi)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect(JSON.stringify(err)).assertContain("401")
      }
      done()
    })

  })
}