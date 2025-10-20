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

import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, Size, TestType } from "@ohos/hypium";
import commonType from '@ohos.data.commonType';

let context: Context | undefined = undefined;
const TAG = "OBJECTSTORE_TEST";

export default function ObjectStoreJsunitV9Ets(context: Context) {
  describe('ObjectStoreJsunitV9Ets', () => {
    beforeAll(async (done: () => void) => {
      done();
    });
    beforeEach(async () => {
      console.info(TAG + 'beforeEach');
      context = context;
    });
    afterEach(() => {
      console.info(TAG + 'afterEach');
    });
    afterAll(() => {
      console.info(TAG + 'afterAll');
    });
    console.info(TAG + "*************Unit Test Begin*************");

    /**
     * @tc.name   : testBindAssetCommunType0001
     * @tc.desc   : Test commonType.Asset,Assets
     * @tc.type   : Function
     * @tc.number : SUB_DISTRIBUTEDDATA_DATAOBJECT_SDK_OBJECTJSAPITEST_BINDASSETCOMMONTYPE_0100
     * @tc.size   : MediumTest
     * @tc.level  : Level 2
     */
    it('testBindAssetCommunType0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      console.log(TAG + "************* testBindAssetCommunType0001 start *************");
      let asset1: commonType.Asset = {
        status: 0,
        name: "1.txt",
        uri: "file://com.example.myapp/data/dir/1.txt",
        path: "/dir/1.txt",
        createTime: "2023/11/30 19:48:00",
        modifyTime: "2023/11/30 20:10:00",
        size: "1"
      };
      let asset2: commonType.Asset = {
        status: 0,
        name: "2.txt",
        uri: "file://com.example.myapp/data/dir/1.txt",
        path: "/dir/2.txt",
        createTime: "2023/11/30 19:48:00",
        modifyTime: "2023/11/30 20:10:00",
        size: "2"
      };
      let assettype1: commonType.Asset = asset1;
      let assettype2: commonType.Asset = asset2;
      let assetarray11: commonType.Assets = new Array(assettype1, assettype2);
      expect(assetarray11[0] == assettype1).assertTrue();
      expect(assetarray11[1] == assettype2).assertTrue();
      done();
    });
  });
}