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
import { describe, it, expect, TestType, Level, Size } from '@ohos/hypium';
import relationalStore from "@ohos.data.relationalStore"

export default function enumValueTest() {
  describe('enumValueTest', () => {
    /**
     * @tc.name   : relationalStoreValueTest0001
     * @tc.number : SUB_DISTRIBUTEMGR_RELATIONALSTORE_ENUM_0100
     * @tc.desc   : Test Enum Values
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('relationalStoreValueTest0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let ASSET_DELETE = relationalStore.AssetStatus.ASSET_DELETE;
      console.info("[AssetStatus]ASSET_DELETE : " +
      JSON.stringify(ASSET_DELETE));
      expect(ASSET_DELETE).assertEqual(4);
      let ASSET_ABNORMAL = relationalStore.AssetStatus.ASSET_ABNORMAL;
      console.info("[AssetStatus]ASSET_ABNORMAL : " +
      JSON.stringify(ASSET_ABNORMAL));
      expect(ASSET_ABNORMAL).assertEqual(5);
      let ASSET_DOWNLOADING = relationalStore.AssetStatus.ASSET_DOWNLOADING;
      console.info("[AssetStatus]ASSET_DOWNLOADING : " +
      JSON.stringify(ASSET_DOWNLOADING));
      expect(ASSET_DOWNLOADING).assertEqual(6);
      done();
    });

    /**
     * @tc.name   : relationalStoreValueTest0002
     * @tc.number : SUB_DISTRIBUTEMGR_RELATIONALSTORE_ENUM_0200
     * @tc.desc   : Test Enum Values
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('relationalStoreValueTest0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let AES_256_GCM = relationalStore.EncryptionAlgo.AES_256_GCM;
      console.info("[EncryptionAlgo]AES_256_GCM : " +
      JSON.stringify(AES_256_GCM));
      expect(AES_256_GCM).assertEqual(0);
      done();
    });

    /**
     * @tc.name   : relationalStoreValueTest0003
     * @tc.number : SUB_DISTRIBUTEMGR_RELATIONALSTORE_ENUM_0300
     * @tc.desc   : Test Enum Values
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('relationalStoreValueTest0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let SHA1 = relationalStore.HmacAlgo.SHA1;
      console.info("[HmacAlgo]SHA1 : " +
      JSON.stringify(SHA1));
      expect(SHA1).assertEqual(0);
      let SHA256 = relationalStore.HmacAlgo.SHA256;
      console.info("[HmacAlgo]SHA256 : " +
      JSON.stringify(SHA256));
      expect(SHA256).assertEqual(1);
      done();
    });

    /**
     * @tc.name   : relationalStoreValueTest0004
     * @tc.number : SUB_DISTRIBUTEMGR_RELATIONALSTORE_ENUM_0400
     * @tc.desc   : Test Enum Values
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('relationalStoreValueTest0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let KDF_SHA1 = relationalStore.KdfAlgo.KDF_SHA1;
      console.info("[KdfAlgo]KDF_SHA1 : " +
      JSON.stringify(KDF_SHA1));
      expect(KDF_SHA1).assertEqual(0);
      let KDF_SHA256 = relationalStore.KdfAlgo.KDF_SHA256;
      console.info("[KdfAlgo]KDF_SHA256 : " +
      JSON.stringify(KDF_SHA256));
      expect(KDF_SHA256).assertEqual(1);
      done();
    });

    /**
     * @tc.name   : relationalStoreValueTest0005
     * @tc.number : SUB_DISTRIBUTEMGR_RELATIONALSTORE_ENUM_0500
     * @tc.desc   : Test Enum Values
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it('relationalStoreValueTest0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let CURSOR_FIELD = relationalStore.Field.CURSOR_FIELD;
      console.info("[Field]CURSOR_FIELD : " +
      JSON.stringify(CURSOR_FIELD));
      expect(CURSOR_FIELD).assertEqual('#_cursor');
      let ORIGIN_FIELD = relationalStore.Field.ORIGIN_FIELD;
      console.info("[Field]ORIGIN_FIELD : " +
      JSON.stringify(ORIGIN_FIELD));
      expect(ORIGIN_FIELD).assertEqual('#_origin');
      let DELETED_FLAG_FIELD = relationalStore.Field.DELETED_FLAG_FIELD;
      console.info("[Field]DELETED_FLAG_FIELD : " +
      JSON.stringify(DELETED_FLAG_FIELD));
      expect(DELETED_FLAG_FIELD).assertEqual('#_deleted_flag');
      let DATA_STATUS_FIELD = relationalStore.Field.DATA_STATUS_FIELD;
      console.info("[Field]DATA_STATUS_FIELD : " +
      JSON.stringify(DATA_STATUS_FIELD));
      expect(DATA_STATUS_FIELD).assertEqual('#_data_status');
      let OWNER_FIELD = relationalStore.Field.OWNER_FIELD;
      console.info("[Field]OWNER_FIELD : " +
      JSON.stringify(OWNER_FIELD));
      expect(OWNER_FIELD).assertEqual('#_cloud_owner');
      let PRIVILEGE_FIELD = relationalStore.Field.PRIVILEGE_FIELD;
      console.info("[Field]PRIVILEGE_FIELD : " +
      JSON.stringify(PRIVILEGE_FIELD));
      expect(PRIVILEGE_FIELD).assertEqual('#_cloud_privilege');
      let SHARING_RESOURCE_FIELD = relationalStore.Field.SHARING_RESOURCE_FIELD;
      console.info("[Field]SHARING_RESOURCE_FIELD : " +
      JSON.stringify(SHARING_RESOURCE_FIELD));
      expect(SHARING_RESOURCE_FIELD).assertEqual('#_sharing_resource_field');
      done();
    });
  });
}