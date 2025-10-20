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

import { afterAll, afterEach, beforeAll, beforeEach, describe, expect, it, Level, Size, TestType } from '@ohos/hypium';
import { taskpool } from '@kit.ArkTS';

export function dependend(params: Number) {
  "use concurrent"
  if (params >= 100) {
    let t = Date.now();
    while ((Date.now() - t) < 1000) {
      continue;
    }
  }
}

function isConcurrent0001(args: number): string {
  return args.toString();
}

@Concurrent
function isConcurrent0002(args: string): string[] {
  return new Array<string>(args);
}

export const Sleep = (ms: number | undefined) => {
  return new Promise<void>(resolve => setTimeout(resolve, ms));
}

export default function IsConcurrentTest() {
  describe('IsConcurrentTest', () => {
    // Defines a test suite. Two parameters are supported: test suite name and test suite function.
    beforeAll(() => {
      // Presets an action, which is performed only once before all test cases of the test suite start.
      // This API supports only one parameter: preset action function.
    })
    beforeEach(() => {
      // Presets an action, which is performed before each unit test case starts.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: preset action function.
    })
    afterEach(() => {
      // Presets a clear action, which is performed after each unit test case ends.
      // The number of execution times is the same as the number of test cases defined by **it**.
      // This API supports only one parameter: clear action function.
    })
    afterAll(() => {
      // Presets a clear action, which is performed after all test cases of the test suite end.
      // This API supports only one parameter: clear action function.
    })
    /**
     * @tc.number    : SUB_COMMONLIBRARY_IS_CONCURRENT_0100
     * @tc.name      : testIsConcurrent0001
     * @tc.desc      : Testing the task->isConcurrent with create func, assert return value.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testIsConcurrent0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let caseName: string = 'testIsConcurrent0001';
      console.info(`${caseName} test start`);
      try {
        let isConcurrent = taskpool.isConcurrent(isConcurrent0001);
        expect(isConcurrent).assertFalse();
      } catch (error) {
        console.info(`${caseName} catch error: code => ${error.code} message => ${error.message}`);
        expect().assertFail();
      }
      console.info(`${caseName} test end`);
      done();
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_IS_CONCURRENT_0200
     * @tc.name      : testIsConcurrent0002
     * @tc.desc      : Testing the task->isConcurrent with create func, assert return value.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testIsConcurrent0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let caseName: string = 'testIsConcurrent0002';
      console.info(`${caseName} test start`);
      try {
        let isConcurrent = taskpool.isConcurrent(isConcurrent0002);
        expect(isConcurrent).assertTrue();
      } catch (error) {
        console.info(`${caseName} catch error: code => ${error.code} message => ${error.message}`);
        expect().assertFail();
      }
      console.info(`${caseName} test end`);
      done();
    });
  })
}