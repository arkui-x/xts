/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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
import fastbuffer from '@ohos.fastbuffer';
import { afterEach, describe, expect, it, Level, Size, TestType } from '@ohos/hypium';

let TAG = ''

function sleep(time: number) {
  return new Promise<void>((resolve, reject) => {
    setTimeout(() => {
      resolve()
    }, time)
  }).then(() => {
    console.info(`sleep ${time} over...`)
  })
}

export default function WriteTest() {
  describe('WriteTest',  () => {
    afterEach(async (done: Function) => {
      await sleep(500);
      done();
    })

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITE_0100
     * @tc.name  : testFastbufferWrite0001
     * @tc.desc  : Test Write empty string at offset 0, expect 0 bytes written and empty buffer.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWrite0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWrite0001';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.alloc(0);
        let offset = buf.write("");
        expect(offset).assertEqual(0);
        let str = buf.toString();
        expect(str).assertEqual("");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITE_0200
     * @tc.name  : testFastbufferWrite0002
     * @tc.desc  : Test Write 'abcd' at offset 0, expect correct string retrieval.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWrite0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWrite0002';
      console.info(TAG + 'begin');
      let buf = fastbuffer.alloc(10);
      try {
        let offset = buf.write('abcd', 0);
        let str = buf.toString('utf-8', 0, 4);
        expect(str).assertEqual("abcd");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITE_0300
     * @tc.name  : testFastbufferWrite0003
     * @tc.desc  : Test Write 4 chars of 'abcdefgh' at offset 0, expect 4 bytes written.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWrite0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWrite0003';
      console.info(TAG + 'begin');
      let buf = fastbuffer.alloc(10);
      try {
        let offset = buf.write('abcdefgh', 0, 4);
        expect(offset).assertEqual(4);
        let str = buf.toString('utf-8', 0, 4);
        expect(str).assertEqual("abcd");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITE_0400
     * @tc.name  : testFastbufferWrite0004
     * @tc.desc  : Testing the write interface with normal value, offset, length, encoding.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWrite0004", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWrite0004';
      console.info(TAG + 'begin');
      let buf = fastbuffer.alloc(10);
      try {
        let offset = buf.write('abcdefgh', 0, 4, 'utf8');
        expect(offset).assertEqual(4);
        let str = buf.toString('utf-8', 0, 4);
        expect(str).assertEqual("abcd");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITE_0500
     * @tc.name  : testFastbufferWrite0005
     * @tc.desc  : Test Writes string to buf at offset according to the character encoding in encoding.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferWrite0005", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferWrite0005';
      console.info(TAG + 'begin');
      let buf = fastbuffer.alloc(8);
      try {
        let offset = buf.write("abcde", -1);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEBIGINT64BE_0100
     * @tc.name  : testFastbufferWriteBigInt64BE0001
     * @tc.desc  : Testing the writeBigInt64BE interface with two parameters: BigInt(0x0102030405060708) and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteBigInt64BE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteBigInt64BE0001';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(8);
        let ref = buf.writeBigInt64BE(BigInt(0x0102030405060708), 0);
        expect(ref).assertEqual(8);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEBIGINT64BE_0200
     * @tc.name  : testFastbufferWriteBigInt64BE0002
     * @tc.desc  : Testing the writeBigInt64BE interface with two parameters: BigInt(0x0102030405060708) and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteBigInt64BE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteBigInt64BE0002';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(8);
        let ref = buf.writeBigInt64BE(BigInt(0x0102030405060708));
        expect(ref).assertEqual(8);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEBIGINT64BE_0300
     * @tc.name  : testFastbufferWriteBigInt64BE0003
     * @tc.desc  : Test Writes value to buf at the specified offset as big-endian.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferWriteBigInt64BE0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferWriteBigInt64BE0003';
      console.info(TAG + 'begin');
      let buf = fastbuffer.allocUninitializedFromPool(8);
      try {
        let ref = buf.writeBigInt64BE(0x0102030405060708n, 1);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEBIGINT64LE_0100
     * @tc.name  : testFastbufferWriteBigInt64LE0001
     * @tc.desc  : Testing the writeBigInt64LE interface with two parameters: BigInt(0x0102030405060708) and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteBigInt64LE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteBigInt64LE0001';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(8);
        let ref = buf.writeBigInt64LE(BigInt(0x0102030405060708), 0);
        expect(ref).assertEqual(8);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEBIGINT64LE_0200
     * @tc.name  : testFastbufferWriteBigInt64LE0002
     * @tc.desc  : Testing the writeBigInt64LE interface with two parameters: BigInt(0x0102030405060708) and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteBigInt64LE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteBigInt64LE0002';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(8);
        let ref = buf.writeBigInt64LE(BigInt(0x0102030405060708));
        expect(ref).assertEqual(8);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEBIGINT64LE_0300
     * @tc.name  : testFastbufferWriteBigInt64LE0003
     * @tc.desc  : Test Writes value to buf at the specified offset as little-endian.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferWriteBigInt64LE0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferWriteBigInt64LE0003';
      console.info(TAG + 'begin');
      let buf = fastbuffer.allocUninitializedFromPool(8);
      try {
        let ref = buf.writeBigInt64LE(0x0102030405060708n, 1);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEBIGUINT64BE_0100
     * @tc.name  : testFastbufferWriteBigUInt64BE0001
     * @tc.desc  : Testing the WriteBigUInt64BE interface with two parameters: BigInt(0xdecafafecacefade) and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteBigUInt64BE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteBigUInt64BE0001';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(8);
        let ref = buf.writeBigUInt64BE(BigInt(0xdecafafecacefade), 0);
        expect(ref).assertEqual(8);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEBIGUINT64BE_0200
     * @tc.name  : testFastbufferWriteBigUInt64BE0002
     * @tc.desc  : Testing the WriteBigUInt64BE interface with parameter: BigInt(0xdecafafecacefade)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteBigUInt64BE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteBigUInt64BE0002';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(8);
        let ref = buf.writeBigUInt64BE(BigInt(0xdecafafecacefade));
        expect(ref).assertEqual(8);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEBIGUINT64BE_0300
     * @tc.name  : testFastbufferWriteBigUInt64BE0003
     * @tc.desc  : Test Writes value to buf at the specified offset as big-endian.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferWriteBigUInt64BE0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferWriteBigUInt64BE0003';
      console.info(TAG + 'begin');
      let buf = fastbuffer.allocUninitializedFromPool(8);
      try {
        let ref = buf.writeBigUInt64BE(0xdecafafecacefaden, 1);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEBIGUINT64LE_0100
     * @tc.name  : testFastbufferWriteBigUInt64LE0001
     * @tc.desc  : Testing the writeBigUInt64LE interface with two parameters: BigInt(0xdecafafecacefade) and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteBigUInt64LE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteBigUInt64LE0001';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(8);
        let ref = buf.writeBigUInt64LE(BigInt(0xdecafafecacefade), 0);
        expect(ref).assertEqual(8);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEBIGUINT64LE_0200
     * @tc.name  : testFastbufferWriteBigUInt64LE0002
     * @tc.desc  : Testing the writeBigUInt64LE interface with two parameter: BigInt(0xdecafafecacefade)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteBigUInt64LE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteBigUInt64LE0002';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(8);
        let ref = buf.writeBigUInt64LE(BigInt(0xdecafafecacefade));
        expect(ref).assertEqual(8);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEBIGUINT64LE_0300
     * @tc.name  : testFastbufferWriteBigUInt64LE0003
     * @tc.desc  : Test Writes value to buf at the specified offset as little-endian.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferWriteBigUInt64LE0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferWriteBigUInt64LE0003';
      console.info(TAG + 'begin');
      let buf = fastbuffer.allocUninitializedFromPool(8);
      try {
        let ref = buf.writeBigUInt64LE(0xdecafafecacefaden, 1);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEDOUBLEBE_0100
     * @tc.name  : testFastbufferWriteDoubleBE0001
     * @tc.desc  : Testing the writeDoubleBE interface with two parameters: 123.456 and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteDoubleBE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteDoubleBE0001';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(8);
        let ref = buf.writeDoubleBE(123.456, 0);
        expect(ref).assertEqual(8);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEDOUBLEBE_0200
     * @tc.name  : testFastbufferWriteDoubleBE0002
     * @tc.desc  : Testing the writeDoubleBE interface with two parameters: 123.456 and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteDoubleBE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteDoubleBE0002';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(8);
        let ref = buf.writeDoubleBE(123.456);
        expect(ref).assertEqual(8);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEDOUBLEBE_0300
     * @tc.name  : testFastbufferWriteDoubleBE0003
     * @tc.desc  : Test Writes value to buf at the specified offset as big-endian.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferWriteDoubleBE0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferWriteDoubleBE0003';
      console.info(TAG + 'begin');
      let buf = fastbuffer.allocUninitializedFromPool(8);
      try {
        let ref = buf.writeDoubleBE(123.456, 1);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEDOUBLELE_0100
     * @tc.name  : testFastbufferWriteDoubleLE0001
     * @tc.desc  : Testing the writeDoubleLE interface with two parameters: 123.456 and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteDoubleLE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteDoubleLE0001';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(8);
        let ref = buf.writeDoubleLE(123.456, 0);
        expect(ref).assertEqual(8);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEDOUBLELE_0200
     * @tc.name  : testFastbufferWriteDoubleLE0002
     * @tc.desc  : Testing the writeDoubleLE interface with two parameters: 123.456 and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteDoubleLE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteDoubleLE0002';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(8);
        let ref = buf.writeDoubleLE(123.456);
        expect(ref).assertEqual(8);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEDOUBLELE_0300
     * @tc.name  : testFastbufferWriteDoubleLE0003
     * @tc.desc  : Test Writes value to buf at the specified offset as little-endian.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferWriteDoubleLE0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferWriteDoubleLE0003';
      console.info(TAG + 'begin');
      let buf = fastbuffer.allocUninitializedFromPool(8);
      try {
        let ref = buf.writeDoubleLE(123.456, 1);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEFLOATBE_0100
     * @tc.name  : testFastbufferWriteFloatBE0001
     * @tc.desc  : Testing the writeFloatBE interface with two parameters: 0xcafebabe and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteFloatBE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteFloatBE0001';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(8);
        let ref = buf.writeFloatBE(0xcafebabe, 0);
        expect(ref).assertEqual(4);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEFLOATBE_0200
     * @tc.name  : testFastbufferWriteFloatBE0002
     * @tc.desc  : Testing the writeFloatBE interface with two parameters: 0xcafebabe and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteFloatBE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteFloatBE0002';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(8);
        let ref = buf.writeFloatBE(0xcafebabe);
        expect(ref).assertEqual(4);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEFLOATBE_0300
     * @tc.name  : testFastbufferWriteFloatBE0003
     * @tc.desc  : Test Writes value to buf at the specified offset as big-endian.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferWriteFloatBE0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferWriteFloatBE0003';
      console.info(TAG + 'begin');
      let buf = fastbuffer.allocUninitializedFromPool(4);
      try {
        let ref = buf.writeFloatBE(0xcabcbcbc, 5);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEFLOATLE_0100
     * @tc.name  : testFastbufferWriteFloatLE0001
     * @tc.desc  : Testing the writeFloatLE interface with two parameters: 0xcafebabe and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteFloatLE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteFloatLE0001';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(8);
        let ref = buf.writeFloatLE(0xcafebabe, 0);
        expect(ref).assertEqual(4);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEFLOATLE_0200
     * @tc.name  : testFastbufferWriteFloatLE0002
     * @tc.desc  : Testing the writeFloatLE interface with two parameters: 0xcafebabe and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteFloatLE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteFloatLE0002';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(8);
        let ref = buf.writeFloatLE(0xcafebabe);
        expect(ref).assertEqual(4);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEFLOATLE_0300
     * @tc.name  : testFastbufferWriteFloatLE0003
     * @tc.desc  : Test Writes value to buf at the specified offset as little-endian.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferWriteFloatLE0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferWriteFloatLE0003';
      console.info(TAG + 'begin');
      let buf = fastbuffer.allocUninitializedFromPool(4);
      try {
        let ref = buf.writeFloatLE(0xcabcbcbc, 5);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEINT8_0100
     * @tc.name  : testFastbufferWriteInt80001
     * @tc.desc  : Testing the writeInt8 interface with value to buf at the specified offset value must be a valid signed 8-bit integer.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteInt80001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteInt80001';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(2);
        let ref = buf.writeInt8(2, 0);
        expect(ref).assertEqual(1);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEINT8_0200
     * @tc.name  : testFastbufferWriteInt80002
     * @tc.desc  : Testing the writeInt8 interface with value to buf at the specified offset value must be a valid signed 8-bit integer.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteInt80002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteInt80002';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(2);
        let ref = buf.writeInt8(2);
        expect(ref).assertEqual(1);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEINT8_0300
     * @tc.name  : testFastbufferWriteInt80003
     * @tc.desc  : Test Writes value to buf at the specified offset value must be a valid signed 8-bit integer.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferWriteInt80003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferWriteInt80003';
      console.info(TAG + 'begin');
      let buf = fastbuffer.allocUninitializedFromPool(2);
      try {
        let ref = buf.writeInt8(2, -1);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEINT16BE_0100
     * @tc.name  : testFastbufferWriteInt16BE0001
     * @tc.desc  : Testing the writeInt16BE interface with two parameters: 0x0102 and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteInt16BE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteInt16BE0001';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.alloc(2);
        let ref = buf.writeInt16BE(0x0102, 0);
        expect(ref).assertEqual(2);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEINT16BE_0200
     * @tc.name  : testFastbufferWriteInt16BE0002
     * @tc.desc  : Testing the writeInt16BE interface with two parameters: 0x0102 and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteInt16BE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteInt16BE0002';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.alloc(2);
        let ref = buf.writeInt16BE(0x0102);
        expect(ref).assertEqual(2);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEINT16BE_0300
     * @tc.name  : testFastbufferWriteInt16BE0003
     * @tc.desc  : Writes value to buf at the specified offset as big-endian The value must be a valid signed 16-bit integer.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferWriteInt16BE0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferWriteInt16BE0003';
      console.info(TAG + 'begin');
      let buf = fastbuffer.alloc(2);
      try {
        let ref = buf.writeInt16BE(0x7bca, -1);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEINT16LE_0100
     * @tc.name  : testFastbufferWriteInt16LE0001
     * @tc.desc  : Testing the writeInt16LE interface with two parameters: 0x0304 and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteInt16LE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteInt16LE0001';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.alloc(2);
        let ref = buf.writeInt16LE(0x0304, 0);
        expect(ref).assertEqual(2);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEINT16LE_0200
     * @tc.name  : testFastbufferWriteInt16LE0002
     * @tc.desc  : Testing the writeInt16LE interface with two parameters: 0x0304 and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteInt16LE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteInt16LE0002';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.alloc(2);
        let ref = buf.writeInt16LE(0x0304);
        expect(ref).assertEqual(2);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEINT16LE_0300
     * @tc.name  : testFastbufferWriteInt16LE0003
     * @tc.desc  : Writes value to buf at the specified offset as little-endian The value must be a valid signed 16-bit integer.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferWriteInt16LE0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferWriteInt16LE0003';
      console.info(TAG + 'begin');
      let buf = fastbuffer.alloc(2);
      try {
        let ref = buf.writeInt16LE(0x7bca, -1);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEINT32BE_0100
     * @tc.name  : testFastbufferWriteInt32BE0001
     * @tc.desc  : Testing the writeInt32BE interface with two parameters: 0x01020304 and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteInt32BE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteInt32BE0001';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.alloc(4);
        let ref = buf.writeInt32BE(0x01020304, 0);
        expect(ref).assertEqual(4);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEINT32BE_0200
     * @tc.name  : testFastbufferWriteInt32BE0002
     * @tc.desc  : Testing the writeInt32BE interface with two parameters: 0x01020304 and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteInt32BE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteInt32BE0002';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.alloc(4);
        let ref = buf.writeInt32BE(0x01020304);
        expect(ref).assertEqual(4);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEINT32BE_0300
     * @tc.name  : testFastbufferWriteInt32BE0003
     * @tc.desc  : Writes value to buf at the specified offset as big-endian The value must be a valid signed 32-bit integer.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferWriteInt32BE0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferWriteInt32BE0003';
      console.info(TAG + 'begin');
      let buf = fastbuffer.alloc(4);
      try {
        let ref = buf.writeInt32BE(0x12345678, -1);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEINT32LE_0100
     * @tc.name  : testFastbufferWriteInt32LE0001
     * @tc.desc  : Testing the writeInt32LE interface with two parameters: 0x05060708 and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteInt32LE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteInt32LE0001';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.alloc(4);
        let ref = buf.writeInt32LE(0x05060708, 0);
        expect(ref).assertEqual(4);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEINT32LE_0200
     * @tc.name  : testFastbufferWriteInt32LE0002
     * @tc.desc  : Testing the writeInt32LE interface with two parameters: 0x05060708 and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteInt32LE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteInt32LE0002';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.alloc(4);
        let ref = buf.writeInt32LE(0x05060708);
        expect(ref).assertEqual(4);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEINT32LE_0300
     * @tc.name  : testFastbufferWriteInt32LE0003
     * @tc.desc  : Writes value to buf at the specified offset as little-endian The value must be a valid signed 32-bit integer.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferWriteInt32LE0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferWriteInt32LE0003';
      console.info(TAG + 'begin');
      let buf = fastbuffer.alloc(4);
      try {
        let ref = buf.writeInt32LE(0x12345678, -1);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEINTBE_0100
     * @tc.name  : testFastbufferWriteIntBE0001
     * @tc.desc  : Testing the writeIntBE interface with three parameters: 0x1234567890ab, 0, 6.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteIntBE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteIntBE0001';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(6);
        let ref = buf.writeIntBE(0x1234567890ab, 0, 6);
        expect(ref).assertEqual(6);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEINTBE_0200
     * @tc.name  : testFastbufferWriteIntBE0002
     * @tc.desc  : Writes byteLength bytes of value to buf at the specified offset as big-endian.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferWriteIntBE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferWriteIntBE0002';
      console.info(TAG + 'begin');
      let buf = fastbuffer.allocUninitializedFromPool(6);
      try {
        let ref = buf.writeIntBE(0x1234567890ab, 1, 6);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEINTLE_0100
     * @tc.name  : testFastbufferWriteIntLE0001
     * @tc.desc  : Testing the writeIntLE interface with three parameters: 0x1234567890ab, 0, 6.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteIntLE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteIntLE0001';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(6);
        let ref = buf.writeIntLE(0x1234567890ab, 0, 6);
        expect(ref).assertEqual(6);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEINTLE_0200
     * @tc.name  : testFastbufferWriteIntLE0002
     * @tc.desc  : Writes byteLength bytes of value to buf at the specified offset as little-endian.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferWriteIntLE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferWriteIntLE0002';
      console.info(TAG + 'begin');
      let buf = fastbuffer.allocUninitializedFromPool(6);
      try {
        let ref = buf.writeIntLE(0x1234567890ab, 1, 6);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEUINT8_0100
     * @tc.name  : testFastbufferWriteUInt80001
     * @tc.desc  : Testing the writeUInt8 interface with two parameters: 0x42 and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteUInt80001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteUInt80001';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(4);
        let ref = buf.writeUInt8(0x3, 0);
        expect(ref).assertEqual(1);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEUINT8_0200
     * @tc.name  : testFastbufferWriteUInt80002
     * @tc.desc  : Testing the writeUInt8 interface with two parameters: 0x42 and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteUInt80002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteUInt80002';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(4);
        let ref = buf.writeUInt8(0x3);
        expect(ref).assertEqual(1);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEUINT8_0300
     * @tc.name  : testFastbufferWriteUInt80003
     * @tc.desc  : Writes value to buf at the specified offset. value must be a valid unsigned 8-bit integer.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferWriteUInt80003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferWriteUInt80003';
      console.info(TAG + 'begin');
      let buf = fastbuffer.allocUninitializedFromPool(4);
      try {
        let ref = buf.writeUInt8(0x42, -1);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEUINT16BE_0100
     * @tc.name  : testFastbufferWriteUInt16BE0001
     * @tc.desc  : Testing the writeUInt16BE interface with two parameters: 0xdead and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteUInt16BE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteUInt16BE0001';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(4);
        let ref = buf.writeUInt16BE(0xdead, 0);
        expect(ref).assertEqual(2);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEUINT16BE_0200
     * @tc.name  : testFastbufferWriteUInt16BE0002
     * @tc.desc  : Testing the writeUInt16BE interface with two parameters: 0xdead and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteUInt16BE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteUInt16BE0002';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(4);
        let ref = buf.writeUInt16BE(0xdead);
        expect(ref).assertEqual(2);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEUINT16BE_0300
     * @tc.name  : testFastbufferWriteUInt16BE0003
     * @tc.desc  : Writes value to buf at the specified offset as big-endian.
     *           The value must be a valid unsigned 16-bit integer.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferWriteUInt16BE0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferWriteUInt16BE0003';
      console.info(TAG + 'begin');
      let buf = fastbuffer.allocUninitializedFromPool(4);
      try {
        let ref = buf.writeUInt16BE(0xdeadfc, 0);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEUINT16LE_0100
     * @tc.name  : testFastbufferWriteUInt16LE0001
     * @tc.desc  : Testing the writeUInt16LE interface with two parameters: 0xdead and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteUInt16LE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteUInt16LE0001';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(4);
        let ref = buf.writeUInt16LE(0xdead, 0);
        expect(ref).assertEqual(2);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEUINT16LE_0200
     * @tc.name  : testFastbufferWriteUInt16LE0002
     * @tc.desc  : Testing the writeUInt16LE interface with two parameters: 0xdead and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteUInt16LE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteUInt16LE0002';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(4);
        let ref = buf.writeUInt16LE(0xdead);
        expect(ref).assertEqual(2);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEUINT16LE_0300
     * @tc.name  : testFastbufferWriteUInt16LE0003
     * @tc.desc  : Writes value to buf at the specified offset as little-endian The value must be a valid unsigned 16-bit integer.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferWriteUInt16LE0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferWriteUInt16LE0003';
      console.info(TAG + 'begin');
      let buf = fastbuffer.allocUninitializedFromPool(4);
      try {
        let ref = buf.writeUInt16LE(0xdeadfc, 0);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEUINT32BE_0100
     * @tc.name  : testFastbufferWriteUInt32BE0001
     * @tc.desc  : Testing the writeUInt32BE interface with two parameters: 0xfeedface and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteUInt32BE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteUInt32BE0001';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(4);
        let ref = buf.writeUInt32BE(0xfeedface, 0);
        expect(ref).assertEqual(4);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEUINT32BE_0200
     * @tc.name  : testFastbufferWriteUInt32BE0002
     * @tc.desc  : Testing the writeUInt32BE interface with two parameters: 0xfeedface and 0.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteUInt32BE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteUInt32BE0002';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(4);
        let ref = buf.writeUInt32BE(0xfeedface);
        expect(ref).assertEqual(4);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEUINT32BE_0300
     * @tc.name  : testFastbufferWriteUInt32BE0003
     * @tc.desc  : Writes value to buf at the specified offset as big-endian The value must be a valid unsigned 32-bit integer.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferWriteUInt32BE0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferWriteUInt32BE0003';
      console.info(TAG + 'begin');
      let buf = fastbuffer.allocUninitializedFromPool(4);
      try {
        let ref = buf.writeUInt32BE(0xfeedface, -1);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEUINT32LE_0100
     * @tc.name  : testFastbufferWriteUInt32LE0001
     * @tc.desc  : Testing writeUInt32LE with value '0xfeedface, 0'.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteUInt32LE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteUInt32LE0001';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(4);
        let ref = buf.writeUInt32LE(0xfeedface, 0);
        expect(ref).assertEqual(4);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEUINT32LE_0200
     * @tc.name  : testFastbufferWriteUInt32LE0002
     * @tc.desc  : Testing writeUInt32LE with value '0xfeedface, 0'.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteUInt32LE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteUInt32LE0002';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(4);
        let ref = buf.writeUInt32LE(0xfeedface);
        expect(ref).assertEqual(4);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEUINT32LE_0300
     * @tc.name  : testFastbufferWriteUInt32LE0003
     * @tc.desc  : Writes value to buf at the specified offset as little-endian The value must be a valid unsigned 32-bit integer.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferWriteUInt32LE0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferWriteUInt32LE0003';
      console.info(TAG + 'begin');
      let buf = fastbuffer.allocUninitializedFromPool(4);
      try {
        let ref = buf.writeUInt32LE(0xfeedface, -1);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEUINTBE_0100
     * @tc.name  : testFastbufferWriteUIntBE0001
     * @tc.desc  : Testing writeUIntBE with value '0x1234567890ab, 0, 6'.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteUIntBE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteUIntBE0001';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(6);
        let ref = buf.writeUIntBE(0x13141516, 0, 6);
        expect(ref).assertEqual(6);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEUINTBE_0200
     * @tc.name  : testFastbufferWriteUIntBE0002
     * @tc.desc  : Writes byteLength bytes of value to buf at the specified offset as big-endian.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferWriteUIntBE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferWriteUIntBE0002';
      console.info(TAG + 'begin');
      let buf = fastbuffer.allocUninitializedFromPool(4);
      try {
        let ref = buf.writeUIntBE(0x13141516, 0, 1);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEUINTLE_0100
     * @tc.name  : testFastbufferWriteUIntLE0001
     * @tc.desc  : Testing writeUIntLE with value '0x1234567890ab, 0, 6'.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferWriteUIntLE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferWriteUIntLE0001';
      console.info(TAG + 'begin');
      try {
        let buf = fastbuffer.allocUninitializedFromPool(6);
        let ref = buf.writeUIntLE(0x1234567890ab, 0, 6);
        expect(ref).assertEqual(6);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_WRITEUINTLE_0200
     * @tc.name  : testFastbufferWriteUIntLE0002
     * @tc.desc  : Writes byteLength bytes of value to buf at the specified offset as little-endian.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferWriteUIntLE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferWriteUIntLE0002';
      console.info(TAG + 'begin');
      let buf = fastbuffer.allocUninitializedFromPool(4);
      try {
        let ref = buf.writeUIntLE(0x13141516, 0, 1);
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });
  })
}