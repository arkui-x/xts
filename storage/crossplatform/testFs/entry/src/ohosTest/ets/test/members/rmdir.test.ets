/*
 * Copyright (C) 2023-2025 Huawei Device Co., Ltd.
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

import {
  FILE_CONTENT,
  prepareFile,
  nextFileName,
  nextFileNameInFilesDir,
  describe,
  it,
  expect,
  afterEach
} from "../Common";
import fileIO from "@ohos.file.fs";

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function fileIORmdir() {
  describe("fileIO_fs_rmdir", () => {
    afterEach(async () => {
      await sleep(500);
    });
    /**
     * @tc.number : SUB_FM_TEST_FILEFS_RMDIR_ASYNC_0000
     * @tc.name   : fileIO_test_rmdir_async_000
     * @tc.desc   : Test rmdir() interfaces. Promise.
     * Recursively delete all files and subfolders in a directory.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_rmdir_async_000", 2, async (done: Function) => {
      let dpath = (await nextFileName("fileIO_test_rmdir_async_000")) + "d";
      let fpath = dpath + "/rmdir_async_000";
      let ffpath = dpath + "/rmdir_async_000_1";
      let ddpath = dpath + "/rmdir_async_000_1d";
      let fffpath = ddpath + "/rmdir_async_000_2";
      fileIO.mkdirSync(dpath);
      fileIO.mkdirSync(ddpath);
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
      expect(prepareFile(ffpath, FILE_CONTENT)).assertTrue();
      expect(prepareFile(fffpath, FILE_CONTENT)).assertTrue();

      try {
        // @ts-nocheck
        expect(fileIO.accessSync(ddpath)).assertTrue();
        // @ts-nocheck
        expect(fileIO.accessSync(fffpath)).assertTrue();
        await fileIO.rmdir(dpath);
        // @ts-nocheck
        expect(!fileIO.accessSync(dpath)).assertTrue();
        // @ts-nocheck
        expect(!fileIO.accessSync(ddpath)).assertTrue();
        // @ts-nocheck
        expect(!fileIO.accessSync(fffpath)).assertTrue();
        done();
      } catch (e) {
        console.log("fileIO_test_rmdir_async_000 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_RMDIR_ASYNC_0100
     * @tc.name   : fileIO_test_rmdir_async_001
     * @tc.desc   : Test rmdir() interfaces. Promise.
     * Invalid path.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_rmdir_async_001", 3, async (done: Function) => {
      let dpath = (await nextFileName("fileIO_test_rmdir_async_001")) + "d";

      try {
        await fileIO.rmdir(dpath);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_rmdir_async_001 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900002 && e.message == "No such file or directory").assertTrue();
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_RMDIR_ASYNC_0200
     * @tc.name   : fileIO_test_rmdir_async_002
     * @tc.desc   : Test rmdir() interfaces. Promise.
     * The path contains ../, normal call.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_rmdir_async_002", 2, async () => {
      let dpath = (await nextFileNameInFilesDir("../files/fileIO_test_rmdir_async_002")) + "d";

      try {
        fileIO.mkdirSync(dpath);
        // @ts-nocheck
        expect(fileIO.accessSync(dpath)).assertTrue();
        await fileIO.rmdir(dpath);
        // @ts-nocheck
        expect(!fileIO.accessSync(dpath)).assertTrue();
      } catch (e) {
        console.log("fileIO_test_rmdir_async_002 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_RMDIR_ASYNC_0300
     * @tc.name   : fileIO_test_rmdir_async_003
     * @tc.desc   : Test rmdir() interfaces. Callback.
     * Recursively delete all files and subfolders in a directory.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_rmdir_async_003", 2, async (done: Function) => {
      let dpath = (await nextFileName("fileIO_test_rmdir_async_003")) + "d";
      let fpath = dpath + "/rmdir_async_001";
      let ffpath = dpath + "/rmdir_async_001_1";
      let ddpath = dpath + "/rmdir_async_001_1d";
      let fffpath = ddpath + "/rmdir_async_001_2";
      fileIO.mkdirSync(dpath);
      fileIO.mkdirSync(ddpath);
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
      expect(prepareFile(ffpath, FILE_CONTENT)).assertTrue();
      expect(prepareFile(fffpath, FILE_CONTENT)).assertTrue();

      try {
        // @ts-nocheck
        expect(fileIO.accessSync(ddpath)).assertTrue();
        // @ts-nocheck
        expect(fileIO.accessSync(fffpath)).assertTrue();
        fileIO.rmdir(dpath, (err) => {
          if (err) {
            console.log("fileIO_test_rmdir_async_003 error package: " + JSON.stringify(err));
            expect(false).assertTrue();
          }
          // @ts-nocheck
          expect(!fileIO.accessSync(dpath)).assertTrue();
          // @ts-nocheck
          expect(!fileIO.accessSync(ddpath)).assertTrue();
          // @ts-nocheck
          expect(!fileIO.accessSync(fffpath)).assertTrue();
          done();
        });
      } catch (e) {
        console.log("fileIO_test_rmdir_async_003 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_RMDIR_ASYNC_0400
     * @tc.name   : fileIO_test_rmdir_async_004
     * @tc.desc   : Test rmdir() interfaces. Callback.
     * Invalid path.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_rmdir_async_004", 3, async (done: Function) => {
      let dpath = (await nextFileName("fileIO_test_rmdir_async_004")) + "d";

      try {
        fileIO.rmdir(dpath, (err) => {
          if (err) {
            console.log("fileIO_test_rmdir_async_004 error: {message: " + err.message + ", code: " + err.code + "}");
            expect(err.code == 13900002 && err.message == "No such file or directory").assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log("fileIO_test_rmdir_async_004 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_RMDIR_ASYNC_0500
     * @tc.name   : fileIO_test_rmdir_async_005
     * @tc.desc   : Test rmdir() interfaces. Callback.
     * The path contains ../, normal call.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_rmdir_async_005", 2, async (done: Function) => {
      let dpath = (await nextFileNameInFilesDir("../files/fileIO_test_rmdir_async_005")) + "d";
      fileIO.mkdirSync(dpath);
      // @ts-nocheck
      expect(fileIO.accessSync(dpath)).assertTrue();

      try {
        fileIO.rmdir(dpath, (err) => {
          if (err) {
            console.log("fileIO_test_rmdir_async_005 error: {message: " + err.message + ", code: " + err.code + "}");
            expect(err.code == 13900002 && err.message == "No such file or directory").assertTrue();
          }
          // @ts-nocheck
          expect(!fileIO.accessSync(dpath)).assertTrue();
          done();
        });
      } catch (e) {
        console.log("fileIO_test_rmdir_async_005 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_RMDIR_ASYNC_0700
     * @tc.name   : fileIO_test_rmdir_async_007
     * @tc.desc   : Test rmdir() interfaces. Callback.
     * Missing parameter.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_rmdir_async_007", 3, async (done: Function) => {
      try {
        fileIO.rmdir("", (err) => {
          if (err) {
            console.log("fileIO_test_rmdir_async_007 error: {message: " + err.message + ", code: " + err.code + "}");
            expect(err.code == 13900002 && err.message == "No such file or directory").assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log("fileIO_test_rmdir_async_007 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_RMDIR_SYNC_0000
     * @tc.name   : fileIO_test_rmdir_sync_000
     * @tc.desc   : Test rmdirSync() interfaces.
     * Recursively delete all files and subfolders in a directory.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_rmdir_sync_000", 2, async () => {
      let dpath = (await nextFileName("fileIO_test_rmdir_sync_000")) + "d";
      let fpath = dpath + "/rmdir_sync_000";
      let ffpath = dpath + "/rmdir_sync_000_1";
      let ddpath = dpath + "/rmdir_sync_000_1d";
      let fffpath = ddpath + "/rmdir_sync_000";
      fileIO.mkdirSync(dpath);
      fileIO.mkdirSync(ddpath);
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
      expect(prepareFile(ffpath, FILE_CONTENT)).assertTrue();
      expect(prepareFile(fffpath, FILE_CONTENT)).assertTrue();

      try {
        // @ts-nocheck
        expect(fileIO.accessSync(ddpath)).assertTrue();
        // @ts-nocheck
        expect(fileIO.accessSync(fffpath)).assertTrue();
        fileIO.rmdirSync(dpath);
        // @ts-nocheck
        expect(!fileIO.accessSync(dpath)).assertTrue();
        // @ts-nocheck
        expect(!fileIO.accessSync(ddpath)).assertTrue();
        // @ts-nocheck
        expect(!fileIO.accessSync(fffpath)).assertTrue();
      } catch (e) {
        console.log("fileIO_test_rmdir_sync_000 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_RMDIR_SYNC_0100
     * @tc.name   : fileIO_test_rmdir_sync_001
     * @tc.desc   : Test rmdirSync() interfaces.
     * Invalid path.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_rmdir_sync_001", 3, async () => {
      let dpath = (await nextFileName("fileIO_test_rmdir_sync_001")) + "d";

      try {
        fileIO.rmdirSync(dpath);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_rmdir_sync_001 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900002 && e.message == "No such file or directory").assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_RMDIR_SYNC_0200
     * @tc.name   : fileIO_test_rmdir_sync_002
     * @tc.desc   : Test rmdirSync() interfaces.
     * The path contains ../, normal call.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_rmdir_sync_002", 2, async () => {
      let dpath = (await nextFileNameInFilesDir("../files/fileIO_test_rmdir_sync_002")) + "d";

      try {
        fileIO.mkdirSync(dpath);
        // @ts-nocheck
        expect(fileIO.accessSync(dpath)).assertTrue();
        fileIO.rmdirSync(dpath);
        // @ts-nocheck
        expect(!fileIO.accessSync(dpath)).assertTrue();
      } catch (e) {
        console.log("fileIO_test_rmdir_sync_002 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });
  });
}
