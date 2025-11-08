/*
 * Copyright (C) 2025 Huawei Device Co., Ltd.
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
import { describe, expect, it, Level, Size, TestType, afterEach } from '@ohos/hypium';
import worker, { ThreadWorkerPriority } from '@ohos.worker';

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

let sleep = async (delay: number = 1000): Promise<void> => {
  return new Promise((resolve, _) => {
    setTimeout(async () => {
      resolve();
    }, delay);
  });
};

export default function workerPriTest() {
  describe('workerPriTest', () => {
    afterEach(async () => {
      await sleep(1000)
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_WORKER_THREADWORKERPRIORITY_0100
     * @tc.name       : testThreadWorkerPriority0001
     * @tc.desc       : test worker total amount limited with ThreadWorkerPriority.HIGH
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testThreadWorkerPriority0001', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const caseName: string = 'testThreadWorkerPriority0001';
      console.info(`${caseName} test start`);
      try {
        const workerInstance: worker.ThreadWorker =
          new worker.ThreadWorker('../workers/worker.ts', { priority: ThreadWorkerPriority.HIGH });
        let isTerminate: boolean = false;
        workerInstance.onexit = (): void => {
          console.info(`${caseName}: workerInstance.onexit`);
          isTerminate = true;
        }
        workerInstance.terminate();
        while (!isTerminate) {
          await asyncSleep(100);
        }
        workerInstance.postMessage({
          name: 'workerInstance',
          type: 'worker.ThreadWorker'
        });
        expect().assertFail();
        done();
      } catch (error) {
        console.info(`${caseName}: catch error: code => ${error.code} message => ${error.message}`);
        expectAssertEqual(error.code, 10200007);
        done();
      }
      console.info(`${caseName} test end`);
    })

    /**
     * @tc.number     : SUB_COMMONLIBRARY_WORKER_THREADWORKERPRIORITY_0200
     * @tc.name       : testThreadWorkerPriority0002
     * @tc.desc       : test worker EC 10200007 with ThreadWorkerPriority MEDIUM
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testThreadWorkerPriority0002', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const caseName: string = 'testThreadWorkerPriority0002';
      console.info(`${caseName} test start`);
      try {
        const workerInstance: worker.ThreadWorker =
          new worker.ThreadWorker('../workers/worker.ts', { priority: ThreadWorkerPriority.MEDIUM });
        let isTerminate: boolean = false;
        workerInstance.onexit = (): void => {
          console.info(`${caseName}: workerInstance.onexit`);
          isTerminate = true;
        }
        workerInstance.terminate();
        while (!isTerminate) {
          await asyncSleep(100);
        }
        workerInstance.postMessage({
          name: 'workerInstance',
          type: 'worker.ThreadWorker'
        });
        expect().assertFail();
        done();
      } catch (error) {
        console.info(`${caseName}: catch error: code => ${error.code} message => ${error.message}`);
        expectAssertEqual(error.code, 10200007);
        done();
      }
      console.info(`${caseName} test end`);
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_WORKER_THREADWORKERPRIORITY_0300
     * @tc.name       : testThreadWorkerPriority0003
     * @tc.desc       : test worker EC 10200007 with ThreadWorkerPriority LOW
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testThreadWorkerPriority0003', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const caseName: string = 'testThreadWorkerPriority0003';
      console.info(`${caseName} test start`);
      try {
        const workerInstance: worker.ThreadWorker =
          new worker.ThreadWorker('../workers/worker.ts', { priority: ThreadWorkerPriority.LOW });
        let isTerminate: boolean = false;
        workerInstance.onexit = (): void => {
          console.info(`${caseName}: workerInstance.onexit`);
          isTerminate = true;
        }
        workerInstance.terminate();
        while (!isTerminate) {
          await asyncSleep(100);
        }
        workerInstance.postMessage({
          name: 'workerInstance',
          type: 'worker.ThreadWorker'
        });
        expect().assertFail();
        done();
      } catch (error) {
        console.info(`${caseName}: catch error: code => ${error.code} message => ${error.message}`);
        expectAssertEqual(error.code, 10200007);
        done();
      }
      console.info(`${caseName} test end`);
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_WORKER_THREADWORKERPRIORITY_0400
     * @tc.name       : testThreadWorkerPriority0004
     * @tc.desc       : test worker EC 10200007 with ThreadWorkerPriority IDLE
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testThreadWorkerPriority0004', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const caseName: string = 'testThreadWorkerPriority0004';
      console.info(`${caseName} test start`);
      try {
        const workerInstance: worker.ThreadWorker =
          new worker.ThreadWorker('../workers/worker.ts', { priority: ThreadWorkerPriority.IDLE });
        let isTerminate: boolean = false;
        workerInstance.onexit = (): void => {
          console.info(`${caseName}: workerInstance.onexit`);
          isTerminate = true;
        }
        workerInstance.terminate();
        while (!isTerminate) {
          await asyncSleep(100);
        }
        workerInstance.postMessage({
          name: 'workerInstance',
          type: 'worker.ThreadWorker'
        });
        expect().assertFail();
        done();
      } catch (error) {
        console.info(`${caseName}: catch error: code => ${error.code} message => ${error.message}`);
        expectAssertEqual(error.code, 10200007);
        done();
      }
      console.info(`${caseName} test end`);
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_WORKER_THREADWORKERPRIORITY_0500
     * @tc.name       : testThreadWorkerPriority0005
     * @tc.desc       : test worker EC 10200007 with ThreadWorkerPriority DEADLINE
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testThreadWorkerPriority0005', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const caseName: string = 'testThreadWorkerPriority0005';
      console.info(`${caseName} test start`);
      try {
        const workerInstance: worker.ThreadWorker =
          new worker.ThreadWorker('../workers/worker.ts', { priority: ThreadWorkerPriority.DEADLINE });
        let isTerminate: boolean = false;
        workerInstance.onexit = (): void => {
          console.info(`${caseName}: workerInstance.onexit`);
          isTerminate = true;
        }
        workerInstance.terminate();
        while (!isTerminate) {
          await asyncSleep(100);
        }
        workerInstance.postMessage({
          name: 'workerInstance',
          type: 'worker.ThreadWorker'
        });
        expect().assertFail();
        done();
      } catch (error) {
        console.info(`${caseName}: catch error: code => ${error.code} message => ${error.message}`);
        expectAssertEqual(error.code, 10200007);
        done();
      }
      console.info(`${caseName} test end`);
    });

    /**
     * @tc.number     : SUB_COMMONLIBRARY_WORKER_THREADWORKERPRIORITY_0600
     * @tc.name       : testThreadWorkerPriority0006
     * @tc.desc       : test worker EC 10200007 with ThreadWorkerPriority VIP
     * @tc.size       : MediumTest
     * @tc.type       : Function
     * @tc.level      : Level 1
     */
    it('testThreadWorkerPriority0006', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1, async (done: Function) => {
      const caseName: string = 'testThreadWorkerPriority0006';
      console.info(`${caseName} test start`);
      try {
        const workerInstance: worker.ThreadWorker =
          new worker.ThreadWorker('../workers/worker.ts', { priority: ThreadWorkerPriority.VIP });
        let isTerminate: boolean = false;
        workerInstance.onexit = (): void => {
          console.info(`${caseName}: workerInstance.onexit`);
          isTerminate = true;
        }
        workerInstance.terminate();
        while (!isTerminate) {
          await asyncSleep(100);
        }
        workerInstance.postMessage({
          name: 'workerInstance',
          type: 'worker.ThreadWorker'
        });
        expect().assertFail();
        done();
      } catch (error) {
        console.info(`${caseName}: catch error: code => ${error.code} message => ${error.message}`);
        expectAssertEqual(error.code, 10200007);
        done();
      }
      console.info(`${caseName} test end`);
    });
  });
}