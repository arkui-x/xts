import { describe, afterEach, it, expect, Level, Size, TestType } from '@ohos/hypium';
import { socket } from '@kit.NetworkKit';
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
  localAddress?: socket.NetAddress;
  tlsCreated?: boolean;
  serverCreated?: boolean;
  sendSuccess?: boolean;
  testPassed?: boolean;
}

interface ThreadWorkerEvent {
  data: WorkerMessageData;
}

interface WorkerTestParams {
  port?: number;
  serverPort?: number;
  bindPort?: number;
}

class MultiWorkerTester {
  static async runMultiWorkerTest(
    caseName: string,
    testType: string,
    workerCount: number,
    testParams?: WorkerTestParams[]
  ): Promise<boolean[]> {
    return new Promise<boolean[]>((resolve) => {
      const workers: worker.ThreadWorker[] = [];
      const testResults: boolean[] = [];
      let completedCount: number = 0;

      for (let i: number = 0; i < workerCount; i++) {
        const workerName: string = `${caseName}_Worker${i + 1}`;
        const workerInstance: worker.ThreadWorker = new worker.ThreadWorker(
          './../workers/socketWorker.ts',
          { name: workerName }
        );

        workers.push(workerInstance);

        workerInstance.onmessage = (event: ThreadWorkerEvent): void => {
          const data: WorkerMessageData = event.data;

          if (data.type === 'testResult' && data.testId === `${caseName}_${i}`) {
            testResults.push(data.success);
            completedCount++;

            if (data.success) {
              console.info(`${workerName} test success`);
            } else {
              console.error(`${workerName} test fail: ${data.error}`);
            }

            workerInstance.terminate();

            if (completedCount === workerCount) {
              console.info(`${caseName} all Worker test completed`);
              resolve(testResults);
            }
          }
        };

        workerInstance.onerror = (): void => {
          console.error(`${workerName} Worker occurred error`);
          testResults.push(false);
          completedCount++;
          workerInstance.terminate();

          if (completedCount === workerCount) {
            resolve(testResults);
          }
        };

        const params: WorkerTestParams = testParams && testParams[i] ? testParams[i] : {};
        const message: WorkerTestMessage = {
          type: 'runSocketTest',
          testType: testType,
          testName: caseName,
          testId: `${caseName}_${i}`,
          workerName: workerName,
          port: params.port,
          serverPort: params.serverPort,
          bindPort: params.bindPort
        };
        workerInstance.postMessage(message);
      }

      console.info(`${caseName} start ${workerCount} Worker thread`);

      setTimeout((): void => {
        if (completedCount < workerCount) {
          console.warn(`${caseName} timeout，stop all Worker`);
          workers.forEach((w: worker.ThreadWorker) => w.terminate());
          while (completedCount < workerCount) {
            testResults.push(false);
            completedCount++;
          }
          resolve(testResults);
        }
      }, 20000);
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
  bindPort?: number;
}

function sleep(time: number): Promise<string> {
  return new Promise<string>((resolve) => {
    setTimeout(() => {
      resolve('ok')
    }, time)
  });
}

export default function SocketWorkerTest() {
  describe('SocketWorkerTest', () => {
    afterEach(async () => {
      await sleep(2000);
    });


    /**
     * @tc.number ArKUIX_TCPSocket_GetLocalAddress_0300
     * @tc.name ArKUIX_TCPSocket_GetLocalAddress_0300
     * @tc.desc Test the functionality of the getLocalAddress interface function
     * using the promise asynchronous callback method(workers)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_TCPSocket_GetLocalAddress_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocket_GetLocalAddress_0300';
        const testParams: WorkerTestParams[] = [
          { port: 8081 },
          { port: 8082 },
        ];
        const results: boolean[] = await MultiWorkerTester.runMultiWorkerTest(
          caseName,
          'getLocalAddress',
          2,
          testParams
        );
        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_Socket_ConstructTCPSocketServerInstance_0200
     * @tc.name ArKUIX_Socket_ConstructTCPSocketServerInstance_0200
     * @tc.desc Function test constructTCPSocketServerInstance interface function(workers)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_Socket_ConstructTCPSocketServerInstance_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_Socket_ConstructTCPSocketServerInstance_0200';
        const results: boolean[] = await MultiWorkerTester.runMultiWorkerTest(
          caseName,
          'constructTCPSocketServerInstance',
          2
        );
        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_Socket_ConstructTLSSocketServerInstance_0200
     * @tc.name ArKUIX_Socket_ConstructTLSSocketServerInstance_0200
     * @tc.desc Function test constructTLSSocketServerInstance interface function(workers)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_Socket_ConstructTLSSocketServerInstance_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_Socket_ConstructTLSSocketServerInstance_0200';
        const results: boolean[] = await MultiWorkerTester.runMultiWorkerTest(
          caseName,
          'constructTLSSocketServerInstance',
          2
        );
        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_UDPSocket_GetLocalAddress_0300
     * @tc.name ArKUIX_UDPSocket_GetLocalAddress_0300
     * @tc.desc Test the functionality of the getLocalAddress interface function(workers)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_UDPSocket_GetLocalAddress_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_UDPSocket_GetLocalAddress_0300';
        const testParams: WorkerTestParams[] = [
          { bindPort: 15001 },
          { bindPort: 15002 },
        ];
        const results: boolean[] = await MultiWorkerTester.runMultiWorkerTest(
          caseName,
          'udpGetLocalAddress',
          2,
          testParams
        );
        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_3700
     * @tc.name ArKUIX_TCPSocketConnection_Send_3700
     * @tc.desc Sending data through TCP Socket Connection connection,Sending data as a string;callback(workers)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_3700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_3700';
        const testParams: WorkerTestParams[] = [
          { serverPort: 14001 },
          { serverPort: 14002 },
        ];
        const results: boolean[] = await MultiWorkerTester.runMultiWorkerTest(
          caseName,
          'tcpSend',
          2,
          testParams
        );
        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_LocalSocket_GetLocalAddress_0300
     * @tc.name ArKUIX_LocalSocket_GetLocalAddress_0300
     * @tc.desc Test the functionality of the getLocalAddress interface function(workers)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_LocalSocket_GetLocalAddress_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_LocalSocket_GetLocalAddress_0300';
        const results: boolean[] = await MultiWorkerTester.runMultiWorkerTest(
          caseName,
          'localSocketGetLocalAddress',
          2
        );
        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_LocalSocketConnection_GetLocalAddress_0300
     * @tc.name ArKUIX_LocalSocketConnection_GetLocalAddress_0300
     * @tc.desc Test the functionality of the getLocalAddress interface function(workers)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_LocalSocketConnection_GetLocalAddress_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_LocalSocketConnection_GetLocalAddress_0300';
        const results: boolean[] = await MultiWorkerTester.runMultiWorkerTest(
          caseName,
          'localSocketConnectionGetLocalAddress',
          2
        );
        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });


    /**
     * @tc.number ArKUIX_LocalSocketServer_GetLocalAddress_0300
     * @tc.name ArKUIX_LocalSocketServer_GetLocalAddress_0300
     * @tc.desc Test the functionality of the getLocalAddress interface function(workers)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_LocalSocketServer_GetLocalAddress_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_LocalSocketServer_GetLocalAddress_0300';
        const results: boolean[] = await MultiWorkerTester.runMultiWorkerTest(
          caseName,
          'localSocketServerGetLocalAddress',
          2
        );
        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_LocalSocketServer_Close_0200
     * @tc.name ArKUIX_LocalSocketServer_Close_0200
     * @tc.desc Test the functionality of the close interface function under LocalSocketServer(workers)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_LocalSocketServer_Close_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_LocalSocketServer_Close_0200';
        const results: boolean[] = await MultiWorkerTester.runMultiWorkerTest(
          caseName,
          'localSocketServerClose',
          2
        );
        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_TCPSocket_GetSocketFd_1600
     * @tc.name ArKUIX_TCPSocket_GetSocketFd_1600
     * @tc.desc Get TCPSocket status,after bind; callback(workers)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_TCPSocket_GetSocketFd_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocket_GetSocketFd_1600';
        const results: boolean[] = await MultiWorkerTester.runMultiWorkerTest(
          caseName,
          'tcpSocketGetSocketFd',
          2
        );
        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Close_0800
     * @tc.name ArKUIX_TCPSocketConnection_Close_0800
     * @tc.desc Close a connection established with TCP Socket; callback(workers)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Close_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Close_0800';
        const testParams: WorkerTestParams[] = [
          { port: 14036, serverPort: 14037 },
          { port: 14038, serverPort: 14039 },
        ];
        const results: boolean[] = await MultiWorkerTester.runMultiWorkerTest(
          caseName,
          'tcpSocketConnectionClose',
          2,
          testParams
        );
        const allPassed: boolean = results.every((result: boolean) => result === true);
        sleep(500)
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_TCPSocketConnection_GetRemoteAddress_0800
     * @tc.name ArKUIX_TCPSocketConnection_GetRemoteAddress_0800
     * @tc.desc Test the functionality of the getRemoteAddress interface function(workers)
     * using the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_GetRemoteAddress_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_GetRemoteAddress_0800';
        const testParams: WorkerTestParams[] = [
          { port: 14043, serverPort: 14044 },
          { port: 14045, serverPort: 14046 },
        ];
        const results: boolean[] = await MultiWorkerTester.runMultiWorkerTest(
          caseName,
          'tcpSocketConnectionGetRemoteAddress',
          2,
          testParams
        );
        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_TCPSocketConnection_GetLocalAddress_0300
     * @tc.name ArKUIX_TCPSocketConnection_GetLocalAddress_0300
     * @tc.desc Test the functionality of the getLocalAddress interface function(workers)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_GetLocalAddress_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_GetLocalAddress_0300';
        const testParams: WorkerTestParams[] = [
          { port: 14050, serverPort: 14051 },
          { port: 14052, serverPort: 14053 },
        ];
        const results: boolean[] = await MultiWorkerTester.runMultiWorkerTest(
          caseName,
          'tcpSocketConnectionGetLocalAddress',
          2,
          testParams
        );
        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Off_Close_0800
     * @tc.name ArKUIX_TCPSocketConnection_Off_Close_0800
     * @tc.desc UnSubscription to the closure event of TCPSocketConnection(workers)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Off_Close_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Off_Close_0800';
        const testParams: WorkerTestParams[] = [
          { port: 14066, serverPort: 14067 },
          { port: 14068, serverPort: 14069 },
        ];
        const results: boolean[] = await MultiWorkerTester.runMultiWorkerTest(
          caseName,
          'tcpSocketConnectionOffClose',
          2,
          testParams
        );
        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_3800
     * @tc.name ArKUIX_TCPSocketServer_Listen_3800
     * @tc.desc Test the functionality of the listen interface function ,using the callback asynchronous callback method(workers)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_3800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_3800';
        const testParams: WorkerTestParams[] = [
          { serverPort: 15001 },
          { serverPort: 15002 },
        ];
        const results: boolean[] = await MultiWorkerTester.runMultiWorkerTest(
          caseName,
          'tcpSocketServerListen',
          2,
          testParams
        );
        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_TCPSocketServer_Close_0400
     * @tc.name ArKUIX_TCPSocketServer_Close_0400
     * @tc.desc Test the functionality of the close interface function and then call the close method(workers)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Close_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Close_0400';
        const testParams: WorkerTestParams[] = [
          { serverPort: 15004 },
          { serverPort: 15005 },
        ];
        const results: boolean[] = await MultiWorkerTester.runMultiWorkerTest(
          caseName,
          'tcpSocketServerClose',
          2,
          testParams
        );
        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_TCPSocketServer_GetState_1000
     * @tc.name ArKUIX_TCPSocketServer_GetState_1000
     * @tc.desc Obtain the TCP Socket Server status after listening(workers)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_GetState_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_GetState_1000';
        const testParams: WorkerTestParams[] = [
          { serverPort: 15007 },
          { serverPort: 15008 },
        ];
        const results: boolean[] = await MultiWorkerTester.runMultiWorkerTest(
          caseName,
          'tcpSocketServerGetState',
          2,
          testParams
        );
        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_6600
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_6600
     * @tc.desc Set other properties of the TCP Socket Server connection after listening(workers)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_6600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_6600';
        const testParams: WorkerTestParams[] = [
          { serverPort: 15010 },
          { serverPort: 15011 },
        ];
        const results: boolean[] = await MultiWorkerTester.runMultiWorkerTest(
          caseName,
          'tcpSocketServerSetExtraOptions',
          2,
          testParams
        );
        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_TCPSocketServer_GetLocalAddress_0300
     * @tc.name ArKUIX_TCPSocketServer_GetLocalAddress_0300
     * @tc.desc Test the functionality of the getLocalAddress interface function(workers) using the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_GetLocalAddress_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_GetLocalAddress_0300';
        const testParams: WorkerTestParams[] = [
          { serverPort: 15013 },
          { serverPort: 15014 },
        ];
        const results: boolean[] = await MultiWorkerTester.runMultiWorkerTest(
          caseName,
          'tcpSocketServerGetLocalAddress',
          2,
          testParams
        );
        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_TCPSocketServer_On_Connect_0600
     * @tc.name ArKUIX_TCPSocketServer_On_Connect_0600
     * @tc.desc Test the functionality of the on interface function using the callback asynchronous callback method(workers)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_On_Connect_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_On_Connect_0600';
        const testParams: WorkerTestParams[] = [
          { serverPort: 15016, port: 15017 },
          { serverPort: 15018, port: 15019 },
        ];
        const results: boolean[] = await MultiWorkerTester.runMultiWorkerTest(
          caseName,
          'tcpSocketServerOnConnect',
          2,
          testParams
        );
        const allPassed: boolean = results.every((result: boolean) => result === true);
        expect(allPassed).assertTrue();
        console.info(`${caseName} ${allPassed ? 'All passed' : 'Existence failed'}`);
        done();
      });

    /**
     * @tc.number ArKUIX_TCPSocketServer_Off_Connect_0800
     * @tc.name ArKUIX_TCPSocketServer_Off_Connect_0800
     * @tc.desc Test the functionality of the off interface function,using the callback asynchronous callback method(workers)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 1
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Off_Connect_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL1,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Off_Connect_0800';
        const testParams: WorkerTestParams[] = [
          { serverPort: 15022, port: 15023 },
          { serverPort: 15024, port: 15025 },
        ];
        const results: boolean[] = await MultiWorkerTester.runMultiWorkerTest(
          caseName,
          'tcpSocketServerOffConnect',
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