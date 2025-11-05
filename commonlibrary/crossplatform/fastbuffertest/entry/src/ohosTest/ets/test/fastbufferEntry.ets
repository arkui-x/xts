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

let TAG = "";

function sleep(time: number) {
  return new Promise<void>((resolve, reject) => {
    setTimeout(() => {
      resolve()
    }, time)
  }).then(() => {
    console.info(`sleep ${time} over...`)
  })
}

export default function EntryTest() {
  describe('EntryTest', () => {
    afterEach(async (done: Function) => {
      await sleep(500);
      done();
    })

    /*
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_ALLOC_0100
     * @tc.name  : testFastbufferAlloc0001
     * @tc.desc  : Testing alloc for parameter with size fill and encoding.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
    */
    it('testFastbufferAlloc0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferAlloc0001";
      try {
        let buf = fastbuffer.alloc(5, 'abc', 'utf8');
        let str = buf.toString();
        expect(str).assertEqual('abcab');
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    })

    /*
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_ALLOC_0200
     * @tc.name  : testFastbufferAlloc0002
     * @tc.desc  : Testing alloc interface with normal size.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it('testFastbufferAlloc0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferAlloc0002";
      try {
        let size = 5;
        let buf = fastbuffer.alloc(size);
        expect(buf.length).assertEqual(size);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    })

    /*
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_ALLOC_0300
     * @tc.name  : testFastbufferAlloc0003
     * @tc.desc  : Testing alloc for parameter with size and fill.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it('testFastbufferAlloc0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferAlloc0003";
      try {
        let buf = fastbuffer.alloc(5, 'a');
        let str = buf.toString();
        expect(str).assertEqual('aaaaa');
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    })

    /*
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_ALLOCUNINITIALIZEDFROMPOOL_0100
     * @tc.name  : testFastbufferAllocUninitializedFromPool0001
     * @tc.desc  : Testing allocUninitializedFromPool interface with normal size.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it('testFastbufferAllocUninitializedFromPool0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferAllocUninitializedFromPool0001";
      try {
        let size = 5;
        let buf = fastbuffer.allocUninitializedFromPool(size);
        expect(buf.length).assertEqual(size);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    })

    /*
      * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_ALLOCUNINITIALIZED_0100
      * @tc.name  : testFastbufferAllocUninitialized0001
      * @tc.desc  : Testing allocUninitialized interface with normal size.
      * @tc.size  : MediumTest
      * @tc.type  : Function
      * @tc.level : Level 1
      */
    it('testFastbufferAllocUninitialized0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferAllocUninitialized0001";
      try {
        let size = 5;
        let buf = fastbuffer.allocUninitialized(size);
        expect(buf.length).assertEqual(size);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    })

    /*
    * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_BYTELENGTH_0100
    * @tc.name  : testFastbufferByteLength0001
    * @tc.desc  : Testing byteLength for fastbuffer with value '\u00bd + \u00bc = \u00be'.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : Level 1
    */
    it('testFastbufferByteLength0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferByteLength0001";
      try {
        let str = '\u00bd + \u00bc = \u00be';
        expect(fastbuffer.byteLength(str, 'utf-8')).assertEqual(12);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /*
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_BYTELENGTH_0200
     * @tc.name  : testFastbufferByteLength0002
     * @tc.desc  : Testing byteLength for fastbuffer with normal value.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it('testFastbufferByteLength0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferByteLength0002";
      try {
        let byteLen = fastbuffer.byteLength("buffer");
        expect(byteLen).assertEqual(6);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /*
    * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_CONCAT_0100
    * @tc.name  : testFastbufferConcat0001
    * @tc.desc  : Testing concat with value 'qwertyu, asdfghj' test truncate.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : Level 1
    */
    it('testFastbufferConcat0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferConcat0001";
      let buf1 = fastbuffer.from("qwertyu");
      let buf2 = fastbuffer.from("asdfghj");
      try {
        let buf = fastbuffer.concat([buf1, buf2], 4);
        let str = buf.toString();
        expect(str).assertEqual("qwer");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /*
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_CONCAT_0200
     * @tc.name  : testFastbufferConcat0002
     * @tc.desc  : Testing concat with value '0x01,0x2,0x3, 0x1,0x2,0x3' test truncate.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it('testFastbufferConcat0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferConcat0002";
      let buf1 = Uint8Array.from([0x01, 0x2, 0x3]);
      let buf2 = Uint8Array.from([0x1, 0x2, 0x3]);
      try {
        let buf = fastbuffer.concat([buf1, buf2]);
        const byteArray = new Uint8Array(buf.buffer, buf.byteOffset, buf.length);
        const str = Array.from(byteArray).join(',');
        expect(str).assertEqual("1,2,3,1,2,3");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /*
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_CONCAT_0300
     * @tc.name  : testFastbufferConcat0003
     * @tc.desc  : Testing concat with value '1145, 1414'.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it('testFastbufferConcat0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferConcat0003";
      try {
        let buf1 = fastbuffer.from("1145");
        let buf2 = fastbuffer.from("1414");
        let buf = fastbuffer.concat([buf1, buf2]);
        let str = buf.toString();
        expect(str).assertEqual("11451414");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /*
     * @tc.number:SUB_COMMONLIBRARY_FASTBUFFER_CONCAT_0400
     * @tc.name: testFastbufferConcat0004
     * @tc.desc: Testing error 10200001
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 2
     */
    it("testFastbufferConcat0004", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      let buf1 = fastbuffer.from("123$");
      let buf2 = fastbuffer.from("*35");
      try {
        let buf = fastbuffer.concat([buf1, buf2], -1);
      } catch (err) {
        expect(err.code).assertEqual(10200001);
      }
    });

    /*
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_FROM_0100
     * @tc.name  : testFastbufferFrom0001
     * @tc.desc  : Copies the passed buffer data onto a new Buffer instance.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferFrom0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferFrom0001";
      try {
        let buf = fastbuffer.from([0x12, 0x34, 0x56]);
        let str = buf.toString("hex");
        expect(str).assertEqual("123456");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /*
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_FROM_0200
     * @tc.name  : testFastbufferFrom0002
     * @tc.desc  : Copies the passed buffer data onto a new Buffer instance.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferFrom0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferFrom0002";
      try {
        let buf = fastbuffer.from([0x12, 0x34, 0x100]);
        let str = buf.toString("hex");
        expect(str).assertEqual("123400");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /*
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_FROM_0300
     * @tc.name  : testFastbufferFrom0003
     * @tc.desc  : Test the from interface create by uint8array base test.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferFrom0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferFrom0003";
      try {
        let uint8Array = new Uint8Array(10);
        let buf = fastbuffer.from(uint8Array, 3, 4);
        buf.fill(1)
        const bufArray = new Uint8Array(buf.buffer, buf.byteOffset, buf.length);
        const result = bufArray.join(',');
        expect(result).assertEqual('1,1,1,1,1,1,1,1,1,1');
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /*
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_FROM_0400
     * @tc.name  : testFastbufferFrom0004
     * @tc.desc  : Test the from interface create by uint8array base test.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferFrom0004", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferFrom0004";
      try {
        let uint8Array = new Uint8Array(10);
        let buf3 = fastbuffer.from(uint8Array);
        buf3.fill(1)
        expect(uint8Array.toString()).assertEqual('1,1,1,1,1,1,1,1,1,1');
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /*
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_FROM_0500
     * @tc.name  : testFastbufferFrom0002
     * @tc.desc  : Test the from interface create by uint8array base test.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferFrom0005", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferFrom0005";
      try {
        let uint8Array = new Uint8Array(10);
        let buf3 = fastbuffer.from(uint8Array, 0);
        buf3.fill(1)
        expect(uint8Array.toString()).assertEqual('1,1,1,1,1,1,1,1,1,1');
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /*
     * @tc.number:SUB_COMMONLIBRARY_FASTBUFFER_FROM_0600
     * @tc.name  : testFastbufferFrom0006
     * @tc.desc  : Testing error 10200001.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferFrom0006", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      try {
        let arrBuf = new ArrayBuffer(10);
        let buf1 = fastbuffer.from(arrBuf, -1);
      } catch (err) {
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number:SUB_COMMONLIBRARY_FASTBUFFER_FROM_0700
     * @tc.name  : testFastbufferFrom0007
     * @tc.desc  : Test the from interface by Copping the passed fastbuffer data onto a new Buffer instance.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferFrom0007", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferFrom0007";
      try {
        const buf1 = fastbuffer.from('auffer');
        const buf2 = fastbuffer.from(buf1);
        buf1[0] = 0x63;
        let str = buf1.toString();
        expect(str).assertEqual("cuffer");
        str = buf2.toString();
        expect(str).assertEqual("auffer");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_FROM_0800
     * @tc.name  : testFastbufferFrom0008
     * @tc.desc  : Test the from interface by Copping the passed fastbuffer data onto a new Buffer instance.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferFrom0008", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferFrom0008";
      try {
        const buf1 = Uint8Array.from([0x64, 0x65, 0x66]);
        const buf2 = fastbuffer.from(buf1);
        let str = buf2.toString();
        expect(str).assertEqual("def");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_FROM_0900
     * @tc.name  : testFastbufferFrom0009
     * @tc.desc  : Test the from interface create by hex string base test.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferFrom0009", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferFrom0009";
      try {
        let buf2 = fastbuffer.from('7468697320697320612074c3a97374', 'hex');
        expect(buf2.toString()).assertEqual('this is a tést');
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_FROM_1000
     * @tc.name  : testFastbufferFrom0010
     * @tc.desc  : Test the from interface create by string base test.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferFrom0010", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferFrom0010";
      try {
        let buf1 = fastbuffer.from('this is a test');
        expect(buf1.toString()).assertEqual('this is a test');
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /*
    * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_ISBUFFER_0100
    * @tc.name  : testFastbufferIsBuffer0001
    * @tc.desc  : Testing isBuffer for fastbuffer with normal value.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : Level 1
    */
    it('testFastbufferIsBuffer0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferIsBuffer0001";
      try {
        let buf = fastbuffer.alloc(4);
        let flag = fastbuffer.isBuffer(buf);
        expect(flag).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /*
    * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_ISBUFFER_0200
    * @tc.name  : testFastbufferIsBuffer0002
    * @tc.desc  : Testing isBuffer for fastbuffer with object value.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : Level 1
    */
    it('testFastbufferIsBuffer0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferIsBuffer0002";
      try {
        let obj = new Object(2);
        let flag = fastbuffer.isBuffer(obj);
        expect(flag).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /*
    * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_ISENCODING_0100
    * @tc.name  : testFastbufferIsEncoding0001
    * @tc.desc  : Testing isEncoding for fastbuffer with normal value.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : Level 1
    */
    it('testFastbufferIsEncoding0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferIsEncoding0001";
      try {
        let encodeArr = ['utf8', 'utf-8', 'ucs2', 'ucs-2', 'ascii', 'latin1', 'binary',
          'utf16le', 'utf-16le', 'base64', 'base64url', 'hex'];
        for (const encode of encodeArr) {
          let flag = fastbuffer.isEncoding(encode);
          expect(flag).assertEqual(true);
        }
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /*
    * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_ISENCODING_0200
    * @tc.name  : testFastbufferIsEncoding0002
    * @tc.desc  : Testing isEncoding for fastbuffer with value 'utf/8'.
    * @tc.size  : MediumTest
    * @tc.type  : Function
    * @tc.level : Level 1
    */
    it('testFastbufferIsEncoding0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferIsEncoding0002";
      try {
        let flag = fastbuffer.isEncoding('utf/8');
        expect(flag).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /*
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_ISENCODING_0300
     * @tc.name  : testFastbufferIsEncoding0003
     * @tc.desc  : Testing isEncoding for fastbuffer with value null.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it('testFastbufferIsEncoding0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferIsEncoding0003";
      try {
        let flag = fastbuffer.isEncoding(null);
        expect(flag).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });
    /*
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_COMPARE_0100
     * @tc.name  : testFastbufferCompare0001
     * @tc.desc  : Testing compare with value '比较$&*' and '比较$&*'.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it('testFastbufferCompare0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferCompare0001";
      try {
        let buf1 = fastbuffer.from("比较$&*");
        let buf2 = fastbuffer.from("比较$&*");
        let res = fastbuffer.compare(buf1, buf2);
        expect(res).assertEqual(0);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /*
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_COMPARE_0200
     * @tc.name  : testFastbufferCompare0002
     * @tc.desc  : Testing compare with value '1234' and '0123'.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it('testFastbufferCompare0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferCompare0002";
      try {
        let buf1 = fastbuffer.from("1234");
        let buf2 = fastbuffer.from("0123");
        let res = fastbuffer.compare(buf1, buf2);
        expect(res).assertEqual(1);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /*
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_COMPARE_0300
     * @tc.name  : testFastbufferCompare0003
     * @tc.desc  : Testing compare with value '比较一' and '比较二'.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it('testFastbufferCompare0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferCompare0003";
      try {
        let buf1 = fastbuffer.from("比较一");
        let buf2 = fastbuffer.from("比较二");
        let res = fastbuffer.compare(buf1, buf2);
        expect(res).assertEqual(-1);
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number:SUB_COMMONLIBRARY_FASTBUFFER_TRANSCODE_0100
     * @tc.name  : testFastbufferTranscode0001
     * @tc.desc  : Re-encodes the given Buffer or Uint8Array instance from one character encoding to another.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferTranscode0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferTranscode0001";
      try {
        let buf1 = fastbuffer.from("1236");
        let buf = fastbuffer.transcode(buf1, "ascii", "ucs2");
        let str = buf.toString("ucs2")
        expect(str).assertEqual("1236");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number:SUB_COMMONLIBRARY_FASTBUFFER_TRANSCODE_0200
     * @tc.name: testFastbufferTranscode0002
     * @tc.desc: Re-encodes the given Buffer or Uint8Array instance from one character encoding to another.
     * @tc.size: MediumTest
     * @tc.type: Function
     * @tc.level: Level 1
     */
    it("testFastbufferTranscode0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferTranscode0002";
      try {
        let buf1 = Uint8Array.from([1, 2, 3, 6]);
        let buf = fastbuffer.transcode(buf1, "ascii", "ucs2");
        let str = buf.toString("ucs2")
        expect(str).assertEqual("1,2,3,6");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });
  })
}