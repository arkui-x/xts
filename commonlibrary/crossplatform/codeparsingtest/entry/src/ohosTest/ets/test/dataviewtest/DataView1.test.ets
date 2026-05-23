/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, Level, Size, TestType } from '@ohos/hypium';

const WAIT_READY_MS_2000: number = 2000
const WAIT_READY_MS_300: number = 300

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

interface OffsetLengthTest {
  view: DataView;
  length: number;
  offset: number;
}

interface SharedBufferTest {
  view1: DataView;
  view2: DataView;
}


interface WriteReadTest {
  view: DataView;
  writeVal: number;
  readVal: number;
}

interface SyncTest {
  view1: DataView;
  view2: DataView;
  syncVal: number;
}

interface IsolationTest {
  view1: DataView;
  view2: DataView;
  val1: number;
  val2: number;
}

interface EndianTest {
  view: DataView;
  value: number;
}

interface SharedBufferConstructorTest {
  view: DataView;
  bufferType: string;
}

interface OffsetBufferSyncTest {
  view: DataView;
  rawBufferView: DataView;
  testVal: number;
}

interface Float32WriteReadTest {
  view: DataView;
  floatVal: number;
}

interface BigInt64Test {
  view: DataView;
  bigIntVal: bigint;
}

interface MultiOffsetReadTest {
  view1: DataView;
  view2: DataView;
  val1: number;
  val2: number;
}

interface BigUint64Test {
  view: DataView;
  bigUintVal: bigint;
}

interface Float16WriteReadTest {
  view: DataView;
  floatVal: number;
}

interface CrossLengthReadTest {
  baseView: DataView;
  shortView: DataView;
  testVal: number;
}

interface ParallelWriteTest {
  viewA: DataView;
  viewB: DataView;
  valA: number;
  valB: number;
}

interface EndianInt16Test {
  view: DataView;
  value: number;
  bigEndianResult: number;
  littleEndianResult: number;
}

interface NestedOffsetTest {
  buffer: ArrayBuffer;
  view1: DataView;
  view2: DataView;
  testVal: number;
}

interface Float16BoundaryTest {
  view: DataView;
  minValue: number;
  maxValue: number;
}

interface SharedBufferCompatTest {
  view: DataView;
  isSharedBuffer: boolean;
}

interface OverlappingViewsTest {
  view1: DataView;
  view2: DataView;
  val1: number;
  val2: number;
}

interface Float64InfinityTest {
  view: DataView;
  positiveInf: number;
  negativeInf: number;
}

interface MixedTypeTest {
  view: DataView;
  intVal: number;
  floatVal: number;
  uintVal: number;
}

interface SplitReadTest {
  view16: DataView;
  view8: DataView;
  value: number;
  highByte: number;
  lowByte: number;
}

interface BigIntSplitReadTest {
  view64: DataView;
  view32: DataView;
  bigIntVal: bigint;
  high32: number;
  low32: number;
}

interface MixedTypeNoConflictTest {
  viewInt: DataView;
  viewFloat: DataView;
  viewUint: DataView;
  intVal: number;
  floatVal: number;
  uintVal: number;
}

interface SharedBufferWriteTest {
  view1: DataView;
  view2: DataView;
  sharedBuffer: SharedArrayBuffer;
  testVal: number;
}

interface NestedViewTest {
  baseView: DataView;
  nestedView: DataView;
  testVal: number;
}

interface LastWriteWinsTest {
  view1: DataView;
  view2: DataView;
  view3: DataView;
  val1: number;
  val2: number;
  val3: number;
}

interface MixedViewTypeTest {
  dataView: DataView;
  uint8Array: Uint8Array;
  testVal: number;
}

interface ContinuousViewsTest {
  view1: DataView;
  view2: DataView;
  val1: number;
  val2: number;
}

interface CrossOffsetReadTest {
  baseView: DataView;
  offsetView: DataView;
  testVal: number;
}

interface SequentialWriteTest {
  view: DataView;
  int8Val: number;
  uint16Val: number;
  float32Val: number;
}

interface FullBufferValidationTest {
  view: DataView;
  buffer: ArrayBuffer;
  values: number[];
}

interface MultiOffsetWriteTest {
  view1: DataView;
  view2: DataView;
  view3: DataView;
  val1: number;
  val2: number;
  val3: number;
}

interface Int16SplitReadTest {
  view16: DataView;
  view8: DataView;
  value: number;
  highByte: number;
  lowByte: number;
}

interface BufferIsolationTest {
  view1: DataView;
  view2: DataView;
  val1: number;
  val2: number;
}

