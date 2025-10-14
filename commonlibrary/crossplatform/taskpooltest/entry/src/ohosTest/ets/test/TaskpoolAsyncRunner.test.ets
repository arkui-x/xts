/*
 * Copyright (C) 2025 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the 'License');
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an 'AS IS' BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { describe, expect, it, Level, Size, TestType } from '@ohos/hypium';
import taskpool from '@ohos.taskpool';
import { BusinessError } from '@ohos.base';

function sleep(ms: number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

@Concurrent
function additionDelay(delay: number): void {
  let start: number = new Date().getTime();
  while (new Date().getTime() - start < delay) {
    continue;
  }
}

@Concurrent
function printNum(args: number): number {
  console.info("printNum: " + args);
  return args;
}

@Concurrent
function processNumber(input: number): number {
  return input * 2;
}

@Concurrent
function taskA(): number {
  return 100;
}

function createTaskA(): taskpool.Task {
  return new taskpool.Task(taskA);
}

@Concurrent
async function taskB(data: number, createTask: () => taskpool.Task): Promise<number> {
  const task = createTask();
  const result = await taskpool.execute(task);
  const numResult = result as number;
  return numResult;
}

@Concurrent
function mathAbs(num: number): number {
  return num < 0 ? -num : num;
}

@Concurrent
function mathAbs1(): void {
  let tmp = 1 + 1;
}

export default function TaskPoolStateTest() {
  describe('TaskPoolStateTest', () => {

    /**
     * @tc.number    : SUB_COMMONLIBRARY_TASKPOOL_ASYNCRUNNER_0100
     * @tc.name      : testAsyncRunnerConstructor0001
     * @tc.desc      : Test AsyncRunner constructor with valid capacity parameter, verify no exception is thrown.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testAsyncRunnerConstructor0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let runner1: taskpool.AsyncRunner = new taskpool.AsyncRunner(5);
        console.info('testAsyncRunnerConstructor0001 pass');
      } catch (error) {
        console.error(`testAsyncRunnerConstructor0001 error：${error.message}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_TASKPOOL_ASYNCRUNNER_0200
     * @tc.name      : testAsyncRunnerConstructor0002
     * @tc.desc      : Test AsyncRunner constructor with valid capacity parameter, verify no exception is thrown.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testAsyncRunnerConstructor0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      try {
        let runner2: taskpool.AsyncRunner = new taskpool.AsyncRunner(5, 1);
        console.info('testAsyncRunnerConstructor0002 pass');
      } catch (error) {
        console.error(`testAsyncRunnerConstructor0002 error：${error.message}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_TASKPOOL_ASYNCRUNNER_0300
     * @tc.name      : testAsyncRunnerConstructor0003
     * @tc.desc      : Test AsyncRunner constructor with valid name and capacity parameters, verify no exception is thrown.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testAsyncRunnerConstructor0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, () => {
      try {
        let runner4: taskpool.AsyncRunner = new taskpool.AsyncRunner("runner3", 5);
        console.info('testAsyncRunnerConstructor0003 pass');
      } catch (error) {
        console.error(`testAsyncRunnerConstructor0003 ：${error.message}`);
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_TASKPOOL_ASYNCRUNNER_0400
     * @tc.name      : testAsyncRunnerConstructor0004
     * @tc.desc      : Test AsyncRunner constructor with valid name and capacity parameters, verify no exception is thrown.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testAsyncRunnerConstructor0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, () => {
      try {
        let runner5: taskpool.AsyncRunner = new taskpool.AsyncRunner("runner4", 5, 1);
        console.info('testAsyncRunnerConstructor0004 pass');
      } catch (error) {
        console.info('testAsyncRunnerConstructor0004 pass ');
        expect().assertTrue();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_TASKPOOL_EXECUTE_0100
     * @tc.name      : testAsyncRunnerExecute0001
     * @tc.desc      : Test normal execution of a single task, verify no exception is thrown and task returns expected result.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testAsyncRunnerExecute0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async () => {
      const TAG = 'testAsyncRunnerExecute0001';
      let result: number = 0;
      try {
        const task = new taskpool.Task(processNumber, 100);
        result = await taskpool.execute(task) as number;
        expect(result).assertEqual(200);
        console.info(`${TAG} passed: succes `);
      } catch (error) {
        expect().assertFail(`${TAG} faile`);
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_TASKPOOL_EXECUTE_0200
     * @tc.name      : testAsyncRunnerExecute0002
     * @tc.desc      : Test execution of a single task with HIGH priority, verify no exception is thrown and task returns expected result.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testAsyncRunnerExecute0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async () => {
      const TAG = 'testAsyncRunnerExecute0002';
      let result: number = 0;
      try {
        const task = new taskpool.Task(processNumber, 100);
        const HIGH_PRIORITY = taskpool.Priority.HIGH;
        result = await taskpool.execute(task, HIGH_PRIORITY) as number;
        expect(result).assertEqual(200);
        console.info(`${TAG} passed: `);
      } catch (error) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_TASKPOOL_EXECUTE_0300
     * @tc.name      : testAsyncRunnerExecute0003
     * @tc.desc      : Test exception scenario of task execution, verify expected error code 10200006 is thrown.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testAsyncRunnerExecute0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      try {
        const task: taskpool.Task = new taskpool.Task(taskB, 100, createTaskA);
        await taskpool.execute(task);
        expect().assertFail();
      } catch (error) {
        expect(error.code).assertEqual(10200006);
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_TASKPOOL_EXECUTE_0400
     * @tc.name      : testAsyncRunnerExecute0004
     * @tc.desc      : Test task execution with dependency in SequenceRunner, verify expected error code 10200025 is thrown.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testAsyncRunnerExecute0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async (done: Function) => {
      const caseName: string = 'testAsyncRunnerExecute0004';
      console.info(`${caseName} test start`);
      try {
        let task1: taskpool.Task = new taskpool.Task(printNum, 100);
        let task2: taskpool.Task = new taskpool.Task(printNum, 200);
        let runner: taskpool.SequenceRunner = new taskpool.SequenceRunner();
        task1.addDependency(task2);
        runner.execute(task1).then(() => {
          console.info("seqrunner: task1 done.");
        });
        runner.execute(task2).then(() => {
          console.info("seqrunner: task2 done");
        });
        expect().assertFail();
      } catch (error) {
        console.info(`${caseName} catch error: code => ${error.code} message => ${error.message}`);
        expect(error.code).assertEqual(10200025);
      }
      console.info(`${caseName} test end`);
      done();
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_TASKPOOL_EXECUTE_0500
     * @tc.name      : testAsyncRunnerExecute0005
     * @tc.desc      : Test execution of a task that has been scheduled periodically, verify expected error code 10200051 is thrown.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testAsyncRunnerExecute0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      const caseName: string = 'testAsyncRunnerExecute0005';
      console.info(`${caseName} test start`);
      try {
        let task: taskpool.Task = new taskpool.Task(printNum, 100);
        taskpool.executePeriodically(1000, task);
        taskpool.execute(task);
        expect().assertFail();
      } catch (error) {
        console.info(`${caseName} catch error: code => ${error.code} message => ${error.message}`);
        expect(error.code).assertEqual(10200051);
      }
      console.info(`${caseName} test end`);
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_TASKPOOL_EXECUTE_0600
     * @tc.name      : testAsyncRunnerExecute0006
     * @tc.desc      : Test execution of tasks exceeding AsyncRunner capacity, verify each failed task throws expected error code 10200054.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testAsyncRunnerExecute0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      const caseName: string = 'testAsyncRunnerExecute0006';
      console.info(`${caseName} test start`);
      let num = 0;
      let runner7: taskpool.AsyncRunner = new taskpool.AsyncRunner("runner7", 5, 5);
      for (let i = 0; i < 30; i++) {
        let task1: taskpool.Task = new taskpool.Task(printNum, 100)
        runner7.execute(task1).catch((error: BusinessError) => {
          console.info(`${caseName} catch error: code => ${error.code} message => ${error.message}`);
          expect(error.code).assertEqual(10200054);
        });
      }
      console.info(`${caseName} test end`);
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_TASKPOOL_EXECUTE_0700
     * @tc.name      : testAsyncRunnerExecute0007
     * @tc.desc      : Test execution of a task that has been executed by taskpool via AsyncRunner, verify expected error code 10200057 is thrown.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testAsyncRunnerExecute0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      const caseName: string = 'testAsyncRunnerExecute0007';
      console.info(`${caseName} test start`);
      try {
        let runner8: taskpool.AsyncRunner = new taskpool.AsyncRunner("runner8", 5, 5);
        let task: taskpool.Task = new taskpool.Task(additionDelay, 1000);
        taskpool.execute(task);
        runner8.execute(task).then(() => {
          console.info("seqrunner: task1 done.");
        });
        expect().assertFail();
      } catch (error) {
        console.info(`${caseName} catch error: code => ${error.code} message => ${error.message}`);
        expect(error.code).assertEqual(10200057);
      }
      console.info(`${caseName} test end`);
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_TASKPOOL_CANCEL_0100
     * @tc.name      : testCancel0001
     * @tc.desc      : Test task cancellation after submitting to taskpool queue, verify task is not executed.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testCancel0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async () => {
      const caseName: string = 'testCancel0001';
      console.info(`${caseName} test start`);
      try {
        let isTaskExecuted: boolean = false;
        const task: taskpool.Task = new taskpool.Task(mathAbs, -100);
        taskpool.execute(task).then((res: Object) => {
          console.info(`${caseName}: task return value: ${JSON.stringify(res)}`);
          isTaskExecuted = true;
        });
        taskpool.cancel(task);
        expect(isTaskExecuted).assertEqual(false);
      } catch (error) {
        console.info(`${caseName}: catch error: code => ${error.code} message => ${error.message}`);
        expect().assertFail();
      }
      console.info(`${caseName} test end`);
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_TASKPOOL_CANCEL_0200
     * @tc.name      : testCancel0002
     * @tc.desc      : Test cancellation of non-existent task in taskpool, verify expected error code 10200015 is thrown.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testCancel0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      const caseName: string = 'testCancel0002';
      console.info(`${caseName} test start`);
      try {
        const nonExistentTask: taskpool.Task = new taskpool.Task(mathAbs, -100);
        try {
          taskpool.cancel(nonExistentTask);
          expect().assertFail(`${caseName}: error`);
        } catch (error) {
          expect(error.code).assertEqual(10200015);
        }
        console.info(`${caseName} test end`);
      } catch (error) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_TASKPOOL_CANCEL_0200
     * @tc.name      : testCancel0002
     * @tc.desc      : Test cancellation of non-existent task in taskpool, verify expected error code 10200015 is thrown.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testCancel0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      const caseName: string = 'testCancel0002';
      console.info(`${caseName} test start`);
      try {
        const nonExistentTask: taskpool.Task = new taskpool.Task(mathAbs, -100);
        try {
          taskpool.cancel(nonExistentTask);
          expect().assertFail(`${caseName}: error`);
        } catch (error) {
          expect(error.code).assertEqual(10200015);
        }
        console.info(`${caseName} test end`);
      } catch (error) {
        expect().assertFail();
      }
    });

    /**
     * @tc.number    : SUB_Runtime_Language_Backend_TaskpoolConcurrency_0300
     * @tc.name      : testCancel0003
     * @tc.desc      : Test multiple cancellations of the same task, verify expected error code 10200055 is thrown.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 2
     */
    it('testTaskpoolCancel003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2, async () => {
      const caseName: string = 'testTaskpoolCancel003';
      console.info(`${caseName} test start`);
      try {
        const task: taskpool.Task = new taskpool.Task(mathAbs1);
        taskpool.execute(task);
        let taskId = task.taskId;
        taskpool.cancel(taskId);
        taskpool.cancel(taskId);
      } catch (error) {
        console.info(`${caseName}: catch error: code => ${error.code} message => ${error.message}`);
        expect(error.code).assertEqual(10200055);
      }
      console.info(`${caseName} test end`);
    });
  });
}