/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { describe, it, expect} from '@ohos/hypium';
import zlib from '@ohos.zlib';
import { BusinessError } from '@ohos.base';
import fs from '@ohos.file.fs';
import common from '@ohos.app.ability.common';
import AbilityDelegatorRegistry from '@ohos.app.ability.abilityDelegatorRegistry';

export default function ZlibTest() {
  describe('zipTest', () => {
      let context: common.Context = AbilityDelegatorRegistry.getAbilityDelegator().getAppContext();
      let dir: string = context.filesDir;
      let content: string = '测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本测试文本';

    /*
     * @tc.number: SUB_Zlib_CompressFile_Func_0100
     * @tc.name: SUB_Zlib_CompressFile_Func_0100
     * @tc.desc: inFile is folders
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Zlib_CompressFile_Func_0100', 0, async (done: Function) => {
      let Path1:string =`${dir}/test000a`;
      let Path2:string =`${dir}/test000b`;
      let filepath1:string = `${Path1}/test000a.txt`;
      let filepath2:string = `${Path2}/test000b.txt`;
      let outFile1:string = `${dir}/test000a.zip`;
      let outFile2:string = `${dir}/test000b.zip`;
      await fs.mkdir(Path1).then((data)=> {
        console.log(`zipDir000a mkdir success:${data}`);
        expect(data).assertUndefined();
      }).catch((err:BusinessError) => {
        console.log(`zipDir000a mkdir fail:${JSON.stringify(err)}`);
        expect().assertFail();
      });
      await fs.mkdir(Path2).then((data)=> {
        console.log(`zipDir000b mkdir success:${data}`);
        expect(data).assertUndefined();
      }).catch((err:BusinessError) => {
        console.log(`zipDir000b mkdir fail:${JSON.stringify(err)}`);
        expect().assertFail();
      });
      let file1:fs.File = fs.openSync(filepath1, 0o100 | 0o2);
      await fs.write(file1.fd, content).then((data) => {
        console.log(`test000a write success:${data}`);
        expect(data > 0).assertTrue();
      }).catch((err:BusinessError) => {
        console.log(`test000a write fail:${err}`);
        expect(err).assertFail();
      });
      try {
        await zlib.compressFile(filepath1, outFile1, {
          level: zlib.CompressLevel.COMPRESS_LEVEL_DEFAULT_COMPRESSION
        }).then((data) => {
          console.log(`compressFilePromise000a success:${JSON.stringify(data)}`);
          let zipStat:fs.Stat = fs.statSync(outFile1);
          let isFile:boolean = zipStat.isFile();
          expect(isFile).assertTrue();
          let srcSize:number = fs.statSync(filepath1).size;
          let zipSize:number = zipStat.size;
          expect(srcSize > zipSize).assertTrue();
          expect(data).assertNull();
          fs.rmdirSync(Path1);
        }).catch((err:BusinessError) => {
          console.log(`compressFilePromise000a fail:${JSON.stringify(err)}`);
          expect(err).assertFail();
        });
      } catch(err) {
        console.log(`compressFilePromise000a catch:${JSON.stringify(err)}`)
        expect().assertFail();
      };

      let file2:fs.File = fs.openSync(filepath2, 0o100 | 0o2);
      await fs.write(file2.fd, content).then((data) => {
        console.log(`test000b write success:${data}`);
        expect(data>0).assertTrue();
      }).catch((err:BusinessError) => {
        console.log(`test000b write fail:${err}`);
        expect(err).assertFail();
      });
      try {
        zlib.compressFile(filepath2, outFile2, {
          level: zlib.CompressLevel.COMPRESS_LEVEL_DEFAULT_COMPRESSION
        }, (res) => {
          if (!res) {
            console.log(`compressFileCallback000b success:${JSON.stringify(res)}`);
            let zipStat:fs.Stat = fs.statSync(outFile2);
            let isFile:boolean = zipStat.isFile();
            expect(isFile).assertTrue();
            let srcSize:number = fs.statSync(filepath2).size;
            let zipSize:number = zipStat.size;
            expect(srcSize > zipSize).assertTrue();
            expect(res).assertNull();
            fs.rmdirSync(Path2);
            done();
          } else {
            console.log(`compressFileCallback000b fail:${ JSON.stringify(res)}`);
            expect(res).assertFail();
            done();
          };
        });
      }catch (err) {
        console.log(`compressFileCallback000b catch:${JSON.stringify(err)}`);
        expect(err).assertFail();
        done();
      };
    });

    /*
     * @tc.number: SUB_Zlib_CompressFile_Func_0200
     * @tc.name: SUB_Zlib_CompressFile_Func_0200
     * @tc.desc: outFile is empty
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Zlib_CompressFile_Func_0200', 0, async (done: Function) => {
      let filePath:string = `${dir}/test001.txt`;
      let options: zlib.Options = {
        level: zlib.CompressLevel.COMPRESS_LEVEL_DEFAULT_COMPRESSION,
        memLevel: zlib.MemLevel.MEM_LEVEL_DEFAULT,
        strategy: zlib.CompressStrategy.COMPRESS_STRATEGY_DEFAULT_STRATEGY
      };
      let file:fs.File = fs.openSync(filePath, 0o100 | 0o2);
      await fs.write(file.fd, content).then((data) => {
        console.log(`test001 write success:${data}`);
        expect(data>0).assertTrue()
      }).catch((err: BusinessError) => {
        console.log('test001 write fail');
        expect(err).assertFail();
      });
        await zlib.compressFile(filePath, '', options).then(data => {
          console.log(`compressFilePromise001 success:${data}`);
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.log(`compressFilePromise001 fail:${err}`);
          expect(err.code).assertEqual(900002);
        });
      try {
        zlib.compressFile(filePath, '', options, (res) => {
          console.log(`compressFileCallback001 end:${res}`);
          expect(res.code).assertEqual(900002);
          done();
        });
      }catch(err) {
        console.log(`compressFileCallback001 callback catch:${err}`);
        expect().assertFail();
        done();
      };
    });

    /*
     * @tc.number: SUB_Zlib_CompressFile_Func_0300
     * @tc.name: SUB_Zlib_CompressFile_Func_0300
     * @tc.desc: infile is empty
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Zlib_CompressFile_Func_0300', 0, async (done: Function) => {
      let outFile: string = `${dir}/test002.zip`;
      let options: zlib.Options = {
        level: zlib.CompressLevel.COMPRESS_LEVEL_DEFAULT_COMPRESSION,
        memLevel: zlib.MemLevel.MEM_LEVEL_DEFAULT,
        strategy: zlib.CompressStrategy.COMPRESS_STRATEGY_DEFAULT_STRATEGY
      };
      try {
        await zlib.compressFile('', outFile, options).then(data => {
          console.log(`compressFilePromise002 success:${data}`);
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.log(`compressFilePromise002 fail:${err}`);
          expect(err.code).assertEqual(900001);
        });
      } catch (err) {
        console.log(`compressFilePromise002 catch:${err}`);
        expect().assertFail();
      };
      try {
        zlib.compressFile('', outFile, options, (res) => {
          console.log(`compressFileCallback002 res:${res}`);
          expect(res.code).assertEqual(900001);
          done();
        });
      }catch (err) {
        console.log(`compressFileCallback002 catch:${err}`);
        expect().assertFail();
        done();
      };
    });

    /*
     * @tc.number: SUB_Zlib_CompressFile_Func_0400
     * @tc.name: SUB_Zlib_CompressFile_Func_0400
     * @tc.desc: normal
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Zlib_CompressFile_Func_0400', 0, async (done: Function) => {
      let filePath1: string = `${dir}/test003-1.txt`;
      let filePath2: string = `${dir}/test003-2.txt`;
      let outFile1: string = `${dir}/test003-1.zip`;
      let outFile2: string = `${dir}/test003-2.zip`;
      let options: zlib.Options = {
        level: zlib.CompressLevel.COMPRESS_LEVEL_DEFAULT_COMPRESSION,
        memLevel: zlib.MemLevel.MEM_LEVEL_DEFAULT,
        strategy: zlib.CompressStrategy.COMPRESS_STRATEGY_DEFAULT_STRATEGY
      };
      let file1:fs.File = fs.openSync(filePath1, 0o100 | 0o2);
      let file2:fs.File = fs.openSync(filePath2, 0o100 | 0o2);
      await fs.write(file1.fd, content).then((data) => {
        console.log(`test003-1 write success:${data}`);
        expect(data>0).assertTrue();
      }).catch((err: BusinessError) => {
        console.log('test003-1 write fail');
        expect(err).assertFail();
      });
      await fs.write(file2.fd, content).then((data) => {
        console.log(`test003-2 write success:${data}`);
        expect(data>0).assertTrue();
      }).catch((err: BusinessError) => {
        console.log('test003-2 write fail');
        expect(err).assertFail();
      });
      await zlib.compressFile(filePath1, outFile1, options).then(data => {
        console.log('compressFilePromise003-1 success');
        let zipStat:fs.Stat = fs.statSync(outFile1);
        let isFile:boolean = zipStat.isFile();
        expect(isFile).assertTrue();
        let srcSize:number = fs.statSync(filePath1).size;
        let zipSize:number = zipStat.size;
        expect(srcSize > zipSize).assertTrue();
        expect(data).assertNull();
      }).catch((err: BusinessError) => {
        console.log('compressFilePromise003-1 fail');
        expect(err).assertFail();
        done();
      });
      try {
        zlib.compressFile(filePath2, outFile2, options, (res) => {
          console.log('compressFileCallback003-2 success');
          let zipStat:fs.Stat = fs.statSync(outFile2);
          let isFile:boolean = zipStat.isFile();
          expect(isFile).assertTrue();
          let srcSize:number = fs.statSync(filePath2).size;
          let zipSize:number = zipStat.size;
          expect(srcSize > zipSize).assertTrue();
          expect(res).assertNull();
          done();
        });
      } catch (err) {
        console.log('compressFileCallback003-2 fail');
        expect(err).assertFail();
        done();
      };
    });

    /*
     * @tc.number: SUB_Zlib_CompressFile_Func_0500
     * @tc.name: SUB_Zlib_CompressFile_Func_0500
     * @tc.desc: options is null
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Zlib_CompressFile_Func_0500', 0, async (done: Function) => {
      let filePath: string = `${dir}/test004.txt`;
      let outFile: string = `${dir}/test004.zip`;
      let file:fs.File = fs.openSync(filePath, 0o100 | 0o2);
      await fs.write(file.fd, content).then((data) => {
        console.log(`test004 write success:${data}`);
        expect(data > 0).assertTrue();
      }).catch((err: BusinessError) => {
        console.log('test004 write fail');
        expect(err).assertFail();
      });
      try {
        await zlib.compressFile(filePath, outFile, null).then(data => {
          console.log(`compressFilePromise004 success:${JSON.stringify(data)}`);
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.log(`compressFilePromise004 fail:${JSON.stringify(err)}`);
          expect().assertFail();
        });
      } catch (err) {
        console.log(`compressFilePromise004 catch:${JSON.stringify(err)}`);
        expect(err.code).assertEqual(401);
      };
      try {
        zlib.compressFile(filePath, outFile, null, (res) => {
          if (!res) {
            console.log(`compressFileCallback004 success:${JSON.stringify(res)}`);
            expect().assertFail();
          } else {
            console.log(`compressFileCallback004 fail:${JSON.stringify(res.code)}`);
            expect().assertFail();
          };
          done();
        });
      }catch (err) {
        console.log(`compressFileCallback004 catch:${JSON.stringify(err)}`);
        expect(err.code).assertEqual(401);
        done();
      };
    });

    /*
     * @tc.number: SUB_Zlib_CompressFile_Func_0600
     * @tc.name: SUB_Zlib_CompressFile_Func_0600
     * @tc.desc: level is invalid
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Zlib_CompressFile_Func_0600', 0, async (done: Function) => {
      let filePath1: string = `${dir}/test005-1.txt`;
      let filePath2: string = `${dir}/test005-2.txt`;
      let outFile1: string = `${dir}/test005-1.zip`;
      let outFile2: string = `${dir}/test005-2.zip`;
      let options: zlib.Options = {
        level: 99,
        memLevel: zlib.MemLevel.MEM_LEVEL_DEFAULT,
        strategy: zlib.CompressStrategy.COMPRESS_STRATEGY_DEFAULT_STRATEGY
      };
      let file1:fs.File = fs.openSync(filePath1, 0o100 | 0o2);
      let file2:fs.File = fs.openSync(filePath2, 0o100 | 0o2);
      await fs.write(file1.fd, content).then((data) => {
        console.log(`test005-1 write success:${data}`);
        expect(data>0).assertTrue();
      }).catch((err: BusinessError) => {
        console.log(`test005-1 write fail:${err}`);
        expect(err).assertFail();
      });
      await fs.write(file2.fd, content).then((data) => {
        console.log(`test005-2 write success:${data}`);
        expect(data>0).assertTrue();
      }).catch((err: BusinessError) => {
        console.log('test005-2 write fail');
        expect(err).assertFail();
      });
      try {
        await zlib.compressFile(filePath1, outFile1, options).then(data => {
          console.log(`compressFilePromise005-1 success:${data}`);
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.log(`compressFilePromise005-1 fail:${JSON.stringify(err)}`);
          expect(err).assertFail();
        });
      } catch (err) {
        console.log(`compressFilePromise005-1 catch:${JSON.stringify(err)}`);
        expect(err.code).assertEqual(401);
      };

      try {
        zlib.compressFile(filePath2, outFile2, options, (res) => {
          console.log(`compressFileCallback005-2 success:${res}`);
          expect().assertFail();
          done();
        });
      } catch (err) {
        console.log(`compressFileCallback005-2 fail:${JSON.stringify(err)}`);
        expect(err.code).assertEqual(401);
        done();
      };
    });

    /*
     * @tc.number: SUB_Zlib_CompressFile_Func_0700
     * @tc.name: SUB_Zlib_CompressFile_Func_0700
     * @tc.desc: memLevel is invalid
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Zlib_CompressFile_Func_0700', 0, async (done: Function) => {
      let filePath1: string = `${dir}/test006-1.txt`;
      let filePath2: string = `${dir}/test006-2.txt`;
      let outFile1: string = `${dir}/test006-1.zip`;
      let outFile2: string = `${dir}/test006-2.zip`;
      let options: zlib.Options = {
        level: zlib.CompressLevel.COMPRESS_LEVEL_DEFAULT_COMPRESSION,
        memLevel: 99,
        strategy: zlib.CompressStrategy.COMPRESS_STRATEGY_DEFAULT_STRATEGY
      };
      let file1:fs.File = fs.openSync(filePath1, 0o100 | 0o2);
      let file2:fs.File = fs.openSync(filePath2, 0o100 | 0o2);
      await fs.write(file1.fd, content).then((data) => {
        console.log(`test006-1 write success:${data}`);
        expect(data>0).assertTrue();
      }).catch((err: BusinessError) => {
        console.log('test006-1 write fail');
        expect(err).assertFail();
      })
      await fs.write(file2.fd, content).then((data) => {
        console.log(`test006-2 write success:${data}`);
        expect(data>0).assertTrue();
      }).catch((err: BusinessError) => {
        console.log(`test006-2 write fail:${err}`);
        expect(err).assertFail();
      })
      await zlib.compressFile(filePath1, outFile1, options).then(data => {
        console.log(`compressFilePromise006-1 success:${data}`);
        let zipStat:fs.Stat = fs.statSync(outFile1);
        let isFile:boolean = zipStat.isFile();
        expect(isFile).assertTrue();
        let srcSize:number = fs.statSync(filePath1).size;
        let zipSize:number = zipStat.size;
        expect(srcSize > zipSize).assertTrue();
        expect(data).assertNull();
      }).catch((err: BusinessError) => {
        console.log(`compressFilePromise006-1 fail:${err}`);
        expect(err).assertFail();
      });
      try {
        zlib.compressFile(filePath2, outFile2, options, (res) => {
          console.log(`compressFileCallback006-2 success:${res}`);
          let zipStat:fs.Stat = fs.statSync(outFile2);
          let isFile:boolean = zipStat.isFile();
          expect(isFile).assertTrue();
          let srcSize:number = fs.statSync(filePath2).size;
          let zipSize:number = zipStat.size;
          expect(srcSize > zipSize).assertTrue();
          expect(res).assertNull();
          done();
        });
      } catch (err) {
        console.log(`compressFileCallback006-2 fail:${err}`);
        expect(err).assertFail();
        done();
      };
    });

    /*
     * @tc.number: SUB_Zlib_CompressFile_Func_0800
     * @tc.name: SUB_Zlib_CompressFile_Func_0800
     * @tc.desc: strategy is invalid
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Zlib_CompressFile_Func_0800', 0, async (done: Function) => {
      let filePath1: string = `${dir}/test007-1.txt`;
      let filePath2: string = `${dir}/test007-2.txt`;
      let outFile1: string = `${dir}/test007-1.zip`;
      let outFile2: string = `${dir}/test007-2.zip`;
      let options: zlib.Options = {
        level: zlib.CompressLevel.COMPRESS_LEVEL_DEFAULT_COMPRESSION,
        memLevel: zlib.MemLevel.MEM_LEVEL_DEFAULT,
        strategy: 99
      };
      let file1:fs.File = fs.openSync(filePath1, 0o100 | 0o2);
      let file2:fs.File = fs.openSync(filePath2, 0o100 | 0o2);
      await fs.write(file1.fd, content).then((data) => {
        console.log(`test007-1 write success:${data}` );
        expect(data>0).assertTrue();
      }).catch((err: BusinessError) => {
        console.log(`test007-1 write fail:${err}`);
        expect(err).assertFail();
      });
      await fs.write(file2.fd, content).then((data) => {
        console.log(`test007-2 write success:${data}`);
        expect(data>0).assertTrue();
      }).catch((err: BusinessError) => {
        console.log(`test007-2 write fail:${err}`);
        expect(err).assertFail();
      });
      await zlib.compressFile(filePath1, outFile1, options).then(data => {
        console.log(`compressFilePromise007-1 success:${data}`);
        let zipStat:fs.Stat = fs.statSync(outFile1);
        let isFile:boolean = zipStat.isFile();
        expect(isFile).assertTrue();
        let srcSize:number = fs.statSync(filePath1).size;
        let zipSize:number = zipStat.size;
        expect(srcSize > zipSize).assertTrue();
        expect(data).assertNull();
      }).catch((err: BusinessError) => {
        console.log(`compressFilePromise007-1 fail:${err}`);
        expect(err).assertFail();
      });
      try {
        zlib.compressFile(filePath2, outFile2, options, (res) => {
          console.log(`compressFileCallback007-2 success:${res}`);
          let zipStat:fs.Stat = fs.statSync(outFile2);
          let isFile:boolean = zipStat.isFile();
          expect(isFile).assertTrue();
          let srcSize:number = fs.statSync(filePath2).size;
          let zipSize:number = zipStat.size;
          expect(srcSize > zipSize).assertTrue();
          expect(res).assertNull();
          done();
        });
      } catch (err) {
        console.log(`compressFileCallback007-2 fail:${err}`);
        expect(err).assertFail();
        done();
      };
    });

    /*
     * @tc.number: SUB_Zlib_DeCompressFile_Func_0900
     * @tc.name: SUB_Zlib_DeCompressFile_Func_0900
     * @tc.desc: normal (promise)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Zlib_DeCompressFile_Func_0900', 0, async (done: Function) => {
      let filePath: string = `${dir}/test008.txt`;
      let zipPath: string = `${dir}/zipTest008.zip`;
      let unzipDir: string = `${dir}/unzipDir008`;
      let finalPath: string = `${unzipDir}/test008.txt`;
      let options: zlib.Options = {
        level: zlib.CompressLevel.COMPRESS_LEVEL_DEFAULT_COMPRESSION
      };
      let file:fs.File = fs.openSync(filePath, 0o100 | 0o2);
      await fs.write(file.fd, content).then(data => {
        console.log(`test008 write success:${data}`);
        expect(data>0).assertTrue();
      }).catch((err: BusinessError) => {
        console.log(`test008 write fail:${err}`);
        expect(err).assertFail();
      });
      await zlib.compressFile(filePath, zipPath, options).then(data => {
        console.log(`compressFile008 success:${data}`);
        expect(data).assertNull();
      }).catch((err: BusinessError) => {
        console.log(`compressFile008 fail:${err}`);
        expect(err).assertFail();
      });
      //创建解压包存放目录
      await fs.mkdir(unzipDir).then(data => {
        console.log(`unzipDir008 mkdir success:${data}`);
        expect(data).assertUndefined();
      }).catch((err: BusinessError) => {
        console.log(`unzipDir008 mkdir fail:${err}`);
        expect(err).assertFail();
      });
      try {
         zlib.decompressFile(zipPath, unzipDir, options).then(data => {
          console.log(`decompressFilePromise008 success :${JSON.stringify(data)}`);
          let finalStat:fs.Stat = fs.statSync(finalPath);
          let isFile:boolean = finalStat.isFile();
          expect(isFile).assertTrue();
          expect(data).assertNull();
          fs.rmdirSync(unzipDir);
          done();
        }).catch((err: BusinessError) => {
          console.log(`decompressFilePromise008 fail :${JSON.stringify(err)}`);
           fs.rmdirSync(unzipDir);
           expect(err).assertFail();
           done();
        });
      } catch (err) {
        console.log(`decompressFilePromise008 catch:${err}`);
        fs.rmdirSync(unzipDir);
        expect(err).assertFail();
        done();
      };
    });

    /*
     * @tc.number: SUB_Zlib_DeCompressFile_Func_1000
     * @tc.name: SUB_Zlib_DeCompressFile_Func_1000
     * @tc.desc: normal (callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Zlib_DeCompressFile_Func_1000', 0, async (done: Function) => {
      let filePath: string = `${dir}/test009.txt`;
      let zipPath: string = `${dir}/zipTest009.zip`;
      let unzipDir: string = `${dir}/unzipDir009`;
      let finalPath: string = `${unzipDir}/test009.txt`;
      let options: zlib.Options = {
        level: zlib.CompressLevel.COMPRESS_LEVEL_DEFAULT_COMPRESSION
      };
      let file:fs.File = fs.openSync(filePath, 0o100 | 0o2);
      await fs.write(file.fd, content).then(data => {
        console.log(`test009 write success:${data}`);
        expect(data>0).assertTrue();
      }).catch((err: BusinessError) => {
        console.log(`test009 write fail:${err}`);
        expect().assertFail();
      });
      await zlib.compressFile(filePath, zipPath, options).then(data => {
        console.log(`compressFile009 success:${data}`);
        let zipStat:fs.Stat = fs.statSync(zipPath);
        let isFile:boolean = zipStat.isFile();
        expect(isFile).assertTrue();
        let srcSize:number = fs.statSync(filePath).size;
        let zipSize:number = zipStat.size;
        expect(srcSize > zipSize).assertTrue();
        expect(data).assertNull();
      }).catch((err: BusinessError) => {
        console.log(`compressFile009 fail:${err}`);
        expect(err).assertFail();
      });
      //创建解压包存放目录
      await fs.mkdir(unzipDir).then(data => {
        console.log(`unzipDir009 mkdir success:${data}`);
        expect(data).assertUndefined();
      }).catch((err: BusinessError) => {
        console.log(`unzipDir009 mkdir fail:${err}`);
        expect(err).assertFail();
      });
      try {
        zlib.decompressFile(zipPath, unzipDir, options, (res) => {
          console.log(`decompressFileCallback009 success :${JSON.stringify(res)}`);
          let finalStat:fs.Stat = fs.statSync(finalPath);
          let isFile:boolean = finalStat.isFile();
          expect(isFile).assertTrue();
          expect(res).assertNull();
          fs.rmdirSync(unzipDir);
          done();
        });
      } catch (err) {
        console.log(`decompressFileCallback009 fail :${JSON.stringify(err)}`);
        fs.rmdirSync(unzipDir);
        expect(err).assertFail();
        done();
      };
    });

    /*
     * @tc.number: SUB_Zlib_DeCompressFile_Func_1100
     * @tc.name: SUB_Zlib_DeCompressFile_Func_1100
     * @tc.desc: inputFile is not exist (promise)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Zlib_DeCompressFile_Func_1100', 0, async (done: Function) => {
      let zipPath:string = 'xxx.zip';
      let unzipDir:string = `${dir}/unzipDir010`;
      let options: zlib.Options = {
        level: zlib.CompressLevel.COMPRESS_LEVEL_DEFAULT_COMPRESSION
      };
      await fs.mkdir(unzipDir).then(data => {
        console.log(`unzipDir010 mkdir success:${data}`);
        expect(data).assertUndefined();
      }).catch((err: BusinessError) => {
        console.log(`unzipDir010 mkdir fail:${err}`);
        expect(err).assertFail();
      });
      await zlib.decompressFile(zipPath, unzipDir, options).then(data => {
        console.log(`decompressFilePromise010 success :${JSON.stringify(data)}`);
        fs.rmdirSync(unzipDir);
        expect().assertFail();
        done();
      }).catch((err: BusinessError) => {
        console.log(`decompressFilePromise010 fail :${JSON.stringify(err)}`);
        expect(err.code).assertEqual(900001);
        fs.rmdirSync(unzipDir);
        done();
      });
    });

    /*
     * @tc.number: SUB_Zlib_DeCompressFile_Func_1200
     * @tc.name: SUB_Zlib_DeCompressFile_Func_1200
     * @tc.desc: inputFile is not exist (callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Zlib_DeCompressFile_Func_1200', 0, async (done: Function) => {
      let zipPath:string = 'xxx.zip';
      let unzipDir: string = `${dir}/unzipDir011`;
      let options: zlib.Options = {
        level: zlib.CompressLevel.COMPRESS_LEVEL_DEFAULT_COMPRESSION
      };
      await fs.mkdir(unzipDir).then(data => {
        console.log('unzipDir011 mkdir success');
        expect(data).assertUndefined();
      }).catch((err: BusinessError) => {
        console.log('unzipDir011 mkdir fail');
        expect(err).assertFail();
      });
      try {
        zlib.decompressFile(zipPath, unzipDir, options, (res) => {
          if (!res) {
            console.log(`decompressFileCallback011 success :${JSON.stringify(res)}`);
            fs.rmdirSync(unzipDir);
            expect().assertFail();
            done();
          } else {
            console.log(`decompressFileCallback011 fail :${JSON.stringify(res)}`);
            expect(res.code).assertEqual(900001);
            fs.rmdirSync(unzipDir);
            done();
          };
        });
      }catch (err) {
        console.log(`decompressFileCallback011 catch :${JSON.stringify(err)}`);
        fs.rmdirSync(unzipDir);
        expect(err).assertFail();
        done();
      };
    });

    /*
     * @tc.number: SUB_Zlib_DeCompressFile_Func_1300
     * @tc.name: SUB_Zlib_DeCompressFile_Func_1300
     * @tc.desc: outPath is not exist (promise)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Zlib_DeCompressFile_Func_1300', 0, async (done: Function) => {
      let filePath: string = `${dir}/test012.txt`;
      let zipPath: string = `${dir}/zipTest012.zip`;
      let unzipDir: string = `${dir}/unzipDir012`;
      let options: zlib.Options = {
        level: zlib.CompressLevel.COMPRESS_LEVEL_DEFAULT_COMPRESSION
      };
      let file:fs.File = fs.openSync(filePath, 0o100 | 0o2);
      await fs.write(file.fd, content).then(data => {
        console.log(`test012 write success:${data}`);
        expect(data>0).assertTrue();
      }).catch((err: BusinessError) => {
        console.log(`test012 write fail:${err}`);
      });
      await zlib.compressFile(filePath, zipPath, options).then(data => {
        console.log(`compressFile012 success:${data}`);
        expect(data).assertNull();
      }).catch((err: BusinessError) => {
        console.log(`compressFile012 fail:${err}`);
        expect(err).assertFail();
      });
      try {
        await zlib.decompressFile(zipPath, unzipDir, options).then(data => {
          console.log(`decompressFilePromise012 success :${JSON.stringify(data)}`);
          expect(data).assertFail();
          done();
        }).catch((err: BusinessError) => {
          console.log(`decompressFilePromise012 fail :${JSON.stringify(err)}`);
          expect(err.code).assertEqual(900002);
          done();
        });
      } catch (err) {
        console.log(`decompressFilePromise012 catch:${err}`);
        expect(err).assertFail();
        done();
      };
    });

    /*
     * @tc.number: SUB_Zlib_DeCompressFile_Func_1400
     * @tc.name: SUB_Zlib_DeCompressFile_Func_1400
     * @tc.desc: outPath is not exist (callback)
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Zlib_DeCompressFile_Func_1400', 0, async (done: Function) => {
      let filePath: string = `${dir}/test013.txt`;
      let zipPath: string = `${dir}/zipTest013.zip`;
      let unzipDir: string = `${dir}/unzipDir013`;
      let options: zlib.Options = {
        level: zlib.CompressLevel.COMPRESS_LEVEL_DEFAULT_COMPRESSION
      };
      let file:fs.File = fs.openSync(filePath, 0o100 | 0o2);
      await fs.write(file.fd, content).then(data => {
        console.log(`test013 write success:${data}`);
        expect(data>0).assertTrue();
      }).catch((err: BusinessError) => {
        console.log(`test013 write fail:${err}`);
        expect().assertFail();
      });
      await zlib.compressFile(filePath, zipPath, options).then(data => {
        console.log(`compressFile013 success:${data}`);
        expect(data).assertNull();
      }).catch((err: BusinessError) => {
        console.log(`compressFile013 fail:${err}`);
        expect(err).assertFail();
      });
      try {
        zlib.decompressFile(zipPath, unzipDir, options, (res) => {
          if (res) {
            console.log(`decompressFileCallback013 fail :${JSON.stringify(res)}`);
            expect(res.code).assertEqual(900002);
            done();
          } else {
            console.log(`decompressFileCallback013 success :${JSON.stringify(res)}` );
            expect(res).assertFail();
            done();
          };
        });
      } catch (err) {
        console.log(`decompressFileCallback013 catch:${err}`);
        expect(err).assertFail();
        done();
      };
    });

    /*
     * @tc.number: SUB_Zlib_DeCompressFile_Func_1500
     * @tc.name: SUB_Zlib_DeCompressFile_Func_1500
     * @tc.desc: input source is not zip format
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Zlib_DeCompressFile_Func_1500', 0, async (done: Function) => {
      let filePath: string = `${dir}/test014.txt`;
      let unzipDir: string = `${dir}/unzipDir014`;
      let options: zlib.Options = {
        level: zlib.CompressLevel.COMPRESS_LEVEL_DEFAULT_COMPRESSION
      };
      let file:fs.File = fs.openSync(filePath, 0o100 | 0o2);
      await fs.write(file.fd, content).then(data => {
        console.log(`test014 write success:${data}`);
        expect(data>0).assertTrue();
      }).catch((err: BusinessError) => {
        console.log(`test014 write fail:${err}`);
        expect().assertFail();
      });
      //创建解压包存放目录
      await fs.mkdir(unzipDir).then(data => {
        console.log(`unzipDir014 mkdir success:${data}`);
        expect(data).assertUndefined();
      }).catch((err: BusinessError) => {
        console.log(`unzipDir014 mkdir fail:${err}`);
        expect(err).assertFail();
      });
      try {
        await zlib.decompressFile(filePath, unzipDir, options).then(data => {
          console.log(`decompressFilePromise014 success :${JSON.stringify(data)}`);
          fs.rmdirSync(unzipDir);
          expect(data).assertFail();
          done();
        }).catch((err: BusinessError) => {
          console.log(`decompressFilePromise014 fail :${JSON.stringify(err)}`);
          fs.rmdirSync(unzipDir);
          expect(err.code).assertEqual(900003);
          done();
        });
      } catch (err) {
        console.log(`decompressFilePromise014 catch :${JSON.stringify(err)}`);
        fs.rmdirSync(unzipDir);
        expect(err).assertFail();
        done();
      };
    });

    /*
     * @tc.number: SUB_Zlib_DeCompressFile_Func_1600
     * @tc.name: SUB_Zlib_DeCompressFile_Func_1600
     * @tc.desc: input source is not zip format
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Zlib_DeCompressFile_Func_1600', 0, async (done: Function) => {
      let filePath: string = `${dir}/test015.txt`;
      let unzipDir: string = `${dir}/unzipDir015`;
      let options: zlib.Options = {
        level: zlib.CompressLevel.COMPRESS_LEVEL_DEFAULT_COMPRESSION
      };
      let file:fs.File = fs.openSync(filePath, 0o100 | 0o2);
      await fs.write(file.fd, content).then(data => {
        console.log(`test015 write success:${data}`);
        expect(data>0).assertTrue();
      }).catch((err: BusinessError) => {
        console.log(`test015 write fail:${err}`);
        expect().assertFail();
      });
      //创建解压包存放目录
      await fs.mkdir(unzipDir).then(data => {
        console.log(`unzipDir015 mkdir success:${data}`);
        expect(data).assertUndefined();
      }).catch((err: BusinessError) => {
        console.log(`unzipDir015 mkdir fail:${err}`);
        expect(err).assertFail();
      });
      try {
        zlib.decompressFile(filePath, unzipDir, options, (res) => {
          if (res) {
            console.log(`decompressFileCallback015 fail :${JSON.stringify(res)}`);
            fs.rmdirSync(unzipDir);
            expect(res.code).assertEqual(900003);
            done();
          } else {
            console.log(`decompressFileCallback015 success :${JSON.stringify(res)}`);
            fs.rmdirSync(unzipDir);
            expect(res).assertFail();
            done();
          };
        });
      } catch (err) {
        fs.rmdirSync(unzipDir);
        console.log(`decompressFileCallback015 catch :${JSON.stringify(err)}`);;
        expect(err).assertFail();
        done();
      };
    });

    /*
     * @tc.number: SUB_Zlib_DeCompressFile_Func_1700
     * @tc.name: SUB_Zlib_DeCompressFile_Func_1700
     * @tc.desc: deCompressFile when options is empty
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Zlib_DeCompressFile_Func_1700', 0, async (done: Function) => {
      let filePath: string = `${dir}/test016.txt`;
      let zipPath: string = `${dir}/zipTest016.zip`;
      let unzipDir: string = `${dir}/unzipDir016`;
      let finalPath: string = `${unzipDir}/test016.txt`;
      let options: zlib.Options = {
        level: zlib.CompressLevel.COMPRESS_LEVEL_DEFAULT_COMPRESSION
      };
      let file:fs.File = fs.openSync(filePath, 0o100 | 0o2);
      await fs.write(file.fd, content).then(data => {
        console.log(`test016 write success:${data}`);
        expect(data>0).assertTrue();
      }).catch((err: BusinessError) => {
        console.log(`test016 write fail:${err}`);
        expect().assertFail();
      });
      await zlib.compressFile(filePath, zipPath, options).then(data => {
        console.log(`compressFile016 success:${data}`);
        expect(data).assertNull();
      }).catch((err: BusinessError) => {
        console.log(`compressFile016 fail:${err}`);
        expect(err).assertFail();
      });
      //创建解压包存放目录
      await fs.mkdir(unzipDir).then(data => {
        console.log(`unzipDir016 mkdir success:${data}`);
        expect(data).assertUndefined();
      }).catch((err: BusinessError) => {
        console.log(`unzipDir016 mkdir fail:${err}`);
        expect(err).assertFail();
      });
      try {
        await zlib.decompressFile(zipPath, unzipDir, {}).then(data => {
          console.log(`decompressFilePromise016 success :${JSON.stringify(data)}`);
          let finalFile:fs.Stat = fs.statSync(finalPath);
          let isFile:boolean = finalFile.isFile();
          expect(data).assertNull();
          expect(isFile).assertTrue();
          fs.rmdirSync(unzipDir);
          done();
        }).catch((err: BusinessError) => {
          console.log(`decompressFilePromise016 fail:${JSON.stringify(err)}`);
          fs.rmdirSync(unzipDir);
          expect(err).assertFail();
          done();
        });
      } catch (err) {
        console.log(`decompressFilePromise016 catch:${JSON.stringify(err)}`);
        fs.rmdirSync(unzipDir);
        expect(err).assertFail();
        done();
      };
    });

    /*
     * @tc.number: SUB_Zlib_DeCompressFile_Func_1800
     * @tc.name: SUB_Zlib_DeCompressFile_Func_1800
     * @tc.desc: deCompressFile when options is null
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Zlib_DeCompressFile_Func_1800', 0, async (done: Function) => {
      let filePath: string = `${dir}/test017.txt`;
      let zipPath: string = `${dir}/zipTest017.zip`;
      let unzipDir: string = `${dir}/unzipDir017`;
      let options: zlib.Options = {
        level: zlib.CompressLevel.COMPRESS_LEVEL_DEFAULT_COMPRESSION
      };
      let file:fs.File = fs.openSync(filePath, 0o100 | 0o2);
      await fs.write(file.fd, content).then(data => {
        console.log(`test017 write success:${data}`);
        expect(data>0).assertTrue();
      }).catch((err: BusinessError) => {
        console.log(`test017 write fail:${err}`);
        expect().assertFail();
      });
      await zlib.compressFile(filePath, zipPath, options).then(data => {
        console.log(`compressFile017 success:${data}`);
        expect(data).assertNull();
      }).catch((err: BusinessError) => {
        console.log(`compressFile017 fail:${err}`);
        expect(err).assertFail();
      });
      //创建解压包存放目录
      await fs.mkdir(unzipDir).then(data => {
        console.log(`unzipDir017 mkdir success:${data}`);
        expect(data).assertUndefined();
      }).catch((err: BusinessError) => {
        console.log(`unzipDir017 mkdir fail:${err}`);
        expect(err).assertFail();
      });
      try {
        zlib.decompressFile(zipPath, unzipDir, null, (res) => {
          console.log(`decompressFileCallback017 finish :${JSON.stringify(res)}`);
          fs.rmdirSync(unzipDir);
          expect().assertFail();
          done();
        });
      } catch (err) {
        console.log(`decompressFileCallback017 catch :${JSON.stringify(err)}`);
        fs.rmdirSync(unzipDir);
        expect(err.code).assertEqual(401);
        done();
      };
    });

    /*
     * @tc.number: SUB_Zlib_DeCompressFile_Func_1900
     * @tc.name: SUB_Zlib_DeCompressFile_Func_1900
     * @tc.desc: There are no options
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 1
     */
    it('SUB_Zlib_DeCompressFile_Func_1900', 0, async (done: Function) => {
      let filePath: string = `${dir}/test018.txt`;
      let zipPath: string = `${dir}/zipTest018.zip`;
      let unzipDir: string = `${dir}/unzipDir018`;
      let finalPath:string = `${dir}/test018.txt`;
      let options: zlib.Options = {
        level: zlib.CompressLevel.COMPRESS_LEVEL_DEFAULT_COMPRESSION
      };
      let file:fs.File = fs.openSync(filePath, 0o100 | 0o2);
      await fs.write(file.fd, content).then(data => {
        console.log(`test018 write success:${data}`);
        expect(data>0).assertTrue();
      }).catch((err: BusinessError) => {
        console.log(`test018 write fail:${err}`);
        expect().assertFail();
      });
      await zlib.compressFile(filePath, zipPath, options).then(data => {
        console.log(`compressFile018 success:${data}`);
        expect(data).assertNull();
      }).catch((err: BusinessError) => {
        console.log(`compressFile018 fail:${err}`);
        expect(err).assertFail();
      });
      //创建解压包存放目录
      await fs.mkdir(unzipDir).then(data => {
        console.log(`unzipDir018 mkdir success:${data}`);
        expect(data).assertUndefined();
      }).catch((err: BusinessError) => {
        console.log(`unzipDir018 mkdir fail:${err}`);
        expect(err).assertFail();
      });
      try {
        zlib.decompressFile(zipPath, unzipDir, (res) => {
          if (!res) {
            console.log(`decompressFileCallback018 success :${JSON.stringify(res)}`);
            let finalStat:fs.Stat = fs.statSync(finalPath);
            let isFile:boolean = finalStat.isFile();
            expect(isFile).assertTrue();
            expect(res).assertNull();
            fs.rmdirSync(unzipDir);
            done();
          } else {
            console.log(`decompressFileCallback018 fail :${JSON.stringify(res)}`);
            fs.rmdirSync(unzipDir);
            expect(res).assertFail();
            done();
          };
        });
      } catch (err) {
        console.log(`decompressFileCallback018 catch :${JSON.stringify(err)}`);
        fs.rmdirSync(unzipDir);
        expect().assertFail();
        done();
      };
    });

    /*
     * @tc.number: SUB_Zlib_DeCompressFile_Func_2000
     * @tc.name: SUB_Zlib_DeCompressFile_Func_2000
     * @tc.desc: inputFile is not exist.  There are no options
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Zlib_DeCompressFile_Func_2000', 0, async (done: Function) => {
      let zipPath:string = 'xxx.zip';
      let unzipDir:string = `${dir}/unzipDir019`;
      await fs.mkdir(unzipDir).then(data => {
        console.log(`unzipDir019 mkdir success:${data}`);
        expect(data).assertUndefined();
      }).catch((err: BusinessError) => {
        console.log(`unzipDir019 mkdir fail:${err}`);
        expect().assertFail();
      });
      try {
        zlib.decompressFile(zipPath, unzipDir, (res) => {
            if (!res) {
            console.log(`decompressFilePromise019 success :${JSON.stringify(res)}`);
              fs.rmdirSync(unzipDir);
              expect().assertFail();
              done();
            } else {
              console.log(`decompressFilePromise019 fail :${JSON.stringify(res)}`);
              fs.rmdirSync(unzipDir);
              expect(res.code).assertEqual(900001);
              done();
            };
        });
      } catch (err) {
        console.log(`decompressFilePromise019 catch:${JSON.stringify(err)}`)
        fs.rmdirSync(unzipDir);
        expect().assertFail();
        done();
      };
    });

    /*
     * @tc.number: SUB_Zlib_DeCompressFile_Func_2100
     * @tc.name: SUB_Zlib_DeCompressFile_Func_2100
     * @tc.desc: outPath is not exist.  There are no options
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Zlib_DeCompressFile_Func_2100', 0, async (done: Function) => {
      let filePath: string = `${dir}/test020.txt`;
      let zipPath: string = `${dir}/zipTest020.zip`;
      let unzipDir: string = `${dir}/unzipDir020`;
      let options: zlib.Options = {
        level: zlib.CompressLevel.COMPRESS_LEVEL_DEFAULT_COMPRESSION
      };
      let file:fs.File = fs.openSync(filePath, 0o100 | 0o2);
      await fs.write(file.fd, content).then(data => {
        console.log(`test020 write success:${data}`);
        expect(data>0).assertTrue();
      }).catch((err: BusinessError) => {
        console.log(`test020 write fail:${err}`);
        expect().assertFail();
      });
      await zlib.compressFile(filePath, zipPath, options).then(data => {
        console.log(`compressFile020 success:${data}`);
        expect(data).assertNull();
      }).catch((err: BusinessError) => {
        console.log(`compressFile020 fail:${err}`);
        expect(err).assertFail();
      });
      try {
        zlib.decompressFile(zipPath, unzipDir, (res) => {
          if (!res) {
            console.log(`decompressFilePromise020 success :${JSON.stringify(res)}`);
            expect().assertFail();
            done();
          } else {
            console.log(`decompressFilePromise020 fail :${JSON.stringify(res)}`);
            expect(res.code).assertEqual(900002);
            done();
          };
        });
      }catch (err) {
        console.log(`decompressFileCallback020 catch :${JSON.stringify(err)}`);
        expect().assertFail();
        done();
      };
    });

    /*
     * @tc.number: SUB_Zlib_DeCompressFile_Func_2200
     * @tc.name: SUB_Zlib_DeCompressFile_Func_2200
     * @tc.desc: input source is not zip format. There are no options
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Zlib_DeCompressFile_Func_2200', 0, async (done: Function) => {
      let filePath: string = `${dir}/test021.txt`;
      let unzipDir: string = `${dir}/unzipDir021`;
      let file:fs.File = fs.openSync(filePath, 0o100 | 0o2);
      await fs.write(file.fd, content).then(data => {
        console.log(`test021 write success:${data}`);
        expect(data>0).assertTrue();
      }).catch((err: BusinessError) => {
        console.log(`test021 write fail:${err}`);
        expect().assertFail();
      });
      //创建解压包存放目录
      await fs.mkdir(unzipDir).then(data => {
        console.log(`unzipDir021 mkdir success:${data}`);
        expect(data).assertUndefined();
      }).catch((err: BusinessError) => {
        console.log(`unzipDir021 mkdir fail:${err}`);
        expect(err).assertFail();
      });
      try {
        zlib.decompressFile(filePath, unzipDir, (res) => {
          if (res) {
            console.log(`decompressFileCallback021 fail :${JSON.stringify(res)}`);
            fs.rmdirSync(unzipDir);
            expect(res.code).assertEqual(900003);
            done();
          } else {
            console.log(`decompressFileCallback021 success :${JSON.stringify(res)}`);
            fs.rmdirSync(unzipDir);
            expect(res).assertFail();
            done();
          };
        });
      } catch (err) {
        console.log(`decompressFileCallback021 catch :${JSON.stringify(err)}`);
        fs.rmdirSync(unzipDir);
        expect().assertFail();
        done();
      };
    });

    /*
     * @tc.number: SUB_Zlib_DeCompressFile_Func_2300
     * @tc.name: SUB_Zlib_DeCompressFile_Func_2300
     * @tc.desc: inputFile path is parent directory
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Zlib_DeCompressFile_Func_2300', 0, async (done: Function) => {
      let filePath: string = `${dir}/test022.txt`;
      let zipDir: string = `${dir}/zipDir022`;
      let zipPath: string = `${zipDir}/zipTest022.zip`;
      let unzipDir: string = `${dir}/unzipDir022`;
      let options: zlib.Options = {
        level: zlib.CompressLevel.COMPRESS_LEVEL_DEFAULT_COMPRESSION
      };
      //创建压缩包存放目录
      await fs.mkdir(zipDir).then(data => {
        console.log(`zipDir022 mkdir success:${data}`);
        expect(data).assertUndefined();
      }).catch((err: BusinessError) => {
        console.log(`zipDir022 mkdir fail:${err}`);
        expect(err).assertFail();
      });
      let file:fs.File = fs.openSync(filePath, 0o100 | 0o2)
      await fs.write(file.fd, content).then(data => {
        console.log(`test022 write success:${data}`);
        expect(data>0).assertTrue();
      }).catch((err: BusinessError) => {
        console.log(`test022 write fail:${err}`);
        expect().assertFail();
      });
      await zlib.compressFile(filePath, zipPath, options).then(data => {
        console.log(`compressFile022 success:${data}`);
        let zipStat:fs.Stat = fs.statSync(zipPath);
        let isFile:boolean = zipStat.isFile();
        expect(isFile).assertTrue();
        let srcSize:number = fs.statSync(filePath).size;
        let zipSize:number = zipStat.size;
        expect(srcSize > zipSize).assertTrue();
        expect(data).assertNull();
      }).catch((err: BusinessError) => {
        console.log(`compressFile022 fail:${err}`);
        expect(err).assertFail();
      });
      //创建解压包存放目录
      await fs.mkdir(unzipDir).then(data => {
        console.log(`unzipDir022 mkdir success:${data}`);
        expect(data).assertUndefined();
      }).catch((err: BusinessError) => {
        console.log(`unzipDir022 mkdir fail:${err}`);
        expect(err).assertFail();
      });
      try {
        zlib.decompressFile(zipDir, unzipDir, options, (res) => {
          if (!res) {
            console.log(`decompressFileCallback022 success :${JSON.stringify(res)}`);
            fs.rmdirSync(unzipDir);
            fs.rmdirSync(zipDir);
            expect(res).assertFail();
            done();
          } else {
            console.log(`decompressFileCallback022 fail :${JSON.stringify(res)}`);
            fs.rmdirSync(unzipDir);
            fs.rmdirSync(zipDir);
            expect(res.code).assertEqual(900003);
            done();
          };
        });
      } catch (err) {
        console.log(`decompressFileCallback022 catch :${JSON.stringify(err)}`);
        fs.rmdirSync(unzipDir);
        fs.rmdirSync(zipDir);
        expect(err).assertFail();
        done();
      };
    });

    /*
     * @tc.number: SUB_Zlib_DeCompressFile_Func_2400
     * @tc.name: SUB_Zlib_DeCompressFile_Func_2400
     * @tc.desc: inputFile path is parent directory
     * @tc.size: MediumTest
     * @tc.type: Method
     * @tc.level: Level 2
     */
    it('SUB_Zlib_DeCompressFile_Func_2400', 0, async (done: Function) => {
      let filePath: string = `${dir}/test023.txt`;
      let zipDir: string = `${dir}/zipDir023`;
      let zipPath: string = `${zipDir}/zipTest023.zip`;
      let unzipDir: string = `${dir}/unzipDir023`;
      let options: zlib.Options = {
        level: zlib.CompressLevel.COMPRESS_LEVEL_DEFAULT_COMPRESSION
      };
      //创建压缩包存放目录
      await fs.mkdir(zipDir).then(data => {
        console.log(`zipDir023 mkdir success:${data}`);
        expect(data).assertUndefined();
      }).catch((err: BusinessError) => {
        console.log(`zipDir023 mkdir fail:${err}`);
        expect(err).assertFail();
      });
      let file:fs.File = fs.openSync(filePath, 0o100 | 0o2);
      await fs.write(file.fd, content).then(data => {
        console.log(`test023 write success:${data}`);
        expect(data>0).assertTrue();
      }).catch((err: BusinessError) => {
        console.log(`test023 write fail:${err}`);
        expect().assertFail();
      });
      await zlib.compressFile(filePath, zipPath, options).then(data => {
        console.log(`compressFile023 success:${data}`);
        let zipStat:fs.Stat = fs.statSync(zipPath);
        let isFile:boolean = zipStat.isFile();
        expect(isFile).assertTrue();
        let srcSize:number = fs.statSync(filePath).size;
        let zipSize:number = zipStat.size;
        expect(srcSize > zipSize).assertTrue();
        expect(data).assertNull();
      }).catch((err: BusinessError) => {
        console.log(`compressFile023 fail:${err}`);
        expect(err).assertFail();
      });
      //创建解压包存放目录
      await fs.mkdir(unzipDir).then(data => {
        console.log(`unzipDir023 mkdir success:${data}`);
        expect(data).assertUndefined();
      }).catch((err: BusinessError) => {
        console.log(`unzipDir023 mkdir fail:${err}`);
        expect(err).assertFail();
      });
      zlib.decompressFile(zipDir, unzipDir,options).then(res => {
        console.log(`decompressFilePromise023 success :${JSON.stringify(res)}`);
        fs.rmdirSync(unzipDir);
        fs.rmdirSync(zipDir);
        expect(res).assertFail();
        done();
      }).catch((err:BusinessError) => {
        console.log(`decompressFilePromise023 fail :${JSON.stringify(err)}`);
        expect(err.code).assertEqual(900003);
        fs.rmdirSync(unzipDir);
        fs.rmdirSync(zipDir);
        done();
      });
    });
  });
};

