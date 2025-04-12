/*
 * Copyright (C) 2023-2025 Huawei Device Co., Ltd.
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

import image from "@ohos.multimedia.image";
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium'
import { testPng, testJpg } from './testImg'
import {
    scale2x1,
    translate3x1,
    rotate90,
    flipH,
    testBmp,
    testGif,
    crop3x3,
    scale1x4,
    setAlpha8,
    translate1x3
} from './testImg2'
import { tcBuf020, tcBuf020_1, tcBuf021, tcBuf021_1, tcBuf022 } from './testImg'
import { BusinessError } from "@kit.BasicServicesKit";
import common from '@ohos.app.ability.common';

async function sleep(ms: number): Promise<void> {
    return new Promise(resolve => setTimeout(resolve, ms));
}

export default function PixelMap() {
    describe("PixelMap", () => {
        let globalpixelmap: image.PixelMap;
        beforeAll(async () => {
            console.info("beforeAll case");
        });

        beforeEach(async () => {
            console.info("beforeEach case");
            await sleep(500);
        });

        afterEach(async () => {
            console.info('afterEach case');
            if (globalpixelmap != undefined) {
                console.info('globalpixelmap release start');
                try {
                    await globalpixelmap.release();
                } catch (error) {
                    console.info('globalpixelmap release fail');
                }
            }

            await sleep(1000);
        });

        afterAll(async () => {
            console.info("afterAll case");
        });

        class loger {
            private myName: string;

            constructor(caseName: string) {
                this.myName = caseName;
            }

            log(msg: string): void {
                console.info(this.myName + ' ' + msg);
            }
        }

        let genPixelMap = async () => {
            let color = new ArrayBuffer(96);
            let bufferArr = new Uint8Array(color);
            for (let i = 0; i < bufferArr.length; i++) {
                bufferArr[i] = i + 1;
            }

            let opts: image.InitializationOptions = {
                editable: true, pixelFormat: 3, size: {
                    height: 4, width: 6
                }
            }
            return image.createPixelMap(color, opts);
        }

        let getDensityTest = async (done: Function, testNum: string, imageData: ArrayBufferLike,
            decodingOptions?: image.DecodingOptions) => {
            let logger: loger = new loger(testNum);
            try {
                let sourceOptions: image.SourceOptions = {
                    sourceDensity: 120
                };
                let imageSource = image.createImageSource(imageData, sourceOptions);
                if (imageSource != undefined) {
                    let pixelMap = await imageSource.createPixelMap(decodingOptions);
                    if (pixelMap != undefined) {
                        let density = pixelMap.getDensity();
                        expect(decodingOptions ? (density == 240) : (density == 120)).assertTrue();
                        done();
                    } else {
                        logger.log(`${testNum} failed`);
                        expect(false).assertTrue();
                        done();
                    }
                } else {
                    logger.log(`${testNum} failed`);
                    expect(false).assertTrue();
                    done();
                }
            } catch (error) {
                logger.log(`${testNum} failed` + error);
                expect(false).assertTrue();
                done();
            }
        }

        let opacityErr = async (done: Function, testNum: string, param: number, type: string) => {
            let logger: loger = new loger(testNum);
            try {
                let pixelMap = await genPixelMap();
                logger.log("pixelMap " + (pixelMap != undefined));
                if (pixelMap != undefined) {
                    if (type == 'callback') {
                        pixelMap.opacity(param, (error) => {
                            if (error) {
                                expect(true).assertTrue();
                                done();
                            } else {
                                expect(false).assertTrue();
                                done();
                            }
                        })
                    } else {
                        try {
                            await pixelMap.opacity(param)
                            expect(false).assertTrue();
                            logger.log('failed');
                            done();
                        } catch (error) {
                            expect(true).assertTrue();
                            logger.log('success');
                            done();
                        }
                    }
                } else {
                    logger.log('create pixelMap failed ');
                    expect(false).assertTrue();
                    done();
                }
            } catch (error) {
                logger.log('failed ' + error);
                expect(false).assertTrue();
                done();
            }
        }

        let checkAlphaPixelmap = async (done: Function, testNum: string, alphaPixelMap: image.PixelMap) => {
            let logger: loger = new loger(testNum);
            logger.log("AlphaPixelMap " + alphaPixelMap);
            if (alphaPixelMap != undefined) {
                let imageInfo: image.ImageInfo = await alphaPixelMap.getImageInfo();
                logger.log("AlphaPixelMap pixelformat " + imageInfo.pixelFormat);
                expect(imageInfo.pixelFormat == 6).assertTrue();
                done();
            } else {
                logger.log('create alphaPixelMap failed');
                expect(false).assertTrue();
                done();
            }
        }

        let createAlphaPixelmapTest =
            async (done: Function, testNum: string, type: string, imageData: ArrayBufferLike) => {
                let logger: loger = new loger(testNum);
                try {
                    let imageSource = image.createImageSource(imageData);
                    logger.log("ImageSource " + (imageSource != undefined));
                    if (imageSource != undefined) {
                        let pixelMap = await imageSource.createPixelMap();
                        logger.log("PixelMap " + pixelMap);
                        if (pixelMap != undefined) {
                            if (type == 'callback') {
                                pixelMap.createAlphaPixelmap(async (err, alphaPixelMap) => {
                                    await checkAlphaPixelmap(done, testNum, alphaPixelMap)
                                })
                            } else {
                                let alphaPixelMap = await pixelMap.createAlphaPixelmap();
                                await checkAlphaPixelmap(done, testNum, alphaPixelMap)
                            }
                        } else {
                            logger.log('create pixelMap failed');
                            expect(false).assertTrue();
                            done();
                        }
                    } else {
                        logger.log('create ImageSource failed');
                        expect(false).assertTrue();
                        done();
                    }
                } catch (error) {
                    logger.log('failed ' + error);
                    expect(false).assertTrue();
                    done();
                }
            }

        let scaleErr = async (done: Function, testNum: string, scaleX: number, scaleY: number) => {
            let logger: loger = new loger(testNum);
            let pixelMap = await genPixelMap();
            logger.log("pixelMap " + (pixelMap != undefined));
            if (pixelMap != undefined) {
                logger.log(testNum + 'create pixelMap success');
                expect(true).assertTrue();
                done();
            } else {
                logger.log(testNum + 'create pixelMap fail');
                expect(false).assertTrue();
                done();
            }

            try {
                logger.log('X is : ' + scaleX);
                logger.log('Y is : ' + scaleY);
                let orgInfo = await pixelMap.getImageInfo();
                await pixelMap.scale(scaleX, scaleY);
                let newInfo = await pixelMap.getImageInfo();
                expect(newInfo.size.height).assertEqual(orgInfo.size.height);
                expect(newInfo.size.width).assertEqual(orgInfo.size.width);
                done();
            } catch (error) {
                logger.log(testNum + 'expected case failure success');
                expect(true).assertTrue();
                done();
            }
        }

        let scaleCbErr = async (done: Function, testNum: string, scaleX: number, scaleY: number) => {
            let logger: loger = new loger(testNum);
            let pixelMap = await genPixelMap();
            logger.log("pixelMap " + (pixelMap != undefined));
            if (pixelMap != undefined) {
                logger.log(testNum + 'create pixelMap success');
                expect(true).assertTrue();
                done();
            } else {
                logger.log(testNum + 'create pixelMap fail');
                expect(false).assertTrue();
                done();
            }

            try {
                pixelMap.scale(scaleX, scaleY, (err: BusinessError) => {
                    if (err) {
                        logger.log(testNum + 'expected case failure success');
                        expect(true).assertTrue();
                        done();
                    } else {
                        logger.log(testNum + 'expected case failure fail');
                        expect(false).assertTrue();
                        done();
                    }
                })
            } catch (error) {
                logger.log(testNum + 'failed ' + error);
                expect(false).assertTrue();
                done();
            }
        }

        let translateErr = async (done: Function, testNum: string, translateX: number, translateY: number) => {
            let logger: loger = new loger(testNum);
            let pixelMap = await genPixelMap();
            logger.log("pixelMap " + (pixelMap != undefined));

            try {
                let orgInfo = await pixelMap.getImageInfo();
                await pixelMap.translate(translateX, translateY);
                let newInfo = await pixelMap.getImageInfo();
                expect(newInfo.size.height).assertEqual(orgInfo.size.height);
                expect(newInfo.size.width).assertEqual(orgInfo.size.width);
                logger.log(testNum + 'expected translate failure fail');
                expect(false).assertTrue();
                done();
            } catch (error) {
                logger.log(testNum + 'expected translate failure success');
                expect(true).assertTrue();
                done();
            }
        }

        let translateCbErr = async (done: Function, testNum: string, translateX: number, translateY: number) => {
            let logger: loger = new loger(testNum);
            try {
                let pixelMap = await genPixelMap();
                logger.log("pixelMap " + (pixelMap != undefined));
                if (pixelMap != undefined) {
                    logger.log('create pixelMap success');
                    pixelMap.translate(translateX, translateY, (err: BusinessError) => {
                        if (err) {
                            logger.log(testNum + 'expected case failure success');
                            expect(true).assertTrue();
                            done();
                        } else {
                            logger.log(testNum + 'expected case failure fail');
                            expect(false).assertTrue();
                            done();
                        }
                    })
                    done();
                } else {
                    logger.log('create pixelMap fail');
                    expect(false).assertTrue();
                }
                done();
            } catch (error) {
                logger.log(testNum + ' success');
                expect(true).assertTrue();
                done();
            }
        }

        let rotateErr = async (done: Function, testNum: string, angle: number) => {
            let logger: loger = new loger(testNum);
            let pixelMap = await genPixelMap();
            logger.log("pixelMap " + (pixelMap != undefined));
            if (pixelMap != undefined) {
                logger.log(testNum + 'create pixelMap success');
                expect(true).assertTrue();
                done();
            } else {
                logger.log(testNum + 'create pixelMap fail');
                expect(false).assertTrue();
                done();
            }

            try {
                await pixelMap.rotate(angle);
                logger.log(testNum + 'expected rotate failure fail');
                expect(false).assertTrue();
                done();
            } catch (error) {
                logger.log(testNum + 'expected rotate failure success');
                expect(true).assertTrue();
                done();
            }
        }

        let rotateCbErr = async (done: Function, testNum: string, rotate: number) => {
            let logger: loger = new loger(testNum);
            try {
                let pixelMap = await genPixelMap();
                logger.log("pixelMap " + (pixelMap != undefined));
                if (pixelMap != undefined) {
                    logger.log('create pixelMap success');
                    expect(true).assertTrue();
                    pixelMap.rotate(rotate, (err: BusinessError) => {
                        if (err) {
                            logger.log(testNum + 'expected case failure success');
                            expect(true).assertTrue();
                            done();
                        } else {
                            logger.log(testNum + 'expected case failure fail');
                            expect(false).assertTrue();
                            done();
                        }
                    })
                } else {
                    logger.log('create pixelMap fail');
                    expect(false).assertTrue();
                    done();
                }
            } catch (error) {
                logger.log(testNum + ' success');
                expect(true).assertTrue();
                done();
            }
        }

        let flipErr = async (done: Function, testNum: string, horizontal: boolean, vertical: boolean) => {
            let logger: loger = new loger(testNum);
            let pixelMap = await genPixelMap();
            logger.log("pixelMap " + (pixelMap != undefined));

            try {
                await pixelMap.flip(horizontal, vertical);
                logger.log(testNum + 'expect flip failure fail');
                expect(false).assertTrue();
                done();
            } catch (error) {
                logger.log(testNum + 'expect flip failure success');
                expect(true).assertTrue();
                done();
            }
        }

        let flipCbErr = async (done: Function, testNum: string, horizontal: boolean, vertical: boolean) => {
            let logger: loger = new loger(testNum);
            try {
                let pixelMap = await genPixelMap();
                logger.log("pixelMap " + (pixelMap != undefined));
                if (pixelMap != undefined) {
                    logger.log('create pixelMap success');
                    expect(true).assertTrue();
                    pixelMap.flip(horizontal, vertical, (err: BusinessError) => {
                        if (err) {
                            logger.log(testNum + 'expected case failure success');
                            expect(true).assertTrue();
                            done();
                        } else {
                            logger.log(testNum + 'expected case failure fail');
                            expect(false).assertTrue();
                            done();
                        }
                    })
                } else {
                    logger.log('create pixelMap fail');
                    expect(false).assertTrue();
                    done();
                }
            } catch (error) {
                logger.log(testNum + ' success');
                expect(true).assertTrue();
                done();
            }
        }

        let cropErr = async (done: Function, testNum: string, region: image.Region) => {
            let logger: loger = new loger(testNum);
            let pixelMap = await genPixelMap();
            logger.log("pixelMap " + (pixelMap != undefined));

            try {
                await pixelMap.crop(region);
                logger.log(testNum + 'expected crop failure fail');
                expect(false).assertTrue();
                done();
            } catch (error) {
                logger.log(testNum + 'expected crop failure success');
                expect(true).assertTrue();
                done();
            }
        }

        let cropCbErr = async (done: Function, testNum: string, region: image.Region) => {
            let logger: loger = new loger(testNum);
            try {
                let pixelMap = await genPixelMap();
                logger.log("pixelMap " + (pixelMap != undefined));
                if (pixelMap != undefined) {
                    logger.log('create pixelMap success');
                    expect(true).assertTrue();
                    pixelMap.crop(region, (err: BusinessError) => {
                        if (err) {
                            logger.log(testNum + 'expected case failure success');
                            expect(true).assertTrue();
                            done();
                        } else {
                            logger.log(testNum + 'expected case failure fail');
                            expect(false).assertTrue();
                            done();
                        }
                    })
                } else {
                    logger.log('create pixelMap fail');
                    expect(false).assertTrue();
                    done();
                }
            } catch (error) {
                logger.log(testNum + ' success');
                expect(true).assertTrue();
                done();
            }
        }

        /**
         * @tc.number    : TEST_ISEDITABLE_001
         * @tc.name      : testIsEditable001
         * @tc.desc      : 1.create pixelmap
         *                 2.call isEditable
         *                 3.return true
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 1
         */
        it('testIsEditable001', 0, async (done: Function) => {
            let logger: loger = new loger('testIsEditable001');
            const Color = new ArrayBuffer(96);
            let opts: image.InitializationOptions = {
                editable: true, pixelFormat: image.PixelMapFormat.RGBA_8888,
                size: {
                    height: 4, width: 6
                }
            }
            image.createPixelMap(Color, opts, (error, pixelmap) => {
                if (pixelmap == undefined) {
                    logger.log('testIsEditable001 create pixelmap failed');
                    expect(false).assertTrue();
                    done();
                } else {
                    expect(pixelmap.isEditable == true).assertTrue();
                    logger.log('testIsEditable001 success ');
                    done();
                }
            })
        })

        /**
         * @tc.number    : TEST_ISEDITABLE_002
         * @tc.name      : testIsEditable002
         * @tc.desc      : 1.create pixelmap
         *                 2.call isEditable
         *                 3.return false
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 1
         */
        it('testIsEditable002', 0, async (done: Function) => {
            let logger: loger = new loger('testIsEditable002');
            const Color = new ArrayBuffer(96);
            let opts: image.InitializationOptions = {
                editable: false, pixelFormat: image.PixelMapFormat.RGBA_8888,
                size: {
                    height: 4, width: 6
                }
            }
            image.createPixelMap(Color, opts, (error, pixelmap) => {
                if (pixelmap == undefined) {
                    logger.log('testIsEditable002 create pixelmap failed');
                    expect(false).assertTrue();
                    done();
                } else {
                    expect(pixelmap.isEditable == false).assertTrue();
                    logger.log('testIsEditable002 success ');
                    done();
                }
            })
        })

        /**
         * @tc.number    : TEST_READPIXELSTOBUFFER_PROMISE_001
         * @tc.name      : testReadPixelsToBufferPromise001
         * @tc.desc      : read all pixels to an buffer
         *                 1.create PixelMap,buffer
         *                 2.call readPixelsToBuffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testReadPixelsToBufferPromise001', 0, async (done: Function) => {
            let logger: loger = new loger('testReadPixelsToBufferPromise001');
            logger.log('testReadPixelsToBufferPromise001 in');
            const color = new ArrayBuffer(96);
            let bufferArr = new Uint8Array(color);
            for (let i = 0; i < bufferArr.length; i++) {
                bufferArr[i] = i + 1;
            }

            let opts: image.InitializationOptions = {
                editable: true, pixelFormat: 4, size: {
                    height: 4, width: 6
                }
            }
            image.createPixelMap(color, opts)
                .then(pixelmap => {
                    globalpixelmap = pixelmap;
                    if (pixelmap == undefined) {
                        logger.log('testReadPixelsToBufferPromise001 createPixelMap failed');
                        expect(false).assertTrue()
                        done();
                    }
                    const readBuffer = new ArrayBuffer(96);
                    pixelmap.readPixelsToBuffer(readBuffer).then(() => {
                        let bufferArr2 = new Uint8Array(readBuffer);
                        let res = true;
                        for (let i = 0; i < bufferArr2.length; i++) {
                            if (bufferArr2[i] != tcBuf020[i]) {
                                res = false;
                                logger.log('TC_20_buffer' + bufferArr2[i]);
                                logger.log('testReadPixelsToBufferPromise001 failed');
                                expect(false).assertTrue();
                                done();
                                break;
                            }
                        }
                        if (res) {
                            logger.log('testReadPixelsToBufferPromise001 success');
                            expect(true).assertTrue()
                            done();
                        }
                    }).catch((error: BusinessError) => {
                        console.log('testReadPixelsToBufferPromise001 read error: ' + error);
                        expect().assertFail();
                        done();
                    })
                }).catch((error: BusinessError) => {
                console.log('testReadPixelsToBufferPromise001 error: ' + error);
                expect().assertFail();
                done();
            })
        })

        /**
         * @tc.number    : TEST_READPIXELSTOBUFFER_CB_001
         * @tc.name      : testReadPixelsToBufferCb001
         * @tc.desc      : read all pixels to an buffer
         *                 1.create PixelMap,buffer
         *                 2.call readPixelsToBuffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testReadPixelsToBufferCb001', 0, async (done: Function) => {
            let logger: loger = new loger('testReadPixelsToBufferCb001');
            logger.log('testReadPixelsToBufferCb001 in');
            const color = new ArrayBuffer(96);
            let bufferArr = new Uint8Array(color);
            for (let i = 0; i < bufferArr.length; i++) {
                bufferArr[i] = i + 1;
            }

            let opts: image.InitializationOptions = {
                editable: true, pixelFormat: 4, size: {
                    height: 4, width: 6
                }
            }
            image.createPixelMap(color, opts, (err, pixelmap) => {
                globalpixelmap = pixelmap;
                if (pixelmap == undefined) {
                    logger.log('testReadPixelsToBufferCb001 createPixelMap failed');
                    expect(false).assertTrue();
                    done();
                } else {
                    const readBuffer = new ArrayBuffer(96);
                    pixelmap.readPixelsToBuffer(readBuffer, () => {
                        let bufferArr = new Uint8Array(readBuffer);
                        let res = true;
                        for (let i = 0; i < bufferArr.length; i++) {
                            if (bufferArr[i] != tcBuf020_1[i]) {
                                res = false;
                                logger.log('testReadPixelsToBufferCb001 failed');
                                expect(false).assertTrue();
                                done();
                                break;
                            }
                        }
                        if (res) {
                            logger.log('testReadPixelsToBufferCb001 success');
                            expect(true).assertTrue()
                            done();
                        }
                    })
                }
            })
        })

        /**
         * @tc.number    : TEST_READPIXELSTOBUFFER_CB_002
         * @tc.name      : testReadPixelsToBufferCb002
         * @tc.desc      : read all pixels to an buffer
         *                 1.create PixelMap,buffer
         *                 2.call readPixelsToBuffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testReadPixelsToBufferCb002', 0, async (done: Function) => {
            let logger: loger = new loger('testReadPixelsToBufferCb002');
            logger.log('testReadPixelsToBufferCb002 in');
            const color = new ArrayBuffer(96);
            let bufferArr = new Uint8Array(color);
            for (let i = 0; i < bufferArr.length; i++) {
                bufferArr[i] = i + 1;
            }

            let opts: image.InitializationOptions = {
                editable: true, pixelFormat: 2, size: {
                    height: 6, width: 8
                }
            }
            image.createPixelMap(color, opts, (err, pixelmap) => {
                globalpixelmap = pixelmap;
                if (pixelmap == undefined) {
                    logger.log('testReadPixelsToBufferCb002 createPixelMap failed');
                    expect(false).assertTrue();
                    done();
                } else {
                    const readBuffer = new ArrayBuffer(0);
                    pixelmap.readPixelsToBuffer(readBuffer, () => {
                        let bufferArr = new Uint8Array(readBuffer);
                        let res = true;
                        for (let i = 0; i < bufferArr.length; i++) {
                            if (bufferArr[i] == 0) {
                                res = false;
                                logger.log('testReadPixelsToBufferCb002 failed');
                                expect(false).assertTrue();
                                done();
                                break;
                            }
                        }
                        if (res) {
                            logger.log('testReadPixelsToBufferCb002 success');
                            expect(true).assertTrue()
                            done();
                        }
                    })
                }
            })
        })

        /**
         * @tc.number    : TEST_READPIXELS_PROMISE_001
         * @tc.name      : testReadPixelsPromise001
         * @tc.desc      : 1.create PixelMap
         *                 2.call readPixels
         *                 3.promise return array
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testReadPixelsPromise001', 0, async (done: Function) => {
            let logger: loger = new loger('testReadPixelsPromise001');
            const color = new ArrayBuffer(96);
            let bufferArr = new Uint8Array(color);
            for (let i = 0; i < bufferArr.length; i++) {
                bufferArr[i] = i + 1;
            }
            let opts: image.InitializationOptions = {
                editable: true, pixelFormat: 3, size: {
                    height: 4, width: 6
                }
            }
            image.createPixelMap(color, opts)
                .then(pixelmap => {
                    globalpixelmap = pixelmap;
                    if (pixelmap == undefined) {
                        logger.log('testReadPixelsPromise001 createPixelMap failed');
                        expect(false).assertTrue()
                        done();
                    }
                    const area: image.PositionArea = {
                        pixels: new ArrayBuffer(8),
                        offset: 0,
                        stride: 8,
                        region: {
                            size: {
                                height: 1, width: 2
                            }, x: 0, y: 0
                        }
                    }
                    pixelmap.readPixels(area).then(() => {
                        let bufferArr2 = new Uint8Array(area.pixels);
                        let res = true;
                        for (let i = 0; i < bufferArr2.length; i++) {
                            if (bufferArr2[i] != tcBuf021[i]) {
                                res = false;
                                logger.log('testReadPixelsPromise001 failed');
                                expect(false).assertTrue();
                                done();
                                break;
                            }
                        }
                        if (res) {
                            logger.log('testReadPixelsPromise001 success');
                            expect(true).assertTrue()
                            done();
                        }
                    })
                })
                .catch((error: BusinessError) => {
                    console.log('testReadPixelsPromise001 error: ' + error);
                    expect().assertFail();
                    done();
                })
        })

        /**
         * @tc.number    : TEST_READPIXELS_PROMISE_002
         * @tc.name      : testReadPixelsPromise002
         * @tc.desc      : 1.create PixelMap
         *                 2.call readPixels
         *                 3.promise return array
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testReadPixelsPromise002', 0, async (done: Function) => {
            let logger: loger = new loger('testReadPixelsPromise002');
            const color = new ArrayBuffer(96);
            let bufferArr = new Uint8Array(color);
            for (let i = 0; i < bufferArr.length; i++) {
                bufferArr[i] = i + 1;
            }
            let opts: image.InitializationOptions = {
                editable: true, pixelFormat: 3, size: {
                    height: 4, width: 6
                }
            }
            image.createPixelMap(color, opts, (err, pixelmap) => {
                globalpixelmap = pixelmap;
                if (pixelmap == undefined) {
                    expect(false).assertTrue();
                    logger.log('testReadPixelsPromise002 create pixelmap failed');
                    done();
                } else {
                    const area: image.PositionArea = {
                        pixels: new ArrayBuffer(0),
                        offset: 0,
                        stride: 8,
                        region: {
                            size: {
                                height: 1, width: 2
                            }, x: 0, y: 0
                        }
                    }
                    pixelmap.readPixels(area).then(() => {
                        logger.log('testReadPixelsPromise002 failed');
                        expect(false).assertTrue();
                        done();
                    }).catch(() => {
                        expect(true).assertTrue();
                        logger.log('testReadPixelsPromise002 success');
                        done();
                    })
                }
            })
        })

        /**
         * @tc.number    : TEST_READPIXELS_PROMISE_003
         * @tc.name      : testReadPixelsPromise003
         * @tc.desc      : 1.create PixelMap
         *                 2.call readPixels
         *                 3.promise return array
         *                 4.callbackcall return undefined
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testReadPixelsPromise003', 0, async (done: Function) => {
            let logger: loger = new loger('testReadPixelsPromise003');
            const color = new ArrayBuffer(96);
            let bufferArr = new Uint8Array(color);
            for (let i = 0; i < bufferArr.length; i++) {
                bufferArr[i] = i + 1;
            }
            let opts: image.InitializationOptions = {
                editable: true, pixelFormat: 3, size: {
                    height: 4, width: 6
                }
            }
            image.createPixelMap(color, opts, (err, pixelmap) => {
                globalpixelmap = pixelmap;
                if (pixelmap == undefined) {
                    expect(false).assertTrue();
                    logger.log('testReadPixelsPromise003 createPixelMap success');
                    done();
                }
                const area: image.PositionArea = {
                    pixels: new ArrayBuffer(20),
                    offset: 21,
                    stride: 8,
                    region: {
                        size: {
                            height: 1, width: 2
                        }, x: 0, y: 0
                    }
                }
                pixelmap.readPixels(area).then(() => {
                    logger.log('testReadPixelsPromise003 failed');
                    expect(false).assertTrue();
                    done();
                }).catch(() => {
                    expect(true).assertTrue();
                    logger.log('testReadPixelsPromise003 success');
                    done();
                })
            })
        })

        /**
         * @tc.number    : TEST_READPIXELS_PROMISE_004
         * @tc.name      : testReadPixelsPromise004
         * @tc.desc      : 1.create PixelMap
         *                 2.call readPixels
         *                 3.promise return array
         *                 4.callbackcall return undefined
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testReadPixelsPromise004', 0, async (done: Function) => {
            let logger: loger = new loger('testReadPixelsPromise004');
            const color = new ArrayBuffer(96);
            let bufferArr = new Uint8Array(color);
            for (let i = 0; i < bufferArr.length; i++) {
                bufferArr[i] = i + 1;
            }
            let opts: image.InitializationOptions = {
                editable: true, pixelFormat: 3, size: {
                    height: 4, width: 6
                }
            }
            image.createPixelMap(color, opts, (err, pixelmap) => {
                globalpixelmap = pixelmap;
                if (pixelmap == undefined) {
                    expect(false).assertTrue();
                    logger.log('testReadPixelsPromise004 createPixelMap success');
                    done();
                }
                const area: image.PositionArea = {
                    pixels: new ArrayBuffer(20),
                    offset: 0,
                    stride: 8,
                    region: {
                        size: {
                            height: -1, width: -1
                        }, x: 0, y: 0
                    }
                }
                pixelmap.readPixels(area).then(() => {
                    logger.log('testReadPixelsPromise004 failed');
                    expect(false).assertTrue();
                    done();
                }).catch(() => {
                    expect(true).assertTrue();
                    logger.log('testReadPixelsPromise004 success');
                    done();
                })
            })
        })

        /**
         * @tc.number    : TEST_READPIXELS_CB_001
         * @tc.name      : testReadPixelsCb001
         * @tc.desc      : 1.create PixelMap
         *                 2.call readPixels
         *                 3.promise return array
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testReadPixelsCb001', 0, async (done: Function) => {
            let logger: loger = new loger('testReadPixelsCb001');
            const color = new ArrayBuffer(96);
            let bufferArr = new Uint8Array(color);
            for (let i = 0; i < bufferArr.length; i++) {
                bufferArr[i] = i + 1;
            }
            let opts: image.InitializationOptions = {
                editable: true, pixelFormat: 3, size: {
                    height: 4, width: 6
                }
            }
            image.createPixelMap(color, opts, (err, pixelmap) => {
                globalpixelmap = pixelmap;
                if (pixelmap == undefined) {
                    logger.log('testReadPixelsCb001 createPixelMap failed');
                    expect(false).assertTrue();
                    done();
                } else {
                    const area: image.PositionArea = {
                        pixels: new ArrayBuffer(8),
                        offset: 0,
                        stride: 8,
                        region: {
                            size: {
                                height: 1, width: 2
                            }, x: 0, y: 0
                        }
                    }
                    pixelmap.readPixels(area, () => {
                        let bufferArr = new Uint8Array(area.pixels);
                        let res = true;
                        for (let i = 0; i < bufferArr.length; i++) {
                            logger.log('testReadPixelsCb001 buffer ' + bufferArr[i]);
                            if (bufferArr[i] != tcBuf021_1[i]) {
                                res = false;
                                logger.log('testReadPixelsCb001 failed');
                                expect(false).assertTrue();
                                done();
                                break;
                            }
                        }
                        if (res) {
                            logger.log('testReadPixelsCb001 success');
                            expect(true).assertTrue()
                            done();
                        }
                    })
                }
            })
        })

        /**
         * @tc.number    : TEST_READPIXELS_CB_002
         * @tc.name      : testReadPixelsCb002
         * @tc.desc      : 1.create PixelMap
         *                 2.call readPixels
         *                 3.promise return array
         *                 4.callbackcall return undefined
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testReadPixelsCb002', 0, async (done: Function) => {
            let logger: loger = new loger('testReadPixelsCb002');
            const color = new ArrayBuffer(96);
            let bufferArr = new Uint8Array(color);
            for (let i = 0; i < bufferArr.length; i++) {
                bufferArr[i] = i + 1;
            }
            let opts: image.InitializationOptions = {
                editable: true, pixelFormat: 3, size: {
                    height: 4, width: 6
                }
            }
            image.createPixelMap(color, opts, (err, pixelmap) => {
                globalpixelmap = pixelmap;
                if (pixelmap == undefined) {
                    expect(false).assertTrue();
                    logger.log('testReadPixelsCb002 create pixelmap fail');
                    done();
                } else {
                    const area: image.PositionArea = {
                        pixels: new ArrayBuffer(20),
                        offset: 0,
                        stride: 8,
                        region: {
                            size: {
                                height: 1, width: 2
                            }, x: -1, y: -1
                        }
                    }
                    pixelmap.readPixels(area).then(() => {
                        logger.log('testReadPixelsCb002 failed');
                        expect(false).assertTrue();
                        done();
                    }).catch(() => {
                        expect(true).assertTrue();
                        logger.log('testReadPixelsCb002 success');
                        done();
                    })
                }
            })
        })

        /**
         * @tc.number    : TEST_WRITEPIXELS_PROMISE_001
         * @tc.name      : testWritePixelsPromise001
         * @tc.desc      : 1.create PixelMap
         *                 2.call writePixels
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testWritePixelsPromise001', 0, async (done: Function) => {
            let logger: loger = new loger('testWritePixelsPromise001');
            const color = new ArrayBuffer(96);
            let opts: image.InitializationOptions = {
                editable: true, pixelFormat: 3, size: {
                    height: 4, width: 6
                }
            }
            image.createPixelMap(color, opts)
                .then(pixelmap => {
                    globalpixelmap = pixelmap;
                    if (pixelmap == undefined) {
                        logger.log('testWritePixelsPromise001 createPixelMap failed');
                        expect(false).assertTrue()
                        done();
                    }

                    const area: image.PositionArea = {
                        pixels: new ArrayBuffer(8),
                        offset: 0,
                        stride: 8,
                        region: {
                            size: {
                                height: 1, width: 2
                            }, x: 0, y: 0
                        }
                    }
                    let bufferArr = new Uint8Array(area.pixels);
                    for (let i = 0; i < bufferArr.length; i++) {
                        bufferArr[i] = i + 1;
                    }
                    logger.log('============ bufferArr ' + JSON.stringify(bufferArr));
                    pixelmap.writePixels(area).then(() => {
                        const readArea: image.PositionArea = {
                            pixels: new ArrayBuffer(8),
                            offset: 0,
                            stride: 8,
                            region: {
                                size: {
                                    height: 1, width: 2
                                }, x: 0, y: 0
                            }
                        }
                        logger.log('============ bufferArr ' + JSON.stringify(readArea));
                        pixelmap.readPixels(readArea).then(() => {
                            let readArr = new Uint8Array(readArea.pixels);
                            let res = true;
                            for (let i = 0; i < readArr.length; i++) {
                                if (readArr[i] != tcBuf022[i]) {
                                    res = false;
                                    logger.log('testWritePixelsPromise001 failed');
                                    expect(false).assertTrue();
                                    done();
                                    break;
                                }
                            }
                            if (res) {
                                logger.log('testWritePixelsPromise001 success');
                                expect(true).assertTrue()
                                done();
                            }
                        })
                    })
                })
                .catch((error: BusinessError) => {
                    console.log('testWritePixelsPromise001 error: ' + error);
                    expect().assertFail();
                    done();
                })
        })

        /**
         * @tc.number    : TEST_WRITEPIXELS_CB_001
         * @tc.name      : testWritePixelsCb001
         * @tc.desc      : 1.create PixelMap
         *                 2.call writePixels
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testWritePixelsCb001', 0, async (done: Function) => {
            let logger: loger = new loger('testWritePixelsCb001');
            try {
                const color = new ArrayBuffer(96);
                let opts: image.InitializationOptions = {
                    editable: true, pixelFormat: 3, size: {
                        height: 4, width: 6
                    }
                }
                image.createPixelMap(color, opts, (err, pixelmap) => {
                    globalpixelmap = pixelmap;
                    if (pixelmap == undefined) {
                        logger.log('testWritePixelsCb001 createPixelMap failed');
                        expect(false).assertTrue()
                        done();
                    }
                    const area: image.PositionArea = {
                        pixels: new ArrayBuffer(8),
                        offset: 0,
                        stride: 8,
                        region: {
                            size: {
                                height: 1, width: 2
                            }, x: 0, y: 0
                        }
                    }
                    let bufferArr = new Uint8Array(area.pixels);
                    for (let i = 0; i < bufferArr.length; i++) {
                        bufferArr[i] = i + 1;
                    }
                    pixelmap.writePixels(area, () => {
                        const readArea: image.PositionArea = {
                            pixels: new ArrayBuffer(8),
                            offset: 0,
                            stride: 8,
                            region: {
                                size: {
                                    height: 1, width: 2
                                }, x: 0, y: 0
                            }
                        }
                        pixelmap.readPixels(readArea, () => {
                            let readArr = new Uint8Array(readArea.pixels);
                            let res = true;
                            for (let i = 0; i < readArr.length; i++) {
                                if (readArr[i] != tcBuf022[i]) {
                                    res = false;
                                    logger.log('testWritePixelsCb001 failed');
                                    expect(false).assertTrue();
                                    done();
                                    break;
                                }
                            }
                            if (res) {
                                logger.log('testWritePixelsCb001 success');
                                expect(true).assertTrue()
                                done();
                            }
                        })
                    })
                })
            } catch (error) {
                logger.log('testWritePixelsCb001 error: ' + error);
                expect(false).assertTrue();
                done();
            }
        })

        /**
         * @tc.number    : TEST_WRITEBUFFERTOPIXELS_PROMISE_001
         * @tc.name      : testWriteBufferToPixelsPromise001
         * @tc.desc      : 1.create PixelMap,buffer
         *                 2.call writeBufferToPixels
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testWriteBufferToPixelsPromise001', 0, async (done: Function) => {
            let logger: loger = new loger('testWriteBufferToPixelsPromise001');
            const color = new ArrayBuffer(96);
            let opts: image.InitializationOptions = {
                editable: true, pixelFormat: 3, size: {
                    height: 4, width: 6
                }
            }
            image.createPixelMap(color, opts)
                .then(pixelmap => {
                    globalpixelmap = pixelmap;
                    if (pixelmap == undefined) {
                        logger.log('testWriteBufferToPixelsPromise001 createPixelMap failed');
                        expect(false).assertTrue()
                        done();
                    }

                    const writeColor = new ArrayBuffer(96);
                    let bufferArr = new Uint8Array(writeColor);
                    for (let i = 0; i < bufferArr.length; i++) {
                        bufferArr[i] = i + 1;
                    }
                    pixelmap.writeBufferToPixels(writeColor).then(() => {
                        const readBuffer = new ArrayBuffer(96);
                        pixelmap.readPixelsToBuffer(readBuffer).then(() => {
                            let bufferArr = new Uint8Array(readBuffer);
                            let res = true;
                            for (let i = 0; i < bufferArr.length; i++) {
                                if (bufferArr[i] == 0) {
                                    res = false;
                                    logger.log('testWriteBufferToPixelsPromise001 failed');
                                    expect(false).assertTrue()
                                    done();
                                    break;
                                }
                            }
                            if (res) {
                                logger.log('testWriteBufferToPixelsPromise001 success');
                                expect(true).assertTrue();
                                done();
                            }
                        })
                    })
                })
                .catch((error: BusinessError) => {
                    console.log('testWriteBufferToPixelsPromise001 error: ' + error);
                    expect().assertFail();
                    done();
                })
        })

        /**
         * @tc.number    : TEST_WRITEBUFFERTOPIXELS_CB_001
         * @tc.name      : testWriteBufferToPixelsCb001
         * @tc.desc      : 1.create PixelMap,buffer
         *                 2.call writeBufferToPixels
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testWriteBufferToPixelsCb001', 0, async (done: Function) => {
            let logger: loger = new loger('testWriteBufferToPixelsCb001');
            const color = new ArrayBuffer(96);
            let bufferArr = new Uint8Array(color);
            for (let i = 0; i < bufferArr.length; i++) {
                bufferArr[i] = i + 1;
            }
            let opts: image.InitializationOptions = {
                editable: true, pixelFormat: 3, size: {
                    height: 4, width: 6
                }
            }
            image.createPixelMap(color, opts).then(pixelmap => {
                globalpixelmap = pixelmap;
                if (pixelmap == undefined) {
                    expect(false).assertTrue()
                    logger.log('testWriteBufferToPixelsCb001 failed');
                    done();
                }
                const writeColor = new ArrayBuffer(96);
                pixelmap.writeBufferToPixels(writeColor, () => {
                    const readBuffer = new ArrayBuffer(96);
                    pixelmap.readPixelsToBuffer(readBuffer, () => {
                        let bufferArr = new Uint8Array(readBuffer);
                        let res = true;
                        for (let i = 0; i < bufferArr.length; i++) {
                            if (res) {
                                if (bufferArr[i] == 0) {
                                    res = false;
                                    logger.log('testWriteBufferToPixelsCb001 Success');
                                    expect(true).assertTrue()
                                    done();
                                    break;
                                }
                            }
                        }
                        if (res) {
                            logger.log('testWriteBufferToPixelsCb001 no change after writeBuffer');
                            expect(false).assertTrue();
                            done();
                        }
                    })
                })
            })
        })

        /**
         * @tc.number    : TEST_GETIMAGEINFO_PROMISE_001
         * @tc.name      : testGetImageInfoPromise001
         * @tc.desc      : 1.create PixelMap,ImageInfo
         *                 2.call getImageInfo
         *                 3.call return imageinfo
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testGetImageInfoPromise001', 0, async (done: Function) => {
            let logger: loger = new loger('testGetImageInfoPromise001');
            const color = new ArrayBuffer(96);
            let opts: image.InitializationOptions = {
                editable: true, pixelFormat: 2, size: {
                    height: 4, width: 6
                }
            }
            image.createPixelMap(color, opts)
                .then(pixelmap => {
                    globalpixelmap = pixelmap;
                    if (pixelmap == undefined) {
                        logger.log('testGetImageInfoPromise001 createPixelMap failed');
                        expect(false).assertTrue()
                        done();
                    }
                    pixelmap.getImageInfo().then(imageInfo => {
                        if (imageInfo == undefined) {
                            logger.log('testGetImageInfoPromise001 imageInfo is empty');
                            expect(false).assertTrue()
                            done();
                        }
                        if (imageInfo.size == null || imageInfo.density == null) {
                            logger.log('testGetImageInfoPromise001 imageInfo size&density is empty');
                            expect(false).assertTrue()
                            done();
                        }
                        if (imageInfo.size.height == 4 && imageInfo.size.width == 6) {
                            logger.log('testGetImageInfoPromise001 success ');
                            expect(true).assertTrue()
                            done();
                        }
                        done();
                    }).catch((error: BusinessError) => {
                        console.log('testGetImageInfoPromise001 getimageinfo error: ' + error);
                        expect().assertFail();
                        done();
                    })
                    done();
                })
                .catch((error: BusinessError) => {
                    console.log('testGetImageInfoPromise001 error: ' + error);
                    expect().assertFail();
                    done();
                })
        })

        /**
         * @tc.number    : TEST_GETIMAGEINFO_CB_001
         * @tc.name      : testGetImageInfoCb001
         * @tc.desc      : 1.create PixelMap,ImageInfo
         *                 2.call getImageInfo
         *                 3.call return imageinfo
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testGetImageInfoCb001', 0, async (done: Function) => {
            let logger: loger = new loger('testGetImageInfoCb001');
            const color = new ArrayBuffer(96);
            let opts: image.InitializationOptions = {
                editable: true, pixelFormat: 3, size: {
                    height: 4, width: 6
                }
            }
            image.createPixelMap(color, opts, (err, pixelmap) => {
                if (pixelmap == undefined) {
                    globalpixelmap = pixelmap;
                    expect(false).assertTrue()
                    logger.log('testGetImageInfoCb001 create pixelmap fail');
                    done();
                }
                pixelmap.getImageInfo((err, imageInfo) => {
                    if (imageInfo == undefined) {
                        logger.log('testGetImageInfoCb001 imageInfo is empty');
                        expect(false).assertTrue()
                        done();
                    }
                    if (imageInfo.size.height == 4 && imageInfo.size.width == 6) {
                        logger.log('testGetImageInfoCb001 imageInfo success');
                        expect(true).assertTrue()
                        done();
                    }
                    done();
                })
            })
        })

        /**
         * @tc.number    : TEST_GETBYTESNUMBERPERROW_001
         * @tc.name      : testGetBytesNumberPerRow001
         * @tc.desc      : 1.create PixelMap
         *                 2.set PixelMap
         *                 3.call getBytesNumberPerRow
         *                 4.call return number
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testGetBytesNumberPerRow001', 0, async (done: Function) => {
            let logger: loger = new loger('testGetBytesNumberPerRow001');
            const color = new ArrayBuffer(96);
            let opts: image.InitializationOptions = {
                editable: true, pixelFormat: 3, size: {
                    height: 4, width: 6
                }
            }
            const expectNum = 4 * opts.size.width;
            image.createPixelMap(color, opts, (err, pixelmap) => {
                globalpixelmap = pixelmap;
                if (pixelmap == undefined) {
                    expect(false).assertTrue()
                    logger.log('testGetBytesNumberPerRow001 create pixelmap fail');
                    done();
                } else {
                    const num = pixelmap.getBytesNumberPerRow();
                    logger.log('testGetBytesNumberPerRow001 num is ' + num);
                    expect(num == expectNum).assertTrue();
                    if (num == expectNum) {
                        logger.log('TC_25-1 success');
                    } else {
                        logger.log('TC_25-1 fail');
                    }
                    done();
                }
            })
        })

        /**
         * @tc.number    : TEST_GETPIXELBYTESNUMBER_001
         * @tc.name      : testGetPixelBytesNumber001
         * @tc.desc      : 1.create PixelMap
         *                 2.set Pixel
         *                 3.call getPixelBytesNumber
         *                 4.call return number
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testGetPixelBytesNumber001', 0, async (done: Function) => {
            let logger: loger = new loger('testGetPixelBytesNumber001');
            const color = new ArrayBuffer(96);
            let opts: image.InitializationOptions = {
                editable: true, pixelFormat: 3, size: {
                    height: 4, width: 6
                }
            }
            const expectNum = 4 * opts.size.width * opts.size.height;
            image.createPixelMap(color, opts, (err, pixelmap) => {
                globalpixelmap = pixelmap;
                if (pixelmap == undefined) {
                    expect(false).assertTrue()
                    logger.log('testGetPixelBytesNumber001 create pixelmap fail');
                    done();
                } else {
                    const num = pixelmap.getPixelBytesNumber();
                    logger.log('testGetPixelBytesNumber001 num is ' + num);
                    expect(num == expectNum).assertTrue();
                    if (num == expectNum) {
                        logger.log('testGetPixelBytesNumber001 success');
                    } else {
                        logger.log('testGetPixelBytesNumber001 fail');
                    }
                    done();
                }
            })
        })

        /**
         * @tc.number    : TEST_GETDENSITY_001
         * @tc.name      : testGetDensity001
         * @tc.desc      : 1.create ImageSource
         *               : 2.create PixelMap
         *               : 3.getDensity
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testGetDensity001', 0, async (done: Function) => {
            let imageData = testPng.buffer;
            await getDensityTest(done, 'testGetDensity001', imageData, null!);
        })

        /**
         * @tc.number    : TEST_GETDENSITY_002
         * @tc.name      : testGetDensity002
         * @tc.desc      : 1.create ImageSource
         *               : 2.create PixelMap
         *               : 3.getDensity
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testGetDensity002', 0, async (done: Function) => {
            let imageData = testJpg.buffer;
            await getDensityTest(done, 'testGetDensity002', imageData, null!);
        })

        /**
         * @tc.number    : TEST_GETDENSITY_003
         * @tc.name      : testGetDensity003
         * @tc.desc      : 1.create ImageSource
         *               : 2.create PixelMap
         *               : 3.getDensity
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testGetDensity003', 0, async (done: Function) => {
            let imageData: ESObject = testBmp.buffer;
            await getDensityTest(done, 'testGetDensity003', imageData, null!);
        })

        /**
         * @tc.number    : TEST_GETDENSITY_004
         * @tc.name      : testGetDensity003
         * @tc.desc      : 1.create ImageSource
         *               : 2.create PixelMap
         *               : 3.getDensity
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testGetDensity004', 0, async (done: Function) => {
            let imageData: ESObject = testGif.buffer;
            await getDensityTest(done, 'testGetDensity004', imageData, null!);
        })

        /**
         * @tc.number    : TEST_GETDENSITY_005
         * @tc.name      : testGetDensity005
         * @tc.desc      : 1.create ImageSource
         *               : 2.create PixelMap with fitDensity
         *               : 3.getDensity
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testGetDensity005', 0, async (done: Function) => {
            let imageData: ESObject = testPng.buffer;
            let decodingOptions: image.DecodingOptions = {
                fitDensity: 240
            };
            await getDensityTest(done, 'testGetDensity005', imageData, decodingOptions);
        })

        /**
         * @tc.number    : TEST_GETDENSITY_006
         * @tc.name      : testGetDensity006
         * @tc.desc      : 1.create ImageSource
         *               : 2.create PixelMap with fitDensity
         *               : 3.getDensity
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testGetDensity006', 0, async (done: Function) => {
            let imageData: ESObject = testJpg.buffer;
            let decodingOptions: image.DecodingOptions = {
                fitDensity: 240
            };
            await getDensityTest(done, 'testGetDensity006', imageData, decodingOptions);
        })

        /**
         * @tc.number    : TEST_GETDENSITY_007
         * @tc.name      : testGetDensity007
         * @tc.desc      : 1.create ImageSource
         *               : 2.create PixelMap with fitDensity
         *               : 3.getDensity
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testGetDensity007', 0, async (done: Function) => {
            let imageData: ESObject = testBmp.buffer;
            let decodingOptions: image.DecodingOptions = {
                fitDensity: 240
            };
            await getDensityTest(done, 'testGetDensity007', imageData, decodingOptions);
        })

        /**
         * @tc.number    : TEST_GETDENSITY_008
         * @tc.name      : testGetDensity008
         * @tc.desc      : 1.create ImageSource
         *               : 2.create PixelMap with fitDensity
         *               : 3.getDensity
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testGetDensity008', 0, async (done: Function) => {
            let imageData: ESObject = testGif.buffer;
            let decodingOptions: image.DecodingOptions = {
                fitDensity: 240
            };
            await getDensityTest(done, 'testGetDensity008', imageData, decodingOptions);
        })

        /**
         * @tc.number    : TEST_OPACITY_PROMISE_001
         * @tc.name      : testOpacityPromise001
         * @tc.desc      : 1.create pixelmap
         *               : 2.setAlpha
         *               : 3.get PixelBytesNumber
         *               : 4.read Pixels To Buffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testOpacityPromise001', 0, async (done: Function) => {
            let testName = 'testOpacityPromise001';
            let logger: loger = new loger(testName);
            try {
                let pixelMap = await genPixelMap()
                logger.log("pixelMap " + (pixelMap != undefined));
                if (pixelMap != undefined) {
                    await pixelMap.opacity(0.8)
                    let pixelSize = pixelMap.getPixelBytesNumber();
                    logger.log(`new pixel size ${pixelSize}`);
                    let readBuffer = new ArrayBuffer(pixelSize);
                    await pixelMap.readPixelsToBuffer(readBuffer);
                    let bufferArr2 = new Uint8Array(readBuffer);
                    for (let i = 0; i < bufferArr2.length; i++) {
                        if (bufferArr2[i] != setAlpha8[i]) {
                            logger.log(`pixel[${i}] current[${bufferArr2[i]}] target[${setAlpha8[i]}]`);
                            expect(false).assertTrue();
                            break;
                        }
                    }
                    expect(true).assertTrue();
                    done();
                } else {
                    logger.log('create pixelMap failed ');
                    expect(false).assertTrue();
                    done();
                }
            } catch (error) {
                logger.log('failed ' + error);
                expect(false).assertTrue();
                done();
            }
        })

        /**
         * @tc.number    : TEST_OPACITY_PROMISE_002
         * @tc.name      : testOpacityPromise002
         * @tc.desc      : 1.create pixelmap
         *               : 2.opacity
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testOpacityPromise002', 0, async (done: Function) => {
            let param: ESObject = {
                a: 1
            };
            opacityErr(done, 'testOpacityPromise002', param, 'Promise')
        })

        /**
         * @tc.number    : TEST_OPACITY_PROMISE_003
         * @tc.name      : testOpacityPromise003
         * @tc.desc      : 1.create pixelmap
         *               : 2.opacity
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testOpacityPromise003', 0, async (done: Function) => {
            let param: ESObject = 'a';
            opacityErr(done, 'testOpacityPromise003', param, 'Promise')
        })

        /**
         * @tc.number    : TEST_OPACITY_PROMISE_004
         * @tc.name      : testOpacityPromise004
         * @tc.desc      : 1.create pixelmap
         *               : 2.opacity
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testOpacityPromise004', 0, async (done: Function) => {
            opacityErr(done, 'testOpacityPromise004', null!, 'Promise')
        })

        /**
         * @tc.number    : TEST_OPACITY_PROMISE_005
         * @tc.name      : testOpacityPromise005
         * @tc.desc      : 1.create pixelmap
         *               : 2.opacity
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testOpacityPromise005', 0, async (done: Function) => {
            opacityErr(done, 'testOpacityPromise005', 2, 'Promise')
        })

        /**
         * @tc.number    : TEST_OPACITY_CB_001
         * @tc.name      : testOpacityCb001
         * @tc.desc      : 1.create pixelmap
         *               : 2.setAlpha
         *               : 3.get PixelBytesNumber
         *               : 4.read Pixels To Buffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testOpacityCb001', 0, async (done: Function) => {
            let logger: loger = new loger('testOpacityCb001');
            try {
                let pixelMap = await genPixelMap()
                logger.log("pixelMap " + (pixelMap != undefined));
                if (pixelMap != undefined) {
                    pixelMap.opacity(0.8, async (err) => {
                        let pixelSize = pixelMap.getPixelBytesNumber();
                        logger.log(`new pixel size ${pixelSize}`);
                        let readBuffer = new ArrayBuffer(pixelSize);
                        await pixelMap.readPixelsToBuffer(readBuffer);
                        let bufferArr2 = new Uint8Array(readBuffer);
                        for (let i = 0; i < bufferArr2.length; i++) {
                            if (bufferArr2[i] != setAlpha8[i]) {
                                logger.log(`pixel[${i}] current[${bufferArr2[i]}] target[${setAlpha8[i]}]`);
                                expect(false).assertTrue();
                                break;
                            }
                        }
                        expect(true).assertTrue();
                        done();
                    })
                } else {
                    logger.log('create pixelMap failed ');
                    expect(false).assertTrue();
                    done();
                }
            } catch (error) {
                logger.log('failed ' + error);
                expect(false).assertTrue();
                done();
            }
        })

        /**
         * @tc.number    : TEST_OPACITY_CB_002
         * @tc.name      : testOpacityCb002
         * @tc.desc      : 1.create pixelmap
         *               : 2.opacity
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testOpacityCb002', 0, async (done: Function) => {
            let param: ESObject = {
                a: 1
            };
            opacityErr(done, 'testOpacityCb002', param, 'callback')
        })

        /**
         * @tc.number    : TEST_OPACITY_CB_003
         * @tc.name      : testOpacityCb003
         * @tc.desc      : 1.create pixelmap
         *               : 2.opacity
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testOpacityCb003', 0, async (done: Function) => {
            let param: ESObject = 'a';
            opacityErr(done, 'testOpacityCb003', param, 'callback')
        })

        /**
         * @tc.number    : TEST_OPACITY_CB_004
         * @tc.name      : testOpacityCb004
         * @tc.desc      : 1.create pixelmap
         *               : 2.opacityErr
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testOpacityCb004', 0, async (done: Function) => {
            opacityErr(done, 'testOpacityCb004', null!, 'callback')
        })

        /**
         * @tc.number    : TEST_OPACITY_CB_005
         * @tc.name      : testOpacityCb005
         * @tc.desc      : 1.create pixelmap
         *               : 2.opacity
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testOpacityCb005', 0, async (done: Function) => {
            opacityErr(done, 'testOpacityCb005', 2, 'callback')
        })

        /**
         * @tc.number    : TEST_CREATEALPHAPIXELMAP_PROMISE_001
         * @tc.name      : testCreateAlphaPixelmapPromise001
         * @tc.desc      : 1.create imagesource
         *               : 2.create pixelmap
         *               : 3.create AlphaPixelmap
         *               : 4.call getImageInfo
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testCreateAlphaPixelmapPromise001', 0, async (done: Function) => {
            let imageData = testPng.buffer;
            await createAlphaPixelmapTest(done, 'testCreateAlphaPixelmapPromise001', 'promise', imageData);
        })

        /**
         * @tc.number    : TEST_CREATEALPHAPIXELMAP_PROMISE_002
         * @tc.name      : testCreateAlphaPixelmapPromise002
         * @tc.desc      : 1.create imagesource
         *               : 2.create pixelmap
         *               : 3.create AlphaPixelmap
         *               : 4.call getImageInfo
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testCreateAlphaPixelmapPromise002', 0, async (done: Function) => {
            let imageData = testJpg.buffer;
            await createAlphaPixelmapTest(done, 'testCreateAlphaPixelmapPromise002', 'promise', imageData);
        })

        /**
         * @tc.number    : TEST_CREATEALPHAPIXELMAP_PROMISE_003
         * @tc.name      : testCreateAlphaPixelmapPromise003
         * @tc.desc      : 1.create imagesource
         *               : 2.create pixelmap
         *               : 3.create AlphaPixelmap
         *               : 4.call getImageInfo
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testCreateAlphaPixelmapPromise003', 0, async (done: Function) => {
            let imageData = testBmp.buffer;
            await createAlphaPixelmapTest(done, 'testCreateAlphaPixelmapPromise003', 'promise', imageData);
        })

        /**
         * @tc.number    : TEST_CREATEALPHAPIXELMAP_PROMISE_004
         * @tc.name      : testCreateAlphaPixelmapPromise004
         * @tc.desc      : 1.create imagesource
         *               : 2.create pixelmap
         *               : 3.create AlphaPixelmap
         *               : 4.call getImageInfo
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testCreateAlphaPixelmapPromise004', 0, async (done: Function) => {
            let imageData = testGif.buffer;
            await createAlphaPixelmapTest(done, 'testCreateAlphaPixelmapPromise004', 'promise', imageData);
        })

        /**
         * @tc.number    : TEST_CREATEALPHAPIXELMAP_CB_001
         * @tc.name      : testCreateAlphaPixelmapCb001
         * @tc.desc      : 1.create imagesource
         *               : 2.create pixelmap
         *               : 3.create AlphaPixelmap
         *               : 4.call getImageInfo
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testCreateAlphaPixelmapCb001', 0, async (done: Function) => {
            let imageData = testPng.buffer;
            await createAlphaPixelmapTest(done, 'testCreateAlphaPixelmapCb001', 'callback', imageData);
        })

        /**
         * @tc.number    : TEST_SCALE_PROMISE_001
         * @tc.name      : testScalePromise001
         * @tc.desc      : 1.create pixelmap
         *               : 2.call scale
         *               : 3.get pixelbytesnumber
         *               : 4.read pixels to buffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testScalePromise001', 0, async (done: Function) => {
            let testNum = 'testScalePromise001';
            let logger: loger = new loger(testNum);
            try {
                let pixelMap = await genPixelMap()
                logger.log("pixelMap " + (pixelMap != undefined));
                if (pixelMap != undefined) {
                    let orgInfo = await pixelMap.getImageInfo();
                    await pixelMap.scale(2.0, 1.0);
                    let newInfo = await pixelMap.getImageInfo()
                    if (newInfo.size.width == orgInfo.size.width * 2) {
                        logger.log(`org width ${orgInfo.size.width}, new width ${newInfo.size.width} `);
                        expect(true).assertTrue();
                        done();
                    } else {
                        logger.log(`org width ${orgInfo.size.width}, new width ${newInfo.size.width} `);
                        expect(false).assertTrue();
                        done();
                    }
                } else {
                    logger.log('create pixelMap fail ');
                    expect(false).assertTrue();
                    done();
                }
            } catch (error) {
                logger.log('failed ' + error);
                expect(false).assertTrue();
                done();
            }
        })

        /**
         * @tc.number    : TEST_SCALE_PROMISE_002
         * @tc.name      : testScalePromise002
         * @tc.desc      : 1.create pixelmap
         *               : 2.call scale
         *               : 3.get pixelbytesnumber
         *               : 4.read pixels to buffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testScalePromise002', 0, async (done: Function) => {
            let logger = new loger('testScalePromise002')
            try {
                let pixelMap = await genPixelMap()
                logger.log("pixelMap " + (pixelMap != undefined));
                if (pixelMap != undefined) {
                    let orgInfo = await pixelMap.getImageInfo();
                    await pixelMap.scale(1.0, 4.0);
                    let newInfo = await pixelMap.getImageInfo()
                    if (newInfo.size.height == orgInfo.size.height * 4) {
                        logger.log(`org width ${orgInfo.size.width}, new width ${newInfo.size.width} `);
                        expect(true).assertTrue();
                        done();
                    } else {
                        logger.log(`org width ${orgInfo.size.width}, new width ${newInfo.size.width} `);
                        expect(false).assertTrue();
                        done();
                    }
                } else {
                    logger.log('create pixelMap fail ');
                    expect(false).assertTrue();
                    done();
                }
            } catch (error) {
                logger.log('failed ' + error);
                expect(false).assertTrue();
                done();
            }
        })

        /**
         * @tc.number    : TEST_SCALE_PROMISE_003
         * @tc.name      : testScalePromise003
         * @tc.desc      : 1.create pixelmap
         *               : 2.call scale
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testScalePromise003', 0, async (done: Function) => {
            let testNum = 'testScalePromise003';
            let X: ESObject = {
                a: 10
            };
            let Y: number = 1.0;
            scaleErr(done, testNum, X, Y);
        })

        /**
         * @tc.number    : TEST_SCALE_PROMISE_004
         * @tc.name      : testScalePromise004
         * @tc.desc      : 1.create pixelmap
         *               : 2.call scale
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testScalePromise004', 0, async (done: Function) => {
            let testNum = 'testScalePromise004';
            let X: ESObject = 'a';
            let Y: number = 1.0;
            scaleErr(done, testNum, X, Y);
        })

        /**
         * @tc.number    : TEST_SCALE_PROMISE_005
         * @tc.name      : testScalePromise005
         * @tc.desc      : 1.create pixelmap
         *               : 2.call scale
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testScalePromise005', 0, async (done: Function) => {
            let testNum = 'testScalePromise005';
            let X: number = 1.0;
            scaleErr(done, testNum, X, null!);
        })

        /**
         * @tc.number    : TEST_SCALE_PROMISE_006
         * @tc.name      : testScalePromise006
         * @tc.desc      : 1.create pixelmap
         *               : 2.call scale
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testScalePromise006', 0, async (done: Function) => {
            let testNum = 'testScalePromise006';
            let X: number = 1.0;
            let Y: ESObject = true;
            scaleErr(done, testNum, X, Y);
        })

        /**
         * @tc.number    : TEST_SCALE_CB_001
         * @tc.name      : testScaleCb001
         * @tc.desc      : 1.create pixelmap
         *               : 2.call scale
         *               : 3.get pixelbytesnumber
         *               : 4.read pixels to buffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testScaleCb001', 0, async (done: Function) => {
            let logger = new loger('testScaleCb001')
            try {
                let pixelMap = await genPixelMap()
                logger.log("pixelMap " + (pixelMap != undefined));
                if (pixelMap != undefined) {
                    let orgInfo = await pixelMap.getImageInfo();
                    pixelMap.scale(1.0, 4.0, async () => {
                        let newInfo = await pixelMap.getImageInfo()
                        if (newInfo.size.height == orgInfo.size.height * 4) {
                            logger.log(`org width ${orgInfo.size.width}, new width ${newInfo.size.width} `);
                            expect(true).assertTrue();
                            done();
                        } else {
                            logger.log(`org width ${orgInfo.size.width}, new width ${newInfo.size.width} `);
                            expect(false).assertTrue();
                            done();
                        }
                    })
                } else {
                    logger.log('create pixelMap fail ');
                    expect(false).assertTrue();
                    done();
                }
            } catch (error) {
                logger.log('failed ' + error);
                expect(false).assertTrue();
                done();
            }
        })

        /**
         * @tc.number    : TEST_SCALE_CB_002
         * @tc.name      : testScaleCb002
         * @tc.desc      : 1.create pixelmap
         *               : 2.call scale
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testScaleCb002', 0, async (done: Function) => {
            let testNum = 'testScaleCb002';
            let X: ESObject = {
                a: 10
            };
            let Y: number = 1.0;
            scaleCbErr(done, testNum, X, Y);
        })

        /**
         * @tc.number    : TEST_SCALE_CB_003
         * @tc.name      : testScaleCb003
         * @tc.desc      : 1.create pixelmap
         *               : 2.call scale
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testScaleCb003', 0, async (done: Function) => {
            let testNum = 'testScaleCb003';
            let X: ESObject = 'a';
            let Y: number = 1.0;
            scaleCbErr(done, testNum, X, Y);
        })

        /**
         * @tc.number    : TEST_SCALE_CB_004
         * @tc.name      : testScaleCb004
         * @tc.desc      : 1.create pixelmap
         *               : 2.call scale
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testScaleCb004', 0, async (done: Function) => {
            let testNum = 'testScaleCb004';
            let X: number = 1.0;
            scaleCbErr(done, testNum, X, null!);
        })

        /**
         * @tc.number    : TEST_SCALE_CB_005
         * @tc.name      : testScaleCb005
         * @tc.desc      : 1.create pixelmap
         *               : 2.call scale
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testScaleCb005', 0, async (done: Function) => {
            let testNum = 'testScaleCb005';
            let X: number = 1.0;
            let Y: ESObject = true;
            scaleCbErr(done, testNum, X, Y);
        })

        /**
         * @tc.number    : TEST_TRANSLATE_PROMISE_001
         * @tc.name      : testTranslatePromise001
         * @tc.desc      : 1.create pixelmap
         *               : 2.call translate
         *               : 3.get pixelbytesnumber
         *               : 4.read pixels to buffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testTranslatePromise001', 0, async (done: Function) => {
            let logger = new loger('testTranslatePromise001')
            try {
                let pixelMap = await genPixelMap()
                logger.log("pixelMap " + (pixelMap != undefined));
                if (pixelMap != undefined) {
                    let orgInfo = await pixelMap.getImageInfo();
                    await pixelMap.translate(3.0, 1.0);
                    let newInfo = await pixelMap.getImageInfo();
                    if (newInfo.size.width != orgInfo.size.width + 3) {
                        logger.log(`org width ${orgInfo.size.width}, new width ${newInfo.size.width} `);
                        expect(false).assertTrue();
                    }
                } else {
                    logger.log('create pixelMap fail ');
                    expect(false).assertTrue();
                }
                done();
            } catch (error) {
                logger.log('failed ' + error);
                expect(false).assertTrue();
                done();
            }
        })

        /**
         * @tc.number    : TEST_TRANSLATE_PROMISE_002
         * @tc.name      : testTranslatePromise002
         * @tc.desc      : 1.create pixelmap
         *               : 2.call translate
         *               : 3.get pixelbytesnumber
         *               : 4.read pixels to buffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testTranslatePromise002', 0, async (done: Function) => {
            let logger = new loger('testTranslatePromise002')
            try {
                let pixelMap = await genPixelMap()
                logger.log("pixelMap " + (pixelMap != undefined));
                if (pixelMap != undefined) {
                    let orgInfo = await pixelMap.getImageInfo();
                    await pixelMap.translate(1.0, 3.0);
                    let newInfo = await pixelMap.getImageInfo()
                    if (newInfo.size.height != orgInfo.size.height + 3) {
                        logger.log(`org height ${orgInfo.size.height}, new height ${newInfo.size.height} `);
                        expect(false).assertTrue();
                    }
                } else {
                    logger.log('create pixelMap fail ');
                    expect(false).assertTrue();
                }
                done();
            } catch (error) {
                logger.log('failed ' + error);
                expect(false).assertTrue();
                done();
            }
        })

        /**
         * @tc.number    : TEST_TRANSLATE_PROMISE_003
         * @tc.name      : testTranslatePromise003
         * @tc.desc      : 1.create pixelmap
         *               : 2.call translate
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testTranslatePromise003', 0, async (done: Function) => {
            let testNum = 'testTranslatePromise003';
            let translateX: ESObject = {
                a: 10
            };
            let translateY: number = 1.0;
            translateErr(done, testNum, translateX, translateY);
        })

        /**
         * @tc.number    : TEST_TRANSLATE_PROMISE_004
         * @tc.name      : testTranslatePromise004
         * @tc.desc      : 1.create pixelmap
         *               : 2.call translate
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testTranslatePromise004', 0, async (done: Function) => {
            let testNum = 'testTranslatePromise004';
            let translateX: ESObject = 'a';
            let translateY: number = 1.0;
            translateErr(done, testNum, translateX, translateY)
        })

        /**
         * @tc.number    : TEST_TRANSLATE_PROMISE_005
         * @tc.name      : testTranslatePromise005
         * @tc.desc      : 1.create pixelmap
         *               : 2.call translate
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testTranslatePromise005', 0, async (done: Function) => {
            let testNum = 'testTranslatePromise005';
            let translateX: number = 1.0;
            translateErr(done, testNum, translateX, null!)
        })

        /**
         * @tc.number    : TEST_TRANSLATE_PROMISE_006
         * @tc.name      : testTranslatePromise006
         * @tc.desc      : 1.create pixelmap
         *               : 2.call translate
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testTranslatePromise006', 0, async (done: Function) => {
            let testNum = 'testTranslatePromise006';
            let translateX: number = 1.0;
            let translateY: ESObject = false;
            translateErr(done, testNum, translateX, translateY)
        })

        /**
         * @tc.number    : TEST_TRANSLATE_CB_001
         * @tc.name      : testTranslateCb001
         * @tc.desc      : 1.create pixelmap
         *               : 2.call translate
         *               : 3.get pixelbytesnumber
         *               : 4.read pixels to buffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testTranslateCb001', 0, async function (done) {
            function sizeCheck(done, logger, orgInfo, newInfo) {
                if (newInfo.size.height != orgInfo.size.height + 3) {
                    logger.log(`org height ${orgInfo.size.height}, new height ${newInfo.size.height} `);
                    expect(false).assertTrue();
                    done();
                }
            }
            await pixelMapModifySizeTest(done, 'testTranslateCb001', 'callback', 'translate', sizeCheck, translate1x3, 1.0, 3.0)
        })

        /**
         * @tc.number    : TEST_TRANSLATE_CB_002
         * @tc.name      : testTranslateCb002
         * @tc.desc      : 1.create pixelmap
         *               : 2.call translate
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testTranslateCb002', 0, async function (done) {
            await pixelMapModifySizeTestErr(done, 'testTranslateCb002', 'callback', 'translate', { a: 10 }, 1.0)
        })

        /**
         * @tc.number    : TEST_TRANSLATE_CB_003
         * @tc.name      : testTranslateCb003
         * @tc.desc      : 1.create pixelmap
         *               : 2.call translate
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testTranslateCb003', 0, async (done: Function) => {
            let testNum = 'testTranslateCb003';
            let translateX: ESObject = 'a';
            let translateY: number = 1.0;
            translateCbErr(done, testNum, translateX, translateY);
        })

        /**
         * @tc.number    : TEST_TRANSLATE_CB_004
         * @tc.name      : testTranslateCb004
         * @tc.desc      : 1.create pixelmap
         *               : 2.call translate
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testTranslateCb004', 0, async (done: Function) => {
            let testNum = 'testTranslateCb004';
            let translateX: number = 1.0;
            translateCbErr(done, testNum, translateX, null!);
        })

        /**
         * @tc.number    : TEST_TRANSLATE_CB_005
         * @tc.name      : testTranslateCb005
         * @tc.desc      : 1.create pixelmap
         *               : 2.call translate
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testTranslateCb005', 0, async (done: Function) => {
            let testNum = 'testTranslateCb005';
            let translateX: number = 1.0;
            let translateY: ESObject = false;
            translateCbErr(done, testNum, translateX, translateY);
        })

        /**
         * @tc.number    : TEST_ROTATE_PROMISE_001
         * @tc.name      : testRotatePromise001
         * @tc.desc      : 1.create pixelmap
         *               : 2.call rotate
         *               : 3.get pixelbytesnumber
         *               : 4.read pixels to buffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testRotatePromise001', 0, async function (done) {
            function sizeCheck(done, logger, orgInfo, newInfo) {
                if (newInfo.size.width != orgInfo.size.height) {
                    logger.log(`org height ${orgInfo.size.height}, new width ${newInfo.size.width} `);
                    expect(false).assertTrue();
                    done();
                }
            }
            await pixelMapModifySizeTest(done, 'testRotatePromise001', 'promise', 'rotate', sizeCheck, rotate90, 90.0)
        })

        /**
         * @tc.number    : TEST_ROTATE_PROMISE_002
         * @tc.name      : testRotatePromise002
         * @tc.desc      : 1.create pixelmap
         *               : 2.call rotate
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testRotatePromise002', 0, async function (done) {
            await pixelMapModifySizeTestErr(done, 'testRotatePromise002', 'promise', 'rotate', 'a')
        })

        /**
         * @tc.number    : TEST_ROTATE_PROMISE_003
         * @tc.name      : testRotatePromise003
         * @tc.desc      : 1.create pixelmap
         *               : 2.call rotate
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testRotatePromise003', 0, async function (done) {
            await pixelMapModifySizeTestErr(done, 'testRotatePromise003', 'promise', 'rotate', { a: 10 })
        })

        /**
         * @tc.number    : TEST_ROTATE_PROMISE_004
         * @tc.name      : testRotatePromise004
         * @tc.desc      : 1.create pixelmap
         *               : 2.call rotate
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testRotatePromise004', 0, async function (done) {
            await pixelMapModifySizeTestErr(done, 'testRotatePromise004', 'promise', 'rotate', null)
        })

        /**
         * @tc.number    : TEST_ROTATE_PROMISE_005
         * @tc.name      : testRotatePromise005
         * @tc.desc      : 1.create pixelmap
         *               : 2.call rotate
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testRotatePromise005', 0, async function (done) {
            await pixelMapModifySizeTestErr(done, 'testRotatePromise005', 'promise', 'rotate', false)
        })

        /**
         * @tc.number    : TEST_ROTATE_CB_001
         * @tc.name      : testRotateCb001
         * @tc.desc      : 1.create pixelmap
         *               : 2.call rotate
         *               : 3.get pixelbytesnumber
         *               : 4.read pixels to buffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testRotateCb001', 0, async function (done) {
            function sizeCheck(done, logger, orgInfo, newInfo) {
                if (newInfo.size.width != orgInfo.size.height) {
                    logger.log(`org height ${orgInfo.size.height}, new width ${newInfo.size.width} `);
                    expect(false).assertTrue();
                    done();
                }
            }
            await pixelMapModifySizeTest(done, 'testRotateCb001', 'callback', 'rotate', sizeCheck, rotate90, 90.0)
        })

        /**
         * @tc.number    : TEST_ROTATE_CB_002
         * @tc.name      : testRotateCb002
         * @tc.desc      : 1.create pixelmap
         *               : 2.call rotate
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testRotateCb002', 0, async function (done) {
            await pixelMapModifySizeTestErr(done, 'testRotateCb002', 'callback', 'rotate', 'a')
        })

        /**
         * @tc.number    : TEST_ROTATE_CB_003
         * @tc.name      : testRotateCb003
         * @tc.desc      : 1.create pixelmap
         *               : 2.call rotate
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testRotateCb003', 0, async function (done) {
            await pixelMapModifySizeTestErr(done, 'testRotateCb003', 'callback', 'rotate', { a: 10 })
        })

        /**
         * @tc.number    : TEST_ROTATE_CB_004
         * @tc.name      : testRotateCb004
         * @tc.desc      : 1.create pixelmap
         *               : 2.call rotate
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testRotateCb004', 0, async function (done) {
            await pixelMapModifySizeTestErr(done, 'testRotateCb004', 'callback', 'rotate', null)
        })

        /**
         * @tc.number    : TEST_ROTATE_CB_005
         * @tc.name      : testRotateCb005
         * @tc.desc      : 1.create pixelmap
         *               : 2.call rotate
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testRotateCb005', 0, async function (done) {
            await pixelMapModifySizeTestErr(done, 'testRotateCb005', 'callback', 'rotate', false)
        })

        /**
         * @tc.number    : TEST_FLIP_PROMISE_001
         * @tc.name      : testFlipPromise001
         * @tc.desc      : 1.create pixelmap
         *               : 2.call flip
         *               : 3.get pixelbytesnumber
         *               : 4.read pixels to buffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testFlipPromise001', 0, async function (done) {
            function sizeCheck(done, logger, orgInfo, newInfo) {
                if (newInfo.size.width != orgInfo.size.width) {
                    logger.log(`org width ${orgInfo.size.width}, new width ${newInfo.size.width} `);
                    expect(false).assertTrue();
                    done();
                }
            }
            await pixelMapModifySizeTest(done, 'testFlipPromise001', 'promise', 'flip', sizeCheck, flipH, false, true)
        })

        /**
         * @tc.number    : TEST_FLIP_PROMISE_002
         * @tc.name      : testFlipPromise002
         * @tc.desc      : 1.create pixelmap
         *               : 2.call flip
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testFlipPromise002', 0, async function (done) {
            await pixelMapModifySizeTestErr(done, 'testFlipPromise002', 'promise', 'flip', 'false', true)
        })

        /**
         * @tc.number    : TEST_FLIP_PROMISE_003
         * @tc.name      : testFlipPromise003
         * @tc.desc      : 1.create pixelmap
         *               : 2.call flip
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testFlipPromise003', 0, async function (done) {
            await pixelMapModifySizeTestErr(done, 'testFlipPromise003', 'promise', 'flip', 1, true)
        })

        /**
         * @tc.number    : TEST_FLIP_PROMISE_004
         * @tc.name      : testFlipPromise004
         * @tc.desc      : 1.create pixelmap
         *               : 2.call flip
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testFlipPromise004', 0, async function (done) {
            await pixelMapModifySizeTestErr(done, 'testFlipPromise004', 'promise', 'flip', true, { a: 10 })
        })

        /**
         * @tc.number    : TEST_FLIP_PROMISE_005
         * @tc.name      : testFlipPromise005
         * @tc.desc      : 1.create pixelmap
         *               : 2.call flip
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testFlipPromise005', 0, async function (done) {
            await pixelMapModifySizeTestErr(done, 'testFlipPromise005', 'promise', 'flip', true, null)
        })

        /**
         * @tc.number    : TEST_FLIP_CB_001
         * @tc.name      : testFlipCb001
         * @tc.desc      : 1.create pixelmap
         *               : 2.call flip
         *               : 3.get pixelbytesnumber
         *               : 4.read pixels to buffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testFlipCb001', 0, async function (done) {
            function sizeCheck(done, logger, orgInfo, newInfo) {
                if (newInfo.size.width != orgInfo.size.width) {
                    logger.log(`org width ${orgInfo.size.width}, new width ${newInfo.size.width} `);
                    expect(false).assertTrue();
                    done();
                }
            }
            await pixelMapModifySizeTest(done, 'testFlipCb001', 'callback', 'flip', sizeCheck, flipH, false, true)
        })

        /**
         * @tc.number    : TEST_FLIP_CB_002
         * @tc.name      : testFlipCb002
         * @tc.desc      : 1.create pixelmap
         *               : 2.call flip
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testFlipCb002', 0, async function (done) {
            await pixelMapModifySizeTestErr(done, 'testFlipCb002', 'callback', 'flip', 'false', true)
        })

        /**
         * @tc.number    : TEST_FLIP_CB_003
         * @tc.name      : testFlipCb003
         * @tc.desc      : 1.create pixelmap
         *               : 2.call flip
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testFlipCb003', 0, async function (done) {
            await pixelMapModifySizeTestErr(done, 'testFlipCb003', 'callback', 'flip', 1, true)
        })

        /**
         * @tc.number    : TEST_FLIP_CB_004
         * @tc.name      : testFlipCb004
         * @tc.desc      : 1.create pixelmap
         *               : 2.call flip
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testFlipCb004', 0, async function (done) {
            await pixelMapModifySizeTestErr(done, 'testFlipCb004', 'callback', 'flip', true, { a: 10 })
        })

        /**
         * @tc.number    : TEST_FLIP_CB_005
         * @tc.name      : testFlipCb005
         * @tc.desc      : 1.create pixelmap
         *               : 2.call flip
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testFlipCb005', 0, async function (done) {
            await pixelMapModifySizeTestErr(done, 'testFlipCb005', 'callback', 'flip', true, null)
        })

        /**
         * @tc.number    : TEST_CROP_PROMISE_001
         * @tc.name      : testCropPromise001
         * @tc.desc      : 1.create PixelMap
         *               : 2.crop
         *               : 3.getImageInfo
         *               : 4.getPixelBytesNumber
         *               : 5.readPixelsToBuffer
         * @tc.size      : MEDIUM
         * @tc.type      : Functional
         * @tc.level     : Level 0
         */
        it('testCropPromise001', 0, async function (done) {
            var region = { size: { height: 3, width: 3 }, x: 1, y: 1 };
            function sizeCheck(done, logger, orgInfo, newInfo) {
                orgInfo = region;
                if (newInfo.size.width != orgInfo.size.width) {
                    logger.log(`orgInfo width ${orgInfo.size.width}, new width ${newInfo.size.width} `);
                    expect(false).assertTrue();
                    done();
                }
            }
            await pixelMapModifySizeTest(done, 'testCropPromise001', 'promise', 'crop', sizeCheck, crop3x3, region)
        })

        /**
         * @tc.number    : TEST_CROP_PROMISE_002
         * @tc.name      : testCropPromise002
         * @tc.desc      : 1.create PixelMap
         *               : 2.crop
         *               : 3.getImageInfo
         *               : 4.getPixelBytesNumber
         *               : 5.readPixelsToBuffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testCropPromise002', 0, async function (done) {
            var region = { size: { height: 3, width: 3 }, x: -1, y: 1 };
            await pixelMapModifySizeTestErr(done, 'testCropPromise002', 'promise', 'crop', region)
        })

        /**
         * @tc.number    : TEST_CROP_PROMISE_003
         * @tc.name      : testCropPromise003
         * @tc.desc      : 1.create PixelMap
         *               : 2.crop
         *               : 3.getImageInfo
         *               : 4.getPixelBytesNumber
         *               : 5.readPixelsToBuffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testCropPromise003', 0, async function (done) {
            var region = { size: { height: 3, width: 3 }, x: 1, y: -1 };
            await pixelMapModifySizeTestErr(done, 'v', 'promise', 'crop', region)
        })

        /**
         * @tc.number    : TEST_CROP_PROMISE_004
         * @tc.name      : testCropPromise004
         * @tc.desc      : 1.create PixelMap
         *               : 2.crop
         *               : 3.getImageInfo
         *               : 4.getPixelBytesNumber
         *               : 5.readPixelsToBuffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testCropPromise004', 0, async function (done) {
            var region = { size: { height: 3, width: -3 }, x: 1, y: 1 };
            await pixelMapModifySizeTestErr(done, 'testCropPromise004', 'promise', 'crop', region)
        })

        /**
         * @tc.number    : TEST_CROP_PROMISE_005
         * @tc.name      : testCropPromise005
         * @tc.desc      : 1.create PixelMap
         *               : 2.crop
         *               : 3.getImageInfo
         *               : 4.getPixelBytesNumber
         *               : 5.readPixelsToBuffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testCropPromise005', 0, async function (done) {
            var region = { size: { height: -3, width: 3 }, x: 1, y: 1 };
            await pixelMapModifySizeTestErr(done, 'testCropPromise005', 'promise', 'crop', region)
        })

        /**
         * @tc.number    : TEST_CROP_CB_001
         * @tc.name      : testCropCb001
         * @tc.desc      : 1.create PixelMap
         *               : 2.crop
         *               : 3.getImageInfo
         *               : 4.getPixelBytesNumber
         *               : 5.readPixelsToBuffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testCropCb001', 0, async function (done) {
            var region = { size: { height: 3, width: 3 }, x: 1, y: 1 };
            function sizeCheck(done, logger, orgInfo, newInfo) {
                orgInfo = region;
                if (newInfo.size.width != orgInfo.size.width) {
                    logger.log(`orgInfo width ${orgInfo.size.width}, new width ${newInfo.size.width} `);
                    expect(false).assertTrue();
                    done();
                }
            }
            await pixelMapModifySizeTest(done, 'testCropCb001', 'callback', 'crop', sizeCheck, crop3x3, region)
        })

        /**
         * @tc.number    : TEST_CROP_CB_002
         * @tc.name      : testCropCb002
         * @tc.desc      : 1.create PixelMap
         *               : 2.crop
         *               : 3.getImageInfo
         *               : 4.getPixelBytesNumber
         *               : 5.readPixelsToBuffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testCropCb002', 0, async function (done) {
            var region = { size: { height: 3, width: 3 }, x: -1, y: 1 };
            await pixelMapModifySizeTestErr(done, 'testCropCb002', 'callback', 'crop', region)
        })

        /**
         * @tc.number    : TEST_CROP_CB_003
         * @tc.name      : testCropCb003
         * @tc.desc      : 1.create PixelMap
         *               : 2.crop
         *               : 3.getImageInfo
         *               : 4.getPixelBytesNumber
         *               : 5.readPixelsToBuffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testCropCb003', 0, async function (done) {
            var region = { size: { height: 3, width: 3 }, x: 1, y: -1 };
            await pixelMapModifySizeTestErr(done, 'testCropCb003', 'callback', 'crop', region)
        })

        /**
         * @tc.number    : TEST_CROP_CB_004
         * @tc.name      : testCropCb004
         * @tc.desc      : 1.create PixelMap
         *               : 2.crop
         *               : 3.getImageInfo
         *               : 4.getPixelBytesNumber
         *               : 5.readPixelsToBuffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testCropCb004', 0, async function (done) {
            var region = { size: { height: 3, width: -3 }, x: 1, y: 1 };
            await pixelMapModifySizeTestErr(done, 'testCropCb004', 'callback', 'crop', region)
        })

        /**
         * @tc.number    : TEST_CROP_CB_005
         * @tc.name      : testCropCb005
         * @tc.desc      : 1.create PixelMap
         *               : 2.crop
         *               : 3.getImageInfo
         *               : 4.getPixelBytesNumber
         *               : 5.readPixelsToBuffer
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testCropCb005', 0, async function (done) {
            var region = { size: { height: -3, width: 3 }, x: 1, y: 1 };
            await pixelMapModifySizeTestErr(done, 'testCropCb005', 'callback', 'crop', region)
        })

        /**
         * @tc.number    : test_Release_Promise_001
         * @tc.name      : testReleasePromise001
         * @tc.desc      : 1.create PixelMap
         *                 2.set Pixel
         *                 3.call release
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testReleasePromise001', 0, async function (done) {
            const color = new ArrayBuffer(96);
            let opts = { editable: true, pixelFormat: 3, size: { height: 4, width: 6 } }
            image.createPixelMap(color, opts).then(pixelmap => {
                globalpixelmap = pixelmap;
                if (pixelmap == undefined) {
                    console.info('testReleasePromise001 createPixelMap failed');
                    expect(false).assertTrue()
                    done();
                }
                pixelmap.release().then(() => {
                    console.info('testReleasePromise001 success');
                    expect(true).assertTrue();
                    done();
                }).catch(error => {
                    console.log('testReleasePromise001 error: ' + error);
                    expect().assertFail();
                    done();
                })
            }).catch(error => {
                console.log('testReleasePromise001 createPixelMap failed error: ' + error);
                expect().assertFail();
                done();
            })
        })

        /**
         * @tc.number    : test_Release_Cb_001
         * @tc.name      : testReleaseCb001
         * @tc.desc      : 1.create PixelMap
         *                 2.set Pixel
         *                 3.call release
         * @tc.size      : MediumTest
         * @tc.type      : Function
         * @tc.level     : Level 2
         */
        it('testReleaseCb001', 0, async function (done) {
            const color = new ArrayBuffer(96);
            let opts = { editable: true, pixelFormat: 3, size: { height: 4, width: 6 } }
            image.createPixelMap(color, opts, (err, pixelmap) => {
                globalpixelmap = pixelmap;
                if (pixelmap == undefined) {
                    console.info('testReleaseCb001 createPixelMap failed');
                    expect(false).assertTrue()
                    done();
                }
                pixelmap.release(() => {
                    expect(true).assertTrue();
                    console.log('testReleaseCb001 success');
                    done();
                })
            })
        })
    });
}
