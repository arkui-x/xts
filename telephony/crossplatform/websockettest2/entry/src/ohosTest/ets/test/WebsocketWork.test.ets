/*
 * Copyright (C) 2026 Huawei Device Co., Ltd.
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

import { describe, it, expect, Level, TestType, Size, beforeEach } from '@ohos/hypium';
import webSocket from '@ohos.net.webSocket';
import worker from '@ohos.worker';

interface WorkerMessageData {
  type: string;
  success: boolean;
  data?: WorkerTestData;
  error?: string;
  testId?: string;
  workerName?: string;
  testName?: string;
}

interface WorkerTestData {
  serverCreated?: boolean;
  startSuccess?: boolean;
  stopSuccess?: boolean;
  connections?: webSocket.WebSocketConnection[];
  sendSuccess?: boolean;
  closeSuccess?: boolean;
  testPassed?: boolean;
  listSuccess?: boolean;
}

interface ThreadWorkerEvent {
  data: WorkerMessageData;
}

interface WorkerTestParams {
  port?: number;
  serverPort?: number;
  serverIP?: string;
}

class WebSocketMultiWorkerTester {
  static async runMultiWorkerTest(
    caseName: string,
    testType: string,
    workerCount: number,
    testParams?: WorkerTestParams[],
    timeoutMs: number = 15000
  ): Promise<boolean[]> {
    return new Promise<boolean[]>((resolve) => {
      const workers: worker.ThreadWorker[] = [];
      const testResults: boolean[] = [];
      let completedCount: number = 0;

      for (let i: number = 0; i < workerCount; i++) {
        const workerName: string = `${caseName}_Worker${i + 1}`;
        const workerInstance: worker.ThreadWorker = new worker.ThreadWorker(
          '../workers/WebSocketWorker',
          { name: workerName }
        );

        workers.push(workerInstance);

        workerInstance.onmessage = (event: ThreadWorkerEvent): void => {
          const data: WorkerMessageData = event.data;

          if (data.type === 'testResult' && data.testId === `${caseName}_${i}`) {
            testResults.push(data.success);
            completedCount++;

            if (data.success) {
              console.info(`${workerName} passed the test`);
            } else {
              console.error(`${workerName} test failed: ${data.error}`);
            }

            workerInstance.terminate();

            if (completedCount === workerCount) {
              console.info(`${caseName} All Worker Tests Completed`);
              resolve(testResults);
            }
          }
        };

        workerInstance.onerror = (): void => {
          console.error(`${workerName} Worker encountered an error`);
          testResults.push(false);
          completedCount++;
          workerInstance.terminate();

          if (completedCount === workerCount) {
            resolve(testResults);
          }
        };

        const params: WorkerTestParams = testParams && testParams[i] ? testParams[i] : {};
        const message: WorkerTestMessage = {
          type: 'runWebSocketTest',
          testType: testType,
          testName: caseName,
          testId: `${caseName}_${i}`,
          workerName: workerName,
          port: params.port,
          serverPort: params.serverPort,
          serverIP: params.serverIP
        };
        workerInstance.postMessage(message);
      }

      console.info(`${caseName} starts ${workerCount} Worker threads`);

      setTimeout((): void => {
        if (completedCount < workerCount) {
          console.warn(`${caseName} timeout, terminate all workers`);
          workers.forEach((w: worker.ThreadWorker) => w.terminate());
          while (completedCount < workerCount) {
            testResults.push(false);
            completedCount++;
          }
          resolve(testResults);
        }
      }, timeoutMs);
    });
  }
}

interface WorkerTestMessage {
  type: string;
  testType: string;
  testName: string;
  testId: string;
  workerName: string;
  port?: number;
  serverPort?: number;
  serverIP?: string;
}

function sleep(time: number): Promise<string> {
  return new Promise<string>((resolve) => {
    setTimeout(() => {
      resolve('ok');
    }, time);
  });
}

export default function WebSocketMultiWorkerTest() {
  beforeEach(async () => {
    await sleep(1000);
  });
  describe('WebSocketMultiWorkerTest', () => {
    /**
     * @tc.number ArKUIX_WebSocket_CreateWebSocketServer_0300
     * @tc.name ArKUIX_WebSocket_CreateWebSocketServer_0300
     * @tc.desc Create multiple WebSocket servers (workers)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_WebSocket_CreateWebSocketServer_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocket_CreateWebSocketServer_0300';
        console.info(`${caseName} testing begins`);

        const results: boolean[] = await WebSocketMultiWorkerTester.runMultiWorkerTest(
          caseName,
          'createWebSocketServer',
          2
        );

        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_2800
     * @tc.name ArKUIX_WebSocketServer_Start_2800
     * @tc.desc Start WebSocket Server with Multiple Workers
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_2800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_2800';
        console.info(`${caseName} testing begins`);

        const testParams: WorkerTestParams[] = [
          { port: 9001 },
          { port: 9002 },
        ];

        const results: boolean[] = await WebSocketMultiWorkerTester.runMultiWorkerTest(
          caseName,
          'webSocketServerStart',
          2,
          testParams
        );

        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Stop_0300
     * @tc.name ArKUIX_WebSocketServer_Stop_0300
     * @tc.desc Stop WebSocket Server Multi Worker
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Stop_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Stop_0300';
        console.info(`${caseName} testing begins`);

        const testParams: WorkerTestParams[] = [
          { port: 9011 },
          { port: 9012 },
        ];

        const results: boolean[] = await WebSocketMultiWorkerTester.runMultiWorkerTest(
          caseName,
          'webSocketServerStop',
          3,
          testParams
        );

        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_ListAllConnections_0400
     * @tc.name ArKUIX_WebSocketServer_ListAllConnections_0400
     * @tc.desc List all connected multi workers
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_ListAllConnections_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_ListAllConnections_0400';
        console.info(`${caseName} testing begins`);

        const testParams: WorkerTestParams[] = [
          { port: 9021 },
          { port: 9022 },
        ];

        const results: boolean[] = await WebSocketMultiWorkerTester.runMultiWorkerTest(
          caseName,
          'webSocketServerListAllConnections',
          2,
          testParams
        );

        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Send_1100
     * @tc.name ArKUIX_WebSocketServer_Send_1100
     * @tc.desc Sending messages to multiple workers
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Send_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Send_1100';
        console.info(`${caseName} testing begins`);

        const testParams: WorkerTestParams[] = [
          { port: 9031 },
          { port: 9032 },
        ];

        const results: boolean[] = await WebSocketMultiWorkerTester.runMultiWorkerTest(
          caseName,
          'webSocketServerSend',
          2,
          testParams
        );

        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Close_1600
     * @tc.name ArKUIX_WebSocketServer_Close_1600
     * @tc.desc Close the connection to multiple workers
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Close_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Close_1600';
        console.info(`${caseName} testing begins`);

        const testParams: WorkerTestParams[] = [
          { port: 9041 },
          { port: 9042 },
        ];

        const results: boolean[] = await WebSocketMultiWorkerTester.runMultiWorkerTest(
          caseName,
          'webSocketServerClose',
          3,
          testParams
        );

        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_On_Connect_0400
     * @tc.name ArKUIX_WebSocketServer_On_Connect_0400
     * @tc.desc WebSocket server connection event subscription for multiple workers
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_On_Connect_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_On_Connect_0400';
        console.info(`${caseName} testing begins`);

        const testParams: WorkerTestParams[] = [
          { port: 9091 },
          { port: 9092 },
        ];

        const results: boolean[] = await WebSocketMultiWorkerTester.runMultiWorkerTest(
          caseName,
          'webSocketServerOnConnect',
          2,
          testParams
        );

        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_Connect_0700
     * @tc.name ArKUIX_WebSocketServer_Off_Connect_0700
     * @tc.desc WebSocket Server Connection Event Unsubscribe (specify callback) Multi Worker
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_Connect_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_Connect_0700';
        console.info(`${caseName} testing begins`);

        const testParams: WorkerTestParams[] = [
          { port: 9101 },
          { port: 9102 },
        ];

        const results: boolean[] = await WebSocketMultiWorkerTester.runMultiWorkerTest(
          caseName,
          'webSocketServerOffConnectSpecific',
          2,
          testParams
        );

        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_Connect_0800
     * @tc.name ArKUIX_WebSocketServer_Off_Connect_0800
     * @tc.desc WebSocket Server Connection Event Unsubscribe (All) Multi Worker
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_Connect_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_Connect_0800';
        console.info(`${caseName} testing begins`);

        const testParams: WorkerTestParams[] = [
          { port: 9111 },
          { port: 9112 },
        ];

        const results: boolean[] = await WebSocketMultiWorkerTester.runMultiWorkerTest(
          caseName,
          'webSocketServerOffConnectAll',
          2,
          testParams
        );

        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_On_MessageReceive_0400
     * @tc.name ArKUIX_WebSocketServer_On_MessageReceive_0400
     * @tc.desc WebSocket Server Message Reception Event Subscription Multi Worker
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_On_MessageReceive_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_On_MessageReceive_0400';
        console.info(`${caseName} testing begins`);

        const testParams: WorkerTestParams[] = [
          { port: 9121 },
          { port: 9122 },
        ];

        const results: boolean[] = await WebSocketMultiWorkerTester.runMultiWorkerTest(
          caseName,
          'webSocketServerOnMessage',
          2,
          testParams
        );

        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_MessageReceive_0700
     * @tc.name ArKUIX_WebSocketServer_Off_MessageReceive_0700
     * @tc.desc WebSocket Server Message Reception Event Unsubscribe (specify callback) Multi Worker
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_MessageReceive_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_MessageReceive_0700';
        console.info(`${caseName} testing begins`);

        const testParams: WorkerTestParams[] = [
          { port: 9131 },
          { port: 9132 },
        ];

        const results: boolean[] = await WebSocketMultiWorkerTester.runMultiWorkerTest(
          caseName,
          'webSocketServerOffMessageSpecific',
          2,
          testParams
        );

        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_MessageReceive_0800
     * @tc.name ArKUIX_WebSocketServer_Off_MessageReceive_0800
     * @tc.desc WebSocket Server Message Reception Event Unsubscribe (All) Multi Worker
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_MessageReceive_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_MessageReceive_0800';
        console.info(`${caseName} testing begins`);

        const testParams: WorkerTestParams[] = [
          { port: 9141 },
          { port: 9142 },
        ];

        const results: boolean[] = await WebSocketMultiWorkerTester.runMultiWorkerTest(
          caseName,
          'webSocketServerOffMessageAll',
          2,
          testParams
        );

        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_On_Error_0400
     * @tc.name ArKUIX_WebSocketServer_On_Error_0400
     * @tc.desc WebSocket server error event subscription for multiple workers
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_On_Error_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_On_Error_0400';
        console.info(`${caseName} testing begins`);

        const testParams: WorkerTestParams[] = [
          { port: 9151 },
          { port: 9152 },
        ];

        const results: boolean[] = await WebSocketMultiWorkerTester.runMultiWorkerTest(
          caseName,
          'webSocketServerOnError',
          3,
          testParams
        );

        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_Error_0600
     * @tc.name ArKUIX_WebSocketServer_Off_Error_0600
     * @tc.desc WebSocket Server Error Event Unsubscribe (specify callback) Multiple Workers
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_Error_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_Error_0600';
        console.info(`${caseName} testing begins`);

        const testParams: WorkerTestParams[] = [
          { port: 9161 },
          { port: 9162 },
        ];

        const results: boolean[] = await WebSocketMultiWorkerTester.runMultiWorkerTest(
          caseName,
          'webSocketServerOffErrorSpecific',
          2,
          testParams
        );

        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_Error_0700
     * @tc.name ArKUIX_WebSocketServer_Off_Error_0700
     * @tc.desc WebSocket Server Error Event Unsubscribe (All) Multiple Workers
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_Error_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_Error_0700';
        console.info(`${caseName} testing begins`);

        const testParams: WorkerTestParams[] = [
          { port: 9171 },
          { port: 9172 },
        ];

        const results: boolean[] = await WebSocketMultiWorkerTester.runMultiWorkerTest(
          caseName,
          'webSocketServerOffErrorAll',
          3,
          testParams
        );

        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_On_Close_0600
     * @tc.name ArKUIX_WebSocketServer_On_Close_0600
     * @tc.desc WebSocket server shutdown event subscription for multiple workers
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_On_Close_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_On_Close_0600';
        console.info(`${caseName} testing begins`);

        const testParams: WorkerTestParams[] = [
          { port: 9181 },
          { port: 9182 },
        ];

        const results: boolean[] = await WebSocketMultiWorkerTester.runMultiWorkerTest(
          caseName,
          'webSocketServerOnClose',
          2,
          testParams
        );

        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_Close_0700
     * @tc.name ArKUIX_WebSocketServer_Off_Close_0700
     * @tc.desc WebSocket Server Shutdown Event Unsubscribe (specify callback) Multiple Workers
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_Close_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_Close_0700';
        console.info(`${caseName} testing begins`);

        const testParams: WorkerTestParams[] = [
          { port: 9191 },
          { port: 9192 },
        ];

        const results: boolean[] = await WebSocketMultiWorkerTester.runMultiWorkerTest(
          caseName,
          'webSocketServerOffCloseSpecific',
          2,
          testParams
        );

        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_Close_0800
     * @tc.name ArKUIX_WebSocketServer_Off_Close_0800
     * @tc.desc WebSocket Server Shutdown Event Unsubscribe (All) Multiple Workers
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_Close_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_Close_0800';
        console.info(`${caseName} testing begins`);

        const testParams: WorkerTestParams[] = [
          { port: 9201 },
          { port: 9202 },
        ];

        const results: boolean[] = await WebSocketMultiWorkerTester.runMultiWorkerTest(
          caseName,
          'webSocketServerOffCloseAll',
          2,
          testParams
        );

        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

  });
}