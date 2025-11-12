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

import { describe, it, expect, Level, TestType, Size, beforeAll, beforeEach, afterAll } from '@ohos/hypium';
import photoAccessHelper from '@ohos.file.photoAccessHelper';
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry'
import deviceInfo from '@ohos.deviceInfo';
import { abilityAccessCtrl, common, Permissions, Want } from '@kit.AbilityKit';
import { BusinessError } from '@kit.BasicServicesKit';

const waitReadyMs_100 = 100;
const waitReadyMs_1000 = 1000;
const waitReadyMs_3000 = 3000;

const ERROR_CODE_PARAMETER_ERROR = "401";
const ERROR_CODE_INVALID_ARGUMENT = "13900020";
const ERROR_CODE_INVALID_TITLE = "14000001";

enum Extension {
  PNG = "png",
  GIF = "gif",
  BAD = "bad",
  JPG = "jpg",
  JPEG = "jpeg",
  WEBP = "webp",
  ART = "art",
  AVIF = "avif",
  BMP = "bmp",
  HEIC = "heic",
  HEIF = "heif",
  ICO = "ico",
  PBM = "pbm",
  PNM = "pnm",
  PAT = "pat",
  PCX = "pcx",
  PGM = "pgm",
  PPM = "ppm",
  SVG = "svg",
  TIF = "tif",
  TIFF = "tiff",
  XBM = "xbm",
  JNG = "jng",
  RGB = "rgb",
  SVGZ = "svgz",
  JP2 = "jp2",
  JPE = "jpe",
  _3GPP = "3gpp",
  ASF = "asf",
  AVI = "avi",
  F4v = "f4v",
  FLV = "flv",
  MP4 = "mp4",
  M2TS = "m2ts",
  M4V = "m4v",
  MKV = "mkv",
  MPEG = "mpeg",
  MTS = "mts",
  QT = "qt",
  TS = "ts",
  WMV = "wmv",
  WEBM = "webm",
  MOV = "mov"
}

let wrongTitles: string[] =
  ['wrong_title.', 'wrong_title/', 'wrong_title?', 'wrong_title:', 'wrong_title*', 'wrong_title<', 'wrong_title>',
    'wrong_title[',
    'wrong_title]', 'wrong_title\'', 'wrong_title"', 'wrong_title\\',
    'toolongtitletoolongtitletoolongtitletoolongtitletoolongtitletoolongtitle' +
      'toolongtitletoolongtitletoolongtitletoolongtitletoolongtitletoolongtitletoolongtitletoolongtitle' +
      'toolongtitletoolongtitletoolongtitletoolongtitletoolongtitletoolongtitletoolongtitletoolongtitle' +
      'toolongtitletoolongtitletoolongtitletoolongtitletoolongtitletoolongtitletoolongtitletoolongtitle'];

let wrongExtensions: (string | null)[] = ['png.', ' png', 'png1', '@@@', '', '///',
  'pngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpng' +
    'pngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpnpngpng' +
    'pngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpngpng'];

let wrongPhotoTypes: photoAccessHelper.PhotoType[] = [-1, 0, 3, Number.MAX_VALUE, Number.MIN_VALUE];

let context: Context;
let phAccessHelper: photoAccessHelper.PhotoAccessHelper;
let osFullNameInfo: string = deviceInfo.osFullName;
let platform = osFullNameInfo.split(' ')[0];
const delegator = abilityDelegatorRegistry.getAbilityDelegator();

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function checkUri(uri: string | undefined): boolean {
  if (uri === undefined || typeof uri !== 'string') {
    return false;
  }
  if (platform === 'Android') {
    return uri.startsWith('content://media/external');
  } else {
    return uri.startsWith('file://media/Photo');
  }
}

async function startAbility(bundleName: string, abilityName: string) {
  let want: Want = {
    bundleName: `${bundleName}`,
    abilityName: `${abilityName}`,
    moduleName: "entry"
  };
  await delegator.startAbility(want).then(result => {
    console.info(`MeasureTest, start abilityFinished: ${result}`)
  }).catch((err: object) => {
    console.error(`MeasureTest, start abilityFailed: ${err}`)
  })
  await sleep(waitReadyMs_1000);
}

async function createAssetCallbackWithOption(photoType: photoAccessHelper.PhotoType | null, extension: string | null,
  options: photoAccessHelper.CreateOptions): Promise<string> {
  return new Promise((resolve, reject) => {
    phAccessHelper.createAsset(photoType, extension, options, async (err, uri) => {
      if (checkUri(uri)) {
        resolve(uri);
      } else {
        console.error(`createAssetCallbackWithOption fail with error:${err.code},${err.message}`);
        reject(err);
      }
    })
  });
}

async function createAssetCallbackWithoutOptions(photoType: photoAccessHelper.PhotoType | null,
  extension: string | null): Promise<string> {
  return new Promise((resolve, reject) => {
    phAccessHelper.createAsset(photoType, extension, async (err, uri) => {
      if (checkUri(uri)) {
        resolve(uri);
      } else {
        console.error(`createAssetCallbackWithoutOptions fail with error:${err.code},${err.message}`);
        reject(err);
      }
    })
  });
}

