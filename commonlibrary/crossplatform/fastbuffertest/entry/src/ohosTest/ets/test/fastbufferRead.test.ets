/**
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
 **/
import fastbuffer from '@ohos.fastbuffer';
import { afterEach, describe, expect, it, Level, Size, TestType } from '@ohos/hypium';

let TAG = ""

function sleep(time: number) {
  return new Promise<void>((resolve, reject) => {
    setTimeout(() => {
      resolve()
    }, time)
  }).then(() => {
    console.info(`sleep ${time} over...`)
  })
}

export default function ReadIntLETest() {
  describe('ReadIntLETest', () => {
    afterEach(async (done: Function) => {
      await sleep(500);
      done();
    })

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READBIGINT64BE_0100
     * @tc.name  : testFastbufferReadBigInt64BE0001
     * @tc.desc  : Test readBigInt64BE method with valid offset parameter
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : level 0
     **/
    it('testFastbufferReadBigInt64BE0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadBigInt64BE0001";
      try {
        let buf = fastbuffer.from([0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x70,
          0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78]);
        let ref = buf.readBigInt64BE(0).toString();
        expect(ref).assertEqual("7161960797921896816");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READBIGINT64BE_0200
     * @tc.name  : testFastbufferReadBigInt64BE0002
     * @tc.desc  : Test readBigInt64BE method without offset parameter (default behavior)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : level 0
     **/
    it('testFastbufferReadBigInt64BE0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadBigInt64BE0002";
      try {
        let buf = fastbuffer.from([0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x70,
          0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78]);
        let ref = buf.readBigInt64BE().toString();
        expect(ref).assertEqual("7161960797921896816");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READBIGINT64BE_0300
     * @tc.name  : testFastbufferReadBigInt64BE0003
     * @tc.desc  : Test readBigInt64BE method with invalid offset parameter (out of bounds)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : level 2
     **/

    it('testFastbufferReadBigInt64BE0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = "testFastbufferReadBigInt64BE0003";
      try {
        let buf = fastbuffer.from([0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x70,
          0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78]);
        let ref = buf.readBigInt64BE(30).toString();
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READBIGINT64LE_0100
     * @tc.name  : testFastbufferReadBigInt64LE0001
     * @tc.desc  : Test readBigInt64LE method with valid offset parameter
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadBigInt64LE0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      TAG = "testFastbufferReadBigInt64LE0001";
      try {
        let buf = fastbuffer.from([0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x70,
          0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78]);
        let ref = buf.readBigInt64LE(0).toString();
        expect(ref).assertEqual("8100120198111388771");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READBIGINT64LE_0200
     * @tc.name  : testFastbufferReadBigInt64LE0002
     * @tc.desc  : Test readBigInt64LE method without offset parameter (default behavior)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadBigInt64LE0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadBigInt64LE0002";
      try {
        let buf = fastbuffer.from([0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x70,
          0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78]);
        let ref = buf.readBigInt64LE().toString();
        expect(ref).assertEqual("8100120198111388771");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READBIGINT64LE_0300
     * @tc.name  : testFastbufferReadBigInt64LE0003
     * @tc.desc  : Test readBigInt64LE method with invalid offset parameter (out of bounds)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     **/
    it('testFastbufferReadBigInt64LE0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = "testFastbufferReadBigInt64LE0003";
      try {
        let buf = fastbuffer.from([0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x70,
          0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78]);
        let ref = buf.readBigInt64LE(50).toString();
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READBIGUINT64BE_0100
     * @tc.name  : testFastbufferReadBigUInt64BE0001
     * @tc.desc  : Test readBigUInt64BE method with valid offset parameter
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadBigUInt64BE0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadBigUInt64BE0001";
      try {
        let buf = fastbuffer.from([0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x70,
          0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78]);
        let ref = buf.readBigUInt64BE(0).toString();
        expect(ref).assertEqual("7161960797921896816");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READBIGUINT64BE_0200
     * @tc.name  : testFastbufferReadBigUInt64BE0002
     * @tc.desc  : Test readBigUInt64BE method without offset parameter (default behavior)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadBigUInt64BE0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadBigUInt64BE0002";
      try {
        let buf = fastbuffer.from([0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x70,
          0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78]);
        let ref = buf.readBigUInt64BE().toString();
        expect(ref).assertEqual("7161960797921896816");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READBIGUINT64BE_0300
     * @tc.name  : testFastbufferReadBigUInt64BE0003
     * @tc.desc  : Test readBigUInt64BE method with invalid offset parameter (out of bounds)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     **/
    it('testFastbufferReadBigUInt64BE0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = "testFastbufferReadBigUInt64BE0003";
      try {
        let buf = fastbuffer.from([0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x70,
          0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78]);
        let ref = buf.readBigUInt64BE(20).toString();
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READBIGUINT64LE_0100
     * @tc.name  : testFastbufferReadBigUInt64LE0001
     * @tc.desc  : Test readBigUInt64LE method with valid offset parameter
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadBigUInt64LE0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadBigUInt64LE0001";
      try {
        let buf = fastbuffer.from([0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x70,
          0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78]);
        let ref = buf.readBigUInt64LE(0).toString();
        expect(ref).assertEqual("8100120198111388771");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READBIGUINT64LE_0200
     * @tc.name  : testFastbufferReadBigUInt64LE0002
     * @tc.desc  : Test readBigUInt64LE method without offset parameter (default behavior)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadBigUInt64LE0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadBigUInt64LE0002";
      try {
        let buf = fastbuffer.from([0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x70,
          0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78]);
        let ref = buf.readBigUInt64LE().toString();
        expect(ref).assertEqual("8100120198111388771");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READBIGUINT64LE_0300
     * @tc.name  : testFastbufferReadBigUInt64LE0003
     * @tc.desc  : Test readBigUInt64LE method with invalid offset parameter (out of bounds)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     **/
    it('testFastbufferReadBigUInt64LE0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = "testFastbufferReadBigUInt64LE0003";
      try {
        let buf = fastbuffer.from([0x63, 0x64, 0x65, 0x66, 0x67, 0x68, 0x69, 0x70,
          0x71, 0x72, 0x73, 0x74, 0x75, 0x76, 0x77, 0x78]);
        let ref = buf.readBigUInt64LE(20).toString();
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READDOUBLEBE_0100
     * @tc.name  : testFastbufferReadDoubleBE0001
     * @tc.desc  : Test readDoubleBE method with valid offset parameter
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadDoubleBE0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadDoubleBE0001";
      try {
        let buf = fastbuffer.from([1, 2, 3, 4, 5, 6, 7, 8]);
        let ref = buf.readDoubleBE(0).toString();
        expect(ref).assertEqual('8.20788039913184e-304');
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READDOUBLEBE_0200
     * @tc.name  : testFastbufferReadDoubleBE0002
     * @tc.desc  : Test readDoubleBE method without offset parameter (default behavior)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadDoubleBE0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL3, () => {
      TAG = "testFastbufferReadDoubleBE0002";
      try {
        let buf = fastbuffer.from([1, 2, 3, 4, 5, 6, 7, 8]);
        let ref = buf.readDoubleBE().toString();
        expect(ref).assertEqual('8.20788039913184e-304');
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READDOUBLEBE_0300
     * @tc.name  : testFastbufferReadDoubleBE0003
     * @tc.desc  : Test readDoubleBE method with invalid offset parameter (out of bounds)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     **/
    it('testFastbufferReadDoubleBE0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = "testFastbufferReadDoubleBE0003";
      try {
        let buf = fastbuffer.from([1, 2, 3, 4, 5, 6, 7, 8]);
        let ref = buf.readDoubleBE(20).toString();
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect(err.code).assertEqual(10200001)
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READDOUBLELE_0100
     * @tc.name  : testFastbufferReadDoubleLE0001
     * @tc.desc  : Test readDoubleLE method with valid offset parameter
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadDoubleLE0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadDoubleLE0001";
      try {
        let buf = fastbuffer.from([1, 2, 3, 4, 5, 6, 7, 8]);
        let ref = buf.readDoubleLE(0).toString();
        expect(ref).assertEqual('5.447603722011605e-270');
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READDOUBLELE_0200
     * @tc.name  : testFastbufferReadDoubleLE0002
     * @tc.desc  : Test readDoubleLE method without offset parameter (default behavior)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadDoubleLE0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadDoubleLE0002";
      try {
        let buf = fastbuffer.from([1, 2, 3, 4, 5, 6, 7, 8]);
        let ref = buf.readDoubleLE().toString();
        expect(ref).assertEqual('5.447603722011605e-270');
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READDOUBLELE_0300
     * @tc.name  : testFastbufferReadDoubleLE0003
     * @tc.desc  : Test readDoubleLE method with invalid offset parameter (out of bounds)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     **/
    it('testFastbufferReadDoubleLE0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = "testFastbufferReadDoubleLE0003";
      try {
        let buf = fastbuffer.from([1, 2, 3, 4, 5, 6, 7, 8]);
        let ref = buf.readDoubleLE(20).toString();
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect(err.code).assertEqual(10200001)
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READFLOATBE_0100
     * @tc.name  : testFastbufferReadFloatBE0001
     * @tc.desc  : Test readFloatBE method with valid offset parameter
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadFloatBE0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadFloatBE0001";
      try {
        let buf = fastbuffer.from([1, 2, 3, 4, 5, 6, 7, 8]);
        let ref = buf.readFloatBE(0).toString();
        expect(ref).assertEqual("2.387939260590663e-38");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READFLOATBE_0200
     * @tc.name  : testFastbufferReadFloatBE0002
     * @tc.desc  : Test readFloatBE method without offset parameter (default behavior)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadFloatBE0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadFloatBE0002";
      try {
        let buf = fastbuffer.from([1, 2, 3, 4, 5, 6, 7, 8]);
        let ref = buf.readFloatBE().toString();
        expect(ref).assertEqual("2.387939260590663e-38");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READFLOATBE_0300
     * @tc.name  : testFastbufferReadFloatBE0003
     * @tc.desc  : Test readFloatBE method with invalid offset parameter (out of bounds)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     **/
    it('testFastbufferReadFloatBE0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = "testFastbufferReadFloatBE0003";
      try {
        let buf = fastbuffer.from([1, 2, 3, 4, 5, 6, 7, 8]);
        let ref = buf.readFloatBE(15).toString();
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect(err.code).assertEqual(10200001)
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READFLOATLE_0100
     * @tc.name  : testFastbufferReadFloatLE0001
     * @tc.desc  : Test readFloatLE method with valid offset parameter
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadFloatLE0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadFloatLE0001";
      try {
        let buf = fastbuffer.from([1, 2, 3, 4, 5, 6, 7, 8]);
        let ref = buf.readFloatLE(0).toString();
        expect(ref).assertEqual("1.539989614439558e-36");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READFLOATLE_0200
     * @tc.name  : testFastbufferReadFloatLE0002
     * @tc.desc  : Test readFloatLE method without offset parameter (default behavior)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadFloatLE0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadFloatLE0002";
      try {
        let buf = fastbuffer.from([1, 2, 3, 4, 5, 6, 7, 8]);
        let ref = buf.readFloatLE().toString();
        expect(ref).assertEqual("1.539989614439558e-36");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READFLOATLE_0300
     * @tc.name  : testFastbufferReadFloatLE0003
     * @tc.desc  : Test readFloatLE method with invalid offset parameter (out of bounds)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     **/
    it('testFastbufferReadFloatLE0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = "testFastbufferReadFloatLE0003";
      try {
        let buf = fastbuffer.from([1, 2, 3, 4, 5, 6, 7, 8]);
        let ref = buf.readFloatLE(10).toString();
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect(err.code).assertEqual(10200001)
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READINT8_0100
     * @tc.name  : testFastbufferReadInt80001
     * @tc.desc  : Test readInt8 method with multiple valid offset parameters
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadInt80001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadInt80001";
      try {
        let buf = fastbuffer.from([-1, 5]);
        let ref1 = buf.readInt8(0).toString();
        let ref2 = buf.readInt8(1).toString();
        expect(ref1).assertEqual('-1');
        expect(ref2).assertEqual('5');
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READINT8_0200
     * @tc.name  : testFastbufferReadInt80002
     * @tc.desc  : Test readInt8 method with invalid offset parameter (out of bounds)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     **/

    it('testFastbufferReadInt80002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = "testFastbufferReadInt80002";
      try {
        let buf = fastbuffer.from([-1, 5]);
        let ref1 = buf.readInt8(4).toString();
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect(err.code).assertEqual(10200001)
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READINT8_0300
     * @tc.name  : testFastbufferReadInt80003
     * @tc.desc  : Test readInt8 method without offset parameter (default behavior)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadInt80003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadInt80003";
      try {
        let buf = fastbuffer.from([-1, 5]);
        let ref1 = buf.readInt8().toString();
        expect(ref1).assertEqual('-1');
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READINT16BE_0100
     * @tc.name  : testFastbufferReadInt16BE0001
     * @tc.desc  : Test readInt16BE method with valid offset parameter
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadInt16BE0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadInt16BE0001";
      try {
        let buf = fastbuffer.from([0, 5]);
        let ref = buf.readInt16BE(0).toString();
        expect(ref).assertEqual("5");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READINT16BE_0200
     * @tc.name  : testFastbufferReadInt16BE0002
     * @tc.desc  : Test readInt16BE method without offset parameter (default behavior)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadInt16BE0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadInt16BE0002";
      try {
        let buf = fastbuffer.from([0, 5]);
        let ref = buf.readInt16BE().toString();
        expect(ref).assertEqual("5");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READINT16BE_0300
     * @tc.name  : testFastbufferReadInt16BE0003
     * @tc.desc  : Test readInt16BE method with invalid offset parameter (out of bounds)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     **/
    it('testFastbufferReadInt16BE0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = "testFastbufferReadInt16BE0003";
      try {
        let buf = fastbuffer.from([0, 5]);
        let ref = buf.readInt16BE(4).toString();
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect(err.code).assertEqual(10200001)
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READINT16LE_0100
     * @tc.name  : testFastbufferReadInt16LE0001
     * @tc.desc  : Test readInt16LE method with valid offset parameter
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadInt16LE0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadInt16LE0001";
      try {
        let buf = fastbuffer.from([0, 5]);
        let ref = buf.readInt16LE(0).toString();
        expect(ref).assertEqual("1280");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READINT16LE_0200
     * @tc.name  : testFastbufferReadInt16LE0002
     * @tc.desc  : Test readInt16LE method without offset parameter (default behavior)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadInt16LE0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadInt16LE0002";
      try {
        let buf = fastbuffer.from([0, 5]);
        let ref = buf.readInt16LE().toString();
        expect(ref).assertEqual("1280");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READINT16LE_0300
     * @tc.name  : testFastbufferReadInt16LE0003
     * @tc.desc  : Test readInt16LE method with invalid offset parameter (out of bounds)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     **/
    it('testFastbufferReadInt16LE0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = "testFastbufferReadInt16LE0003";
      try {
        let buf = fastbuffer.from([0, 5]);
        let ref = buf.readInt16LE(3).toString();
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect(err.code).assertEqual(10200001)
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READINT32BE_0100
     * @tc.name  : testFastbufferReadInt32BE0001
     * @tc.desc  : Test readInt32BE method with valid offset parameter
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadInt32BE0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadInt32BE0001";
      try {
        let buf = fastbuffer.from([0, 0, 0, 5]);
        let ref = buf.readInt32BE(0).toString();
        expect(ref).assertEqual("5");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READINT32BE_0200
     * @tc.name  : testFastbufferReadInt32BE0002
     * @tc.desc  : Test readInt32BE method without offset parameter (default behavior)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadInt32BE0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadInt32BE0002";
      try {
        let buf = fastbuffer.from([0, 0, 0, 5]);
        let ref = buf.readInt32BE().toString();
        expect(ref).assertEqual("5");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READINT32BE_0300
     * @tc.name  : testFastbufferReadInt32BE0003
     * @tc.desc  : Test readInt32BE method with invalid offset parameter (out of bounds)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     **/
    it('testFastbufferReadInt32BE0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = "testFastbufferReadInt32BE0003";
      try {
        let buf = fastbuffer.from([0, 0, 0, 5]);
        let ref = buf.readInt32BE(5).toString();
        expect().assertFail()
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READINT32LE_0100
     * @tc.name  : testFastbufferReadInt32LE0001
     * @tc.desc  : Test readInt32LE method with valid offset parameter
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadInt32LE0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadInt32LE0001";
      try {
        let buf = fastbuffer.from([0, 0, 0, 5]);
        let ref = buf.readInt32LE(0).toString();
        expect(ref).assertEqual("83886080");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READINT32LE_0200
     * @tc.name  : testFastbufferReadInt32LE0002
     * @tc.desc  : Test readInt32LE method without offset parameter (default behavior)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadInt32LE0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadInt32LE0002";
      try {
        let buf = fastbuffer.from([0, 0, 0, 5]);
        let ref = buf.readInt32LE().toString();
        expect(ref).assertEqual("83886080");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READINT32LE_0300
     * @tc.name  : testFastbufferReadInt32LE0003
     * @tc.desc  : Test readInt32LE method with invalid offset parameter (out of bounds)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     **/
    it('testFastbufferReadInt32LE0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = "testFastbufferReadInt32LE0003";
      try {
        let buf = fastbuffer.from([0, 0, 0, 5]);
        let ref = buf.readInt32LE(5).toString();
        expect().assertFail()
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READINTBE_0100
     * @tc.name  : testFastbufferReadIntBE0001
     * @tc.desc  : Test readIntBE method with valid offset and byteLength parameters
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadIntBE0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferReadIntBE0001";
      try {
        let buf = fastbuffer.allocUninitializedFromPool(6);
        buf.writeIntBE(0x123456789011, 0, 6);
        let ref = buf.readIntBE(0, 5).toString(16);
        expect(ref).assertEqual("1234567890");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READINTBE_0200
     * @tc.name  : testFastbufferReadIntBE0002
     * @tc.desc  : Test readIntBE method with invalid byteLength parameter (out of bounds)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     **/
    it('testFastbufferReadIntBE0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = "testFastbufferReadIntBE0002";
      try {
        let buf = fastbuffer.allocUninitializedFromPool(6);
        buf.writeIntBE(0x123456789011, 0, 6);
        let ref = buf.readIntBE(0, 7).toString(16);
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READINTLE_0100
     * @tc.name  : testFastbufferReadIntLE0001
     * @tc.desc  : Test readIntLE method with valid offset and byteLength parameters
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadIntLE0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferReadIntLE0001';
      console.info(TAG + " begin");
      try {
        let buf = fastbuffer.from([0x12, 0x34, 0x56, 0x78, 0x90, 0xab]);
        let ref = buf.readIntLE(0, 6).toString(16);
        expect(ref).assertEqual("-546f87a9cbee");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READINTLE_0200
     * @tc.name  : testFastbufferreadIntLE0002
     * @tc.desc  : Test readIntLE method with invalid offset and byteLength parameters (out of bounds)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     **/
    it("testFastbufferReadIntLE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferReadIntLE0002';
      console.info(TAG + " begin");
      let buf = fastbuffer.allocUninitializedFromPool(6);
      buf.writeIntLE(0x123456789011, 0, 6);
      try {
        let ref = buf.readIntLE(2, 5).toString(16);
        expect().assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READUINT8_0100
     * @tc.name  : testFastbufferReadUInt80001
     * @tc.desc  : Test readUInt8 method with multiple valid offset parameters
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadUInt80001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferReadUInt80001';
      console.info(TAG + " begin");
      try {
        let buf = fastbuffer.from([1, -2]);
        let ref1 = buf.readUInt8(0).toString();
        let ref2 = buf.readUInt8(1).toString();
        expect(ref1).assertEqual("1");
        expect(ref2).assertEqual("254");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READUINT8_0200
     * @tc.name  : testFastbufferReadUInt80002
     * @tc.desc  : Test readUInt8 method without offset parameter (default behavior)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadUInt80002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferReadUInt80002';
      console.info(TAG + " begin");
      try {
        let buf = fastbuffer.from([1, -2]);
        let ref = buf.readUInt8().toString();
        expect(ref).assertEqual("1");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READUINT8_0300
     * @tc.name  : testFastbufferReadUInt80003
     * @tc.desc  : Test readUInt8 method with invalid offset parameter (out of bounds)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     **/
    it("testFastbufferReadUInt80003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferReadUInt80003';
      console.info(TAG + " begin");
      let buf = fastbuffer.allocUninitializedFromPool(4);
      buf.writeUInt8(0x42);
      try {
        let ref = buf.readUInt8(4).toString(16);
        expect().assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READUINT16BE_0100
     * @tc.name  : testFastbufferReadUInt16BE0001
     * @tc.desc  : Test readUInt16BE method with multiple valid offset parameters
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadUInt16BE0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferReadUInt16BE0001';
      console.info(TAG + " begin");
      try {
        let buf = fastbuffer.from([0x12, 0x34, 0x56]);
        let ref = buf.readUInt16BE(0).toString(16);
        expect(ref).assertEqual("1234");
        ref = buf.readUInt16BE(1).toString(16);
        expect(ref).assertEqual("3456");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READUINT16BE_0200
     * @tc.name  : testFastbufferReadUInt16BE0002
     * @tc.desc  : Test readUInt16BE method without offset parameter (default behavior)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it('testFastbufferReadUInt16BE0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferReadUInt16BE0002';
      console.info(TAG + " begin");
      try {
        let buf = fastbuffer.from([0x12, 0x34, 0x56]);
        let ref = buf.readUInt16BE().toString(16);
        expect(ref).assertEqual("1234");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READUINT16BE_0300
     * @tc.name  : testFastbufferReadUInt16BE0003
     * @tc.desc  : Test readUInt16BE method with invalid offset parameter (out of bounds)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     **/
    it("testFastbufferReadUInt16BE0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferReadUInt16BE0003';
      console.info(TAG + " begin");
      let buf = fastbuffer.allocUninitializedFromPool(4);
      buf.writeUInt16BE(0x1234, 0);
      try {
        let ref = buf.readUInt16BE(3).toString(16);
        expect().assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READUINT16LE_0100
     * @tc.name  : testFastbufferReadUInt16LE0001
     * @tc.desc  : Test readUInt16LE method with multiple valid offset parameters
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it("testFastbufferReadUInt16LE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferReadUInt16LE0001';
      console.info(TAG + " begin");
      try {
        let buf = fastbuffer.from([0x12, 0x34, 0x56]);
        let ref = buf.readUInt16LE(0).toString(16);
        expect(ref).assertEqual("3412");
        ref = buf.readUInt16LE(1).toString(16);
        expect(ref).assertEqual("5634");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READUINT16LE_0200
     * @tc.name  : testFastbufferReadUInt16LE0002
     * @tc.desc  : Test readUInt16LE method without offset parameter (default behavior)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it("testFastbufferReadUInt16LE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferReadUInt16LE0002';
      console.info(TAG + " begin");
      try {
        let buf = fastbuffer.from([0x12, 0x34, 0x56]);
        let ref = buf.readUInt16LE().toString(16);
        expect(ref).assertEqual("3412");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READUINT16LE_0300
     * @tc.name  : testFastbufferReadUInt16LE0003
     * @tc.desc  : Test readUInt16LE method with invalid offset parameter (out of bounds)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     **/
    it("testFastbufferReadUInt16LE0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferReadUInt16LE0003';
      console.info(TAG + " begin");
      let buf = fastbuffer.allocUninitializedFromPool(4);
      buf.writeUInt16LE(0x1234, 0);
      try {
        let ref = buf.readUInt16LE(3).toString(16);
        expect().assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READUINT32BE_0100
     * @tc.name  : testFastbufferReadUInt32BE0001
     * @tc.desc  : Test readUInt32BE method with valid offset parameter
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it("testFastbufferReadUInt32BE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferReadUInt32BE0001';
      console.info(TAG + " begin");
      try {
        let buf = fastbuffer.from([0x12, 0x34, 0x56, 0x78]);
        let ref = buf.readUInt32BE(0).toString(16);
        expect(ref).assertEqual("12345678");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READUINT32BE_0200
     * @tc.name  : testFastbufferReadUInt32BE0002
     * @tc.desc  : Test readUInt32BE method without offset parameter (default behavior)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it("testFastbufferReadUInt32BE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferReadUInt32BE0002';
      console.info(TAG + " begin");
      try {
        let buf = fastbuffer.from([0x12, 0x34, 0x56, 0x78]);
        let ref = buf.readUInt32BE().toString(16);
        expect(ref).assertEqual("12345678");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READUINT32BE_0300
     * @tc.name  : testFastbufferReadUInt32BE0003
     * @tc.desc  : Test readUInt32BE method with invalid offset parameter (out of bounds)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     **/
    it("testFastbufferReadUInt32BE0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferReadUInt32BE0003';
      console.info(TAG + " begin");
      let buf = fastbuffer.allocUninitializedFromPool(4);
      buf.writeUInt32BE(0x12345678, 0);
      try {
        let ref = buf.readUInt32BE(1).toString(16);
        expect().assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READUINT32LE_0100
     * @tc.name  : testFastbufferReadUInt32LE0001
     * @tc.desc  : Test readUInt32LE method with valid offset parameter
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it("testFastbufferReadUInt32LE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferReadUInt32LE0001';
      console.info(TAG + " begin");
      try {
        let buf = fastbuffer.from([0x12, 0x34, 0x56, 0x78]);
        let ref = buf.readUInt32LE(0).toString(16);
        expect(ref).assertEqual("78563412");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READUINT32LE_0200
     * @tc.name  : testFastbufferReadUInt32LE0002
     * @tc.desc  : Test readUInt32LE method without offset parameter (default behavior)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it("testFastbufferReadUInt32LE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferReadUInt32LE0002';
      console.info(TAG + " begin");
      try {
        let buf = fastbuffer.from([0x12, 0x34, 0x56, 0x78]);
        let ref = buf.readUInt32LE().toString(16);
        expect(ref).assertEqual("78563412");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READUINT32LE_0300
     * @tc.name  : testFastbufferReadUInt32LE0003
     * @tc.desc  : Test readUInt32LE method with invalid offset parameter (out of bounds)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     **/
    it("testFastbufferReadUInt32LE0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferReadUInt32LE0003';
      console.info(TAG + " begin");
      let buf = fastbuffer.allocUninitializedFromPool(4);
      buf.writeUInt32LE(0x12345678, 0);
      try {
        let ref = buf.readUInt32LE(1).toString(16);
        expect().assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READUINTBE_0100
     * @tc.name  : testFastbufferReadUIntBE0001
     * @tc.desc  : Test readUIntBE method with valid offset and byteLength parameters
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it("testFastbufferReadUIntBE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferReadUIntBE0001';
      console.info(TAG + " begin");
      try {
        let buf = fastbuffer.from([0x12, 0x34, 0x56, 0x78, 0x90, 0xab]);
        let ref = buf.readUIntBE(0, 6).toString(16);
        expect(ref).assertEqual("1234567890ab");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READUINTBE_0200
     * @tc.name  : testFastbufferReadUIntBE0002
     * @tc.desc  : Test ReadUIntBE method with offset and byteLength causing out-of-bounds access
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     **/
    it("testFastbufferReadUIntBE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferReadUIntBE0002';
      console.info(TAG + " begin");
      let buf = fastbuffer.allocUninitializedFromPool(4);
      buf.writeUIntBE(0x13141516, 0, 4);
      try {
        let ref = buf.readUIntBE(2, 3).toString(16);
        expect().assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READUINTLE_0100
     * @tc.name  : testFastbufferReadUIntLE0001
     * @tc.desc  : Test readUIntLE method with valid offset and byteLength parameters for 6-byte unsigned integer
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 0
     **/
    it("testFastbufferReadUIntLE0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = 'testFastbufferReadUIntLE0001';
      console.info(TAG + " begin");
      try {
        let buf = fastbuffer.from([0x12, 0x34, 0x56, 0x78, 0x90, 0xab]);
        let ref = buf.readUIntLE(0, 6).toString(16);
        expect(ref).assertEqual("ab9078563412");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_READUINTLE_0200
     * @tc.name  : testFastbufferReadUIntLE0002
     * @tc.desc  : Test readUIntLE method with invalid parameters (offset + byteLength exceeds buffer bounds)
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     **/
    it("testFastbufferReadUIntLE0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = 'testFastbufferReadUIntLE0002';
      console.info(TAG + " begin");
      let buf = fastbuffer.allocUninitializedFromPool(4);
      buf.writeUIntLE(0x13141516, 0, 4);
      try {
        let ref = buf.readUIntLE(2, 3).toString(16);
        expect().assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });
  })
}
