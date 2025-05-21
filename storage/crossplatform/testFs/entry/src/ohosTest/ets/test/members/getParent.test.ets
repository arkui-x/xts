/*
 * Copyright (C) 2023 Huawei Device Co., Ltd.
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
  fileIO, FILE_CONTENT, prepareFile, nextFileName, isIntNum, describe, it, expect,
} from '../Common';
import { Level } from '@ohos/hypium';

export default function fileIOFileGetParent() {
  describe('fileIO_fs_file_getParent', () => {

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_FILEGETPARENT_0100
     * @tc.name fileIO_test_filegetParent_001
     * @tc.desc Test getParent() interfaces.
     * Open the file, file getParent(),write content
     * @tc.size MEDIUM
     * @tc.type Functoin
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_filegetParent_001', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_test_filegetParent_001');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let file = fileIO.openSync(fpath, fileIO.OpenMode.READ_WRITE);
        expect(isIntNum(file.fd)).assertTrue();
        let file_path : string = file.path;
        let index = file_path.lastIndexOf("\/");
        let str = file_path.substring(0, index+1);
        str = str.slice(0, -1);
        expect(file.getParent() == str).assertTrue();
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
      } catch (e) {
        console.log('fileIO_test_filegetParent_001 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_FILEGETPARENT_0200
     * @tc.name fileIO_test_filegetParent_002
     * @tc.desc Test getParent() interfaces.
     * Open the file, file getParent(),without content
     * @tc.size MEDIUM
     * @tc.type Functoin
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_filegetParent_002', Level.LEVEL0, async () => {
      let fpath = await nextFileName('fileIO_test_filegetParent_002');

      try {
        let file = fileIO.openSync(fpath, fileIO.OpenMode.READ_WRITE | fileIO.OpenMode.CREATE);
        expect(isIntNum(file.fd)).assertTrue();
        let file_path : string = file.path;
        let index = file_path.lastIndexOf("\/");
        let str = file_path.substring(0, index+1);
        str = str.slice(0, -1);
        expect(file.getParent() == str).assertTrue();
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
      } catch (e) {
        console.log('fileIO_test_filegetParent_002 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });

    /**
     * @tc.number SUB_BASIC_FM_FileAPI_FileIOV9_FILEIO_FILEGETPARENT_0300
     * @tc.name fileIO_test_filegetParent_003
     * @tc.desc Test getParent() interfaces.
     * Open the file, file getParent(),fs.dup
     * @tc.size MEDIUM
     * @tc.type Functoin
     * @tc.level Level 3
     * @tc.require
     */
    it('fileIO_test_filegetParent_003', Level.LEVEL3, async () => {
      let fpath = await nextFileName('fileIO_test_filegetParent_003');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();
      try {
        let file = fileIO.openSync(fpath, fileIO.OpenMode.READ_WRITE);
        expect(isIntNum(file.fd)).assertTrue();
        let filenew = fileIO.dup(file.fd);
        expect(file.getParent() == filenew.getParent()).assertTrue();
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
      } catch (e) {
        console.log('fileIO_test_filegetParent_006 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });
  });
}
