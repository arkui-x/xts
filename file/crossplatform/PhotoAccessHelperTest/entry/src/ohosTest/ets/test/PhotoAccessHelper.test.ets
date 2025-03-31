/*
 * Copyright (c) 2024-2025 Huawei Device Co., Ltd.
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

import dataSharePredicates from '@ohos.data.dataSharePredicates';
import photoAccessHelper from '@ohos.file.photoAccessHelper';
import abilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry'
import { BusinessError } from "@ohos.base";
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import deviceInfo from '@ohos.deviceInfo';
import PlatformNAPI from 'libentry.so'
import { Want } from '@kit.AbilityKit';

const waitReadyMs_100 = 100;
const waitReadyMs_600 = 600;
const waitReadyMs_1000 = 1000;
const waitReadyMs_3000 = 3000;
const waitReadyMs_8000 = 8000;

let isPass: boolean;
let errCode: number;
let photoAsset_: photoAccessHelper.PhotoAsset;
let photoAssetList1_: Array<photoAccessHelper.PhotoAsset> = [];
let photoAssetList2_: Array<photoAccessHelper.PhotoAsset> = [];
let fetchPhotoResult_: photoAccessHelper.FetchResult<photoAccessHelper.PhotoAsset>;
let fetchAlbumsResult_: photoAccessHelper.FetchResult<photoAccessHelper.Album>;
let context: Context;
let phAccessHelper: photoAccessHelper.PhotoAccessHelper;
let photoPredicates: dataSharePredicates.DataSharePredicates = new dataSharePredicates.DataSharePredicates();
let resultTest: photoAccessHelper.PhotoSelectResult | null;
let androidVersion: number = -1;
let osFullNameInfo: string = deviceInfo.osFullName;
const delegator = abilityDelegatorRegistry.getAbilityDelegator();
let platform = osFullNameInfo.split(' ')[0];
if (platform == 'Android') {
  androidVersion = Number(osFullNameInfo.split(' ')[1]);
}

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function isAndroidVersionGreaterOrEqual(num: number) {
  if (platform != 'Android') {
    return true;
  } else {
    if (androidVersion >= num) {
      return true;
    } else {
      return false;
    }
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
  await sleep(waitReadyMs_100);
}

async function getAssets_Promise(fetchOptions: photoAccessHelper.FetchOptions) {
  await phAccessHelper.getAssets(fetchOptions).then((fetchResult) => {
    fetchPhotoResult_ = fetchResult;
  }).catch((err: BusinessError) => {
    console.error(`getAssets fail with error: ${err.code}, ${err.message}`);
  });
  await sleep(waitReadyMs_100);
}

async function getAlbums_Callback1(AlbumType: photoAccessHelper.AlbumType, AlbumSubtype: photoAccessHelper.AlbumSubtype,
                                  fetchOptions: photoAccessHelper.FetchOptions) {
  phAccessHelper.getAlbums(AlbumType, AlbumSubtype, fetchOptions, async (err, fetchResult) => {
      if (err || fetchResult == null) {
        isPass = false;
        console.error(`getAlbums fail with error: ${err.code}, ${err.message}`);
      } else {
        fetchAlbumsResult_ = fetchResult;
      }
    });
  await sleep(waitReadyMs_600);
}

async function getAlbums_Callback2(AlbumType: photoAccessHelper.AlbumType, AlbumSubtype: photoAccessHelper.AlbumSubtype) {
  phAccessHelper.getAlbums(AlbumType, AlbumSubtype, async (err, fetchResult) => {
      if (err || fetchResult == null) {
        isPass = false;
        console.error(`getAlbums fail with error: ${err.code}, ${err.message}`);
      } else {
        fetchAlbumsResult_ = fetchResult;
      }
    });
  await sleep(waitReadyMs_600);
}

async function getAlbums_Promise(AlbumType: photoAccessHelper.AlbumType, AlbumSubtype: photoAccessHelper.AlbumSubtype,
                                 fetchOptions: photoAccessHelper.FetchOptions) {
  await phAccessHelper.getAlbums(AlbumType, AlbumSubtype, fetchOptions).then((fetchResult) => {
      if (fetchResult == null) {
        isPass = false;
      } else {
        fetchAlbumsResult_ = fetchResult;
      }
    }).catch((err: BusinessError) => {
      isPass = false;
      console.error(`getAlbums fail with error: ${err.code}, ${err.message}`);
    });
  await sleep(waitReadyMs_100);
}

async function waitGetAllObjectsCallback(): Promise<photoAccessHelper.PhotoAsset[]> {
  return new Promise((resolve, reject) => {
    fetchPhotoResult_.getAllObjects(async (err, photoAssetList) => {
      if (photoAssetList != null) {
        resolve(photoAssetList);
      } else {
        console.error(`photoAsset failed with err:${err.code}, ${err.message}`);
        reject(err);
      }
    });
  });
}

export default function abilityTest() {
  describe('PhotoAccessHelperTest', () => {
    beforeAll(async () => {
      await startAbility('com.example.photoaccesshelpertest', 'EntryAbility');
      await sleep(waitReadyMs_8000);
      context = getContext();
      phAccessHelper = photoAccessHelper.getPhotoAccessHelper(context);
    })
    afterEach(async () => {
      resultTest = null;
      fetchPhotoResult_.close();
      await sleep(waitReadyMs_100);
    })

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_select_Func_0100
     * @tc.name   : select
     * @tc.desc   : Test select interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_select_Func_0100', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let PhotoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
        PhotoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE;
        let photoPicker = new photoAccessHelper.PhotoViewPicker();
        photoPicker.select(PhotoSelectOptions).then((PhotoSelectResult: photoAccessHelper.PhotoSelectResult) => {
          resultTest = PhotoSelectResult;
        }).catch((err: BusinessError) => {
          console.error("select fail with error: " + err.code +","+ err.message);
        });
        await sleep(waitReadyMs_1000);
        if (platform == "iOS") {
          PlatformNAPI.select();
        }
        await sleep(waitReadyMs_3000);
        if (resultTest != null) {
          expect(resultTest.photoUris[0] != null).assertTrue();
          expect(resultTest.isOriginalPhoto != null).assertTrue();
        } else {
          expect(false).assertTrue();
        }
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_select_Func_0100 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_select_Func_0200
     * @tc.name   : select
     * @tc.desc   : Test select interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_select_Func_0200', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let PhotoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
        PhotoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.VIDEO_TYPE;
        let photoPicker = new photoAccessHelper.PhotoViewPicker();
        photoPicker.select(PhotoSelectOptions).then((PhotoSelectResult: photoAccessHelper.PhotoSelectResult) => {
          resultTest = PhotoSelectResult;
        }).catch((err: BusinessError) => {
          console.error("select fail with error: " + err.code +","+ err.message);
        });
        await sleep(waitReadyMs_1000);
        if (platform == "iOS") {
          PlatformNAPI.select();
        }
        await sleep(waitReadyMs_3000);
        if (resultTest != null) {
          expect(resultTest.photoUris[0] != null).assertTrue();
          expect(resultTest.isOriginalPhoto != null).assertTrue();
        } else {
          expect(false).assertTrue();
        }
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_select_Func_0200 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_select_Func_0300
     * @tc.name   : select
     * @tc.desc   : Test select interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_select_Func_0300', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let PhotoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
        PhotoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_VIDEO_TYPE;
        let photoPicker = new photoAccessHelper.PhotoViewPicker();
        photoPicker.select(PhotoSelectOptions).then((PhotoSelectResult: photoAccessHelper.PhotoSelectResult) => {
          resultTest = PhotoSelectResult;
        }).catch((err: BusinessError) => {
          console.error("select fail with error: " + err.code +","+ err.message);
        });
        await sleep(waitReadyMs_1000);
        if (platform == "iOS") {
          PlatformNAPI.select();
        }
        await sleep(waitReadyMs_3000);
        if (resultTest != null) {
          expect(resultTest.photoUris[0] != null).assertTrue();
          expect(resultTest.isOriginalPhoto != null).assertTrue();
        } else {
          expect(false).assertTrue();
        }
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_select_Func_0300 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_select_Func_0400
     * @tc.name   : select
     * @tc.desc   : Test select interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_select_Func_0400', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let PhotoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
        PhotoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_TYPE;
        let photoPicker = new photoAccessHelper.PhotoViewPicker();
        photoPicker.select(PhotoSelectOptions, (err, PhotoSelectResult) => {
          if (err) {
            console.error("select fail with error: " + err.code +","+ err.message);
          } else {
            resultTest = PhotoSelectResult;
          }
        })
        await sleep(waitReadyMs_1000);
        if (platform == "iOS") {
          PlatformNAPI.select();
        }
        await sleep(waitReadyMs_3000);
        if (resultTest != null) {
          expect(resultTest.photoUris[0] != null).assertTrue();
          expect(resultTest.isOriginalPhoto != null).assertTrue();
        } else {
          expect(false).assertTrue();
        }
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_select_Func_0400 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_select_Func_0500
     * @tc.name   : select
     * @tc.desc   : Test select interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_select_Func_0500', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let PhotoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
        PhotoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.VIDEO_TYPE;
        let photoPicker = new photoAccessHelper.PhotoViewPicker();
        photoPicker.select(PhotoSelectOptions, (err, PhotoSelectResult) => {
          if (err) {
            console.error("select fail with error: " + err.code +","+ err.message);
          } else {
            resultTest = PhotoSelectResult;
          }
        })
        await sleep(waitReadyMs_1000);
        if (platform == "iOS") {
          PlatformNAPI.select();
        }
        await sleep(waitReadyMs_3000);
        if (resultTest != null) {
          expect(resultTest.photoUris[0] != null).assertTrue();
          expect(resultTest.isOriginalPhoto != null).assertTrue();
        } else {
          expect(false).assertTrue();
        }
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_select_Func_0500 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_select_Func_0600
     * @tc.name   : select
     * @tc.desc   : Test select interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_select_Func_0600', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let PhotoSelectOptions = new photoAccessHelper.PhotoSelectOptions();
        PhotoSelectOptions.MIMEType = photoAccessHelper.PhotoViewMIMETypes.IMAGE_VIDEO_TYPE;
        let photoPicker = new photoAccessHelper.PhotoViewPicker();
        photoPicker.select(PhotoSelectOptions, (err, PhotoSelectResult) => {
          if (err) {
            console.error("select fail with error: " + err.code +","+ err.message);
          } else {
            resultTest = PhotoSelectResult;
          }
        })
        await sleep(waitReadyMs_1000);
        if (platform == "iOS") {
          PlatformNAPI.select();
        }
        await sleep(waitReadyMs_3000);
        if (resultTest != null) {
          expect(resultTest.photoUris[0] != null).assertTrue();
          expect(resultTest.isOriginalPhoto != null).assertTrue();
        } else {
          expect(false).assertTrue();
        }
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_select_Func_0600 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_select_Func_0700
     * @tc.name   : select
     * @tc.desc   : Test select interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_select_Func_0700', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let photoPicker = new photoAccessHelper.PhotoViewPicker();
        photoPicker.select((err, PhotoSelectResult) => {
          if (err) {
            console.error("select fail with error: " + err.code +","+ err.message);
          } else {
            resultTest = PhotoSelectResult;
          }
        })
        await sleep(waitReadyMs_1000);
        if (platform == "iOS") {
          PlatformNAPI.select();
        }
        await sleep(waitReadyMs_3000);
        if (resultTest != null) {
          expect(resultTest.photoUris[0] != null).assertTrue();
          expect(resultTest.isOriginalPhoto != null).assertTrue();
        } else {
          expect(false).assertTrue();
        }
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_select_Func_0700 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    })

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_getPhotoAccessHelper_Func_0100
     * @tc.name   : getPhotoAccessHelper
     * @tc.desc   : Test getPhotoAccessHelper interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_getPhotoAccessHelper_Func_0100', 0, async (done: Function) => {
      try {
        let context = getContext();
        let phAccessHelper = photoAccessHelper.getPhotoAccessHelper(context);
        expect(phAccessHelper != null).assertTrue();
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_getPhotoAccessHelper_Func_0100 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_getAssets_Func_0100
     * @tc.name   : getAssets
     * @tc.desc   : Test getAssets interface - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_getAssets_Func_0100', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        isPass = false;
        phAccessHelper.getAssets(fetchOptions, async (err, fetchResult) => {
          if (fetchResult != null) {
            isPass = true;
            fetchPhotoResult_ = fetchResult;
          } else {
            console.error(`getAssets fail with error: ${err.code}, ${err.message}`);
          }
        });
        await sleep(waitReadyMs_3000);
        expect(isPass).assertTrue();
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_getAssets_Func_0100 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_getAssets_Func_0200
     * @tc.name   : getAssets
     * @tc.desc   : Test getAssets interface - Callback
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_PhotoAccessHelper_getAssets_Func_0200', 0, async (done: Function) => {
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: ["abc"],
          predicates: photoPredicates,
        };
        phAccessHelper.getAssets(fetchOptions, async (err, fetchResult) => {
          if (fetchResult != null) {
            fetchPhotoResult_ = fetchResult;
          } else {
            console.error(`getAssets fail with error: ${err.code}, ${err.message}`);
          }
        });
        await sleep(waitReadyMs_600);
      }
      catch (error) {
        expect(error.code).assertEqual("13900020");
        console.error(`SUB_ArkUIX_PhotoAccessHelper_getAssets_Func_0200 success: ${error.code}, ${error.message}`);
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_getAssets_Func_0300
     * @tc.name   : getAssets
     * @tc.desc   : Test getAssets interface - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_getAssets_Func_0300', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        isPass = false;
        await phAccessHelper.getAssets(fetchOptions).then((fetchResult) => {
          isPass = true;
          fetchPhotoResult_ = fetchResult;
        }).catch((err: BusinessError) => {
          console.error(`getAssets fail with error: ${err.code}, ${err.message}`);
        });
        await sleep(waitReadyMs_100);
        expect(isPass).assertTrue();
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_getAssets_Func_0300 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_getAssets_Func_0400
     * @tc.name   : getAssets
     * @tc.desc   : Test getAssets interface - Promise
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_PhotoAccessHelper_getAssets_Func_0400', 0, async (done: Function) => {
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: ["abc"],
          predicates: photoPredicates,
        };
        await phAccessHelper.getAssets(fetchOptions).then((fetchResult) => {
          fetchPhotoResult_ = fetchResult;
        }).catch((err: BusinessError) => {
          console.error(`getAssets fail with error: ${err.code}, ${err.message}`);
        });
        await sleep(waitReadyMs_100);
      }
      catch (error) {
        expect(error.code).assertEqual("13900020");
        console.error(`SUB_ArkUIX_PhotoAccessHelper_getAssets_Func_0400 success: ${error.code}, ${error.message}`);
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0100
     * @tc.name   : getAlbums
     * @tc.desc   : Test getAlbums interface - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0100', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        isPass = true;
        await getAlbums_Callback1(photoAccessHelper.AlbumType.USER, photoAccessHelper.AlbumSubtype.ANY, fetchOptions);
        await getAlbums_Callback1(photoAccessHelper.AlbumType.SYSTEM, photoAccessHelper.AlbumSubtype.ANY, fetchOptions);
        expect(isPass).assertTrue();
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0100 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0200
     * @tc.name   : getAlbums
     * @tc.desc   : Test getAlbums interface - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0200', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        isPass = true;
        await getAlbums_Callback1(photoAccessHelper.AlbumType.SYSTEM, photoAccessHelper.AlbumSubtype.USER_GENERIC, fetchOptions);
        await getAlbums_Callback1(photoAccessHelper.AlbumType.SYSTEM, photoAccessHelper.AlbumSubtype.FAVORITE, fetchOptions);
        await getAlbums_Callback1(photoAccessHelper.AlbumType.SYSTEM, photoAccessHelper.AlbumSubtype.VIDEO, fetchOptions);
        await getAlbums_Callback1(photoAccessHelper.AlbumType.SYSTEM, photoAccessHelper.AlbumSubtype.ANY, fetchOptions);
        expect(isPass).assertTrue();
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0200 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0300
     * @tc.name   : getAlbums
     * @tc.desc   : Test getAlbums interface - Callback
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0300', 0, async (done: Function) => {
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        phAccessHelper.getAlbums(-1, photoAccessHelper.AlbumSubtype.ANY, fetchOptions,
          async (err, fetchResult) => {
            if (fetchResult != null) {
              fetchAlbumsResult_ = fetchResult;
            } else {
              console.error(`getAlbums fail with error: ${err.code}, ${err.message}`);
            }
          });
        await sleep(waitReadyMs_600);
        expect().assertFail();
      }
      catch (error) {
        expect(error.code).assertEqual("13900020");
        console.error(`SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0300 success: ${error.code}, ${error.message}`);
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0400
     * @tc.name   : getAlbums
     * @tc.desc   : Test getAlbums interface - Callback
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0400', 0, async (done: Function) => {
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        phAccessHelper.getAlbums(photoAccessHelper.AlbumType.USER, -1, fetchOptions,
          async (err, fetchResult) => {
            if (fetchResult != null) {
              fetchAlbumsResult_ = fetchResult;
            } else {
              console.error(`getAlbums fail with error: ${err.code}, ${err.message}`);
            }
          });
        await sleep(waitReadyMs_600);
        expect().assertFail();
      }
      catch (error) {
        expect(error.code).assertEqual("13900020");
        console.error(`SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0400 success: ${error.code}, ${error.message}`);
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0500
     * @tc.name   : getAlbums
     * @tc.desc   : Test getAlbums interface - Callback
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0500', 0, async (done: Function) => {
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: ["abc"],
          predicates: photoPredicates,
        };
        phAccessHelper.getAlbums(photoAccessHelper.AlbumType.USER, photoAccessHelper.AlbumSubtype.ANY, fetchOptions,
          async (err, fetchResult) => {
            if (fetchResult != null) {
              fetchAlbumsResult_ = fetchResult;
            } else {
              console.error(`getAlbums fail with error: ${err.code}, ${err.message}`);
            }
          });
        await sleep(waitReadyMs_600);
        expect().assertFail();
      }
      catch (error) {
        expect(error.code).assertEqual("13900020");
        console.error(`SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0500 success: ${error.code}, ${error.message}`);
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0600
     * @tc.name   : getAlbums
     * @tc.desc   : Test getAlbums interface - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0600', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        isPass = true;
        await getAlbums_Callback2(photoAccessHelper.AlbumType.USER, photoAccessHelper.AlbumSubtype.ANY);
        await getAlbums_Callback2(photoAccessHelper.AlbumType.SYSTEM, photoAccessHelper.AlbumSubtype.ANY);
        expect(isPass).assertTrue();
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0600 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0700
     * @tc.name   : getAlbums
     * @tc.desc   : Test getAlbums interface - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0700', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        isPass = true;
        await getAlbums_Callback2(photoAccessHelper.AlbumType.SYSTEM, photoAccessHelper.AlbumSubtype.USER_GENERIC);
        await getAlbums_Callback2(photoAccessHelper.AlbumType.SYSTEM, photoAccessHelper.AlbumSubtype.FAVORITE);
        await getAlbums_Callback2(photoAccessHelper.AlbumType.SYSTEM, photoAccessHelper.AlbumSubtype.VIDEO);
        await getAlbums_Callback2(photoAccessHelper.AlbumType.SYSTEM, photoAccessHelper.AlbumSubtype.ANY);
        expect(isPass).assertTrue();
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0700 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0800
     * @tc.name   : getAlbums
     * @tc.desc   : Test getAlbums interface - Callback
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0800', 0, async (done: Function) => {
      try {
        phAccessHelper.getAlbums(-1, photoAccessHelper.AlbumSubtype.ANY,
          async (err, fetchResult) => {
            if (fetchResult != null) {
              fetchAlbumsResult_ = fetchResult;
            } else {
              console.error(`getAlbums fail with error: ${err.code}, ${err.message}`);
            }
          });
        await sleep(waitReadyMs_600);
        expect().assertFail();
      }
      catch (error) {
        expect(error.code).assertEqual("13900020");
        console.error(`SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0800 success: ${error.code}, ${error.message}`);
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0900
     * @tc.name   : getAlbums
     * @tc.desc   : Test getAlbums interface - Callback
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0900', 0, async (done: Function) => {
      try {
        phAccessHelper.getAlbums(photoAccessHelper.AlbumType.USER, -1,
          async (err, fetchResult) => {
            if (fetchResult != null) {
              fetchAlbumsResult_ = fetchResult;
            } else {
              console.error(`getAlbums fail with error: ${err.code}, ${err.message}`);
            }
          });
        await sleep(waitReadyMs_600);
        expect().assertFail();
      }
      catch (error) {
        expect(error.code).assertEqual("13900020");
        console.error(`SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_0900 success: ${error.code}, ${error.message}`);
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_1000
     * @tc.name   : getAlbums
     * @tc.desc   : Test getAlbums interface - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_1000', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        isPass = true;
        await getAlbums_Promise(photoAccessHelper.AlbumType.USER, photoAccessHelper.AlbumSubtype.ANY, fetchOptions);
        await getAlbums_Promise(photoAccessHelper.AlbumType.SYSTEM, photoAccessHelper.AlbumSubtype.ANY, fetchOptions);
        expect(isPass).assertTrue();
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_1000 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_1100
     * @tc.name   : getAlbums
     * @tc.desc   : Test getAlbums interface - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_1100', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        isPass = true;
        await getAlbums_Promise(photoAccessHelper.AlbumType.SYSTEM, photoAccessHelper.AlbumSubtype.USER_GENERIC, fetchOptions);
        await getAlbums_Promise(photoAccessHelper.AlbumType.SYSTEM, photoAccessHelper.AlbumSubtype.FAVORITE, fetchOptions);
        await getAlbums_Promise(photoAccessHelper.AlbumType.SYSTEM, photoAccessHelper.AlbumSubtype.VIDEO, fetchOptions);
        await getAlbums_Promise(photoAccessHelper.AlbumType.SYSTEM, photoAccessHelper.AlbumSubtype.ANY, fetchOptions);
        expect(isPass).assertTrue();
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_1100 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_1200
     * @tc.name   : getAlbums
     * @tc.desc   : Test getAlbums interface - Promise
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_1200', 0, async (done: Function) => {
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await phAccessHelper.getAlbums(-1, photoAccessHelper.AlbumSubtype.ANY, fetchOptions)
          .then((fetchResult) => {
            fetchAlbumsResult_ = fetchResult;
          }).catch((err: BusinessError) => {
            console.error(`getAlbums fail with error: ${err.code}, ${err.message}`);
          });
        await sleep(waitReadyMs_100);
        expect().assertFail();
      }
      catch (error) {
        expect(error.code).assertEqual("13900020");
        console.error(`SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_1200 success: ${error.code}, ${error.message}`);
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_1300
     * @tc.name   : getAlbums
     * @tc.desc   : Test getAlbums interface - Promise
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_1300', 0, async (done: Function) => {
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await phAccessHelper.getAlbums(photoAccessHelper.AlbumType.USER, -1, fetchOptions)
          .then((fetchResult) => {
            fetchAlbumsResult_ = fetchResult;
          }).catch((err: BusinessError) => {
            console.error(`getAlbums fail with error: ${err.code}, ${err.message}`);
          });
        await sleep(waitReadyMs_100);
        expect().assertFail();
      }
      catch (error) {
        expect(error.code).assertEqual("13900020");
        console.error(`SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_1300 success: ${error.code}, ${error.message}`);
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_1400
     * @tc.name   : getAlbums
     * @tc.desc   : Test getAlbums interface - Promise
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_1400', 0, async (done: Function) => {
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: ["abc"],
          predicates: photoPredicates,
        };
        await phAccessHelper.getAlbums(photoAccessHelper.AlbumType.USER, photoAccessHelper.AlbumSubtype.ANY, fetchOptions)
          .then((fetchResult) => {
            fetchAlbumsResult_ = fetchResult;
          }).catch((err: BusinessError) => {
            console.error(`getAlbums fail with error: ${err.code}, ${err.message}`);
          });
        await sleep(waitReadyMs_100);
        expect().assertFail();
      }
      catch (error) {
        expect(error.code).assertEqual("13900020");
        console.error(`SUB_ArkUIX_PhotoAccessHelper_getAlbums_Func_1400 success: ${error.code}, ${error.message}`);
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_PhotoAsset_Func_0100
     * @tc.name   : PhotoAsset
     * @tc.desc   : Test PhotoAsset property
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_PhotoAsset_Func_0100', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);
        expect((await fetchPhotoResult_.getFirstObject()).uri != null).assertTrue();
        expect((await fetchPhotoResult_.getFirstObject()).photoType != null).assertTrue();
        expect((await fetchPhotoResult_.getFirstObject()).displayName != null).assertTrue();
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_PhotoAsset_Func_0100 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_PhotoAsset.get_Func_0100
     * @tc.name   : PhotoAsset.get
     * @tc.desc   : Test PhotoAsset.get interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_PhotoAsset.get_Func_0100', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [photoAccessHelper.PhotoKeys.URI, photoAccessHelper.PhotoKeys.PHOTO_TYPE,
            photoAccessHelper.PhotoKeys.DISPLAY_NAME, photoAccessHelper.PhotoKeys.SIZE, photoAccessHelper.PhotoKeys.DATE_ADDED,
            photoAccessHelper.PhotoKeys.DATE_MODIFIED, photoAccessHelper.PhotoKeys.DURATION, photoAccessHelper.PhotoKeys.WIDTH,
            photoAccessHelper.PhotoKeys.HEIGHT, photoAccessHelper.PhotoKeys.DATE_TAKEN, photoAccessHelper.PhotoKeys.ORIENTATION,
            photoAccessHelper.PhotoKeys.FAVORITE, photoAccessHelper.PhotoKeys.TITLE],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);
        expect((await fetchPhotoResult_.getFirstObject()).get(photoAccessHelper.PhotoKeys.URI) != null).assertTrue();
        expect((await fetchPhotoResult_.getFirstObject()).get(photoAccessHelper.PhotoKeys.PHOTO_TYPE) != null).assertTrue();
        expect((await fetchPhotoResult_.getFirstObject()).get(photoAccessHelper.PhotoKeys.DISPLAY_NAME) != null).assertTrue();
        expect((await fetchPhotoResult_.getFirstObject()).get(photoAccessHelper.PhotoKeys.SIZE) != null).assertTrue();
        expect((await fetchPhotoResult_.getFirstObject()).get(photoAccessHelper.PhotoKeys.DATE_ADDED) != null).assertTrue();
        expect((await fetchPhotoResult_.getFirstObject()).get(photoAccessHelper.PhotoKeys.DATE_MODIFIED) != null).assertTrue();
        expect((await fetchPhotoResult_.getFirstObject()).get(photoAccessHelper.PhotoKeys.DURATION) != null).assertTrue();
        expect((await fetchPhotoResult_.getFirstObject()).get(photoAccessHelper.PhotoKeys.WIDTH) != null).assertTrue();
        expect((await fetchPhotoResult_.getFirstObject()).get(photoAccessHelper.PhotoKeys.HEIGHT) != null).assertTrue();
        expect((await fetchPhotoResult_.getFirstObject()).get(photoAccessHelper.PhotoKeys.DATE_TAKEN) != null).assertTrue();
        expect((await fetchPhotoResult_.getFirstObject()).get(photoAccessHelper.PhotoKeys.ORIENTATION) != null).assertTrue();
        if (isAndroidVersionGreaterOrEqual(11)) {
          expect((await fetchPhotoResult_.getFirstObject()).get(photoAccessHelper.PhotoKeys.FAVORITE) != null).assertTrue();
        }
        expect((await fetchPhotoResult_.getFirstObject()).get(photoAccessHelper.PhotoKeys.TITLE) != null).assertTrue();
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_PhotoAsset.get_Func_0100 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_PhotoAsset.get_Func_0200
     * @tc.name   : PhotoAsset.get
     * @tc.desc   : Test PhotoAsset.get interface
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_PhotoAccessHelper_PhotoAsset.get_Func_0200', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [photoAccessHelper.PhotoKeys.URI, photoAccessHelper.PhotoKeys.PHOTO_TYPE,
            photoAccessHelper.PhotoKeys.DISPLAY_NAME, photoAccessHelper.PhotoKeys.SIZE, photoAccessHelper.PhotoKeys.DATE_ADDED,
            photoAccessHelper.PhotoKeys.DATE_MODIFIED, photoAccessHelper.PhotoKeys.DURATION, photoAccessHelper.PhotoKeys.WIDTH,
            photoAccessHelper.PhotoKeys.HEIGHT, photoAccessHelper.PhotoKeys.DATE_TAKEN, photoAccessHelper.PhotoKeys.ORIENTATION,
            photoAccessHelper.PhotoKeys.FAVORITE, photoAccessHelper.PhotoKeys.TITLE],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);
        (await fetchPhotoResult_.getFirstObject()).get("abc");
        expect().assertFail();
      }
      catch (error) {
        expect(error.code).assertEqual("14000014");
        console.error(`SUB_ArkUIX_PhotoAccessHelper_PhotoAsset.get_Func_0200 success: ${error.code}, ${error.message}`);
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_Album_Func_0100
     * @tc.name   : Album
     * @tc.desc   : Test Album property
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_Album_Func_0100', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS' || androidVersion == 10) {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAlbums_Promise(photoAccessHelper.AlbumType.SYSTEM, photoAccessHelper.AlbumSubtype.ANY, fetchOptions);

        expect((await fetchAlbumsResult_.getFirstObject()).imageCount != null).assertTrue();
        expect((await fetchAlbumsResult_.getFirstObject()).videoCount != null).assertTrue();
        expect((await fetchAlbumsResult_.getFirstObject()).albumType != null).assertTrue();
        expect((await fetchAlbumsResult_.getFirstObject()).albumSubtype != null).assertTrue();
        expect((await fetchAlbumsResult_.getFirstObject()).albumName != null).assertTrue();
        expect((await fetchAlbumsResult_.getFirstObject()).albumUri != null).assertTrue();
        expect((await fetchAlbumsResult_.getFirstObject()).count != null).assertTrue();
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_Album_Func_0100 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_Album.getAssets_Func_0100
     * @tc.name   : Album.getAssets
     * @tc.desc   : Test Album.getAssets interface - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_Album.getAssets_Func_0100', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS' || androidVersion == 10) {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAlbums_Promise(photoAccessHelper.AlbumType.SYSTEM, photoAccessHelper.AlbumSubtype.ANY, fetchOptions);

        isPass = false;
        (await fetchAlbumsResult_.getFirstObject()).getAssets(fetchOptions, async (err, fetchResult) => {
          if (fetchResult != null) {
            isPass = true;
            fetchPhotoResult_ = fetchResult;
          } else {
            console.error(`getAssets fail with error: ${err.code}, ${err.message}`);
          }
        });
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_Album.getAssets_Func_0100 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_Album.getAssets_Func_0200
     * @tc.name   : Album.getAssets
     * @tc.desc   : Test Album.getAssets interface - Callback
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_PhotoAccessHelper_Album.getAssets_Func_0200', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS' || androidVersion == 10) {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAlbums_Promise(photoAccessHelper.AlbumType.SYSTEM, photoAccessHelper.AlbumSubtype.ANY, fetchOptions);

        fetchOptions = {
          fetchColumns: ["abc"],
          predicates: photoPredicates,
        };
        (await fetchAlbumsResult_.getFirstObject()).getAssets(fetchOptions, async (err, fetchResult) => {
          if (fetchResult != null) {
            fetchPhotoResult_ = fetchResult;
          } else {
            console.error(`getAssets fail with error: ${err.code}, ${err.message}`);
          }
        });
        await sleep(waitReadyMs_600);
        expect().assertFail();
      }
      catch (error) {
        expect(error.code).assertEqual("13900020");
        console.error(`SUB_ArkUIX_PhotoAccessHelper_Album.getAssets_Func_0200 success: ${error.code}, ${error.message}`);
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_Album.getAssets_Func_0300
     * @tc.name   : Album.getAssets
     * @tc.desc   : Test Album.getAssets interface - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_Album.getAssets_Func_0300', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS' || androidVersion == 10) {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAlbums_Promise(photoAccessHelper.AlbumType.SYSTEM, photoAccessHelper.AlbumSubtype.ANY, fetchOptions);

        isPass = false;
        await (await fetchAlbumsResult_.getFirstObject()).getAssets(fetchOptions).then((fetchResult) => {
          isPass = true;
          fetchPhotoResult_ = fetchResult;
        }).catch((err: BusinessError) => {
          console.error(`getAssets fail with error: ${err.code}, ${err.message}`);
        });
        await sleep(waitReadyMs_100);
        expect(isPass).assertTrue();
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_Album.getAssets_Func_0300 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_Album.getAssets_Func_0400
     * @tc.name   : Album.getAssets
     * @tc.desc   : Test Album.getAssets interface - Promise
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_PhotoAccessHelper_Album.getAssets_Func_0400', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS' || androidVersion == 10) {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAlbums_Promise(photoAccessHelper.AlbumType.SYSTEM, photoAccessHelper.AlbumSubtype.ANY, fetchOptions);

        fetchOptions = {
          fetchColumns: ["abc"],
          predicates: photoPredicates,
        };
        await (await fetchAlbumsResult_.getFirstObject()).getAssets(fetchOptions).then((fetchResult) => {
          fetchPhotoResult_ = fetchResult;
        }).catch((err: BusinessError) => {
          console.error(`getAssets fail with error: ${err.code}, ${err.message}`);
        });
        await sleep(waitReadyMs_600);
        expect().assertFail();
      }
      catch (error) {
        expect(error.code).assertEqual("13900020");
        console.error(`SUB_ArkUIX_PhotoAccessHelper_Album.getAssets_Func_0400 success: ${error.code}, ${error.message}`);
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_FetchResult.getCount_Func_0100
     * @tc.name   : FetchResult.getCount
     * @tc.desc   : Test FetchResult.getCount interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_FetchResult.getCount_Func_0100', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);
        expect(fetchPhotoResult_.getCount() > 0).assertTrue();
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_FetchResult.getCount_Func_0100 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_FetchResult.isAfterLast_Func_0100
     * @tc.name   : FetchResult.isAfterLast
     * @tc.desc   : Test FetchResult.isAfterLast interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_FetchResult.isAfterLast_Func_0100', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);
        await fetchPhotoResult_.getFirstObject();
        expect(fetchPhotoResult_.isAfterLast()).assertFalse();
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_FetchResult.isAfterLast_Func_0100 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_FetchResult.isAfterLast_Func_0200
     * @tc.name   : FetchResult.isAfterLast
     * @tc.desc   : Test FetchResult.isAfterLast interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_FetchResult.isAfterLast_Func_0200', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);
        await fetchPhotoResult_.getLastObject();
        expect(fetchPhotoResult_.isAfterLast()).assertTrue();
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_FetchResult.isAfterLast_Func_0200 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_FetchResult.close_Func_0100
     * @tc.name   : FetchResult.close
     * @tc.desc   : Test FetchResult.close interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_FetchResult.close_Func_0100', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);
        fetchPhotoResult_.close();
        fetchPhotoResult_.getCount();
        expect().assertFail();
      }
      catch (error) {
        expect(error.code).assertEqual("13900020");
        console.error(`SUB_ArkUIX_PhotoAccessHelper_FetchResult.close_Func_0100 success: ${error.code}, ${error.message}`);
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_FetchResult.getFirstObject_Func_0100
     * @tc.name   : FetchResult.getFirstObject
     * @tc.desc   : Test FetchResult.getFirstObject interface - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_FetchResult.getFirstObject_Func_0100', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);

        fetchPhotoResult_.getFirstObject((err, photoAsset) => {
          if (photoAsset != null) {
            photoAsset_ = photoAsset;
          } else {
            console.error(`getFirstObject failed with err:${err.code}, ${err.message}`);
          }
        });
        await sleep(waitReadyMs_600);
        expect(photoAsset_.displayName).assertEqual((await fetchPhotoResult_.getObjectByPosition(0)).displayName);
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_FetchResult.getFirstObject_Func_0100 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_FetchResult.getFirstObject_Func_0200
     * @tc.name   : FetchResult.getFirstObject
     * @tc.desc   : Test FetchResult.getFirstObject interface - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_FetchResult.getFirstObject_Func_0200', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);

        photoAsset_ = await fetchPhotoResult_.getFirstObject();
        await sleep(waitReadyMs_100);
        expect(photoAsset_.displayName).assertEqual((await fetchPhotoResult_.getObjectByPosition(0)).displayName);
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_FetchResult.getFirstObject_Func_0200 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_FetchResult.getNextObject_Func_0100
     * @tc.name   : FetchResult.getNextObject
     * @tc.desc   : Test FetchResult.getNextObject interface - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_FetchResult.getNextObject_Func_0100', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);

        await fetchPhotoResult_.getFirstObject();
        fetchPhotoResult_.getNextObject((err, photoAsset) => {
          if (photoAsset != null) {
            photoAsset_ = photoAsset;
          } else {
            console.error(`getNextObject failed with err:${err.code}, ${err.message}`);
          }
        });
        await sleep(waitReadyMs_600);
        expect(photoAsset_.displayName).assertEqual((await fetchPhotoResult_.getObjectByPosition(1)).displayName);
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_FetchResult.getNextObject_Func_0100 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_FetchResult.getNextObject_Func_0200
     * @tc.name   : FetchResult.getNextObject
     * @tc.desc   : Test FetchResult.getNextObject interface - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_FetchResult.getNextObject_Func_0200', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);

        await fetchPhotoResult_.getFirstObject();
        photoAsset_ = await fetchPhotoResult_.getNextObject();
        await sleep(waitReadyMs_100);
        expect(photoAsset_.displayName).assertEqual((await fetchPhotoResult_.getObjectByPosition(1)).displayName);
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_FetchResult.getNextObject_Func_0200 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_FetchResult.getLastObject_Func_0100
     * @tc.name   : FetchResult.getLastObject
     * @tc.desc   : Test FetchResult.getLastObject interface - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_FetchResult.getLastObject_Func_0100', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);

        fetchPhotoResult_.getLastObject((err, photoAsset) => {
          if (photoAsset != null) {
            photoAsset_ = photoAsset;
          } else {
            console.error(`getLastObject failed with err:${err.code}, ${err.message}`);
          }
        });
        await sleep(waitReadyMs_600);
        expect(photoAsset_.displayName).assertEqual(
          (await fetchPhotoResult_.getObjectByPosition(fetchPhotoResult_.getCount() - 1)).displayName);
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_FetchResult.getLastObject_Func_0100 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_FetchResult.getLastObject_Func_0200
     * @tc.name   : FetchResult.getLastObject
     * @tc.desc   : Test FetchResult.getLastObject interface - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_FetchResult.getLastObject_Func_0200', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);

        photoAsset_ = await fetchPhotoResult_.getLastObject();
        await sleep(waitReadyMs_100);
        expect(photoAsset_.displayName).assertEqual(
          (await fetchPhotoResult_.getObjectByPosition(fetchPhotoResult_.getCount() - 1)).displayName);
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_FetchResult.getLastObject_Func_0200 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_FetchResult.getObjectByPosition_Func_0100
     * @tc.name   : FetchResult.getObjectByPosition
     * @tc.desc   : Test FetchResult.getObjectByPosition interface - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_FetchResult.getObjectByPosition_Func_0100', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);

        fetchPhotoResult_.getObjectByPosition(0, (err, photoAsset) => {
          if (photoAsset != null) {
            photoAsset_ = photoAsset;
          } else {
            console.error(`photoAsset failed with err:${err.code}, ${err.message}`);
          }
        });
        await sleep(waitReadyMs_600);
        expect(photoAsset_.displayName).assertEqual((await fetchPhotoResult_.getFirstObject()).displayName);
        fetchPhotoResult_.getObjectByPosition(fetchPhotoResult_.getCount() - 1, (err, photoAsset) => {
          if (photoAsset != null) {
            photoAsset_ = photoAsset;
          } else {
            console.error(`getObjectByPosition failed with err:${err.code}, ${err.message}`);
          }
        });
        await sleep(waitReadyMs_600);
        expect(photoAsset_.displayName).assertEqual((await fetchPhotoResult_.getLastObject()).displayName);
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_FetchResult.getObjectByPosition_Func_0100 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_FetchResult.getObjectByPosition_Func_0200
     * @tc.name   : FetchResult.getObjectByPosition
     * @tc.desc   : Test FetchResult.getObjectByPosition interface - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_FetchResult.getObjectByPosition_Func_0200', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);

        photoAsset_ = await fetchPhotoResult_.getObjectByPosition(0);
        await sleep(waitReadyMs_600);
        expect(photoAsset_.displayName).assertEqual((await fetchPhotoResult_.getFirstObject()).displayName);
        photoAsset_ = await fetchPhotoResult_.getObjectByPosition(fetchPhotoResult_.getCount() - 1);
        await sleep(waitReadyMs_600);
        expect(photoAsset_.displayName).assertEqual((await fetchPhotoResult_.getLastObject()).displayName);
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_FetchResult.getObjectByPosition_Func_0200 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_FetchResult.getObjectByPosition_Func_0300
     * @tc.name   : FetchResult.getObjectByPosition
     * @tc.desc   : Test FetchResult.getObjectByPosition interface - Callback
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_PhotoAccessHelper_FetchResult.getObjectByPosition_Func_0300', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);

        isPass = true;
        fetchPhotoResult_.getObjectByPosition(-1, (err, photoAsset) => {
          if (photoAsset != null) {
            isPass = false;
          } else {
            errCode = err.code;
            console.error(`getObjectByPosition failed with err:${err.code}, ${err.message}`);
          }
        });
        await sleep(waitReadyMs_600);
        expect(isPass).assertTrue();
        expect(errCode).assertEqual("14000011");
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_FetchResult.getObjectByPosition_Func_0300 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_FetchResult.getObjectByPosition_Func_0400
     * @tc.name   : FetchResult.getObjectByPosition
     * @tc.desc   : Test FetchResult.getObjectByPosition interface - Promise
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_PhotoAccessHelper_FetchResult.getObjectByPosition_Func_0400', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);

        isPass = true;
        await fetchPhotoResult_.getObjectByPosition(-1).then((photoAsset) => {
          isPass = false;
        }).catch((err: BusinessError) => {
          errCode = err.code;
          console.error(`getObjectByPosition fail with error: ${err.code}, ${err.message}`);
        });
        await sleep(waitReadyMs_100);
        expect(isPass).assertTrue();
        expect(errCode).assertEqual("14000011");
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_FetchResult.getObjectByPosition_Func_0400 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_FetchResult.getAllObjects_Func_0100
     * @tc.name   : FetchResult.getAllObjects
     * @tc.desc   : Test FetchResult.getAllObjects interface - Callback
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_FetchResult.getAllObjects_Func_0100', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);

        photoAssetList1_.push(await fetchPhotoResult_.getFirstObject());
        for (let i = 0; i < fetchPhotoResult_.getCount() - 1; i++) {
          photoAssetList1_.push(await fetchPhotoResult_.getNextObject());
        }
        photoAssetList2_ = await waitGetAllObjectsCallback();
        for (let i = 0; i < photoAssetList1_.length; i++) {
          expect(photoAssetList1_[i].displayName).assertEqual(photoAssetList2_[i].displayName);
        }
        photoAssetList1_.length = 0;
        photoAssetList2_.length = 0;
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_FetchResult.getAllObjects_Func_0100 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_PhotoAccessHelper_FetchResult.getAllObjects_Func_0200
     * @tc.name   : FetchResult.getAllObjects
     * @tc.desc   : Test FetchResult.getAllObjects interface - Promise
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_PhotoAccessHelper_FetchResult.getAllObjects_Func_0200', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);

        photoAssetList1_.push(await fetchPhotoResult_.getFirstObject());
        for (let i = 0; i < fetchPhotoResult_.getCount() - 1; i++) {
          photoAssetList1_.push(await fetchPhotoResult_.getNextObject());
        }
        photoAssetList2_ = await fetchPhotoResult_.getAllObjects();
        await sleep(waitReadyMs_100);
        for (let i = 0; i < photoAssetList1_.length; i++) {
          expect(photoAssetList1_[i].displayName).assertEqual(photoAssetList2_[i].displayName);
        }
        photoAssetList1_.length = 0;
        photoAssetList2_.length = 0;
      }
      catch (error) {
        console.error(`SUB_ArkUIX_PhotoAccessHelper_FetchResult.getAllObjects_Func_0200 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

  })
}