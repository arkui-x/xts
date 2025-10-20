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

function promiseCase(): Promise<void | Object> {
  let p: Promise<void | Object> = new Promise((resolve: Function, reject: Function) => {
    setTimeout(() => {
      resolve(1);
    }, 100);
  });
  return p;
}

function printArgs(args: number): number {
  "use concurrent"
  console.info(`printArgs: ${args}`);
  return args;
}

export const Sleep = (ms: number | undefined) => {
  return new Promise<void>(resolve => setTimeout(resolve, ms));
}

export default function GetTaskPoolInfoTest() {
  describe('GetTaskPoolInfoTest', () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_GET_TASK_POOL_INFO_0100
     * @tc.name      : testTaskpoolGetTaskPoolInfo0001
     * @tc.desc      : Obtain the internal information of the task pool, including thread information and task information
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testTaskpoolGetTaskPoolInfo0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let caseName: string = 'testTaskpoolGetTaskPoolInfo0001';
      console.info(`${caseName} test start`);
      try {
        let task1: taskpool.Task = new taskpool.Task(printArgs, 10);
        let taskpoolInfo: taskpool.TaskPoolInfo = taskpool.getTaskPoolInfo();
        console.info(`${caseName}: taskpoolInfo: ${JSON.stringify(taskpoolInfo)}`);
        expect(taskpoolInfo.threadInfos[0].tid != 0).assertTrue();
        expect(taskpoolInfo.threadInfos[0].taskIds).assertDeepEquals([]);
        expect(taskpoolInfo.taskInfos).assertDeepEquals([]);
        expect(taskpoolInfo.threadInfos[0].priority).assertLargerOrEqual(0);
        await promiseCase();
        done();
      } catch (error) {
        console.info(`${caseName}: catch error: code => ${error.code} message => ${error.message}`);
        expect().assertFail();
        done();
      }
      console.info(`${caseName} test end`);
    });
  })
}