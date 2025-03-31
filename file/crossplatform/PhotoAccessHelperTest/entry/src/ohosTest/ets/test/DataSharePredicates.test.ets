/*
 * Copyright (c) 2024 Huawei Device Co., Ltd.
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
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect } from '@ohos/hypium';
import { BusinessError } from "@ohos.base";
import deviceInfo from '@ohos.deviceInfo';

const waitReadyMs_100 = 100;
const waitReadyMs_2000 = 2000;
const limitResultNumber_5 = 5;

let assetsCount: number;
let tempWidth1: photoAccessHelper.MemberType;
let tempWidth2: photoAccessHelper.MemberType;
let tempObject: photoAccessHelper.PhotoAsset;
let sizeArray: Array<photoAccessHelper.MemberType> = [];
let isPass: boolean;
let fetchPhotoResult_: photoAccessHelper.FetchResult<photoAccessHelper.PhotoAsset>;
let context: Context;
let phAccessHelper: photoAccessHelper.PhotoAccessHelper;
let photoPredicates: dataSharePredicates.DataSharePredicates = new dataSharePredicates.DataSharePredicates();
let androidVersion: number = -1;
let osFullNameInfo: string = deviceInfo.osFullName;
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

async function getAssets_Promise(fetchOptions: photoAccessHelper.FetchOptions) {
  await phAccessHelper.getAssets(fetchOptions).then((fetchResult) => {
    fetchPhotoResult_ = fetchResult;
  }).catch((err: BusinessError) => {
    console.error(`getAssets fail with error: ${err.code}, ${err.message}`);
  });
  await sleep(waitReadyMs_100);
}

export default function abilityTest() {
  describe('DataSharePredicatesTest', () => {
    beforeAll(async () => {
      await sleep(waitReadyMs_100);
      context = getContext();
      phAccessHelper = photoAccessHelper.getPhotoAccessHelper(context);

      let fetchOptions: photoAccessHelper.FetchOptions = {
        fetchColumns: [],
        predicates: photoPredicates,
      };
      await getAssets_Promise(fetchOptions);
      assetsCount = fetchPhotoResult_.getCount();
    })
    afterEach(async () => {
      fetchPhotoResult_.close();
      photoPredicates = new dataSharePredicates.DataSharePredicates();
      await sleep(waitReadyMs_100);
    })
    afterAll(async () => {
      await sleep(waitReadyMs_2000);
    })

    /**
     * @tc.number : SUB_ArkUIX_DataSharePredicates_equalTo_Func_0100
     * @tc.name   : equalTo
     * @tc.desc   : Test equalTo interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_DataSharePredicates_equalTo_Func_0100', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [photoAccessHelper.PhotoKeys.HEIGHT],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);
        let photoHeight_ = (await fetchPhotoResult_.getFirstObject()).get(photoAccessHelper.PhotoKeys.HEIGHT);

        photoPredicates.equalTo(photoAccessHelper.PhotoKeys.HEIGHT, photoHeight_);
        fetchOptions = {
          fetchColumns: [photoAccessHelper.PhotoKeys.HEIGHT],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);
        expect((await fetchPhotoResult_.getFirstObject()).get(photoAccessHelper.PhotoKeys.HEIGHT))
          .assertEqual(photoHeight_);
        for (let i = 0; i < fetchPhotoResult_.getCount() - 1; i++) {
          expect((await fetchPhotoResult_.getNextObject()).get(photoAccessHelper.PhotoKeys.HEIGHT))
            .assertEqual(photoHeight_);
        }
      }
      catch (error) {
        console.error(`SUB_ArkUIX_DataSharePredicates_equalTo_Func_0100 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_DataSharePredicates_equalTo_Func_0200
     * @tc.name   : equalTo
     * @tc.desc   : Test equalTo interface
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_DataSharePredicates_equalTo_Func_0200', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        photoPredicates.equalTo("", "test");
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);
        expect(fetchPhotoResult_.getCount()).assertEqual(assetsCount);
      }
      catch (error) {
        console.error(`SUB_ArkUIX_DataSharePredicates_equalTo_Func_0200 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_DataSharePredicates_equalTo_Func_0300
     * @tc.name   : equalTo
     * @tc.desc   : Test equalTo interface
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_DataSharePredicates_equalTo_Func_0300', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        photoPredicates.equalTo(photoAccessHelper.PhotoKeys.WIDTH, "");
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);
        expect(fetchPhotoResult_.getCount()).assertEqual(0);
      }
      catch (error) {
        console.error(`SUB_ArkUIX_DataSharePredicates_equalTo_Func_0300 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_DataSharePredicates_and_Func_0100
     * @tc.name   : and
     * @tc.desc   : Test and interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_DataSharePredicates_and_Func_0100', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [photoAccessHelper.PhotoKeys.WIDTH, photoAccessHelper.PhotoKeys.HEIGHT],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);
        let photoHeight_ = (await fetchPhotoResult_.getFirstObject()).get(photoAccessHelper.PhotoKeys.HEIGHT);
        let photoWidth_ = (await fetchPhotoResult_.getFirstObject()).get(photoAccessHelper.PhotoKeys.WIDTH);

        photoPredicates.equalTo(photoAccessHelper.PhotoKeys.HEIGHT, photoHeight_)
          .and()
          .equalTo(photoAccessHelper.PhotoKeys.WIDTH, photoWidth_);
        fetchOptions = {
          fetchColumns: [photoAccessHelper.PhotoKeys.WIDTH, photoAccessHelper.PhotoKeys.HEIGHT],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);
        let tempObject = await fetchPhotoResult_.getFirstObject();
        expect(tempObject.get(photoAccessHelper.PhotoKeys.HEIGHT)).assertEqual(photoHeight_);
        expect(tempObject.get(photoAccessHelper.PhotoKeys.WIDTH)).assertEqual(photoWidth_);
        for (let i = 0; i < fetchPhotoResult_.getCount() - 1; i++) {
          tempObject = await fetchPhotoResult_.getNextObject();
          expect(tempObject.get(photoAccessHelper.PhotoKeys.HEIGHT)).assertEqual(photoHeight_);
          expect(tempObject.get(photoAccessHelper.PhotoKeys.WIDTH)).assertEqual(photoWidth_);
        }
      }
      catch (error) {
        console.error(`SUB_ArkUIX_DataSharePredicates_and_Func_0100 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_DataSharePredicates_orderByAsc_Func_0100
     * @tc.name   : orderByAsc
     * @tc.desc   : Test orderByAsc interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_DataSharePredicates_orderByAsc_Func_0100', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        photoPredicates.orderByAsc(photoAccessHelper.PhotoKeys.WIDTH);
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [photoAccessHelper.PhotoKeys.WIDTH],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);

        isPass = true;
        tempObject = await fetchPhotoResult_.getFirstObject();
        sizeArray.push(tempObject.get(photoAccessHelper.PhotoKeys.WIDTH));
        for (let i = 0; i < fetchPhotoResult_.getCount() - 1; i++) {
          tempObject = await fetchPhotoResult_.getNextObject();
          sizeArray.push(tempObject.get(photoAccessHelper.PhotoKeys.WIDTH));
        }
        for (let i = 0; i < sizeArray.length - 1; i++) {
          if (sizeArray[i] > sizeArray[i + 1]) {
            isPass = false;
            break;
          }
        }
        expect(isPass).assertTrue();
        sizeArray.length = 0;
      }
      catch (error) {
        console.error(`SUB_ArkUIX_DataSharePredicates_orderByAsc_Func_0100 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_DataSharePredicates_orderByAsc_Func_0200
     * @tc.name   : orderByAsc
     * @tc.desc   : Test orderByAsc interface
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_DataSharePredicates_orderByAsc_Func_0200', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        photoPredicates.orderByAsc("");
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);
        expect(fetchPhotoResult_.getCount()).assertEqual(assetsCount);
      }
      catch (error) {
        console.error(`SUB_ArkUIX_DataSharePredicates_orderByAsc_Func_0200 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_DataSharePredicates_orderByDesc_Func_0100
     * @tc.name   : orderByDesc
     * @tc.desc   : Test orderByDesc interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_DataSharePredicates_orderByDesc_Func_0100', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        photoPredicates.orderByDesc(photoAccessHelper.PhotoKeys.WIDTH);
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [photoAccessHelper.PhotoKeys.WIDTH],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);

        isPass = true;
        tempObject = await fetchPhotoResult_.getFirstObject();
        sizeArray.push(tempObject.get(photoAccessHelper.PhotoKeys.WIDTH));
        for (let i = 0; i < fetchPhotoResult_.getCount() - 1; i++) {
          tempObject = await fetchPhotoResult_.getNextObject();
          sizeArray.push(tempObject.get(photoAccessHelper.PhotoKeys.WIDTH));
        }
        for (let i = 0; i < sizeArray.length - 1; i++) {
          if (sizeArray[i] < sizeArray[i + 1]) {
            isPass = false;
            break;
          }
        }
        expect(isPass).assertTrue();
        sizeArray.length = 0;
      }
      catch (error) {
        console.error(`SUB_ArkUIX_DataSharePredicates_orderByDesc_Func_0100 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_DataSharePredicates_orderByDesc_Func_0200
     * @tc.name   : orderByDesc
     * @tc.desc   : Test orderByDesc interface
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_DataSharePredicates_orderByDesc_Func_0200', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        photoPredicates.orderByDesc("");
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);
        expect(fetchPhotoResult_.getCount()).assertEqual(assetsCount);
      }
      catch (error) {
        console.error(`SUB_ArkUIX_DataSharePredicates_orderByDesc_Func_0200 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_DataSharePredicates_limit_Func_0100
     * @tc.name   : limit
     * @tc.desc   : Test limit interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_DataSharePredicates_limit_Func_0100', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let photoPredicates: dataSharePredicates.DataSharePredicates = new dataSharePredicates.DataSharePredicates();
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);
        let firstPhotoName = (await fetchPhotoResult_.getFirstObject()).displayName;

        photoPredicates.limit(limitResultNumber_5, 0);
        await getAssets_Promise(fetchOptions);
        if (isAndroidVersionGreaterOrEqual(11)) {
          expect(0 < fetchPhotoResult_.getCount() && fetchPhotoResult_.getCount() <= limitResultNumber_5).assertTrue();
        } else {
          expect(fetchPhotoResult_.getCount()).assertEqual(assetsCount);
        }
        expect((await fetchPhotoResult_.getFirstObject()).displayName).assertEqual(firstPhotoName);
      }
      catch (error) {
        console.error(`SUB_ArkUIX_DataSharePredicates_limit_Func_0100 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_DataSharePredicates_limit_Func_0200
     * @tc.name   : limit
     * @tc.desc   : Test limit interface
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_DataSharePredicates_limit_Func_0200', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        photoPredicates.limit(-1, 0);
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);
        expect(fetchPhotoResult_.getCount()).assertEqual(assetsCount);
      }
      catch (error) {
        console.error(`SUB_ArkUIX_DataSharePredicates_limit_Func_0200 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_DataSharePredicates_limit_Func_0300
     * @tc.name   : limit
     * @tc.desc   : Test limit interface
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_DataSharePredicates_limit_Func_0300', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        photoPredicates.limit(limitResultNumber_5, -1);
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);
        if (isAndroidVersionGreaterOrEqual(11)) {
          expect(0 < fetchPhotoResult_.getCount() && fetchPhotoResult_.getCount() <= limitResultNumber_5).assertTrue();
        } else {
          expect(fetchPhotoResult_.getCount()).assertEqual(assetsCount);
        }
      }
      catch (error) {
        console.error(`SUB_ArkUIX_DataSharePredicates_limit_Func_0300 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_DataSharePredicates_in_Func_0100
     * @tc.name   : in
     * @tc.desc   : Test in interface
     * @tc.level  : Level 0
     */
    it('SUB_ArkUIX_DataSharePredicates_in_Func_0100', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [photoAccessHelper.PhotoKeys.WIDTH],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);

        tempWidth1 = (await fetchPhotoResult_.getFirstObject()).get(photoAccessHelper.PhotoKeys.WIDTH);
        tempWidth2 = (await fetchPhotoResult_.getNextObject()).get(photoAccessHelper.PhotoKeys.WIDTH);
        photoPredicates.in(photoAccessHelper.PhotoKeys.WIDTH, [tempWidth1, tempWidth2]);
        fetchOptions = {
          fetchColumns: [photoAccessHelper.PhotoKeys.WIDTH],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);
        let tempResult = (await fetchPhotoResult_.getFirstObject()).get(photoAccessHelper.PhotoKeys.WIDTH);
        expect(tempResult == tempWidth1 || tempResult == tempWidth2).assertTrue();
        for (let i = 0; i < fetchPhotoResult_.getCount() - 1; i++) {
          let tempResult = (await fetchPhotoResult_.getNextObject()).get(photoAccessHelper.PhotoKeys.WIDTH);
          expect(tempResult == tempWidth1 || tempResult == tempWidth2).assertTrue();
        }
      }
      catch (error) {
        console.error(`SUB_ArkUIX_DataSharePredicates_in_Func_0100 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_DataSharePredicates_in_Func_0200
     * @tc.name   : in
     * @tc.desc   : Test in interface
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_DataSharePredicates_in_Func_0200', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        photoPredicates.in("", ["test"]);
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);
        expect(fetchPhotoResult_.getCount()).assertEqual(assetsCount);
      }
      catch (error) {
        console.error(`SUB_ArkUIX_DataSharePredicates_in_Func_0200 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_DataSharePredicates_in_Func_0300
     * @tc.name   : in
     * @tc.desc   : Test in interface
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_DataSharePredicates_in_Func_0300', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        photoPredicates.in(photoAccessHelper.PhotoKeys.WIDTH, [""]);
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [photoAccessHelper.PhotoKeys.WIDTH],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);
        expect(fetchPhotoResult_.getCount()).assertLargerOrEqual(0);
      }
      catch (error) {
        console.error(`SUB_ArkUIX_DataSharePredicates_in_Func_0300 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

    /**
     * @tc.number : SUB_ArkUIX_DataSharePredicates_in_Func_0400
     * @tc.name   : in
     * @tc.desc   : Test in interface
     * @tc.level  : Level 2
     */
    it('SUB_ArkUIX_DataSharePredicates_in_Func_0400', 0, async (done: Function) => {
      if (platform != 'Android' && platform != 'iOS') {
        done();
        return;
      }
      try {
        photoPredicates.in(photoAccessHelper.PhotoKeys.WIDTH, []);
        let fetchOptions: photoAccessHelper.FetchOptions = {
          fetchColumns: [photoAccessHelper.PhotoKeys.WIDTH],
          predicates: photoPredicates,
        };
        await getAssets_Promise(fetchOptions);
        expect(fetchPhotoResult_.getCount()).assertLargerOrEqual(0);
      }
      catch (error) {
        console.error(`SUB_ArkUIX_DataSharePredicates_in_Func_0400 error: ${error.code}, ${error.message}`);
        expect().assertFail();
      }
      done();
    });

  })
}