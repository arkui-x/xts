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

import fileIO from "@ohos.file.fs";
import { describe, it, expect, afterEach } from "@ohos/hypium";

const FILE_CONTENT = "hello world";

function randomString(num) {
  let len = num;
  let $chars = "aaaabbbbcccc";
  let maxPos = $chars.length;
  let pwd = "";
  for (let i = 0; i < len; i++) {
    pwd += $chars.charAt(Math.floor(Math.random() * maxPos));
  }
  return pwd;
}

function prepareFile(fpath, content) {
  try {
    let file = fileIO.openSync(fpath, fileIO.OpenMode.CREATE | fileIO.OpenMode.READ_WRITE);
    fileIO.truncateSync(file.fd);
    fileIO.writeSync(file.fd, content);
    fileIO.fsyncSync(file.fd);
    fileIO.closeSync(file);
    return true;
  } catch (e) {
    console.log("Failed to prepareFile for " + e);
    return false;
  }
}

async function nextFileName(testName) {
  let context = globalThis.abilityContext;
  let data = context.cacheDir;
  let BASE_PATH = data + "/";
  return BASE_PATH + testName + "_" + randomString(testName.length);
}

function isIntNum(val) {
  return typeof val === "number" && val % 1 === 0;
}

async function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function onOpenErrorSimple(testName, expectedCode, done) {
  return function (err) {
    if (err) {
      console.log(testName + ": " + err.message + ", code: " + err.code);
      expect(err.code).assertEqual(expectedCode);
      done();
    } else {
      expect(false).assertTrue();
      done();
    }
  };
}

function onOpenErrorNoCodeCheck(testName, done) {
  return function (err) {
    if (err) {
      console.log(testName + ": " + err.message + ", code: " + err.code);
      done();
    } else {
      expect(false).assertTrue();
      done();
    }
  };
}

function onOpenErrorOrSuccess(testName, fpath, expectedErrCode, done) {
  return function (err, file) {
    if (err) {
      console.log(testName + ": " + err.message + ", code: " + err.code);
      expect(err.code).assertEqual(expectedErrCode);
      fileIO.unlinkSync(fpath);
      done();
      return;
    }
    expect(isIntNum(file.fd)).assertTrue();
    fileIO.closeSync(file);
    fileIO.unlinkSync(fpath);
    done();
  };
}

function onOpenErrorExpectSuccess(testName, fpath, done) {
  return function (err, file) {
    if (err) {
      console.log(testName + ": " + err.message + ", code: " + err.code);
      expect(false).assertTrue();
      fileIO.unlinkSync(fpath);
      done();
      return;
    }
    expect(isIntNum(file.fd)).assertTrue();
    fileIO.closeSync(file);
    fileIO.unlinkSync(fpath);
    done();
  };
}

