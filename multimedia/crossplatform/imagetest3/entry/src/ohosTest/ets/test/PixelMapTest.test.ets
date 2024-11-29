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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, ExpectExtend } from '@ohos/hypium'
import { BusinessError } from '@ohos.base'
import image from '@ohos.multimedia.image'
import colorSpaceManager from '@ohos.graphics.colorSpaceManager';

import { testPng, testJpg, testGif, testBmp } from './ImageResource'
import { tcBuf020, tcBuf021 } from './ImageResource2'
import { translate3x1, translate1x3, rotate90, crop3x3, setAlpha8 } from './ImageResource2'
import { flip, flipV, flipH, flipV_H } from './ImageResource2'

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

export default function PixelMapTest() {
  describe('PixelMapTest', () => {
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
     * @tc.number : SUB_ARKUIX_PixelMap_readPixelsToBufferSync_Func_0010
     * @tc.name   : readPixelsToBufferSync
     * @tc.desc   : Test Func readPixelsToBufferSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_readPixelsToBufferSync_Func_0010', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.BGRA_8888,
        size: size,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        let readBuffer = new ArrayBuffer(96)
        pixelmap.readPixelsToBufferSync(readBuffer)
        let bufferArr2 = new Uint8Array(readBuffer)
        let res: boolean = true
        for (let i = 0; i < bufferArr2.length; i++) {
          if (bufferArr2[i] != tcBuf020[i]) {
            res = false
            console.info('SUB_ARKUIX_PixelMap_readPixelsToBufferSync_Func_0010 failed')
            break
          }
        }
        expect(res).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_readPixelsToBufferSync_Func_0020
     * @tc.name   : readPixelsToBufferSync
     * @tc.desc   : Test Func readPixelsToBufferSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_readPixelsToBufferSync_Func_0020', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.BGRA_8888,
        size: size,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        let readBuffer = new ArrayBuffer(10)
        pixelmap.readPixelsToBufferSync(readBuffer)
        let bufferArr2 = new Uint8Array(readBuffer)
        let res: boolean = true
        for (let i = 0; i < bufferArr2.length; i++) {
          if (bufferArr2[i] != tcBuf020[i]) {
            res = false
            console.info('SUB_ARKUIX_PixelMap_readPixelsToBufferSync_Func_0020 failed')
            break
          }
        }
        expect(res).assertFalse()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_writeBufferToPixelsSync_Func_0010
     * @tc.name   : writeBufferToPixelsSync
     * @tc.desc   : Test Func writeBufferToPixelsSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_writeBufferToPixelsSync_Func_0010', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      let writeColor = new ArrayBuffer(96)
      let writeArrayBuffer = new Uint8Array(writeColor)
      for (let i = 0; i < writeArrayBuffer.length; i++) {
        writeArrayBuffer[i] = i + 1
      }
      let readBuffer = new ArrayBuffer(96)
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        pixelmap.writeBufferToPixelsSync(writeColor)
        pixelmap.readPixelsToBufferSync(readBuffer)
        let bufferArr = new Uint8Array(readBuffer)
        let res: boolean = true
        for (let i = 0; i < bufferArr.length; i++) {
          if (bufferArr[i] == 0) {
            res = false
            console.info('SUB_ARKUIX_PixelMap_writeBufferToPixelsSync_Func_0010 failed')
            break
          }
        }
        expect(res).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_writeBufferToPixelsSync_Func_0020
     * @tc.name   : writeBufferToPixelsSync
     * @tc.desc   : Test Func writeBufferToPixelsSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_writeBufferToPixelsSync_Func_0020', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      let writeColor = new ArrayBuffer(100)
      let writeArrayBuffer = new Uint8Array(writeColor)
      for (let i = 0; i < writeArrayBuffer.length; i++) {
        writeArrayBuffer[i] = i + 1
      }
      let readBuffer = new ArrayBuffer(96)
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        pixelmap.writeBufferToPixelsSync(writeColor)
        pixelmap.readPixelsToBufferSync(readBuffer)
        let bufferArr = new Uint8Array(readBuffer)
        let res: boolean = true
        for (let i = 0; i < bufferArr.length; i++) {
          if (bufferArr[i] == 0) {
            res = false
            console.info('SUB_ARKUIX_PixelMap_writeBufferToPixelsSync_Func_0020 failed')
            break
          }
        }
        expect(res).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_readPixelsSync_Func_0010
     * @tc.name   : readPixelsSync
     * @tc.desc   : Test Func readPixelsSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_readPixelsSync_Func_0010', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      let region: image.Region = { size: { width: 2, height: 1 }, x: 0, y: 0 }
      let positionArea: image.PositionArea = { pixels: new ArrayBuffer(8), offset: 0, stride: 8, region: region }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        pixelmap.readPixelsSync(positionArea)
        let bufferArr2 = new Uint8Array(positionArea.pixels)
        let res: boolean = true
        for (let i = 0; i < bufferArr2.length; i++) {
          if (bufferArr2[i] != tcBuf021[i]) {
            res = false;
            console.info('SUB_ARKUIX_PixelMap_readPixelsSync_Func_0010 failed')
            break
          }
        }
        expect(res).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_readPixelsSync_Func_0020
     * @tc.name   : readPixelsSync
     * @tc.desc   : Test Func readPixelsSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_PixelMap_readPixelsSync_Func_0020', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      let region: image.Region = { size: { width: 2, height: 1 }, x: 0, y: 0 }
      let positionArea: image.PositionArea = { pixels: new ArrayBuffer(4), offset: 0, stride: 8, region: region }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        pixelmap.readPixelsSync(positionArea)
        let bufferArr2 = new Uint8Array(positionArea.pixels)
        let res: boolean = true
        for (let i = 0; i < bufferArr2.length; i++) {
          if (bufferArr2[i] != tcBuf021[i]) {
            res = false;
            console.info('SUB_ARKUIX_PixelMap_readPixelsSync_Func_0020 failed')
            break
          }
        }
        expect(res).assertFalse()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_readPixelsSync_Func_0030
     * @tc.name   : readPixelsSync
     * @tc.desc   : Test Func readPixelsSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_PixelMap_readPixelsSync_Func_0030', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      let region: image.Region = { size: { width: 2, height: 1 }, x: 0, y: 0 }
      let positionArea: image.PositionArea = { pixels: new ArrayBuffer(8), offset: -1, stride: 8, region: region }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        pixelmap.readPixelsSync(positionArea)
        let bufferArr2 = new Uint8Array(positionArea.pixels)
        let res: boolean = true
        for (let i = 0; i < bufferArr2.length; i++) {
          if (bufferArr2[i] != tcBuf021[i]) {
            res = false;
            console.info('SUB_ARKUIX_PixelMap_readPixelsSync_Func_0030 failed')
            break
          }
        }
        expect(res).assertFalse()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_readPixelsSync_Func_0040
     * @tc.name   : readPixelsSync
     * @tc.desc   : Test Func readPixelsSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_PixelMap_readPixelsSync_Func_0040', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      let region: image.Region = { size: { width: 2, height: 1 }, x: 0, y: 0 }
      let positionArea: image.PositionArea = { pixels: new ArrayBuffer(8), offset: 0, stride: -1, region: region }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        pixelmap.readPixelsSync(positionArea)
        let bufferArr2 = new Uint8Array(positionArea.pixels)
        let res: boolean = true
        for (let i = 0; i < bufferArr2.length; i++) {
          if (bufferArr2[i] != tcBuf021[i]) {
            res = false;
            console.info('SUB_ARKUIX_PixelMap_readPixelsSync_Func_0040 failed')
            break
          }
        }
        expect(res).assertFalse()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_readPixelsSync_Func_0050
     * @tc.name   : readPixelsSync
     * @tc.desc   : Test Func readPixelsSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_PixelMap_readPixelsSync_Func_0050', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      let region: image.Region = { size: { width: -1, height: -1 }, x: 0, y: 0 }
      let positionArea: image.PositionArea = { pixels: new ArrayBuffer(8), offset: 0, stride: 8, region: region }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        pixelmap.readPixelsSync(positionArea)
        let bufferArr2 = new Uint8Array(positionArea.pixels)
        let res: boolean = true
        for (let i = 0; i < bufferArr2.length; i++) {
          if (bufferArr2[i] != tcBuf021[i]) {
            res = false;
            console.info('SUB_ARKUIX_PixelMap_readPixelsSync_Func_0050 failed')
            break
          }
        }
        expect(res).assertFalse()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_readPixelsSync_Func_0060
     * @tc.name   : readPixelsSync
     * @tc.desc   : Test Func readPixelsSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_PixelMap_readPixelsSync_Func_0060', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      let region: image.Region = { size: { width: 5, height: 7 }, x: 0, y: 0 }
      let positionArea: image.PositionArea = { pixels: new ArrayBuffer(8), offset: 0, stride: 8, region: region }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        pixelmap.readPixelsSync(positionArea)
        let bufferArr2 = new Uint8Array(positionArea.pixels)
        let res: boolean = true
        for (let i = 0; i < bufferArr2.length; i++) {
          if (bufferArr2[i] != tcBuf021[i]) {
            res = false;
            console.info('SUB_ARKUIX_PixelMap_readPixelsSync_Func_0060 failed')
            break
          }
        }
        expect(res).assertFalse()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_writePixelsSync_Func_0010
     * @tc.name   : writePixelsSync
     * @tc.desc   : Test Func writePixelsSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_writePixelsSync_Func_0010', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      let region: image.Region = { size: { width: 2, height: 1 }, x: 0, y: 0 }
      let positionAreaForWrite: image.PositionArea = { pixels: new ArrayBuffer(8), offset: 0, stride: 8, region: region }
      let writeArrayBuffer = new Uint8Array(positionAreaForWrite.pixels)
      for (let i = 0; i < writeArrayBuffer.length; i++) {
        writeArrayBuffer[i] = i + 1
      }
      let positionAreaForRead: image.PositionArea = { pixels: new ArrayBuffer(8), offset: 0, stride: 8, region: region }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        pixelmap.writePixelsSync(positionAreaForWrite)
        await pixelmap.readPixels(positionAreaForRead).then(() => {
          let readArrayBuffer = new Uint8Array(positionAreaForRead.pixels)
          let res: boolean = true;
          for (let i = 0; i < readArrayBuffer.length; i++) {
            if (readArrayBuffer[i] != tcBuf021[i]) {
              res = false;
              console.info('SUB_ARKUIX_PixelMap_writePixelsSync_Func_0010 failed')
              break
            }
          }
          expect(res).assertTrue()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_writePixelsSync_Func_0020
     * @tc.name   : writePixelsSync
     * @tc.desc   : Test Func writePixelsSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_PixelMap_writePixelsSync_Func_0020', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      let region: image.Region = { size: { width: 2, height: 1 }, x: 0, y: 0 }
      let positionAreaForWrite: image.PositionArea = { pixels: new ArrayBuffer(12), offset: 0, stride: 8, region: region }
      let writeArrayBuffer = new Uint8Array(positionAreaForWrite.pixels)
      for (let i = 0; i < writeArrayBuffer.length; i++) {
        writeArrayBuffer[i] = i + 1
      }
      let positionAreaForRead: image.PositionArea = { pixels: new ArrayBuffer(8), offset: 0, stride: 8, region: region }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        pixelmap.writePixelsSync(positionAreaForWrite)
        await pixelmap.readPixels(positionAreaForRead).then(() => {
          let readArrayBuffer = new Uint8Array(positionAreaForRead.pixels)
          let res: boolean = true;
          for (let i = 0; i < readArrayBuffer.length; i++) {
            if (readArrayBuffer[i] != tcBuf021[i]) {
              res = false;
              console.info('SUB_ARKUIX_PixelMap_writePixelsSync_Func_0020 failed')
              break
            }
          }
          expect(res).assertTrue()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_writePixelsSync_Func_0030
     * @tc.name   : writePixelsSync
     * @tc.desc   : Test Func writePixelsSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_PixelMap_writePixelsSync_Func_0030', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      let region: image.Region = { size: { width: 2, height: 1 }, x: 0, y: 0 }
      let positionAreaForWrite: image.PositionArea = { pixels: new ArrayBuffer(8), offset: -1, stride: 8, region: region }
      let writeArrayBuffer = new Uint8Array(positionAreaForWrite.pixels)
      for (let i = 0; i < writeArrayBuffer.length; i++) {
        writeArrayBuffer[i] = i + 1
      }
      let positionAreaForRead: image.PositionArea = { pixels: new ArrayBuffer(8), offset: 0, stride: 8, region: region }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        pixelmap.writePixelsSync(positionAreaForWrite)
        await pixelmap.readPixels(positionAreaForRead).then(() => {
          let readArrayBuffer = new Uint8Array(positionAreaForRead.pixels)
          let res: boolean = true;
          for (let i = 0; i < readArrayBuffer.length; i++) {
            if (readArrayBuffer[i] != tcBuf021[i]) {
              res = false;
              console.info('SUB_ARKUIX_PixelMap_writePixelsSync_Func_0030 failed')
              break
            }
          }
          expect(res).assertFalse()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_writePixelsSync_Func_0040
     * @tc.name   : writePixelsSync
     * @tc.desc   : Test Func writePixelsSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_PixelMap_writePixelsSync_Func_0040', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      let region: image.Region = { size: { width: 2, height: 1 }, x: 0, y: 0 }
      let positionAreaForWrite: image.PositionArea = { pixels: new ArrayBuffer(8), offset: 0, stride: -1, region: region }
      let writeArrayBuffer = new Uint8Array(positionAreaForWrite.pixels)
      for (let i = 0; i < writeArrayBuffer.length; i++) {
        writeArrayBuffer[i] = i + 1
      }
      let positionAreaForRead: image.PositionArea = { pixels: new ArrayBuffer(8), offset: 0, stride: 8, region: region }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        pixelmap.writePixelsSync(positionAreaForWrite)
        await pixelmap.readPixels(positionAreaForRead).then(() => {
          let readArrayBuffer = new Uint8Array(positionAreaForRead.pixels)
          let res: boolean = true;
          for (let i = 0; i < readArrayBuffer.length; i++) {
            if (readArrayBuffer[i] != tcBuf021[i]) {
              res = false;
              console.info('SUB_ARKUIX_PixelMap_writePixelsSync_Func_0040 failed')
              break
            }
          }
          expect(res).assertFalse()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_writePixelsSync_Func_0050
     * @tc.name   : writePixelsSync
     * @tc.desc   : Test Func writePixelsSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_PixelMap_writePixelsSync_Func_0050', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      let region: image.Region = { size: { width: -1, height: -1 }, x: 0, y: 0 }
      let positionAreaForWrite: image.PositionArea = { pixels: new ArrayBuffer(8), offset: 0, stride: 8, region: region }
      let writeArrayBuffer = new Uint8Array(positionAreaForWrite.pixels)
      for (let i = 0; i < writeArrayBuffer.length; i++) {
        writeArrayBuffer[i] = i + 1
      }
      let positionAreaForRead: image.PositionArea = { pixels: new ArrayBuffer(8), offset: 0, stride: 8, region: region }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        pixelmap.writePixelsSync(positionAreaForWrite)
        await pixelmap.readPixels(positionAreaForRead).then(() => {
          let readArrayBuffer = new Uint8Array(positionAreaForRead.pixels)
          let res: boolean = true;
          for (let i = 0; i < readArrayBuffer.length; i++) {
            if (readArrayBuffer[i] != tcBuf021[i]) {
              res = false;
              console.info('SUB_ARKUIX_PixelMap_writePixelsSync_Func_0050 failed')
              break
            }
          }
          expect(res).assertFalse()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("62980115")
        })
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_writePixelsSync_Func_0060
     * @tc.name   : writePixelsSync
     * @tc.desc   : Test Func writePixelsSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_PixelMap_writePixelsSync_Func_0060', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      let region: image.Region = { size: { width: 5, height: 7 }, x: 0, y: 0 }
      let positionAreaForWrite: image.PositionArea = { pixels: new ArrayBuffer(8), offset: 0, stride: 8, region: region }
      let writeArrayBuffer = new Uint8Array(positionAreaForWrite.pixels)
      for (let i = 0; i < writeArrayBuffer.length; i++) {
        writeArrayBuffer[i] = i + 1
      }
      let positionAreaForRead: image.PositionArea = { pixels: new ArrayBuffer(8), offset: 0, stride: 8, region: region }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        expect(pixelmap.isEditable).assertTrue()
        pixelmap.writePixelsSync(positionAreaForWrite)
        await pixelmap.readPixels(positionAreaForRead).then(() => {
          let readArrayBuffer = new Uint8Array(positionAreaForRead.pixels)
          let res: boolean = true;
          for (let i = 0; i < readArrayBuffer.length; i++) {
            if (readArrayBuffer[i] != tcBuf021[i]) {
              res = false;
              console.info('SUB_ARKUIX_PixelMap_writePixelsSync_Func_0060 failed')
              break
            }
          }
          expect(res).assertFalse()
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect(JSON.stringify(err)).assertContain("62980115")
        })
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_getImageInfoSync_Func_0010
     * @tc.name   : getImageInfoSync
     * @tc.desc   : Test Func getImageInfoSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_getImageInfoSync_Func_0010', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let size: image.Size = { width: 6, height: 4 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
        alphaType: image.AlphaType.UNPREMUL,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        let imageInfo: image.ImageInfo = pixelmap.getImageInfoSync()
        if (imageInfo == undefined) {
          console.info('imageInfo is empty')
          expect().assertFail()
        } else {
          expect(imageInfo.size.width == 6).assertTrue()
          expect(imageInfo.size.height == 4).assertTrue()
          expect(imageInfo.pixelFormat == image.PixelMapFormat.RGBA_8888).assertTrue()
          expect(imageInfo.alphaType == image.AlphaType.UNPREMUL).assertTrue()
        }
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_getImageInfoSync_Func_0020
     * @tc.name   : getImageInfoSync
     * @tc.desc   : Test Func getImageInfoSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_getImageInfoSync_Func_0020', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      let sourceOptions: image.SourceOptions = {
        sourceDensity: 240
      }
      let decodingOptions: image.DecodingOptions = {
        editable: true,
        fitDensity: 240
      }
      try {
        let imageSourceApi: image.ImageSource = image.createImageSource(data, sourceOptions)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync(decodingOptions)
        expect(pixelmap.isEditable).assertTrue()
        let imageInfo: image.ImageInfo = pixelmap.getImageInfoSync()
        if (imageInfo == undefined) {
          console.info('imageInfo is empty')
          expect().assertFail()
        } else {
          console.info('imageInfo.density is ' + JSON.stringify(imageInfo.density))
          console.info('imageInfo.mimeType is ' + JSON.stringify(imageInfo.mimeType))
          expect(imageInfo.density == 240).assertTrue()
          expect(imageInfo.mimeType == "image/png").assertTrue()
        }
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_opacitySync_Func_0010
     * @tc.name   : opacitySync
     * @tc.desc   : Test Func opacitySync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_opacitySync_Func_0010', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { width: 6, height: 4 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        pixelmap.opacitySync(0.8)
        let pixelBytesNumber = pixelmap.getPixelBytesNumber()
        console.info('pixelBytesNumber is ' + JSON.stringify(pixelBytesNumber))
        let readBuffer = new ArrayBuffer(pixelBytesNumber)
        pixelmap.readPixelsToBufferSync(readBuffer)
        let bufferArr2 = new Uint8Array(readBuffer)
        let res: boolean = true
        for (let i = 0; i < bufferArr2.length; i++) {
          if (bufferArr2[i] != setAlpha8[i]) {
            res = false
            break
          }
        }
        expect(res).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_opacitySync_Func_0020
     * @tc.name   : opacitySync
     * @tc.desc   : Test Func opacitySync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_PixelMap_opacitySync_Func_0020', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { width: 6, height: 4 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        let pixelBytesNumber = pixelmap.getPixelBytesNumber()
        console.info('pixelBytesNumber is ' + JSON.stringify(pixelBytesNumber))
        let readBuffer = new ArrayBuffer(pixelBytesNumber)
        let readBufferCheck = new ArrayBuffer(pixelBytesNumber)
        pixelmap.readPixelsToBufferSync(readBufferCheck)
        pixelmap.opacitySync(2)
        pixelmap.readPixelsToBufferSync(readBuffer)
        let bufferArr2 = new Uint8Array(readBuffer)
        let bufferArr2Check = new Uint8Array(readBufferCheck)
        let res: boolean = true
        for (let i = 0; i < bufferArr2.length; i++) {
          if (bufferArr2[i] != bufferArr2Check[i]) {
            res = false
            break
          }
        }
        expect(res).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_opacitySync_Func_0030
     * @tc.name   : opacitySync
     * @tc.desc   : Test Func opacitySync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_PixelMap_opacitySync_Func_0030', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { width: 6, height: 4 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        let pixelBytesNumber = pixelmap.getPixelBytesNumber()
        console.info('pixelBytesNumber is ' + JSON.stringify(pixelBytesNumber))
        let readBuffer = new ArrayBuffer(pixelBytesNumber)
        let readBufferCheck = new ArrayBuffer(pixelBytesNumber)
        pixelmap.readPixelsToBufferSync(readBufferCheck)
        pixelmap.opacitySync(-1)
        pixelmap.readPixelsToBufferSync(readBuffer)
        let bufferArr2 = new Uint8Array(readBuffer)
        let bufferArr2Check = new Uint8Array(readBufferCheck)
        let res: boolean = true
        for (let i = 0; i < bufferArr2.length; i++) {
          if (bufferArr2[i] != bufferArr2Check[i]) {
            res = false
            break
          }
        }
        expect(res).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_createAlphaPixelmapSync_Func_0010
     * @tc.name   : createAlphaPixelmapSync
     * @tc.desc   : Test Func createAlphaPixelmapSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_createAlphaPixelmapSync_Func_0010', 0, async (done: Function) => {
      let data: ArrayBuffer = testJpg.buffer as ArrayBuffer
      try {
        let imageSourceApi: image.ImageSource = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync()
        let alphaPixelMap: image.PixelMap = pixelmap.createAlphaPixelmapSync()
        let imageInfo: image.ImageInfo = alphaPixelMap.getImageInfoSync()
        console.info('imageInfo.pixelFormat is ' + JSON.stringify(imageInfo.pixelFormat))
        expect(imageInfo.pixelFormat == image.PixelMapFormat.ALPHA_8).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_createAlphaPixelmapSync_Func_0020
     * @tc.name   : createAlphaPixelmapSync
     * @tc.desc   : Test Func createAlphaPixelmapSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_createAlphaPixelmapSync_Func_0020', 0, async (done: Function) => {
      let data: ArrayBuffer = testPng.buffer as ArrayBuffer
      try {
        let imageSourceApi: image.ImageSource = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync()
        let alphaPixelMap: image.PixelMap = pixelmap.createAlphaPixelmapSync()
        let imageInfo: image.ImageInfo = alphaPixelMap.getImageInfoSync()
        console.info('imageInfo.pixelFormat is ' + JSON.stringify(imageInfo.pixelFormat))
        expect(imageInfo.pixelFormat == image.PixelMapFormat.ALPHA_8).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_createAlphaPixelmapSync_Func_0030
     * @tc.name   : createAlphaPixelmapSync
     * @tc.desc   : Test Func createAlphaPixelmapSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_createAlphaPixelmapSync_Func_0030', 0, async (done: Function) => {
      let data: ArrayBuffer = testGif.buffer as ArrayBuffer
      try {
        let imageSourceApi: image.ImageSource = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync()
        let alphaPixelMap: image.PixelMap = pixelmap.createAlphaPixelmapSync()
        let imageInfo: image.ImageInfo = alphaPixelMap.getImageInfoSync()
        console.info('imageInfo.pixelFormat is ' + JSON.stringify(imageInfo.pixelFormat))
        expect(imageInfo.pixelFormat == image.PixelMapFormat.ALPHA_8).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_createAlphaPixelmapSync_Func_0040
     * @tc.name   : createAlphaPixelmapSync
     * @tc.desc   : Test Func createAlphaPixelmapSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_createAlphaPixelmapSync_Func_0040', 0, async (done: Function) => {
      let data: ArrayBuffer = testBmp.buffer as ArrayBuffer
      try {
        let imageSourceApi: image.ImageSource = image.createImageSource(data)
        let pixelmap: image.PixelMap = imageSourceApi.createPixelMapSync()
        let alphaPixelMap: image.PixelMap = pixelmap.createAlphaPixelmapSync()
        let imageInfo: image.ImageInfo = alphaPixelMap.getImageInfoSync()
        console.info('imageInfo.pixelFormat is ' + JSON.stringify(imageInfo.pixelFormat))
        expect(imageInfo.pixelFormat == image.PixelMapFormat.ALPHA_8).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_scaleSync_Func_0010
     * @tc.name   : scaleSync
     * @tc.desc   : Test Func scaleSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_scaleSync_Func_0010', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        let imageInfo1: image.ImageInfo = pixelmap.getImageInfoSync()
        pixelmap.scaleSync(4.0, 4.0)
        let imageInfo2: image.ImageInfo = pixelmap.getImageInfoSync()
        console.info('imageInfo2 is ' + JSON.stringify(imageInfo2))
        expect(imageInfo2.size.height == imageInfo1.size.height * 4).assertTrue()
        expect(imageInfo2.size.width == imageInfo1.size.width * 4).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_scaleSync_Func_0020
     * @tc.name   : scaleSync
     * @tc.desc   : Test Func scaleSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_scaleSync_Func_0020', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        let imageInfo1: image.ImageInfo = pixelmap.getImageInfoSync()
        pixelmap.scaleSync(0.5, 0.5)
        let imageInfo2: image.ImageInfo = pixelmap.getImageInfoSync()
        console.info('imageInfo2 is ' + JSON.stringify(imageInfo2))
        expect(imageInfo2.size.height == imageInfo1.size.height * 0.5).assertTrue()
        expect(imageInfo2.size.width == imageInfo1.size.width * 0.5).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_scaleSync_Func_0030
     * @tc.name   : scaleSync
     * @tc.desc   : Test Func scaleSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_PixelMap_scaleSync_Func_0030', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        let imageInfo1: image.ImageInfo = pixelmap.getImageInfoSync()
        pixelmap.scaleSync(-1, -1)
        let imageInfo2: image.ImageInfo = pixelmap.getImageInfoSync()
        console.info('imageInfo2 is ' + JSON.stringify(imageInfo2))
        expect(imageInfo2.size.height == imageInfo1.size.height).assertTrue()
        expect(imageInfo2.size.width == imageInfo1.size.width).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_scaleSync_Func_0040
     * @tc.name   : scaleSync
     * @tc.desc   : Test Func scaleSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_PixelMap_scaleSync_Func_0040', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        let imageInfo1: image.ImageInfo = pixelmap.getImageInfoSync()
        pixelmap.scaleSync(0, 0)
        let imageInfo2: image.ImageInfo = pixelmap.getImageInfoSync()
        console.info('imageInfo2 is ' + JSON.stringify(imageInfo2))
        expect(imageInfo2.size.height == imageInfo1.size.height).assertTrue()
        expect(imageInfo2.size.width == imageInfo1.size.width).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_translateSync_Func_0010
     * @tc.name   : translateSync
     * @tc.desc   : Test Func translateSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_translateSync_Func_0010', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        let imageInfo1: image.ImageInfo = pixelmap.getImageInfoSync()
        pixelmap.translateSync(1, 3)
        let imageInfo2: image.ImageInfo = pixelmap.getImageInfoSync()
        console.info('imageInfo2 is ' + JSON.stringify(imageInfo2))
        let res: boolean = true
        let pixelSize = pixelmap.getPixelBytesNumber()
        let readBuffer = new ArrayBuffer(pixelSize)
        pixelmap.readPixelsToBufferSync(readBuffer)
        let bufferArr2 = new Uint8Array(readBuffer)
        for (let i = 0; i < bufferArr2.length; i++) {
          if (bufferArr2[i] != translate1x3[i]) {
            res = false
            break
          }
        }
        expect(res).assertTrue()
        expect(imageInfo2.size.height == imageInfo1.size.height + 3).assertTrue()
        expect(imageInfo2.size.width == imageInfo1.size.width + 1).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_translateSync_Func_0020
     * @tc.name   : translateSync
     * @tc.desc   : Test Func translateSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_translateSync_Func_0020', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        let imageInfo1: image.ImageInfo = pixelmap.getImageInfoSync()
        pixelmap.translateSync(3, 1)
        let imageInfo2: image.ImageInfo = pixelmap.getImageInfoSync()
        console.info('imageInfo2 is ' + JSON.stringify(imageInfo2))
        let res: boolean = true
        let pixelSize = pixelmap.getPixelBytesNumber()
        let readBuffer = new ArrayBuffer(pixelSize)
        pixelmap.readPixelsToBufferSync(readBuffer)
        let bufferArr2 = new Uint8Array(readBuffer)
        for (let i = 0; i < bufferArr2.length; i++) {
          if (bufferArr2[i] != translate3x1[i]) {
            res = false
            break
          }
        }
        expect(res).assertTrue()
        expect(imageInfo2.size.height == imageInfo1.size.height + 1).assertTrue()
        expect(imageInfo2.size.width == imageInfo1.size.width + 3).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_translateSync_Func_0030
     * @tc.name   : translateSync
     * @tc.desc   : Test Func translateSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_PixelMap_translateSync_Func_0030', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        let imageInfo1: image.ImageInfo = pixelmap.getImageInfoSync()
        pixelmap.translateSync(0, 0)
        let imageInfo2: image.ImageInfo = pixelmap.getImageInfoSync()
        console.info('imageInfo2 is ' + JSON.stringify(imageInfo2))
        expect(imageInfo2.size.height == imageInfo1.size.height).assertTrue()
        expect(imageInfo2.size.width == imageInfo1.size.width).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_translateSync_Func_0040
     * @tc.name   : translateSync
     * @tc.desc   : Test Func translateSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_translateSync_Func_0040', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        let imageInfo1: image.ImageInfo = pixelmap.getImageInfoSync()
        pixelmap.translateSync(-1, -1)
        let imageInfo2: image.ImageInfo = pixelmap.getImageInfoSync()
        console.info('imageInfo2 is ' + JSON.stringify(imageInfo2))
        expect(imageInfo2.size.height == imageInfo1.size.height - 1).assertTrue()
        expect(imageInfo2.size.width == imageInfo1.size.width - 1).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_rotateSync_Func_0010
     * @tc.name   : rotateSync
     * @tc.desc   : Test Func rotateSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_rotateSync_Func_0010', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        let imageInfo1: image.ImageInfo = pixelmap.getImageInfoSync()
        pixelmap.rotateSync(90.0)
        let imageInfo2: image.ImageInfo = pixelmap.getImageInfoSync()
        console.info('imageInfo2 is ' + JSON.stringify(imageInfo2))
        let res: boolean = true
        let pixelSize = pixelmap.getPixelBytesNumber()
        let readBuffer = new ArrayBuffer(pixelSize)
        pixelmap.readPixelsToBufferSync(readBuffer)
        let bufferArr2 = new Uint8Array(readBuffer)
        for (let i = 0; i < bufferArr2.length; i++) {
          if (bufferArr2[i] != rotate90[i]) {
            res = false
            break
          }
        }
        expect(res).assertTrue()
        expect(imageInfo2.size.width == imageInfo1.size.height).assertTrue()
        expect(imageInfo2.size.height == imageInfo1.size.width).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_rotateSync_Func_0020
     * @tc.name   : rotateSync
     * @tc.desc   : Test Func rotateSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_rotateSync_Func_0020', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        let imageInfo1: image.ImageInfo = pixelmap.getImageInfoSync()
        pixelmap.rotateSync(-90)
        let imageInfo2: image.ImageInfo = pixelmap.getImageInfoSync()
        console.info('imageInfo2 is ' + JSON.stringify(imageInfo2))
        expect(imageInfo2.size.width == imageInfo1.size.height).assertTrue()
        expect(imageInfo2.size.height == imageInfo1.size.width).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_rotateSync_Func_0030
     * @tc.name   : rotateSync
     * @tc.desc   : Test Func rotateSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_rotateSync_Func_0030', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        let imageInfo1: image.ImageInfo = pixelmap.getImageInfoSync()
        pixelmap.rotateSync(0)
        let imageInfo2: image.ImageInfo = pixelmap.getImageInfoSync()
        console.info('imageInfo2 is ' + JSON.stringify(imageInfo2))
        expect(imageInfo2.size.width == imageInfo1.size.width).assertTrue()
        expect(imageInfo2.size.height == imageInfo1.size.height).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_rotateSync_Func_0040
     * @tc.name   : rotateSync
     * @tc.desc   : Test Func rotateSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_rotateSync_Func_0040', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        let imageInfo1: image.ImageInfo = pixelmap.getImageInfoSync()
        pixelmap.rotateSync(450)
        let imageInfo2: image.ImageInfo = pixelmap.getImageInfoSync()
        console.info('imageInfo2 is ' + JSON.stringify(imageInfo2))
        expect(imageInfo2.size.width == imageInfo1.size.height).assertTrue()
        expect(imageInfo2.size.height == imageInfo1.size.width).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_flipSync_Func_0010
     * @tc.name   : flipSync
     * @tc.desc   : Test Func flipSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_flipSync_Func_0010', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        pixelmap.flipSync(false, true)
        let res: boolean = true
        let pixelSize = pixelmap.getPixelBytesNumber()
        let readBuffer = new ArrayBuffer(pixelSize)
        pixelmap.readPixelsToBufferSync(readBuffer)
        let bufferArr2 = new Uint8Array(readBuffer)
        for (let i = 0; i < bufferArr2.length; i++) {
          if (bufferArr2[i] != flipV[i]) {
            res = false
            break
          }
        }
        expect(res).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_flipSync_Func_0020
     * @tc.name   : flipSync
     * @tc.desc   : Test Func flipSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_flipSync_Func_0020', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        pixelmap.flipSync(true, false)
        let res: boolean = true
        let pixelSize = pixelmap.getPixelBytesNumber()
        let readBuffer = new ArrayBuffer(pixelSize)
        pixelmap.readPixelsToBufferSync(readBuffer)
        let bufferArr2 = new Uint8Array(readBuffer)
        for (let i = 0; i < bufferArr2.length; i++) {
          if (bufferArr2[i] != flipH[i]) {
            res = false
            break
          }
        }
        expect(res).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_flipSync_Func_0030
     * @tc.name   : flipSync
     * @tc.desc   : Test Func flipSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_flipSync_Func_0030', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        pixelmap.flipSync(true, true)
        let res: boolean = true
        let pixelSize = pixelmap.getPixelBytesNumber()
        let readBuffer = new ArrayBuffer(pixelSize)
        pixelmap.readPixelsToBufferSync(readBuffer)
        let bufferArr2 = new Uint8Array(readBuffer)
        for (let i = 0; i < bufferArr2.length; i++) {
          if (bufferArr2[i] != flipV_H[i]) {
            res = false
            break
          }
        }
        expect(res).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_flipSync_Func_0040
     * @tc.name   : flipSync
     * @tc.desc   : Test Func flipSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_flipSync_Func_0040', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        pixelmap.flipSync(false, false)
        let res: boolean = true
        let pixelSize = pixelmap.getPixelBytesNumber()
        let readBuffer = new ArrayBuffer(pixelSize)
        pixelmap.readPixelsToBufferSync(readBuffer)
        let bufferArr2 = new Uint8Array(readBuffer)
        for (let i = 0; i < bufferArr2.length; i++) {
          if (bufferArr2[i] != flip[i]) {
            res = false
            break
          }
        }
        expect(res).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_cropSync_Func_0010
     * @tc.name   : cropSyncSync
     * @tc.desc   : Test Func cropSyncSync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_cropSync_Func_0010', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      let region: image.Region = {
        size: {
          height: 3, width: 3
        },
        x: 1, y: 1
      }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        pixelmap.cropSync(region)
        let res: boolean = true
        let pixelSize = pixelmap.getPixelBytesNumber()
        let readBuffer = new ArrayBuffer(pixelSize)
        pixelmap.readPixelsToBufferSync(readBuffer)
        let bufferArr2 = new Uint8Array(readBuffer)
        for (let i = 0; i < bufferArr2.length; i++) {
          if (bufferArr2[i] != crop3x3[i]) {
            res = false
            break
          }
        }
        expect(res).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_cropSync_Func_0020
     * @tc.name   : cropSyncSync
     * @tc.desc   : Test Func cropSyncSync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_PixelMap_cropSync_Func_0020', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }
      let region: image.Region = { size: { height: -1, width: -1 }, x: 1, y: 1 }
      try {
        let pixelmap = image.createPixelMapSync(color, initializationOptions)
        let pixelSize = pixelmap.getPixelBytesNumber()
        let readBuffer = new ArrayBuffer(pixelSize)
        let readBufferCheck = new ArrayBuffer(pixelSize)
        pixelmap.readPixelsToBufferSync(readBufferCheck)
        pixelmap.cropSync(region)
        pixelmap.readPixelsToBufferSync(readBuffer)
        let bufferArr2 = new Uint8Array(readBuffer)
        let bufferArr2Check = new Uint8Array(readBufferCheck)
        let res: boolean = true
        for (let i = 0; i < bufferArr2.length; i++) {
          if (bufferArr2[i] != bufferArr2Check[i]) {
            res = false
            break
          }
        }
        expect(res).assertTrue()
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_setColorSpace_Func_0010
     * @tc.name   : setColorSpace
     * @tc.desc   : Test Func setColorSpace Sync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_setColorSpace_Func_0010', 0, async (done: Function) => {
      let colorSpaceArray1: Array<colorSpaceManager.ColorSpace> = [colorSpaceManager.ColorSpace.ADOBE_RGB_1998,
        colorSpaceManager.ColorSpace.DCI_P3, colorSpaceManager.ColorSpace.DISPLAY_P3,
        colorSpaceManager.ColorSpace.SRGB, colorSpaceManager.ColorSpace.BT709,
        colorSpaceManager.ColorSpace.P3_PQ]
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }

      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      try {
        for (let i = 0; i < colorSpaceArray1.length; i++) {
          let colorSpaceManage = colorSpaceManager.create(colorSpaceArray1[i])
          pixelmap.setColorSpace(colorSpaceManage)
          expect(pixelmap.getColorSpace().getColorSpaceName()).assertEqual(colorSpaceManage.getColorSpaceName())
        }
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_setColorSpace_Func_0020
     * @tc.name   : setColorSpace
     * @tc.desc   : Test Func setColorSpace Sync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_setColorSpace_Func_0020', 0, async (done: Function) => {
      let colorSpaceArray2: Array<colorSpaceManager.ColorSpace> = [colorSpaceManager.ColorSpace.BT601_EBU,
        colorSpaceManager.ColorSpace.BT601_SMPTE_C, colorSpaceManager.ColorSpace.BT2020_HLG,
        colorSpaceManager.ColorSpace.BT2020_PQ, colorSpaceManager.ColorSpace.P3_HLG,
        colorSpaceManager.ColorSpace.ADOBE_RGB_1998_LIMIT]
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }

      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      try {
        for (let i = 0; i < colorSpaceArray2.length; i++) {
          let colorSpaceManage = colorSpaceManager.create(colorSpaceArray2[i])
          pixelmap.setColorSpace(colorSpaceManage)
          expect(pixelmap.getColorSpace().getColorSpaceName()).assertEqual(colorSpaceManage.getColorSpaceName())
        }
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_setColorSpace_Func_0030
     * @tc.name   : setColorSpace
     * @tc.desc   : Test Func setColorSpace Sync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_setColorSpace_Func_0030', 0, async (done: Function) => {
      let colorSpaceArray3: Array<colorSpaceManager.ColorSpace> = [colorSpaceManager.ColorSpace.DISPLAY_P3_LIMIT,
        colorSpaceManager.ColorSpace.SRGB_LIMIT, colorSpaceManager.ColorSpace.BT709_LIMIT,
        colorSpaceManager.ColorSpace.BT601_EBU_LIMIT, colorSpaceManager.ColorSpace.BT601_SMPTE_C_LIMIT,
        colorSpaceManager.ColorSpace.BT2020_HLG]
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }

      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      try {
        for (let i = 0; i < colorSpaceArray3.length; i++) {
          let colorSpaceManage = colorSpaceManager.create(colorSpaceArray3[i])
          pixelmap.setColorSpace(colorSpaceManage)
          expect(pixelmap.getColorSpace().getColorSpaceName()).assertEqual(colorSpaceManage.getColorSpaceName())
        }
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_setColorSpace_Func_0040
     * @tc.name   : setColorSpace
     * @tc.desc   : Test Func setColorSpace Sync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_setColorSpace_Func_0040', 0, async (done: Function) => {
      let colorSpaceArray4: Array<colorSpaceManager.ColorSpace> = [colorSpaceManager.ColorSpace.BT2020_PQ_LIMIT,
        colorSpaceManager.ColorSpace.P3_HLG_LIMIT, colorSpaceManager.ColorSpace.P3_PQ_LIMIT,
        colorSpaceManager.ColorSpace.LINEAR_P3, colorSpaceManager.ColorSpace.LINEAR_SRGB,
        colorSpaceManager.ColorSpace.LINEAR_BT709]
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }

      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      try {
        for (let i = 0; i < colorSpaceArray4.length; i++) {
          let colorSpaceManage = colorSpaceManager.create(colorSpaceArray4[i])
          pixelmap.setColorSpace(colorSpaceManage)
          expect(pixelmap.getColorSpace().getColorSpaceName()).assertEqual(colorSpaceManage.getColorSpaceName())
        }
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_setColorSpace_Func_0050
     * @tc.name   : setColorSpace
     * @tc.desc   : Test Func setColorSpace Sync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_setColorSpace_Func_0050', 0, async (done: Function) => {
      let colorSpaceArray5: Array<colorSpaceManager.ColorSpace> = [colorSpaceManager.ColorSpace.LINEAR_BT2020,
        colorSpaceManager.ColorSpace.DISPLAY_SRGB, colorSpaceManager.ColorSpace.DISPLAY_P3_SRGB,
        colorSpaceManager.ColorSpace.DISPLAY_P3_HLG, colorSpaceManager.ColorSpace.DISPLAY_P3_PQ]
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }

      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      try {
        for (let i = 0; i < colorSpaceArray5.length; i++) {
          let colorSpaceManage = colorSpaceManager.create(colorSpaceArray5[i])
          pixelmap.setColorSpace(colorSpaceManage)
          expect(pixelmap.getColorSpace().getColorSpaceName()).assertEqual(colorSpaceManage.getColorSpaceName())
        }
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_setColorSpace_Func_0060
     * @tc.name   : setColorSpace
     * @tc.desc   : Test Func setColorSpace Sync
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_PixelMap_setColorSpace_Func_0060', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }

      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      try {
        pixelmap.setColorSpace(undefined)
        expect().assertFail()
      } catch (err) {
        expect(err.code).assertEqual('62980115')
      }
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_getColorSpace_Func_0070
     * @tc.name   : getColorSpace
     * @tc.desc   : Test Func getColorSpace Sync
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_getColorSpace_Func_0070', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }

      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      try {
        let colorSpaceManage = colorSpaceManager.create(colorSpaceManager.ColorSpace.SRGB)
        pixelmap.setColorSpace(colorSpaceManage)
        expect(pixelmap.getColorSpace().getColorSpaceName()).assertEqual(colorSpaceManage.getColorSpaceName())
        await releasePixelmap(pixelmap)
      } catch (err) {
        console.info('try-catch err is ' + JSON.stringify(err))
        expect().assertFail()
      }
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_applyColorSpace_Func_0010
     * @tc.name   : applyColorSpace
     * @tc.desc   : Test Func applyColorSpace Callback
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_applyColorSpace_Func_0010', 0, async (done: Function) => {
      let colorSpaceArray: Array<colorSpaceManager.ColorSpace> = [colorSpaceManager.ColorSpace.SRGB,
        colorSpaceManager.ColorSpace.DCI_P3, colorSpaceManager.ColorSpace.DISPLAY_P3,
        colorSpaceManager.ColorSpace.ADOBE_RGB_1998]
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }

      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      for (let i = 0; i < colorSpaceArray.length; i++) {
        let colorSpaceManage = colorSpaceManager.create(colorSpaceArray[i])
        await (async (): Promise<void> => {
          return new Promise((resolve, reject) => {
            pixelmap.applyColorSpace(colorSpaceManage, (err) => {
              err == undefined ? resolve() : reject(err)
            })
          });
        })().then(async () => {
          expect(pixelmap.getColorSpace().getColorSpaceName()).assertEqual(colorSpaceManage.getColorSpaceName())
        }).catch((err: BusinessError) => {
          expect().assertFail()
        });
      }
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_applyColorSpace_Func_0020
     * @tc.name   : applyColorSpace
     * @tc.desc   : Test Func applyColorSpace Callback
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_PixelMap_applyColorSpace_Func_0020', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }

      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      await (async (): Promise<void> => {
        return new Promise((resolve, reject) => {
          pixelmap.applyColorSpace(undefined, (err) => {
            err == undefined ? resolve() : reject(err)
          })
        });
      })().then(async () => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain("62980115")
      });
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_applyColorSpace_Func_0030
     * @tc.name   : applyColorSpace
     * @tc.desc   : Test Func applyColorSpace Promise
     * @tc.level  : Level 0
     */
    it('SUB_ARKUIX_PixelMap_applyColorSpace_Func_0030', 0, async (done: Function) => {
      let colorSpaceArray: Array<colorSpaceManager.ColorSpace> = [colorSpaceManager.ColorSpace.SRGB,
        colorSpaceManager.ColorSpace.DCI_P3, colorSpaceManager.ColorSpace.DISPLAY_P3,
        colorSpaceManager.ColorSpace.ADOBE_RGB_1998]
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }

      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      for (let i = 0; i < colorSpaceArray.length; i++) {
        let colorSpaceManage = colorSpaceManager.create(colorSpaceArray[i])
        await pixelmap.applyColorSpace(colorSpaceManage).then(() => {
          expect(pixelmap.getColorSpace().getColorSpaceName()).assertEqual(colorSpaceManage.getColorSpaceName())
        }).catch((err: BusinessError) => {
          console.info('err is ' + JSON.stringify(err))
          expect().assertFail()
        })
      }
      await releasePixelmap(pixelmap)
      done()
    })

    /**
     * @tc.number : SUB_ARKUIX_PixelMap_applyColorSpace_Func_0040
     * @tc.name   : applyColorSpace
     * @tc.desc   : Test Func applyColorSpace Promise
     * @tc.level  : Level 2
     */
    it('SUB_ARKUIX_PixelMap_applyColorSpace_Func_0040', 0, async (done: Function) => {
      let color = new ArrayBuffer(96)
      let bufferArr = new Uint8Array(color)
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1
      }
      let size: image.Size = { height: 4, width: 6 }
      let initializationOptions: image.InitializationOptions = {
        editable: true,
        pixelFormat: image.PixelMapFormat.RGBA_8888,
        size: size,
      }

      let pixelmap = image.createPixelMapSync(color, initializationOptions)
      await pixelmap.applyColorSpace(undefined).then(() => {
        expect().assertFail()
      }).catch((err: BusinessError) => {
        expect(JSON.stringify(err)).assertContain("62980115")
      })
      await releasePixelmap(pixelmap)
      done()
    })

  })
}