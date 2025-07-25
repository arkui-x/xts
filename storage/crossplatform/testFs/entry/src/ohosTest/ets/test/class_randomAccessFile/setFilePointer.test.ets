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
  fileIO, FILE_CONTENT, prepareFile, nextFileName, describe, it, expect
} from '../Common';
import { Level } from '@ohos/hypium';

export default function fileIORandomAccessFileSetFilePointer() {
  describe('fileIO_randomAccessFile_setFilePointer', () => {

    /**
     * @tc.number SUB_STORAGE_FILEIO_RANDOMACCESSFILE_SET_FILE_POINTER_SYNC_0000
     * @tc.name fileIO_randomaccessfile_set_file_pointer_sync_000
     * @tc.desc Test setFilePointer() interface. Set file offset pointer position and read will start from filePointer + offset
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_randomaccessfile_set_file_pointer_sync_000', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_randomaccessfile_set_file_pointer_sync_000');
      expect(prepareFile(fpath, FILE_CONTENT)).assertTrue();

      try {
        let randomaccessfile = fileIO.createRandomAccessFileSync(fpath, fileIO.OpenMode.CREATE | fileIO.OpenMode.READ_WRITE);
        expect(randomaccessfile.filePointer == 0).assertTrue();
        let initFilePointer = 5;
        randomaccessfile.setFilePointer(initFilePointer);
        expect(randomaccessfile.filePointer == initFilePointer).assertTrue();

        let initOffset = 5;
        let readLen = randomaccessfile.readSync(new ArrayBuffer(4096), { offset: initOffset });
        expect(readLen == FILE_CONTENT.length - initFilePointer - initOffset).assertTrue();

        randomaccessfile.close();
        fileIO.unlinkSync(fpath);
        done();
      } catch(err) {
        console.info('fileIO_randomaccessfile_set_file_pointer_sync_000 has failed for ' + err);
        expect(false).assertTrue();
        done();
      }
    });
  })
}