function runOpenErrorPromiseTests() {
  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_000
   * @tc.name   fileIO_open_error_000
   * @tc.desc   Test open() interface with invalid path(-1). Promise.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_000", 3, async () => {
    try {
      await fileIO.open(-1, fileIO.OpenMode.READ_WRITE);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_open_error_000 has failed for " + e.message + ", code: " + e.code);
      expect(e.code).assertEqual(13900020);
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_002
   * @tc.name   fileIO_open_error_002
   * @tc.desc   Test open() interface with null path. Promise.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_002", 3, async () => {
    try {
      await fileIO.open(null);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_open_error_002 has failed for " + e.message + ", code: " + e.code);
      expect(e.code).assertEqual(13900020);
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_003
   * @tc.name   fileIO_open_error_003
   * @tc.desc   Test open() interface with undefined path. Promise.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_003", 3, async () => {
    try {
      await fileIO.open(undefined);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_open_error_003 has failed for " + e.message + ", code: " + e.code);
      expect(e.code).assertEqual(13900020);
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_004
   * @tc.name   fileIO_open_error_004
   * @tc.desc   Test open() interface with null mode. Promise.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_004", 3, async () => {
    let fpath = await nextFileName("fileIO_open_error_004");
    expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
    try {
      await fileIO.open(fpath, null);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_open_error_004 has failed for " + e.message + ", code: " + e.code);
      expect(e.code).assertEqual(13900020);
      fileIO.unlinkSync(fpath);
    }
  });
}

function runOpenErrorCallbackTests() {
  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_007
   * @tc.name   fileIO_open_error_007
   * @tc.desc   Test open() interface with null path. Callback.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_007", 3, async (done) => {
    try {
      fileIO.open(null, onOpenErrorSimple("fileIO_open_error_007", 13900020, done));
    } catch (e) {
      console.log("fileIO_open_error_007: " + e.message + ", code: " + e.code);
      expect(e.code).assertEqual(13900020);
      done();
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_008
   * @tc.name   fileIO_open_error_008
   * @tc.desc   Test open() interface with undefined path. Callback.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_008", 3, async (done) => {
    try {
      fileIO.open(undefined, onOpenErrorSimple("fileIO_open_error_008", 13900020, done));
    } catch (e) {
      console.log("fileIO_open_error_008: " + e.message + ", code: " + e.code);
      expect(e.code).assertEqual(13900020);
      done();
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_009
   * @tc.name   fileIO_open_error_009
   * @tc.desc   Test open() interface with null mode. Callback.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it('fileIO_open_error_009', 3, async function (done) {
    let fpath = await nextFileName('fileIO_open_error_009');
    expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
    try {
      fileIO.open(fpath, null, onOpenErrorOrSuccess('fileIO_open_error_009', fpath, 13900020, done));
    } catch (e) {
      console.log('fileIO_open_error_009: ' + e.message + ', code: ' + e.code);
      fileIO.unlinkSync(fpath);
      done();
    }
  });
}

function runOpenErrorCallbackWithModeTests() {
  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_010
   * @tc.name   fileIO_open_error_010
   * @tc.desc   Test open() interface with undefined mode. Callback.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_010", 3, async (done) => {
    let fpath = await nextFileName("fileIO_open_error_010");
    expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
    try {
      fileIO.open(fpath, undefined, onOpenErrorExpectSuccess("fileIO_open_error_010", fpath, done));
    } catch (e) {
      console.log("fileIO_open_error_010: " + e.message + ", code: " + e.code);
      expect(false).assertTrue();
      fileIO.unlinkSync(fpath);
      done();
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_012
   * @tc.name   fileIO_open_error_012
   * @tc.desc   Test open() interface with null path. Callback with mode.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_012", 3, async (done) => {
    try {
      fileIO.open(null, 0, onOpenErrorSimple("fileIO_open_error_012", 13900020, done));
    } catch (e) {
      console.log("fileIO_open_error_012: " + e.message + ", code: " + e.code);
      expect(e.code).assertEqual(13900020);
      done();
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_013
   * @tc.name   fileIO_open_error_013
   * @tc.desc   Test open() interface with undefined path. Callback with mode.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_013", 3, async (done) => {
    try {
      fileIO.open(undefined, 0, onOpenErrorSimple("fileIO_open_error_013", 13900020, done));
    } catch (e) {
      console.log("fileIO_open_error_013: " + e.message + ", code: " + e.code);
      expect(e.code).assertEqual(13900020);
      done();
    }
  });
}

function runOpenErrorCallbackModeWithFileTests() {
  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_014
   * @tc.name   fileIO_open_error_014
   * @tc.desc   Test open() interface with null mode. Callback with mode.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_014", 3, async (done) => {
    let fpath = await nextFileName('fileIO_open_error_014');
    expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
    try {
      fileIO.open(fpath, null, onOpenErrorOrSuccess('fileIO_open_error_014', fpath, 13900020, done));
    } catch (e) {
      console.log('fileIO_open_error_014: ' + e.message + ', code: ' + e.code);
      fileIO.unlinkSync(fpath);
      done();
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_015
   * @tc.name   fileIO_open_error_015
   * @tc.desc   Test open() interface with undefined mode. Callback with mode.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_015", 3, async (done) => {
    let fpath = await nextFileName("fileIO_open_error_015");
    expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
    try {
      fileIO.open(fpath, undefined, onOpenErrorExpectSuccess("fileIO_open_error_015", fpath, done));
    } catch (e) {
      console.log("fileIO_open_error_015: " + e.message + ", code: " + e.code);
      expect(false).assertTrue();
      fileIO.unlinkSync(fpath);
      done();
    }
  });
}

function runOpenErrorSyncTests() {
  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_000
   * @tc.name   fileIO_openSync_error_000
   * @tc.desc   Test openSync() interface with undefined path.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_openSync_error_000", 3, () => {
    try {
      fileIO.openSync(undefined);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_openSync_error_000 has failed for " + e.message + ", code: " + e.code);
      expect(e.code).assertEqual(13900020);
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_002
   * @tc.name   fileIO_openSync_error_002
   * @tc.desc   Test openSync() interface with null path.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_openSync_error_002", 3, async () => {
    try {
      fileIO.openSync(null);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_openSync_error_002: " + e.message + ", code: " + e.code);
      expect(e.code).assertEqual(13900020);
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_004
   * @tc.name   fileIO_openSync_error_004
   * @tc.desc   Test openSync() interface with undefined mode.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_openSync_error_004", 3, async () => {
    let fpath = await nextFileName("fileIO_openSync_error_004");
    expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
    try {
      let file = fileIO.openSync(fpath, undefined);
      expect(isIntNum(file.fd)).assertTrue();
      fileIO.closeSync(file);
      fileIO.unlinkSync(fpath);
    } catch (e) {
      console.log("fileIO_openSync_error_004: " + e.message + ", code: " + e.code);
      expect(false).assertTrue();
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_016
   * @tc.name   fileIO_test_open_sync_016
   * @tc.desc   Test openSync() interface with invalid path(-1).
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_test_open_sync_016", 3, async () => {
    try {
      fileIO.openSync(-1);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_test_open_sync_016 has failed for " + e.message + ", code: " + e.code);
      expect(e.code).assertEqual(13900020);
    }
  });
}

function runOpenErrorCallbackInvalidPathTests() {
  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_016
   * @tc.name   fileIO_open_error_016
   * @tc.desc   Test open() interface with invalid path(-1). Callback.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_016", 3, async (done) => {
    try {
      fileIO.open(-1, onOpenErrorSimple("fileIO_open_error_016", 13900020, done));
    } catch (e) {
      console.log("fileIO_open_error_016: " + e.message + ", code: " + e.code);
      expect(e.code).assertEqual(13900020);
      done();
    }
  });
}

function runOpenErrorPathTests() {
  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_019
   * @tc.name   fileIO_open_error_019
   * @tc.desc   Test open() interface with relative path. Promise.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_019", 3, async () => {
    try {
      await fileIO.open("../relative_test_file", fileIO.OpenMode.READ_ONLY);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_open_error_019 has failed for " + e.message + ", code: " + e.code);
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_020
   * @tc.name   fileIO_open_error_020
   * @tc.desc   Test open() interface with path starting with "://". Promise.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_020", 3, async () => {
    try {
      await fileIO.open("://invalidpath", fileIO.OpenMode.READ_ONLY);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_open_error_020 has failed for " + e.message + ", code: " + e.code);
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_021
   * @tc.name   fileIO_open_error_021
   * @tc.desc   Test open() interface with path ending with "://". Promise.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_021", 3, async () => {
    try {
      await fileIO.open("invalidpath://", fileIO.OpenMode.READ_ONLY);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_open_error_021 has failed for " + e.message + ", code: " + e.code);
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_022
   * @tc.name   fileIO_open_error_022
   * @tc.desc   Test open() interface with Windows-style path. Promise.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_022", 3, async () => {
    try {
      await fileIO.open("C:\\Users\\test.txt", fileIO.OpenMode.READ_ONLY);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_open_error_022 has failed for " + e.message + ", code: " + e.code);
    }
  });
}

function runOpenErrorUriTests() {
  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_023
   * @tc.name   fileIO_open_error_023
   * @tc.desc   Test open() interface with uppercase FILE:// URI. Promise.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_023", 3, async () => {
    try {
      await fileIO.open("FILE:///data/local/tmp/test.txt", fileIO.OpenMode.READ_ONLY);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_open_error_023 has failed for " + e.message + ", code: " + e.code);
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_024
   * @tc.name   fileIO_open_error_024
   * @tc.desc   Test open() interface with mixed-case File:// URI. Promise.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_024", 3, async () => {
    try {
      await fileIO.open("File:///data/local/tmp/test.txt", fileIO.OpenMode.READ_ONLY);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_open_error_024 has failed for " + e.message + ", code: " + e.code);
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_025
   * @tc.name   fileIO_open_error_025
   * @tc.desc   Test open() interface with non-existent file URI. Promise.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_025", 3, async () => {
    try {
      await fileIO.open("file:///data/local/tmp/non_existent_file_12345", fileIO.OpenMode.READ_ONLY);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_open_error_025 has failed for " + e.message + ", code: " + e.code);
      expect(e.code).assertEqual(13900002);
    }
  });
}

function runOpenErrorSpecialTests() {
  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_026
   * @tc.name   fileIO_open_error_026
   * @tc.desc   Test open() interface with space string path. Promise.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_026", 3, async () => {
    try {
      await fileIO.open("   ", fileIO.OpenMode.READ_ONLY);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_open_error_026 has failed for " + e.message + ", code: " + e.code);
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_027
   * @tc.name   fileIO_open_error_027
   * @tc.desc   Test open() interface with file:// URI containing spaces. Promise.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_027", 3, async () => {
    try {
      await fileIO.open("file://   ", fileIO.OpenMode.READ_ONLY);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_open_error_027 has failed for " + e.message + ", code: " + e.code);
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_028
   * @tc.name   fileIO_open_error_028
   * @tc.desc   Test open() interface with special characters and Chinese path. Promise.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_028", 3, async () => {
    try {
      await fileIO.open("特殊字符@#$%^&*()test", fileIO.OpenMode.READ_ONLY);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_open_error_028 has failed for " + e.message + ", code: " + e.code);
    }
  });
}

function runOpenErrorPermissionTests() {
  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_029
   * @tc.name   fileIO_open_error_029
   * @tc.desc   Test open() interface with read-only permission file, try write. Promise.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_029", 3, async (done) => {
    let fpath = await nextFileName("fileIO_open_error_029");
    expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
    try {
      let file = await fileIO.open(fpath, fileIO.OpenMode.READ_ONLY);
      expect(isIntNum(file.fd)).assertTrue();
      fileIO.writeSync(file.fd, FILE_CONTENT);
      expect(false).assertTrue();
      fileIO.closeSync(file);
    } catch (e) {
      console.log("fileIO_open_error_029 has failed for " + e.message + ", code: " + e.code);
      fileIO.unlinkSync(fpath);
      done();
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_030
   * @tc.name   fileIO_open_error_030
   * @tc.desc   Test open() interface with write-only permission file, try read. Promise.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_030", 3, async (done) => {
    let fpath = await nextFileName("fileIO_open_error_030");
    expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
    try {
      let file = await fileIO.open(fpath, fileIO.OpenMode.WRITE_ONLY);
      expect(isIntNum(file.fd)).assertTrue();
      fileIO.readSync(file.fd, new ArrayBuffer(4096));
      expect(false).assertTrue();
      fileIO.closeSync(file);
    } catch (e) {
      console.log("fileIO_open_error_030 has failed for " + e.message + ", code: " + e.code);
      fileIO.unlinkSync(fpath);
      done();
    }
  });
}

function runOpenErrorPathCallbackTests() {
  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_031
   * @tc.name   fileIO_open_error_031
   * @tc.desc   Test open() interface with relative path. Callback.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_031", 3, async (done) => {
    try {
      fileIO.open("../relative_test_file", fileIO.OpenMode.READ_ONLY, onOpenErrorNoCodeCheck("fileIO_open_error_031", done));
    } catch (e) {
      console.log("fileIO_open_error_031: " + e.message + ", code: " + e.code);
      done();
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_032
   * @tc.name   fileIO_open_error_032
   * @tc.desc   Test open() interface with path starting with "://". Callback.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_032", 3, async (done) => {
    try {
      fileIO.open("://invalidpath", fileIO.OpenMode.READ_ONLY, onOpenErrorNoCodeCheck("fileIO_open_error_032", done));
    } catch (e) {
      console.log("fileIO_open_error_032: " + e.message + ", code: " + e.code);
      done();
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_033
   * @tc.name   fileIO_open_error_033
   * @tc.desc   Test open() interface with path ending with "://". Callback.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_033", 3, async (done) => {
    try {
      fileIO.open("invalidpath://", fileIO.OpenMode.READ_ONLY, onOpenErrorNoCodeCheck("fileIO_open_error_033", done));
    } catch (e) {
      console.log("fileIO_open_error_033: " + e.message + ", code: " + e.code);
      done();
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_034
   * @tc.name   fileIO_open_error_034
   * @tc.desc   Test open() interface with Windows-style path. Callback.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_034", 3, async (done) => {
    try {
      fileIO.open("C:\\Users\\test.txt", fileIO.OpenMode.READ_ONLY, onOpenErrorNoCodeCheck("fileIO_open_error_034", done));
    } catch (e) {
      console.log("fileIO_open_error_034: " + e.message + ", code: " + e.code);
      done();
    }
  });
}

function runOpenErrorUriCallbackTests() {
  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_035
   * @tc.name   fileIO_open_error_035
   * @tc.desc   Test open() interface with uppercase FILE:// URI. Callback.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_035", 3, async (done) => {
    try {
      fileIO.open("FILE:///data/local/tmp/test.txt", fileIO.OpenMode.READ_ONLY, onOpenErrorNoCodeCheck("fileIO_open_error_035", done));
    } catch (e) {
      console.log("fileIO_open_error_035: " + e.message + ", code: " + e.code);
      done();
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_036
   * @tc.name   fileIO_open_error_036
   * @tc.desc   Test open() interface with mixed-case File:// URI. Callback.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_036", 3, async (done) => {
    try {
      fileIO.open("File:///data/local/tmp/test.txt", fileIO.OpenMode.READ_ONLY, onOpenErrorNoCodeCheck("fileIO_open_error_036", done));
    } catch (e) {
      console.log("fileIO_open_error_036: " + e.message + ", code: " + e.code);
      done();
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_037
   * @tc.name   fileIO_open_error_037
   * @tc.desc   Test open() interface with non-existent file URI. Callback.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_037", 3, async (done) => {
    try {
      fileIO.open("file:///data/local/tmp/non_existent_file_12345", fileIO.OpenMode.READ_ONLY, onOpenErrorSimple("fileIO_open_error_037", 13900002, done));
    } catch (e) {
      console.log("fileIO_open_error_037: " + e.message + ", code: " + e.code);
      done();
    }
  });
}

function runOpenErrorSpecialCallbackTests() {
  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_038
   * @tc.name   fileIO_open_error_038
   * @tc.desc   Test open() interface with space string path. Callback.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_038", 3, async (done) => {
    try {
      fileIO.open("   ", fileIO.OpenMode.READ_ONLY, onOpenErrorNoCodeCheck("fileIO_open_error_038", done));
    } catch (e) {
      console.log("fileIO_open_error_038: " + e.message + ", code: " + e.code);
      done();
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_039
   * @tc.name   fileIO_open_error_039
   * @tc.desc   Test open() interface with file:// URI containing spaces. Callback.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_039", 3, async (done) => {
    try {
      fileIO.open("file://   ", fileIO.OpenMode.READ_ONLY, onOpenErrorNoCodeCheck("fileIO_open_error_039", done));
    } catch (e) {
      console.log("fileIO_open_error_039: " + e.message + ", code: " + e.code);
      done();
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_ERROR_040
   * @tc.name   fileIO_open_error_040
   * @tc.desc   Test open() interface with special characters and Chinese path. Callback.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_open_error_040", 3, async (done) => {
    try {
      fileIO.open("特殊字符@#$%^&*()test", fileIO.OpenMode.READ_ONLY, onOpenErrorNoCodeCheck("fileIO_open_error_040", done));
    } catch (e) {
      console.log("fileIO_open_error_040: " + e.message + ", code: " + e.code);
      done();
    }
  });
}

function runOpenErrorPathSyncTests() {
  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_006
   * @tc.name   fileIO_openSync_error_006
   * @tc.desc   Test openSync() interface with relative path.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_openSync_error_006", 3, () => {
    try {
      fileIO.openSync("../relative_test_file", fileIO.OpenMode.READ_ONLY);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_openSync_error_006 has failed for " + e.message + ", code: " + e.code);
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_007
   * @tc.name   fileIO_openSync_error_007
   * @tc.desc   Test openSync() interface with path starting with "://".
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_openSync_error_007", 3, () => {
    try {
      fileIO.openSync("://invalidpath", fileIO.OpenMode.READ_ONLY);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_openSync_error_007 has failed for " + e.message + ", code: " + e.code);
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_008
   * @tc.name   fileIO_openSync_error_008
   * @tc.desc   Test openSync() interface with path ending with "://".
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_openSync_error_008", 3, () => {
    try {
      fileIO.openSync("invalidpath://", fileIO.OpenMode.READ_ONLY);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_openSync_error_008 has failed for " + e.message + ", code: " + e.code);
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_009
   * @tc.name   fileIO_openSync_error_009
   * @tc.desc   Test openSync() interface with Windows-style path.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_openSync_error_009", 3, () => {
    try {
      fileIO.openSync("C:\\Users\\test.txt", fileIO.OpenMode.READ_ONLY);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_openSync_error_009 has failed for " + e.message + ", code: " + e.code);
    }
  });
}

function runOpenErrorUriSyncTests() {
  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_010
   * @tc.name   fileIO_openSync_error_010
   * @tc.desc   Test openSync() interface with uppercase FILE:// URI.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_openSync_error_010", 3, () => {
    try {
      fileIO.openSync("FILE:///data/local/tmp/test.txt", fileIO.OpenMode.READ_ONLY);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_openSync_error_010 has failed for " + e.message + ", code: " + e.code);
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_011
   * @tc.name   fileIO_openSync_error_011
   * @tc.desc   Test openSync() interface with mixed-case File:// URI.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_openSync_error_011", 3, () => {
    try {
      fileIO.openSync("File:///data/local/tmp/test.txt", fileIO.OpenMode.READ_ONLY);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_openSync_error_011 has failed for " + e.message + ", code: " + e.code);
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_012
   * @tc.name   fileIO_openSync_error_012
   * @tc.desc   Test openSync() interface with non-existent file URI.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_openSync_error_012", 3, () => {
    try {
      fileIO.openSync("file:///data/local/tmp/non_existent_file_12345", fileIO.OpenMode.READ_ONLY);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_openSync_error_012 has failed for " + e.message + ", code: " + e.code);
      expect(e.code).assertEqual(13900002);
    }
  });
}

function runOpenErrorSpecialSyncTests() {
  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_013
   * @tc.name   fileIO_openSync_error_013
   * @tc.desc   Test openSync() interface with space string path.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_openSync_error_013", 3, () => {
    try {
      fileIO.openSync("   ", fileIO.OpenMode.READ_ONLY);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_openSync_error_013 has failed for " + e.message + ", code: " + e.code);
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_014
   * @tc.name   fileIO_openSync_error_014
   * @tc.desc   Test openSync() interface with file:// URI containing spaces.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_openSync_error_014", 3, () => {
    try {
      fileIO.openSync("file://   ", fileIO.OpenMode.READ_ONLY);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_openSync_error_014 has failed for " + e.message + ", code: " + e.code);
    }
  });

  /**
   * @tc.number SUB_FM_TEST_FILEFS_OPEN_SYNC_ERROR_015
   * @tc.name   fileIO_openSync_error_015
   * @tc.desc   Test openSync() interface with special characters and Chinese path.
   * @tc.size   : MediumTest
   * @tc.type   : Function
   * @tc.level  : Level 3
   */
  it("fileIO_openSync_error_015", 3, () => {
    try {
      fileIO.openSync("特殊字符@#$%^&*()test", fileIO.OpenMode.READ_ONLY);
      expect(false).assertTrue();
    } catch (e) {
      console.log("fileIO_openSync_error_015 has failed for " + e.message + ", code: " + e.code);
    }
  });
}

export default function fileIOOpenError() {
  describe("fileIO_fs_open_error", () => {
    afterEach(async () => {
      await sleep(500);
    });
    runOpenErrorPromiseTests();
    runOpenErrorCallbackTests();
    runOpenErrorCallbackWithModeTests();
    runOpenErrorCallbackModeWithFileTests();
    runOpenErrorSyncTests();
    runOpenErrorCallbackInvalidPathTests();
    runOpenErrorPathTests();
    runOpenErrorUriTests();
    runOpenErrorSpecialTests();
    runOpenErrorPermissionTests();
    runOpenErrorPathCallbackTests();
    runOpenErrorUriCallbackTests();
    runOpenErrorSpecialCallbackTests();
    runOpenErrorPathSyncTests();
    runOpenErrorUriSyncTests();
    runOpenErrorSpecialSyncTests();
  });
}
