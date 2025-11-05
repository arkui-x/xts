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

export default function PropertyTest() {
  describe('PropertyTest', () => {
    afterEach(async (done: Function) => {
      await sleep(500);
      done();
    })

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_FILL_0100
     * @tc.name  : testFastbufferFill0001
     * @tc.desc  : Testing fill with normal value.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it('testFastbufferFill0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferFill0001";
      try {
        let buf = fastbuffer.alloc(10).fill("xz");
        let str = buf.toString();
        expect(str).assertEqual("xzxzxzxzxz");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_FILL_0200
     * @tc.name  : testFastbufferFill0002
     * @tc.desc  : Testing fill with value, offset.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it('testFastbufferFill0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferFill0002";
      try {
        let buf = fastbuffer.alloc(6).fill("$*$", 0);
        let str = buf.toString();
        expect(str).assertEqual("$*$$*$");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_FILL_0300
     * @tc.name  : testFastbufferFill0003
     * @tc.desc  : Testing fill with value, offset, end.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it('testFastbufferFill0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferFill0003";
      try {
        let buf = fastbuffer.alloc(6).fill("$*$", 0, 3);
        let str = buf.toString('utf-8', 0, 3);
        expect(str).assertEqual("$*$");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_FILL_0400
     * @tc.name  : testFastbufferFill0004
     * @tc.desc  : Testing fill with value, offset, end and encoding.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it('testFastbufferFill0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferFill0004";
      try {
        let buf = fastbuffer.alloc(6).fill("$*$", 0, 3, 'utf-8');
        let str = buf.toString('utf-8', 0, 3);
        expect(str).assertEqual("$*$");
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_FILL_0500
     * @tc.name  : testFastbufferFill0005
     * @tc.desc  : Testing error 10200001.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it('testFastbufferFill0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = "testFastbufferFill0005";
      try {
        let buf = fastbuffer.alloc(6).fill("$*$", 0, 10, 'utf-8');
        let str = buf.toString('utf-8', 0, 3);
        expect().assertFail();
      } catch (err) {
        console.error(`${TAG} is fail,err is ${err}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_FASTBUFFER_COMPARE_0100
     * @tc.name   : testFastbufferCompare0001
     * @tc.desc   : Cancel the same task twice
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testFastbufferCompare0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let caseName: string = 'testFastbufferCompare0001';
      console.info(`${caseName} test start`);
      try {
        let buf = fastbuffer.from([1, 2, 3, 4, 5]);
        let data1 = new Uint8Array([1, 2, 3, 4, 5]);
        let data2 = fastbuffer.from([1, 2, 3, 4, 5]);

        let result1 = buf.compare(data1, 0, 3, 0, 3);
        let result2 = buf.compare(data2, 2, 5, 2, 5);
        expect(result1).assertEqual(0);
        expect(result2).assertEqual(0);
      } catch (err) {
        console.info(`${caseName}: catch error: code => ${err.code} message => ${err.message}`);
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_FASTBUFFER_COMPARE_0200
     * @tc.name   : testFastbufferCompare0002
     * @tc.desc   : Cancel the same task twice
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testFastbufferCompare0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let caseName: string = 'testFastbufferCompare0002';
      console.info(`${caseName} test start`);
      try {
        let buf = fastbuffer.from([10, 20, 30, 45, 50, 60, 70, 80, 90, 100]);
        let data1 = fastbuffer.from([5, 15, 30, 40, 50, 65, 0, 0, 0, 0]);
        let data2 = new Uint8Array([10, 20, 30, 40, 55, 0, 0, 0, 0, 0]);
        const result1 = buf.compare(data1, 0, 3, 0, 3);
        expect(result1).assertEqual(1);

        const result2 = buf.compare(data2, 0, 4, 0, 4);
        expect(result2).assertEqual(1);
      } catch (err) {
        console.info(`${caseName}: catch error: code => ${err.code} message => ${err.message}`);
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_FASTBUFFER_COMPARE_0300
     * @tc.name   : testFastbufferCompare0003
     * @tc.desc   : Cancel the same task twice
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testFastbufferCompare0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let caseName: string = 'testFastbufferCompare0003';
      console.info(`${caseName} test start`);
      try {
        let buf = fastbuffer.from([5, 15, 30, 40, 50, 65, 0, 0, 0, 0]);
        let data1 = fastbuffer.from([10, 20, 30, 45, 50, 60, 70, 80, 90, 100]);
        let data2 = new Uint8Array([10, 20, 30, 40, 55, 0, 0, 0, 0, 0]);
        const result1 = buf.compare(data1, 0, 3, 0, 3);
        expect(result1).assertEqual(-1);

        const result2 = buf.compare(data2, 0, 4, 0, 4);
        expect(result2).assertEqual(-1);
      } catch (err) {
        console.info(`${caseName}: catch error: code => ${err.code} message => ${err.message}`);
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_FASTBUFFER_COMPARE_0400
     * @tc.name   : testFastbufferCompare0004
     * @tc.desc   : Cancel the same task twice
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testFastbufferCompare0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let caseName: string = 'testFastbufferCompare0004';
      console.info(`${caseName} test start`);
      try {
        let buf = fastbuffer.from([5, 15, 30, 40, 50, 65, 0, 0, 0, 0]);
        let data1 = fastbuffer.from([5, 15, 30, 40, 50, 65, 0, 0, 0, 0]);
        let data2 = new Uint8Array([5, 15, 30, 40, 50, 65, 0, 0, 0, 0]);
        const result1 = buf.compare(data1);
        expect(result1).assertEqual(0);

        const result2 = buf.compare(data2);
        expect(result2).assertEqual(0);
      } catch (err) {
        console.info(`${caseName}: catch error: code => ${err.code} message => ${err.message}`);
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_FASTBUFFER_COMPARE_0500
     * @tc.name   : testFastbufferCompare0005
     * @tc.desc   : Cancel the same task twice
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testFastbufferCompare0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let caseName: string = 'testFastbufferCompare0005';
      console.info(`${caseName} test start`);
      try {
        let buf = fastbuffer.from([10, 20, 30, 45, 50, 60, 70, 80, 90, 100]);
        let data1 = fastbuffer.from([5, 15, 30, 40, 50, 65, 0, 0, 0, 0]);
        let data2 = new Uint8Array([9, 20, 30, 40, 55, 0, 0, 0, 0, 0]);
        const result1 = buf.compare(data1);
        expect(result1).assertEqual(1);

        const result2 = buf.compare(data2);
        expect(result2).assertEqual(1);
      } catch (err) {
        console.info(`${caseName}: catch error: code => ${err.code} message => ${err.message}`);
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_FASTBUFFER_COMPARE_0600
     * @tc.name   : testFastbufferCompare0006
     * @tc.desc   : Cancel the same task twice
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testFastbufferCompare0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let caseName: string = 'testFastbufferCompare0006';
      console.info(`${caseName} test start`);
      try {
        let buf = fastbuffer.from([5, 15, 30, 40, 50, 65, 0, 0, 0, 0]);
        let data1 = fastbuffer.from([10, 20, 30, 45, 50, 60, 70, 80, 90, 100]);
        let data2 = new Uint8Array([10, 20, 30, 40, 55, 0, 0, 0, 0, 0]);
        const result1 = buf.compare(data1);
        expect(result1).assertEqual(-1);

        const result2 = buf.compare(data2);
        expect(result2).assertEqual(-1);
      } catch (err) {
        console.info(`${caseName}: catch error: code => ${err.code} message => ${err.message}`);
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_FASTBUFFER_COMPARE_0700
     * @tc.name   : testFastbufferCompare0007
     * @tc.desc   : Cancel the same task twice
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testFastbufferCompare0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let caseName: string = 'testFastbufferCompare0007';
      console.info(`${caseName} test start`);
      try {
        let buf = fastbuffer.from([5, 15, 30, 40, 50, 65, 0, 0, 0, 0]);
        let data1 = fastbuffer.from([5, 15, 30, 40, 50, 65, 0, 0, 0, 0]);
        let data2 = new Uint8Array([5, 15, 30, 40, 50, 65, 0, 0, 0, 0]);
        const result1 = buf.compare(data1, 0);
        expect(result1).assertEqual(0);

        const result2 = buf.compare(data2, 0);
        expect(result2).assertEqual(0);
      } catch (err) {
        console.info(`${caseName}: catch error: code => ${err.code} message => ${err.message}`);
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_FASTBUFFER_COMPARE_0800
     * @tc.name   : testFastbufferCompare0008
     * @tc.desc   : Cancel the same task twice
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testFastbufferCompare0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let caseName: string = 'testFastbufferCompare0008';
      console.info(`${caseName} test start`);
      try {
        let buf = fastbuffer.from([5, 15, 30, 40, 50, 65, 0, 0, 0, 0]);
        let data1 = fastbuffer.from([1, 20, 30, 45, 50, 60, 70, 80, 90, 100]);
        let data2 = new Uint8Array([2, 20, 30, 40, 55, 0, 0, 0, 0, 0]);
        const result1 = buf.compare(data1, 0);
        expect(result1).assertEqual(1);

        const result2 = buf.compare(data2, 0);
        expect(result2).assertEqual(1);
      } catch (err) {
        console.info(`${caseName}: catch error: code => ${err.code} message => ${err.message}`);
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_FASTBUFFER_COMPARE_0900
     * @tc.name   : testFastbufferCompare0009
     * @tc.desc   : Cancel the same task twice
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testFastbufferCompare0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let caseName: string = 'testFastbufferCompare0009';
      console.info(`${caseName} test start`);
      try {
        let buf = fastbuffer.from([5, 15, 30, 40, 50, 65, 0, 0, 0, 0]);
        let data1 = fastbuffer.from([10, 20, 30, 45, 50, 60, 70, 80, 90, 100]);
        let data2 = new Uint8Array([10, 20, 30, 40, 55, 0, 0, 0, 0, 0]);
        const result1 = buf.compare(data1, 0);
        expect(result1).assertEqual(-1);

        const result2 = buf.compare(data2, 0);
        expect(result2).assertEqual(-1);
      } catch (err) {
        console.info(`${caseName}: catch error: code => ${err.code} message => ${err.message}`);
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_FASTBUFFER_COMPARE_1000
     * @tc.name   : testFastbufferCompare0010
     * @tc.desc   : Cancel the same task twice
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testFastbufferCompare0010', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let caseName: string = 'testFastbufferCompare0010';
      console.info(`${caseName} test start`);
      try {
        let buf = fastbuffer.from([5, 15, 30, 40, 50, 65, 0, 0, 0, 0]);
        let data1 = fastbuffer.from([5, 15, 30, 40, 50, 65, 0, 0, 0, 0]);
        let data2 = new Uint8Array([5, 15, 30, 40, 50, 65, 0, 0, 0, 0]);
        const result1 = buf.compare(data1, 0, buf.length);
        expect(result1).assertEqual(0);

        const result2 = buf.compare(data2, 0, buf.length);
        expect(result2).assertEqual(0);
      } catch (err) {
        console.info(`${caseName}: catch error: code => ${err.code} message => ${err.message}`);
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_FASTBUFFER_COMPARE_1100
     * @tc.name   : testFastbufferCompare0011
     * @tc.desc   : Cancel the same task twice
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testFastbufferCompare0011', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let caseName: string = 'testFastbufferCompare0011';
      console.info(`${caseName} test start`);
      try {
        let buf = fastbuffer.from([5, 15, 30, 40, 50, 65, 0, 0, 0, 0]);
        let data1 = fastbuffer.from([1, 15, 30, 45, 50, 60, 70, 80, 90, 100]);
        let data2 = new Uint8Array([2, 15, 30, 40, 55, 0, 0, 0, 0, 0]);
        const result1 = buf.compare(data1, 0, 2);
        expect(result1).assertEqual(1);

        const result2 = buf.compare(data2, 0, 2);
        expect(result2).assertEqual(1);
      } catch (err) {
        console.info(`${caseName}: catch error: code => ${err.code} message => ${err.message}`);
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_FASTBUFFER_COMPARE_1200
     * @tc.name   : testFastbufferCompare0012
     * @tc.desc   : Cancel the same task twice
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testFastbufferCompare0012', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let caseName: string = 'testFastbufferCompare0012';
      console.info(`${caseName} test start`);
      try {
        let buf = fastbuffer.from([5, 15, 30, 40, 50, 65, 0, 0, 0, 0]);
        let data1 = fastbuffer.from([10, 20, 30, 45, 50, 60, 70, 80, 90, 100]);
        let data2 = new Uint8Array([10, 20, 30, 40, 55, 0, 0, 0, 0, 0]);
        const result1 = buf.compare(data1, 0, 2);
        expect(result1).assertEqual(-1);

        const result2 = buf.compare(data2, 0, 2);
        expect(result2).assertEqual(-1);
      } catch (err) {
        console.info(`${caseName}: catch error: code => ${err.code} message => ${err.message}`);
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_FASTBUFFER_COMPARE_1300
     * @tc.name   : testFastbufferCompare0013
     * @tc.desc   : Cancel the same task twice
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testFastbufferCompare0013', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let caseName: string = 'testFastbufferCompare0013';
      console.info(`${caseName} test start`);
      try {
        let buf = fastbuffer.from([5, 15, 30, 40, 50, 65, 0, 0, 0, 0]);
        let data1 = fastbuffer.from([5, 15, 30, 40, 50, 65, 0, 0, 0, 0]);
        let data2 = new Uint8Array([5, 15, 30, 40, 50, 65, 0, 0, 0, 0]);
        const result1 = buf.compare(data1, 0, buf.length, 0);
        expect(result1).assertEqual(0);

        const result2 = buf.compare(data2, 0, buf.length, 0);
        expect(result2).assertEqual(0);
      } catch (err) {
        console.info(`${caseName}: catch error: code => ${err.code} message => ${err.message}`);
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_FASTBUFFER_COMPARE_1400
     * @tc.name   : testFastbufferCompare0014
     * @tc.desc   : Cancel the same task twice
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testFastbufferCompare0014', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let caseName: string = 'testFastbufferCompare0014';
      console.info(`${caseName} test start`);
      try {
        let buf = fastbuffer.from([5, 15, 30, 40, 50, 65, 0, 0, 0, 0]);
        let data1 = fastbuffer.from([1, 3, 4, 15, 50, 60, 70, 80, 90, 100]);
        let data2 = new Uint8Array([2, 15, 30, 40, 55, 0, 0, 0, 0, 0]);
        const result1 = buf.compare(data1, 0, 2, 1);
        expect(result1).assertEqual(1);

        const result2 = buf.compare(data2, 0, 2, 1);
        expect(result2).assertEqual(1);
      } catch (err) {
        console.info(`${caseName}: catch error: code => ${err.code} message => ${err.message}`);
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_FASTBUFFER_COMPARE_1500
     * @tc.name   : testFastbufferCompare0015
     * @tc.desc   : Cancel the same task twice
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testFastbufferCompare0015', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async () => {
      let caseName: string = 'testFastbufferCompare0015';
      console.info(`${caseName} test start`);
      try {
        let buf = fastbuffer.from([5, 15, 30, 40, 50, 65, 0, 0, 0, 0]);
        let data1 = fastbuffer.from([10, 20, 30, 45, 50, 60, 70, 80, 90, 100]);
        let data2 = new Uint8Array([10, 20, 30, 40, 55, 0, 0, 0, 0, 0]);
        const result1 = buf.compare(data1, 0, 2, 0);
        expect(result1).assertEqual(-1);
        const result2 = buf.compare(data2, 0, 2, 0);
        expect(result2).assertEqual(-1);
      } catch (err) {
        console.info(`${caseName}: catch error: code => $ {err.code} message => ${err.message}`);
      }
    });

    /**
     * @tc.number : SUB_COMMONLIBRARY_FASTBUFFER_COMPARE_1600
     * @tc.name   : testFastbufferCompare0016
     * @tc.desc   : Testing error 10200001
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 2
     */
    it('testFastbufferCompare0016', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      let caseName: string = 'testFastbufferCompare0016';
      console.info(`${caseName} test start`);
      try {
        let buf = fastbuffer.from([5, 15, 30, 40, 50, 65, 0, 0, 0, 0]);
        let data1 = fastbuffer.from([10, 20, 30, 45, 50, 60, 70, 80, 90, 100]);
        let data2 = new Uint8Array([10, 20, 30, 40, 55, 0, 0, 0, 0, 0]);
        const result1 = buf.compare(data1, 0, -10, 0, -10);
        const result2 = buf.compare(data2, 0, -10, 0, -10);
      } catch (err) {
        console.info(`${caseName}: catch error: code => $ {err.code} message => ${err.message}`);
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_COPY_0100
     * @tc.name  : testFastbufferCopy0001
     * @tc.desc  : Test the copy interface by copying one fastbuffer of numeric string
     *             type to other fastbuffer of numeric string type.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferCopy0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferCopy0001";
      try {
        let buf1 = fastbuffer.from("1236114515");
        let buf2 = fastbuffer.from("1235");
        let num = buf1.copy(buf2);
        expect(num).assertEqual(4);
        let str = buf2.toString();
        expect(str).assertEqual("1236");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail()
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_COPY_0200
     * @tc.name  : testFastbufferCopy0002
     * @tc.desc  : Testing error 10200001.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level: Level 2
     */
    it("testFastbufferCopy0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      try {

        let buf1 = fastbuffer.from("abcdefg");
        let buf2 = fastbuffer.from("1235789");
        let num = buf1.copy(buf2, 0);

        expect(num).assertEqual(buf1.length < buf2.length ? buf1.length : buf2.length);
      } catch (err) {
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_COPY_0300
     * @tc.name  : testFastbufferCopy0003
     * @tc.desc  : Copies data from a region of buf to a region in target,
     *             even if the target memory region overlaps with buf.
     *             If sourceEnd is greater than the length of the target, the length of the target shall prevail,
     *             and the extra part will not be overwritten.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferCopy0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let uint8array = new Uint8Array(10).fill(9);
      const buf = fastbuffer.from([1, 2, 3, 4, 5, 6, 7]);
      let num = buf.copy(uint8array, 9, 1, undefined);
      expect(num).assertEqual(1);
      let str = uint8array.toString();
      expect(str).assertEqual("9,9,9,9,9,9,9,9,9,2");
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_COPY_0400
     * @tc.name  : testFastbufferCopy0004
     * @tc.desc  : Test the copy interface by copying one fastbuffer of chinese string type  to other fastbuffer of
     *             numeric string type,and setting the parameter targetStart to 5,sourceStart to 1,sourceStart to 3.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferCopy0004", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferCopy0004";
      try {
        let buf1 = fastbuffer.from("abcdefg");
        let buf2 = fastbuffer.from("1235789");
        let num = buf1.copy(buf2, 5, 1, 3);
        expect(num).assertEqual(2);
        let str = buf2.toString();
        expect(str).assertEqual("12357bc");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail()
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_COPY_0500
     * @tc.name  : testFastbufferCopy0005
     * @tc.desc  : Copies data from a region of buf to a region in target,
     *             even if the target memory region overlaps with buf.
     *             If sourceEnd is greater than the length of the target, the length of the target shall prevail,
     *             and the extra part will not be overwritten.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferCopy0005", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      try {
        let uint8array = new Uint8Array(10).fill(0);
        const buf = fastbuffer.from([1, 2, 3, 4, 5, 6, 7]);
        let num = buf.copy(uint8array, -1, 3, 100);
      } catch (err) {
        expect(err.code).assertEqual(10200001);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_EQUALS_0100
     * @tc.name  : testFastbufferEquals0001
     * @tc.desc  : Test the equals interface by two identical buffers which content is include chinese string
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferEquals0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferEquals0001";
      try {
        let buf1 = fastbuffer.from("1236测试");
        let buf2 = fastbuffer.from("1236测试");
        let res = buf1.equals(buf2);
        expect(res).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail()
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_EQUALS_0200
     * @tc.name  : testFastbufferEquals0002
     * @tc.desc  : Returns true if both buf and otherBuffer have exactly the same bytes, false otherwise.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferEquals0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let buf1 = fastbuffer.from("1236");
      let buf2 = fastbuffer.from("1235");
      let res = buf1.equals(buf2);
      expect(res).assertEqual(false);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_INCLUDES_0100
     * @tc.name  : testFastbufferIncludes0001
     * @tc.desc  : Test the includes interface by passing the parameter value to a numerical
     *             string which is in the fastbuffer.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferIncludes0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferIncludes0001";
      try {
        let buf = fastbuffer.from("13236qwerty");
        let flag = buf.includes("3");
        expect(flag).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_INCLUDES_0200
     * @tc.name  : testFastbufferIncludes0002
     * @tc.desc  : Test the includes interface by passing the parameter value to a numerical string
     *             which is in the fastbuffer.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferIncludes0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferIncludes0002";
      try {
        let buf = fastbuffer.from("13236qwerty");
        let flag = buf.includes("s");
        expect(flag).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_INCLUDES_0300
     * @tc.name  : testFastbufferIncludes0003
     * @tc.desc  : Test the includes interface by passing the parameter value to a numerical string
     *             which is in the buffer,and byteOffset to 2.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferIncludes0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferIncludes0003";
      try {
        let buf = fastbuffer.from("13qwrqwt236");
        let flag = buf.includes("3", 2);
        expect(flag).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_INCLUDES_0400
     * @tc.name  : testFastbufferIncludes0004
     * @tc.desc  : Test the includes interface by passing the parameter value to two numerical string
     *             which is in the fastbuffer.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferIncludes0004", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferIncludes0004";
      try {
        let buf = fastbuffer.from("13asgsdv236");
        let flag = buf.includes("m", 2);
        expect(flag).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_INCLUDES_0500
     * @tc.name  : testFastbufferIncludes0005
     * @tc.desc  : Test the includes interface by passing the parameter value to two numerical string
     *             which is in the fastbuffer.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferIncludes0005", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferIncludes0005";
      try {
        let buf = fastbuffer.from("13qwrqwt236");
        let flag = buf.includes("3", 2, 'utf-8');
        expect(flag).assertEqual(true);
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_INCLUDES_0600
     * @tc.name  : testFastbufferIncludes0006
     * @tc.desc  : Test the indexOf interface by passing the parameter value to a character string.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferIncludes0006", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferIncludes0006";
      try {
        let buf = fastbuffer.from("13asgsdv236");
        let flag = buf.includes("m", 2, 'utf-8');
        expect(flag).assertEqual(false);
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_INDEXOF_0100
     * @tc.name  : testFastbufferIndexOf0001
     * @tc.desc  : Test the indexOf interface by passing the parameter value to a character string.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferIndexOf0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferIndexOf0001";
      try {
        let buf = fastbuffer.from("13236qwerty");
        let index = buf.indexOf("3");
        expect(index).assertEqual(1);
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_INDEXOF_0200
     * @tc.name  : testFastbufferIndexOf0002
     * @tc.desc  : The index of the first occurrence of value in buf.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferIndexOf0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let buf1 = fastbuffer.from("13236");
      let index = buf1.indexOf("a");
      expect(index).assertEqual(-1);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_INDEXOF_0300
     * @tc.name  : testFastbufferIndexOf0003
     * @tc.desc  : The index of the first occurrence of value in buf.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferIndexOf0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferIndexOf0003";
      try {
        let buf = fastbuffer.from("13236qwerty");
        let index = buf.indexOf("3", 1);
        expect(index).assertEqual(1);
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_INDEXOF_0400
     * @tc.name  : testFastbufferIndexOf0004
     * @tc.desc  : The index of the first occurrence of value in buf.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferIndexOf0004", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let buf1 = fastbuffer.from("a13236");
      let index = buf1.indexOf("a", 2);
      expect(index).assertEqual(-1);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_INDEXOF_0500
     * @tc.name  : testFastbufferIndexOf0005
     * @tc.desc  : The index of the first occurrence of value in buf.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferIndexOf0005", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferIndexOf0005";
      try {
        let buf = fastbuffer.from("13236qwerty");
        let index = buf.indexOf("3", 1, 'utf-8');
        expect(index).assertEqual(1);
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_INDEXOF_0600
     * @tc.name  : testFastbufferIndexOf0006
     * @tc.desc  : The index of the first occurrence of value in buf.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferIndexOf0006", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      let buf1 = fastbuffer.from("a13236");
      let index = buf1.indexOf("a", 2, 'utf-8');
      expect(index).assertEqual(-1);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_LASTINDEXOF_0100
     * @tc.name  : testFastbufferLastIndexOf0001
     * @tc.desc  : Test the lastIndexOf interface by passing the parameter value to a character string which is in the fastbuffer.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferLastIndexOf0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferLastIndexOf0001";
      try {
        let buf = fastbuffer.from("13236qwert");
        let index = buf.lastIndexOf("3");
        expect(index).assertEqual(3);
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_LASTINDEXOF_0200
     * @tc.name  : testFastbufferLastIndexOf0002
     * @tc.desc  : The index of the last occurrence of value in buf.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferLastIndexOf0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let buf1 = fastbuffer.from("13236");
      let index = buf1.lastIndexOf("a");
      expect(index).assertEqual(-1);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_LASTINDEXOF_0300
     * @tc.name  : testFastbufferLastIndexOf0003
     * @tc.desc  : Test the lastIndexOf interface by passing the parameter value to a character string
     *             which is in the buffer and byteOffset to 2.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferLastIndexOf0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferLastIndexOf0003";
      try {
        let buf = fastbuffer.from("13236qwerty");
        let index = buf.lastIndexOf("3", 2);
        expect(index).assertEqual(1);
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_LASTINDEXOF_0400
     * @tc.name  : testFastbufferLastIndexOf0004
     * @tc.desc  : The index of the last occurrence of value in buf.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferLastIndexOf0004", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let buf1 = fastbuffer.from("13236");
      let index = buf1.lastIndexOf("a", 2);
      expect(index).assertEqual(-1);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_LASTINDEXOF_0500
     * @tc.name  : testFastbufferLastIndexOf0005
     * @tc.desc  : Test the lastIndexOf interface by passing the parameter value, offset, encoding.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferLastIndexOf0005", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferLastIndexOf0005";
      try {
        let buf = fastbuffer.from("13236qwerty");
        let index = buf.lastIndexOf("3", 2, 'utf8');
        expect(index).assertEqual(1);
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_LASTINDEXOF_0600
     * @tc.name  : testFastbufferLastIndexOf0006
     * @tc.desc  : The index of the last occurrence of value in buf.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferLastIndexOf0006", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let buf1 = fastbuffer.from("13236");
      let index = buf1.lastIndexOf("a", 2, 'utf8');
      expect(index).assertEqual(-1);
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_KEYS_0100
     * @tc.name  : testFastbufferKeys0001
     * @tc.desc  : Test the keys interface by source fastbuffer which created from uint8Array.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferKeys0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferKeys0001";
      try {
        let buf = fastbuffer.from("1234567");
        let keys = buf.keys();
        let index = 0;
        for (const key of keys) {
          expect(key).assertEqual(index);
          index++;
        }
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_VALUES_0100
     * @tc.name  : testFastbufferValues0001
     * @tc.desc  : Test the values interface by source fastbuffer which created from string.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferValues0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferValues0001";
      try {
        let buf = fastbuffer.from("1234567");
        let values = buf.values();
        let va = 49;
        for (const value of values) {
          expect(value).assertEqual(va);
          va++;
        }
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_ENTRIES_0100
     * @tc.name  : testFastbufferEntries0001
     * @tc.desc  : Test the entries interface by source fastbuffer which created from string.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferEntries0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferEntries0001";
      try {
        let buf = fastbuffer.from("1234567");
        let entries = buf.entries();
        let va = 49, index = 0;
        for (const entry of entries) {
          expect(entry[0]).assertEqual(index);
          expect(entry[1]).assertEqual(va);
          va++;
          index++;
        }
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_SUBARRAY_0100
     * @tc.name  : testFastbufferSubarray0001
     * @tc.desc  : Test the subarray interface by pass the parameter start is 0 and end is 5.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferSubarray0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferSubarray0001";
      console.info(TAG + 'begin');
      try {
        let buf1 = fastbuffer.allocUninitializedFromPool(26);
        for (let i = 0; i < 26; i++) {
          buf1.writeInt8(i + 97, i);
        }
        const buf2 = buf1.subarray(0, 5);
        let str = buf2.toString('ascii', 0, buf2.length);
        expect(str).assertEqual("abcde");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail()
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_SUBARRAY_0200
     * @tc.name  : testFastbufferSubarray0002
     * @tc.desc  : Test the subarray interface by pass the parameter start is 0 and end is 5.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferSubarray0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferSubarray0002";
      console.info(TAG + 'begin');
      try {
        let buf1 = fastbuffer.allocUninitializedFromPool(26);
        for (let i = 0; i < 26; i++) {
          buf1.writeInt8(i + 97, i);
        }
        const buf2 = buf1.subarray(0);
        let str = buf2.toString('ascii', 0, buf2.length);
        expect(str).assertEqual("abcdefghijklmnopqrstuvwxyz");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail()
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_SUBARRAY_0300
     * @tc.name  : testFastbufferSubarray0003
     * @tc.desc  : Test the subarray interface by pass the parameter start is 0 and end is 26.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferSubarray0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferSubarray0003";
      console.info(TAG + 'begin');
      try {
        let buf1 = fastbuffer.allocUninitializedFromPool(26);
        for (let i = 0; i < 26; i++) {
          buf1.writeInt8(i + 97, i);
        }
        const buf2 = buf1.subarray();
        let str = buf2.toString('ascii', 0, buf2.length);
        expect(str).assertEqual("abcdefghijklmnopqrstuvwxyz");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail()
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_SWAP16_0100
     * @tc.name  : testFastbufferSwap160001
     * @tc.desc  : Interprets buf as an array of unsigned 16-bit integers and swaps the byte order in-place.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferSwap160001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferSwap160001";
      console.info(TAG + "begin");
      try {
        let buf1 = fastbuffer.from("1323");
        buf1.swap16();
        let str = buf1.toString("hex");
        expect(str).assertEqual("33313332");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_SWAP16_0200
     * @tc.name  : testFastbufferSwap160002
     * @tc.desc  : Testing error 10200009.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferSwap160002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = "testFastbufferSwap160002";
      console.info(TAG + "begin");
      let buf1 = fastbuffer.from("132");
      try {
        buf1.swap16();
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200009);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_SWAP32_0100
     * @tc.name  : testFastbufferSwap320001
     * @tc.desc  : Interprets buf as an array of unsigned 32-bit integers and swaps the byte order in-place.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferSwap320001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferSwap320001";
      console.info(TAG + "begin");
      try {
        let buf1 = fastbuffer.from("1234");
        buf1.swap32();
        let str = buf1.toString();
        expect(str).assertEqual("4321");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_SWAP32_0200
     * @tc.name  : testFastbufferSwap320002
     * @tc.desc  : Testing error 10200009.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferSwap320002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = "testFastbufferSwap320002";
      console.info(TAG + "begin");
      let buf1 = fastbuffer.from("132");
      try {
        buf1.swap32();
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200009);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_SWAP64_0100
     * @tc.name  : testFastbufferSwap640001
     * @tc.desc  : Interprets buf as an array of unsigned 32-bit integers and swaps the byte order in-place.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferSwap640001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferSwap640001";
      console.info(TAG + "begin");
      try {
        let buf1 = fastbuffer.from([0x1, 0x2, 0x3, 0x4, 0x5, 0x6, 0x7, 0x8]);
        buf1.swap64();
        let str = buf1.toString('hex')
        expect(str).assertEqual("0807060504030201");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_SWAP64_0200
     * @tc.name  : testFastbufferSwap640002
     * @tc.desc  : Testing error 10200009.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 2
     */
    it("testFastbufferSwap640002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, () => {
      TAG = "testFastbufferSwap640002";
      console.info(TAG + "begin");
      let buf1 = fastbuffer.from("1234567");
      try {
        buf1.swap64();
        expect(null).assertFail();
      } catch (err) {
        console.error(TAG + ' catch get e' + `, error code is ${err.code}, message is ${err.message}`);
        expect(err.code).assertEqual(10200009);
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_TOJSON_0100
     * @tc.name  : testFastbufferToJSON0001
     * @tc.desc  : Test the toJSON interface source fastbuffer of numerical string type.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferToJSON0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferToJSON0001";
      console.info(TAG + "begin");
      try {
        let buf1 = fastbuffer.from([0x1, 0x2, 0x3, 0x4, 0x5]);
        let obj = buf1.toJSON();
        expect(JSON.stringify(obj)).assertEqual('{"type":"FastBuffer","data":[1,2,3,4,5]}');
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_TOSTRING_0100
     * @tc.name  : testFastbufferToString0001
     * @tc.desc  : Test the toString interface by passing the parameter encoding to "latin1".
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferToString0001", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferToString0001";
      console.info(TAG + "begin");
      try {
        let buf = fastbuffer.from("abcde");
        let str = buf.toString("latin1");
        expect(str).assertEqual("abcde");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_TOSTRING_0200
     * @tc.name  : testFastbufferToString0002
     * @tc.desc  : Test the toString interface by passing the parameter encoding with encoding, start.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferToString0002", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferToString0002";
      console.info(TAG + "begin");
      try {
        let buf = fastbuffer.from("abcde");
        let str = buf.toString("utf8", 2);
        expect(str).assertEqual("cde");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_TOSTRING_0300
     * @tc.name  : testFastbufferToString0003
     * @tc.desc  : Test the toString interface by passing the parameter encoding with encoding, start, end.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferToString0003", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferToString0003";
      console.info(TAG + "begin");
      try {
        let buf = fastbuffer.from("abcde");
        let str = buf.toString("utf8", 2, 4);
        expect(str).assertEqual("cd");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number: SUB_COMMONLIBRARY_FASTBUFFER_TOSTRING_0400
     * @tc.name  : testFastbufferToString0004
     * @tc.desc  : Decodes buf to a string according to the specified character encoding in encoding.
     * @tc.size  : MediumTest
     * @tc.type  : Function
     * @tc.level : Level 1
     */
    it("testFastbufferToString0004", TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      TAG = "testFastbufferToString0004";
      console.info(TAG + "begin");
      try {
        let buf1 = fastbuffer.from("1236");
        let str = buf1.toString();
        expect(str).assertEqual("1236");
      } catch (err) {
        console.error(`${TAG} err is ${err}`);
        expect().assertFail();
      }
    });
  })
}
