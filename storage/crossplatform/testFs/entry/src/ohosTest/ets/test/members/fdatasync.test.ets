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

import { FILE_CONTENT, nextFileName, prepareFile, describe, it, expect, afterEach } from "../Common";
import fileIO from "@ohos.file.fs";

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function fileIOFdatasync() {
  describe("fileIO_fs_fdatasync", () => {
    afterEach(async () => {
      await sleep(500);
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_FDATASYNC_ASYNC_0000
     * @tc.name   : fileIO_test_fdatasync_async_000
     * @tc.desc   : Test fdatasync() interfaces. Promise.
     * Open the file in read-write mode, and synchronize the file content data.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_fdatasync_async_000", 2, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_fdatasync_async_000");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let file = fileIO.openSync(fpath, fileIO.OpenMode.READ_WRITE);
        await fileIO.fdatasync(file.fd);
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
        done();
      } catch (e) {
        console.log("fileIO_test_fdatasync_async_000 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_FDATASYNC_ASYNC_0100
     * @tc.name   : fileIO_test_fdatasync_async_001
     * @tc.desc   : Test fdatasync() interfaces. Promise.
     * Invalid fd parameter.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_fdatasync_async_001", 3, async (done: Function) => {
      try {
        await fileIO.fdatasync(-1);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_fdatasync_async_001 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900008 && e.message == "Bad file descriptor").assertTrue();
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_FDATASYNC_ASYNC_0200
     * @tc.name   : fileIO_test_fdatasync_async_002
     * @tc.desc   : Test fdatasync() interfaces. Callback.
     * Open the file in read-write mode, and synchronize the file content data.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_fdatasync_async_002", 2, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_fdatasync_async_002");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let file = fileIO.openSync(fpath, fileIO.OpenMode.READ_WRITE);
        fileIO.fdatasync(file.fd, (err) => {
          if (err) {
            console.log("fileIO_test_fdatasync_async_002 error package: " + JSON.stringify(err));
            expect(false).assertTrue();
          }
          fileIO.closeSync(file);
          fileIO.unlinkSync(fpath);
          done();
        });
      } catch (e) {
        console.log("fileIO_test_fdatasync_async_002 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_FDATASYNC_ASYNC_0300
     * @tc.name   : fileIO_test_fdatasync_async_003
     * @tc.desc   : Test fdatasync() interfaces. Callback.
     * Invalid fd parameter.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_fdatasync_async_003", 3, async (done: Function) => {
      try {
        fileIO.fdatasync(-1, (err) => {
          if (err) {
            console.log("fileIO_test_fdatasync_async_003 error: {message: " + err.message + ", code: " + err.code +
              "}");
            expect(err.code == 13900008 && err.message == "Bad file descriptor").assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log("fileIO_test_fdatasync_async_003 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_FDATASYNC_SYNC_0000
     * @tc.name   : fileIO_test_fdatasync_sync_000
     * @tc.desc   : Test fdatasyncSync() interfaces.
     * Open the file in read-write mode, and synchronize the file content data.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_fdatasync_sync_000", 2, async () => {
      let fpath = await nextFileName("fileIO_test_fdatasync_sync_000");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let file = fileIO.openSync(fpath, fileIO.OpenMode.READ_WRITE);
        fileIO.fdatasyncSync(file.fd);
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
      } catch (e) {
        console.log("fileIO_test_fdatasync_sync_000 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_FDATASYNC_SYNC_0100
     * @tc.name   : fileIO_test_fdatasync_sync_001
     * @tc.desc   : Test fdatasyncSync() interfaces.
     * Invalid fd parameter.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_fdatasync_sync_001", 3, async () => {
      try {
        fileIO.fdatasyncSync(-1);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_fdatasync_sync_001 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900008 && e.message == "Bad file descriptor").assertTrue();
      }
    });
  });
}
