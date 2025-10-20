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
import { promiseCase } from './removeDependency.test';
import { taskpool } from '@kit.ArkTS';

function printArgs(args: number): number {
  "use concurrent"
  console.info(`printArgs: ${args}`);
  return args;
}

export default function TaskpoolPropertyTest() {
  describe('TaskpoolPropertyTest', () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_TASKPOOL_PROPERTY_0100
     * @tc.name      : testTaskpoolProperty0001
     * @tc.desc      : Testing Taskpool properties
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testTaskpoolProperty0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let caseName: string = 'testTaskpoolProperty0001';
      console.info(`${caseName} test start`);
      try {
        let isTerminate1: boolean = false;
        let isTerminate2: boolean = false;
        let testTask1: taskpool.Task = new taskpool.Task(printArgs, 100);
        let testTask2: taskpool.Task = new taskpool.Task(printArgs, 200);
        let taskgroup1: taskpool.TaskGroup = new taskpool.TaskGroup('name');
        taskgroup1.addTask(testTask2);
        taskpool.execute(testTask1).then((res: Object) => {
          console.info(`${caseName}: testTask1 return value: ${JSON.stringify(res)}`);
          isTerminate1 = true;
        });
        taskpool.execute(taskgroup1).then((res: Object) => {
          console.info(`${caseName}: testTask2 return value: ${JSON.stringify(res)}`);
          isTerminate2 = true;
        });
        while (!(isTerminate1 && isTerminate2)) {
          await promiseCase();
        }
        console.info(`${caseName}: ${JSON.stringify(typeof (testTask1.function))}`);
        expect(typeof (testTask1.function) == 'function').assertTrue();
        expect(testTask1.arguments).assertDeepEquals([100]);
        expect(typeof (testTask1.name) == 'string').assertTrue();
        expect(typeof (testTask1.totalDuration) == 'number').assertTrue();
        expect(testTask1.totalDuration != -1).assertTrue();
        expect(typeof (testTask1.ioDuration) == 'number').assertTrue();
        expect(testTask1.ioDuration != -1).assertTrue();
        expect(typeof (testTask1.cpuDuration) == 'number').assertTrue();
        expect(testTask1.cpuDuration != -1).assertTrue();
        console.info(`${caseName}: ${JSON.stringify(typeof (taskgroup1.name))}`);
        expect(typeof (taskgroup1.name) == 'string').assertTrue();
      } catch (error) {
        console.info(`${caseName}: catch error: code => ${error.code} message => ${error.message}`);
        expect().assertFail();
        done();
      }
      try {
        let isTerminate1: boolean = false;
        let isTerminate2: boolean = false;
        let isTerminate3: boolean = false;
        let testTask1: taskpool.Task = new taskpool.Task(printArgs, 100);
        let testTask2: taskpool.Task = new taskpool.Task(printArgs, 200);
        let testTask3: taskpool.Task = new taskpool.Task(printArgs, 300);
        taskpool.execute(testTask1).then((res: Object) => {
          console.info(`${caseName}: testTask1 return value: ${JSON.stringify(res)}`);
          isTerminate1 = true;
        });
        taskpool.execute(testTask2).then((res: Object) => {
          console.info(`${caseName}: testTask2 return value: ${JSON.stringify(res)}`);
          isTerminate2 = true;
        });
        taskpool.execute(testTask3).then((res: Object) => {
          isTerminate3 = true;
        });
        let taskInfo_0: taskpool.TaskInfo = taskpool.getTaskPoolInfo().taskInfos[0];
        while (!(isTerminate1 && isTerminate2 || isTerminate3)) {
          await promiseCase();
        }
        let type_taskId: string = typeof (taskInfo_0.taskId);
        console.info(`${caseName}: result1 taskId: ${JSON.stringify(type_taskId)}`);
        expect(type_taskId == 'number').assertTrue();
        let type_state: string = typeof (taskInfo_0.state);
        console.info(`${caseName}: result1 state: ${JSON.stringify(type_state)}`);
        expect(type_state == 'number').assertTrue();
        let type_duration: string = typeof (taskInfo_0.duration);
        expect(type_duration == 'number').assertTrue();
        let type_name: string = typeof (taskInfo_0.name);
        expect(type_name == 'string').assertTrue();
      } catch (error) {
        console.info(`${caseName}: catch error: code => ${error.code} message => ${error.message}`);
        expect().assertFail();
        done();
      }
      try {
        let isTerminate1: boolean = false;
        let isTerminate2: boolean = false;
        let isTerminate3: boolean = false;
        let testTask1: taskpool.Task = new taskpool.Task(printArgs, 100);
        let testTask2: taskpool.Task = new taskpool.Task(printArgs, 200);
        let testTask3: taskpool.Task = new taskpool.Task(printArgs, 300);
        taskpool.execute(testTask1).then((res: Object) => {
          console.info(`${caseName}: testTask1 return value: ${JSON.stringify(res)}`);
          isTerminate1 = true;
        });
        taskpool.execute(testTask2).then((res: Object) => {
          console.info(`${caseName}: testTask2 return value: ${JSON.stringify(res)}`);
          isTerminate2 = true;
        });
        taskpool.execute(testTask3).then((res: Object) => {
          console.info(`${caseName}: testTask3 return value: ${JSON.stringify(res)}`);
          isTerminate3 = true;
        });
        while (!(isTerminate1 && isTerminate2 || isTerminate3)) {
          await promiseCase();
        }
        let threadInfos: taskpool.ThreadInfo = taskpool.getTaskPoolInfo().threadInfos[0];
        let type_tid: string = typeof (threadInfos.tid);
        let type_priority: string = typeof (threadInfos.priority)
        expect(type_tid === 'number').assertTrue();
        expect(Array.isArray(threadInfos.taskIds)).assertTrue();
        expect(type_priority === 'number').assertTrue();
      } catch (error) {
        console.info(`${caseName}: catch error: code => ${error.code} message => ${error.message}`);
        expect().assertFail();
        done();
      }
      try {
        let isTerminate1: boolean = false;
        let testTask1: taskpool.Task = new taskpool.Task(printArgs, 100);
        let testTask2: taskpool.Task = new taskpool.Task(printArgs, 200);
        let testTask3: taskpool.Task = new taskpool.Task(printArgs, 300);
        taskpool.execute(testTask1).then((res: Object) => {
          console.info(`${caseName}: testTask1 return value: ${JSON.stringify(res)}`);
          isTerminate1 = true;
        });
        taskpool.execute(testTask2).then((res: Object) => {
          console.info(`${caseName}: testTask2 return value: ${JSON.stringify(res)}`);
        });
        taskpool.execute(testTask3).then((res: Object) => {
          console.info(`${caseName}: testTask3 return value: ${JSON.stringify(res)}`);
        });
        let taskPoolInfo: taskpool.TaskPoolInfo = taskpool.getTaskPoolInfo();
        while (!(isTerminate1)) {
          await promiseCase();
        }
        expect(Array.isArray(taskPoolInfo.threadInfos)).assertTrue();
        expect((taskPoolInfo.threadInfos).length != 0).assertTrue();
        expect(Array.isArray(taskPoolInfo.taskInfos)).assertTrue();
        expect((taskPoolInfo.taskInfos).length != 0).assertTrue();
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