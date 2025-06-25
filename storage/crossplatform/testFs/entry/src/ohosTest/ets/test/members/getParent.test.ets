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
  fileIO, FILE_CONTENT, prepareFile, nextFileName, isIntNum, describe, it, expect,
} from '../Common';

import { Level } from '@ohos/hypium';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';

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
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
      let context = abilityDelegator.getAppContext();
      let data = context.filesDir;
      let parentDir =  'testDir001';
      let testDir = await data + '/' + parentDir;
      fileIO.mkdirSync(testDir);
      let fpath = testDir + '/test001.txt'

      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let file = fileIO.openSync(fpath, fileIO.OpenMode.READ_WRITE);
        expect(isIntNum(file.fd)).assertTrue();

        let file_path : string = file.getParent();
        let index = file_path.lastIndexOf("\/");
        let str = file_path.substring(index + 1);

        expect(str == parentDir).assertTrue();
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
      let abilityDelegator = AbilityDelegatorRegistry.getAbilityDelegator();
      let context = abilityDelegator.getAppContext();
      let data = context.filesDir;
      let parentDir =  'testDir002';
      let testDir = await data + '/' + parentDir;
      fileIO.mkdirSync(testDir);
      let fpath = testDir + '/test002.txt'

      try {
        let file = fileIO.openSync(fpath, fileIO.OpenMode.READ_WRITE | fileIO.OpenMode.CREATE);
        expect(isIntNum(file.fd)).assertTrue();

        let file_path : string = file.getParent();
        let index = file_path.lastIndexOf("\/");
        let str = file_path.substring(index + 1);

        expect(str == parentDir).assertTrue();
        fileIO.closeSync(file);
        fileIO.unlinkSync(fpath);
      } catch (e) {
        console.log('fileIO_test_filegetParent_002 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });
  });
}
