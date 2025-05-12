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

import {
  fileIO, FILE_CONTENT, prepareFile, nextFileName, describe, it, expect,
} from '../Common';
import { Level } from '@ohos/hypium';

export default function fileIOMoveFile() {
  describe('fileIO_fs_moveFile',() =>{

    /**
     * @tc.number SUB_DF_FILEIO_MOVEFILE_ASYNC_0000
     * @tc.name fileIO_test_moveFile_async_000
     * @tc.desc Test moveFile() interface. Promise.
     * Move a single file, shall work properly in normal case.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_moveFile_async_000', Level.LEVEL0, async (done: Function) => {
      let dpath = await nextFileName('fileIO_test_moveFile_async_000');
      let fpath = dpath + '/file_005.txt';
      let ddpath = dpath + '/dir_005';
      let ffpath = ddpath + '/file_005.txt';
      fileIO.mkdirSync(dpath);
      fileIO.mkdirSync(ddpath);
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        await fileIO.moveFile(fpath, ffpath);
        let stat = fileIO.statSync(ffpath);
        expect(stat.size == FILE_CONTENT.length).assertTrue();
        fileIO.rmdirSync(dpath);
        done();
      } catch (e) {
        console.log('fileIO_test_moveFile_async_000 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number fileIO_test_moveFile_async_001
     * @tc.name fileIO_test_moveFile_async_002
     * @tc.desc Test moveFile() interface. Promise.
     * A file with the same name already exists under the destination path.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_moveFile_async_001', Level.LEVEL3, async (done: Function) => {
      let dpath = await nextFileName('fileIO_test_moveFile_async_001');
      let fpath = dpath + '/file_007.txt';
      let ddpath = dpath + '/dir_007';
      let ffpath = ddpath + '/file_007.txt';
      fileIO.mkdirSync(dpath);
      fileIO.mkdirSync(ddpath);
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        fileIO.copyFileSync(fpath, ffpath);
        await fileIO.moveFile(fpath, ffpath, 1);
        expect(false).assertTrue();
      } catch (e) {
        fileIO.rmdirSync(dpath);
        console.log('fileIO_test_moveFile_async_001 has failed for ' + e.message + ', code: ' + e.code);
        expect(e.code == 13900015 && e.message == 'File exists').assertTrue();
        done();
      }
    });



    /**
     * @tc.number fileIO_test_moveFile_async_002
     * @tc.name fileIO_test_moveFile_async_004
     * @tc.desc Test moveFile() interface. Promise.
     * The path point to nothing, no such file.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_moveFile_async_002', Level.LEVEL3, async (done: Function) => {
      let dpath = await nextFileName('fileIO_test_moveFile_async_002');
      let fpath = dpath + '/file_009.txt';
      let ddpath = dpath + '/dir_009';
      let ffpath = ddpath + '/file_009.txt';
      fileIO.mkdirSync(dpath);
      fileIO.mkdirSync(ddpath);

      try {
        await fileIO.moveFile(fpath, ffpath);
        expect(false).assertTrue();
      } catch (e) {
        fileIO.rmdirSync(dpath);
        console.log('fileIO_test_moveFile_async_002 has failed for ' + e.message + ', code: ' + e.code);
        expect(e.code == 13900002 && e.message == 'No such file or directory').assertTrue();
        done();
      }
    });
    /**
     * @tc.number fileIO_test_moveFile_async_003
     * @tc.name fileIO_test_moveFile_async_006
     * @tc.desc Test moveFile() interface. Promise.
     * The path point to a directory, not a file.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_moveFile_async_003', Level.LEVEL3, async (done: Function) => {
      let dpath = await nextFileName('fileIO_test_moveFile_async_003');
      let ddpath = dpath + '/dir_011';
      fileIO.mkdirSync(dpath);

      try {
        await fileIO.moveFile(dpath, ddpath);
        expect(false).assertTrue();
      } catch (e) {
        fileIO.rmdirSync(dpath);
        console.log('fileIO_test_moveFile_async_003 has failed for ' + e.message + ', code: ' + e.code);
        expect(e.code == 13900020 && e.message == 'Invalid argument').assertTrue();
        done();
      }
    });


    /**
     * @tc.number fileIO_test_moveFile_async_004
     * @tc.name fileIO_test_moveFile_async_009
     * @tc.desc Test moveFile() interface. Promise.
     * Entry parameters increase forced movement when mode = 0.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_moveFile_async_004', Level.LEVEL3, async (done: Function) => {
      let dpath = await nextFileName('fileIO_test_moveFile_async_004');
      let fpath = dpath + '/file_013.txt';
      let ddpath = dpath + '/dir_013';
      let ffpath = ddpath + '/file_013.txt';
      fileIO.mkdirSync(dpath);
      fileIO.mkdirSync(ddpath);
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
      expect(prepareFile(ffpath, '')).assertTrue();

      try {
        await fileIO.moveFile(fpath, ffpath, 0);
        let stat = fileIO.statSync(ffpath);
        expect(stat.size == FILE_CONTENT.length).assertTrue();
        fileIO.rmdirSync(dpath);
        done();
      } catch (e) {
        console.log('fileIO_test_moveFile_async_004 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });



    /**
     * @tc.number fileIO_test_moveFile_async_005
     * @tc.name fileIO_test_moveFile_async_011
     * @tc.desc Test moveFile() interface. Promise.
     * Undefined option arguments, use default mode = 0.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_moveFile_async_005', Level.LEVEL3, async (done: Function) => {
      let dpath = await nextFileName('fileIO_test_moveFile_async_005');
      let fpath = dpath + '/file_016.txt';
      let ddpath = dpath + '/dir_016';
      let ffpath = ddpath + '/file_016.txt';
      fileIO.mkdirSync(dpath);
      fileIO.mkdirSync(ddpath);
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
      expect(prepareFile(ffpath, '')).assertTrue();

      try {
        await fileIO.moveFile(fpath, ffpath, undefined);
        let stat = fileIO.statSync(ffpath);
        expect(stat.size == FILE_CONTENT.length).assertTrue();
        fileIO.rmdirSync(dpath);
        done();
      } catch (e) {
        console.log('fileIO_test_moveFile_async_005 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });

  });
}