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

import { describe, it, expect, TestType, Size, Level } from "@ohos/hypium";

import zlib from "@ohos.zlib";

export default function zlibEnumValueTest() {
  describe('testZlibEnumValue', () => {
    /**
     * @tc.number : SUB_BUNDLEMANAGER_SDK_ZLIB_ENUMVALUE_0100
     * @tc.name   : testZlibEnumValue0001
     * @tc.desc   : Test Zlib Enum Value
     * @tc.type   : Function
     * @tc.size   : MediumTest
     * @tc.level  : Level 0
     */
    it('testZlibEnumValue0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let MEM_LEVEL_MIN = zlib.MemLevel.MEM_LEVEL_MIN;
      console.info("[MemLevel]MEM_LEVEL_MIN : " + JSON.stringify(MEM_LEVEL_MIN));
      expect(MEM_LEVEL_MIN).assertEqual(1);
      let MEM_LEVEL_MAX = zlib.MemLevel.MEM_LEVEL_MAX;
      console.info("[MemLevel]MEM_LEVEL_MAX : " + JSON.stringify(MEM_LEVEL_MAX));
      expect(MEM_LEVEL_MAX).assertEqual(9);
      done();
    });

    /**
     * @tc.number : SUB_BUNDLEMANAGER_SDK_ZLIB_ENUMVALUE_0200
     * @tc.name   : testZlibEnumValue0002
     * @tc.desc   : Test Zlib Enum Value
     * @tc.type   : Function
     * @tc.size   : MediumTest
     * @tc.level  : Level 0
     */
    it('testZlibEnumValue0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let COMPRESS_LEVEL_NO_COMPRESSION = zlib.CompressLevel.COMPRESS_LEVEL_NO_COMPRESSION;
      console.info("[CompressLevel]COMPRESS_LEVEL_NO_COMPRESSION : " +
      JSON.stringify(COMPRESS_LEVEL_NO_COMPRESSION));
      expect(COMPRESS_LEVEL_NO_COMPRESSION).assertEqual(0);
      let COMPRESS_LEVEL_BEST_SPEED = zlib.CompressLevel.COMPRESS_LEVEL_BEST_SPEED;
      console.info("[CompressLevel]COMPRESS_LEVEL_BEST_SPEED : " +
      JSON.stringify(COMPRESS_LEVEL_BEST_SPEED));
      expect(COMPRESS_LEVEL_BEST_SPEED).assertEqual(1);
      let COMPRESS_LEVEL_BEST_COMPRESSION = zlib.CompressLevel.COMPRESS_LEVEL_BEST_COMPRESSION;
      console.info("[CompressLevel]COMPRESS_LEVEL_BEST_COMPRESSION : " +
      JSON.stringify(COMPRESS_LEVEL_BEST_COMPRESSION));
      expect(COMPRESS_LEVEL_BEST_COMPRESSION).assertEqual(9);
      done();
    });

    /**
     * @tc.number : SUB_BUNDLEMANAGER_SDK_ZLIB_ENUMVALUE_0300
     * @tc.name   : testZlibEnumValue0003
     * @tc.desc   : Test Zlib Enum Value
     * @tc.type   : Function
     * @tc.size   : MediumTest
     * @tc.level  : Level 0
     */
    it('testZlibEnumValue0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let COMPRESS_STRATEGY_FILTERED = zlib.CompressStrategy.COMPRESS_STRATEGY_FILTERED;
      console.info("[CompressStrategy]COMPRESS_STRATEGY_FILTERED : " +
      JSON.stringify(COMPRESS_STRATEGY_FILTERED));
      expect(COMPRESS_STRATEGY_FILTERED).assertEqual(1);
      let COMPRESS_STRATEGY_HUFFMAN_ONLY = zlib.CompressStrategy.COMPRESS_STRATEGY_HUFFMAN_ONLY;
      console.info("[CompressStrategy]COMPRESS_STRATEGY_HUFFMAN_ONLY : " +
      JSON.stringify(COMPRESS_STRATEGY_HUFFMAN_ONLY));
      expect(COMPRESS_STRATEGY_HUFFMAN_ONLY).assertEqual(2);
      let COMPRESS_STRATEGY_FIXED = zlib.CompressStrategy.COMPRESS_STRATEGY_FIXED;
      console.info("[CompressStrategy]COMPRESS_STRATEGY_FIXED : " +
      JSON.stringify(COMPRESS_STRATEGY_FIXED));
      expect(COMPRESS_STRATEGY_FIXED).assertEqual(4);
      let COMPRESS_STRATEGY_RLE = zlib.CompressStrategy.COMPRESS_STRATEGY_RLE;
      console.info("[CompressStrategy]COMPRESS_STRATEGY_RLE : " +
      JSON.stringify(COMPRESS_STRATEGY_RLE));
      expect(COMPRESS_STRATEGY_RLE).assertEqual(3);
      done();
    });
  });
}