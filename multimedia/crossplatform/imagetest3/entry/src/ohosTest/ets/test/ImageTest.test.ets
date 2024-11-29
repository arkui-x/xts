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
import image from '@ohos.multimedia.image';

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

export default function ImageTest() {
  describe('ImageTest', () => {
    beforeAll(async () => {
      await sleep(1000);
    })
    afterEach(async () => {
      await sleep(50);
    })
    afterAll(async () => {
      await sleep(2000);
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_0010
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.editable
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_0010', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: false,
        pixelFormat: image.PixelMapFormat.BGRA_8888,
        size: size,
        scaleMode: image.ScaleMode.FIT_TARGET_SIZE,
        alphaType: image.AlphaType.UNKNOWN,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertFalse()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_0020
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.editable
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_0020', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.BGRA_8888,
        size: size,
        scaleMode: image.ScaleMode.FIT_TARGET_SIZE,
        alphaType: image.AlphaType.UNKNOWN,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_0030
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and color
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_0030', 0, async (done: Function) => {
      let color = new ArrayBuffer(0)
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.BGRA_8888,
        size: size,
        scaleMode: image.ScaleMode.FIT_TARGET_SIZE,
        alphaType: image.AlphaType.UNKNOWN,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_0040
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.alphaType
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_0040', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.BGRA_8888,
        size: size,
        scaleMode: image.ScaleMode.FIT_TARGET_SIZE,
        alphaType: image.AlphaType.OPAQUE,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_0050
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.alphaType
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_0050', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.BGRA_8888,
        size: size,
        scaleMode: image.ScaleMode.FIT_TARGET_SIZE,
        alphaType: image.AlphaType.PREMUL,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_0060
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.alphaType
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_0060', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.BGRA_8888,
        size: size,
        scaleMode: image.ScaleMode.FIT_TARGET_SIZE,
        alphaType: image.AlphaType.UNPREMUL,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_0070
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.scaleMode
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_0070', 0, async (done: Function) => {
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
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_0080
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.pixelFormat
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_0080', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.UNKNOWN,
        size: size,
        scaleMode: image.ScaleMode.CENTER_CROP,
        alphaType: image.AlphaType.UNPREMUL,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_0090
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.pixelFormat
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_0090', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGB_565,
        size: size,
        scaleMode: image.ScaleMode.CENTER_CROP,
        alphaType: image.AlphaType.UNPREMUL,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_0100
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.pixelFormat
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_0100', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
        scaleMode: image.ScaleMode.CENTER_CROP,
        alphaType: image.AlphaType.UNPREMUL,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_0110
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.pixelFormat
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_0110', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGB_888,
        size: size,
        scaleMode: image.ScaleMode.CENTER_CROP,
        alphaType: image.AlphaType.UNPREMUL,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_0120
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.pixelFormat
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_0120', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.ALPHA_8,
        size: size,
        scaleMode: image.ScaleMode.CENTER_CROP,
        alphaType: image.AlphaType.UNPREMUL,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_0130
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.pixelFormat
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_0130', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_F16,
        size: size,
        scaleMode: image.ScaleMode.CENTER_CROP,
        alphaType: image.AlphaType.UNPREMUL,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_0140
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.pixelFormat
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_0140', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.NV21,
        size: size,
        scaleMode: image.ScaleMode.CENTER_CROP,
        alphaType: image.AlphaType.UNPREMUL,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_0150
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.pixelFormat
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_0150', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.NV12,
        size: size,
        scaleMode: image.ScaleMode.CENTER_CROP,
        alphaType: image.AlphaType.UNPREMUL,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_0160
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.size
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_0160', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = {
        width: 0, height: 0
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.BGRA_8888,
        size: size,
        scaleMode: image.ScaleMode.CENTER_CROP,
        alphaType: image.AlphaType.UNPREMUL,
      }
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      expect(pixelmap).assertUndefined()
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_0170
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.size
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_0170', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = {
        width: -1, height: -1
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.BGRA_8888,
        size: size,
        scaleMode: image.ScaleMode.CENTER_CROP,
        alphaType: image.AlphaType.UNPREMUL,
      }
      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      expect(pixelmap).assertUndefined()
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_0180
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and color
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_0180', 0, async (done: Function) => {
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.BGRA_8888,
        size: size,
        scaleMode: image.ScaleMode.FIT_TARGET_SIZE,
        alphaType: image.AlphaType.UNKNOWN,
      }
      try {
        let pixelmap = image.createPixelMapSync(undefined, initializationOptions)
        expect(pixelmap).assertUndefined()
      } catch (err) {
        expect(true).assertTrue()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_1010
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.editable
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_1010', 0, async (done: Function) => {
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: false,
        pixelFormat: image.PixelMapFormat.BGRA_8888,
        size: size,
        scaleMode: image.ScaleMode.FIT_TARGET_SIZE,
        alphaType: image.AlphaType.UNKNOWN,
      }
      try {
        let pixelmap = image.createPixelMapSync(initializationOptions)
        expect(pixelmap.isEditable).assertFalse()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_1020
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.editable
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_1020', 0, async (done: Function) => {
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.BGRA_8888,
        size: size,
        scaleMode: image.ScaleMode.FIT_TARGET_SIZE,
        alphaType: image.AlphaType.UNKNOWN,
      }
      try {
        let pixelmap = image.createPixelMapSync(initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_1030
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.alphaType
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_1030', 0, async (done: Function) => {
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.BGRA_8888,
        size: size,
        scaleMode: image.ScaleMode.FIT_TARGET_SIZE,
        alphaType: image.AlphaType.OPAQUE,
      }
      try {
        let pixelmap = image.createPixelMapSync(initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_1040
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.alphaType
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_1040', 0, async (done: Function) => {
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.BGRA_8888,
        size: size,
        scaleMode: image.ScaleMode.FIT_TARGET_SIZE,
        alphaType: image.AlphaType.PREMUL,
      }
      try {
        let pixelmap = image.createPixelMapSync(initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_1050
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.alphaType
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_1050', 0, async (done: Function) => {
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.BGRA_8888,
        size: size,
        scaleMode: image.ScaleMode.FIT_TARGET_SIZE,
        alphaType: image.AlphaType.UNPREMUL,
      }
      try {
        let pixelmap = image.createPixelMapSync(initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_1060
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.scaleMode
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_1060', 0, async (done: Function) => {
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
      try {
        let pixelmap = image.createPixelMapSync(initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_1070
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.pixelFormat
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_1070', 0, async (done: Function) => {
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.UNKNOWN,
        size: size,
        scaleMode: image.ScaleMode.CENTER_CROP,
        alphaType: image.AlphaType.UNPREMUL,
      }
      try {
        let pixelmap = image.createPixelMapSync(initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_1080
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.pixelFormat
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_1080', 0, async (done: Function) => {
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGB_565,
        size: size,
        scaleMode: image.ScaleMode.CENTER_CROP,
        alphaType: image.AlphaType.UNPREMUL,
      }
      try {
        let pixelmap = image.createPixelMapSync(initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_1090
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.pixelFormat
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_1090', 0, async (done: Function) => {
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
        scaleMode: image.ScaleMode.CENTER_CROP,
        alphaType: image.AlphaType.UNPREMUL,
      }
      try {
        let pixelmap = image.createPixelMapSync(initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_1100
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.pixelFormat
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_1100', 0, async (done: Function) => {
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGB_888,
        size: size,
        scaleMode: image.ScaleMode.CENTER_CROP,
        alphaType: image.AlphaType.UNPREMUL,
      }
      try {
        let pixelmap = image.createPixelMapSync(initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_1110
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.pixelFormat
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_1110', 0, async (done: Function) => {
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.ALPHA_8,
        size: size,
        scaleMode: image.ScaleMode.CENTER_CROP,
        alphaType: image.AlphaType.UNPREMUL,
      }
      try {
        let pixelmap = image.createPixelMapSync(initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_1120
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.pixelFormat
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_1120', 0, async (done: Function) => {
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
      try {
        let pixelmap = image.createPixelMapSync(initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_1130
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.pixelFormat
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_1130', 0, async (done: Function) => {
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_F16,
        size: size,
        scaleMode: image.ScaleMode.CENTER_CROP,
        alphaType: image.AlphaType.UNPREMUL,
      }
      try {
        let pixelmap = image.createPixelMapSync(initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_1140
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.pixelFormat
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_1140', 0, async (done: Function) => {
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.NV21,
        size: size,
        scaleMode: image.ScaleMode.CENTER_CROP,
        alphaType: image.AlphaType.UNPREMUL,
      }
      try {
        let pixelmap = image.createPixelMapSync(initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_1150
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.pixelFormat
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_1150', 0, async (done: Function) => {
      let size: image.Size = {
        width: 4, height: 6
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.NV12,
        size: size,
        scaleMode: image.ScaleMode.CENTER_CROP,
        alphaType: image.AlphaType.UNPREMUL,
      }
      try {
        let pixelmap = image.createPixelMapSync(initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_1160
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.size
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_1160', 0, async (done: Function) => {
      let size: image.Size = {
        width: 0, height: 0
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
        scaleMode: image.ScaleMode.CENTER_CROP,
        alphaType: image.AlphaType.UNPREMUL,
      }
      let pixelmap = image.createPixelMapSync(initializationOptions)
      expect(pixelmap).assertUndefined()
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPixelMapSync_Func_1170
     * @tc.name   : createPixelMapSync
     * @tc.desc   : Test Func createPixelMapSync and InitializationOptions.size
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createPixelMapSync_Func_1170', 0, async (done: Function) => {
      let size: image.Size = {
        width: -1, height: -1
      }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
        scaleMode: image.ScaleMode.CENTER_CROP,
        alphaType: image.AlphaType.UNPREMUL,
      }
      let pixelmap = image.createPixelMapSync(initializationOptions)
      expect(pixelmap).assertUndefined()
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_0010
     * @tc.name   : createPremultipliedPixelMap
     * @tc.desc   : Test Func createPremultipliedPixelMap AsyncCallback
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_0010', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNPREMUL,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          image.createPremultipliedPixelMap(srcPixelmap, dstPixelMap, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        let dstPixelMap_imageInfo: image.ImageInfo = dstPixelMap.getImageInfoSync()
        expect(dstPixelMap_imageInfo.alphaType == image.AlphaType.PREMUL).assertTrue()
      }).catch((err: BusinessError) => {
        expect().assertFail()
      });
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_0020
     * @tc.name   : createPremultipliedPixelMap
     * @tc.desc   : Test Func createPremultipliedPixelMap AsyncCallback
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_0020', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          image.createPremultipliedPixelMap(srcPixelmap, dstPixelMap, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain('401')
      });
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_0030
     * @tc.name   : createPremultipliedPixelMap
     * @tc.desc   : Test Func createPremultipliedPixelMap AsyncCallback
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_0030', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.OPAQUE,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          image.createPremultipliedPixelMap(srcPixelmap, dstPixelMap, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain('401')
      });
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_0040
     * @tc.name   : createPremultipliedPixelMap
     * @tc.desc   : Test Func createPremultipliedPixelMap AsyncCallback
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_0040', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.PREMUL,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          image.createPremultipliedPixelMap(srcPixelmap, dstPixelMap, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain('401')
      });
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_0050
     * @tc.name   : createPremultipliedPixelMap
     * @tc.desc   : Test Func createPremultipliedPixelMap AsyncCallback
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_0050', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNPREMUL,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: false,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          image.createPremultipliedPixelMap(srcPixelmap, dstPixelMap, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain('62980248')
      });
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_0060
     * @tc.name   : createPremultipliedPixelMap
     * @tc.desc   : Test Func createPremultipliedPixelMap AsyncCallback
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_0060', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: false,
        size: size,
        alphaType: image.AlphaType.UNPREMUL,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          image.createPremultipliedPixelMap(srcPixelmap, dstPixelMap, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        let dstPixelMap_imageInfo: image.ImageInfo = dstPixelMap.getImageInfoSync()
        expect(dstPixelMap_imageInfo.alphaType == image.AlphaType.PREMUL).assertTrue()
      }).catch((err: BusinessError) => {
        expect().assertFail()
      });
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_1010
     * @tc.name   : createPremultipliedPixelMap
     * @tc.desc   : Test Func createPremultipliedPixelMap Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_1010', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNPREMUL,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await image.createPremultipliedPixelMap(srcPixelmap, dstPixelMap).then(() => {
        let dstPixelMap_imageInfo: image.ImageInfo = dstPixelMap.getImageInfoSync()
        expect(dstPixelMap_imageInfo.alphaType == image.AlphaType.PREMUL).assertTrue()
      }).catch((err: BusinessError) => {
        console.info('err is ' + JSON.stringify(err))
        expect().assertFail()
      })
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_1020
     * @tc.name   : createPremultipliedPixelMap
     * @tc.desc   : Test Func createPremultipliedPixelMap Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_1020', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await image.createPremultipliedPixelMap(srcPixelmap, dstPixelMap).then(() => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        console.info('err is ' + JSON.stringify(err))
        expect(JSON.stringify(err)).assertContain('401')
      })
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_1030
     * @tc.name   : createPremultipliedPixelMap
     * @tc.desc   : Test Func createPremultipliedPixelMap Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_1030', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.OPAQUE,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await image.createPremultipliedPixelMap(srcPixelmap, dstPixelMap).then(() => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        console.info('err is ' + JSON.stringify(err))
        expect(JSON.stringify(err)).assertContain('401')
      })
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_1040
     * @tc.name   : createPremultipliedPixelMap
     * @tc.desc   : Test Func createPremultipliedPixelMap Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_1040', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.PREMUL,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await image.createPremultipliedPixelMap(srcPixelmap, dstPixelMap).then(() => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        console.info('err is ' + JSON.stringify(err))
        expect(JSON.stringify(err)).assertContain('401')
      })
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_1050
     * @tc.name   : createPremultipliedPixelMap
     * @tc.desc   : Test Func createPremultipliedPixelMap Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_1050', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNPREMUL,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: false,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await image.createPremultipliedPixelMap(srcPixelmap, dstPixelMap).then(() => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        console.info('err is ' + JSON.stringify(err))
        expect(JSON.stringify(err)).assertContain('62980248')
      })
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_1060
     * @tc.name   : createPremultipliedPixelMap
     * @tc.desc   : Test Func createPremultipliedPixelMap Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createPremultipliedPixelMap_Func_1060', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: false,
        size: size,
        alphaType: image.AlphaType.UNPREMUL,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await image.createPremultipliedPixelMap(srcPixelmap, dstPixelMap).then(() => {
        let dstPixelMap_imageInfo: image.ImageInfo = dstPixelMap.getImageInfoSync()
        expect(dstPixelMap_imageInfo.alphaType == image.AlphaType.PREMUL).assertTrue()
      }).catch((err: BusinessError) => {
        console.info('err is ' + JSON.stringify(err))
        expect().assertFail()
      })
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_0010
     * @tc.name   : createUnpremultipliedPixelMaps
     * @tc.desc   : Test Func createUnpremultipliedPixelMap AsyncCallback
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_0010', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.PREMUL,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          image.createUnpremultipliedPixelMap(srcPixelmap, dstPixelMap, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        let dstPixelMap_imageInfo: image.ImageInfo = dstPixelMap.getImageInfoSync()
        expect(dstPixelMap_imageInfo.alphaType == image.AlphaType.UNPREMUL).assertTrue()
      }).catch((err: BusinessError) => {
        expect().assertFail()
      });
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_0020
     * @tc.name   : createUnpremultipliedPixelMaps
     * @tc.desc   : Test Func createUnpremultipliedPixelMap AsyncCallback
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_0020', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          image.createUnpremultipliedPixelMap(srcPixelmap, dstPixelMap, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        let dstPixelMap_imageInfo: image.ImageInfo = dstPixelMap.getImageInfoSync()
        expect(dstPixelMap_imageInfo.alphaType == image.AlphaType.UNPREMUL).assertTrue()
      }).catch((err: BusinessError) => {
        expect().assertFail()
      });
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_0030
     * @tc.name   : createUnpremultipliedPixelMap
     * @tc.desc   : Test Func createUnpremultipliedPixelMap AsyncCallback
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_0030', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.OPAQUE,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          image.createUnpremultipliedPixelMap(srcPixelmap, dstPixelMap, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain('401')
      });
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_0040
     * @tc.name   : createUnpremultipliedPixelMap
     * @tc.desc   : Test Func createUnpremultipliedPixelMap AsyncCallback
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_0040', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNPREMUL,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          image.createUnpremultipliedPixelMap(srcPixelmap, dstPixelMap, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain('401')
      });
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_0050
     * @tc.name   : createUnpremultipliedPixelMap
     * @tc.desc   : Test Func createUnpremultipliedPixelMap AsyncCallback
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_0050', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: false,
        size: size,
        alphaType: image.AlphaType.PREMUL,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          image.createUnpremultipliedPixelMap(srcPixelmap, dstPixelMap, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        let dstPixelMap_imageInfo: image.ImageInfo = dstPixelMap.getImageInfoSync()
        expect(dstPixelMap_imageInfo.alphaType == image.AlphaType.UNPREMUL).assertTrue()
      }).catch((err: BusinessError) => {
        expect().assertFail()
      });
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_0060
     * @tc.name   : createUnpremultipliedPixelMap
     * @tc.desc   : Test Func createUnpremultipliedPixelMap AsyncCallback
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_0060', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.PREMUL,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: false,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          image.createUnpremultipliedPixelMap(srcPixelmap, dstPixelMap, (err: BusinessError) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain('62980248')
      });
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_1010
     * @tc.name   : createUnpremultipliedPixelMaps
     * @tc.desc   : Test Func createUnpremultipliedPixelMap Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_1010', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.PREMUL,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await image.createUnpremultipliedPixelMap(srcPixelmap, dstPixelMap).then(() => {
        let dstPixelMap_imageInfo: image.ImageInfo = dstPixelMap.getImageInfoSync()
        expect(dstPixelMap_imageInfo.alphaType == image.AlphaType.UNPREMUL).assertTrue()
      }).catch((err: BusinessError) => {
        console.info('err is ' + JSON.stringify(err))
        expect().assertFail()
      })
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_1020
     * @tc.name   : createUnpremultipliedPixelMaps
     * @tc.desc   : Test Func createUnpremultipliedPixelMap Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_1020', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await image.createUnpremultipliedPixelMap(srcPixelmap, dstPixelMap).then(() => {
        let dstPixelMap_imageInfo: image.ImageInfo = dstPixelMap.getImageInfoSync()
        expect(dstPixelMap_imageInfo.alphaType == image.AlphaType.UNPREMUL).assertTrue()
      }).catch((err: BusinessError) => {
        console.info('err is ' + JSON.stringify(err))
        expect().assertFail()
      })
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_1030
     * @tc.name   : createUnpremultipliedPixelMap
     * @tc.desc   : Test Func createUnpremultipliedPixelMap Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_1030', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.OPAQUE,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await image.createUnpremultipliedPixelMap(srcPixelmap, dstPixelMap).then(() => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        console.info('err is ' + JSON.stringify(err))
        expect(JSON.stringify(err)).assertContain('401')
      })
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_1040
     * @tc.name   : createUnpremultipliedPixelMap
     * @tc.desc   : Test Func createUnpremultipliedPixelMap Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_1040', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNPREMUL,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await image.createUnpremultipliedPixelMap(srcPixelmap, dstPixelMap).then(() => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        console.info('err is ' + JSON.stringify(err))
        expect(JSON.stringify(err)).assertContain('401')
      })
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_1050
     * @tc.name   : createUnpremultipliedPixelMap
     * @tc.desc   : Test Func createUnpremultipliedPixelMap Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_1050', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: false,
        size: size,
        alphaType: image.AlphaType.PREMUL,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await image.createUnpremultipliedPixelMap(srcPixelmap, dstPixelMap).then(() => {
        let dstPixelMap_imageInfo: image.ImageInfo = dstPixelMap.getImageInfoSync()
        expect(dstPixelMap_imageInfo.alphaType == image.AlphaType.UNPREMUL).assertTrue()
      }).catch((err: BusinessError) => {
        console.info('err is ' + JSON.stringify(err))
        expect().assertFail()
      })
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_1060
     * @tc.name   : createUnpremultipliedPixelMap
     * @tc.desc   : Test Func createUnpremultipliedPixelMap Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createUnpremultipliedPixelMap_Func_1060', 0, async (done: Function) => {
      let size: image.Size = {
        width: 2, height: 2
      }
      let srcPixelmap_initializationOptions: image.InitializationOptions = {
        editable: true,
        size: size,
        alphaType: image.AlphaType.PREMUL,
      }
      let dstPixelMap_initializationOptions: image.InitializationOptions = {
        editable: false,
        size: size,
        alphaType: image.AlphaType.UNKNOWN,
      }
      let srcPixelmap = image.createPixelMapSync(srcPixelmap_initializationOptions)
      let dstPixelMap = image.createPixelMapSync(dstPixelMap_initializationOptions)
      await image.createUnpremultipliedPixelMap(srcPixelmap, dstPixelMap).then(() => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        console.info('err is ' + JSON.stringify(err))
        expect(JSON.stringify(err)).assertContain('62980248')
      })
      await releasePixelmap(srcPixelmap)
      await releasePixelmap(dstPixelMap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createImageSource_Func_1010
     * @tc.name   : createImageSource
     * @tc.desc   : Test Func createImageSource Sync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createImageSource_Func_1010', 0, async (done: Function) => {
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 240,
        sourcePixelFormat: image.PixelMapFormat.UNKNOWN,
        sourceSize: {
          width: 4, height: 4
        }
      }
      try {
        let imageSource = image.createImageSource(getContext().resourceManager.getRawFdSync('icon.png'), sourceOptions);
        expect(imageSource != undefined).assertTrue()
        await releaseImageSource(imageSource)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createImageSource_Func_1020
     * @tc.name   : createImageSource
     * @tc.desc   : Test Func createImageSource Sync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createImageSource_Func_1020', 0, async (done: Function) => {
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 240,
        sourcePixelFormat: image.PixelMapFormat.RGB_565,
        sourceSize: {
          width: 4, height: 4
        }
      }
      try {
        let imageSource = image.createImageSource(getContext().resourceManager.getRawFdSync('icon.png'), sourceOptions);
        expect(imageSource != undefined).assertTrue()
        await releaseImageSource(imageSource)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createImageSource_Func_1030
     * @tc.name   : createImageSource
     * @tc.desc   : Test Func createImageSource Sync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createImageSource_Func_1030', 0, async (done: Function) => {
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 240,
        sourcePixelFormat: image.PixelMapFormat.RGBA_8888,
        sourceSize: {
          width: 4, height: 4
        }
      }
      try {
        let imageSource = image.createImageSource(getContext().resourceManager.getRawFdSync('icon.png'), sourceOptions);
        expect(imageSource != undefined).assertTrue()
        await releaseImageSource(imageSource)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createImageSource_Func_1040
     * @tc.name   : createImageSource
     * @tc.desc   : Test Func createImageSource Sync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createImageSource_Func_1040', 0, async (done: Function) => {
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 240,
        sourcePixelFormat: image.PixelMapFormat.BGRA_8888,
        sourceSize: {
          width: 4, height: 4
        }
      }
      try {
        let imageSource = image.createImageSource(getContext().resourceManager.getRawFdSync('icon.png'), sourceOptions);
        expect(imageSource != undefined).assertTrue()
        await releaseImageSource(imageSource)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createImageSource_Func_1050
     * @tc.name   : createImageSource
     * @tc.desc   : Test Func createImageSource Sync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createImageSource_Func_1050', 0, async (done: Function) => {
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 240,
        sourcePixelFormat: image.PixelMapFormat.RGB_888,
        sourceSize: {
          width: 4, height: 4
        }
      }
      try {
        let imageSource = image.createImageSource(getContext().resourceManager.getRawFdSync('icon.png'), sourceOptions);
        expect(imageSource != undefined).assertTrue()
        await releaseImageSource(imageSource)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createImageSource_Func_1060
     * @tc.name   : createImageSource
     * @tc.desc   : Test Func createImageSource Sync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createImageSource_Func_1060', 0, async (done: Function) => {
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 240,
        sourcePixelFormat: image.PixelMapFormat.ALPHA_8,
        sourceSize: {
          width: 4, height: 4
        }
      }
      try {
        let imageSource = image.createImageSource(getContext().resourceManager.getRawFdSync('icon.png'), sourceOptions);
        expect(imageSource != undefined).assertTrue()
        await releaseImageSource(imageSource)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createImageSource_Func_1070
     * @tc.name   : createImageSource
     * @tc.desc   : Test Func createImageSource Sync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createImageSource_Func_1070', 0, async (done: Function) => {
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 240,
        sourcePixelFormat: image.PixelMapFormat.RGBA_F16,
        sourceSize: {
          width: 4, height: 4
        }
      }
      try {
        let imageSource = image.createImageSource(getContext().resourceManager.getRawFdSync('icon.png'), sourceOptions);
        expect(imageSource != undefined).assertTrue()
        await releaseImageSource(imageSource)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createImageSource_Func_1080
     * @tc.name   : createImageSource
     * @tc.desc   : Test Func createImageSource Sync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createImageSource_Func_1080', 0, async (done: Function) => {
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 240,
        sourcePixelFormat: image.PixelMapFormat.NV21,
        sourceSize: {
          width: 4, height: 4
        }
      }
      try {
        let imageSource = image.createImageSource(getContext().resourceManager.getRawFdSync('icon.png'), sourceOptions);
        expect(imageSource != undefined).assertTrue()
        await releaseImageSource(imageSource)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createImageSource_Func_1090
     * @tc.name   : createImageSource
     * @tc.desc   : Test Func createImageSource Sync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_Image_createImageSource_Func_1090', 0, async (done: Function) => {
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 240,
        sourcePixelFormat: image.PixelMapFormat.NV12,
        sourceSize: {
          width: 4, height: 4
        }
      }
      try {
        let imageSource = image.createImageSource(getContext().resourceManager.getRawFdSync('icon.png'), sourceOptions);
        expect(imageSource != undefined).assertTrue()
        await releaseImageSource(imageSource)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createImageSource_Func_1100
     * @tc.name   : createImageSource
     * @tc.desc   : Test Func createImageSource Sync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createImageSource_Func_1100', 0, async (done: Function) => {
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 240,
        sourcePixelFormat: image.PixelMapFormat.RGBA_8888,
        sourceSize: {
          width: 4, height: 4
        }
      }
      try {
        let imageSource = image.createImageSource(undefined, sourceOptions);
        expect(imageSource).assertUndefined()
      } catch (err) {
        expect(JSON.stringify(err)).assertContain('401')
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createImageSource_Func_1200
     * @tc.name   : createImageSource
     * @tc.desc   : Test Func createImageSource Sync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createImageSource_Func_1200', 0, async (done: Function) => {
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 0,
        sourcePixelFormat: image.PixelMapFormat.RGBA_8888,
        sourceSize: {
          width: 4, height: 4
        }
      }
      try {
        let imageSource = image.createImageSource(getContext().resourceManager.getRawFdSync('icon.png'), sourceOptions);
        expect(imageSource != undefined).assertTrue()
        await releaseImageSource(imageSource)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createImageSource_Func_1130
     * @tc.name   : createImageSource
     * @tc.desc   : Test Func createImageSource Sync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createImageSource_Func_1130', 0, async (done: Function) => {
      let sourceOptions: image.SourceOptions = {
        sourceDensity: -1,
        sourcePixelFormat: image.PixelMapFormat.RGBA_8888,
        sourceSize: {
          width: 4, height: 4
        }
      }
      try {
        let imageSource = image.createImageSource(getContext().resourceManager.getRawFdSync('icon.png'), sourceOptions);
        expect(imageSource != undefined).assertTrue()
        await releaseImageSource(imageSource)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createImageSource_Func_1140
     * @tc.name   : createImageSource
     * @tc.desc   : Test Func createImageSource Sync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createImageSource_Func_1140', 0, async (done: Function) => {
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 240,
        sourcePixelFormat: image.PixelMapFormat.RGBA_8888,
        sourceSize: {
          width: 0, height: 0
        }
      }
      try {
        let imageSource = image.createImageSource(getContext().resourceManager.getRawFdSync('icon.png'), sourceOptions);
        expect(imageSource != undefined).assertTrue()
        await releaseImageSource(imageSource)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_Image_createImageSource_Func_1150
     * @tc.name   : createImageSource
     * @tc.desc   : Test Func createImageSource Sync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_Image_createImageSource_Func_1150', 0, async (done: Function) => {
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 240,
        sourcePixelFormat: image.PixelMapFormat.RGBA_8888,
        sourceSize: {
          width: -1, height: -1
        }
      }
      try {
        let imageSource = image.createImageSource(getContext().resourceManager.getRawFdSync('icon.png'), sourceOptions);
        expect(imageSource != undefined).assertTrue()
        await releaseImageSource(imageSource)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

  })
}