interface OverlappingWriteTest {
  viewA: DataView;
  viewB: DataView;
  valA: number;
  valB: number;
}

interface Int32ToUint32Test {
  view: DataView;
  intVal: number;
  uintVal: number;
}

interface MixedTypeCrossWriteTest {
  view: DataView;
  uint8Val: number;
  int32Val: number;
  float64Val: number;
}

interface Float32PrecisionTest {
  view: DataView;
  originalVal: number;
  tolerance: number;
}

interface Uint16ToFloat32Test {
  view: DataView;
  uintVal: number;
  floatVal: number;
}

interface SeparateBufferTest {
  view1: DataView;
  view2: DataView;
  val1: number;
  val2: number;
}

export default function DataView1Test() {
  describe('DataView1Test', () => {
    beforeAll(async () => {
      await sleep(WAIT_READY_MS_2000)
    })
    beforeEach(async () => {
      await sleep(WAIT_READY_MS_300)
    })
    afterEach(async () => {
      await sleep(WAIT_READY_MS_300)
    })
    afterAll(async () => {
      await sleep(WAIT_READY_MS_300)
    })

    /**
     * @tc.name   ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0100
     * @tc.number ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0100
     * @tc.desc   test DataView constructor
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const buffer = new ArrayBuffer(8);
      const view = new DataView(buffer);
      expect(view.buffer.byteLength).assertEqual(8);
    });
    /**
     * @tc.name   ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0200
     * @tc.number ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0200
     * @tc.desc   test DataView constructor
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const buffer = new ArrayBuffer(10);
      const view = new DataView(buffer, 3);
      expect(view.byteOffset).assertEqual(3);
    });
    /**
     * @tc.name   ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0300
     * @tc.number ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0300
     * @tc.desc   test DataView constructor
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const buffer = new ArrayBuffer(16);
      const view = new DataView(buffer, 4, 6);
      const test: OffsetLengthTest = { view, length: view.byteLength, offset: view.byteOffset };
      expect(test.length).assertEqual(6);
      expect(test.offset).assertEqual(4);
    });

    /**
     * @tc.name   ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0400
     * @tc.number ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0400
     * @tc.desc   test DataView constructor
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const buffer = new ArrayBuffer(10);
      const offset = 3;
      const view = new DataView(buffer, offset);
      expect(view.byteLength).assertEqual(10 - offset);
    });

    /**
     * @tc.name   ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0500
     * @tc.number ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0500
     * @tc.desc   test DataView constructor
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const buffer = new ArrayBuffer(12);
      const view = new DataView(buffer, 0);
      expect(view.byteLength).assertEqual(buffer.byteLength);
    });

    /**
     * @tc.name   ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0600
     * @tc.number ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0600
     * @tc.desc   test DataView constructor
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const buffer = new ArrayBuffer(8);
      const test: SharedBufferTest = {
        view1: new DataView(buffer),
        view2: new DataView(buffer)
      };
      expect(test.view1.buffer).assertEqual(test.view2.buffer);
    });

    /**
     * @tc.name   ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0700
     * @tc.number ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0700
     * @tc.desc   test DataView constructor
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const buffer = new ArrayBuffer(5);
      const view = new DataView(buffer, 5);
      expect(view.byteLength).assertEqual(0);
    });

    /**
     * @tc.name   ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0800
     * @tc.number ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0800
     * @tc.desc   test DataView constructor
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      const buffer = new ArrayBuffer(8);
      const view = new DataView(buffer, 2, 4);
      const writeVal = 123;
      view.setInt16(0, writeVal);
      const test: WriteReadTest = { view, writeVal, readVal: view.getInt16(0) };
      expect(test.readVal).assertEqual(test.writeVal);
    });

    /**
     * @tc.name   ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0900
     * @tc.number ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0900
     * @tc.desc   test DataView constructor
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      try {
        new DataView(new ArrayBuffer(6), 7);
        expect().assertFail();
      } catch (error) {
        expect(error.name).assertEqual("RangeError");
        expect(error.message).assertContain("offset > bufferByteLength");
      }
    });

    /**
     * @tc.name   ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_1000
     * @tc.number ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_1000
     * @tc.desc   test DataView constructor
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_DATAVIEWTEST_DATAVIEW1_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      try {
        new DataView(new ArrayBuffer(10), 6, 5);
        expect().assertFail();
      } catch (error) {
        expect(error.name).assertEqual("RangeError");
        expect(error.message).assertContain("offset + viewByteLen > bufByteLen");
      }
    });
  })
}

