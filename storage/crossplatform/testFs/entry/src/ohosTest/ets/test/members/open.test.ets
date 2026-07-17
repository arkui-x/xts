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

import { FILE_CONTENT, nextFileName, prepareFile, isIntNum, describe, it, expect, afterEach, randomString } from "../Common";
import fileIO from "@ohos.file.fs";
import fileUri from "@ohos.file.fileuri";
import { BusinessError } from "@kit.BasicServicesKit";

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function fileIOOpen() {
  describe("fileIO_fs_open", () => {
    afterEach(async () => {
      await sleep(500);
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_0000
     * @tc.name   : fileIO_test_open_async_000
     * @tc.desc   : Test open() interfaces. mode=0o0. Promise.
     * Open the file in read-only mode, verifying the file is readable.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_async_000", 2, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_000");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
      let file = await fileIO.open(fpath, fileIO.OpenMode.READ_ONLY);

      try {
        expect(isIntNum(file.fd)).assertTrue();
        fileIO.read(file.fd, new ArrayBuffer(4096)).then((readLen) => {
          expect(readLen == FILE_CONTENT.length).assertTrue();
        });
        fileIO.writeSync(file.fd, new ArrayBuffer(4096));
        expect(false).assertTrue();
      } catch (e) {
        fileIO.closeSync(file)
        fileIO.unlinkSync(fpath);
        console.log("fileIO_test_open_async_000 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900008 && e.message == "Bad file descriptor").assertTrue();
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_0100
     * @tc.name   : fileIO_test_open_async_001
     * @tc.desc   : Test open() interfaces.  mode=0o1. Promise.
     * Open the file in write-only mode, verifying the file is writable.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_async_001", 2, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_001");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
      let length = 20;

      try {
        let file = await fileIO.open(fpath, fileIO.OpenMode.WRITE_ONLY);
        expect(isIntNum(file.fd)).assertTrue();
        fileIO.write(file.fd, new ArrayBuffer(length)).then((bytesWritten) => {
          expect(bytesWritten == length).assertTrue();
          fileIO.closeSync(file);
          fileIO.unlinkSync(fpath);
          done();
        });
      } catch (e) {
        console.log("fileIO_test_open_async_001 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_0200
     * @tc.name   : fileIO_test_open_async_002
     * @tc.desc   : Test open() interfaces.  mode=0o2. Promise.
     * The path point to nothing, no such file.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_002", 3, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_002");

      try {
        await fileIO.open(fpath, fileIO.OpenMode.READ_WRITE);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_open_async_002 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900002 && e.message == "No such file or directory").assertTrue();
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_0300
     * @tc.name   : fileIO_test_open_async_003
     * @tc.desc   : Test open() interfaces.  mode=0o102. Promise.
     * If the path point to the file which does not exist, the file can be created.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_async_003", 2, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_003");

      try {
        let file = await fileIO.open(fpath, fileIO.OpenMode.CREATE | fileIO.OpenMode.READ_WRITE);
        expect(isIntNum(file.fd)).assertTrue();
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
        done();
      } catch (e) {
        console.log("fileIO_test_open_async_003 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_0400
     * @tc.name   : fileIO_test_open_async_004
     * @tc.desc   : Test open() interfaces.  mode=0o1002. Promise.
     * If the file exists and the file is opened for read-write, trim its length to zero.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_async_004", 2, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_004");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let file = await fileIO.open(fpath, fileIO.OpenMode.TRUNC | fileIO.OpenMode.READ_WRITE);
        expect(isIntNum(file.fd)).assertTrue();
        fileIO.read(file.fd, new ArrayBuffer(4096)).then((readLen) => {
          expect(readLen == 0).assertTrue();
          fileIO.closeSync(file);
          fileIO.unlinkSync(fpath);
        });
        done();
      } catch (e) {
        console.log("fileIO_test_open_async_004 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_0500
     * @tc.name   : fileIO_test_open_async_005
     * @tc.desc   : Test open() interfaces.  mode=0o2002. Promise.
     * Open as append, subsequent writes will append to the end of the file.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_async_005", 2, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_005");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
      let length = 100;

      try {
        let file = await fileIO.open(fpath, fileIO.OpenMode.APPEND | fileIO.OpenMode.READ_WRITE);
        expect(isIntNum(file.fd)).assertTrue();
        fileIO.writeSync(file.fd, new ArrayBuffer(length));
        fileIO.read(file.fd, new ArrayBuffer(4096), {
          offset: 0
        }).then((readLen) => {
          expect(readLen == length + FILE_CONTENT.length).assertTrue();
          fileIO.closeSync(file);
          fileIO.unlinkSync(fpath);
        });
        done();
      } catch (e) {
        console.log("fileIO_test_open_async_005 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_0600
     * @tc.name   : fileIO_test_open_async_006
     * @tc.desc   : Test open() interfaces.  mode=0o4002. Promise.
     * If the file is a special file, the opening and subsequent IOs perform non-blocking operations.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_async_006", 2, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_006");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let file = await fileIO.open(fpath, fileIO.OpenMode.NONBLOCK | fileIO.OpenMode.READ_WRITE);
        expect(isIntNum(file.fd)).assertTrue();
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
        done();
      } catch (e) {
        console.log("fileIO_test_open_async_006 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_0700
     * @tc.name   : fileIO_test_open_async_007
     * @tc.desc   : Test open() interfaces.  mode=0o200000. Promise.
     * The path points to a directory.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_async_007", 2, async (done: Function) => {
      let dpath = await nextFileName("fileIO_test_open_async_007");
      fileIO.mkdirSync(dpath);

      try {
        let file = await fileIO.open(dpath, fileIO.OpenMode.DIR);
        expect(isIntNum(file.fd)).assertTrue();
        fileIO.rmdirSync(dpath);
        done();
      } catch (e) {
        console.log("fileIO_test_open_async_007 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_0800
     * @tc.name   : fileIO_test_open_async_008
     * @tc.desc   : Test open() interfaces.  mode=0o200000. Promise.
     * The path does not point to a directory, throw error.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_008", 3, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_008");
      expect(prepareFile(fpath, "")).assertTrue();

      try {
        await fileIO.open(fpath, fileIO.OpenMode.DIR);
        expect(false).assertTrue();
      } catch (e) {
        fileIO.unlinkSync(fpath);
        console.log("fileIO_test_open_async_008 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900018 && e.message == "Not a directory").assertTrue();
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_0900
     * @tc.name   : fileIO_test_open_async_009
     * @tc.desc   : Test open() interfaces.  mode=0o400002. Promise.
     * The path does not point to a symbolic link.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_async_009", 2, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_009");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let file = await fileIO.open(fpath, fileIO.OpenMode.NOFOLLOW | fileIO.OpenMode.READ_WRITE);
        expect(isIntNum(file.fd)).assertTrue();
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
        done();
      } catch (e) {
        console.log("fileIO_test_open_async_009 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_1000
     * @tc.name   : fileIO_test_open_async_010
     * @tc.desc   : Test open() interfaces.  mode=0o4010002. Promise.
     * Open the file in the way of synchronous IO.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_async_010", 2, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_010");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let file = await fileIO.open(fpath, fileIO.OpenMode.SYNC | fileIO.OpenMode.READ_WRITE);
        expect(isIntNum(file.fd)).assertTrue();
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
        done();
      } catch (e) {
        console.log("fileIO_test_open_async_010 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_1100
     * @tc.name   : fileIO_test_open_async_011
     * @tc.desc   : Test open() interfaces. Promise.
     * The path refers to a file, not a directory.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_011", 3, async (done: Function) => {
      let dpath = await nextFileName("fileIO_test_open_async_011");
      fileIO.mkdirSync(dpath);

      try {
        await fileIO.open(dpath, fileIO.OpenMode.READ_WRITE);
        expect(false).assertTrue();
      } catch (e) {
        fileIO.rmdirSync(dpath);
        console.log("fileIO_test_open_async_011 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900019 && e.message == "Is a directory").assertTrue();
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_1200
     * @tc.name   : fileIO_test_open_async_012
     * @tc.desc   : Test open() interfaces. Promise.
     * Undefined option arguments, use default mode = 0o0.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_012", 3, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_012");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      let file: fileIO.File = await fileIO.open(fpath);
      ;
      try {
        expect(isIntNum(file.fd)).assertTrue();
        let readLen = fileIO.readSync(file.fd, new ArrayBuffer(4096));
        expect(readLen == FILE_CONTENT.length).assertTrue();
        fileIO.writeSync(file.fd, new ArrayBuffer(4096));
        expect(false).assertTrue();
      } catch (e) {
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
        console.log("fileIO_test_open_async_012 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900008 && e.message == "Bad file descriptor").assertTrue();
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_1300
     * @tc.name   : fileIO_test_open_async_013
     * @tc.desc   : Test open() interfaces. mode=0o0. Callback.
     * Open the file in read-only mode, verifying the file is readable.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_async_013", 2, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_013");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        fileIO.open(fpath, fileIO.OpenMode.READ_ONLY, (err, file) => {
          if (err) {
            console.log("fileIO_test_open_async_013 error package: " + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(isIntNum(file.fd)).assertTrue();
          let readLen = fileIO.readSync(file.fd, new ArrayBuffer(4096));
          expect(readLen == FILE_CONTENT.length).assertTrue();
          fileIO
            .write(file.fd, new ArrayBuffer(4096))
            .then((writeLen) => {
              console.info("write data to file succeed and size is:" + writeLen);
              expect(false).assertTrue();
            })
            .catch((err: BusinessError) => {
              console.info("write data to file failed with error message: " + err.message + ", error code: " +
              err.code);
              expect(err.code == 13900008 && err.message == "Bad file descriptor").assertTrue();
              fileIO.unlinkSync(fpath);
              done();
            });
        });
      } catch (e) {
        console.log("fileIO_test_open_async_013 has failed for " + e.message + ", code: " + e.code);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_1400
     * @tc.name   : fileIO_test_open_async_014
     * @tc.desc   : Test open() interfaces. mode=0o1. Callback.
     * Open the file in write-only mode, verifying the file is writable.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_async_014", 2, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_014");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
      let length = 20;

      try {
        fileIO.open(fpath, fileIO.OpenMode.WRITE_ONLY, (err, file) => {
          if (err) {
            console.log("fileIO_test_open_async_014 error package" + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(isIntNum(file.fd)).assertTrue();
          fileIO.write(file.fd, new ArrayBuffer(length)).then((bytesWritten) => {
            expect(bytesWritten == length).assertTrue();
            fileIO.closeSync(file);
            fileIO.unlinkSync(fpath);
          });
        });
        done();
      } catch (e) {
        console.log("fileIO_test_open_async_014 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_1500
     * @tc.name   : fileIO_test_open_async_015
     * @tc.desc   : Test open() interfaces. mode=0o2. Callback.
     * The path point to nothing, no such file.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_015", 3, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_015");

      try {
        fileIO.open(fpath, fileIO.OpenMode.READ_WRITE, (err) => {
          if (err) {
            console.log("fileIO_test_open_async_015 error: {message: " + err.message + ", code: " + err.code + "}");
            expect(err.code == 13900002 && err.message == "No such file or directory").assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log("fileIO_test_open_async_015 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_1600
     * @tc.name   : fileIO_test_open_async_016
     * @tc.desc   : Test open() interfaces. mode=0o102. Callback.
     * If the path point to the file which does not exist, the file can be created.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_async_016", 2, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_016");

      try {
        fileIO.open(fpath, fileIO.OpenMode.CREATE | fileIO.OpenMode.WRITE_ONLY, (err, file) => {
          if (err) {
            console.log("fileIO_test_open_async_016 error package: " + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(isIntNum(file.fd)).assertTrue();
          fileIO.closeSync(file);
          fileIO.unlinkSync(fpath);
          done();
        });
      } catch (e) {
        console.log("fileIO_test_open_async_016 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_1700
     * @tc.name   : fileIO_test_open_async_017
     * @tc.desc   : Test open() interfaces. mode=0o1002. Callback.
     * If the file exists and the file is opened for read-write, trim its length to zero.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_async_017", 2, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_017");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        fileIO.open(fpath, fileIO.OpenMode.TRUNC | fileIO.OpenMode.READ_WRITE, (err, file) => {
          if (err) {
            console.log("fileIO_test_open_async_017 error package: " + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(isIntNum(file.fd)).assertTrue();
          fileIO.read(file.fd, new ArrayBuffer(4096)).then((readLen) => {
            expect(readLen == 0).assertTrue();
            fileIO.closeSync(file);
            fileIO.unlinkSync(fpath);
          });
          done();
        });
      } catch (e) {
        console.log("fileIO_test_open_async_017 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_1800
     * @tc.name   : fileIO_test_open_async_018
     * @tc.desc   : Test open() interfaces. mode=0o2002. Callback.
     * Open as append, subsequent writes will append to the end of the file.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_async_018", 2, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_018");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
      let length = 100;

      try {
        fileIO.open(fpath, fileIO.OpenMode.APPEND | fileIO.OpenMode.READ_WRITE, (err, file) => {
          if (err) {
            console.log("fileIO_test_open_async_018 error package: " + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(isIntNum(file.fd)).assertTrue();
          fileIO.writeSync(file.fd, new ArrayBuffer(length));
          fileIO.read(file.fd, new ArrayBuffer(4096), {
            offset: 0
          }).then((readLen) => {
            expect(readLen == length + FILE_CONTENT.length).assertTrue();
            fileIO.closeSync(file);
            fileIO.unlinkSync(fpath);
          });
          done();
        });
      } catch (e) {
        console.log("fileIO_test_open_async_018 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_1900
     * @tc.name   : fileIO_test_open_async_019
     * @tc.desc   : Test open() interfaces. mode=0o4002. Callback.
     * If the file is a special file, the opening and subsequent IOs perform non-blocking operations.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_async_019", 2, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_019");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        fileIO.open(fpath, fileIO.OpenMode.NONBLOCK | fileIO.OpenMode.READ_WRITE, (err, file) => {
          if (err) {
            console.log("fileIO_test_open_async_019 error package: " + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(isIntNum(file.fd)).assertTrue();
          fileIO.closeSync(file);
          fileIO.unlinkSync(fpath);
          done();
        });
      } catch (e) {
        console.log("fileIO_test_open_async_019 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_2000
     * @tc.name   : fileIO_test_open_async_020
     * @tc.desc   : Test open() interfaces. mode=0o200000. Callback.
     * The path points to a directory.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_async_020", 2, async (done: Function) => {
      let dpath = await nextFileName("fileIO_test_open_async_020");
      fileIO.mkdirSync(dpath);

      try {
        fileIO.open(dpath, fileIO.OpenMode.DIR, (err, file) => {
          if (err) {
            console.log("fileIO_test_open_async_020 error package: " + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(isIntNum(file.fd)).assertTrue();
          fileIO.rmdirSync(dpath);
          done();
        });
      } catch (e) {
        console.log("fileIO_test_open_async_020 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_2100
     * @tc.name   : fileIO_test_open_async_021
     * @tc.desc   : Test open() interfaces. mode=0o200000. Callback.
     * The path does not point to a directory, throw error.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_021", 3, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_021");
      expect(prepareFile(fpath, "")).assertTrue();

      try {
        fileIO.open(fpath, fileIO.OpenMode.DIR, (err) => {
          if (err) {
            fileIO.unlinkSync(fpath);
            console.log("fileIO_test_open_async_021 error: {message: " + err.message + ", code: " + err.code + "}");
            expect(err.code == 13900018 && err.message == "Not a directory").assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log("fileIO_test_open_async_021 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_2200
     * @tc.name   : fileIO_test_open_async_022
     * @tc.desc   : Test open() interfaces. mode=0o400002. Callback.
     * The path does not point to a symbolic link.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_async_022", 2, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_022");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        fileIO.open(fpath, fileIO.OpenMode.NOFOLLOW | fileIO.OpenMode.READ_WRITE, (err, file) => {
          if (err) {
            console.log("fileIO_test_open_async_022 error package: " + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(isIntNum(file.fd)).assertTrue();
          fileIO.closeSync(file);
          fileIO.unlinkSync(fpath);
          done();
        });
      } catch (e) {
        console.log("fileIO_test_open_async_022 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_2300
     * @tc.name   : fileIO_test_open_async_023
     * @tc.desc   : Test open() interfaces. mode=0o4010002. Callback.
     * Open the file in the way of synchronous IO.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_async_023", 2, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_023");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        fileIO.open(fpath, fileIO.OpenMode.SYNC | fileIO.OpenMode.READ_WRITE, (err, file) => {
          if (err) {
            console.log("fileIO_test_open_async_023 error package: " + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(isIntNum(file.fd)).assertTrue();
          fileIO.closeSync(file);
          fileIO.unlinkSync(fpath);
          done();
        });
      } catch (e) {
        console.log("fileIO_test_open_async_023 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_2400
     * @tc.name   : fileIO_test_open_async_024
     * @tc.desc   : Test open() interfaces. Callback.
     * The path refers to a file, not a directory.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_024", 3, async (done: Function) => {
      let dpath = await nextFileName("fileIO_test_open_async_024");
      fileIO.mkdirSync(dpath);

      try {
        fileIO.open(dpath, fileIO.OpenMode.READ_WRITE, (err, file) => {
          if (err) {
            fileIO.rmdirSync(dpath);
            console.log("fileIO_test_open_async_024 error: {message: " + err.message + ", code: " + err.code + "}");
            expect(err.code == 13900019 && err.message == "Is a directory").assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log("fileIO_test_open_async_024 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_2500
     * @tc.name   : fileIO_test_open_async_025
     * @tc.desc   : Test open() interfaces. Callback.
     * Undefined option arguments, use default mode = 0o0.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_025", 3, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_025");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        fileIO.open(fpath, (err, file) => {
          if (err) {
            console.log("fileIO_test_open_async_025 error package: " + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(isIntNum(file.fd)).assertTrue();
          let readLen = fileIO.readSync(file.fd, new ArrayBuffer(4096));
          expect(readLen == FILE_CONTENT.length).assertTrue();
          fileIO.write(file.fd, new ArrayBuffer(4096), (err, bytesWritten) => {
            if (err) {
              fileIO.closeSync(file);
              fileIO.unlinkSync(fpath);
              console.log("fileIO_test_open_async_025 error: {message: " + err.message + ", code: " + err.code + "}");
              expect(err.code == 13900008 && err.message == "Bad file descriptor").assertTrue();
              done();
            } else {
              expect(false).assertTrue();
            }
          });
        });
      } catch (e) {
        console.log("fileIO_test_open_async_025 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_0000
     * @tc.name   : fileIO_test_open_sync_000
     * @tc.desc   : Test openSync() interfaces. mode=0o0.
     * Open the file in read-only mode, verifying the file is readable.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_sync_000", 2, async () => {
      let fpath = await nextFileName("fileIO_test_open_sync_000");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let file = fileIO.openSync(fpath, fileIO.OpenMode.READ_ONLY);
        expect(isIntNum(file.fd)).assertTrue();
        let readlen = fileIO.readSync(file.fd, new ArrayBuffer(4096));
        expect(readlen == FILE_CONTENT.length).assertTrue();
        fileIO.writeSync(file.fd, new ArrayBuffer(4096));
        expect(false).assertTrue();
      } catch (e) {
        fileIO.unlinkSync(fpath);
        console.log("fileIO_test_open_sync_000 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900008 && e.message == "Bad file descriptor").assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_0100
     * @tc.name   : fileIO_test_open_sync_001
     * @tc.desc   : Test openSync() interfaces. mode=0o1.
     * Open the file in write-only mode, verifying the file is writable.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_sync_001", 2, async () => {
      let fpath = await nextFileName("fileIO_test_open_sync_001");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let file = fileIO.openSync(fpath, fileIO.OpenMode.WRITE_ONLY);
        expect(isIntNum(file.fd)).assertTrue();
        let bytesWritten = fileIO.writeSync(file.fd, FILE_CONTENT);
        expect(bytesWritten == FILE_CONTENT.length).assertTrue();
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
      } catch (e) {
        console.log("fileIO_test_open_sync_001 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_0200
     * @tc.name   : fileIO_test_open_sync_002
     * @tc.desc   : Test openSync() interfaces. mode=0o2.
     * Open the file in read-write mode, verifying the file is readable and writable.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_sync_002", 2, async () => {
      let fpath = await nextFileName("fileIO_test_open_sync_002");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let file = fileIO.openSync(fpath, fileIO.OpenMode.READ_WRITE);
        expect(isIntNum(file.fd)).assertTrue();
        let readlen = fileIO.readSync(file.fd, new ArrayBuffer(4096));
        expect(readlen == FILE_CONTENT.length).assertTrue();
        let length = 20;
        let bytesWritten = fileIO.writeSync(file.fd, new ArrayBuffer(length), {
          offset: 0
        });
        expect(bytesWritten == length).assertTrue();
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
      } catch (e) {
        console.log("fileIO_test_open_sync_002 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_0300
     * @tc.name   : fileIO_test_open_sync_003
     * @tc.desc   : Test openSync() interfaces. mode=0o102.
     * If the path point to the file which does not exist, the file can be created.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_sync_003", 2, async () => {
      let fpath = await nextFileName("fileIO_test_open_sync_003");

      try {
        let file = fileIO.openSync(fpath, fileIO.OpenMode.CREATE | fileIO.OpenMode.READ_WRITE);
        expect(isIntNum(file.fd)).assertTrue();
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
      } catch (e) {
        console.log("fileIO_test_open_sync_003 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_0400
     * @tc.name   : fileIO_test_open_sync_004
     * @tc.desc   : Test openSync() interfaces. mode=0o1002.
     * If the file exists and the file is opened for read-write, trim its length to zero.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_sync_004", 2, async () => {
      let fpath = await nextFileName("fileIO_test_open_sync_004");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let file = fileIO.openSync(fpath, fileIO.OpenMode.TRUNC | fileIO.OpenMode.READ_WRITE);
        expect(isIntNum(file.fd)).assertTrue();
        let readLen = fileIO.readSync(file.fd, new ArrayBuffer(4096));
        expect(readLen == 0).assertTrue();
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
      } catch (e) {
        console.log("fileIO_test_open_sync_004 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_0500
     * @tc.name   : fileIO_test_open_sync_005
     * @tc.desc   : Test openSync() interfaces. mode=0o2002.
     * Open as append, subsequent writes will append to the end of the file.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_sync_005", 2, async () => {
      let fpath = await nextFileName("fileIO_test_open_sync_005");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let file = fileIO.openSync(fpath, fileIO.OpenMode.APPEND | fileIO.OpenMode.READ_WRITE);
        expect(isIntNum(file.fd)).assertTrue();
        let length = 100;
        let bytesWritten = fileIO.writeSync(file.fd, new ArrayBuffer(length));
        expect(bytesWritten == length).assertTrue();
        let readLen = fileIO.readSync(file.fd, new ArrayBuffer(4096), {
          offset: 0
        });
        expect(readLen == length + FILE_CONTENT.length).assertTrue();
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
      } catch (e) {
        console.log("fileIO_test_open_sync_005 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_0600
     * @tc.name   : fileIO_test_open_sync_006
     * @tc.desc   : Test openSync() interfaces. mode=0o4002.
     * If the file is a special file, the opening and subsequent IOs perform non-blocking operations.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_sync_006", 2, async () => {
      let fpath = await nextFileName("fileIO_test_open_sync_006");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let file = fileIO.openSync(fpath, fileIO.OpenMode.NONBLOCK | fileIO.OpenMode.READ_WRITE);
        expect(isIntNum(file.fd)).assertTrue();
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
      } catch (e) {
        console.log("fileIO_test_open_sync_006 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_0700
     * @tc.name   : fileIO_test_open_sync_007
     * @tc.desc   : Test openSync() interfaces. mode=0o200000.
     * The path points to a directory.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_sync_007", 2, async () => {
      let dpath = await nextFileName("fileIO_test_open_sync_007");
      fileIO.mkdirSync(dpath);

      try {
        let file = fileIO.openSync(dpath, fileIO.OpenMode.DIR);
        expect(isIntNum(file.fd)).assertTrue();
        fileIO.rmdirSync(dpath);
      } catch (e) {
        console.log("fileIO_test_open_sync_007 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_0800
     * @tc.name   : fileIO_test_open_sync_008
     * @tc.desc   : Test openSync() interfaces. mode=0o200000.
     * The path does not a directory, throw error.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_sync_008", 3, async () => {
      let fpath = await nextFileName("fileIO_test_open_sync_008");
      expect(prepareFile(fpath, "")).assertTrue();

      try {
        fileIO.openSync(fpath, fileIO.OpenMode.DIR);
        expect(false).assertTrue();
      } catch (e) {
        fileIO.unlinkSync(fpath);
        console.log("fileIO_test_open_sync_008 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900018 && e.message == "Not a directory").assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_0900
     * @tc.name   : fileIO_test_open_sync_009
     * @tc.desc   : Test openSync() interfaces. mode=0o400002.
     * The path does not point to a symbolic link.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_sync_009", 2, async () => {
      let fpath = await nextFileName("fileIO_test_open_sync_009");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let file = fileIO.openSync(fpath, fileIO.OpenMode.NOFOLLOW | fileIO.OpenMode.READ_WRITE);
        expect(isIntNum(file.fd)).assertTrue();
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
      } catch (e) {
        console.log("fileIO_test_open_sync_009 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_1000
     * @tc.name   : fileIO_test_open_sync_010
     * @tc.desc   : Test openSync() interfaces. mode=0o4010002.
     * Open the file in the way of synchronous IO.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_sync_010", 2, async () => {
      let fpath = await nextFileName("fileIO_test_open_sync_010");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let file = fileIO.openSync(fpath, fileIO.OpenMode.SYNC | fileIO.OpenMode.READ_WRITE);
        expect(isIntNum(file.fd)).assertTrue();
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
      } catch (e) {
        console.log("fileIO_test_open_sync_010 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_1100
     * @tc.name   : fileIO_test_open_sync_011
     * @tc.desc   : Test openSync() interfaces.
     * The path refers to a file, not a directory.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_sync_011", 3, async () => {
      let dpath = await nextFileName("fileIO_test_open_sync_011");
      fileIO.mkdirSync(dpath);

      try {
        fileIO.openSync(dpath, fileIO.OpenMode.READ_WRITE);
        expect(false).assertTrue();
      } catch (e) {
        fileIO.rmdirSync(dpath);
        console.log("fileIO_test_open_sync_011 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900019 && e.message == "Is a directory").assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_1200
     * @tc.name   : fileIO_test_open_sync_012
     * @tc.desc   : Test openSync() interfaces.
     * Undefined option arguments, use default mode = 0o0.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_sync_012", 3, async () => {
      let fpath = await nextFileName("fileIO_test_open_sync_012");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
      let file = fileIO.openSync(fpath, undefined);

      try {
        expect(isIntNum(file.fd)).assertTrue();
        let readlen = fileIO.readSync(file.fd, new ArrayBuffer(4096));
        expect(readlen == FILE_CONTENT.length).assertTrue();
        fileIO.writeSync(file.fd, new ArrayBuffer(4096));
        expect(false).assertTrue();
      } catch (e) {
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
        console.log("fileIO_test_open_sync_012 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900008 && e.message == "Bad file descriptor").assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_2600
     * @tc.name   : fileIO_test_open_async_026
     * @tc.desc   : Test open() interfaces with file:// URI. Promise.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_async_026", 2, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_026");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
      let uri = fileUri.getUriFromPath(fpath);

      try {
        let file = await fileIO.open(uri, fileIO.OpenMode.READ_ONLY);
        expect(isIntNum(file.fd)).assertTrue();
        expect(file.path === fpath).assertTrue();
        expect(file.name === fpath.split('/').pop()).assertTrue();
        fileIO.read(file.fd, new ArrayBuffer(4096)).then((readLen) => {
          expect(readLen == FILE_CONTENT.length).assertTrue();
          fileIO.closeSync(file);
          fileIO.unlinkSync(fpath);
          done();
        }).catch((err: BusinessError) => {
          fileIO.closeSync(file);
          fileIO.unlinkSync(fpath);
          console.log("fileIO_test_open_async_026 read has failed for " + err.message + ", code: " + err.code);
          expect(false).assertTrue();
          done();
        });
      } catch (e) {
        console.log("fileIO_test_open_async_026 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_2700
     * @tc.name   : fileIO_test_open_async_027
     * @tc.desc   : Test open() interfaces with file:// URI. Callback.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_async_027", 2, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_027");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
      let uri = fileUri.getUriFromPath(fpath);

      try {
        fileIO.open(uri, fileIO.OpenMode.READ_ONLY, (err, file) => {
          if (err) {
            console.log("fileIO_test_open_async_027 error package: " + JSON.stringify(err));
            expect(false).assertTrue();
            fileIO.unlinkSync(fpath);
            done();
            return;
          }
          expect(isIntNum(file.fd)).assertTrue();
          expect(file.path === fpath).assertTrue();
          expect(file.name === fpath.split('/').pop()).assertTrue();
          fileIO.read(file.fd, new ArrayBuffer(4096)).then((readLen) => {
            expect(readLen == FILE_CONTENT.length).assertTrue();
            fileIO.closeSync(file);
            fileIO.unlinkSync(fpath);
            done();
          }).catch((readErr: BusinessError) => {
            fileIO.closeSync(file);
            fileIO.unlinkSync(fpath);
            console.log("fileIO_test_open_async_027 read has failed for " + readErr.message + ", code: " + readErr.code);
            expect(false).assertTrue();
            done();
          });
        });
      } catch (e) {
        console.log("fileIO_test_open_async_027 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
        fileIO.unlinkSync(fpath);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_1300
     * @tc.name   : fileIO_test_open_sync_013
     * @tc.desc   : Test openSync() interfaces with file:// URI.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_sync_013", 2, async () => {
      let fpath = await nextFileName("fileIO_test_open_sync_013");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
      let uri = fileUri.getUriFromPath(fpath);

      try {
        let file = fileIO.openSync(uri, fileIO.OpenMode.READ_ONLY);
        expect(isIntNum(file.fd)).assertTrue();
        expect(file.path === fpath).assertTrue();
        expect(file.name === fpath.split('/').pop()).assertTrue();
        let readlen = fileIO.readSync(file.fd, new ArrayBuffer(4096));
        expect(readlen == FILE_CONTENT.length).assertTrue();
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
      } catch (e) {
        console.log("fileIO_test_open_sync_013 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ERROR_001
     * @tc.name   : fileIO_open_error_001
     * @tc.desc   : Test open() interface with empty string path. Promise.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_open_error_001", 3, async () => {
      try {
        await fileIO.open("");
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_open_error_001 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900002).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ERROR_006
     * @tc.name   : fileIO_open_error_006
     * @tc.desc   : Test open() interface with empty string path. Callback.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_open_error_006", 3, async (done: Function) => {
      try {
        fileIO.open("", (err) => {
          if (err) {
            console.log("fileIO_open_error_006: " + err.message + ", code: " + err.code);
            expect(err.code == 13900002).assertTrue();
            done();
          } else {
            expect(false).assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log("fileIO_open_error_006: " + e.message + ", code: " + e.code);
        expect(e.code == 13900002).assertTrue();
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ERROR_011
     * @tc.name   : fileIO_open_error_011
     * @tc.desc   : Test open() interface with empty string path. Callback with mode.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_open_error_011", 3, async (done: Function) => {
      try {
        fileIO.open("", 0, (err) => {
          if (err) {
            console.log("fileIO_open_error_011: " + err.message + ", code: " + err.code);
            expect(err.code == 13900002).assertTrue();
            done();
          } else {
            expect(false).assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log("fileIO_open_error_011: " + e.message + ", code: " + e.code);
        expect(e.code == 13900002).assertTrue();
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_001
     * @tc.name   : fileIO_openSync_error_001
     * @tc.desc   : Test openSync() interface with empty string path.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_openSync_error_001", 3, async () => {
      try {
        fileIO.openSync("");
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_openSync_error_001: " + e.message + ", code: " + e.code);
        expect(e.code == 13900002).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_3200
     * @tc.name   : fileIO_test_open_async_032
     * @tc.desc   : Test open() interfaces. Promise with then/catch pattern.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_032", 3, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_032");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      fileIO.open(fpath, fileIO.OpenMode.READ_ONLY).then((file) => {
        expect(isIntNum(file.fd)).assertTrue();
        return fileIO.read(file.fd, new ArrayBuffer(4096)).then((readLen) => {
          expect(readLen == FILE_CONTENT.length).assertTrue();
          fileIO.closeSync(file);
          fileIO.unlinkSync(fpath);
          done();
        }).catch((readErr: BusinessError) => {
          fileIO.closeSync(file);
          fileIO.unlinkSync(fpath);
          console.log("fileIO_test_open_async_032 read has failed for " + readErr.message + ", code: " + readErr.code);
          expect(false).assertTrue();
          done();
        });
      }).catch((err: BusinessError) => {
        fileIO.unlinkSync(fpath);
        console.log("fileIO_test_open_async_032 has failed for " + err.message + ", code: " + err.code);
        expect(false).assertTrue();
        done();
      });
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ERROR_017
     * @tc.name   : fileIO_open_error_017
     * @tc.desc   : Test open() interface with file name too long. Promise.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_open_error_017", 3, async (done: Function) => {
      let fpath = await nextFileName("fileIO_open_error_017");
      let fpath1 = fpath + randomString(250);

      try {
        await fileIO.open(fpath1, fileIO.OpenMode.CREATE | fileIO.OpenMode.READ_WRITE);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_open_error_017 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900030).assertTrue();
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ERROR_018
     * @tc.name   : fileIO_open_error_018
     * @tc.desc   : Test open() interface with file name too long. Callback.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_open_error_018", 3, async (done: Function) => {
      let fpath = await nextFileName("fileIO_open_error_018");
      let fpath1 = fpath + randomString(250);

      try {
        fileIO.open(fpath1, fileIO.OpenMode.CREATE | fileIO.OpenMode.WRITE_ONLY, (err) => {
          if (err) {
            console.log("fileIO_open_error_018: " + err.message + ", code: " + err.code);
            expect(err.code == 13900030).assertTrue();
            done();
          } else {
            expect(false).assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log("fileIO_open_error_018: " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_005
     * @tc.name   : fileIO_openSync_error_005
     * @tc.desc   : Test openSync() interface with file name too long.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_openSync_error_005", 3, async () => {
      let fpath = await nextFileName("fileIO_openSync_error_005");
      let fpath1 = fpath + randomString(250);

      try {
        fileIO.openSync(fpath1, fileIO.OpenMode.CREATE | fileIO.OpenMode.READ_WRITE);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_openSync_error_005 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900030).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_3400
     * @tc.name   : fileIO_test_open_async_034
     * @tc.desc   : Test open() interfaces. mode=0o200000. Promise.then().catch().
     * The path does not point to a directory, throw error.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_034", 3, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_034");
      expect(prepareFile(fpath, "")).assertTrue();

      try {
        fileIO.open(fpath, fileIO.OpenMode.DIR).then(() => {
          expect(false).assertTrue();
        }).catch((err: BusinessError) => {
          fileIO.unlinkSync(fpath);
          console.log("fileIO_test_open_async_034 error: {message: " + err.message + ", code: " + err.code + "}");
          expect(err.code == 13900018).assertTrue();
          done();
        });
      } catch (e) {
        console.log("fileIO_test_open_async_034 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_3500
     * @tc.name   : fileIO_test_open_async_035
     * @tc.desc   : Test open() interfaces with file:// URI. mode=0o200000. Promise.
     * The path does not point to a directory, throw error.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_035", 3, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_035");
      expect(prepareFile(fpath, "")).assertTrue();
      let uri = fileUri.getUriFromPath(fpath);

      try {
        await fileIO.open(uri, fileIO.OpenMode.DIR);
        expect(false).assertTrue();
      } catch (e) {
        fileIO.unlinkSync(fpath);
        console.log("fileIO_test_open_async_035 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900018).assertTrue();
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_3600
     * @tc.name   : fileIO_test_open_async_036
     * @tc.desc   : Test open() interfaces with file:// URI. Promise.
     * The path refers to a directory, throw error.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_036", 3, async (done: Function) => {
      let dpath = await nextFileName("fileIO_test_open_async_036");
      fileIO.mkdirSync(dpath);
      let uri = fileUri.getUriFromPath(dpath);

      try {
        await fileIO.open(uri, fileIO.OpenMode.READ_WRITE);
        expect(false).assertTrue();
      } catch (e) {
        fileIO.rmdirSync(dpath);
        console.log("fileIO_test_open_async_036 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900019).assertTrue();
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_3700
     * @tc.name   : fileIO_test_open_async_037
     * @tc.desc   : Test open() interfaces with unsupported URI scheme. Promise.
     * Open with database:// URI, throw error.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_037", 3, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_037");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
      let uri = "database://" + fpath;

      try {
        await fileIO.open(uri, fileIO.OpenMode.READ_ONLY);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_open_async_037 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900020).assertTrue();
        fileIO.unlinkSync(fpath);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_3800
     * @tc.name   : fileIO_test_open_async_038
     * @tc.desc   : Test open() interfaces. mode=0o101. CREATE | WRITE_ONLY. Promise.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_async_038", 2, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_038");

      try {
        let file = await fileIO.open(fpath, fileIO.OpenMode.CREATE | fileIO.OpenMode.WRITE_ONLY);
        expect(isIntNum(file.fd)).assertTrue();
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
        done();
      } catch (e) {
        console.log("fileIO_test_open_async_038 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_3900
     * @tc.name   : fileIO_test_open_async_039
     * @tc.desc   : Test open() interfaces. mode=0o1001. TRUNC | WRITE_ONLY. Promise.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_async_039", 2, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_039");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let file = await fileIO.open(fpath, fileIO.OpenMode.TRUNC | fileIO.OpenMode.WRITE_ONLY);
        expect(isIntNum(file.fd)).assertTrue();
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
        done();
      } catch (e) {
        console.log("fileIO_test_open_async_039 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_4000
     * @tc.name   : fileIO_test_open_async_040
     * @tc.desc   : Test open() interfaces. mode=0o2001. APPEND | WRITE_ONLY. Promise.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_open_async_040", 2, async (done: Function) => {
      let fpath = await nextFileName("fileIO_test_open_async_040");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let file = await fileIO.open(fpath, fileIO.OpenMode.APPEND | fileIO.OpenMode.WRITE_ONLY);
        expect(isIntNum(file.fd)).assertTrue();
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
        done();
      } catch (e) {
        console.log("fileIO_test_open_async_040 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_4100
     * @tc.name   : fileIO_test_open_async_041
     * @tc.desc   : Test open() interfaces with relative path. Promise.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_041", 3, async (done: Function) => {
      try {
        await fileIO.open("../relative_test_file", fileIO.OpenMode.READ_ONLY);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_open_async_041 has failed for " + e.message + ", code: " + e.code);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_4200
     * @tc.name   : fileIO_test_open_async_042
     * @tc.desc   : Test open() interfaces with path starting with "://". Promise.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_042", 3, async (done: Function) => {
      try {
        await fileIO.open("://invalidpath", fileIO.OpenMode.READ_ONLY);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_open_async_042 has failed for " + e.message + ", code: " + e.code);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_4300
     * @tc.name   : fileIO_test_open_async_043
     * @tc.desc   : Test open() interfaces with path ending with "://". Promise.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_043", 3, async (done: Function) => {
      try {
        await fileIO.open("invalidpath://", fileIO.OpenMode.READ_ONLY);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_open_async_043 has failed for " + e.message + ", code: " + e.code);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_4400
     * @tc.name   : fileIO_test_open_async_044
     * @tc.desc   : Test open() interfaces with Windows-style path. Promise.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_044", 3, async (done: Function) => {
      try {
        await fileIO.open("C:\\Users\\test.txt", fileIO.OpenMode.READ_ONLY);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_open_async_044 has failed for " + e.message + ", code: " + e.code);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_4500
     * @tc.name   : fileIO_test_open_async_045
     * @tc.desc   : Test open() interfaces with uppercase FILE:// URI. Promise.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_045", 3, async (done: Function) => {
      try {
        await fileIO.open("FILE:///data/local/tmp/test.txt", fileIO.OpenMode.READ_ONLY);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_open_async_045 has failed for " + e.message + ", code: " + e.code);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_4600
     * @tc.name   : fileIO_test_open_async_046
     * @tc.desc   : Test open() interfaces with mixed-case File:// URI. Promise.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_046", 3, async (done: Function) => {
      try {
        await fileIO.open("File:///data/local/tmp/test.txt", fileIO.OpenMode.READ_ONLY);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_open_async_046 has failed for " + e.message + ", code: " + e.code);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_4700
     * @tc.name   : fileIO_test_open_async_047
     * @tc.desc   : Test open() interfaces with non-existent file URI. Promise.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_047", 3, async (done: Function) => {
      try {
        await fileIO.open("file:///data/local/tmp/non_existent_file_12345", fileIO.OpenMode.READ_ONLY);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_open_async_047 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900002).assertTrue();
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_4800
     * @tc.name   : fileIO_test_open_async_048
     * @tc.desc   : Test open() interfaces with space string path. Promise.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_048", 3, async (done: Function) => {
      try {
        await fileIO.open("   ", fileIO.OpenMode.READ_ONLY);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_open_async_048 has failed for " + e.message + ", code: " + e.code);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_4900
     * @tc.name   : fileIO_test_open_async_049
     * @tc.desc   : Test open() interfaces with file:// URI containing spaces. Promise.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_049", 3, async (done: Function) => {
      try {
        await fileIO.open("file://   ", fileIO.OpenMode.READ_ONLY);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_open_async_049 has failed for " + e.message + ", code: " + e.code);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_5000
     * @tc.name   : fileIO_test_open_async_050
     * @tc.desc   : Test open() interfaces with special characters and Chinese path. Promise.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_050", 3, async (done: Function) => {
      try {
        await fileIO.open("特殊字符@#$%^&*()test", fileIO.OpenMode.READ_ONLY);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_open_async_050 has failed for " + e.message + ", code: " + e.code);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_5100
     * @tc.name   : fileIO_test_open_async_051
     * @tc.desc   : Test open() interfaces with relative path. Callback.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_051", 3, async (done: Function) => {
      try {
        fileIO.open("../relative_test_file", fileIO.OpenMode.READ_ONLY, (err) => {
          if (err) {
            console.log("fileIO_test_open_async_051: " + err.message + ", code: " + err.code);
            done();
          } else {
            expect(false).assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log("fileIO_test_open_async_051: " + e.message + ", code: " + e.code);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_5200
     * @tc.name   : fileIO_test_open_async_052
     * @tc.desc   : Test open() interfaces with path starting with "://". Callback.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_052", 3, async (done: Function) => {
      try {
        fileIO.open("://invalidpath", fileIO.OpenMode.READ_ONLY, (err) => {
          if (err) {
            console.log("fileIO_test_open_async_052: " + err.message + ", code: " + err.code);
            done();
          } else {
            expect(false).assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log("fileIO_test_open_async_052: " + e.message + ", code: " + e.code);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_5300
     * @tc.name   : fileIO_test_open_async_053
     * @tc.desc   : Test open() interfaces with path ending with "://". Callback.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_053", 3, async (done: Function) => {
      try {
        fileIO.open("invalidpath://", fileIO.OpenMode.READ_ONLY, (err) => {
          if (err) {
            console.log("fileIO_test_open_async_053: " + err.message + ", code: " + err.code);
            done();
          } else {
            expect(false).assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log("fileIO_test_open_async_053: " + e.message + ", code: " + e.code);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_5400
     * @tc.name   : fileIO_test_open_async_054
     * @tc.desc   : Test open() interfaces with Windows-style path. Callback.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_054", 3, async (done: Function) => {
      try {
        fileIO.open("C:\\Users\\test.txt", fileIO.OpenMode.READ_ONLY, (err) => {
          if (err) {
            console.log("fileIO_test_open_async_054: " + err.message + ", code: " + err.code);
            done();
          } else {
            expect(false).assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log("fileIO_test_open_async_054: " + e.message + ", code: " + e.code);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_5500
     * @tc.name   : fileIO_test_open_async_055
     * @tc.desc   : Test open() interfaces with uppercase FILE:// URI. Callback.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_055", 3, async (done: Function) => {
      try {
        fileIO.open("FILE:///data/local/tmp/test.txt", fileIO.OpenMode.READ_ONLY, (err) => {
          if (err) {
            console.log("fileIO_test_open_async_055: " + err.message + ", code: " + err.code);
            done();
          } else {
            expect(false).assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log("fileIO_test_open_async_055: " + e.message + ", code: " + e.code);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_5600
     * @tc.name   : fileIO_test_open_async_056
     * @tc.desc   : Test open() interfaces with mixed-case File:// URI. Callback.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_056", 3, async (done: Function) => {
      try {
        fileIO.open("File:///data/local/tmp/test.txt", fileIO.OpenMode.READ_ONLY, (err) => {
          if (err) {
            console.log("fileIO_test_open_async_056: " + err.message + ", code: " + err.code);
            done();
          } else {
            expect(false).assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log("fileIO_test_open_async_056: " + e.message + ", code: " + e.code);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_5700
     * @tc.name   : fileIO_test_open_async_057
     * @tc.desc   : Test open() interfaces with non-existent file URI. Callback.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_057", 3, async (done: Function) => {
      try {
        fileIO.open("file:///data/local/tmp/non_existent_file_12345", fileIO.OpenMode.READ_ONLY, (err) => {
          if (err) {
            console.log("fileIO_test_open_async_057: " + err.message + ", code: " + err.code);
            expect(err.code == 13900002).assertTrue();
            done();
          } else {
            expect(false).assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log("fileIO_test_open_async_057: " + e.message + ", code: " + e.code);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_5800
     * @tc.name   : fileIO_test_open_async_058
     * @tc.desc   : Test open() interfaces with space string path. Callback.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_058", 3, async (done: Function) => {
      try {
        fileIO.open("   ", fileIO.OpenMode.READ_ONLY, (err) => {
          if (err) {
            console.log("fileIO_test_open_async_058: " + err.message + ", code: " + err.code);
            done();
          } else {
            expect(false).assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log("fileIO_test_open_async_058: " + e.message + ", code: " + e.code);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_5900
     * @tc.name   : fileIO_test_open_async_059
     * @tc.desc   : Test open() interfaces with file:// URI containing spaces. Callback.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_059", 3, async (done: Function) => {
      try {
        fileIO.open("file://   ", fileIO.OpenMode.READ_ONLY, (err) => {
          if (err) {
            console.log("fileIO_test_open_async_059: " + err.message + ", code: " + err.code);
            done();
          } else {
            expect(false).assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log("fileIO_test_open_async_059: " + e.message + ", code: " + e.code);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_ASYNC_6000
     * @tc.name   : fileIO_test_open_async_060
     * @tc.desc   : Test open() interfaces with special characters and Chinese path. Callback.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_test_open_async_060", 3, async (done: Function) => {
      try {
        fileIO.open("特殊字符@#$%^&*()test", fileIO.OpenMode.READ_ONLY, (err) => {
          if (err) {
            console.log("fileIO_test_open_async_060: " + err.message + ", code: " + err.code);
            done();
          } else {
            expect(false).assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log("fileIO_test_open_async_060: " + e.message + ", code: " + e.code);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_016
     * @tc.name   : fileIO_openSync_error_016
     * @tc.desc   : Test openSync() interface with relative path.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_openSync_error_016", 3, () => {
      try {
        fileIO.openSync("../relative_test_file", fileIO.OpenMode.READ_ONLY);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_openSync_error_016 has failed for " + e.message + ", code: " + e.code);
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_017
     * @tc.name   : fileIO_openSync_error_017
     * @tc.desc   : Test openSync() interface with path starting with "://".
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_openSync_error_017", 3, () => {
      try {
        fileIO.openSync("://invalidpath", fileIO.OpenMode.READ_ONLY);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_openSync_error_017 has failed for " + e.message + ", code: " + e.code);
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_018
     * @tc.name   : fileIO_openSync_error_018
     * @tc.desc   : Test openSync() interface with path ending with "://".
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_openSync_error_018", 3, () => {
      try {
        fileIO.openSync("invalidpath://", fileIO.OpenMode.READ_ONLY);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_openSync_error_018 has failed for " + e.message + ", code: " + e.code);
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_019
     * @tc.name   : fileIO_openSync_error_019
     * @tc.desc   : Test openSync() interface with Windows-style path.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_openSync_error_019", 3, () => {
      try {
        fileIO.openSync("C:\\Users\\test.txt", fileIO.OpenMode.READ_ONLY);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_openSync_error_019 has failed for " + e.message + ", code: " + e.code);
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_020
     * @tc.name   : fileIO_openSync_error_020
     * @tc.desc   : Test openSync() interface with uppercase FILE:// URI.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_openSync_error_020", 3, () => {
      try {
        fileIO.openSync("FILE:///data/local/tmp/test.txt", fileIO.OpenMode.READ_ONLY);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_openSync_error_020 has failed for " + e.message + ", code: " + e.code);
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_021
     * @tc.name   : fileIO_openSync_error_021
     * @tc.desc   : Test openSync() interface with mixed-case File:// URI.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_openSync_error_021", 3, () => {
      try {
        fileIO.openSync("File:///data/local/tmp/test.txt", fileIO.OpenMode.READ_ONLY);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_openSync_error_021 has failed for " + e.message + ", code: " + e.code);
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_022
     * @tc.name   : fileIO_openSync_error_022
     * @tc.desc   : Test openSync() interface with non-existent file URI.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_openSync_error_022", 3, () => {
      try {
        fileIO.openSync("file:///data/local/tmp/non_existent_file_12345", fileIO.OpenMode.READ_ONLY);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_openSync_error_022 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900002).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_023
     * @tc.name   : fileIO_openSync_error_023
     * @tc.desc   : Test openSync() interface with space string path.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_openSync_error_023", 3, () => {
      try {
        fileIO.openSync("   ", fileIO.OpenMode.READ_ONLY);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_openSync_error_023 has failed for " + e.message + ", code: " + e.code);
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_024
     * @tc.name   : fileIO_openSync_error_024
     * @tc.desc   : Test openSync() interface with file:// URI containing spaces.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_openSync_error_024", 3, () => {
      try {
        fileIO.openSync("file://   ", fileIO.OpenMode.READ_ONLY);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_openSync_error_024 has failed for " + e.message + ", code: " + e.code);
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_025
     * @tc.name   : fileIO_openSync_error_025
     * @tc.desc   : Test openSync() interface with special characters and Chinese path.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 3
     */
    it("fileIO_openSync_error_025", 3, () => {
      try {
        fileIO.openSync("特殊字符@#$%^&*()test", fileIO.OpenMode.READ_ONLY);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_openSync_error_025 has failed for " + e.message + ", code: " + e.code);
      }
    });
  });
}