async function CreateAssetPromise(photoType: photoAccessHelper.PhotoType | null, extension: string | null,
  options: photoAccessHelper.CreateOptions): Promise<string> {
  return new Promise((resolve, reject) => {
    phAccessHelper.createAsset(photoType, extension, options).then((uri) => {
      if (checkUri(uri)) {
        resolve(uri);
      }
    }).catch((err: BusinessError) => {
      console.error(`CreateAssetPromise fail with error: ${err.code}, ${err.message}`);
      reject(err);
    })
  });
}

const permissions: Array<Permissions> = ['ohos.permission.WRITE_IMAGEVIDEO'];

function reqPermissionsFromUser(permissions: Array<Permissions>, context: common.UIAbilityContext): Promise<boolean> {
    return new Promise((resolve, reject) => {
      try {
        let atManager: abilityAccessCtrl.AtManager = abilityAccessCtrl.createAtManager();
        atManager.requestPermissionsFromUser(context, permissions)
          .then((data) => {
            let grantStatus: Array<number> = data.authResults;
            let allGranted = grantStatus.every(status => status === 0);
            if (allGranted) {
              resolve(true);
            }
          }).catch((err: BusinessError) => {
          reject(new Error('permission denied'));
        });
      } catch (err) {
        reject(new Error('permission denied'));
      }
    });
  }

