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
import {
  testOwnKeysInvariant10,
  testProxyApplyTrap5,
  testProxyConstructTrap6,
  testProxyDeleteProperty4,
  testProxyGetTrap1,
  testProxyHasTrap3,
  testProxySetTrap2,
  testReflectDefineProperty9,
  testReflectForwarding8,
  testRevocableProxy7
} from './Proxy';

const WAIT_READY_MS_2000: number = 2000
const WAIT_READY_MS_300: number = 300

function sleep(ms: number): Promise<void> {
  return new Promise(resolve => setTimeout(resolve, ms))
}

export default function proxyTest() {
  describe('proxyTest', () => {
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
     * @tc.name   ArkUIX_SUB_PROXYTEST_PROXY_0100
     * @tc.number ArkUIX_SUB_PROXYTEST_PROXY_0100
     * @tc.desc   test proxy
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_PROXYTEST_PROXY_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let result = testProxyGetTrap1();
      expect(result).assertEqual(true);
    });

    /**
     * @tc.name   ArkUIX_SUB_PROXYTEST_PROXY_0200
     * @tc.number ArkUIX_SUB_PROXYTEST_PROXY_0200
     * @tc.desc   test proxy
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_PROXYTEST_PROXY_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let result = testProxySetTrap2();
      expect(result).assertEqual(3);
    });
    /**
     * @tc.name   ArkUIX_SUB_PROXYTEST_PROXY_0300
     * @tc.number ArkUIX_SUB_PROXYTEST_PROXY_0300
     * @tc.desc   test proxy
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_PROXYTEST_PROXY_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let result = testProxyHasTrap3();
      expect(result).assertEqual(true);
    });

    /**
     * @tc.name   ArkUIX_SUB_PROXYTEST_PROXY_0400
     * @tc.number ArkUIX_SUB_PROXYTEST_PROXY_0400
     * @tc.desc   test proxy
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_PROXYTEST_PROXY_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let result = testProxyDeleteProperty4();
      expect(result).assertEqual(true);
    });

    /**
     * @tc.name   ArkUIX_SUB_PROXYTEST_PROXY_0500
     * @tc.number ArkUIX_SUB_PROXYTEST_PROXY_0500
     * @tc.desc   test proxy
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_PROXYTEST_PROXY_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let result = testProxyApplyTrap5();
      expect(result).assertEqual(true);
    });

    /**
     * @tc.name   ArkUIX_SUB_PROXYTEST_PROXY_0600
     * @tc.number ArkUIX_SUB_PROXYTEST_PROXY_0600
     * @tc.desc   test proxy
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_PROXYTEST_PROXY_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let result = testProxyConstructTrap6();
      expect(result).assertEqual(true);
    });

    /**
     * @tc.name   ArkUIX_SUB_PROXYTEST_PROXY_0700
     * @tc.number ArkUIX_SUB_PROXYTEST_PROXY_0700
     * @tc.desc   test proxy
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_PROXYTEST_PROXY_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let result = testRevocableProxy7();
      expect(result).assertEqual(3);
    });

    /**
     * @tc.name   ArkUIX_SUB_PROXYTEST_PROXY_0800
     * @tc.number ArkUIX_SUB_PROXYTEST_PROXY_0800
     * @tc.desc   test proxy
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_PROXYTEST_PROXY_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let result = testReflectForwarding8();
      expect(result).assertEqual(true);
    });

    /**
     * @tc.name   ArkUIX_SUB_PROXYTEST_PROXY_0900
     * @tc.number ArkUIX_SUB_PROXYTEST_PROXY_0900
     * @tc.desc   test proxy
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_PROXYTEST_PROXY_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let result = testReflectDefineProperty9();
      expect(result).assertEqual(3);
    });

    /**
     * @tc.name   ArkUIX_SUB_PROXYTEST_PROXY_1000
     * @tc.number ArkUIX_SUB_PROXYTEST_PROXY_1000
     * @tc.desc   test proxy
     * @tc.type   FUNCTION
     * @tc.size   MEDIUMTEST
     * @tc.level  LEVEL1
     */
    it('ArkUIX_SUB_PROXYTEST_PROXY_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      let result = testOwnKeysInvariant10();
      expect(result).assertEqual(1);
    });
  })
}


