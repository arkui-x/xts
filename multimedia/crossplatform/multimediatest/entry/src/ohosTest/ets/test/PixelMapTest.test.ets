/*
 * Copyright (C) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the 'License');
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an 'AS IS' BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import image from '@ohos.multimedia.image';
import { afterEach, beforeAll, describe, expect, it, Level, Size, TestType } from '@ohos/hypium';
import hilog from '@ohos.hilog';
import { BusinessError } from '@ohos.base';
import fs from '@ohos.file.fs';

let isSupportHdr: boolean;

interface HdrPicture {
  uri: string,
  fd: number,
  fileSize: number,
  fileData: ArrayBuffer
}

export default function PixelMapTest() {
  describe('image10bitPixelMap', () => {
    let globalPacker: image.ImagePacker | undefined;
    let globalPixelMap: image.PixelMap | undefined;
    let filesDir: string | undefined;
    let openHdrPic: HdrPicture;

    beforeAll(async () => {
      filesDir = AppStorage.get('pathDir');
      isSupportHdr = await fs.access('/system/lib64/ndk/libvideo_processing_capi_impl.so').then((res: boolean) => {
        if (res) {
          console.info("file exists");
          return true;
        } else {
          console.info("file not exists");
          return false;
        }
      }).catch((err: BusinessError) => {
        console.error("access failed with error message: " + err.message + ", error code: " + err.code);
        return false;
      })
    })
    afterEach(() => {
      if (globalPixelMap != undefined) {
        hilog.info(0x0000, '10bitPixelMap', '%{public}s', 'afterEach case');
        try {
          globalPixelMap.release();
          globalPixelMap = undefined;
        } catch (error) {
          hilog.info(0x0000, '10bitPixelMap', '%{public}s', 'pixelMap release fail');
        }
      }
      if (globalPacker != undefined) {
        hilog.info(0x0000, '10bitPixelMap', '%{public}s', 'globalPacker release start');
        try {
          globalPacker.release();
        } catch (error) {
          hilog.info(0x0000, '10bitPixelMap', '%{public}s', 'globalPacker release fail');
        }
      }
      try {
        fs.closeSync(openHdrPic.fd)
      } catch (error) {
        hilog.info(0x0000, '10bitPixelMap', '%{public}s', 'fileDescriptor close failed. ' + error);
      }
      hilog.info(0x0000, '10bitPixelMap', '%{public}s', 'after each case');
    })

    class Logger {
      testNum: string;

      constructor(testNum: string) {
        this.testNum = testNum;
      }

      log(msg: string) {
        hilog.info(0x0000, "image10bitPixelMap", 'case: %{public}s msg:%{public}s', this.testNum, msg);
      }
    }


    let sleep = async (delay: number): Promise<void> => {
      return new Promise((resolve, _) => {
        setTimeout(async () => {
          resolve();
        }, delay);
      });
    };

    const calculateBufferSize = (height: number, width: number, format: image.PixelMapFormat) => {
      switch (format) {
        case image.PixelMapFormat.UNKNOWN:
          return height * width * 4;
        case image.PixelMapFormat.UNKNOWN:
        case image.PixelMapFormat.UNKNOWN:
          return (height * width + ((height + 1) / 2 * (width + 1) / 2) * 2) * 2;
        default:
          return 0;
      }
    }

    const testCreatePixelMap = async (fileName: string, expectFormat: image.PixelMapFormat): Promise<PixelMap> => {
      if (isSupportHdr) {
        return testImageSourceCreatePixelMap(fileName, expectFormat);
      } else {
        return createPixelMapByPixelFormat(expectFormat);
      }
    }

    const createPixelMapByPixelFormat = async (srcPixelFormat: image.PixelMapFormat): Promise<PixelMap> => {
      let color = new ArrayBuffer(calculateBufferSize(4, 6, srcPixelFormat));
      let bufferArr = new Uint8Array(color);
      for (let i = 0; i < bufferArr.length; i++) {
        bufferArr[i] = i + 1;
      }

      let opts: image.InitializationOptions = {
        editable: true,
        pixelFormat: srcPixelFormat,
        size: { height: 4, width: 6 }
      }
      return image.createPixelMapSync(color, opts);
    }

    const getBuffer = async (fileName: string) => {
      let filePath = filesDir + '/' + fileName;
      let file = fs.openSync(filePath);
      const stats = fs.statSync(filePath);
      const fileSize = stats.size;
      const bufferRead = new ArrayBuffer(fileSize)
      fs.readSync(file.fd, bufferRead)
      openHdrPic = {
        uri: filePath,
        fd: file.fd,
        fileSize: fileSize,
        fileData: bufferRead
      }
      return bufferRead
    }

    const testImageSourceCreatePixelMap =
      async (file: string | number | ArrayBuffer, desiredFormat: image.PixelMapFormat) => {
        let imageSource: image.ImageSource;
        if (typeof file == 'string') {
          let buffer = await getBuffer(file);
          imageSource = image.createImageSource(buffer);
        } else if (typeof file == 'number') {
          imageSource = image.createImageSource(file);
        } else {
          imageSource = image.createImageSource(file);
        }
        let decodingOpt: image.DecodingOptions = {
          editable: true,
          desiredPixelFormat: desiredFormat,
        }
        let pixelMap = await imageSource.createPixelMap(decodingOpt);
        return pixelMap;
      }

    const opacityTest = async (done: Function, testNum: string, type: string, fileName: string) => {
      let logger = new Logger(testNum)
      try {
        let pixelMap = await testCreatePixelMap(fileName, image.PixelMapFormat.UNKNOWN);
        logger.log("pixelMap " + (pixelMap != undefined));
        if (pixelMap != undefined) {
          globalPixelMap = pixelMap;
          if (type == 'callback') {
            pixelMap.opacity(0.8, (err) => {
              if (err != undefined) {
                expect(false).assertTrue();
                logger.log('set alpha failed');
              } else {
                logger.log('set alpha success');
              }
              done();
            })
          } else if (type == 'promise') {
            try {
              await pixelMap.opacity(0.8);
              logger.log('set alpha success.');
              done();
            } catch (error) {
              logger.log('set alpha failed. error: ' + error);
              expect(false).assertTrue();
              done();
            }
          } else {
            try {
              pixelMap.opacitySync(0.8)
              logger.log('set alpha success.');
              done();
            } catch (error) {
              logger.log('set alpha failed. error: ' + error);
              expect(false).assertTrue();
              done();
            }
          }
        } else {
          logger.log('creat pixelMap failed');
          expect(false).assertTrue();
          done();
        }
      } catch (error) {
        logger.log('failed ' + error);
        expect(false).assertTrue();
        done();
      }
    }

    const checkPixelMapInterface = async (done: Function, logger: Logger, pixelMap: image.PixelMap,
      orgInfo: image.ImageInfo, sizeCheck: Function) => {
      let newInfo = await pixelMap.getImageInfo()
      sizeCheck(done, logger, orgInfo, newInfo)
      done();
    }

    const pixelMapModifySizeTest = async (done: Function, testNum: string, type: string, pixelMapInterface: string,
      fileName: string, format: image.PixelMapFormat, sizeCheck: Function,
      ...params: Object[]) => {
      let logger = new Logger(testNum);
      try {
        let pixelMap = await testCreatePixelMap(fileName, format)

        logger.log("pixelMap " + (pixelMap != undefined));
        if (pixelMap != undefined) {
          globalPixelMap = pixelMap;
          let orgInfo = await pixelMap.getImageInfo()
          logger.log(`orgInfo.pixelFormat : ` + orgInfo.pixelFormat);
          logger.log(`format : ` + format);
          if (type == 'callback') {
            pixelMap[pixelMapInterface](...params, async () => {
              await checkPixelMapInterface(done, logger, pixelMap, orgInfo, sizeCheck)
            })
          } else if (type == 'promise') {
            await pixelMap[pixelMapInterface](...params);
            await checkPixelMapInterface(done, logger, pixelMap, orgInfo, sizeCheck)
          } else {
            pixelMap[pixelMapInterface](...params);
            await checkPixelMapInterface(done, logger, pixelMap, orgInfo, sizeCheck)
          }
        } else {
          logger.log('create pixelMap failed');
          expect(false).assertTrue();
          done();
        }
      } catch (error) {
        logger.log('failed ' + error);
        expect(false).assertTrue();
        done();
      }
    }
    /**
     * @tc.number    : SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_0100
     * @tc.name      : testOpacityPromise0001
     * @tc.desc      : 1. Create a pixelmap
     *               : 2. Call opacity with promise
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testOpacityPromise0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      if (!isSupportHdr) {
        hilog.info(0x0000, "image10bitPixelMap", 'case: %{public}s msg:%{public}s',
          'SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_0100', 'device is not support hdr');
        done();
      } else {
        await opacityTest(done, 'SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_0100', 'promise', "CUVAHdrMulti.jpg");
      }
    });

    /**
     * @tc.number    : SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_0200
     * @tc.name      : testOpacityCallback0001
     * @tc.desc      : 1. Create a pixelmap
     *               : 2. Call opacity with callback
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testOpacityCallback0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      await opacityTest(done, 'SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_0200', 'callback',
        "HDRVividSingleLayer.heic");
    });

    /**
     * @tc.number    : SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_0300
     * @tc.name      : testScalePromise0001
     * @tc.desc      : 1. Create a pixelmap
     *               : 2. Call scale with promise
     *               : 3. Get pixel bytes number
     *               : 4. Read pixels to buffer
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testScalePromise0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let sizeCheck = (done: Function, logger: Logger, orgInfo: image.ImageInfo, newInfo: image.ImageInfo) => {
        if (newInfo.size.width !== orgInfo.size.width * 2) {
          logger.log(`org width ${orgInfo.size.width}, new width ${newInfo.size.width}`);
          expect(false).assertTrue();
          done();
        }
      };
      await pixelMapModifySizeTest(done, 'SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_0300',
        'promise', 'scale', "CUVAHdrMulti.jpg", image.PixelMapFormat.UNKNOWN, sizeCheck, 2.0, 1.0);

    });
    
    /**
     * @tc.number    : SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_0400
     * @tc.name      : testScalePromise0002
     * @tc.desc      : 1. Create a pixelmap
     *               : 2. Call scale with promise and anti-aliasing
     *               : 3. Get pixel bytes number
     *               : 4. Read pixels to buffer
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testScalePromise0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let sizeCheck = (done: Function, logger: Logger, orgInfo: image.ImageInfo, newInfo: image.ImageInfo) => {
        if (newInfo.size.width !== orgInfo.size.width * 2) {
          logger.log(`org width ${orgInfo.size.width}, new width ${newInfo.size.width}`);
          expect(false).assertTrue();
          done();
        }
      };
      await pixelMapModifySizeTest(done, 'SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_0400',
        'promise', 'scale', "CUVAHdrMulti.jpg", image.PixelMapFormat.UNKNOWN, sizeCheck, 2.0, 1.0, 1);
    });

    /**
     * @tc.number    : SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_0500
     * @tc.name      : testScaleCallback0001
     * @tc.desc      : 1. Create a pixelmap
     *               : 2. Call scale with callback
     *               : 3. Get pixel bytes number
     *               : 4. Read pixels to buffer
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testScaleCallback0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let sizeCheck = (done: Function, logger: Logger, orgInfo: image.ImageInfo, newInfo: image.ImageInfo) => {
        if (newInfo.size.width !== orgInfo.size.width * 2) {
          logger.log(`org width ${orgInfo.size.width}, new width ${newInfo.size.width}`);
          expect(false).assertTrue();
          done();
        }
      };
      await pixelMapModifySizeTest(done, 'SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_0500',
        'callback', 'scale', "HDRVividSingleLayer.heic", image.PixelMapFormat.UNKNOWN, sizeCheck, 2.0, 1.0);
    });

    /**
     * @tc.number    : SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_0600
     * @tc.name      : testScaleSync0001
     * @tc.desc      : 1. Create a pixelmap
     *               : 2. Call scaleSync
     *               : 3. Get pixel bytes number
     *               : 4. Read pixels to buffer
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testScaleSync0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let sizeCheck = (done: Function, logger: Logger, orgInfo: image.ImageInfo, newInfo: image.ImageInfo) => {
        if (newInfo.size.width !== orgInfo.size.width * 2) {
          logger.log(`org width ${orgInfo.size.width}, new width ${newInfo.size.width}`);
          expect(false).assertTrue();
          done();
        }
      };
      await pixelMapModifySizeTest(done, 'SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_0600',
        'sync', 'scaleSync', "HDRVividSingleLayer.heic", image.PixelMapFormat.UNKNOWN, sizeCheck, 2.0, 1.0, 1);
    });

    /**
     * @tc.number    : SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_0700
     * @tc.name      : testTranslatePromise0001
     * @tc.desc      : 1. Create a pixelmap
     *               : 2. Call translate with promise
     *               : 3. Get pixel bytes number
     *               : 4. Read pixels to buffer
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testTranslatePromise0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let sizeCheck = (done: Function, logger: Logger, orgInfo: image.ImageInfo, newInfo: image.ImageInfo) => {
        logger.log(`org width ${orgInfo.size.width}, new width ${newInfo.size.width}`);
        if (newInfo.size.width !== orgInfo.size.width + 3) {
          expect(false).assertTrue();
          done();
        }
      };
      await pixelMapModifySizeTest(done, 'SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_0700',
        'promise', 'translate', "CUVAHdrMulti.jpg", image.PixelMapFormat.UNKNOWN, sizeCheck, 3.0, 1.0);
    });

    /**
     * @tc.number    : SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_0800
     * @tc.name      : testTranslateCallback0001
     * @tc.desc      : 1. Create a pixelmap
     *               : 2. Call translate with callback
     *               : 3. Get pixel bytes number
     *               : 4. Read pixels to buffer
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testTranslateCallback0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let sizeCheck = (done: Function, logger: Logger, orgInfo: image.ImageInfo, newInfo: image.ImageInfo) => {
        if (newInfo.size.width !== orgInfo.size.width + 3) {
          logger.log(`org width ${orgInfo.size.width}, new width ${newInfo.size.width}`);
          expect(false).assertTrue();
          done();
        }
      };
      await pixelMapModifySizeTest(done, 'SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_0800',
        'callback', 'translate', "HDRVividSingleLayer.heic", image.PixelMapFormat.UNKNOWN, sizeCheck, 3.0, 1.0);
    });

    /**
     * @tc.number    : SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_0900
     * @tc.name      : testRotatePromise0001
     * @tc.desc      : 1. Create a pixelmap
     *               : 2. Call rotate with promise
     *               : 3. Get pixel bytes number
     *               : 4. Read pixels to buffer
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testRotatePromise0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let sizeCheck = (done: Function, logger: Logger, orgInfo: image.ImageInfo, newInfo: image.ImageInfo) => {
        if (newInfo.size.width !== orgInfo.size.height) {
          logger.log(`org height ${orgInfo.size.height}, new width ${newInfo.size.width}`);
          expect(false).assertTrue();
          done();
        }
      };
      await pixelMapModifySizeTest(done, 'SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_0900',
        'promise', 'rotate', "CUVAHdrMulti.jpg", image.PixelMapFormat.UNKNOWN, sizeCheck, 90.0);
    });

    /**
     * @tc.number    : SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_1000
     * @tc.name      : testRotateCallback0001
     * @tc.desc      : 1. Create a pixelmap
     *               : 2. Call rotate with callback
     *               : 3. Get pixel bytes number
     *               : 4. Read pixels to buffer
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testRotateCallback0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let sizeCheck = (done: Function, logger: Logger, orgInfo: image.ImageInfo, newInfo: image.ImageInfo) => {
        if (newInfo.size.width !== orgInfo.size.height) {
          logger.log(`org height ${orgInfo.size.height}, new width ${newInfo.size.width}`);
          expect(false).assertTrue();
          done();
        }
      };
      await pixelMapModifySizeTest(done, 'SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_1000',
        'callback', 'rotate', "HDRVividSingleLayer.heic", image.PixelMapFormat.UNKNOWN, sizeCheck, 90.0);
    });

    /**
     * @tc.number    : SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_1100
     * @tc.name      : testFlipPromise0001
     * @tc.desc      : 1. Create a pixelmap
     *               : 2. Call flip with promise
     *               : 3. Get pixel bytes number
     *               : 4. Read pixels to buffer
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFlipPromise0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let sizeCheck = (done: Function, logger: Logger, orgInfo: image.ImageInfo, newInfo: image.ImageInfo) => {
        if (newInfo.size.width !== orgInfo.size.width) {
          logger.log(`org width ${orgInfo.size.width}, new width ${newInfo.size.width}`);
          expect(false).assertTrue();
          done();
        }
      };
      await pixelMapModifySizeTest(done, 'SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_1100',
        'promise', 'flip', "CUVAHdrMulti.jpg", image.PixelMapFormat.UNKNOWN, sizeCheck, false, true);
    });

    /**
     * @tc.number    : SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_1200
     * @tc.name      : testFlipCallback0001
     * @tc.desc      : 1. Create a pixelmap
     *               : 2. Call flip with callback
     *               : 3. Get pixel bytes number
     *               : 4. Read pixels to buffer
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testFlipCallback0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let sizeCheck = (done: Function, logger: Logger, orgInfo: image.ImageInfo, newInfo: image.ImageInfo) => {
        if (newInfo.size.width !== orgInfo.size.width) {
          logger.log(`org width ${orgInfo.size.width}, new width ${newInfo.size.width}`);
          expect(false).assertTrue();
          done();
        }
      };
      await pixelMapModifySizeTest(done, 'SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_1200',
        'callback', 'flip', "HDRVividSingleLayer.heic", image.PixelMapFormat.UNKNOWN, sizeCheck, false, true);
    });

    /**
     * @tc.number    : SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_1300
     * @tc.name      : testCropPromise0001
     * @tc.desc      : 1. Create a PixelMap
     *               : 2. Call crop with promise
     *               : 3. getImageInfo
     *               : 4. getPixelBytesNumber
     *               : 5. readPixelsToBuffer
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testCropPromise0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let region: image.Region = { size: { height: 3, width: 3 }, x: 1, y: 1 };
      let sizeCheck = (done: Function, logger: Logger, orgInfo: image.ImageInfo, newInfo: image.ImageInfo) => {
        if (newInfo.size.width !== region.size.width) {
          logger.log(`region width ${region.size.width}, new width ${newInfo.size.width}`);
          expect(false).assertTrue();
          done();
        }
      };
      await pixelMapModifySizeTest(done, 'SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_1300',
        'promise', 'crop', "CUVAHdrMulti.jpg", image.PixelMapFormat.UNKNOWN, sizeCheck, region);
    });

    /**
     * @tc.number    : SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_1400
     * @tc.name      : testCropCallback0001
     * @tc.desc      : 1. Create a PixelMap
     *               : 2. Call crop with callback
     *               : 3. Get image info
     *               : 4. Get pixel bytes number
     *               : 5. Read pixels to buffer
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testCropCallback0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let region: image.Region = { size: { height: 3, width: 3 }, x: 1, y: 1 };
      let sizeCheck = (done: Function, logger: Logger, orgInfo: image.ImageInfo, newInfo: image.ImageInfo) => {
        if (newInfo.size.width !== region.size.width) {
          logger.log(`region width ${region.size.width}, new width ${newInfo.size.width}`);
          expect(false).assertTrue();
          done();
        }
      };
      await pixelMapModifySizeTest(done, 'SUB_MULTIMEDIA_IMAGE_PIXELMAPADAPTION_10bit_1400',
        'callback', 'crop', "HDRVividSingleLayer.heic", image.PixelMapFormat.UNKNOWN, sizeCheck, region);
    });
  })
}