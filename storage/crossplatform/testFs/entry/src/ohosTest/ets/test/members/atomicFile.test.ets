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
import { FILE_CONTENT, nextFileName, prepareFile, describe, it, expect, afterEach } from "../Common";

import { Level } from '@ohos/hypium';
import util from '@ohos.util';
import fileIO from '@ohos.file.fs';
import { common } from '@kit.AbilityKit';

export default function fileIOAtomicFile() {
  describe('fileIO_atomicFile', () => {

    it("fileIO_test_atomicFile_000", Level.LEVEL0, () => {
      try {
        let file1 = new fileIO.AtomicFile("");
        let ws1 = file1.startWrite();
      } catch (e) {
        console.log('fileIO_test_atomicFile_000 has failed for ' + e.message + ', code: ' + e.code);
        expect(e.code == 13900002 && e.message === "No such file or directory").assertTrue();
      }
    });

    it('fileIO_test_atomicFile_001', Level.LEVEL0, () => {
      let context = getContext() as common.UIAbilityContext;
      const filepath = context.filesDir + "/test1.txt";

      try {
        let file = new fileIO.AtomicFile(filepath);
        let ws = file.startWrite();
        file.finishWrite();
        let stat = fileIO.statSync(filepath);
        expect(stat.size == 0).assertTrue();
      } catch (e) {
        console.log('fileIO_test_atomicFile_001 has failed for ' + e.message);
        expect(false).assertTrue();
      }
    });

    it('fileIO_test_atomicFile_002', Level.LEVEL0, () => {
      let context = getContext() as common.UIAbilityContext;
      const filepath = context.filesDir + "/test2.txt";

      try {
        let file = new fileIO.AtomicFile(filepath);
        let ws = file.startWrite();
        ws.write("hello world","utf-8",()=> {
          file.finishWrite();
          setTimeout(()=>{
            let data = file.readFully();
            let decoder = util.TextDecoder.create('utf-8');
            let str = decoder.decodeToString(new Uint8Array(data));
            expect(str === FILE_CONTENT).assertTrue();
          },1000);
        })
      } catch (e) {
        console.log('fileIO_test_atomicFile_002 has failed for ' + e.message);
        expect(false).assertTrue();
      }
    });

    it('fileIO_test_atomicFile_003', Level.LEVEL0, () => {
      let context = getContext() as common.UIAbilityContext;
      const filepath = context.filesDir + "/test3/test3.txt";

      try {
        let file = new fileIO.AtomicFile(filepath);
        let ws = file.startWrite();
      } catch (e) {
        expect(e.message === "No such file or directory").assertTrue();
      }
    });

    it('fileIO_test_atomicFile_004', Level.LEVEL0, () => {
      let context = getContext() as common.UIAbilityContext;
      const filepath = context.filesDir + "test4.txt";
      expect(prepareFile(filepath, FILE_CONTENT)).assertTrue();

      try {
        let file = new fileIO.AtomicFile(filepath);
        let data = file.readFully();
        expect(data !== null).assertTrue();
        let decoder = util.TextDecoder.create('utf-8');
        let str = decoder.decodeToString(new Uint8Array(data));
        expect(str === FILE_CONTENT).assertTrue();
      } catch (e) {
        console.log('fileIO_test_atomicFile_004 has failed for ' + e.message);
        expect(false).assertTrue();
      }
    });

    it('fileIO_test_atomicFile_005', Level.LEVEL0, () => {
      let context = getContext() as common.UIAbilityContext;
      const filepath = context.filesDir + 'test5.txt';
      expect(prepareFile(filepath, FILE_CONTENT)).assertTrue();

      try {
        let file = new fileIO.AtomicFile(filepath);
        let readStream = file.openRead();
        readStream.on('readable', () => {
          let data = readStream.read();
          if (data == null) {
            return;
          }
          expect(data === FILE_CONTENT).assertTrue();
        });
      } catch (e) {
        console.log('fileIO_test_atomicFile_005 has failed for ' + e.message);
        expect(false).assertTrue();
      }
    });

    it('fileIO_test_atomicFile_006', Level.LEVEL0, () => {
      console.log('fileIO_test_atomicFile_006 begin');
      let context = getContext() as common.UIAbilityContext;
      const filepath = context.filesDir + 'test6.txt';

      try {
        let file = new fileIO.AtomicFile(filepath);
        let ws = file.startWrite();
        ws.write("hello world","utf-8",()=> {
          file.failWrite();
          setTimeout(()=>{
            let data = file.readFully();
            let decoder = util.TextDecoder.create('utf-8');
            let str = decoder.decodeToString(new Uint8Array(data));
            expect(str === "fileIO_test_atomicFile_006").assertTrue();
          },1000)
        })
      } catch (e) {
        console.log('fileIO_test_atomicFile_006 has failed for ' + e.message);
        expect(false).assertTrue();
      }
    });

    it('fileIO_test_atomicFile_007', Level.LEVEL0, () => {
      let context = getContext() as common.UIAbilityContext;
      const filepath = context.filesDir + 'test7.txt';
      expect(prepareFile(filepath, "fileIO_test_atomicFile_007")).assertTrue();

      try {
        let rFile = new fileIO.AtomicFile(filepath);
        let readData = rFile.readFully();
        let rDecoder = util.TextDecoder.create('utf-8');
        let readStr = rDecoder.decodeToString(new Uint8Array(readData));
        expect(readStr === "fileIO_test_atomicFile_007").assertTrue();
        let wPath = context.filesDir + '/test7_write.txt';
        let wFile = new fileIO.AtomicFile(wPath);
        let ws = wFile.startWrite();
        ws.write(readStr,"utf-8",()=> {
          wFile.finishWrite();
          setTimeout(()=>{
            let writeData = wFile.readFully();
            let wDecoder = util.TextDecoder.create('utf-8');
            let writeStr = wDecoder.decodeToString(new Uint8Array(writeData));
            expect(writeStr === "fileIO_test_atomicFile_007").assertTrue();
          },1000)
        })
      } catch (e) {
        console.log('fileIO_test_atomicFile_007 has failed for ' + e.message);
        expect(false).assertTrue();
      }
    });

    it('fileIO_test_atomicFile_008', Level.LEVEL0, () => {
      let context = getContext() as common.UIAbilityContext;
      const filepath = context.filesDir + 'test8.txt';

      try {
        let file = new fileIO.AtomicFile(filepath);
        let ws = file.startWrite();
        file.finishWrite();
        let stat = fileIO.statSync(filepath);
        expect(stat.size == 0).assertTrue();
        file.delete();
        let res = fileIO.accessSync(filepath);
        expect(res).assertFalse();
      } catch (e) {
        console.log('fileIO_test_atomicFile_008 has failed for ' + e.message);
        expect(false).assertTrue();
      }
    });

    it('fileIO_test_atomicFile_009', Level.LEVEL0, () => {
      let context = getContext() as common.UIAbilityContext;
      const filepath = context.filesDir + 'test9.txt';

      try {
        let file = new fileIO.AtomicFile(filepath);
        let File = file.getBaseFile();
      } catch (e) {
        console.log('fileIO_test_atomicFile_009 has failed for ' + e.message + ', code: ' + e.code);
        expect(e.code == 13900002 && e.message === "No such file or directory").assertTrue();
      }
    });

    it('fileIO_test_atomicFile_010', Level.LEVEL0, () => {
      let context = getContext() as common.UIAbilityContext;
      const filepath = context.filesDir + 'test10.txt';

      try {
        let file = new fileIO.AtomicFile(filepath);
        let ws = file.startWrite();
        ws.write("fileIO_test_atomicFile_010","utf-8",()=> {
          file.finishWrite();
          let File = file.getBaseFile();
          expect(File.fd > 0).assertTrue();
        })
      } catch (e) {
        console.log('fileIO_test_atomicFile_010 has failed for ' + e.message);
        expect(false).assertTrue();
      }
    });
  })
}