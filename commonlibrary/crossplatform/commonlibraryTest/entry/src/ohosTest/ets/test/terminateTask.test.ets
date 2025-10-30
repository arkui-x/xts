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

function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export function dependend(params: Number) {
  "use concurrent"
  if (params >= 100) {
    let t = Date.now();
    while ((Date.now() - t) < 1000) {
      continue;
    }
  }
}

@Concurrent
async function delay(ms: number): Promise<number> {
  const promise = await new Promise<number>(resolve => {
    setTimeout(() => resolve(ms), ms);
  });
  return promise;
}

@Concurrent
function terminateTask0001(arg: number): number {
  let t: number = Date.now();
  while (Date.now() - t < arg) {
    console.info("longTask time :" + (Date.now() - t));
    continue;
  }
  console.info("longTask has been executed.");
  return arg;
}

export const Sleep = (ms: number | undefined) => {
  return new Promise<void>(resolve => setTimeout(resolve, ms));
}

export default function TerminateTaskTest() {
  describe('TerminateTaskTest', () => {
    beforeAll(() => {
      console.info("beforeAll: Prerequisites at the test suite level, which are executed before the test suite is executed.");
    });
    beforeEach(async() => {
      await sleep(100);
      console.info("beforeEach: Prerequisites at the test case level, which are executed before each test case is executed.");
    });
    afterEach(() => {
      console.info("afterEach: Test case-level clearance conditions, which are executed after each test case is executed.");
    });
    afterAll(async() => {
      await sleep(500);
      console.info("afterAll: Test suite-level cleanup condition, which is executed after the test suite is executed");
    });
    console.info("start################################start");

    /**
     * @tc.number    : SUB_COMMONLIBRARY_TERMINATE_TASK_0100
     * @tc.name      : testTerminateTask0001
     * @tc.desc      : Testing the task->terminateTask with create func, assert the size of the task pool array.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testTerminateTask0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let caseName: string = 'testTerminateTask0001';
      console.info(`${caseName} test start`);
      try {
        let task: taskpool.LongTask = new taskpool.LongTask(terminateTask0001, 1000)
        taskpool.execute(task).then((res: Object) => {
          taskpool.terminateTask(task);
          console.info("taskpool longTask result: " + res);
        });
        await delay(1500);
        expect(taskpool.getTaskPoolInfo().taskInfos.length).assertEqual(0);
      } catch (error) {
        console.info(`${caseName} catch error: code => ${error.code} message => ${error.message}`);
        expect().assertFail();
      }
      console.info(`${caseName} test end`);
      done();
    });
  })
}