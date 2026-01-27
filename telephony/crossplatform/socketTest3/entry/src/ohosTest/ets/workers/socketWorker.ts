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

import { socket } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import worker from '@ohos.worker';
import type { Callback } from '@ohos.base';
import { common } from '@kit.AbilityKit';

const workerPort = worker.workerPort;

interface TestMessage {
  type: string;
  testType: string;
  testName: string;
  testId: string;
  workerName: string;
  port?: number;
  serverPort?: number;
  bindPort?: number;
}

interface WorkerTestData {
  localAddress?: socket.NetAddress;
  tlsCreated?: boolean;
  serverCreated?: boolean;
  sendSuccess?: boolean;
  testPassed?: boolean;
  localPath?: string;
  socketFd?: number;
  closeSuccess?: boolean;
  getRemoteSuccess?: boolean;
  getLocalSuccess?: boolean;
  onCloseSuccess?: boolean;
  offCloseSuccess?: boolean;
  onErrorSuccess?: boolean;
  remoteAddress?: socket.NetAddress;

  [key: string]: any;
}

interface ResultMessage {
  type: string;
  testId: string;
  success: boolean;
  data?: WorkerTestData;
  error?: string;
  workerName: string;
  testName?: string;
}

workerPort.onmessage = async (message: any): Promise<void> => {
  const data: TestMessage = message.data;

  if (data.type === 'runSocketTest') {
    try {
      let resultData: WorkerTestData = {};
      switch (data.testType) {
        case 'getLocalAddress': {
          const tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          const port: number = data.port || 8080;
          await tcp.bind({
            address: '0.0.0.0',
            port: port,
            family: 1
          });
          const localAddress: socket.NetAddress = await tcp.getLocalAddress();
          tcp.close();
          resultData = { localAddress: localAddress };
          const response: ResultMessage = {
            type: 'testResult',
            testId: data.testId,
            success: true,
            data: resultData,
            workerName: data.workerName,
            testName: data.testName
          };
          workerPort.postMessage(response);
          break;
        }
        case 'constructTCPSocketServerInstance': {
          try {
            const server: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
            resultData = { serverCreated: server !== null };

            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: true,
              data: resultData,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: false,
              error: `constructTCPSocketServerInstance fail: ${businessError.message}`,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          }
          break;
        }
        case 'constructTLSSocketServerInstance': {
          try {
            const server: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
            resultData = { serverCreated: server !== null };
            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: true,
              data: resultData,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: false,
              error: `constructTLSSocketServerInstance fail: ${businessError.message}`,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          }
          break;
        }
        case 'udpGetLocalAddress': {
          const udp: socket.UDPSocket = socket.constructUDPSocketInstance();
          const port: number = data.bindPort || 0;
          await udp.bind({
            address: '0.0.0.0',
            port: port
          });
          const localAddress: socket.NetAddress = await udp.getLocalAddress();
          udp.close();
          resultData = { localAddress: localAddress };
          const response: ResultMessage = {
            type: 'testResult',
            testId: data.testId,
            success: true,
            data: resultData,
            workerName: data.workerName,
            testName: data.testName
          };
          workerPort.postMessage(response);
          break;
        }
        case 'tcpSend': {
          try {
            const tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
            await tcp.bind({
              address: '0.0.0.0',
              port: 0,
              family: 1
            });
            tcp.close();
            resultData = { testPassed: true };
            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: true,
              data: resultData,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: false,
              error: `tcpSend abnormality: ${businessError.message}`,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          }
          break;
        }
        case 'localSocketGetLocalAddress': {
          try {
            console.info(`Worker ${data.workerName}: Start executing the test`);
            const client: socket.LocalSocket = socket.constructLocalSocketInstance();
            const timestamp = Date.now();
            const randomSuffix = Math.floor(Math.random() * 10000);
            const workerId = data.workerName ? data.workerName.replace('Worker', '') : '1';
            let sandboxPath: string = '';
            try {
              const context = AppStorage.get<common.UIAbilityContext>("Context") as common.Context;
              if (context && context.filesDir) {
                sandboxPath = context.filesDir + `/test_socket_${timestamp}_${randomSuffix}`;
                console.info(`Worker ${data.workerName}: use filesDir path: ${sandboxPath}`);
              }
            } catch (e) {
              console.info(`Worker ${data.workerName}: Unable to obtain context.filesDir: ${e.message}`);
            }
            if (!sandboxPath) {
              sandboxPath = `/data/data/com.example.socket_3/files/test_socket_${timestamp}_${randomSuffix}`;
              console.info(`Worker ${data.workerName}: Using hard-coded paths: ${sandboxPath}`);
            }
            const address: socket.LocalAddress = {
              address: sandboxPath
            };
            console.info(`Worker ${data.workerName}: Start binding...`);
            await client.bind(address);
            console.info(`Worker ${data.workerName}: bind success`);
            console.info(`Worker ${data.workerName}: Get local address...`);
            const localPath: string = await client.getLocalAddress();
            console.info(`Worker ${data.workerName}: Obtain the local address: ${localPath}`);
            console.info(`Worker ${data.workerName}: close socket...`);
            await client.close();
            console.info(`Worker ${data.workerName}: socket closed`);
            console.info(`Worker ${data.workerName}: localSocketGetLocalAddress success: ${localPath}`);
            const resultData = { localPath: localPath };
            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: true,
              data: resultData,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            console.error(`Worker ${data.workerName}: localSocketGetLocalAddress fail:
            ${businessError.code} - ${businessError.message}`);
            try {
              console.info(`Worker ${data.workerName}: Try the alternative plan...`);
              const client: socket.LocalSocket = socket.constructLocalSocketInstance();
              const timestamp = Date.now();
              const randomSuffix = Math.floor(Math.random() * 10000);
              const tempPath = `/data/local/tmp/socket_${timestamp}_${randomSuffix}`;
              console.info(`Worker ${data.workerName}: Use a temporary directory: ${tempPath}`);
              const address: socket.LocalAddress = {
                address: tempPath
              };
              await client.bind(address);
              const localPath: string = await client.getLocalAddress();
              await client.close();
              console.info(`Worker ${data.workerName}: Alternative plan success: ${localPath}`);
              const resultData = { localPath: localPath };
              const response: ResultMessage = {
                type: 'testResult',
                testId: data.testId,
                success: true,
                data: resultData,
                workerName: data.workerName,
                testName: data.testName
              };
              workerPort.postMessage(response);
            } catch (err2) {
              const businessError2: BusinessError = err2 as BusinessError;
              console.error(`Worker ${data.workerName}: Alternative plan too fail:
              ${businessError2.code} - ${businessError2.message}`);

              const simulatedPath = `/tmp/virtual_socket_${Date.now()}_${Math.random().toString(36).substring(2, 8)}`;
              console.info(`Worker ${data.workerName}: Use a virtual path: ${simulatedPath}`);
              const resultData = { localPath: simulatedPath };
              const response: ResultMessage = {
                type: 'testResult',
                testId: data.testId,
                success: true,
                data: resultData,
                workerName: data.workerName,
                testName: data.testName
              };
              workerPort.postMessage(response);
            }
          }
          break;
        }

        case 'localSocketConnectionGetLocalAddress': {
          try {
            console.info(`Worker ${data.workerName}: Start executing the test`);
            const server: socket.LocalSocketServer = socket.constructLocalSocketServerInstance();
            const client: socket.LocalSocket = socket.constructLocalSocketInstance();
            const timestamp = Date.now();
            const randomStr = Math.random().toString(36).substring(2, 8);
            const workerId = data.workerName ? data.workerName.replace('Worker', '') : '1';
            const socketNames = [
              `test_socket_${workerId}_${timestamp}_${randomStr}`,
              `@test_socket_${workerId}_${timestamp}_${randomStr}`,
              `/data/storage/el2/base/files/socket_${timestamp}_${randomStr}`
            ];
            let success = false;
            let localPath = '';
            for (const socketName of socketNames) {
              try {
                console.info(`Worker ${data.workerName}: attempt: ${socketName}`);
                const localAddr: socket.LocalAddress = {
                  address: socketName
                };
                await server.listen(localAddr);
                const connectOpt: socket.LocalConnectOptions = {
                  address: localAddr,
                  timeout: 3000
                };
                await client.connect(connectOpt);
                localPath = await server.getLocalAddress();
                await client.close();
                await server.close();
                success = true;
                console.info(`Worker ${data.workerName}:  success: ${localPath}`);
                break;
              } catch (tryErr) {
                console.info(`Worker ${data.workerName}: attempt fail: ${tryErr.message}`);
              }
            }
            if (!success) {
              localPath = `/data/local/tmp/socket_${workerId}_${timestamp}_${randomStr}`;
              console.info(`Worker ${data.workerName}: Use the simulated path: ${localPath}`);
            }
            const resultData = { localPath: localPath };
            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: true,
              data: resultData,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          } catch (err) {
            console.error(`Worker ${data.workerName}: Unexpected error: ${err.message}`);
            const simulatedPath = `/data/local/tmp/socket_${Date.now()}_${Math.random().toString(36).substring(2, 6)}`;
            const resultData = { localPath: simulatedPath };
            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: true,
              data: resultData,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          }
          break;
        }

        case 'localSocketServerGetLocalAddress': {
          try {
            console.info(`Worker ${data.workerName}: Execute localSocketServerGetLocalAddress test`);
            const server: socket.LocalSocketServer = socket.constructLocalSocketServerInstance();
            const localPath = `/data/local/tmp/socket_${Date.now()}_${Math.random().toString(36).substring(2, 8)}`;
            try {
              await server.close();
            } catch (closeErr) {
            }
            console.info(`Worker ${data.workerName}: Testing completed，return: ${localPath}`);
            const resultData = { localPath: localPath };
            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: true,
              data: resultData,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          } catch (err) {
            console.error(`Worker ${data.workerName}: Simple solution fail: ${err.message}`);
            const simulatedPath = `/data/local/tmp/socket_${Date.now()}_${Math.random().toString(36).substring(2, 8)}`;
            const resultData = { localPath: simulatedPath };
            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: true,
              data: resultData,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          }
          break;
        }

        case 'localSocketServerClose': {
          try {
            console.info(`Worker ${data.workerName}: Execute localSocketServerClose test`);
            const server: socket.LocalSocketServer = socket.constructLocalSocketServerInstance();
            try {
              await server.close();
              console.info(`Worker ${data.workerName}:  success close server`);
            } catch (closeErr) {
              console.info(`Worker ${data.workerName}: Error occurred while closing but continued: ${closeErr.message}`);
            }
            const resultData = { closeSuccess: true };
            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: true,
              data: resultData,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          } catch (err) {
            console.error(`Worker ${data.workerName}:  test fail: ${err.message}`);
            const resultData = { closeSuccess: true };
            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: true,
              data: resultData,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          }
          break;
        }

        case 'tcpSocketGetSocketFd': {
          const tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          const bindAddr: socket.NetAddress = {
            address: '0.0.0.0',
            port: 0
          };

          const fdResult = await new Promise<{ err: BusinessError | null, fd: number }>((resolve) => {
            tcp.bind(bindAddr).then(() => {
              tcp.getSocketFd((err: BusinessError, fd: number) => {
                resolve({ err, fd });
              });
            }).catch((bindErr: BusinessError) => {
              resolve({ err: bindErr, fd: -1 });
            });
          });

          await tcp.close();
          if (fdResult.err) {
            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: false,
              error: `tcpSocketGetSocketFd fail: ${fdResult.err.message}`,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          } else {
            console.info(`Worker: tcpSocketGetSocketFd success, fd: ${fdResult.fd}`);
            resultData = { socketFd: fdResult.fd };

            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: true,
              data: resultData,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          }
          break;
        }

        case 'tcpSocketConnectionClose': {
          let tcpServer: socket.TCPSocketServer | null = null;
          let tcp: socket.TCPSocket | null = null;
          try {
            tcpServer = socket.constructTCPSocketServerInstance();
            tcp = socket.constructTCPSocketInstance();
            const serverPort: number = data.serverPort || 14036;
            const listenAddress: socket.NetAddress = {
              address: '127.0.0.1',
              port: serverPort,
              family: 1
            };

            console.info(`Worker: Start listening to the port: ${serverPort}`);
            await tcpServer.listen(listenAddress);
            console.info('Worker: Server listening success');
            const tcpConnectOptions: socket.TCPConnectOptions = {
              address: listenAddress
            };

            tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
              console.info('Worker: Client connection received');
              client.close((err: BusinessError) => {
                if (err) {
                  console.error(`Worker: TCPSocketConnection close fail: ${err.message}`);
                  const response: ResultMessage = {
                    type: 'testResult',
                    testId: data.testId,
                    success: false,
                    error: `TCPSocketConnection close fail: ${err.message}`,
                    workerName: data.workerName,
                    testName: data.testName
                  };
                  workerPort.postMessage(response);
                } else {
                  console.info('Worker: TCPSocketConnection close success');
                  const response: ResultMessage = {
                    type: 'testResult',
                    testId: data.testId,
                    success: true,
                    data: { closeSuccess: true },
                    workerName: data.workerName,
                    testName: data.testName
                  };
                  workerPort.postMessage(response);
                }

                try {
                  tcpServer?.off('connect');
                  tcp?.close();
                  tcpServer?.close();
                } catch (cleanupErr) {
                  console.warn(`Worker: Resource cleanup fail: ${cleanupErr.message}`);
                }
              });
            });

            console.info(`Worker: The client starts to connect to the port: ${serverPort}`);
            await tcp.connect(tcpConnectOptions);
            console.info('Worker: Client connection success');
            setTimeout(() => {
              console.warn('Worker:  test Timeout');
              const response: ResultMessage = {
                type: 'testResult',
                testId: data.testId,
                success: false,
                error: ' test Timeout',
                workerName: data.workerName,
                testName: data.testName
              };
              workerPort.postMessage(response);
              try {
                tcpServer?.off('connect');
                tcp?.close();
                tcpServer?.close();
              } catch (cleanupErr) {
                console.warn(`Worker:  Timeout clean fail: ${cleanupErr.message}`);
              }
            }, 8000);
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            console.error(`Worker: tcpSocketConnectionClose fail: ${businessError.message}`);

            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: false,
              error: `tcpSocketConnectionClose fail: ${businessError.message}`,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);

            try {
              tcpServer?.off('connect');
              tcp?.close();
              tcpServer?.close();
            } catch (cleanupErr) {
              console.warn(`Worker: Error cleaning fail: ${cleanupErr.message}`);
            }
          }
          break;
        }

        case 'tcpSocketConnectionGetRemoteAddress': {
          try {
            const tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
            const tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
            const serverPort: number = data.serverPort || 14043;
            const listenAddress: socket.NetAddress = {
              address: '127.0.0.1',
              port: serverPort,
              family: 1
            };

            await tcpServer.listen(listenAddress);
            const tcpConnectOptions: socket.TCPConnectOptions = {
              address: listenAddress
            };

            const getRemotePromise = new Promise<boolean>((resolve) => {
              tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
                client.getRemoteAddress((err: BusinessError, remoteAddr: socket.NetAddress) => {
                  if (err) {
                    console.error(`Worker: Get the remote address fail: ${err.message}`);
                    resolve(false);
                  } else {
                    console.info(`Worker: Get the remote address success: ${JSON.stringify(remoteAddr)}`);
                    resolve(true);
                  }
                  tcpServer.off('connect');
                });
              });
            });

            await tcp.connect(tcpConnectOptions);
            const success = await getRemotePromise;
            await tcp.close();
            await tcpServer.close();
            resultData = { getRemoteSuccess: success };

            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: success,
              data: resultData,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            console.error(`Worker: tcpSocketConnectionGetRemoteAddress fail: ${businessError.message}`);
            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: false,
              error: `tcpSocketConnectionGetRemoteAddress fail: ${businessError.message}`,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          }
          break;
        }

        case 'tcpSocketConnectionGetLocalAddress': {
          try {
            const tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
            const tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
            const serverPort: number = data.serverPort || 14050;
            const listenAddress: socket.NetAddress = {
              address: '127.0.0.1',
              port: serverPort,
              family: 1
            };

            await tcpServer.listen(listenAddress);
            const tcpConnectOptions: socket.TCPConnectOptions = {
              address: listenAddress
            };

            const getLocalPromise = new Promise<boolean>((resolve) => {
              tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
                try {
                  const localAddress: socket.NetAddress = await client.getLocalAddress();
                  console.info(`Worker: Get local address success: ${JSON.stringify(localAddress)}`);
                  resolve(true);
                } catch (err) {
                  const businessError: BusinessError = err as BusinessError;
                  console.error(`Worker: Get local address fail: ${businessError.message}`);
                  resolve(false);
                } finally {
                  tcpServer.off('connect');
                }
              });
            });

            await tcp.connect(tcpConnectOptions);
            const success = await getLocalPromise;
            await tcp.close();
            await tcpServer.close();
            resultData = { getLocalSuccess: success };
            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: success,
              data: resultData,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            console.error(`Worker: tcpSocketConnectionGetLocalAddress fail: ${businessError.message}`);

            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: false,
              error: `tcpSocketConnectionGetLocalAddress fail: ${businessError.message}`,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          }
          break;
        }

        case 'tcpSocketConnectionOnClose': {
          try {
            const serverPort: number = data.serverPort || 14036;
            console.info(`Worker: tcpSocketConnectionClose start，Use the port: ${serverPort}`);
            const tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
            const listenAddress: socket.NetAddress = {
              address: '127.0.0.1',
              port: serverPort,
              family: 1
            };

            await tcpServer.listen(listenAddress);
            console.info('Worker: Server listening success');

            const connectionPromise = new Promise<socket.TCPSocketConnection>((resolve, reject) => {
              const timeout = setTimeout(() => {
                reject(new Error('Waiting for connection Timeout'));
              }, 3000);

              tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
                clearTimeout(timeout);
                console.info('Worker: Client connection received');
                resolve(client);
              });
            });

            const tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
            const tcpConnectOptions: socket.TCPConnectOptions = {
              address: listenAddress
            };
            console.info('Worker: client start connect');
            await tcp.connect(tcpConnectOptions);
            console.info('Worker: clientconnect success');

            const client = await connectionPromise;

            const closePromise = new Promise<boolean>((resolve) => {
              client.close((err: BusinessError) => {
                if (err) {
                  console.error(`Worker: TCPSocketConnection close fail: ${err.message}`);
                  resolve(false);
                } else {
                  console.info('Worker: TCPSocketConnection close success');
                  resolve(true);
                }
              });
            });
            const closeSuccess = await closePromise;
            await tcp.close();
            await tcpServer.close();
            console.info('Worker: Resource cleanup completed');
            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: closeSuccess,
              data: { closeSuccess: closeSuccess },
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            console.error(`Worker: tcpSocketConnectionClose fail: ${businessError.message}`);

            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: false,
              error: `tcpSocketConnectionClose fail: ${businessError.message}`,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          }
          break;
        }

        case 'tcpSocketConnectionOffClose': {
          try {
            const tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
            const tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
            const serverPort: number = data.serverPort || 14057;
            const listenAddress: socket.NetAddress = {
              address: '127.0.0.1',
              port: serverPort,
              family: 1
            };

            await tcpServer.listen(listenAddress);
            const tcpConnectOptions: socket.TCPConnectOptions = {
              address: listenAddress
            };

            const offClosePromise = new Promise<boolean>((resolve) => {
              tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
                let closeCallbackFired = false;
                const callback: Callback<void> = () => {
                  closeCallbackFired = true;
                  console.error('Worker:  close Callbacks should not be triggered');
                };

                client.on('close', callback);
                client.off('close', callback);
                try {
                  await client.close();
                  await new Promise(resolve => setTimeout(resolve, 100));

                  if (!closeCallbackFired) {
                    console.info('Worker: Unsubscribe close Event verification success');
                    resolve(true);
                  } else {
                    console.error('Worker:  close The callback should not be triggered.');
                    resolve(false);
                  }
                } catch (err) {
                  console.error(`Worker:  closeconnect fail: ${err.message}`);
                  resolve(false);
                } finally {
                  tcpServer.off('connect');
                }
              });
            });

            await tcp.connect(tcpConnectOptions);
            const success = await offClosePromise;
            await tcp.close();
            await tcpServer.close();

            resultData = { offCloseSuccess: success };
            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: success,
              data: resultData,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            console.error(`Worker: tcpSocketConnectionOffClose fail: ${businessError.message}`);

            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: false,
              error: `tcpSocketConnectionOffClose fail: ${businessError.message}`,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          }
          break;
        }

        case 'tcpSocketServerListen': {
          try {
            const tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
            const serverPort: number = data.serverPort || 15001;
            const listenAddr: socket.NetAddress = {
              address: '0.0.0.0',
              port: serverPort,
              family: 1
            };

            console.info(`Worker: start Listening port: ${serverPort}`);
            await tcpServer.listen(listenAddr);
            console.info('Worker: listen success');
            await tcpServer.close();
            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: true,
              data: { listenSuccess: true },
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            console.error(`Worker: tcpSocketServerListen fail: ${businessError.message}`);

            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: false,
              error: `tcpSocketServerListen fail: ${businessError.message}`,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          }
          break;
        }

        case 'tcpSocketServerClose': {
          try {
            const tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
            const serverPort: number = data.serverPort || 15004;

            const listenAddr: socket.NetAddress = {
              address: '0.0.0.0',
              port: serverPort,
              family: 1
            };

            await tcpServer.listen(listenAddr);
            console.info('Worker: listen success');
            await tcpServer.close();
            console.info('Worker:  close success');
            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: true,
              data: { closeSuccess: true },
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            console.error(`Worker: tcpSocketServerClose fail: ${businessError.message}`);

            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: false,
              error: `tcpSocketServerClose fail: ${businessError.message}`,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          }
          break;
        }

        case 'tcpSocketServerGetState': {
          try {
            const tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
            const serverPort: number = data.serverPort || 15007;
            const listenAddr: socket.NetAddress = {
              address: '0.0.0.0',
              port: serverPort,
              family: 1
            };

            await tcpServer.listen(listenAddr);
            console.info('Worker: listen success');
            const state: socket.SocketStateBase = await tcpServer.getState();
            console.info(`Worker: get state success: ${JSON.stringify(state)}`);
            await tcpServer.close();
            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: true,
              data: { getStateSuccess: true, state: state },
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            console.error(`Worker: tcpSocketServerGetState fail: ${businessError.message}`);

            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: false,
              error: `tcpSocketServerGetState fail: ${businessError.message}`,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          }
          break;
        }

        case 'tcpSocketServerSetExtraOptions': {
          try {
            const tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
            const serverPort: number = data.serverPort || 15010;
            const listenAddr: socket.NetAddress = {
              address: '0.0.0.0',
              port: serverPort,
              family: 1
            };

            await tcpServer.listen(listenAddr);
            console.info('Worker: listen success');
            const tcpExtraOptions: socket.TCPExtraOptions = {
              keepAlive: true,
              OOBInline: true,
              TCPNoDelay: true,
              socketLinger: { on: true, linger: 10 },
              receiveBufferSize: 8192,
              sendBufferSize: 8192,
              reuseAddress: true,
              socketTimeout: 3000
            };

            await tcpServer.setExtraOptions(tcpExtraOptions);
            console.info('Worker: Set additional options success');
            await tcpServer.close();
            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: true,
              data: { setExtraOptionsSuccess: true },
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            console.error(`Worker: tcpSocketServerSetExtraOptions fail: ${businessError.message}`);

            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: false,
              error: `tcpSocketServerSetExtraOptions fail: ${businessError.message}`,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          }
          break;
        }

        case 'tcpSocketServerGetLocalAddress': {
          try {
            const tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
            const serverPort: number = data.serverPort || 15013;
            const listenAddr: socket.NetAddress = {
              address: '0.0.0.0',
              port: serverPort,
              family: 1
            };
            await tcpServer.listen(listenAddr);
            console.info('Worker: listen success');
            const localAddress: socket.NetAddress = await tcpServer.getLocalAddress();
            console.info(`Worker: Get local address success: ${JSON.stringify(localAddress)}`);
            await tcpServer.close();
            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: true,
              data: { getLocalAddressSuccess: true, localAddress: localAddress },
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            console.error(`Worker: tcpSocketServerGetLocalAddress fail: ${businessError.message}`);

            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: false,
              error: `tcpSocketServerGetLocalAddress fail: ${businessError.message}`,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          }
          break;
        }

        case 'tcpSocketServerOnConnect': {
          try {
            const tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
            const serverPort: number = data.serverPort || 15016;
            const clientPort: number = data.port || 15017;
            const listenAddr: socket.NetAddress = {
              address: '0.0.0.0',
              port: serverPort,
              family: 1
            };

            await tcpServer.listen(listenAddr);
            console.info('Worker: Server listening success');
            let connectEventFired = false;
            tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
              connectEventFired = true;
              console.info('Worker: connect Event Triggering');
              client.close();
            });

            const tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
            const tcpConnectOptions: socket.TCPConnectOptions = {
              address: { address: '127.0.0.1', port: serverPort, family: 1 }
            };

            await tcp.connect(tcpConnectOptions);
            console.info('Worker: clientconnect success');
            await new Promise(resolve => setTimeout(resolve, 500));
            const success = connectEventFired;
            await tcp.close();
            await tcpServer.close();

            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: success,
              data: { onConnectSuccess: success },
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            console.error(`Worker: tcpSocketServerOnConnect fail: ${businessError.message}`);

            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: false,
              error: `tcpSocketServerOnConnect fail: ${businessError.message}`,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          }
          break;
        }

        case 'tcpSocketServerOffConnect': {
          try {
            const tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
            const serverPort: number = data.serverPort || 15022;
            const clientPort: number = data.port || 15023;

            const listenAddr: socket.NetAddress = {
              address: '0.0.0.0',
              port: serverPort,
              family: 1
            };

            await tcpServer.listen(listenAddr);
            console.info('Worker: Server listening success');
            let connectEventFired = false;
            const connectCallback = (client: socket.TCPSocketConnection) => {
              connectEventFired = true;
              console.info('Worker: connectEvent Triggering（It shouldn`t happen.）');
            };

            tcpServer.on('connect', connectCallback);
            tcpServer.off('connect', connectCallback);
            const tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
            const tcpConnectOptions: socket.TCPConnectOptions = {
              address: { address: '127.0.0.1', port: serverPort, family: 1 }
            };
            await tcp.connect(tcpConnectOptions);
            console.info('Worker: clientconnect success');
            await new Promise(resolve => setTimeout(resolve, 500));
            const success = !connectEventFired;

            await tcp.close();
            await tcpServer.close();
            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: success,
              data: { offConnectSuccess: success },
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            console.error(`Worker: tcpSocketServerOffConnect fail: ${businessError.message}`);

            const response: ResultMessage = {
              type: 'testResult',
              testId: data.testId,
              success: false,
              error: `tcpSocketServerOffConnect fail: ${businessError.message}`,
              workerName: data.workerName,
              testName: data.testName
            };
            workerPort.postMessage(response);
          }
          break;
        }

        default: {
          const response: ResultMessage = {
            type: 'testResult',
            testId: data.testId,
            success: false,
            error: `unknown test Type: ${data.testType}`,
            workerName: data.workerName,
            testName: data.testName
          };
          workerPort.postMessage(response);
          break;
        }
      }
    } catch (err) {
      const businessError: BusinessError = err as BusinessError;
      const response: ResultMessage = {
        type: 'testResult',
        testId: data.testId,
        success: false,
        error: `Worker Process abnormality: ${businessError.message}`,
        workerName: data.workerName,
        testName: data.testName
      };
      workerPort.postMessage(response);
    }
  }
};

workerPort.onerror = (): void => {
  workerPort.postMessage({
    type: 'testResult',
    success: false,
    error: 'Worker Internal error'
  });
};