export default function CreateAssetTest() {
  describe('CreateAssetTest', () => {
    beforeAll(async () => {
      await startAbility('com.example.createassettest_oh', 'EntryAbility');
      await sleep(waitReadyMs_3000);
      console.log("XTS platfrom is " + platform);
      context = getContext();
      phAccessHelper = photoAccessHelper.getPhotoAccessHelper(context);
      try {
        await reqPermissionsFromUser(permissions, context as common.UIAbilityContext).then((isGranted)=>{
          if(isGranted) {
            console.log("XTS get permission");
          } else {
            console.log("XTS no permission");
          }
        }).catch((err:BusinessError)=>{
          console.log("XTS no permission:" + err.message);
        })
      } catch (err) {
        console.log("XTS no permission:" + err.message);
      }
    })
    beforeEach(async () => {
      await sleep(waitReadyMs_100);
    })
    afterAll(async () => {
      await sleep(waitReadyMs_1000);
    })
    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_0100
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_0100
     * @tc.desc Test the function createAsset-Callback-Options photoType is IMAGE
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_0100', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL0,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {

          let phototype = photoAccessHelper.PhotoType.IMAGE;
          let extension: string = Extension.PNG;
          let title: string = "createAsset_Func_0100";
          let options: photoAccessHelper.CreateOptions = {
            title: title
          }
          await createAssetCallbackWithOption(phototype, extension, options).then((uri) => {
            expect(checkUri(uri)).assertTrue();
          }).catch((err: BusinessError) => {
            expect().assertFail();
          })
        } catch (error) {
          console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_0100 error: ${error.code}, ${error.message}`);
          expect().assertFail();
        }
        done();
      }
    )

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_0200
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_0200
     * @tc.desc Test the function createAsset-Callback photoType is IMAGE
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_0200', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL0,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {
          let phototype = photoAccessHelper.PhotoType.IMAGE;
          let extension: string = Extension.PNG;
          await createAssetCallbackWithoutOptions(phototype, extension).then((uri) => {
            expect(checkUri(uri)).assertTrue();
          }).catch((err: BusinessError) => {
            expect().assertFail();
          })
        } catch (error) {
          console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_0200 error: ${error.code}, ${error.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_0300
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_0300
     * @tc.desc Test the function createAsset-Promise photoType is IMAGE
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_0300', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL0,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {
          let phototype = photoAccessHelper.PhotoType.IMAGE;
          let extension: string = Extension.PNG;
          let title: string = "createAsset_Func_0300";
          let options: photoAccessHelper.CreateOptions = {
            title: title
          }
          await CreateAssetPromise(phototype, extension, options).then((uri) => {
            expect(checkUri(uri)).assertTrue();
          }).catch((err: BusinessError) => {
            expect().assertFail();
          })
        } catch (error) {
          console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_0300 error: ${error.code}, ${error.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_0400
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_0400
     * @tc.desc Test the function createAsset-Callback-Options photoType is VIDEO
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_0400', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL0,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {
          let phototype = photoAccessHelper.PhotoType.VIDEO;
          let extension: string = Extension.MP4;
          let title: string = "createAsset_Func_0400";
          let options: photoAccessHelper.CreateOptions = {
            title: title
          }
          await createAssetCallbackWithOption(phototype, extension, options).then((uri) => {
            expect(checkUri(uri)).assertTrue();
          }).catch((err: BusinessError) => {
            expect().assertFail();
          })
        } catch (error) {
          console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_0400 error: ${error.code}, ${error.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_0500
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_0500
     * @tc.desc Test the function createAsset-Callback photoType is VIDEO
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_0500', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL0,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {
          let phototype = photoAccessHelper.PhotoType.VIDEO;
          let extension: string = Extension.MP4;
          await createAssetCallbackWithoutOptions(phototype, extension).then((uri) => {
            expect(checkUri(uri)).assertTrue();
          }).catch((err: BusinessError) => {
            expect().assertFail();
          })
        } catch (error) {
          console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_0500 error: ${error.code}, ${error.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_0600
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_0600
     * @tc.desc Test the function createAsset-Promise photoType is VIDEO
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_0600', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL0,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {
          let phototype = photoAccessHelper.PhotoType.VIDEO;
          let extension: string = Extension.MP4;
          let title: string = "createAsset_Func_0600";
          let options: photoAccessHelper.CreateOptions = {
            title: title
          }
          await phAccessHelper.createAsset(phototype, extension, options).then((uri) => {
            expect(checkUri(uri)).assertTrue();
          }).catch((err: BusinessError) => {
            expect().assertFail();
          })
        } catch (error) {
          console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_0600 error: ${error.code}, ${error.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_0700
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_0700
     * @tc.desc Test the function createAsset-Callback-Options photoType is NULL
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_0700', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL1,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {
          let phototype = null;
          let extension: string = Extension.PNG;
          let title: string = "createAsset_Func_0700";
          let options: photoAccessHelper.CreateOptions = {
            title: title
          }
          await createAssetCallbackWithOption(phototype, extension, options).then((uri) => {
            expect().assertFail();
          }).catch((err: BusinessError) => {
            expect(err.code).assertEqual(ERROR_CODE_INVALID_ARGUMENT);
          })
        } catch (error) {
          expect().assertFail();
          console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_0700 error: ${error.code}, ${error.message}`);
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_0800
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_0800
     * @tc.desc Test the function createAsset-Callback photoType is NULL
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_0800', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL1,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {
          let phototype = null;
          let extension: string = Extension.PNG;
          await createAssetCallbackWithoutOptions(phototype, extension).then((uri) => {
            expect().assertFail();
          }).catch((err: BusinessError) => {
            expect(err.code).assertEqual(ERROR_CODE_INVALID_ARGUMENT);
          })
        } catch (error) {
          expect().assertFail();
          console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_0800 error: ${error.code}, ${error.message}`);
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_0900
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_0900
     * @tc.desc Test the function createAsset-Promise photoType is NULL
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_0900', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL1,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {
          let phototype = null;
          let extension: string = Extension.PNG;
          let title: string = "createAsset_Func_0900";
          let options: photoAccessHelper.CreateOptions = {
            title: title
          }
          await phAccessHelper.createAsset(phototype, extension, options).then((uri) => {
            expect().assertFail();
          }).catch((err: BusinessError) => {
            expect().assertFail();
            console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_0900 error: ${err.code}, ${err.message}`);
          })
        } catch (error) {
          expect(error.code).assertEqual(ERROR_CODE_INVALID_ARGUMENT);
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_1000
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_1000
     * @tc.desc Test the function createAsset-Callback-Options Wrong photoType
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_1000', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL1,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        for (const photoType of wrongPhotoTypes) {
          try {
            let extension: string = Extension.PNG;
            let title: string = "createAsset_Func_1000";
            let options: photoAccessHelper.CreateOptions = {
              title: title
            }
            await createAssetCallbackWithOption(photoType, extension, options).then((uri) => {
              expect().assertFail();
            }).catch((err: BusinessError) => {
              expect(err.code).assertEqual(ERROR_CODE_INVALID_ARGUMENT);
            })
          } catch (error) {
            expect().assertFail();
            console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_1000 error: ${error.code}, ${error.message}`);
          }
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_1100
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_1100
     * @tc.desc Test the function createAsset-Callback Wrong photoType
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_1100', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL1,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        for (const photoType of wrongPhotoTypes) {
          try {
            let extension: string = Extension.PNG;
            await createAssetCallbackWithoutOptions(photoType, extension).then((uri) => {
              expect().assertFail();
            }).catch((err: BusinessError) => {
              expect(err.code).assertEqual(ERROR_CODE_INVALID_ARGUMENT);
            })
          } catch (error) {
            expect().assertFail();
            console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_1100 error: ${error.code}, ${error.message}`);
          }
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_1200
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_1200
     * @tc.desc Test the function createAsset-Promise Wrong photoType
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_1200', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL1,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        for (const photoType of wrongPhotoTypes) {
          try {
            let extension: string = Extension.PNG;
            let title: string = "createAsset_Func_1200";
            let options: photoAccessHelper.CreateOptions = {
              title: title
            }
            await phAccessHelper.createAsset(photoType, extension, options).then((uri) => {
              expect().assertFail();
            }).catch((err: BusinessError) => {
              expect().assertFail();
              console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_1200 error: ${err.code}, ${err.message}`);
            })
          } catch (error) {
            expect(error.code).assertEqual(ERROR_CODE_INVALID_ARGUMENT);
          }
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_1300
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_1300
     * @tc.desc Test the function createAsset-Callback-Options support IMAGE extension
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_1300', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL0,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        let imgExtensions: string[] = [];
        if (platform === 'Android') {
          imgExtensions = [Extension.JPG, Extension.JPEG, Extension.GIF, Extension.WEBP];
        } else {
          imgExtensions = [Extension.JPG, Extension.PNG, Extension.GIF, Extension.TIFF, Extension.TIF];
        }
        for (const extension of imgExtensions) {
          try {
            let phototype = photoAccessHelper.PhotoType.IMAGE;
            let title: string = "createAsset_Func_1300_" + extension;
            let options: photoAccessHelper.CreateOptions = {
              title: title
            }
            await createAssetCallbackWithOption(phototype, extension, options).then((uri) => {
              expect(checkUri(uri)).assertTrue();
            }).catch((err: BusinessError) => {
              expect().assertFail();
              console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_1300 error: ${err.code}, ${err.message}`);
            })
          } catch (error) {
            expect().assertFail();
            console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_1300 error: ${error.code}, ${error.message}`);
          }
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_1400
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_1400
     * @tc.desc Test the function createAsset-Callback support IMAGE extension
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_1400', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL0,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        let imgExtensions: string[] = [];
        if (platform === 'Android') {
          imgExtensions = [Extension.JPG, Extension.JPEG, Extension.GIF, Extension.WEBP];
        } else {
          imgExtensions = [Extension.JPG, Extension.PNG, Extension.GIF, Extension.TIFF, Extension.TIF];
        }

        for (const extension of imgExtensions) {
          try {
            let phototype = photoAccessHelper.PhotoType.IMAGE;
            await createAssetCallbackWithoutOptions(phototype, extension).then((uri) => {
              expect(checkUri(uri)).assertTrue();
            }).catch((err: BusinessError) => {
              expect().assertFail();
              console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_1400 error: ${err.code}, ${err.message}`);
            })
          } catch (error) {
            expect().assertFail();
            console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_1400 error: ${error.code}, ${error.message}`);
          }
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_1500
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_1500
     * @tc.desc Test the function createAsset-Promise support IMAGE extension
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_1500', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL0,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        let imgExtensions: string[] = [];
        if (platform === 'Android') {
          imgExtensions = [Extension.JPG, Extension.JPEG, Extension.GIF, Extension.WEBP];
        } else {
          imgExtensions = [Extension.JPG, Extension.PNG, Extension.GIF, Extension.TIFF, Extension.TIF];
        }

        for (const extension of imgExtensions) {
          try {
            let phototype = photoAccessHelper.PhotoType.IMAGE;
            let title: string = "createAsset_Func_1500_" + extension;
            let options: photoAccessHelper.CreateOptions = {
              title: title
            }
            await phAccessHelper.createAsset(phototype, extension, options).then((uri) => {
              expect(checkUri(uri)).assertTrue();
            }).catch((error: BusinessError) => {
              expect().assertFail();
              console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_1500 error: ${error.code}, ${error.message}`);
            })
          } catch (error) {
            expect().assertFail();
            console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_1500 error: ${error.code}, ${error.message}`);
          }
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_1600
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_1600
     * @tc.desc Test the function createAsset-Callback-Options support VIDEO extension
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_1600', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL0,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        let vidExtensions: string[] = [];
        if (platform === 'Android') {
          vidExtensions = [Extension.MP4, Extension.M4V, Extension.MOV, Extension._3GPP, Extension.AVI];
        } else {
          vidExtensions = [Extension.MP4, Extension.M4V, Extension.MOV, Extension._3GPP, Extension.AVI];
        }
        for (const extension of vidExtensions) {
          try {
            let phototype = photoAccessHelper.PhotoType.VIDEO;
            let title: string = "createAsset_Func_1600_" + extension;
            let options: photoAccessHelper.CreateOptions = {
              title: title
            }
            await createAssetCallbackWithOption(phototype, extension, options).then((uri) => {
              expect(checkUri(uri)).assertTrue();
            }).catch((err: BusinessError) => {
              expect().assertFail();
              console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_1600 error: ${err.code}, ${err.message}`);
            })
          } catch (error) {
            expect().assertFail();
            console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_1600 error: ${error.code}, ${error.message}`);
          }
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_1700
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_1700
     * @tc.desc Test the function createAsset-Callback support VIDEO extension
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_1700', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL0,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        let vidExtensions: string[] = [];
        if (platform === 'Android') {
          vidExtensions = [Extension.MP4, Extension.M4V, Extension.MOV, Extension._3GPP, Extension.AVI];
        } else {
          vidExtensions = [Extension.MP4, Extension.M4V, Extension.MOV, Extension._3GPP, Extension.AVI];
        }

        for (const extension of vidExtensions) {
          try {
            let phototype = photoAccessHelper.PhotoType.VIDEO;
            await createAssetCallbackWithoutOptions(phototype, extension).then((uri) => {
              expect(checkUri(uri)).assertTrue();
            }).catch((err: BusinessError) => {
              expect().assertFail();
              console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_1700 error: ${err.code}, ${err.message}`);
            })
          } catch (error) {
            expect().assertFail();
            console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_1700 error: ${error.code}, ${error.message}`);
          }
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_1800
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_1800
     * @tc.desc Test the function createAsset-Promise support VIDEO extension
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_1800', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL0,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        let vidExtensions: string[] = [];
        if (platform === 'Android') {
          vidExtensions = [Extension.MP4, Extension.M4V, Extension.MOV, Extension._3GPP, Extension.AVI];
        } else {
          vidExtensions = [Extension.MP4, Extension.M4V, Extension.MOV, Extension._3GPP, Extension.AVI];
        }

        for (const extension of vidExtensions) {
          try {
            let phototype = photoAccessHelper.PhotoType.VIDEO;
            let title: string = "createAsset_Func_1800_" + extension;
            let options: photoAccessHelper.CreateOptions = {
              title: title
            }
            await phAccessHelper.createAsset(phototype, extension, options).then((uri) => {
              expect(checkUri(uri)).assertTrue();
            }).catch((error: BusinessError) => {
              expect().assertFail();
              console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_1800 error: ${error.code}, ${error.message}`);
            })
          } catch (error) {
            expect().assertFail();
            console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_1800 error: ${error.code}, ${error.message}`);
          }
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_1900
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_1900
     * @tc.desc Test the function createAsset-Callback-Options extension is null
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_1900', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL1,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {
          let phototype = photoAccessHelper.PhotoType.IMAGE;
          let extension: string | null = null;
          let title: string = "createAsset_Func_1900";
          let options: photoAccessHelper.CreateOptions = {
            title: title
          }
          await createAssetCallbackWithOption(phototype, extension, options).then((uri) => {
            expect().assertFail();
          }).catch((err: BusinessError) => {
            expect(err.code).assertEqual(ERROR_CODE_INVALID_ARGUMENT);
          })
        } catch (error) {
          expect().assertFail();
          console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_1900 error: ${error.code}, ${error.message}`);
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_2000
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_2000
     * @tc.desc Test the function createAsset-Callback extension is null
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_2000', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL1,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {
          let phototype = photoAccessHelper.PhotoType.IMAGE;
          let extension: string | null = null;
          await createAssetCallbackWithoutOptions(phototype, extension).then((uri) => {
            expect().assertFail();
          }).catch((err: BusinessError) => {
            expect(err.code).assertEqual(ERROR_CODE_INVALID_ARGUMENT);
          })
        } catch (error) {
          expect().assertFail();
          console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_2000 error: ${error.code}, ${error.message}`);
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_2100
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_2100
     * @tc.desc Test the function createAsset-Promise extension is null
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_2100', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL1,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {
          let phototype = photoAccessHelper.PhotoType.IMAGE;
          let extension: string | null = null;
          let title: string = "createAsset_Func_2100";
          let options: photoAccessHelper.CreateOptions = {
            title: title
          }
          await phAccessHelper.createAsset(phototype, extension, options).then((uri) => {
            expect().assertFail();
          }).catch((error: BusinessError) => {
              expect().assertFail();
              console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_2100 error: ${error.code}, ${error.message}`);
            })
          expect().assertFail();
        } catch (error) {
          expect(error.code).assertEqual(ERROR_CODE_INVALID_ARGUMENT);
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_2200
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_2200
     * @tc.desc Test the function createAsset-Callback-Options title is default image
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_2200', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL0,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {
          let phototype = photoAccessHelper.PhotoType.IMAGE;
          let extension: string = Extension.PNG;
          let options: photoAccessHelper.CreateOptions = {}
          await createAssetCallbackWithOption(phototype, extension, options).then((uri) => {
            expect(checkUri(uri)).assertTrue();
          }).catch((err: BusinessError) => {
            expect().assertFail();
            console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_2200 error: ${err.code}, ${err.message}`);
          })
        } catch (error) {
          expect().assertFail();
          console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_2200 error: ${error.code}, ${error.message}`);
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_2300
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_2300
     * @tc.desc Test the function createAsset-Callback title is default image
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_2300', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL0,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {
          let phototype = photoAccessHelper.PhotoType.IMAGE;
          let extension: string = Extension.PNG;
          await createAssetCallbackWithoutOptions(phototype, extension).then((uri) => {
            expect(checkUri(uri)).assertTrue();
          }).catch((err: BusinessError) => {
            expect().assertFail();
            console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_2300 error: ${err.code}, ${err.message}`);
          })
        } catch (error) {
          expect().assertFail();
          console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_2300 error: ${error.code}, ${error.message}`);
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_2400
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_2400
     * @tc.desc Test the function createAsset-Promise title is default image
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_2400', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL0,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {
          let phototype = photoAccessHelper.PhotoType.IMAGE;
          let extension: string = Extension.PNG;
          let options: photoAccessHelper.CreateOptions = {}
          await phAccessHelper.createAsset(phototype, extension, options).then((uri) => {
            expect(checkUri(uri)).assertTrue();
          }).catch((error: BusinessError) => {
            expect().assertFail();
            console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_2400 error: ${error.code}, ${error.message}`);
          })
        } catch (error) {
          console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_2400 error: ${error.code}, ${error.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_2500
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_2500
     * @tc.desc Test the function createAsset-Callback-Options title is default video
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_2500', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL0,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {
          let phototype = photoAccessHelper.PhotoType.VIDEO;
          let extension: string = Extension.MP4;
          let options: photoAccessHelper.CreateOptions = {}
          await createAssetCallbackWithOption(phototype, extension, options).then((uri) => {
            expect(checkUri(uri)).assertTrue();
          }).catch((err: BusinessError) => {
            expect().assertFail();
            console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_2500 error: ${err.code}, ${err.message}`);
          })
        } catch (error) {
          expect().assertFail();
          console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_2500 error: ${error.code}, ${error.message}`);
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_2600
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_2600
     * @tc.desc Test the function createAsset-Callback title is default video
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_2600', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL0,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {
          let phototype = photoAccessHelper.PhotoType.VIDEO;
          let extension: string = Extension.MP4;
          await createAssetCallbackWithoutOptions(phototype, extension).then((uri) => {
            expect(checkUri(uri)).assertTrue();
          }).catch((err: BusinessError) => {
            expect().assertFail();
            console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_2600 error: ${err.code}, ${err.message}`);
          })
        } catch (error) {
          expect().assertFail();
          console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_2600 error: ${error.code}, ${error.message}`);
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_2700
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_2700
     * @tc.desc Test the function createAsset-Promise title is default video
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_2700', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL0,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {
          let phototype = photoAccessHelper.PhotoType.VIDEO;
          let extension: string = Extension.MP4;
          let options: photoAccessHelper.CreateOptions = {}
          await phAccessHelper.createAsset(phototype, extension, options).then((uri) => {
            expect(checkUri(uri)).assertTrue();
          }).catch((error: BusinessError) => {
            expect().assertFail();
            console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_2700 error: ${error.code}, ${error.message}`);
          })
        } catch (error) {
          console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_2700 error: ${error.code}, ${error.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_2800
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_2800
     * @tc.desc Test the function createAsset-Callback-Options title is bad
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_2800', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL0,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        for (const title of wrongTitles) {
          try {
            let phototype = photoAccessHelper.PhotoType.VIDEO;
            let extension: string = Extension.MP4;
            let options: photoAccessHelper.CreateOptions = {
              title: title
            }
            await createAssetCallbackWithOption(phototype, extension, options).then((uri) => {
              expect().assertFail();
            }).catch((err: BusinessError) => {
              expect(err.code).assertEqual(ERROR_CODE_INVALID_TITLE);
            })
          } catch (error) {
            expect().assertFail();
            console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_2800
                wrongtitle: ${title} error: ${error.code}, ${error.message}`);
          }
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_2900
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_2900
     * @tc.desc Test the function createAsset-Promise title is bad
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_2900', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL0,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        for (const title of wrongTitles) {
          try {
            let phototype = photoAccessHelper.PhotoType.VIDEO;
            let extension: string = Extension.MP4;
            let options: photoAccessHelper.CreateOptions = {
              title: title
            }
            await phAccessHelper.createAsset(phototype, extension, options).then((uri) => {
              expect().assertFail();
            }).catch((error: BusinessError) => {
              expect(error.code).assertEqual(ERROR_CODE_INVALID_TITLE);
            })
          } catch (error) {
            expect().assertFail();
            console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_2900
                wrongtitle: ${title} error: ${error.code}, ${error.message}`);
          }
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_3000
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_3000
     * @tc.desc Test the function createAsset-Callback-Options photoType-IMAGE extension not suit
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_3000', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL2,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {
          let phototype = photoAccessHelper.PhotoType.IMAGE;
          let extension: string | null = Extension.MP4;
          let title: string = "createAsset_Func_3000";
          let options: photoAccessHelper.CreateOptions = {
            title: title
          }
          await createAssetCallbackWithOption(phototype, extension, options).then((uri) => {
            expect().assertFail();
          }).catch((err: BusinessError) => {
            expect(err.code).assertEqual(ERROR_CODE_PARAMETER_ERROR);
          })
        } catch (error) {
          expect().assertFail();
          console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_3000 error: ${error.code}, ${error.message}`);
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_3100
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_3100
     * @tc.desc Test the function createAsset-Callback photoType-IMAGE extension not suit
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_3100', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL2,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {
          let phototype = photoAccessHelper.PhotoType.IMAGE;
          let extension: string | null = Extension.MP4;
          await createAssetCallbackWithoutOptions(phototype, extension).then((uri) => {
            expect().assertFail();
          }).catch((err: BusinessError) => {
            expect(err.code).assertEqual(ERROR_CODE_PARAMETER_ERROR);
          })
        } catch (error) {
          expect().assertFail();
          console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_3100 error: ${error.code}, ${error.message}`);
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_3200
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_3200
     * @tc.desc Test the function createAsset-Promise photoType-IMAGE extension not suit
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_3200', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL2,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {
          let phototype = photoAccessHelper.PhotoType.IMAGE;
          let extension: string | null = Extension.MP4;
          let title: string = "createAsset_Func_3200";
          let options: photoAccessHelper.CreateOptions = {
            title: title
          }
          await phAccessHelper.createAsset(phototype, extension, options).then((uri) => {
            expect().assertFail();
          }).catch((error: BusinessError) => {
            expect().assertFail();
            console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_3200 error: ${error.code}, ${error.message}`);
          })
          expect().assertFail();
        } catch (error) {
          expect(error.code).assertEqual(ERROR_CODE_PARAMETER_ERROR);
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_3300
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_3300
     * @tc.desc Test the function createAsset-Callback-Options photoType-VIDEO extension not suit
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_3300', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL2,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {
          let phototype = photoAccessHelper.PhotoType.VIDEO;
          let extension: string | null = Extension.PNG;
          let title: string = "createAsset_Func_3300";
          let options: photoAccessHelper.CreateOptions = {
            title: title
          }
          await createAssetCallbackWithOption(phototype, extension, options).then((uri) => {
            expect().assertFail();
          }).catch((err: BusinessError) => {
            expect(err.code).assertEqual(ERROR_CODE_PARAMETER_ERROR);
          })
        } catch (error) {
          expect().assertFail();
          console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_3300 error: ${error.code}, ${error.message}`);
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_3400
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_3400
     * @tc.desc Test the function createAsset-Callback photoType-VIDEO extension not suit
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_3400', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL2,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {
          let phototype = photoAccessHelper.PhotoType.VIDEO;
          let extension: string | null = Extension.PNG;
          await createAssetCallbackWithoutOptions(phototype, extension).then((uri) => {
            expect().assertFail();
          }).catch((err: BusinessError) => {
            expect(err.code).assertEqual(ERROR_CODE_PARAMETER_ERROR);
          })
        } catch (error) {
          expect().assertFail();
          console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_3400 error: ${error.code}, ${error.message}`);
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_3500
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_3500
     * @tc.desc Test the function createAsset-Promise photoType-VIDEO extension not suit
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_3500', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL2,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        try {
          let phototype = photoAccessHelper.PhotoType.VIDEO;
          let extension: string | null = Extension.PNG;
          let title: string = "createAsset_Func_3500";
          let options: photoAccessHelper.CreateOptions = {
            title: title
          }
          await phAccessHelper.createAsset(phototype, extension, options).then((uri) => {
            expect().assertFail();
          }).catch((error: BusinessError) => {
            expect().assertFail();
            console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_3500 error: ${error.code}, ${error.message}`);
          })
          expect().assertFail();
        } catch (error) {
          expect(error.code).assertEqual(ERROR_CODE_PARAMETER_ERROR);
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_3600
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_3600
     * @tc.desc Test the function createAsset-Callback-Options extension is bad
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_3600', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL1,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        for (const extension of wrongExtensions) {
          try {
            let phototype = photoAccessHelper.PhotoType.IMAGE;
            let title: string = "createAsset_Func_3600";
            let options: photoAccessHelper.CreateOptions = {
              title: title
            }
            await createAssetCallbackWithOption(phototype, extension, options).then((uri) => {
              expect().assertFail();
            }).catch((err: BusinessError) => {
              expect(err.code).assertEqual(ERROR_CODE_PARAMETER_ERROR);
            })
          } catch (error) {
            expect().assertFail();
            console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_3600 error: ${error.code}, ${error.message}`);
          }
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_3700
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_3700
     * @tc.desc Test the function createAsset-Callback extension is bad
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_3700', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL1,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        for (const extension of wrongExtensions) {
          try {
            let phototype = photoAccessHelper.PhotoType.IMAGE;
            await createAssetCallbackWithoutOptions(phototype, extension).then((uri) => {
              expect().assertFail();
            }).catch((err: BusinessError) => {
              expect(err.code).assertEqual(ERROR_CODE_PARAMETER_ERROR);
            })
          } catch (error) {
            expect().assertFail();
            console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_3700 error: ${error.code}, ${error.message}`);
          }
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_3800
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_3800
     * @tc.desc Test the function createAsset-Promise extension is bad
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 1
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_3800', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL1,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        for (const extension of wrongExtensions) {
          try {
            let phototype = photoAccessHelper.PhotoType.IMAGE;
            let title: string = "createAsset_Func_3800";
            let options: photoAccessHelper.CreateOptions = {
              title: title
            }
            await phAccessHelper.createAsset(phototype, extension, options).then((uri) => {
              expect().assertFail();
            }).catch((error: BusinessError) => {
              expect().assertFail();
              console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_3800
                extension: ${extension} error: ${error.code}, ${error.message}`);
            })
            expect().assertFail();
          } catch (error) {
            expect(error.code).assertEqual(ERROR_CODE_PARAMETER_ERROR);
          }
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_3900
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_3900
     * @tc.desc Test the function createAsset-Callback-Options photoType-bad extension-bad
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_3900', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL2,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        for (const extension of wrongExtensions) {
          for (const phototype of wrongPhotoTypes) {
            try {
              let title: string = "createAsset_Func_3900";
              let options: photoAccessHelper.CreateOptions = {
                title: title
              }
              await createAssetCallbackWithOption(phototype, extension, options).then((uri) => {
                expect().assertFail();
              }).catch((err: BusinessError) => {
                expect(err.code).assertEqual(ERROR_CODE_INVALID_ARGUMENT);
              })
            } catch (error) {
              expect().assertFail();
              console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_3900 error: ${error.code}, ${error.message}`);
            }
          }
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_4000
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_4000
     * @tc.desc Test the function createAsset-Callback photoType-bad extension-bad
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_4000', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL2,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        for (const extension of wrongExtensions) {
          for (const phototype of wrongPhotoTypes) {
            try {
              await createAssetCallbackWithoutOptions(phototype, extension).then((uri) => {
                expect().assertFail();
              }).catch((err: BusinessError) => {
                expect(err.code).assertEqual(ERROR_CODE_INVALID_ARGUMENT);
              })
            } catch (error) {
              expect().assertFail();
              console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_4000 error: ${error.code}, ${error.message}`);
            }
          }
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_4100
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_4100
     * @tc.desc Test the function createAsset-Promise photoType-bad extension-bad
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_4100', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL2,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        for (const extension of wrongExtensions) {
          for (const phototype of wrongPhotoTypes) {
            try {
              let title: string = "createAsset_Func_4100";
              let options: photoAccessHelper.CreateOptions = {
                title: title
              }
              await phAccessHelper.createAsset(phototype, extension, options).then((uri) => {
                expect().assertFail();
              }).catch((error: BusinessError) => {
                expect().assertFail();
                console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_4100 error: ${error.code}, ${error.message}`);
              })
            } catch (error) {
              expect(error.code).assertEqual(ERROR_CODE_INVALID_ARGUMENT);
            }
          }
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_4200
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_4200
     * @tc.desc Test the function createAsset-Callback-Options photoType-bad title-bad
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_4200', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL2,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        for (const title of wrongTitles) {
          for (const phototype of wrongPhotoTypes) {
            try {
              let extension: string = Extension.PNG;
              let options: photoAccessHelper.CreateOptions = {
                title: title
              }
              await createAssetCallbackWithOption(phototype, extension, options).then((uri) => {
                expect().assertFail();
              }).catch((err: BusinessError) => {
                expect(err.code).assertEqual(ERROR_CODE_INVALID_ARGUMENT);
              })
            } catch (error) {
              expect().assertFail();
              console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_4200 error: ${error.code}, ${error.message}`);
            }
          }
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_4300
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_4300
     * @tc.desc Test the function createAsset-Promise photoType-bad title-bad
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_4300', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL2,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        for (const title of wrongTitles) {
          for (const phototype of wrongPhotoTypes) {
            try {
              let extension: string = Extension.PNG;
              let options: photoAccessHelper.CreateOptions = {
                title: title
              }
              await phAccessHelper.createAsset(phototype, extension, options).then((uri) => {
                expect().assertFail();
              }).catch((error: BusinessError) => {
                expect().assertFail();
                console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_4300 error: ${error.code}, ${error.message}`);
              })
            } catch (error) {
              expect(error.code).assertEqual(ERROR_CODE_INVALID_ARGUMENT);
            }
          }
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_4400
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_4400
     * @tc.desc Test the function createAsset-Callback-Options extension-bad title-bad
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_4400', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL2,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        for (const title of wrongTitles) {
          for (const extension of wrongExtensions) {
            try {
              let phototype = photoAccessHelper.PhotoType.IMAGE;
              let options: photoAccessHelper.CreateOptions = {
                title: title
              }
              await createAssetCallbackWithOption(phototype, extension, options).then((uri) => {
                expect().assertFail();
              }).catch((err: BusinessError) => {
                expect(err.code).assertEqual(ERROR_CODE_PARAMETER_ERROR);
              })
            } catch (error) {
              expect().assertFail();
              console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_4400 error: ${error.code}, ${error.message}`);
            }
          }
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_4500
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_4500
     * @tc.desc Test the function createAsset-Promise extension-bad title-bad
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_4500', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL2,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        for (const title of wrongTitles) {
          for (const extension of wrongExtensions) {
            try {
              let phototype = photoAccessHelper.PhotoType.IMAGE;
              let options: photoAccessHelper.CreateOptions = {
                title: title
              }
              await phAccessHelper.createAsset(phototype, extension, options).then((uri) => {
                expect().assertFail();
              }).catch((error: BusinessError) => {
                expect().assertFail();
                console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_4500 error: ${error.code}, ${error.message}`);
              })
            } catch (error) {
              expect(error.code).assertEqual(ERROR_CODE_PARAMETER_ERROR);
            }
          }
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_4600
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_4600
     * @tc.desc Test the function createAsset-Callback-Options photoType-bad extension-bad title-bad
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_4600', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL2,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        for (const title of wrongTitles) {
          for (const extension of wrongExtensions) {
            for (const phototype of wrongPhotoTypes) {
              try {
                let options: photoAccessHelper.CreateOptions = {
                  title: title
                }
                await createAssetCallbackWithOption(phototype, extension, options).then((uri) => {
                  expect().assertFail();
                }).catch((err: BusinessError) => {
                  expect(err.code).assertEqual(ERROR_CODE_INVALID_ARGUMENT);
                })
              } catch (error) {
                expect().assertFail();
                console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_4600 error: ${error.code}, ${error.message}`);
              }
            }
          }
        }
        done();
      })

    /**
     * @tc.number ArkUIX_PhotoAccessHelper_createAsset_Func_4700
     * @tc.name ArkUIX_PhotoAccessHelper_createAsset_Func_4700
     * @tc.desc Test the function createAsset-Promise photoType-bad extension-bad title-bad
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 2
     */
    it('ArkUIX_PhotoAccessHelper_createAsset_Func_4700', Size.MEDIUMTEST | TestType.FUNCTION | Level.LEVEL2,
      async (done: Function) => {
        if (platform === 'iOS') {
          done();
          return;
        }
        for (const title of wrongTitles) {
          for (const extension of wrongExtensions) {
            for (const phototype of wrongPhotoTypes) {
              try {
                let options: photoAccessHelper.CreateOptions = {
                  title: title
                }
                await phAccessHelper.createAsset(phototype, extension, options).then((uri) => {
                  expect().assertFail();
                }).catch((error: BusinessError) => {
                  expect().assertFail();
                  console.error(`ArkUIX_PhotoAccessHelper_createAsset_Func_4700 error: ${error.code},
                    ${error.message}`);
                })
              } catch (error) {
                expect(error.code).assertEqual(ERROR_CODE_INVALID_ARGUMENT);
              }
            }
          }
        }
        done();
      })
  })
}