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

function mathSqrt(value1: number): number {
  "use concurrent"
  return Math.sqrt(value1);
}

function mathPow(value1: number, value2: number): number {
  "use concurrent"
  return Math.pow(value1, value2);
}

function promiseCase(): Promise<void | Object> {
  let p: Promise<void | Object> = new Promise((resolve: Function, reject: Function) => {
    setTimeout(() => {
      resolve(1);
    }, 100);
  });
  return p;
}

export default function IsCanceledTest() {
  describe('IsCanceledTest', () => {
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
     * @tc.number    : SUB_COMMONLIBRARY_ISCANCELED_0100
     * @tc.name      : testTaskpoolTaskIsCanceled0001
     * @tc.desc      : Check if the task that is currently running has been canceled
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testTaskpoolTaskIsCanceled0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let caseName: string = 'testTaskpoolTaskIsCanceled0001';
      console.info(`${caseName} test start`);
      try {
        let isTerminate1: boolean = false;
        let isTerminate2: boolean = false;
        let isTerminate3: boolean = false;
        let result1: number = 0;
        let result2: number = 0;
        let result3: number = 0;
        let taskConstructor1: taskpool.Task = new taskpool.Task(mathSqrt, 100);
        let taskConstructor2: taskpool.Task = new taskpool.Task(mathSqrt, 121);
        let taskConstructor3: taskpool.Task = new taskpool.Task(mathSqrt, 144);
        taskpool.execute(taskConstructor1).then((res: Object) => {
          console.info(`${caseName}: taskConstructor1 return value: ${JSON.stringify(res)}`);
          isTerminate1 = true;
          result1 = res as number;
        });
        taskpool.execute(taskConstructor2).then((res: Object) => {
          console.info(`${caseName}: taskConstructor2 return value: ${JSON.stringify(res)}`);
          isTerminate2 = true;
          result2 = res as number;
        });
        taskpool.execute(taskConstructor3).then((res: Object) => {
          console.info(`${caseName}: taskConstructor3 return value: ${JSON.stringify(res)}`);
          isTerminate3 = true;
          result3 = res as number;
        });
        taskpool.cancel(taskConstructor2);
        taskpool.cancel(taskConstructor3);
        while (!(isTerminate1 || isTerminate2 || isTerminate3)) {
          await promiseCase();
        }
        expect(result1).assertEqual(10);
        expect(result2).assertEqual(0);
        expect(result3).assertEqual(0);
        expect(taskpool.Task.isCanceled() == true);
        done();
      } catch (error) {
        console.info(`${caseName}: catch error: code => ${error.code} message => ${error.message}`);
        expect().assertFail();
        done();
      }
      console.info(`${caseName} test end`);
    });

    /**
     * @tc.number    : SUB_COMMONLIBRARY_ISCANCELED_0200
     * @tc.name      : testTaskpoolTaskIsCanceled0002
     * @tc.desc      : Check if the task that is currently running has been canceled
     * @tc.size      : MediumTest
     * @tc.type      : Function
     * @tc.level     : Level 1
     */
    it('testTaskpoolTaskIsCanceled0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      let caseName: string = 'testTaskpoolTaskIsCanceled0002';
      console.info(`${caseName} test start`);
      try {
        let isTerminate1: boolean = false;
        let isTerminate2: boolean = false;
        let isTerminate3: boolean = false;
        let result1: number = 0;
        let result2: number = 0;
        let result3: number = 0;
        let taskConstructor1: taskpool.Task = new taskpool.Task(mathPow, 10, 2);
        let taskConstructor2: taskpool.Task = new taskpool.Task(mathPow, 2, 4);
        let taskConstructor3: taskpool.Task = new taskpool.Task(mathPow, 4, 3);
        taskpool.execute(taskConstructor1).then((res: Object) => {
          console.info(`${caseName}: taskConstructor1 return value: ${JSON.stringify(res)}`);
          isTerminate1 = true;
          result1 = res as number;
          expect(result1).assertEqual(100);
        });
        taskpool.execute(taskConstructor2).then((res: Object) => {
          console.info(`${caseName}: taskConstructor2 return value: ${JSON.stringify(res)}`);
          isTerminate2 = true;
          result2 = res as number;
          expect(result2).assertEqual(16);
        });
        taskpool.execute(taskConstructor3).then((res: Object) => {
          console.info(`${caseName}: taskConstructor3 return value: ${JSON.stringify(res)}`);
          isTerminate3 = true;
          result3 = res as number;
          expect(result3).assertEqual(64);
        });
        while (!(isTerminate1 && isTerminate2 && isTerminate3)) {
          await promiseCase();
        }
        expect(taskpool.Task.isCanceled() == false);
        let result: number = result1 + result2 + result3;
        expect(result).assertEqual(180);
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