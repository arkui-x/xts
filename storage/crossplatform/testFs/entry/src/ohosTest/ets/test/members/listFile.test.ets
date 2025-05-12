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

import { fileIO, FILE_CONTENT, prepareFile, nextFileName, describe, it, expect, randomString } from '../Common';
import { TestType, Size, Level } from '@ohos/hypium';
import deviceInfo from '@ohos.deviceInfo';

export default function fileIOListfile() {
  describe('fileIO_fs_listfile', () => {
    /**
     * @tc.number SUB_DF_FILEIO_LISTFILE_SYNC_0000
     * @tc.name fileIO_test_listfile_sync_000
     * @tc.desc Test listFileSync()interfaces.
     * Only path, do not filter file.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_listfile_sync_000', Level.LEVEL0, async () => {
      let dpath = await nextFileName('fileIO_test_listfile_sync_000');
      let fpath1 = dpath + '/listfile_sync_000.txt';
      let fpath2 = dpath + '/listfile_sync_000.doc';
      let fpath3 = dpath + '/listfile_sync_000.png';
      fileIO.mkdirSync(dpath);
      expect(prepareFile(fpath1, FILE_CONTENT)).assertTrue();
      expect(prepareFile(fpath2, FILE_CONTENT)).assertTrue();
      expect(prepareFile(fpath3, FILE_CONTENT)).assertTrue();
      try {
        let dirents = fileIO.listFileSync(dpath);
        expect(dirents.length == 3).assertTrue();
        fileIO.rmdirSync(dpath);
      } catch (err) {
        console.log('fileIO_test_listfile_sync_000 has failed for ' + err.message + ', code:' + err.code);
        expect(false).assertTrue();
      }
    });
    /**
     * @tc.number SUB_DF_FILEIO_LISTFILE_SYNC_1200
     * @tc.name fileIO_test_listfile_sync_012
     * @tc.desc Test listFileSync() interfaces.
     * Undefined option arguments, use default options.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_listfile_sync_012', Level.LEVEL3, async () => {
      let dpath = await nextFileName('fileIO_test_listfile_sync_012');
      let ddpath = dpath + '/second_dir';
      let fpath1 = dpath + '/listfile_sync_011.txt';
      let fpath2 = dpath + '/listfile_sync_011.doc';
      let fpath3 = dpath + '/listfile_sync_011.png';
      let ffpath1 = ddpath + '/listfile_sync_second_011.txt';
      let ffpath2 = ddpath + '/listfile_sync_second_011.doc';
      fileIO.mkdirSync(dpath);
      fileIO.mkdirSync(ddpath);
      expect(prepareFile(fpath1, FILE_CONTENT)).assertTrue();
      expect(prepareFile(fpath2, FILE_CONTENT)).assertTrue();
      expect(prepareFile(fpath3, FILE_CONTENT)).assertTrue();
      expect(prepareFile(ffpath1, FILE_CONTENT)).assertTrue();
      expect(prepareFile(ffpath2, FILE_CONTENT)).assertTrue();
      try {
        let dirents = fileIO.listFileSync(dpath, undefined);
        expect(dirents.length == 4).assertTrue();
        fileIO.rmdirSync(dpath);
      } catch (err) {
        console.log('fileIO_test_listfile_sync_012 has failed for ' + err.message + ', code:' + err.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LISTFILE_ASYNC_0000
     * @tc.name fileIO_test_listfile_async_000
     * @tc.desc Test listFile() interface. Callback.
     * Only path, do not filter file.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_listfile_async_000', Level.LEVEL0, async () => {
      let dpath = await nextFileName('fileIO_test_listfile_async_000');
      let fpath1 = dpath + '/listfile_async_000.txt';
      let fpath2 = dpath + '/listfile_async_000.doc';
      let fpath3 = dpath + '/listfile_async_000.png';
      fileIO.mkdirSync(dpath);
      expect(prepareFile(fpath1, FILE_CONTENT)).assertTrue();
      expect(prepareFile(fpath2, FILE_CONTENT)).assertTrue();
      expect(prepareFile(fpath3, FILE_CONTENT)).assertTrue();
      try {
        fileIO.listFile(dpath, (err, dirents) => {
          if (err) {
            console.log('fileIO_test_listfile_async_000 err package ' + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(dirents.length == 3).assertTrue();
          fileIO.rmdirSync(dpath);
        });
      } catch (e) {
        console.log('fileIO_test_listfile_async_000 has failed for ' + e.message + ', code:' + e.code);
        expect(false).assertTrue();
      }
    });
    /**
     * @tc.number SUB_DF_FILEIO_LISTFILE_ASYNC_0100
     * @tc.name fileIO_test_listfile_async_001
     * @tc.desc Test listFile() interface. Promise.
     * Only path, do not filter file.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_listfile_async_001', Level.LEVEL3, async (done: Function) => {
      let dpath = await nextFileName('fileIO_test_listfile_async_001');
      let fpath1 = dpath + '/listfile_async_001.txt';
      let fpath2 = dpath + '/listfile_async_001_1.doc';
      let fpath3 = dpath + '/listfile_async_001.png';
      fileIO.mkdirSync(dpath);
      expect(prepareFile(fpath1, FILE_CONTENT)).assertTrue();
      expect(prepareFile(fpath2, FILE_CONTENT)).assertTrue();
      expect(prepareFile(fpath3, FILE_CONTENT)).assertTrue();
      try {
        let dirents = await fileIO.listFile(dpath);
        expect(dirents.length == 3).assertTrue();
        fileIO.rmdirSync(dpath);
        done();
      } catch (err) {
        console.log('fileIO_test_listfile_async_001 has failed for ' + err.message + ', code:' + err.code);
        expect(false).assertTrue();
      }
    });
    /**
     * @tc.number SUB_DF_FILEIO_LISTFILE_ASYNC_2100
     * @tc.name fileIO_test_listfile_async_021
     * @tc.desc Test listFile() interfaces. Callback.
     * Undefined option arguments, use default options.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_listfile_async_021', Level.LEVEL3, async () => {
      let dpath = await nextFileName('fileIO_test_listfile_async_021');
      let ddpath = dpath + '/second_dir';
      let fpath1 = dpath + '/listfile_async_021.txt';
      let fpath2 = dpath + '/listfile_async_021.doc';
      let fpath3 = dpath + '/listfile_async_021.png';
      let ffpath1 = ddpath + '/listfile_sync_second_021.txt';
      let ffpath2 = ddpath + '/listfile_sync_second_021.doc';
      fileIO.mkdirSync(dpath);
      fileIO.mkdirSync(ddpath);
      expect(prepareFile(fpath1, FILE_CONTENT)).assertTrue();
      expect(prepareFile(fpath2, FILE_CONTENT)).assertTrue();
      expect(prepareFile(fpath3, FILE_CONTENT)).assertTrue();
      expect(prepareFile(ffpath1, FILE_CONTENT)).assertTrue();
      expect(prepareFile(ffpath2, FILE_CONTENT)).assertTrue();
      try {
        fileIO.listFile(dpath, undefined, (err, dirents) => {
          if (err) {
            console.log('fileIO_test_listfile_async_021 err package ' + JSON.stringify(err));
            expect(false).assertTrue();
          }
          expect(dirents.length == 4).assertTrue();
          fileIO.rmdirSync(dpath);
        });
      } catch (e) {
        console.log('fileIO_test_listfile_async_021 has failed for ' + e.message + ', code:' + e.code);
        expect(false).assertTrue();
      }
    });
    /**
     * @tc.number SUB_DF_FILEIO_LISTFILE_ASYNC_2300
     * @tc.name fileIO_test_listfile_async_023
     * @tc.desc Test listFile() interfaces. Promise.
     * Undefined option arguments, use default options.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_listfile_async_023', Level.LEVEL3, async (done: Function) => {
      let dpath = await nextFileName('fileIO_test_listfile_async_023');
      let ddpath = dpath + '/second_dir';
      let fpath1 = dpath + '/listfile_async_023.txt';
      let fpath2 = dpath + '/listfile_async_023.doc';
      let fpath3 = dpath + '/listfile_async_023.png';
      let ffpath1 = ddpath + '/listfile_sync_second_023.txt';
      let ffpath2 = ddpath + '/listfile_sync_second_023.doc';
      fileIO.mkdirSync(dpath);
      fileIO.mkdirSync(ddpath);
      expect(prepareFile(fpath1, FILE_CONTENT)).assertTrue();
      expect(prepareFile(fpath2, FILE_CONTENT)).assertTrue();
      expect(prepareFile(fpath3, FILE_CONTENT)).assertTrue();
      expect(prepareFile(ffpath1, FILE_CONTENT)).assertTrue();
      expect(prepareFile(ffpath2, FILE_CONTENT)).assertTrue();
      try {
        let dirents = await fileIO.listFile(dpath, undefined);
        expect(dirents.length == 4).assertTrue();
        fileIO.rmdirSync(dpath);
        done();
      } catch (err) {
        console.log('fileIO_test_listfile_async_023 has failed for ' + err.message + ', code:' + err.code);
        expect(false).assertTrue();
      }
    });
    /**
     * @tc.number SUB_DF_FILEIO_LISTFILE_ASYNC_2600
     * @tc.name fileIO_test_listfile_async_026
     * @tc.desc Test listFile() interface. Callback.
     * No such file or directory.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_listfile_async_026', Level.LEVEL0, async () => {
      let dpath = await nextFileName('fileIO_test_listfile_async_026');
      try {
        fileIO.listFile(dpath, (err, dirents) => {
          if (err) {
            console.log('fileIO_test_listfile_async_026 err package ' + err.message + ', code:' + err.code);
            expect(err.code == 13900002 && err.message == 'No such file or directory').assertTrue();
          }
        });
      } catch (e) {
        console.log('fileIO_test_listfile_async_026 has failed for ' + e.message + ', code:' + e.code);
        expect(false).assertTrue();
      }
    });
    /**
     * @tc.number SUB_DF_FILEIO_LISTFILE_ASYNC_2700
     * @tc.name fileIO_test_listfile_async_027
     * @tc.desc Test listFile() interface. Promise.
     * No such file or directory.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_listfile_async_027', Level.LEVEL3, async () => {
      let dpath = await nextFileName('fileIO_test_listfile_async_027');
      let osName: string = deviceInfo.osFullName;
      if (osName.startsWith('Android')) {
        try {
          await fileIO.listFile(dpath);
          expect(false).assertTrue();
        } catch (err) {
          console.log('fileIO_test_listfile_async_027 has failed for ' + err.message + ', code:' + err.code);
          expect(err.code == 13900002 && err.message == 'No such file or directory').assertTrue();
        }
      }
    });
    /**
     * @tc.number SUB_DF_FILEIO_LISTFILE_ASYNC_2800
     * @tc.name fileIO_test_listfile_async_028
     * @tc.desc Test listFile() interface. Promise.
     * Not a directory.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_listfile_async_028', Level.LEVEL3, async () => {
      let dpath = await nextFileName('fileIO_test_listfile_async_028');
      expect(prepareFile(dpath, FILE_CONTENT)).assertTrue();
      let osName: string = deviceInfo.osFullName;
      if (osName.startsWith('Android')) {
        try {
          await fileIO.listFile(dpath);
          expect(false).assertTrue();
        } catch (err) {
          console.log('fileIO_test_listfile_async_028 has failed for ' + err.message + ', code:' + err.code);
          expect(err.code == 13900018 && err.message == 'Not a directory').assertTrue();
        }
      }
    });
    /**
     * @tc.number SUB_DF_FILEIO_LISTFILE_ASYNC_2900
     * @tc.name fileIO_test_listfile_async_029
     * @tc.desc Test listFile() interface. Callback.
     * Not a directory.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_listfile_async_029', Level.LEVEL0, async () => {
      let dpath = await nextFileName('fileIO_test_listfile_async_029');
      expect(prepareFile(dpath, FILE_CONTENT)).assertTrue();
      try {
        fileIO.listFile(dpath, (err, dirents) => {
          if (err) {
            console.log('fileIO_test_listfile_async_029 err package ' + err.message + ', code:' + err.code);
            expect(err.code == 13900018 && err.message == 'Not a directory').assertTrue();
          }
        });
      } catch (e) {
        console.log('fileIO_test_listfile_async_026 has failed for ' + e.message + ', code:' + e.code);
        expect(false).assertTrue();
      }
    });
  });
}
