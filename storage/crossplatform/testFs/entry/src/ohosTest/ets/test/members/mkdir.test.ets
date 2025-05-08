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
import { Level } from '@ohos/hypium';
import deviceInfo from '@ohos.deviceInfo';

async function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms));
}

export default function fileIOMkdir() {
  describe("fileIO_fs_mkdir", () => {

    afterEach(async () => {
      await sleep(500);
    });
    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_0000
     * @tc.name   : fileIO_test_mkdir_async_000
     * @tc.desc   : Test mkdir() interfaces. Promise.
     * Create a directory, verify normal function.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("fileIO_test_mkdir_async_000", Level.LEVEL1, async (done: Function) => {
      let dpath = (await nextFileName("fileIO_test_mkdir_async_000")) + "d";

      try {
        await fileIO.mkdir(dpath);
        expect(fileIO.accessSync(dpath)).assertTrue();
        fileIO.rmdirSync(dpath);
        done();
      } catch (e) {
        console.log("fileIO_test_mkdir_async_000 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_0100
     * @tc.name   : fileIO_test_mkdir_async_001
     * @tc.desc   : Test mkdir() interfaces. Promise.
     * The path has pointed to a file.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_mkdir_async_001", Level.LEVEL2, async () => {
      let fpath = await nextFileName("fileIO_test_mkdir_async_001");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        await fileIO.mkdir(fpath);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_mkdir_async_001 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900015 && e.message == "File exists").assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_0200
     * @tc.name   : fileIO_test_mkdir_async_002
     * @tc.desc   : Test mkdir() interfaces. Callback.
     * Create a directory, verify normal function.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("fileIO_test_mkdir_async_002", Level.LEVEL2, async (done: Function) => {
      let dpath = (await nextFileName("fileIO_test_mkdir_async_002")) + "d";

      try {
        fileIO.mkdir(dpath, (err) => {
          if (err) {
            console.log("fileIO_test_mkdir_async_002 error package: " + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(fileIO.accessSync(dpath)).assertTrue();
          fileIO.rmdirSync(dpath);
          done();
        });
      } catch (e) {
        console.log("fileIO_test_mkdir_async_002 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_0300
     * @tc.name   : fileIO_test_mkdir_async_003
     * @tc.desc   : Test mkdir() interfaces. Callback.
     * The directory has been existed.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_mkdir_async_003", Level.LEVEL2, async (done: Function) => {
      let osName: string = deviceInfo.osFullName;
      try {
        fileIO.mkdir("/", (err) => {
          if (err) {
            console.log("fileIO_test_mkdir_async_003 error: {message: " + err.message + ", code: " + err.code + "}");
            if (osName.startsWith('Android')) {
              expect(err.code == 13900015 && err.message == "File exists").assertTrue();
            } else if (osName.startsWith('iOS')) {
              expect(err.code == 13900019 && err.message == "Is a directory").assertTrue();
            }
            done();
          }
        });
      } catch (e) {
        console.log("fileIO_test_mkdir_async_003 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });
  
    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_0400
     * @tc.name   : fileIO_test_mkdir_async_004
     * @tc.desc   : Test mkdir() interfaces. Promise.
     * The path is empty.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_mkdir_async_004", Level.LEVEL2, async (done: Function) => {
      try {
        await fileIO.mkdir("");
        expect(false).assertTrue();
        done();
      } catch (e) {
        console.log("fileIO_test_mkdir_async_004 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900020 && e.message == "Invalid argument").assertTrue();
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_0500
     * @tc.name   : fileIO_test_mkdir_async_005
     * @tc.desc   : Test mkdir() interfaces. Promise.
     * The path exists *.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("fileIO_test_mkdir_async_005", Level.LEVEL2, async (done: Function) => {
      let dpath = (await nextFileName("fileIO_test_mkdir_async_005")) + "*";
      try {
        await fileIO.mkdir(dpath);
        expect(fileIO.accessSync(dpath)).assertTrue();
        fileIO.rmdirSync(dpath);
        done();
      } catch (e) {
        console.log("fileIO_test_mkdir_async_005 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_0600
     * @tc.name   : fileIO_test_mkdir_async_006
     * @tc.desc   : Test mkdir() interfaces. Promise.
     * The path exists ?.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("fileIO_test_mkdir_async_006", Level.LEVEL2, async (done: Function) => {
      let dpath = (await nextFileName("fileIO_test_mkdir_async_006")) + "?";
      try {
        await fileIO.mkdir(dpath);
        expect(fileIO.accessSync(dpath)).assertTrue();
        fileIO.rmdirSync(dpath);
        done();
      } catch (e) {
        console.log("fileIO_test_mkdir_async_006 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_0700
     * @tc.name   : fileIO_test_mkdir_async_007
     * @tc.desc   : Test mkdir() interfaces. Promise.
     * The path exists :.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("fileIO_test_mkdir_async_007", Level.LEVEL2, async (done: Function) => {
      let dpath = (await nextFileName("fileIO_test_mkdir_async_007")) + ":";
      try {
        await fileIO.mkdir(dpath);
        expect(fileIO.accessSync(dpath)).assertTrue();
        fileIO.rmdirSync(dpath);
        done();
      } catch (e) {
        console.log("fileIO_test_mkdir_async_007 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_0900
     * @tc.name   : fileIO_test_mkdir_async_009
     * @tc.desc   : Test mkdir() interfaces. Callback.
     * The path is empty.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_mkdir_async_009", Level.LEVEL2, async (done: Function) => {
      try {
        fileIO.mkdir("", (err) => {
          expect(err != null).assertTrue();
          console.log("fileIO_test_mkdir_async_009 error package: " + err.code);
          expect(err.code == 13900020).assertTrue();
          done();
        });
      } catch (e) {
        console.log("fileIO_test_mkdir_async_009 has failed for " + e.message + ", code: " + e.code);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_1000
     * @tc.name   : fileIO_test_mkdir_async_010
     * @tc.desc   : Test mkdir() interfaces. Callback.
     * The path exists *.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("fileIO_test_mkdir_async_010", Level.LEVEL2, async (done: Function) => {
      let dpath = (await nextFileName("fileIO_test_mkdir_async_010")) + "*";
      try {
        fileIO.mkdir(dpath, (err) => {
          if (err) {
            console.log("fileIO_test_mkdir_async_010 error package: " + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(fileIO.accessSync(dpath)).assertTrue();
          fileIO.rmdirSync(dpath);
          done();
        });
      } catch (e) {
        console.log("fileIO_test_mkdir_async_010 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_1100
     * @tc.name   : fileIO_test_mkdir_async_011
     * @tc.desc   : Test mkdir() interfaces. Callback.
     * The path exists ?.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("fileIO_test_mkdir_async_011", Level.LEVEL1, async (done: Function) => {
      let dpath = (await nextFileName("fileIO_test_mkdir_async_011")) + "?";
      try {
        fileIO.mkdir(dpath, (err) => {
          if (err) {
            console.log("fileIO_test_mkdir_async_011 error package: " + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(fileIO.accessSync(dpath)).assertTrue();
          fileIO.rmdirSync(dpath);
          done();
        });
      } catch (e) {
        console.log("fileIO_test_mkdir_async_011 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_1200
     * @tc.name   : fileIO_test_mkdir_async_012
     * @tc.desc   : Test mkdir() interfaces. Callback.
     * The path exists :.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("fileIO_test_mkdir_async_012", Level.LEVEL1, async (done: Function) => {
      let dpath = (await nextFileName("fileIO_test_mkdir_async_012")) + ":";
      try {
        fileIO.mkdir(dpath, (err) => {
          if (err) {
            console.log("fileIO_test_mkdir_async_012 error package: " + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(fileIO.accessSync(dpath)).assertTrue();
          fileIO.rmdirSync(dpath);
          done();
        });
      } catch (e) {
        console.log("fileIO_test_mkdir_async_012 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_1300
     * @tc.name   : fileIO_test_mkdir_async_013
     * @tc.desc   : Test mkdir() interfaces. Promise.
     * Create a directory, verify normal function.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("fileIO_test_mkdir_async_013", Level.LEVEL1, async (done: Function) => {
      let dpath = (await nextFileName("fileIO_test_mkdir_async_013")) + "d";

      try {
        await fileIO.mkdir(dpath, true);
        expect(fileIO.accessSync(dpath)).assertTrue();
        fileIO.rmdirSync(dpath);
        done();
      } catch (e) {
        console.log("fileIO_test_mkdir_async_000 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_1400
     * @tc.name   : fileIO_test_mkdir_async_014fileIO_test_mkdir_async_014
     * @tc.desc   : Test mkdir() interfaces. Promise.
     * The path has pointed to a file.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_mkdir_async_014", Level.LEVEL2, async () => {
      let fpath = await nextFileName("fileIO_test_mkdir_async_014");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
      try {
        await fileIO.mkdir(fpath, true);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_mkdir_async_001 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900015 && e.message == "File exists").assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_1500
     * @tc.name   : fileIO_test_mkdir_async_015
     * @tc.desc   : Test mkdir() interfaces. Callback.
     * Create a directory, verify normal function.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("fileIO_test_mkdir_async_015", Level.LEVEL1, async (done: Function) => {
      let dpath = (await nextFileName("fileIO_test_mkdir_async_015")) + "d";

      try {
        fileIO.mkdir(dpath, true, (err) => {
          if (err) {
            console.log("fileIO_test_mkdir_async_002 error package: " + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(fileIO.accessSync(dpath)).assertTrue();
          fileIO.rmdirSync(dpath);
          done();
        });
      } catch (e) {
        console.log("fileIO_test_mkdir_async_002 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_1600
     * @tc.name   : fileIO_test_mkdir_async_016
     * @tc.desc   : Test mkdir() interfaces. Callback.
     * The directory has been existed.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_mkdir_async_016", Level.LEVEL2, async (done: Function) => {
      try {
        fileIO.mkdir("/", false, (err) => {
          if (err) {
            console.log("fileIO_test_mkdir_async_016 error: {message: " + err.message + ", code: " + err.code + "}");
            expect(err.code == 13900015 && err.message == "File exists").assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log("fileIO_test_mkdir_async_016 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_1700
     * @tc.name   : fileIO_test_mkdir_async_017
     * @tc.desc   : Test mkdir() interfaces. Promise.
     * The path is empty.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_mkdir_async_017", Level.LEVEL2, async (done: Function) => {
      try {
        await fileIO.mkdir("", false);
        expect(false).assertTrue();
        done();
      } catch (e) {
        console.log("fileIO_test_mkdir_async_017 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900002 && e.message == "No such file or directory").assertTrue();
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_1800
     * @tc.name   : fileIO_test_mkdir_async_018
     * @tc.desc   : Test mkdir() interfaces. Promise.
     * The path exists *.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("fileIO_test_mkdir_async_018", Level.LEVEL1, async (done: Function) => {
      let dpath = (await nextFileName("fileIO_test_mkdir_async_018")) + "*";
      try {
        await fileIO.mkdir(dpath, true);
        expect(fileIO.accessSync(dpath)).assertTrue();
        fileIO.rmdirSync(dpath);
        done();
      } catch (e) {
        console.log("fileIO_test_mkdir_async_018 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_1900
     * @tc.name   : fileIO_test_mkdir_async_019
     * @tc.desc   : Test mkdir() interfaces. Promise.
     * The path exists ?.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("fileIO_test_mkdir_async_019", Level.LEVEL1, async (done: Function) => {
      let dpath = (await nextFileName("fileIO_test_mkdir_async_019")) + "?";
      try {
        await fileIO.mkdir(dpath, true);
        expect(fileIO.accessSync(dpath)).assertTrue();
        fileIO.rmdirSync(dpath);
        done();
      } catch (e) {
        console.log("fileIO_test_mkdir_async_019 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_2000
     * @tc.name   : fileIO_test_mkdir_async_020
     * @tc.desc   : Test mkdir() interfaces. Promise.
     * The path exists :.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("fileIO_test_mkdir_async_020", Level.LEVEL1, async (done: Function) => {
      let dpath = (await nextFileName("fileIO_test_mkdir_async_020")) + ":";
      try {
        await fileIO.mkdir(dpath, true);
        expect(fileIO.accessSync(dpath)).assertTrue();
        fileIO.rmdirSync(dpath);
        done();
      } catch (e) {
        console.log("fileIO_test_mkdir_async_020 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_2100
     * @tc.name   : fileIO_test_mkdir_async_021
     * @tc.desc   : Test mkdir() interfaces. Callback.
     * The path is empty.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_mkdir_async_021", Level.LEVEL2, async (done: Function) => {
      try {
        fileIO.mkdir("", false, (err) => {
          expect(err != null).assertTrue();
          console.log("fileIO_test_mkdir_async_021 error package: " + err.code);
          expect(err.code == 13900002).assertTrue();
          done();
        });
      } catch (e) {
        console.log("fileIO_test_mkdir_async_021 has failed for " + e.message + ", code: " + e.code);
        done();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_2200
     * @tc.name   : fileIO_test_mkdir_async_022
     * @tc.desc   : Test mkdir() interfaces. Callback.
     * The path exists *.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("fileIO_test_mkdir_async_022", Level.LEVEL1, async (done: Function) => {
      let dpath = (await nextFileName("fileIO_test_mkdir_async_022")) + "*";
      try {
        fileIO.mkdir(dpath, true, (err) => {
          if (err) {
            console.log("fileIO_test_mkdir_async_022 error package: " + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(fileIO.accessSync(dpath)).assertTrue();
          fileIO.rmdirSync(dpath);
          done();
        });
      } catch (e) {
        console.log("fileIO_test_mkdir_async_022 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_2300
     * @tc.name   : fileIO_test_mkdir_async_023
     * @tc.desc   : Test mkdir() interfaces. Callback.
     * The path exists ?.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("fileIO_test_mkdir_async_023", Level.LEVEL1, async (done: Function) => {
      let dpath = (await nextFileName("fileIO_test_mkdir_async_023")) + "?";
      try {
        fileIO.mkdir(dpath, true, (err) => {
          if (err) {
            console.log("fileIO_test_mkdir_async_023 error package: " + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(fileIO.accessSync(dpath)).assertTrue();
          fileIO.rmdirSync(dpath);
          done();
        });
      } catch (e) {
        console.log("fileIO_test_mkdir_async_023 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_ASYNC_2400
     * @tc.name   : fileIO_test_mkdir_async_024
     * @tc.desc   : Test mkdir() interfaces. Callback.
     * The path exists :.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 0
     */
    it("fileIO_test_mkdir_async_024", Level.LEVEL0, async (done: Function) => {
      let dpath = (await nextFileName("fileIO_test_mkdir_async_024")) + ":";
      try {
        fileIO.mkdir(dpath, true, (err) => {
          if (err) {
            console.log("fileIO_test_mkdir_async_024 error package: " + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(fileIO.accessSync(dpath)).assertTrue();
          fileIO.rmdirSync(dpath);
          done();
        });
      } catch (e) {
        console.log("fileIO_test_mkdir_async_024 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_SYNC_0000
     * @tc.name   : fileIO_test_mkdir_sync_000
     * @tc.desc   : Test mkdirSync() interfaces.
     * Create a directory, verify normal function.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("fileIO_test_mkdir_sync_000", Level.LEVEL1, async () => {
      let dpath = (await nextFileName("fileIO_test_mkdir_sync_000")) + "d";

      try {
        fileIO.mkdirSync(dpath);
        expect(fileIO.accessSync(dpath)).assertTrue();
        fileIO.rmdirSync(dpath);
      } catch (e) {
        console.log("fileIO_test_mkdir_sync_000 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_SYNC_0100
     * @tc.name   : fileIO_test_mkdir_sync_001
     * @tc.desc   : Test mkdirSync() interfaces.
     * The directory has been existed.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_mkdir_sync_001", Level.LEVEL2, async () => {
      let osName: string = deviceInfo.osFullName;
      try {
        fileIO.mkdirSync("/");
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_mkdir_sync_001 has failed for " + e.message + ", code: " + e.code);
        if (osName.startsWith('Android')) {
          expect(e.code == 13900015 && e.message == "File exists").assertTrue();
        } else if (osName.startsWith('iOS')) {
          expect(e.code == 13900019 && e.message == "Is a directory").assertTrue();
        }
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_SYNC_0200
     * @tc.name   : fileIO_test_mkdir_sync_002
     * @tc.desc   : Test mkdirSync() interfaces.
     * The path is empty.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_mkdir_sync_002", Level.LEVEL2, async () => {
      try {
        fileIO.mkdirSync("");
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_mkdir_sync_002 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900020 && e.message == "Invalid argument").assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_SYNC_0300
     * @tc.name   : fileIO_test_mkdir_sync_003
     * @tc.desc   : Test mkdirSync() interfaces.
     * The path has pointed to a file.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_mkdir_sync_003", Level.LEVEL2, async () => {
      let fpath = await nextFileName("fileIO_test_mkdir_sync_003");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        fileIO.mkdirSync(fpath);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_mkdir_sync_003 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900015 && e.message == "File exists").assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_SYNC_0400
     * @tc.name   : fileIO_test_mkdir_sync_004
     * @tc.desc   : Test mkdirSync() interfaces.
     * The path exists *.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("fileIO_test_mkdir_sync_004", Level.LEVEL1, async () => {
      let dpath = (await nextFileName("fileIO_test_mkdir_sync_004")) + "*";
      try {
        await fileIO.mkdirSync(dpath);
        expect(fileIO.accessSync(dpath)).assertTrue();
        fileIO.rmdirSync(dpath);
      } catch (e) {
        console.log("fileIO_test_mkdir_sync_004 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_SYNC_0500
     * @tc.name   : fileIO_test_mkdir_sync_005
     * @tc.desc   : Test mkdirSync() interfaces.
     * The path exists ?.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("fileIO_test_mkdir_sync_005", Level.LEVEL1, async () => {
      let dpath = (await nextFileName("fileIO_test_mkdir_sync_005")) + "?";
      try {
        await fileIO.mkdirSync(dpath);
        expect(fileIO.accessSync(dpath)).assertTrue();
        fileIO.rmdirSync(dpath);
      } catch (e) {
        console.log("fileIO_test_mkdir_sync_005 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_SYNC_0600
     * @tc.name   : fileIO_test_mkdir_sync_006
     * @tc.desc   : Test mkdirSync() interfaces.
     * The path exists :.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("fileIO_test_mkdir_sync_006", Level.LEVEL1, async () => {
      let dpath = (await nextFileName("fileIO_test_mkdir_sync_006")) + ":";
      try {
        await fileIO.mkdirSync(dpath);
        expect(fileIO.accessSync(dpath)).assertTrue();
        fileIO.rmdirSync(dpath);
      } catch (e) {
        console.log("fileIO_test_mkdir_sync_006 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_SYNC_0700
     * @tc.name   : fileIO_test_mkdir_sync_007
     * @tc.desc   : Test mkdirSync() interfaces.
     * Create a directory, verify normal function.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("fileIO_test_mkdir_sync_007", Level.LEVEL1, async () => {
      let dpath = (await nextFileName("fileIO_test_mkdir_sync_007")) + "d";

      try {
        fileIO.mkdirSync(dpath, true);
        expect(fileIO.accessSync(dpath)).assertTrue();
        fileIO.rmdirSync(dpath);
      } catch (e) {
        console.log("fileIO_test_mkdir_sync_007 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_SYNC_0800
     * @tc.name   : fileIO_test_mkdir_sync_008
     * @tc.desc   : Test mkdirSync() interfaces.
     * The directory has been existed.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_mkdir_sync_008", Level.LEVEL2, async () => {
      try {
        fileIO.mkdirSync("/", false);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_mkdir_sync_008 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900015 && e.message == "File exists").assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_SYNC_0900
     * @tc.name   : fileIO_test_mkdir_sync_009
     * @tc.desc   : Test mkdirSync() interfaces.
     * The path is empty.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_mkdir_sync_009", Level.LEVEL2, async () => {
      try {
        fileIO.mkdirSync("", false);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_mkdir_sync_009 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900002 && e.message == "No such file or directory").assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_SYNC_1000
     * @tc.name   : fileIO_test_mkdir_sync_010
     * @tc.desc   : Test mkdirSync() interfaces.
     * The path has pointed to a file.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it("fileIO_test_mkdir_sync_010", Level.LEVEL2, async () => {
      let fpath = await nextFileName("fileIO_test_mkdir_sync_010");
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        fileIO.mkdirSync(fpath, true);
        expect(false).assertTrue();
      } catch (e) {
        console.log("fileIO_test_mkdir_sync_010 has failed for " + e.message + ", code: " + e.code);
        expect(e.code == 13900015 && e.message == "File exists").assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_SYNC_1100
     * @tc.name   : fileIO_test_mkdir_sync_011
     * @tc.desc   : Test mkdirSync() interfaces.
     * The path exists *.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("fileIO_test_mkdir_sync_011", Level.LEVEL1, async () => {
      let dpath = (await nextFileName("fileIO_test_mkdir_sync_011")) + "*";
      try {
        await fileIO.mkdirSync(dpath, true);
        expect(fileIO.accessSync(dpath)).assertTrue();
        fileIO.rmdirSync(dpath);
      } catch (e) {
        console.log("fileIO_test_mkdir_sync_011 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_SYNC_1200
     * @tc.name   : fileIO_test_mkdir_sync_012
     * @tc.desc   : Test mkdirSync() interfaces.
     * The path exists ?.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("fileIO_test_mkdir_sync_012", Level.LEVEL1, async () => {
      let dpath = (await nextFileName("fileIO_test_mkdir_sync_012")) + "?";
      try {
        await fileIO.mkdirSync(dpath, true);
        expect(fileIO.accessSync(dpath)).assertTrue();
        fileIO.rmdirSync(dpath);
      } catch (e) {
        console.log("fileIO_test_mkdir_sync_012 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number : SUB_FM_TEST_FILEFS_MKDIR_SYNC_0600
     * @tc.name   : fileIO_test_mkdir_sync_013
     * @tc.desc   : Test mkdirSync() interfaces.
     * The path exists :.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it("fileIO_test_mkdir_sync_013", Level.LEVEL1, async () => {
      let dpath = (await nextFileName("fileIO_test_mkdir_sync_013")) + ":";
      try {
        await fileIO.mkdirSync(dpath, true);
        expect(fileIO.accessSync(dpath)).assertTrue();
        fileIO.rmdirSync(dpath);
      } catch (e) {
        console.log("fileIO_test_mkdir_sync_013 has failed for " + e.message + ", code: " + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_MKDIRSYNC_NEW_0100
     * @tc.name fileIO_test_mkdir_sync_new_001
     * @tc.desc Test mkdirSync() interfaces.
     * Create a single level directory, verify normal function.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_mkdir_sync_new_001', Level.LEVEL0, async () => {
      let dpath = await nextFileName('fileIO_test_mkdir_sync_new_001') + 'd';
      let dpath1 = dpath + '/d1/d2';

      try {
        fileIO.mkdirSync(dpath,false);
        expect(fileIO.accessSync(dpath)).assertTrue();
        fileIO.mkdirSync(dpath1,false);
        expect(false).assertTrue();
      } catch (e) {
        fileIO.rmdirSync(dpath);
        console.log('fileIO_test_mkdir_sync_new_001 has failed for ' + e.message + ', code: ' + e.code);
        expect(e.code == 13900002 && e.message == 'No such file or directory').assertTrue();
      }
    });

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_MKDIRSYNC_NEW_0200
     * @tc.name fileIO_test_mkdir_sync_new_002
     * @tc.desc Test mkdirSync() interfaces.
     * Create a multi-level directory, verify normal function.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_mkdir_sync_new_002', Level.LEVEL0, async () => {
      let dpath = await nextFileName('fileIO_test_mkdir_sync_new_002') + 'd';
      let dpath1 = dpath + '/d1/d2';

      try {
        fileIO.mkdirSync(dpath,true);
        expect(fileIO.accessSync(dpath)).assertTrue();
        fileIO.mkdirSync(dpath1,true);
        expect(fileIO.accessSync(dpath1)).assertTrue();
        fileIO.rmdirSync(dpath);
      } catch (e) {
        console.log('fileIO_test_mkdir_sync_new_002 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_MKDIRSYNC_NEW_0300
     * @tc.name fileIO_test_mkdir_sync_new_003
     * @tc.desc Test mkdirSync() interfaces.
     * missing recursion parameter,use default recursion = false.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_mkdir_sync_new_003', Level.LEVEL3, async () => {
      let dpath = await nextFileName('fileIO_test_mkdir_sync_new_003') + 'd';
      let dpath1 = dpath + '/d1/d2';

      try {
        fileIO.mkdirSync(dpath);
        expect(fileIO.accessSync(dpath)).assertTrue();
        fileIO.mkdirSync(dpath1);
        expect(false).assertTrue();
      } catch (e) {
        fileIO.rmdirSync(dpath);
        console.log('fileIO_test_mkdir_sync_new_003 has failed for ' + e.message + ', code: ' + e.code);
        expect(e.code == 13900002 && e.message == 'No such file or directory').assertTrue();
      }
    });

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_MKDIRSYNC_NEW_0400
     * @tc.name fileIO_test_mkdir_sync_new_004
     * @tc.desc Test mkdirSync() interfaces.
     * Undefined recursion arguments,use default recursion = false.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_mkdir_sync_new_004', Level.LEVEL3, async () => {
      let dpath = await nextFileName('fileIO_test_mkdir_sync_new_004') + 'd';
      let dpath1 = dpath + '/d1/d2';
      console.log('lzyLOG dpath1' + dpath1);
      try {
        fileIO.mkdirSync(dpath,undefined);
        expect(fileIO.accessSync(dpath)).assertTrue();
        fileIO.mkdirSync(dpath1,undefined);
        expect(false).assertTrue();
      } catch (e) {
        fileIO.rmdirSync(dpath);
        console.log('fileIO_test_mkdir_sync_new_004 has failed for ' + e.message + ', code: ' + e.code);
        expect(e.code == 13900002 && e.message == 'No such file or directory').assertTrue();
      }
    });

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_MKDIRSYNC_NEW_0500
     * @tc.name fileIO_test_mkdir_sync_new_005
     * @tc.desc Test mkdirSync() interfaces.
     * The path has pointed to a file.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_mkdir_sync_new_005', Level.LEVEL3, async () => {
      let fpath = await nextFileName('fileIO_test_mkdir_sync_new_005') + 'd';
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        fileIO.mkdirSync(fpath,true);
        expect(false).assertTrue();
      } catch (e) {
        fileIO.unlinkSync(fpath);
        console.log('fileIO_test_mkdir_sync_new_005 has failed for ' + e.message + ', code: ' + e.code);
        expect(e.code == 13900015 && e.message == 'File exists').assertTrue();
      }
    });

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_MKDIRSYNC_NEW_0600
     * @tc.name fileIO_test_mkdir_sync_new_006
     * @tc.desc Test mkdirSync() interfaces.
     * The directory has been existed.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_mkdir_sync_new_006', Level.LEVEL3, async () => {

      try {
        fileIO.mkdirSync('/',false);
        expect(false).assertTrue();
      } catch (e) {
        console.log('fileIO_test_mkdir_sync_new_006 has failed for ' + e.message + ', code: ' + e.code);
        expect(e.code == 13900015 && e.message == 'File exists').assertTrue();
      }
    });

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_MKDIRSYNC_NEW_0700
     * @tc.name fileIO_test_mkdir_sync_new_007
     * @tc.desc Test mkdirSync() interfaces.
     * The path is empty.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_mkdir_sync_new_007', Level.LEVEL3, async () => {

      try {
        fileIO.mkdirSync('',false);
        expect(false).assertTrue();
      } catch (e) {
        console.log('fileIO_test_mkdir_sync_new_007 has failed for ' + e.message + ', code: ' + e.code);
        expect(e.code == 13900002 && e.message == 'No such file or directory').assertTrue();
      }
    });

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_MKDIR_ASYNC_NEW_0100
     * @tc.name fileIO_test_mkdir_async_new_001
     * @tc.desc Test mkdir() interfaces. Promise.
     * Create a single level directory, verify normal function.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_mkdir_async_new_001', Level.LEVEL0, async (done: Function) => {
      let dpath = await nextFileName('fileIO_test_mkdir_async_new_001') + 'd';
      let dpath1 = dpath + '/d1/d2';

      try {
        await fileIO.mkdir(dpath,false);
        expect(fileIO.accessSync(dpath)).assertTrue();
        await fileIO.mkdir(dpath1,false);
        expect(false).assertTrue();
      } catch (e) {
        fileIO.rmdirSync(dpath);
        console.log('fileIO_test_mkdir_async_new_001 has failed for ' + e.message + ', code: ' + e.code);
        expect(e.code == 13900002 && e.message == 'No such file or directory').assertTrue();
        done();
      }
    });

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_MKDIR_ASYNC_NEW_0200
     * @tc.name fileIO_test_mkdir_async_new_002
     * @tc.desc Test mkdir() interfaces. Promise.
     * Create a multi-level directory, verify normal function.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_mkdir_async_new_002', Level.LEVEL0, async (done: Function) => {
      let dpath = await nextFileName('fileIO_test_mkdir_async_new_002') + 'd';
      let dpath1 = dpath + '/d1/d2';

      try {
        await fileIO.mkdir(dpath,true);
        expect(fileIO.accessSync(dpath)).assertTrue();
        await fileIO.mkdir(dpath1,true);
        expect(fileIO.accessSync(dpath1)).assertTrue();
        fileIO.rmdirSync(dpath);
        done();
      } catch (e) {
        console.log('fileIO_test_mkdir_async_new_002 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_MKDIR_ASYNC_NEW_0300
     * @tc.name fileIO_test_mkdir_async_new_003
     * @tc.desc Test mkdir() interfaces. Promise.
     * missing recursion parameter,use default recursion = false.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_mkdir_async_new_003', Level.LEVEL3, async (done: Function) => {
      let dpath = await nextFileName('fileIO_test_mkdir_async_new_003') + 'd';
      let dpath1 = dpath + '/d1/d2';

      try {
        await fileIO.mkdir(dpath);
        expect(fileIO.accessSync(dpath)).assertTrue();
        await fileIO.mkdir(dpath1);
        expect(false).assertTrue();
      } catch (e) {
        fileIO.rmdirSync(dpath);
        console.log('fileIO_test_mkdir_async_new_003 has failed for ' + e.message + ', code: ' + e.code);
        expect(e.code == 13900002 && e.message == 'No such file or directory').assertTrue();
        done();

      }
    });

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_MKDIR_ASYNC_NEW_0400
     * @tc.name fileIO_test_mkdir_async_new_004
     * @tc.desc Test mkdir() interfaces. Promise.
     * Undefined recursion arguments,use default recursion = false.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_mkdir_async_new_004', Level.LEVEL3, async (done: Function) => {
      let dpath = await nextFileName('fileIO_test_mkdir_async_new_004') + 'd';
      let dpath1 = dpath + '/d1/d2';

      try {
        await fileIO.mkdir(dpath,undefined);
        expect(fileIO.accessSync(dpath)).assertTrue();
        await fileIO.mkdir(dpath1,undefined);
        expect(false).assertTrue();
      } catch (e) {
        fileIO.rmdirSync(dpath);
        console.log('fileIO_test_mkdir_async_new_004 has failed for ' + e.message + ', code: ' + e.code);
        expect(e.code == 13900002 && e.message == 'No such file or directory').assertTrue();
        done();
      }
    });

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_MKDIR_ASYNC_NEW_0500
     * @tc.name fileIO_test_mkdir_async_new_005
     * @tc.desc Test mkdir() interfaces. Promise.
     * The path has pointed to a file.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_mkdir_async_new_005', Level.LEVEL3, async (done: Function) => {
      let fpath = await nextFileName('fileIO_test_mkdir_async_new_005') + 'd';
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        await fileIO.mkdir(fpath,true);
        expect(false).assertTrue();
      } catch (e) {
        fileIO.unlinkSync(fpath);
        console.log('fileIO_test_mkdir_async_new_005 has failed for ' + e.message + ', code: ' + e.code);
        expect(e.code == 13900015 && e.message == 'File exists').assertTrue();
        done();
      }
    });

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_MKDIR_ASYNC_NEW_0600
     * @tc.name fileIO_test_mkdir_async_new_006
     * @tc.desc Test mkdir() interfaces. Promise.
     * The directory has been existed.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_mkdir_async_new_006', Level.LEVEL3, async (done: Function) => {

      try {
        await fileIO.mkdir('/',false);
        expect(false).assertTrue();
      } catch (e) {
        console.log('fileIO_test_mkdir_async_new_006 has failed for ' + e.message + ', code: ' + e.code);
        expect(e.code == 13900015 && e.message == 'File exists').assertTrue();
        done();
      }
    });

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_MKDIR_ASYNC_NEW_0700
     * @tc.name fileIO_test_mkdir_async_new_007
     * @tc.desc Test mkdir() interfaces. Promise.
     * The path is empty.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_mkdir_async_new_007', Level.LEVEL3, async (done: Function) => {

      try {
        await fileIO.mkdir('',false);
        expect(false).assertTrue();
      } catch (e) {
        console.log('fileIO_test_mkdir_async_new_007 has failed for ' + e.message + ', code: ' + e.code);
        expect(e.code == 13900002 && e.message == 'No such file or directory').assertTrue();
        done();
      }
    });

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_MKDIR_ASYNC_NEW_0800
     * @tc.name fileIO_test_mkdir_async_new_008
     * @tc.desc Test mkdir() interfaces. Callback.
     * Create a single level directory, verify normal function.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_mkdir_async_new_008', Level.LEVEL0, async (done: Function) => {
      let dpath = await nextFileName('fileIO_test_mkdir_async_new_008') + 'd';
      let dpath1 = dpath + '/d1/d2';

      try {
        fileIO.mkdir(dpath, false,(err) => {
          if(err) {
            console.log('fileIO_test_mkdir_async_new_008 error package: ' + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(fileIO.accessSync(dpath)).assertTrue();
          fileIO.mkdir(dpath1, false,(err) => {
            if(err) {
              fileIO.rmdirSync(dpath);
              console.log('fileIO_test_mkdir_async_new_008 error package1: ' + JSON.stringify(err));
              expect(err.code == 13900002 && err.message == 'No such file or directory').assertTrue();
              done();
            }
          });
        });
      } catch (e) {
        console.log('fileIO_test_mkdir_async_new_008 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_MKDIR_ASYNC_NEW_0900
     * @tc.name fileIO_test_mkdir_async_new_009
     * @tc.desc Test mkdir() interfaces. Callback.
     * Create a multi-level directory, verify normal function.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_mkdir_async_new_009', Level.LEVEL0, async (done: Function) => {
      let dpath = await nextFileName('fileIO_test_mkdir_async_new_009') + 'd';
      let dpath1 = dpath + '/d1/d2';

      try {
        fileIO.mkdir(dpath, true, (err) => {
          if(err) {
            console.log('fileIO_test_mkdir_async_new_009 error package: ' + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(fileIO.accessSync(dpath)).assertTrue();
          fileIO.mkdir(dpath1, true, (err) => {
            if(err) {
              console.log('fileIO_test_mkdir_async_new_009 error package1: ' + JSON.stringify(err));
              expect(false).assertTrue();
            }
            expect(fileIO.accessSync(dpath1)).assertTrue();
            fileIO.rmdirSync(dpath);
            done();
          });
        });
      } catch (e) {
        console.log('fileIO_test_mkdir_async_new_009 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_MKDIR_ASYNC_NEW_1000
     * @tc.name fileIO_test_mkdir_async_new_010
     * @tc.desc Test mkdir() interfaces. Callback.
     * missing recursion parameter,use default recursion = false.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_mkdir_async_new_010', Level.LEVEL3, async (done: Function) => {
      let dpath = await nextFileName('fileIO_test_mkdir_async_new_010') + 'd';
      let dpath1 = dpath + '/d1/d2';

      try {
        fileIO.mkdir(dpath, (err) => {
          if(err) {
            console.log('fileIO_test_mkdir_async_new_010 error package: ' + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(fileIO.accessSync(dpath)).assertTrue();
          fileIO.mkdir(dpath1, (err) => {
            if(err) {
              fileIO.rmdirSync(dpath);
              console.log('fileIO_test_mkdir_async_new_010 error package1: ' + JSON.stringify(err));
              expect(err.code == 13900002 && err.message == 'No such file or directory').assertTrue();
              done();
            }
          });
        });
      } catch (e) {
        console.log('fileIO_test_mkdir_async_new_010 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_MKDIR_ASYNC_NEW_1100
     * @tc.name fileIO_test_mkdir_async_new_011
     * @tc.desc Test mkdir() interfaces. Callback.
     * Undefined recursion arguments,use default recursion = false.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_mkdir_async_new_011', Level.LEVEL3, async (done: Function) => {
      let dpath = await nextFileName('fileIO_test_mkdir_async_new_011') + 'd';
      let dpath1 = dpath + '/d1/d2';

      try {
        fileIO.mkdir(dpath, undefined, (err) => {
          if(err) {
            console.log('fileIO_test_mkdir_async_new_011 error package: ' + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(fileIO.accessSync(dpath)).assertTrue();
          fileIO.mkdir(dpath1, undefined, (err) => {
            if(err) {
              fileIO.rmdirSync(dpath);
              console.log('fileIO_test_mkdir_async_new_011 error package1: ' + JSON.stringify(err));
              expect(err.code == 13900002 && err.message == 'No such file or directory').assertTrue();
              done();
            }
          });
        });
      } catch (e) {
        console.log('fileIO_test_mkdir_async_new_011 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_MKDIR_ASYNC_NEW_1200
     * @tc.name fileIO_test_mkdir_async_new_012
     * @tc.desc Test mkdir() interfaces. Callback.
     * The path has pointed to a file.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_mkdir_async_new_012', Level.LEVEL3, async (done: Function) => {
      let fpath = await nextFileName('fileIO_test_mkdir_async_new_012') + 'd';
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        fileIO.mkdir(fpath, true, (err) => {
          if(err) {
            fileIO.unlinkSync(fpath);
            console.log('fileIO_test_mkdir_async_new_012 error package: ' + JSON.stringify(err));
            expect(err.code == 13900015 && err.message == 'File exists').assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log('fileIO_test_mkdir_async_new_012 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_MKDIR_ASYNC_NEW_1300
     * @tc.name fileIO_test_mkdir_async_new_013
     * @tc.desc Test mkdir() interfaces. Callback.
     * The directory has been existed.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_mkdir_async_new_013', Level.LEVEL3, async (done: Function) => {

      try {
        fileIO.mkdir('/', false, (err) => {
          if(err) {
            console.log('fileIO_test_mkdir_async_new_013 error package: ' + JSON.stringify(err));
            expect(err.code == 13900015 && err.message == 'File exists').assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log('fileIO_test_mkdir_async_new_013 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_MKDIR_ASYNC_NEW_1400
     * @tc.name fileIO_test_mkdir_async_new_014
     * @tc.desc Test mkdir() interfaces. Callback.
     * The path is empty.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_mkdir_async_new_014', Level.LEVEL3, async (done: Function) => {

      try {
        fileIO.mkdir('', false, (err) => {
          if(err) {
            console.log('fileIO_test_mkdir_async_new_014 error package: ' + JSON.stringify(err));
            expect(err.code == 13900002 && err.message == 'No such file or directory').assertTrue();
            done();
          }
        });
      } catch (e) {
        console.log('fileIO_test_mkdir_async_new_014 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });
  });
}
