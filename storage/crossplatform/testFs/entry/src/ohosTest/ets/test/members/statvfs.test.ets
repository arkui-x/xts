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

import {isIntNum, describe, it, expect, afterEach } from "../Common";
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';
import statvfs from  '@ohos.file.statvfs'
import { Level } from '@ohos/hypium';

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function fileIOStatvfs() {
  describe('fileIO_statvfs_test', () => {
    afterEach(async () => {
      await sleep(500);
  });

  /**
   * @tc.number SUB_DF_STATFS_GET_FREE_SIZE_SYNC_0000
   * @tc.name statvfs_test_get_free_size_sync_000
   * @tc.desc Test getFreeSizeSync() interfaces, when the path is a sandbox path, promise way back.
   * @tc.size MEDIUM
   * @tc.type Function
   * @tc.level Level 0
   * @tc.require
  */
  it('statvfs_test_get_free_size_sync_000', Level.LEVEL0, async (done: Function) => {
    try {
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
      let context = abilityDelegator.getAppContext();
      let data = context.filesDir;
      let number = statvfs.getFreeSizeSync(data);
      console.log("getFreeSize getFilesDir===>" + (number / 1024));
      expect(isIntNum(number)).assertTrue();
      done();
    } catch (e) {
      console.log('statvfs_test_get_free_size_sync_000 has failed for ' + e.message + ', code: ' + e.code);
      expect(false).assertTrue();
      done();
    }
  });

  /**
   * @tc.number SUB_DF_STATFS_GET_FREE_SIZE_SYNC_0100
   * @tc.name statvfs_test_get_free_size_sync_001
   * @tc.desc Test getFreeSizeSync() interfaces, when the path is dev, callback way back.
   * @tc.size MEDIUM
   * @tc.type Function
   * @tc.level Level 0
   * @tc.require
  */
  it('statvfs_test_get_free_size_sync_001', Level.LEVEL0, async (done: Function) => {
    try {
      let number = statvfs.getFreeSizeSync("/dev");
      console.log("getFreeSizeNumber dev===>:" + (number / 1024));
      expect(isIntNum(number)).assertTrue();
      done();
    } catch (e) {
      console.log('statvfs_test_get_free_size_sync_001 has failed for ' + e.message + ', code: ' + e.code);
      expect(false).assertTrue();
      done();
    }
  });

  /**
   * @tc.number SUB_DF_STATFS_GET_FREE_SIZE_SYNC_0200
   * @tc.name statvfs_test_get_free_size_sync_002
   * @tc.desc Test getFreeSizeSync() interfaces, when the parameter type is wrong.
   * @tc.size MEDIUM
   * @tc.type Function
   * @tc.level Level 3
   * @tc.require
  */
  it('statvfs_test_get_free_size_sync_002', Level.LEVEL3, async (done: Function) => {
    try {
      statvfs.getFreeSizeSync("1");
      expect(false).assertTrue();
      done();
    } catch (e) {
      console.log('statvfs_test_get_free_size_sync_002 has failed for ' + e.message + ', code: ' + e.code);
      expect(e.code == 13900002 && e.message == 'No such file or directory').assertTrue();
      done();
    }
  });

  /**
   * @tc.number SUB_DF_STATFS_GET_FREE_SIZE_SYNC_0300
   * @tc.name statvfs_test_get_free_size_sync_003
   * @tc.desc Test getFreeSizeSync() interfaces, when the path is empty.
   * @tc.size MEDIUM
   * @tc.type Function
   * @tc.level Level 3
   * @tc.require
  */
  it('statvfs_test_get_free_size_sync_003', Level.LEVEL3, async (done: Function) => {
    try {
      statvfs.getFreeSizeSync("");
      expect(false).assertFalse();
      done();
    } catch (e) {
      console.log('statvfs_test_get_free_size_sync_003 has failed for ' + e.message + ', code: ' + e.code);
      expect(e.code == 13900002 && e.message == 'No such file or directory').assertTrue();
      done();
    }
  });

  /**
   * @tc.number SUB_DF_STATFS_GET_TOTAL_SIZE_SYNC_0000
   * @tc.name statvfs_test_get_total_size_sync_000
   * @tc.desc Test getTotalSizeSync() interfaces, when the path is a sandbox path, promise way back.
   * @tc.size MEDIUM
   * @tc.type Function
   * @tc.level Level 0
   * @tc.require
  */
  it('statvfs_test_get_total_size_sync_000', Level.LEVEL0, async (done: Function) => {
    try {
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
      let context = abilityDelegator.getAppContext();
      let data = context.filesDir;
      let number = statvfs.getTotalSizeSync(data);
      console.log("getTotalSizeNumber GetFilesDir====>:" + (number / 1024));
      expect(isIntNum(number)).assertTrue();
      done();
    } catch (e) {
      console.log('statvfs_test_get_total_size_sync_000 has failed for ' + e.message + ', code: ' + e.code);
      expect(false).assertTrue();
      done();
    }
  });

  /**
   * @tc.number SUB_DF_STATFS_GET_TOTAL_SIZE_SYNC_0100
   * @tc.name statvfs_test_get_total_size_sync_001
   * @tc.desc Test getTotalSizeSync() interfaces, when the path is dev, callback way back.
   * @tc.size MEDIUM
   * @tc.type Function
   * @tc.level Level 0
   * @tc.require
  */
  it('statvfs_test_get_total_size_sync_001', Level.LEVEL0, async (done: Function) => {
    try {
      let number = statvfs.getTotalSizeSync("/dev");
      console.log("getTotalSizeNumber dev===>:" + (number / 1024));
      expect(isIntNum(number)).assertTrue();
      done();
    } catch (e) {
      console.log('statvfs_test_get_total_size_sync_001 has failed for ' + e.message + ', code: ' + e.code);
      expect(false).assertTrue();
      done();
    }
  });

  /**
   * @tc.number SUB_DF_STATFS_GET_TOTAL_SIZE_SYNC_0200
   * @tc.name statvfs_test_get_total_size_sync_002
   * @tc.desc Test getTotalSizeSync() interfaces, when the parameter type is wrong.
   * @tc.size MEDIUM
   * @tc.type Function
   * @tc.level Level 3
   * @tc.require
  */
  it('statvfs_test_get_total_size_sync_002', Level.LEVEL3, async (done: Function) => {
    try {
      statvfs.getTotalSizeSync("1");
      expect(false).assertTrue();
      done();
    } catch (e) {
      console.log('statvfs_test_get_total_size_sync_002 has failed for ' + e.message + ', code: ' + e.code);
      expect(e.code == 13900002 && e.message == 'No such file or directory').assertTrue();
      done();
    }
  });

  /**
   * @tc.number SUB_DF_STATFS_GET_TOTAL_SIZE_SYNC_0300
   * @tc.name statvfs_test_get_total_size_sync_003
   * @tc.desc Test getTotalSizeSync() interfaces, when the path is empty.
   * @tc.size MEDIUM
   * @tc.type Function
   * @tc.level Level 3
   * @tc.require
  */
  it('statvfs_test_get_total_size_sync_003', Level.LEVEL3, async (done: Function) => {
    try {
      statvfs.getTotalSizeSync("");
      expect(false).assertFalse();
      done();
    } catch (e) {
      console.log('statvfs_test_get_total_size_sync_003 has failed for ' + e.message + ', code: ' + e.code);
      expect(e.code == 13900002 && e.message == 'No such file or directory').assertTrue();
      done();
    }
  });

  /**
   * @tc.number SUB_DF_STATFS_GET_FREE_SIZE_0000
   * @tc.name statvfs_test_get_free_size_async_000
   * @tc.desc Test getFreeSize() interfaces, when the path is a sandbox path, promise way back.
   * @tc.size MEDIUM
   * @tc.type Function
   * @tc.level Level 0
   * @tc.require
  */
  it('statvfs_test_get_free_size_async_000', Level.LEVEL0, async (done: Function) => {
    try {
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
      let context = abilityDelegator.getAppContext();
      let data = context.filesDir;
      let number = await statvfs.getFreeSize(data);
      console.log("getFreeSize getFilesDir===>" + (number / 1024));
      expect(isIntNum(number)).assertTrue();
      done();
    } catch (e) {
      console.log('statvfs_test_get_free_size_async_000 has failed for ' + e.message + ', code: ' + e.code);
      expect(false).assertTrue();
      done();
    }
  });

  /**
   * @tc.number SUB_DF_STATFS_GET_FREE_SIZE_0100
   * @tc.name statvfs_test_get_free_size_async_001
   * @tc.desc Test getFreeSize() interfaces, when the path is dev, callback way back.
   * @tc.size MEDIUM
   * @tc.type Function
   * @tc.level Level 0
   * @tc.require
  */
  it('statvfs_test_get_free_size_async_001', Level.LEVEL0, async (done: Function) => {
    try {
      statvfs.getFreeSize("/dev", (err, number) => {
        if (err) {
          console.log('statvfs_test_get_free_size_async_001 error package: ' + JSON.stringify(err));
          expect(false).assertTrue();
          done();
        }
        console.log("getFreeSizeNumber dev===>:" + (number / 1024));
        expect(isIntNum(number)).assertTrue();
        done();
      });
    } catch (e) {
      console.log('statvfs_test_get_free_size_async_001 has failed for ' + e.message + ', code: ' + e.code);
      expect(false).assertTrue();
      done();
    }
  });

  /**
   * @tc.number SUB_DF_STATFS_GET_FREE_SIZE_0200
   * @tc.name statvfs_test_get_free_size_async_002
   * @tc.desc Test getFreeSize() interfaces, when the parameter type is wrong.
   * @tc.size MEDIUM
   * @tc.type Function
   * @tc.level Level 0
   * @tc.require
  */
  it('statvfs_test_get_free_size_async_002', Level.LEVEL0, async (done: Function) => {
    try {
      await statvfs.getFreeSize("1");
      expect(false).assertTrue();
      done();
    } catch (e) {
      console.log('statvfs_test_get_free_size_async_002 has failed for ' + e.message + ', code: ' + e.code);
      expect(e.code == 13900002 && e.message == 'No such file or directory').assertTrue();
      done();
    }
  });

  /**
   * @tc.number SUB_DF_STATFS_GET_FREE_SIZE_0300
   * @tc.name statvfs_test_get_free_size_async_003
   * @tc.desc Test getFreeSize() interfaces, when the path is empty.
   * @tc.size MEDIUM
   * @tc.type Function
   * @tc.level Level 0
   * @tc.require
  */
  it('statvfs_test_get_free_size_async_003', Level.LEVEL0, async (done: Function) => {
    try {
      await statvfs.getFreeSize("");
      expect(false).assertFalse();
      done();
    } catch (e) {
      console.log('statvfs_test_get_free_size_async_003 has failed for ' + e.message + ', code: ' + e.code);
      expect(e.code == 13900002 && e.message == 'No such file or directory').assertTrue();
      done();
    }
  });

  /**
   * @tc.number SUB_DF_STATFS_GET_FREE_SIZE_0400
   * @tc.name statvfs_test_get_free_size_async_004
   * @tc.desc Test getFreeSize() interfaces, when the path is empty.
   * @tc.size MEDIUM
   * @tc.type Function
   * @tc.level Level 0
   * @tc.require
  */
  it('statvfs_test_get_free_size_async_004', Level.LEVEL0, async (done: Function) => {
    try {
      statvfs.getFreeSize("", (err) => {
        if (err) {
          console.log(
            'statvfs_test_get_free_size_async_004 error package: {' + err.message + ', code: ' + err.code + '}');
          expect(err.code == 13900002 && err.message == 'No such file or directory').assertTrue();
          done();
        }
      });
    } catch (e) {
      console.log('statvfs_test_get_free_size_async_004 has failed for ' + e.message + ', code: ' + e.code);
      expect(false).assertTrue();
      done();
    }
  });

  /**
   * @tc.number SUB_DF_STATFS_GET_TOTAL_SIZE_0000
   * @tc.name statvfs_test_get_total_size_async_000
   * @tc.desc Test getTotalSize() interfaces, when the path is a sandbox path, promise way back.
   * @tc.size MEDIUM
   * @tc.type Function
   * @tc.level Level 0
   * @tc.require
  */
  it('statvfs_test_get_total_size_async_000', Level.LEVEL0, async (done: Function) => {

    try {
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
      let context = abilityDelegator.getAppContext();
      let data = context.filesDir;
      let number = await statvfs.getTotalSize(data);
      console.log("getTotalSizeNumber GetFilesDir====>:" + (number / 1024));
      expect(isIntNum(number)).assertTrue();
      done();
    } catch (e) {
      console.log('statvfs_test_get_total_size_async_000 has failed for ' + e.message + ', code: ' + e.code);
      expect(false).assertTrue();
      done();
    }
  });

  /**
   * @tc.number SUB_DF_STATFS_GET_TOTAL_SIZE_0100
   * @tc.name statvfs_test_get_total_size_async_001
   * @tc.desc Test getTotalSize() interfaces, when the path is dev, callback way back.
   * @tc.size MEDIUM
   * @tc.type Function
   * @tc.level Level 0
   * @tc.require
  */
  it('statvfs_test_get_total_size_async_001', Level.LEVEL0, async (done: Function) => {

    try {
      statvfs.getTotalSize("/dev", (err, number) => {
        if (err) {
          console.log('statvfs_test_get_total_size_async_001 error package: ' + JSON.stringify(err));
          expect(false).assertTrue();
          done();
        }
        console.log("getTotalSizeNumber dev===>:" + (number / 1024));
        expect(isIntNum(number)).assertTrue();
        done();
      });
    } catch (e) {
      console.log('statvfs_test_get_total_size_async_001 has failed for ' + e.message + ', code: ' + e.code);
      expect(false).assertTrue();
      done();
    }
  });

  /**
   * @tc.number SUB_DF_STATFS_GET_TOTAL_SIZE_0200
   * @tc.name statvfs_test_get_total_size_async_002
   * @tc.desc Test getTotalSize() interfaces, when the parameter type is wrong.
   * @tc.size MEDIUM
   * @tc.type Function
   * @tc.level Level 0
   * @tc.require
  */
  it('statvfs_test_get_total_size_async_002', Level.LEVEL0, async (done: Function) => {

    try {
      await statvfs.getTotalSize("1");
      expect(false).assertTrue();
      done();
    } catch (e) {
      console.log('statvfs_test_get_total_size_async_002 has failed for ' + e.message + ', code: ' + e.code);
      expect(e.code == 13900002 && e.message == 'No such file or directory').assertTrue();
      done();
    }
  });

  /**
   * @tc.number SUB_DF_STATFS_GET_TOTAL_SIZE_0300
   * @tc.name statvfs_test_get_total_size_async_003
   * @tc.desc Test getTotalSize() interfaces, when the path is empty.
   * @tc.size MEDIUM
   * @tc.type Function
   * @tc.level Level 0
   * @tc.require
  */
  it('statvfs_test_get_total_size_async_003', Level.LEVEL0, async (done: Function) => {

    try {
      await statvfs.getTotalSize("");
      expect(false).assertTrue();
      done();
    } catch (e) {
      console.log('statvfs_test_get_total_size_async_003 has failed for ' + e.message + ', code: ' + e.code);
      expect(e.code == 13900002 && e.message == 'No such file or directory').assertTrue();
      done();
    }
  });

  /**
   * @tc.number SUB_DF_STATFS_GET_TOTAL_SIZE_0400
   * @tc.name statvfs_test_get_total_size_async_004
   * @tc.desc Test getTotalSize() interfaces, when the path is empty.
   * @tc.size MEDIUM
   * @tc.type Function
   * @tc.level Level 0
   * @tc.require
  */
  it('statvfs_test_get_total_size_async_004', Level.LEVEL0, async (done: Function) => {

    try {
      statvfs.getTotalSize("", (err) => {
        if (err) {
          console.log(
            'statvfs_test_get_total_size_async_004 error package: {' + err.message + ', code: ' + err.code + '}');
          expect(err.code == 13900002 && err.message == 'No such file or directory').assertTrue();
          done();
        }
      });
    } catch (e) {
      console.log('statvfs_test_get_total_size_async_004 has failed for ' + e.message + ', code: ' + e.code);
      expect(false).assertTrue();
      done();
    }
  });
});
}