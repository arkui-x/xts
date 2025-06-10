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
  fileIO, FILE_CONTENT, prepareFile, nextFileName, isIntNum, isBigInt, isBoolean,
  describe, it, expect,
} from '../Common';
import { Level } from '@ohos/hypium';

export default function fileIOLstat() {
  describe('fileIO_lstat', () => {

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_SYNC_0000
     * @tc.name fileIO_lstat_sync_000
     * @tc.desc Test Lstat.lstatSync() interface.
     * This interface shall work properly in normal case.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_sync_000', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_sync_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = fileIO.lstatSync(fpath);
        expect(stat !== null).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_sync_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_SYNC_0010
     * @tc.name fileIO_lstat_sync_001
     * @tc.desc Test Lstat.lstatSync() interface.
     * This interface shall throw an exception when the file isnt's exist.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_sync_001', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_sync_001');

      try {
        fileIO.lstatSync(fpath);
        expect(null).assertFail();
      } catch (e) {
        console.log('fileIO_lstat_sync_001 has failed for ' + e);
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_INO_0000
     * @tc.name fileIO_lstat_ino_000
     * @tc.desc Test the ino member of class Lstat
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_ino_000', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_ino_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
      try {
        let stat = fileIO.lstatSync(fpath);
        expect(isBigInt(stat.ino)).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_ino_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_MODE_0000
     * @tc.name fileIO_lstat_mode_000
     * @tc.desc Test the mode member of class Lstat
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_mode_000', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_mode_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = fileIO.lstatSync(fpath);
        expect(isIntNum(stat.mode)).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_mode_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_UID_0000
     * @tc.name fileIO_lstat_uid_000
     * @tc.desc Test the uid member of class Lstat
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_uid_000', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_uid_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = fileIO.lstatSync(fpath);
        expect(isIntNum(stat.uid)).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_uid_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_GID_0000
     * @tc.name fileIO_lstat_gid_000
     * @tc.desc Test the gid member of class Lstat
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_gid_000', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_gid_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = fileIO.lstatSync(fpath);
        expect(isIntNum(stat.gid)).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_gid_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_SIZE_0000
     * @tc.name fileIO_lstat_size_000
     * @tc.desc Test the size member of class Lstat
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_size_000', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_size_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = fileIO.lstatSync(fpath);
        expect(isIntNum(stat.size)).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_size_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ATIME_0000
     * @tc.name fileIO_lstat_atime_000
     * @tc.desc Test the atime member of class Lstat
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_atime_000', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_atime_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = fileIO.lstatSync(fpath);
        expect(isIntNum(stat.atime)).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_atime_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_MTIME_0000
     * @tc.name fileIO_lstat_mtime_000
     * @tc.desc Test the mtime member of class Lstat
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_mtime_000', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_mtime_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = fileIO.lstatSync(fpath);
        expect(isIntNum(stat.mtime)).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_mtime_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_CTIME_0000
     * @tc.name fileIO_lstat_ctime_000
     * @tc.desc Test the ctime member of class Lstat
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_ctime_000', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_ctime_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = fileIO.lstatSync(fpath);
        expect(isIntNum(stat.ctime)).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_ctime_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_IS_BLOCK_DEVICE_0000
     * @tc.name fileIO_lstat_is_block_device_000
     * @tc.desc Test the isBlockDevice() method of class Lstat.
     * This interface shall return a boolean variable.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_is_block_device_000', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_is_block_device_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = fileIO.lstatSync(fpath);
        expect(isBoolean(stat.isBlockDevice())).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_is_block_device_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_IS_BLOCK_DEVICE_0010
     * @tc.name fileIO_lstat_is_block_device_001
     * @tc.desc Test the isBlockDevice() method of class Lstat.
     * This interface shall not treat a normal file as a block special device.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_is_block_device_001', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_is_block_device_001');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = fileIO.lstatSync(fpath);
        expect(stat.isBlockDevice() === false).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_is_block_device_001 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_IS_CHARACTER_DEVICE_0000
     * @tc.name fileIO_lstat_is_character_device_000
     * @tc.desc Test Lstat.isCharacterDevice() interface.
     * This interface shall return a boolean variable.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_is_character_device_000', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_is_character_device_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = fileIO.lstatSync(fpath);
        expect(isBoolean(stat.isCharacterDevice())).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_is_character_device_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_IS_CHARACTER_DEVICE_0010
     * @tc.name fileIO_lstat_is_character_device_001
     * @tc.desc Test Lstat.isCharacterDevice() interface.
     * This interface shall not treat a normal file as a character special device.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_is_character_device_001', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_is_character_device_001');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = fileIO.lstatSync(fpath);
        expect(stat.isCharacterDevice() === false).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_is_character_device_001 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_IS_DIRECTORY_0000
     * @tc.name fileIO_lstat_is_directory_000
     * @tc.desc Test Lstat.isDirectory() interface.
     * This interface shall return a boolean variable.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_is_directory_000', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_is_directory_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = fileIO.lstatSync(fpath);
        expect(isBoolean(stat.isDirectory())).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_is_directory_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_IS_DIRECTORY_0010
     * @tc.name fileIO_lstat_is_directory_001
     * @tc.desc Test Lstat.isDirectory() interface.
     * This interface shall not treat a normal file as a directory.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_is_directory_001', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_is_directory_001');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = fileIO.lstatSync(fpath);
        expect(stat.isDirectory() === false).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_is_directory_001 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_IS_DIRECTORY_0020
     * @tc.name fileIO_lstat_is_directory_002
     * @tc.desc Test Lstat.isDirectory() interface.
     * This interface shall not treat a normal file as a directory.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_is_directory_002', Level.LEVEL0, async () => {
      let dpath = await nextFileName('fileIO_lstat_is_directory_002') + 'd';

      try {
        expect(fileIO.mkdirSync(dpath) == null).assertTrue();
        let stat = fileIO.lstatSync(dpath);
        expect(stat.isDirectory()).assertTrue();
        expect(fileIO.rmdirSync(dpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_is_directory_002 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_IS_FIFO_0000
     * @tc.name fileIO_lstat_is_fifo_000
     * @tc.desc Test Lstat.isFIFO() interface.
     * This interface shall return a boolean variable.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_is_fifo_000', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_is_fifo_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = fileIO.lstatSync(fpath);
        expect(isBoolean(stat.isFIFO())).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_is_fifo_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_IS_FIFO_0010
     * @tc.name fileIO_lstat_is_fifo_001
     * @tc.desc Test Lstat.isFIFO() interface.
     * This interface shall not treat a normal file as a FIFO.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_is_fifo_001', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_is_fifo_001');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = fileIO.lstatSync(fpath);
        expect(stat.isFIFO() === false).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_is_fifo_001 has failed for ' + e);
        expect(null).assertFail();
      }
    });


    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_IS_FILE_0000
     * @tc.name fileIO_lstat_is_file_000
     * @tc.desc Test Lstat.isFile() interface.
     * This interface shall return a boolean variable.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_is_file_000', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_is_file_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = fileIO.lstatSync(fpath);
        expect(isBoolean(stat.isFile())).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_is_file_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_IS_FILE_0010
     * @tc.name fileIO_lstat_is_file_001
     * @tc.desc Test Lstat.isFile() interface.
     * This interface shall treat a normal file as a normal file.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_is_file_001', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_is_file_001');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = fileIO.lstatSync(fpath);
        expect(stat.isFile()).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_is_file_001 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_IS_FILE_0020
     * @tc.name fileIO_lstat_is_file_002
     * @tc.desc Test Lstat.isFile() interface.
     * This interface shall not treat a directory as a normal file.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_is_file_002', Level.LEVEL0, async () => {
      let dpath = await nextFileName('fileIO_lstat_is_file_002');

      try {
        expect(fileIO.mkdirSync(dpath) == null).assertTrue();
        let stat = fileIO.lstatSync(dpath);
        expect(stat.isFile() === false).assertTrue();
        expect(fileIO.rmdirSync(dpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_is_file_002 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_IS_SOCKET_0000
     * @tc.name fileIO_lstat_is_socket_000
     * @tc.desc Test Lstat.isSocket() interface.
     * This interface shall return a boolean variable.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_is_socket_000', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_is_socket_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = fileIO.lstatSync(fpath);
        expect(isBoolean(stat.isSocket())).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_is_socket_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_IS_SOCKET_0010
     * @tc.name fileIO_lstat_is_socket_001
     * @tc.desc Test Lstat.isSocket() interface.
     * This interface shall not treat a file as a socket.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_is_socket_001', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_is_socket_001');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = fileIO.lstatSync(fpath);
        expect(stat.isSocket() === false).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_is_socket_001 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_IS_SYMBOLIC_LINK_0000
     * @tc.name fileIO_lstat_is_symbolic_link_000
     * @tc.desc Test Lstat.isSymbolicLink() interface.
     * This interface shall return a boolean variable.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_is_symbolic_link_000', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_is_symbolic_link_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = fileIO.lstatSync(fpath);
        expect(isBoolean(stat.isSymbolicLink())).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_is_symbolic_link_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_IS_SYMBOLIC_LINK_0010
     * @tc.name fileIO_lstat_is_symbolic_link_001
     * @tc.desc Test Lstat.isSymbolicLink() interface.
     * This interface shall not treat a normal file as a symbolic link.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_is_symbolic_link_001', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_lstat_is_symbolic_link_001');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = fileIO.lstatSync(fpath);
        expect(stat.isSymbolicLink() === false).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_lstat_is_symbolic_link_001 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_0000
     * @tc.name fileIO_lstat_async_000
     * @tc.desc Test Stat.lstatAsync() interface.
     * This interface shall work properly in normal case when providing the promise async model.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_000', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        fileIO.lstat(fpath).then((stat) => {
          expect(stat !== null).assertTrue();
          expect(fileIO.unlinkSync(fpath) == null).assertTrue();
        });
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_0010
     * @tc.name fileIO_lstat_async_001
     * @tc.desc Test Stat.lstatAsync() interface.
     * This interface shall work properly in normal case when providing the callback async model.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_001', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_001');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        fileIO.lstat(fpath,  (error)=> {
          expect(fileIO.unlinkSync(fpath) == null).assertTrue();
          done();
        });
      } catch (e) {
        console.log('fileIO_lstat_async_001 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_0020
     * @tc.name fileIO_lstat_async_002
     * @tc.desc Test Stat.lstatAsync() interface.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_002', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_002');

      try {
        fileIO.lstat(fpath,   (error)=> {
          done();
        });
      } catch (e) {
        console.log('fileIO_lstat_async_002 has failed for ' + e);
        expect(!!e).assertTrue();
        done();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_INO_0000
     * @tc.name fileIO_lstat_async_ino_000
     * @tc.desc Test the ino member of class Lstat.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_ino_000', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_ino_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = await fileIO.lstat(fpath);
        expect(isBigInt(stat.ino)).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_ino_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_MODE_0000
     * @tc.name fileIO_lstat_async_mode_000
     * @tc.desc Test the mode member of class Lstat.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_mode_000', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_mode_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = await fileIO.lstat(fpath);
        expect(isIntNum(stat.mode)).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_mode_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_UID_0000
     * @tc.name fileIO_lstat_async_uid_000
     * @tc.desc Test the uid member of class Lstat.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_uid_000', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_uid_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = await fileIO.lstat(fpath);
        expect(isIntNum(stat.uid)).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_uid_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_GID_0000
     * @tc.name fileIO_lstat_async_gid_000
     * @tc.desc Test the gid member of class Lstat.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_gid_000', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_gid_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = await fileIO.lstat(fpath);
        expect(isIntNum(stat.gid)).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_gid_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_SIZE_0000
     * @tc.name fileIO_lstat_async_size_000
     * @tc.desc Test the size member of class lstat.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_size_000', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_size_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = await fileIO.lstat(fpath);
        expect(isIntNum(stat.size)).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_size_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_ATIME_0000
     * @tc.name fileIO_lstat_async_atime_000
     * @tc.desc Test lstat.atime() interface.
     * @tc.desc Test the atime member of class lstat.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_atime_000', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_atime_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = await fileIO.lstat(fpath);
        expect(isIntNum(stat.atime)).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_atime_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_MTIME_0000
     * @tc.name fileIO_lstat_async_mtime_000
     * @tc.desc Test lstat.mtime() interface.
     * @tc.desc Test the mtime member of class lstat.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_mtime_000', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_mtime_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = await fileIO.lstat(fpath);
        expect(isIntNum(stat.mtime)).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_mtime_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_CTIME_0000
     * @tc.name fileIO_lstat_async_ctime_000
     * @tc.desc Test the ctime member of class lstat.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_ctime_000', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_ctime_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = await fileIO.lstat(fpath);
        expect(isIntNum(stat.ctime)).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_ctime_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_IS_BLOCK_DEVICE_0000
     * @tc.name fileIO_lstat_async_is_block_device_000
     * @tc.desc Test the isBlockDevice method of class lstat.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_is_block_device_000', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_is_block_device_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = await fileIO.lstat(fpath);
        expect(isBoolean(stat.isBlockDevice())).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_is_block_device_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_IS_BLOCK_DEVICE_0010
     * @tc.name fileIO_lstat_async_is_block_device_001
     * @tc.desc Test the isBlockDevice method of class lstat.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_is_block_device_001', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_is_block_device_001');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = await fileIO.lstat(fpath);
        expect(stat.isBlockDevice() === false).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_is_block_device_001 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_IS_CHARACTER_DEVICE_0000
     * @tc.name fileIO_lstat_async_is_character_device_000
     * @tc.desc Test the isCharacterDevice method of class lstat.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_is_character_device_000', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_is_character_device_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = await fileIO.lstat(fpath);
        expect(isBoolean(stat.isCharacterDevice())).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_is_character_device_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_IS_CHARACTER_DEVICE_0010
     * @tc.name fileIO_lstat_async_is_character_device_001
     * @tc.desc Test the isCharacterDevice method of class lstat.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_is_character_device_001', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_is_character_device_001');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = await fileIO.lstat(fpath);
        expect(stat.isCharacterDevice() === false).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_is_character_device_001 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_IS_DIRECTORY_0000
     * @tc.name fileIO_lstat_async_is_directory_000
     * @tc.desc Test lstat.isDirectory() interface.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_is_directory_000', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_is_directory_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = await fileIO.lstat(fpath);
        expect(isBoolean(stat.isDirectory())).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_is_directory_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_IS_DIRECTORY_0010
     * @tc.name fileIO_lstat_async_is_directory_001
     * @tc.desc Test lstat.isDirectory() interface.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_is_directory_001', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_is_directory_001');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = await fileIO.lstat(fpath);
        expect(stat.isDirectory() === false).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_is_directory_001 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_IS_DIRECTORY_0020
     * @tc.name fileIO_lstat_async_is_directory_002
     * @tc.desc Test lstat.isDirectory() interface.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_is_directory_002', Level.LEVEL0, async (done: Function) => {
      let dpath = await nextFileName('fileIO_lstat_async_is_directory_002') + 'd';

      try {
        expect(fileIO.mkdirSync(dpath) == null).assertTrue();
        let stat = await fileIO.lstat(dpath);
        expect(stat.isDirectory()).assertTrue();
        expect(fileIO.rmdirSync(dpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_is_directory_002 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_IS_FIFO_0000
     * @tc.name fileIO_lstat_async_is_fifo_000
     * @tc.desc Test lstat.isFIFO() interface.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_is_fifo_000', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_is_fifo_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = await fileIO.lstat(fpath);
        expect(isBoolean(stat.isFIFO())).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_is_fifo_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_IS_FIFO_0010
     * @tc.name fileIO_lstat_async_is_fifo_001
     * @tc.desc Test lstat.isFIFO() interface.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_is_fifo_001', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_is_fifo_001');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = await fileIO.lstat(fpath);
        expect(stat.isFIFO() === false).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_is_fifo_001 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_IS_FILE_0000
     * @tc.name fileIO_lstat_async_is_file_000
     * @tc.desc Test lstat.isFile() interface.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_is_file_000', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_is_file_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = await fileIO.lstat(fpath);
        expect(isBoolean(stat.isFile())).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_is_file_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_IS_FILE_0010
     * @tc.name fileIO_lstat_async_is_file_001
     * @tc.desc Test lstat.isFile() interface.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_is_file_001', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_is_file_001');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = await fileIO.lstat(fpath);
        expect(stat.isFile()).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_is_file_001 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_IS_FILE_0020
     * @tc.name fileIO_lstat_async_is_file_002
     * @tc.desc Test lstat.isFile() interface.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_is_file_002', Level.LEVEL0, async (done: Function) => {
      let dpath = await nextFileName('fileIO_lstat_async_is_file_002');

      try {
        expect(fileIO.mkdirSync(dpath) == null).assertTrue();
        let stat = await fileIO.lstat(dpath);
        expect(stat.isFile() === false).assertTrue();
        expect(fileIO.rmdirSync(dpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_is_file_002 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_IS_SOCKET_0000
     * @tc.name fileIO_lstat_async_is_socket_000
     * @tc.desc Test lstat.isSocket() interface.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_is_socket_000', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_is_socket_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = await fileIO.lstat(fpath);
        expect(isBoolean(stat.isSocket())).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_is_socket_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_IS_SOCKET_0010
     * @tc.name fileIO_lstat_async_is_socket_001
     * @tc.desc Test lstat.isSocket() interface.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_is_socket_001', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_is_socket_001');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = await fileIO.lstat(fpath);
        expect(stat.isSocket() === false).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_is_socket_001 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_IS_SYMBOLIC_LINK_0000
     * @tc.name fileIO_lstat_async_is_symbolic_link_000
     * @tc.desc Test lstat.isSymbolicLink() interface.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_is_symbolic_link_000', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_is_symbolic_link_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = await fileIO.lstat(fpath);
        expect(isBoolean(stat.isSymbolicLink())).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_is_symbolic_link_000 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_LSTAT_ASYNC_IS_SYMBOLIC_LINK_0010
     * @tc.name fileIO_lstat_async_is_symbolic_link_001
     * @tc.desc Test lstat.isSymbolicLink() interface.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_lstat_async_is_symbolic_link_001', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_lstat_async_is_symbolic_link_001');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = await fileIO.lstat(fpath);
        expect(stat.isSymbolicLink() === false).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
        done();
      } catch (e) {
        console.log('fileIO_lstat_async_is_symbolic_link_001 has failed for ' + e);
        expect(null).assertFail();
      }
    });

    /**
     * @tc.number SUB_DF_FILEIO_APPEND_FILE_SYNC_0010
     * @tc.name fileIO_test_append_file_sync_000
     * @tc.desc Test lstat.lstatSync() interface.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_append_file_sync_000', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_test_append_file_sync_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let stat = fileIO.lstatSync(fpath);
        expect(isIntNum(stat.size)).assertTrue();

        let file = fileIO.openSync(fpath, 0o2002);
        expect(isIntNum(file.fd)).assertTrue();

        expect(fileIO.writeSync(file.fd, FILE_CONTENT) == FILE_CONTENT.length).assertTrue();
        expect(fileIO.closeSync(file) == null).assertTrue();

        stat = fileIO.lstatSync(fpath);
        expect(stat.size == FILE_CONTENT.length * 2).assertTrue();
        expect(fileIO.unlinkSync(fpath) == null).assertTrue();
      } catch (e) {
        console.log('fileIO_test_append_file_sync_000 has failed for ' + e);
        expect(null).assertFail();
      }
      done();
    });
  });}
