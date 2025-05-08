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

import { fileIO, FILE_CONTENT, prepareFile, nextFileName, describe, it, expect, } from '../Common';
import { Level } from '@ohos/hypium';

export default function fileIOStreamFlush() {
  describe('fileIO_fs_stream_flush', () => {
    /**
     * @tc.number SUB_DF_FILEIO_STREAM_FLUSH_SYNC_0000
     * @tc.name fileIO_test_stream_flush_sync_000
     * @tc.desc Test the flushSync() interface of class Stream.
     * Refresh file stream.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_stream_flush_sync_000', Level.LEVEL0, async () => {
      let fPath = await nextFileName('fileIO_test_stream_flush_sync_000');
      expect(prepareFile(fPath, FILE_CONTENT)).assertTrue();
      try {
        let sr = fileIO.createStreamSync(fPath, 'r+');
        expect(sr !== null).assertTrue();
        expect(sr.writeSync(FILE_CONTENT) == FILE_CONTENT.length).assertTrue();
        sr.flushSync();
        sr.closeSync();
        fileIO.unlinkSync(fPath);
      } catch (e) {
        console.log('fileIO_test_stream_flush_sync_000 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });
    /**
     * @tc.number SUB_DF_FILEIO_STREAM_FLUSH_ASYNC_0000
     * @tc.name fileIO_test_stream_flush_async_000
     * @tc.desc Test the flush() interface of class Stream. Promise.then().catch()
     * Refresh the file stream.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_stream_flush_async_000', Level.LEVEL0, async (done: Function) => {
       let fPath = await nextFileName('fileIO_test_stream_flush_async_000');
       expect(prepareFile(fPath, FILE_CONTENT)).assertTrue();
       try {
         let sr = await fileIO.createStreamSync(fPath, 'r+');
         expect(sr !== null).assertTrue();
         expect(sr.writeSync(FILE_CONTENT) == FILE_CONTENT.length).assertTrue();
         sr.flush().then(() => {
           sr.closeSync();
           fileIO.unlinkSync(fPath);
           done();
         }).catch((err: Error) => {
           console.log('fileIO_test_stream_flush_async_000 error package' + JSON.stringify(err));
           expect(false).assertTrue();
         });
       } catch (e) {
         console.log('fileIO_test_stream_flush_async_000 has failed for ' + e.message + ', code: ' + e.code);
         expect(false).assertTrue();
       }
    });
    /**
     * @tc.number SUB_DF_FILEIO_STREAM_FLUSH_ASYNC_0100
     * @tc.name fileIO_test_stream_flush_async_001
     * @tc.desc Test the flush() interface of class Stream. Callback.
     * Refresh the file stream.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_stream_flush_async_001', Level.LEVEL0, async (done: Function) => {
      let fPath = await nextFileName('fileIO_test_stream_flush_async_001');
      expect(prepareFile(fPath, FILE_CONTENT)).assertTrue();
      try {
        let sr = await fileIO.createStreamSync(fPath, 'r+');
        expect(sr !== null).assertTrue();
        expect(sr.writeSync(FILE_CONTENT) == FILE_CONTENT.length).assertTrue();
        sr.flush((err) => {
          if (err) {
            console.log('fileIO_test_stream_flush_async_001 error package' + JSON.stringify(err));
            expect(false).assertTrue();
          }
          sr.closeSync();
          fileIO.unlinkSync(fPath);
          done();
        });
      } catch (e) {
        console.log('fileIO_test_stream_flush_async_001 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });
  });
}
