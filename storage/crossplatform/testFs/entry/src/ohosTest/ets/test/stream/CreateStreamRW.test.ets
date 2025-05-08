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

import { fileIO, FILE_CONTENT, prepareFile, nextFileName, describe, it, expect, isIntNum } from '../Common';
import fs from '@ohos.file.fs';
import { TestType, Size, Level } from '@ohos/hypium';

export default function fileIOCreateStreamRW() {
  describe('streamReadWriteTest', () => {
    /**
     * @tc.number SUB_DF_FILEIO_CREATE_READSTREAM_0100
     * @tc.name fileIO_test_create_ReadStream_001
     * @tc.desc Test the createReadStream() interface of class Stream.
     * ReadStream reads files.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_create_ReadStream_001', Level.LEVEL0, async () => {
      let filePath = await nextFileName('fileIO_test_create_ReadStream_001');
      expect(prepareFile(filePath, FILE_CONTENT)).assertTrue();
      try {
        let rs = fs.createReadStream(filePath);
        let rsSize = 0;
        rs.on('readable', () => {
          let data = rs.read();
          if (data != null) {
            rsSize = rsSize + data.length;
            console.log('fileIO_test_create_ReadStream_001 content ' + data.slice(0, 10) + ', data.length: ' +
            data.length);
          }
          const filesize = fileIO.lstatSync(filePath).size;
          console.log('fileIO_test_create_ReadStream_001 rsSize ' + rsSize + ', filesize: ' + filesize);
          expect(rsSize == filesize).assertTrue();
        });
        fs.unlinkSync(filePath);
      } catch (e) {
        console.log('fileIO_test_create_ReadStream_001 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });
    /**
     * @tc.number SUB_DF_FILEIO_CREATE_READSTREAM_0200
     * @tc.name fileIO_test_create_ReadStream_002
     * @tc.desc Test the createReadStream() interface of class Stream.
     * ReadStream reads the file file area start end.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_create_ReadStream_002', Level.LEVEL0, async () => {
      let filePath = await nextFileName('fileIO_test_create_ReadStream_002');
      expect(prepareFile(filePath, FILE_CONTENT)).assertTrue();
      try {
        let start = 1;
        let end = 11;
        let rs = fs.createReadStream(filePath, { start, end });
        let rsSize = 0;
        rs.on('readable', () => {
          let data = rs.read();
          if (data != null) {
            rsSize = rsSize + data.length;
            console.log('fileIO_test_create_ReadStream_002 content ' + data.slice(0, 10) + ', data.length: ' +
            data.length);
          }

          const filesize = fileIO.lstatSync(filePath).size;
          console.log('fileIO_test_create_ReadStream_001 rsSize ' + rsSize + ', filesize: ' + filesize);
          expect(rsSize == end - start).assertTrue();
        });
        fs.unlinkSync(filePath);
      } catch (e) {
        console.log('fileIO_test_create_ReadStream_002 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });
    /**
     * @tc.number SUB_DF_FILEIO_CREATE_READSTREAM_0300
     * @tc.name fileIO_test_create_ReadStream_003
     * @tc.desc Test the createReadStream() interface of class Stream.
     * ReadStream automatically reads file.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_create_ReadStream_003', Level.LEVEL0, async () => {
      let filePath = await nextFileName('fileIO_test_create_ReadStream_003');
      expect(prepareFile(filePath, FILE_CONTENT)).assertTrue();
      try {
        let rs = fs.createReadStream(filePath);
        let rsSize = 0;
        rs.on('data', (emitData) => {
          let data = emitData?.data;
          if (data != undefined) {
            rsSize = rsSize + data?.length;
            console.log('fileIO_test_create_ReadStream_003 content ' + data.slice(0, 10) + ', data.length: ' +
              data?.length);
          }
          let filesize = fs.lstatSync(filePath).size;
          console.log('fileIO_test_create_ReadStream_003 rsSize ' + rsSize + ', filesize: ' + filesize);
          expect(rsSize == filesize).assertTrue();
        });
        fs.unlinkSync(filePath);
      } catch (e) {
        console.log('fileIO_test_create_ReadStream_003 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });
    /**
     * @tc.number SUB_DF_FILEIO_CREATE_READSTREAM_0400
     * @tc.name fileIO_test_create_ReadStream_004
     * @tc.desc Test the createReadStream() interface of class Stream.
     * Seek (set offset position) before ReadStream reads the file.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_create_ReadStream_004', Level.LEVEL0, async () => {
      let filePath = await nextFileName('fileIO_test_create_ReadStream_004');
      expect(prepareFile(filePath, FILE_CONTENT)).assertTrue();
      try {
        let seekPos = 4;
        let rs = fs.createReadStream(filePath);
        let rsSize = 0;
        rs.seek(seekPos);
        rs.on('data', (emitData) => {
          let data = emitData?.data;
          if (data != undefined) {
            rsSize = rsSize + data?.length;
            console.log('fileIO_test_create_ReadStream_004 content ' + data.slice(0, 10) + ', data.length: ' +
              data?.length);
          }
          let filesize = fs.lstatSync(filePath).size;
          console.log('fileIO_test_create_ReadStream_004 rsSize ' + rsSize + ', filesize-seekPos: ' + (filesize - seekPos));
          expect(rsSize == filesize - seekPos).assertTrue();
        });
        fs.unlinkSync(filePath);
      } catch (e) {
        console.log('fileIO_test_create_ReadStream_004 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });
    /**
     * @tc.number SUB_DF_FILEIO_CREATE_READSTREAM_0500
     * @tc.name fileIO_test_create_ReadStream_005
     * @tc.desc Test the createReadStream() interface of class Stream.
     * Stream copy file read. txt ->write.txt
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_create_ReadStream_005', Level.LEVEL0, async () => {
      let filePath = await nextFileName('fileIO_test_create_ReadStream_005');
      let wPath = await nextFileName('fileIO_test_create_ReadStream_00501');
      expect(prepareFile(filePath, FILE_CONTENT)).assertTrue();
      expect(prepareFile(wPath, '')).assertTrue();
      try {
        let rs = fs.createReadStream(filePath);
        let ws = fs.createWriteStream(wPath);
        let rsSize = 0;
        rs.on('readable', () => {
          let data = rs.read();
          if (data != null) {
            ws.write(data);
            rsSize = rsSize + data.length;
            console.log('fileIO_test_create_ReadStream_005 content ' + data.slice(0, 10) + ', data.length: ' +
              data?.length);
          }

          let filesize = fs.lstatSync(wPath).size;
          console.log('fileIO_test_create_ReadStream_005 rsSize ' + rsSize + ', filesize: ' + filesize);
          expect(rsSize == filesize).assertTrue();
        });
        fs.unlinkSync(filePath);
      } catch (e) {
        console.log('fileIO_test_create_ReadStream_005 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });
    /**
     * @tc.number SUB_DF_FILEIO_CREATE_READSTREAM_0600
     * @tc.name fileIO_test_create_ReadStream_006
     * @tc.desc Test the createReadStream() interface of class Stream.
     * Copy files on Stream and use close to release resources at the end
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_create_ReadStream_006', Level.LEVEL0, async () => {
      let filePath = await nextFileName('fileIO_test_create_ReadStream_006');
      let wPath = await nextFileName('fileIO_test_create_ReadStream_00601');
      expect(prepareFile(filePath, FILE_CONTENT)).assertTrue();
      expect(prepareFile(wPath, '')).assertTrue();
      try {
        let rs = fs.createReadStream(filePath);
        let ws = fs.createWriteStream(wPath);
        let rsSize = 0;
        rs.on('readable', () => {
          let data = rs.read();
          if (data != null) {
            ws.write(data);
            rsSize = rsSize + data.length;
            console.log('fileIO_test_create_ReadStream_006 content ' + data.slice(0, 10) + ', data.length: ' +
              data?.length);
          }

          let filesize = fs.lstatSync(wPath).size;
          console.log('fileIO_test_create_ReadStream_005 rsSize ' + rsSize + ', filesize: ' + filesize);
          expect(rsSize == filesize).assertTrue();
          rs.close();
          ws.close();
        });
        fs.unlinkSync(filePath);
      } catch (e) {
        console.log('fileIO_test_create_ReadStream_006 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });
    /**
     * @tc.number SUB_DF_FILEIO_CREATE_READSTREAM_0700
     * @tc.name fileIO_test_create_ReadStream_007
     * @tc.desc Test the createReadStream() interface of class Stream.
     * Invalid argument.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_create_ReadStream_007', Level.LEVEL0, async () => {
      try {
        let rs = fs.createReadStream(null);
        expect(false).assertTrue();
      } catch (e) {
        console.log('fileIO_test_create_ReadStream_007 has failed for ' + e.message + ', code: ' + e.code);
        expect(e.code == 13900020 && e.message == 'Invalid argument').assertTrue();
      }
    });
    /**
     * @tc.number SUB_DF_FILEIO_CREATE_READSTREAM_0800
     * @tc.name fileIO_test_create_ReadStream_008
     * @tc.desc Test the createReadStream() interface of class Stream.
     * No such file or directory.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_create_ReadStream_008', Level.LEVEL0, async () => {
      let filePath = await nextFileName('fileIO_test_create_ReadStream_008');
      try {
        let start = 1;
        let end = 11;
        let rs = fs.createReadStream(filePath, { start, end });
        expect(false).assertTrue();
      } catch (e) {
        console.log('fileIO_test_create_ReadStream_008 has failed for ' + e.message + ', code: ' + e.code);
        expect(e.code == 13900002 && e.message == 'No such file or directory').assertTrue();
      }
    });
    /**
     * @tc.number SUB_DF_FILEIO_CREATE_READSTREAM_0900
     * @tc.name fileIO_test_create_ReadStream_009
     * @tc.desc Test the createReadStream() interface of class Stream.
     * Invalid argument,createWriteStream
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_create_ReadStream_009', Level.LEVEL0, async () => {
      try {
        let ws = fs.createWriteStream(null);
        expect(false).assertTrue();
      } catch (e) {
        console.log('fileIO_test_create_ReadStream_009 has failed for ' + e.message + ', code: ' + e.code);
        expect(e.code == 13900020 && e.message == 'Invalid argument').assertTrue();
      }
    });
    /**
     * @tc.number SUB_DF_FILEIO_CREATE_READSTREAM_1000
     * @tc.name fileIO_test_create_ReadStream_010
     * @tc.desc Test the createReadStream() interface of class Stream.
     * ReadStream reads files.bytesRead
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_create_ReadStream_010', Level.LEVEL0, async () => {
      let filePath = await nextFileName('fileIO_test_create_ReadStream_010');
      expect(prepareFile(filePath, FILE_CONTENT)).assertTrue();
      try {
        let ReadStream = fs.createReadStream(filePath);
        let rb = ReadStream.bytesRead;
        let rpath = ReadStream.path;
        expect(isIntNum(rb)).assertTrue();
        expect(rpath == filePath).assertTrue();
        fs.unlinkSync(filePath);
      } catch (e) {
        console.log('fileIO_test_create_ReadStream_010 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });
    /**
     * @tc.number SUB_DF_FILEIO_CREATE_READSTREAM_1100
     * @tc.name fileIO_test_create_ReadStream_011
     * @tc.desc Test the createReadStream() interface of class Stream.
     * ReadStream reads files.Seek
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_create_ReadStream_011', Level.LEVEL0, async () => {
      let filePath = await nextFileName('fileIO_test_create_ReadStream_011');
      expect(prepareFile(filePath, FILE_CONTENT)).assertTrue();
      try {
        let ReadStream = fs.createReadStream(filePath);
        let offset = 5;
        let curOff = ReadStream.seek(offset, fs.WhenceType.SEEK_SET);
        expect(offset == curOff).assertTrue();
        fs.unlinkSync(filePath);
      } catch (e) {
        console.log('fileIO_test_create_ReadStream_011 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });
    /**
     * @tc.number SUB_DF_FILEIO_CREATE_READSTREAM_1200
     * @tc.name fileIO_test_create_ReadStream_012
     * @tc.desc Test the createWriteStream() interface of class Stream.
     * ReadStream reads files.bytesWritten, path
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_create_ReadStream_012', Level.LEVEL0, async () => {
      let filePath = await nextFileName('fileIO_test_create_ReadStream_012');
      expect(prepareFile(filePath, FILE_CONTENT)).assertTrue();
      try {
        let WriteStream = fs.createWriteStream(filePath);
        let wb = WriteStream.bytesWritten;
        let wPath = WriteStream.path;
        expect(isIntNum(wb)).assertTrue();
        expect(wPath == filePath).assertTrue();
        fs.unlinkSync(filePath);
      } catch (e) {
        console.log('fileIO_test_create_ReadStream_013 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });
    /**
     * @tc.number SUB_DF_FILEIO_CREATE_READSTREAM_1300
     * @tc.name fileIO_test_create_ReadStream_013
     * @tc.desc Test the createWriteStream() interface of class Stream.
     * ReadStream reads files.Seek
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_create_ReadStream_013', Level.LEVEL0, async () => {
      let filePath = await nextFileName('fileIO_test_create_ReadStream_013');
      expect(prepareFile(filePath, FILE_CONTENT)).assertTrue();
      try {
        let WriteStream = fs.createWriteStream(filePath);
        let curOff = WriteStream.seek(5, fs.WhenceType.SEEK_SET);
        console.log('fileIO_test_create_ReadStream_014 has failed for ' + curOff);
        expect(true).assertTrue();
        fs.unlinkSync(filePath);
      } catch (e) {
        console.log('fileIO_test_create_ReadStream_014 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });
    /**
     * @tc.number SUB_DF_FILEIO_CREATE_READSTREAM_1400
     * @tc.name fileIO_test_create_ReadStream_014
     * @tc.desc Test the createReadStream() interface of class Stream.
     * Copy files on Stream and use close to release resources at the end, start=0.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_create_ReadStream_014', Level.LEVEL0, async () => {
      let filePath = await nextFileName('fileIO_test_create_ReadStream_014');
      let wPath = await nextFileName('fileIO_test_create_ReadStream_014');
      expect(prepareFile(filePath, FILE_CONTENT)).assertTrue();
      expect(prepareFile(wPath, '')).assertTrue();
      try {
        let rs = fs.createReadStream(filePath);
        let ws = fs.createWriteStream(wPath);
        let rsSize = 0;
        rs.on('readable', () => {
          let data = rs.read();
          if (data != null) {
            ws.write(data);
            rsSize = rsSize + data.length;
            console.log('fileIO_test_create_ReadStream_014 content ' + data.slice(0, 10) + ', data.length: ' +
            data.length);
          }

          let filesize = fs.lstatSync(wPath).size;
          console.log('fileIO_test_create_ReadStream_014 rsSize ' + rsSize + ', filesize: ' + filesize);
          expect(rsSize == filesize).assertTrue();
          rs.close();
          ws.close();
        });
        fs.unlinkSync(filePath);
      } catch (e) {
        console.log('fileIO_test_create_ReadStream_014 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });
    /**
     * @tc.number SUB_DF_FILEIO_CREATE_READSTREAM_1500
     * @tc.name fileIO_test_create_ReadStream_015
     * @tc.desc Test the createReadStream() interface of class Stream.
     * Copy files on Stream and use close to release resources at the end, mode=0.
     * @tc.size MEDIUM
     * @tc.type Function
     * @tc.level Level 0
     * @tc.require
     */
    it('fileIO_test_create_ReadStream_015', Level.LEVEL0, async () => {
      let filePath = await nextFileName('fileIO_test_create_ReadStream_015');
      let wPath = await nextFileName('fileIO_test_create_ReadStream_015');
      expect(prepareFile(filePath, FILE_CONTENT)).assertTrue();
      expect(prepareFile(wPath, '')).assertTrue();
      try {
        let rs = fs.createReadStream(filePath);
        let ws = fs.createWriteStream(wPath, {start:0, mode:0o2});
        let rsSize = 0;
        rs.on('readable', () => {
          let data = rs.read();
          if (data != null) {
            ws.write(data);
            rsSize = rsSize + data.length;
            console.log('fileIO_test_create_ReadStream_015 content ' + data.slice(0, 10) + ', data.length: ' +
              data?.length);
          }

          let filesize = fs.lstatSync(wPath).size;
          console.log('fileIO_test_create_ReadStream_015 rsSize ' + rsSize + ', filesize: ' + filesize);
          expect(rsSize == filesize).assertTrue();
          rs.close();
          ws.close();
        });
        fs.unlinkSync(filePath);
      } catch (e) {
        console.log('fileIO_test_create_ReadStream_015 has failed for ' + e.message + ', code: ' + e.code);
        expect(false).assertTrue();
      }
    });
  })
}
