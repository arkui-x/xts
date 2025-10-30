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
import { describe, expect, it, TestType, Size, Level, beforeAll, beforeEach, afterEach, afterAll} from '@ohos/hypium'
import worker from '@ohos.worker'

const asyncSleep: Function = (time: number): Promise<Object> => {
  return new Promise(resolve => setTimeout(resolve, time));
}
const expectAssertEqual: Function = (actualValue: number | string, expectValue: number | string): void => {
  try {
    expect(actualValue).assertEqual(expectValue);
  } catch (error) {
    console.info(`expectAssertEqual catch error: ${error}`);
  }
}
const expectAssertTrue: Function = (actualValue: boolean): void => {
  try {
    expect(actualValue).assertTrue();
  } catch (error) {
    console.info(`expectAssertTrue catch error: ${error}`);
  }
}
function sleep(ms:number) {
  return new Promise<ESObject>((resolve) => setTimeout(resolve, ms));
}

export default function dispatchEventTest() {
  describe('dispatchEventTest', () => {
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
     * @tc.number : SUB_COMMONLIBRARY_WORKER_EVENT_TARGET_DISPATCH_EVENT_0100
     * @tc.name   : testDispatchEvent0001
     * @tc.desc   : test distribute events defined in Worker.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testDispatchEvent0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let caseName: string = 'testWorkerWorkerEventTargetDispatchEvent0001';
        console.info(`${caseName} test start`);
        try {
          let count: number = 0;
          let workerInstance_1: worker.ThreadWorker = new worker.ThreadWorker('@worker.ts');
          let isTerminate_1: boolean = false;
          let flag_1: boolean = false;
          workerInstance_1.onexit = (): void => {
            console.info(`${caseName}: workerInstance_1.onexit`);
            isTerminate_1 = true;
          }
          workerInstance_1.addEventListener('workerInstance_1_addEventListener', () => {
            console.info(`${caseName}: workerInstance_1_addEventListener listener callback`);
            flag_1 = true;
            count++;
          });
          let workerInstance_2: worker.ThreadWorker = new worker.ThreadWorker('@worker.ts');
          let isTerminate_2: boolean = false;
          let flag_2: boolean = false;
          workerInstance_2.onexit = (): void => {
            console.info(`${caseName}: workerInstance_2.onexit`);
            isTerminate_2 = true;
          }
          workerInstance_2.addEventListener('workerInstance_2_addEventListener', () => {
            console.info(`${caseName}: workerInstance_2_addEventListener listener callback`);
            flag_2 = true;
            count++;
          });
          let dispatchEventSuccess_1 = workerInstance_1.dispatchEvent({
            type: 'workerInstance_1_addEventListener', timeStamp: 0
          });
          console.info(`${caseName}: dispatchEventSuccess_1 = ${dispatchEventSuccess_1}`);
          expectAssertTrue(dispatchEventSuccess_1);
          let dispatchEventSuccess_2 = workerInstance_2.dispatchEvent({
            type: 'workerInstance_2_addEventListener', timeStamp: 0
          });
          console.info(`${caseName}: dispatchEventSuccess_2 = ${dispatchEventSuccess_2}`);
          expectAssertTrue(dispatchEventSuccess_2);
          while (!(flag_1 && flag_2)) {
            await asyncSleep(100);
          }
          expectAssertEqual(count, 2);
          workerInstance_1.removeEventListener('workerInstance_1_addEventListener');
          workerInstance_2.removeEventListener('workerInstance_2_addEventListener');
          workerInstance_1.terminate();
          workerInstance_2.terminate();
          while (!(isTerminate_1 && isTerminate_2)) {
            await asyncSleep(100);
          }
          done();
        } catch (error) {
          console.info(`${caseName}: catch error: code => ${error.code} message => ${error.message}`);
          expect().assertFail();
          done();
        }
        console.info(`${caseName} test end`);
      });

    /**
     * @tc.number : SUB_COMMONLIBRARY_WORKER_EVENT_TARGET_DISPATCH_EVENT_0200
     * @tc.name   : testDispatchEvent0002
     * @tc.desc   : test distribute events defined in Worker.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testDispatchEvent0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let caseName: string = 'testWorkerWorkerEventTargetDispatchEvent0002';
        console.info(`${caseName} test start`);
        try {
          let count: number = 0;
          let workerInstance_1: worker.ThreadWorker = new worker.ThreadWorker('@worker.ts');
          let isTerminate_1: boolean = false;
          let flag_1: boolean = false;
          workerInstance_1.onexit = (): void => {
            console.info(`${caseName}: workerInstance_1.onexit`);
            isTerminate_1 = true;
          }
          workerInstance_1.addEventListener('workerInstance_1_addEventListener', () => {
            console.info(`${caseName}: workerInstance_1_addEventListener listener callback`);
            flag_1 = true;
            let dispatchEventSuccess_2 = workerInstance_2.dispatchEvent({
              type: 'workerInstance_2_addEventListener', timeStamp: 0
            });
            console.info(`${caseName}: dispatchEventSuccess_2 = ${dispatchEventSuccess_2}`);
            expectAssertTrue(dispatchEventSuccess_2);
          });
          let workerInstance_2: worker.ThreadWorker = new worker.ThreadWorker('@worker.ts');
          let isTerminate_2: boolean = false;
          let flag_2: boolean = false;
          workerInstance_2.onexit = (): void => {
            console.info(`${caseName}: workerInstance_2.onexit`);
            isTerminate_2 = true;
          }
          workerInstance_2.addEventListener('workerInstance_2_addEventListener', () => {
            console.info(`${caseName}: workerInstance_2_addEventListener listener callback`);
            flag_2 = true;
            count++;
          });
          let dispatchEventSuccess_1 = workerInstance_1.dispatchEvent({
            type: 'workerInstance_1_addEventListener', timeStamp: 0
          });
          console.info(`${caseName}: dispatchEventSuccess_1 = ${dispatchEventSuccess_1}`);
          expectAssertTrue(dispatchEventSuccess_1);
          while (!(flag_1 && flag_2)) {
            await asyncSleep(100);
          }
          expectAssertEqual(count, 1);
          workerInstance_1.removeEventListener('workerInstance_1_addEventListener');
          workerInstance_2.removeEventListener('workerInstance_2_addEventListener');
          workerInstance_1.terminate();
          workerInstance_2.terminate();
          while (!(isTerminate_1 && isTerminate_2)) {
            await asyncSleep(100);
          }
          done();
        } catch (error) {
          console.info(`${caseName}: catch error: code => ${error.code} message => ${error.message}`);
          expect().assertFail();
          done();
        }
        console.info(`${caseName} test end`);
      });

    /**
     * @tc.number : SUB_COMMONLIBRARY_WORKER_EVENT_TARGET_DISPATCH_EVENT_0300
     * @tc.name   : testDispatchEvent0003
     * @tc.desc   : test distribute events defined in Worker.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testDispatchEvent0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let caseName: string = 'testWorkerWorkerEventTargetDispatchEvent0003';
        console.info(`${caseName} test start`);
        try {
          let count: number = 0;
          let workerInstance_1: worker.ThreadWorker = new worker.ThreadWorker('@worker.ts');
          let isTerminate_1: boolean = false;
          let flag_1: boolean = false;
          workerInstance_1.onexit = (): void => {
            console.info(`${caseName}: workerInstance_1.onexit`);
            isTerminate_1 = true;
          }
          workerInstance_1.on('workerInstance_1_on', () => {
            console.info(`${caseName}: workerInstance_1_on listener callback`);
            flag_1 = true;
            count++;
          });
          let workerInstance_2: worker.ThreadWorker = new worker.ThreadWorker('@worker.ts');
          let isTerminate_2: boolean = false;
          let flag_2: boolean = false;
          workerInstance_2.onexit = (): void => {
            console.info(`${caseName}: workerInstance_2.onexit`);
            isTerminate_2 = true;
          }
          workerInstance_2.on('workerInstance_2_on', () => {
            console.info(`${caseName}: workerInstance_2_on listener callback`);
            flag_2 = true;
            count++;
          });
          let dispatchEventSuccess_1 = workerInstance_1.dispatchEvent({
            type: 'workerInstance_1_on', timeStamp: 0
          });
          console.info(`${caseName}: dispatchEventSuccess_1 = ${dispatchEventSuccess_1}`);
          expectAssertTrue(dispatchEventSuccess_1);
          let dispatchEventSuccess_2 = workerInstance_2.dispatchEvent({
            type: 'workerInstance_2_on', timeStamp: 0
          });
          console.info(`${caseName}: dispatchEventSuccess_2 = ${dispatchEventSuccess_2}`);
          expectAssertTrue(dispatchEventSuccess_2);
          while (!(flag_1 && flag_2)) {
            await asyncSleep(100);
          }
          expectAssertEqual(count, 2);
          workerInstance_1.removeEventListener('workerInstance_1_on');
          workerInstance_2.removeEventListener('workerInstance_2_on');
          workerInstance_1.terminate();
          workerInstance_2.terminate();
          while (!(isTerminate_1 && isTerminate_2)) {
            await asyncSleep(100);
          }
          done();
        } catch (error) {
          console.info(`${caseName}: catch error: code => ${error.code} message => ${error.message}`);
          expect().assertFail();
          done();
        }
        console.info(`${caseName} test end`);
      });

    /**
     * @tc.number : SUB_COMMONLIBRARY_WORKER_EVENT_TARGET_DISPATCH_EVENT_0400
     * @tc.name   : testDispatchEvent0004
     * @tc.desc   : test distribute events defined in Worker.
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : Level 1
     */
    it('testDispatchEvent0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        let caseName: string = 'testWorkerWorkerEventTargetDispatchEvent0004';
        console.info(`${caseName} test start`);
        try {
          let count: number = 0;
          let workerInstance_1: worker.ThreadWorker = new worker.ThreadWorker('@worker.ts');
          let isTerminate_1: boolean = false;
          let flag_1: boolean = false;
          workerInstance_1.onexit = (): void => {
            console.info(`${caseName}: workerInstance_1.onexit`);
            isTerminate_1 = true;
          }
          workerInstance_1.on('workerInstance_1_on', () => {
            console.info(`${caseName}: workerInstance_1_on listener callback`);
            flag_1 = true;
            let dispatchEventSuccess_2 = workerInstance_2.dispatchEvent({
              type: 'workerInstance_2_on', timeStamp: 0
            });
            console.info(`${caseName}: dispatchEventSuccess_2 = ${dispatchEventSuccess_2}`);
            expectAssertTrue(dispatchEventSuccess_2);
          });
          let workerInstance_2: worker.ThreadWorker = new worker.ThreadWorker('@worker.ts');
          let isTerminate_2: boolean = false;
          let flag_2: boolean = false;
          workerInstance_2.onexit = (): void => {
            console.info(`${caseName}: workerInstance_2.onexit`);
            isTerminate_2 = true;
          }
          workerInstance_2.on('workerInstance_2_on', () => {
            console.info(`${caseName}: workerInstance_2_on listener callback`);
            flag_2 = true;
            count++;
          });
          let dispatchEventSuccess_1 = workerInstance_1.dispatchEvent({
            type: 'workerInstance_1_on', timeStamp: 0
          });
          console.info(`${caseName}: dispatchEventSuccess_1 = ${dispatchEventSuccess_1}`);
          expectAssertTrue(dispatchEventSuccess_1);
          while (!(flag_1 && flag_2)) {
            await asyncSleep(100);
          }
          expectAssertEqual(count, 1);
          workerInstance_1.removeEventListener('workerInstance_1_on');
          workerInstance_2.removeEventListener('workerInstance_2_on');
          workerInstance_1.terminate();
          workerInstance_2.terminate();
          while (!(isTerminate_1 && isTerminate_2)) {
            await asyncSleep(100);
          }
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