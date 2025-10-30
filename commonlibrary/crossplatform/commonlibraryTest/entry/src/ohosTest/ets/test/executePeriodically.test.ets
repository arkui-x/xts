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
import { BusinessError } from '@ohos.base';

export function dependend(params: Number) {
  "use concurrent"
  if (params >= 100) {
    let t = Date.now();
    while ((Date.now() - t) < 1000) {
      continue;
    }
  }
}

export const Sleep = (ms: number | undefined) => {
  return new Promise<void>(resolve => setTimeout(resolve, ms));
}

function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export function promiseCase() {
  let p: Promise<void> = new Promise<void>((resolve: Function, reject: Function) => {
    setTimeout(() => {
      resolve(1)
    }, 100)
  }).then(undefined, (error: BusinessError) => {
  })
  return p
}

export function sendDataTest(args: number) {
  "use concurrent"
  let res: number = args * 10;
  taskpool.Task.sendData(res);
}

export default function ExecutePeriodicallyTest() {
  describe('ExecutePeriodicallyTest', () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_EXECUTEPERIODICALLY_0100
     * @tc.name      : testExecutePeriodically0001
     * @tc.desc      : taskpool support executePeriodically interface
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testExecutePeriodically0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let task = new taskpool.Task(dependend, 200);
      taskpool.executePeriodically(100, task)
      try {
        taskpool.execute(task)
      } catch (e) {
        expect(e.toString())
          .assertEqual("BusinessError: The periodic task cannot be executed again, taskpool:: the periodicTask cannot execute again");
      }
      taskpool.cancel(task);
      done();
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_EXECUTEPERIODICALLY_0200
     * @tc.name      : testExecutePeriodically0002
     * @tc.desc      : taskpool support executePeriodically interface
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testExecutePeriodically0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let task = new taskpool.Task(dependend, 200);
      taskpool.executePeriodically(100, task)
      try {
        taskpool.executeDelayed(100, task)
      } catch (e) {
        expect(e.toString())
          .assertEqual("BusinessError: The periodic task cannot be executed again, taskpool:: the periodicTask cannot executeDelayed");
      }
      taskpool.cancel(task);
      done();
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_EXECUTEPERIODICALLY_0300
     * @tc.name      : testExecutePeriodically0003
     * @tc.desc      : taskpool support executePeriodically interface
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testExecutePeriodically0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let task = new taskpool.Task(dependend, 200);
      taskpool.executePeriodically(100, task)
      try {
        let task1 = new taskpool.Task(dependend, 300);
        task.addDependency(task1);
      } catch (e) {
        expect(e.toString()).assertEqual("BusinessError: The periodic task cannot have a dependency.");
      }
      taskpool.cancel(task);
      done();
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_EXECUTEPERIODICALLY_0400
     * @tc.name      : testExecutePeriodically0004
     * @tc.desc      : taskpool support executePeriodically interface
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testExecutePeriodically0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let task = new taskpool.Task(dependend, 200);
      taskpool.executePeriodically(100, task)
      try {
        let task1 = new taskpool.Task(dependend, 300);
        task1.addDependency(task);
      } catch (e) {
        expect(e.toString()).assertEqual("BusinessError: The periodic task cannot have a dependency.");
      }
      taskpool.cancel(task);
      done();
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_EXECUTEPERIODICALLY_0500
     * @tc.name      : testExecutePeriodically0005
     * @tc.desc      : taskpool support executePeriodically interface
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testExecutePeriodically0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let task = new taskpool.Task(dependend, 200);
      taskpool.executePeriodically(100, task)
      try {
        let taskGroup = new taskpool.TaskGroup();
        taskGroup.addTask(task)
      } catch (e) {
        expect(e.toString())
          .assertEqual("BusinessError: The periodic task cannot be executed again, taskpool:: The interface does not support the periodicTask");
      }
      taskpool.cancel(task);
      done();
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_EXECUTEPERIODICALLY_0600
     * @tc.name      : testExecutePeriodically0006
     * @tc.desc      : taskpool support executePeriodically interface
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testExecutePeriodically0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let task = new taskpool.Task(dependend, 200);
      taskpool.executePeriodically(100, task)
      try {
        let runner = new taskpool.SequenceRunner()
        runner.execute(task)
      } catch (e) {
        expect(e.toString())
          .assertEqual("BusinessError: The periodic task cannot be executed again, taskpool:: SequenceRunner cannot execute the periodicTask");
      }
      taskpool.cancel(task);
      done();
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_EXECUTEPERIODICALLY_0700
     * @tc.name      : testExecutePeriodically0007
     * @tc.desc      : taskpool support executePeriodically interface
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testExecutePeriodically0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let task = new taskpool.Task(dependend, 200);
      taskpool.executePeriodically(100, task)
      try {
        let runner = new taskpool.SequenceRunner()
        runner.execute(task)
      } catch (e) {
        expect(e.toString())
          .assertEqual("BusinessError: The periodic task cannot be executed again, taskpool:: SequenceRunner cannot execute the periodicTask");
      }
      taskpool.cancel(task);
      done();
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_EXECUTEPERIODICALLY_0800
     * @tc.name      : testExecutePeriodically0008
     * @tc.desc      : taskpool support executePeriodically interface
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testExecutePeriodically0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let task = new taskpool.Task(dependend, 200);
      taskpool.executePeriodically(100, task)
      try {
        taskpool.executePeriodically(1000, task)
      } catch (e) {
        expect(e.toString())
          .assertEqual("BusinessError: The concurrent task has been executed and cannot be executed periodically.");
      }

      let t = Date.now();
      while ((Date.now() - t) < 3000) {
        continue;
      }
      taskpool.cancel(task)

      let time = Date.now();
      while ((Date.now() - time) < 2000) {
        continue;
      }
      try {
        taskpool.executePeriodically(1000, task)
      } catch (e) {
        expect(e.toString())
          .assertEqual("BusinessError: The concurrent task has been executed and cannot be executed periodically.");
      }
      done();
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_EXECUTEPERIODICALLY_0900
     * @tc.name      : testExecutePeriodically0009
     * @tc.desc      : taskpool support executePeriodically interface
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testExecutePeriodically0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let task = new taskpool.Task(dependend, 200);
      taskpool.execute(task)
      try {
        taskpool.executePeriodically(100, task)
      } catch (e) {
        expect(e.toString())
          .assertEqual("BusinessError: The concurrent task has been executed and cannot be executed periodically.");
      }

      let task1 = new taskpool.Task(dependend, 200);
      let taskGroup = new taskpool.TaskGroup()
      taskGroup.addTask(task1)
      try {
        taskpool.executePeriodically(100, task1)
      } catch (e) {
        expect(e.toString())
          .assertEqual("BusinessError: The concurrent task has been executed and cannot be executed periodically.");
      }

      let task2 = new taskpool.Task(dependend, 200);
      let runner = new taskpool.SequenceRunner()
      runner.execute(task2)
      try {
        taskpool.executePeriodically(100, task2)
      } catch (e) {
        expect(e.toString())
          .assertEqual("BusinessError: The concurrent task has been executed and cannot be executed periodically.");
      }

      let task3 = new taskpool.Task(dependend, 200);
      let task4 = new taskpool.Task(dependend, 200);
      task3.addDependency(task4)
      try {
        taskpool.executePeriodically(100, task3)
      } catch (e) {
        expect(e.toString()).assertEqual("BusinessError: Parameter error. The input parameters are invalid, " +
          "taskpool:: the task with dependency cannot executePeriodically");
      }
      try {
        taskpool.executePeriodically(100, task4)
      } catch (e) {
        expect(e.toString()).assertEqual("BusinessError: Parameter error. The input parameters are invalid, " +
          "taskpool:: the task with dependency cannot executePeriodically");
      }

      let task5 = new taskpool.Task(dependend, 200);
      taskpool.executeDelayed(1000, task5)
      try {
        taskpool.executePeriodically(100, task5)
      } catch (e) {
        expect(e.toString())
          .assertEqual("BusinessError: The concurrent task has been executed and cannot be executed periodically.");
      }
      done();
    });
  })
}