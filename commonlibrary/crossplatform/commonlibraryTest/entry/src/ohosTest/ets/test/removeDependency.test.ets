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

@Concurrent
async function delay(ms: number): Promise<number> {
  const promise = await new Promise<number>(resolve => {
    setTimeout(() => resolve(ms), ms);
  });
  return promise;
}

export function delaySum(value1: number, value2: number, delay: number): number {
  "use concurrent"
  let start: number = new Date().getTime();
  while (new Date().getTime() - start < delay) {
    continue;
  }
  return value1 + value2;
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

export default function RemoveDependencyTest() {
  describe('RemoveDependencyTest', () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_TASK_REMOVE_DEPENDENCY_0100
     * @tc.name      : testTaskRemoveDependency0001
     * @tc.desc      : Testing the task->removeDependency with create tasks 1, 2, 3, none executed,
     *                 add 1 dependency 2, 2 dependency 3, remove 1 dependency 2.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testTaskRemoveDependency0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let caseName: string = 'testTaskRemoveDependency0001';
      console.info(`${caseName} test start`);
      try {
        let task1: taskpool.Task = new taskpool.Task(delay, 100);
        let task2: taskpool.Task = new taskpool.Task(delay, 200);
        let task3: taskpool.Task = new taskpool.Task(delay, 200);
        console.info("dependency: add dependency start");
        task1.addDependency(task2);
        task2.addDependency(task3);
        console.info("dependency: add dependency end");
        console.info("dependency: remove dependency start");
        task1.removeDependency(task2);
        console.info("dependency: remove dependency end");
        console.info("dependency: start execute second");
        taskpool.execute(task1).then(() => {
          console.info("dependency: second task1 success");
        });
        taskpool.execute(task2).then(() => {
          console.info("dependency: second task2 success");
        });
        taskpool.execute(task3).then(() => {
          console.info("dependency: second task3 success");
        });
      } catch (error) {
        console.info(`${caseName} catch error: code => ${error.code} message => ${error.message}`);
        expect().assertFail();
      }
      console.info(`${caseName} test end`);
      done();
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_TASK_REMOVE_DEPENDENCY_0200
     * @tc.name      : testTaskRemoveDependency0002
     * @tc.desc      : Testing the task->removeDependency with create tasks 1, 2, 3, none executed,
     *                 add 1 dependency 2, 2 dependency 3, remove 2 dependency 3.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testTaskRemoveDependency0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let caseName: string = 'testTaskRemoveDependency0002';
      console.info(`${caseName} test start`);
      try {
        let task1: taskpool.Task = new taskpool.Task(delay, 100);
        let task2: taskpool.Task = new taskpool.Task(delay, 200);
        let task3: taskpool.Task = new taskpool.Task(delay, 200);
        console.info("dependency: add dependency start");
        task1.addDependency(task2);
        task2.addDependency(task3);
        console.info("dependency: add dependency end");
        console.info("dependency: remove dependency start");
        task2.removeDependency(task3);
        console.info("dependency: remove dependency end");
        console.info("dependency: start execute second");
        taskpool.execute(task1).then(() => {
          console.info("dependency: second task1 success");
        });
        taskpool.execute(task2).then(() => {
          console.info("dependency: second task2 success");
        });
        taskpool.execute(task3).then(() => {
          console.info("dependency: second task3 success");
        });
      } catch (error) {
        console.info(`${caseName} catch error: code => ${error.code} message => ${error.message}`);
        expect().assertFail();
      }
      console.info(`${caseName} test end`);
      done();
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_TASK_REMOVE_DEPENDENCY_0300
     * @tc.name      : testTaskRemoveDependency0003
     * @tc.desc      : Testing the task->removeDependency with create tasks 1, 2, 3, none executed,
     *                 add 1 dependency 2, 2 dependency 3, remove 1 dependency 3.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testTaskRemoveDependency0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let caseName: string = 'testTaskRemoveDependency0003';
      console.info(`${caseName} test start`);
      try {
        let task1: taskpool.Task = new taskpool.Task(delay, 100);
        let task2: taskpool.Task = new taskpool.Task(delay, 200);
        let task3: taskpool.Task = new taskpool.Task(delay, 200);
        console.info("dependency: add dependency start");
        task1.addDependency(task2);
        task2.addDependency(task3);
        console.info("dependency: add dependency end");
        console.info("dependency: remove dependency start");
        task1.removeDependency(task3);
        expect().assertFail();
      } catch (error) {
        console.info(`${caseName} catch error: code => ${error.code} message => ${error.message}`);
      }
      console.info(`${caseName} test end`);
      done();
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_TASK_REMOVE_DEPENDENCY_0400
     * @tc.name      : testTaskRemoveDependency0004
     * @tc.desc      : Testing the task->removeDependency with create tasks 1, 2, 3, none executed,
     *                 add 1 dependency 2, 2 dependency 3, remove 3 dependency 1.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testTaskRemoveDependency0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let caseName: string = 'testTaskRemoveDependency0004';
      console.info(`${caseName} test start`);
      try {
        let task1: taskpool.Task = new taskpool.Task(delay, 100);
        let task2: taskpool.Task = new taskpool.Task(delay, 200);
        let task3: taskpool.Task = new taskpool.Task(delay, 200);
        console.info("dependency: add dependency start");
        task1.addDependency(task2);
        task2.addDependency(task3);
        console.info("dependency: add dependency end");
        console.info("dependency: remove dependency start");
        task3.removeDependency(task1);
        expect().assertFail();
      } catch (error) {
        console.info(`${caseName} catch error: code => ${error.code} message => ${error.message}`);
      }
      console.info(`${caseName} test end`);
      done();
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_TASK_REMOVE_DEPENDENCY_0500
     * @tc.name      : testTaskRemoveDependency0005
     * @tc.desc      : Testing the task->removeDependency with create tasks 1, 2, 3, none executed,
     *                 remove 3 dependency 1.
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testTaskRemoveDependency0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let caseName: string = 'testTaskRemoveDependency0005';
      console.info(`${caseName} test start`);
      try {
        let task1: taskpool.Task = new taskpool.Task(delay, 100);
        let task2: taskpool.Task = new taskpool.Task(delay, 200);
        let task3: taskpool.Task = new taskpool.Task(delay, 200);
        console.info("dependency: remove dependency start");
        task3.removeDependency(task1);
        expect().assertFail();
      } catch (error) {
        console.info(`${caseName} catch error: code => ${error.code} message => ${error.message}`);
      }
      console.info(`${caseName} test end`);
      done();
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_TASK_REMOVE_DEPENDENCY_0600
     * @tc.name      : testTaskRemoveDependency0006
     * @tc.desc      : removeDependency for taskpool
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testTaskRemoveDependency0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let finalString: string = "";
      let isTerminate1: boolean = false;
      let isTerminate2: boolean = false;
      let isTerminate3: boolean = false;

      let task1: taskpool.Task = new taskpool.Task(delaySum, 10, 20, 100)
      let task2: taskpool.Task = new taskpool.Task(delaySum, 30, 40, 300)
      let task3: taskpool.Task = new taskpool.Task(delaySum, 50, 60, 500)
      task1.addDependency(task2);
      task2.addDependency(task3);
      task1.removeDependency(task2);
      task2.removeDependency(task3);
      taskpool.execute(task1).then(() => {
        finalString += "a";
        isTerminate1 = true;
      })
      taskpool.execute(task2).then(() => {
        finalString += "b";
        isTerminate2 = true;
      })
      taskpool.execute(task3).then(() => {
        finalString += "c";
        isTerminate3 = true;
      })
      while (!isTerminate1 || !isTerminate2 || !isTerminate3) {
        await promiseCase()
      }
      expect(finalString.charAt(2)).assertEqual("c");
      done();
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_TASK_REMOVE_DEPENDENCY_0700
     * @tc.name      : testTaskRemoveDependency0007
     * @tc.desc      : removeDependency for taskpool
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 0
     */
    it('testTaskRemoveDependency0007', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0, async (done: Function) => {
      let task1: taskpool.Task = new taskpool.Task(delaySum, 10, 20, 100)
      let task2: taskpool.Task = new taskpool.Task(delaySum, 30, 40, 200)
      let task3: taskpool.Task = new taskpool.Task(delaySum, 50, 60, 300)
      task1.addDependency(task2);
      task2.addDependency(task3);
      taskpool.execute(task1).then(() => {
        console.info("task1 success");
      })
      taskpool.execute(task2).then(() => {
        console.info("task2 success");
      })
      taskpool.execute(task3).then(() => {
        console.info("task3 success");
      })

      try {
        task2.removeDependency(task3);
      } catch (e) {
        expect((e as BusinessError).toString())
          .assertEqual("BusinessError: The dependency does not exist, taskpool:: executedTask cannot removeDependency");
      }
      done();
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_TASK_REMOVE_DEPENDENCY_0800
     * @tc.name      : testTaskRemoveDependency0008
     * @tc.desc      : removeDependency for taskpool
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testTaskRemoveDependency0008', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let task1: taskpool.Task = new taskpool.Task(delaySum, 10, 20, 100)
      let task2: taskpool.Task = new taskpool.Task(delaySum, 30, 40, 300)
      let task3: taskpool.Task = new taskpool.Task(delaySum, 50, 60, 500)
      task1.addDependency(task2);
      task2.addDependency(task3);
      taskpool.execute(task1, taskpool.Priority.IDLE);
      taskpool.execute(task2, taskpool.Priority.IDLE);
      taskpool.execute(task3, taskpool.Priority.IDLE);
      taskpool.cancel(task1);
      try {
        task1.removeDependency(task2);
      } catch (e) {
        expect((e as BusinessError).toString())
          .assertEqual("BusinessError: The dependency does not exist, taskpool:: executedTask cannot removeDependency");
      }
      done();
    });
    
    /**
     * @tc.number    : SUB_COMMONLIBRARY_TASK_REMOVE_DEPENDENCY_0900
     * @tc.name      : testTaskRemoveDependency0009
     * @tc.desc      : removeDependency for taskpool
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testTaskRemoveDependency0009', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let task1: taskpool.Task = new taskpool.Task(delaySum, 10, 20, 100)
      let task2: taskpool.Task = new taskpool.Task(delaySum, 30, 40, 200)
      let task3: taskpool.Task = new taskpool.Task(delaySum, 50, 60, 300)
      task1.addDependency(task2);
      task2.addDependency(task3);
      taskpool.execute(task1, taskpool.Priority.IDLE).then(() => {
        console.info("task1 success");
      })
      taskpool.execute(task2, taskpool.Priority.IDLE).then(() => {
        console.info("task2 success");
      })
      taskpool.execute(task3, taskpool.Priority.IDLE).then(() => {
        console.info("task3 success");
      })

      try {
        task2.removeDependency(task3);
      } catch (e) {
        expect((e as BusinessError).toString())
          .assertEqual("BusinessError: The dependency does not exist, taskpool:: executedTask cannot removeDependency");
      }
      done();
    });
  })
}