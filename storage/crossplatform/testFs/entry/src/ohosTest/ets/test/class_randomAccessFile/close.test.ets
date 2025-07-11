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
  fileIO, nextFileName,
  describe, it, expect
} from '../Common';
import { Level } from '@ohos/hypium';

export default function fileIORandomAccessFileClose() {
  describe('fileIO_randomAccessFile_close', () => {

    /**
     * @tc.number SUB_STORAGE_FILEIO_RANDOMACCESSFILE_CLOSE_SYNC_0000
     * @tc.name fileIO_randomaccessfile_close_sync_000
     * @tc.desc Test close() interface. Close the RandomAccessFile object.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_randomaccessfile_close_sync_000', Level.LEVEL0, async (done: Function) => {
      let fpath = await nextFileName('fileIO_randomaccessfile_close_sync_000');

      try {
        let randomaccessfile = fileIO.createRandomAccessFileSync(fpath, fileIO.OpenMode.CREATE | fileIO.OpenMode.READ_WRITE);
        randomaccessfile.close();
        fileIO.unlinkSync(fpath);
        done();
      } catch(err) {
        console.info('fileIO_randomaccessfile_close_sync_000 has failed for ' + err);
        expect(false).assertTrue();
        done();
      }
    });
  })
}