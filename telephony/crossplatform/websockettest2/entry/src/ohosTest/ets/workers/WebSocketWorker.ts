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

import webSocket from '@ohos.net.webSocket';
import { BusinessError } from '@kit.BasicServicesKit';
import worker from '@ohos.worker';

const workerPort = worker.workerPort;

interface TestMessage {
  type: string;
  testType: string;
  testName: string;
  testId: string;
  workerName: string;
  port?: number;
  clientPort?: number;
  serverPort?: number;
  serverIP?: string;
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

interface ResultMessage {
  type: string;
  testId: string;
  success: boolean;
  data?: WorkerTestData;
  error?: string;
  workerName: string;
  testName?: string;
}

function sleep(time: number): Promise<string> {
  return new Promise<string>((resolve) => {
    setTimeout(() => {
      resolve('ok');
    }, time);
  });
}

workerPort.onmessage = async (message: any): Promise<void> => {
  const data: TestMessage = message.data;

  if (data.type === 'runWebSocketTest') {
    try {
      let resultData: WorkerTestData = {};
      let success = false;
      let errorMsg = '';

      switch (data.testType) {
        case 'createWebSocketServer': {
          try {
            const server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
            resultData = { serverCreated: server !== null };
            success = true;
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            errorMsg = `createWebSocketServer fail: ${businessError.message}`;
          }
          break;
        }

        case 'webSocketServerStart': {
          try {
            const server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
            const port = data.port || 8088;
            const serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: data.serverIP || "0.0.0.0",
              serverPort: port,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            };

            const startResult = await server.start(serverConfig);
            resultData = { startSuccess: startResult };
            success = startResult;

            if (success) {
              await server.stop();
            } else {
              errorMsg = 'WebSocket start fail';
            }
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            errorMsg = `webSocketServerStart fail: ${businessError.message}`;
          }
          break;
        }

        case 'webSocketServerStop': {
          try {
            const server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
            const port = data.port || 8089;
            const serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: data.serverIP || "0.0.0.0",
              serverPort: port,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            };

            const startResult = await server.start(serverConfig);
            if (!startResult) {
              errorMsg = 'WebSocketServer start fail';
              break;
            }

            const stopResult = await server.stop();
            resultData = { stopSuccess: stopResult };
            success = stopResult;

            if (!success) {
              errorMsg = 'WebSocketServer stop fail';
            }
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            errorMsg = `webSocketServer Stop fail : ${businessError.message}`;
          }
          break;
        }

        case 'webSocketServerListAllConnections': {
          try {
            const server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
            const port = data.port || 8090;
            const serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: data.serverIP || "0.0.0.0",
              serverPort: port,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            };

            const startResult = await server.start(serverConfig);
            if (!startResult) {
              errorMsg = 'WebSocketServer start fail';
              break;
            }


            let connectionPromise = new Promise<webSocket.WebSocketConnection>((resolve) => {
              const callback = (connection: webSocket.WebSocketConnection) => {
                server.off('connect', callback);
                resolve(connection);
              };
              server.on('connect', callback);
            });

            const client: webSocket.WebSocket = webSocket.createWebSocket();
            const connectPromise = new Promise<boolean>((resolve) => {
              client.connect(`ws://127.0.0.1:${port}`, (err: BusinessError, value: boolean) => {
                resolve(value);
              });
            });

            await Promise.all([connectionPromise, connectPromise]);
            await sleep(500);

            const connections = await server.listAllConnections();
            resultData = {
              connections: connections,
              listSuccess: connections !== undefined
            };
            success = connections !== undefined && connections.length > 0;

            if (connections && connections.length > 0) {
              await server.close(connections[0]);
            }
            await server.stop();

            if (!success) {
              errorMsg = 'Failed to get the connection list';
            }
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            errorMsg = `listAllConnections fail: ${businessError.message}`;
          }
          break;
        }

        case 'webSocketServerSend': {
          try {
            const server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
            const port = data.port || 8091;
            const serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: data.serverIP || "0.0.0.0",
              serverPort: port,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            };

            const startResult = await server.start(serverConfig);
            if (!startResult) {
              errorMsg = 'WebSocketServer start fail';
              break;
            }

            let connection: webSocket.WebSocketConnection | null = null;
            const connectionPromise = new Promise<webSocket.WebSocketConnection>((resolve) => {
              const callback = (conn: webSocket.WebSocketConnection) => {
                server.off('connect', callback);
                connection = conn;
                resolve(conn);
              };
              server.on('connect', callback);
            });

            const client: webSocket.WebSocket = webSocket.createWebSocket();
            let messageReceived = false;
            client.on('message', (err: BusinessError, value: string | ArrayBuffer) => {
              if (!err && value === "hello client") {
                messageReceived = true;
              }
            });

            const connectPromise = new Promise<boolean>((resolve) => {
              client.connect(`ws://127.0.0.1:${port}`, (err: BusinessError, value: boolean) => {
                resolve(value);
              });
            });

            await Promise.all([connectionPromise, connectPromise]);
            await sleep(500);

            if (connection) {
              const sendResult = await server.send("hello client", connection);
              resultData = { sendSuccess: sendResult };

              await sleep(500);
              success = sendResult && messageReceived;
            } else {
              errorMsg = 'Connection failed';
            }

            if (connection) {
              await server.close(connection);
            }
            await server.stop();

            if (!success && !errorMsg) {
              errorMsg = 'send message fail';
            }
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            errorMsg = `send fail: ${businessError.message}`;
          }
          break;
        }

        case 'webSocketServerClose': {
          try {
            const server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
            const port = data.port || 8092;
            const serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: data.serverIP || "0.0.0.0",
              serverPort: port,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            };

            const startResult = await server.start(serverConfig);
            if (!startResult) {
              errorMsg = 'WebSocketServer start fail';
              break;
            }

            let connection: webSocket.WebSocketConnection | null = null;
            let connectCallback: any = null;
            const connectionPromise = new Promise<webSocket.WebSocketConnection>((resolve) => {
              connectCallback = (conn: webSocket.WebSocketConnection) => {
                if (connection) {
                  return;
                }
                connection = conn;
                resolve(conn);
              };
              server.on('connect', connectCallback);
            });

            await sleep(3000);

            const client: webSocket.WebSocket = webSocket.createWebSocket();
            let closed = true;
            let clientConnected = false;

            client.on('open', () => {
              clientConnected = true;
            });

            client.on('close', (err: BusinessError) => {
              closed = !err;
            });

            client.on('error', () => {
              closed = false;
            });

            await new Promise<void>((resolve) => {
              const connectTimer = setTimeout(() => resolve(), 15000);
              client.connect(`ws://127.0.0.1:${port}`, (err: BusinessError) => {
                clearTimeout(connectTimer);
                clientConnected = !err;
                resolve();
              });
            });

            if (!clientConnected) {
              errorMsg = 'Client connection timed out';
              break;
            }

            await Promise.race([connectionPromise, sleep(10000)]);
            await sleep(2000);

            let closeResult = false;
            if (connection) {
              try {
                closeResult = await server.close(connection);
                await sleep(3000);
              } catch (err) {
              }
              resultData = { closeSuccess: closeResult };
            } else {
              errorMsg = 'Client connection not captured';
            }

            success = closeResult && closed && clientConnected;

            try {
              if (connection) {
                server.off('connect', connectCallback);
              }
            } catch (err) {
            }

            try {
              client.close();
            } catch (err) {
            }

            await sleep(1000);
            try {
              await server.stop();
            } catch (err) {
            }

            if (!success && !errorMsg) {
              errorMsg = 'close connect fail';
            }
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            errorMsg = `close fail: ${businessError?.message || String(err)}`;
          }

          const workerGlobal = globalThis as unknown as {
            postMessage: (msg: any) => void;
          };
          if (workerGlobal && typeof workerGlobal.postMessage === 'function') {
            workerGlobal.postMessage({
              type: 'testResult',
              testId: data?.testId || '',
              workerName: data?.workerName || '',
              success: success || false,
              error: errorMsg || '',
              data: resultData || {}
            });
          }
          break;
        }

        case 'webSocketServerOnConnect': {
          try {
            const server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
            const port = data.port || 8088;
            const serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: data.serverIP || "0.0.0.0",
              serverPort: port,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            };

            const startResult = await server.start(serverConfig);
            if (!startResult) {
              errorMsg = 'WebSocketServer start fail';
              break;
            }

            let connectionReceived = false;
            const connectionPromise = new Promise<boolean>((resolve) => {
              const callback = (connection: webSocket.WebSocketConnection) => {
                console.info(`${data.workerName}  received connect: ${JSON.stringify(connection)}`);
                connectionReceived = true;
                resolve(true);
              };
              server.on('connect', callback);
            });

            const client: webSocket.WebSocket = webSocket.createWebSocket();
            const connectPromise = new Promise<boolean>((resolve) => {
              client.connect(`ws://127.0.0.1:${port}`, (err: BusinessError, value: boolean) => {
                resolve(!err && value);
              });
            });

            await Promise.all([connectionPromise, connectPromise]);
            await sleep(500);

            resultData = { testPassed: connectionReceived };
            success = connectionReceived;

            await server.stop();

            if (!success) {
              errorMsg = 'Connect event listening fail';
            }
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            errorMsg = `webSocketServerOnConnect fail: ${businessError.message}`;
          }
          break;
        }

        case 'webSocketServerOffConnectSpecific': {
          try {
            const server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
            const port = data.port || 8088;
            const serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: data.serverIP || "0.0.0.0",
              serverPort: port,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            };

            const startResult = await server.start(serverConfig);
            if (!startResult) {
              errorMsg = 'WebSocketServer start fail';
              break;
            }

            let connectionReceived = false;
            const callback = (connection: webSocket.WebSocketConnection) => {
              console.info(`${data.workerName} should not received connect: ${JSON.stringify(connection)}`);
              connectionReceived = true;
            };
            server.on('connect', callback);
            server.off('connect', callback);

            const client: webSocket.WebSocket = webSocket.createWebSocket();
            const connectPromise = new Promise<boolean>((resolve) => {
              client.connect(`ws://127.0.0.1:${port}`, (err: BusinessError, value: boolean) => {
                resolve(!err && value);
              });
            });

            await Promise.all([connectPromise]);
            await sleep(500);

            resultData = { testPassed: !connectionReceived };
            success = !connectionReceived;

            await server.stop();

            if (!success) {
              errorMsg = 'Unsubscribe from the specified callback fail';
            }
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            errorMsg = `webSocketServerOffConnectSpecific fail: ${businessError.message}`;
          }
          break;
        }

        case 'webSocketServerOffConnectAll': {
          try {
            const server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
            const port = data.port || 8088;
            const serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: data.serverIP || "0.0.0.0",
              serverPort: port,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            };

            const startResult = await server.start(serverConfig);
            if (!startResult) {
              errorMsg = 'WebSocketServer start fail';
              break;
            }

            let connectionReceived = false;
            const callback1 = (connection: webSocket.WebSocketConnection) => {
              connectionReceived = true;
            };
            const callback2 = (connection: webSocket.WebSocketConnection) => {
              connectionReceived = true;
            };
            server.on('connect', callback1);
            server.on('connect', callback2);
            server.off('connect');

            const client: webSocket.WebSocket = webSocket.createWebSocket();
            const connectPromise = new Promise<boolean>((resolve) => {
              client.connect(`ws://127.0.0.1:${port}`, (err: BusinessError, value: boolean) => {
                resolve(!err && value);
              });
            });

            await Promise.all([connectPromise]);
            await sleep(500);

            resultData = { testPassed: !connectionReceived };
            success = !connectionReceived;

            await server.stop();

            if (!success) {
              errorMsg = 'Unsubscribe from all callbacks fail';
            }
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            errorMsg = `webSocketServerOffConnectAll fail: ${businessError.message}`;
          }
          break;
        }

        case 'webSocketServerOnMessage': {
          try {
            const server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
            const port = data.port || 8088;
            const serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: data.serverIP || "0.0.0.0",
              serverPort: port,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            };

            const startResult = await server.start(serverConfig);
            if (!startResult) {
              errorMsg = 'WebSocketServer start fail';
              break;
            }

            let messageReceived = false;
            let receivedData = '';
            const messagePromise = new Promise<boolean>((resolve) => {
              const callback = (message: webSocket.WebSocketMessage) => {
                console.info(`${data.workerName} received message: ${message.data}`);
                messageReceived = true;
                receivedData = message.data as string;
                resolve(true);
              };
              server.on('messageReceive', callback);
            });

            const connectionPromise = new Promise<webSocket.WebSocketConnection>((resolve) => {
              const connectCallback = (connection: webSocket.WebSocketConnection) => {
                server.off('connect', connectCallback);
                resolve(connection);
              };
              server.on('connect', connectCallback);
            });

            const client: webSocket.WebSocket = webSocket.createWebSocket();
            const connectPromise = new Promise<boolean>((resolve) => {
              client.connect(`ws://127.0.0.1:${port}`, (err: BusinessError, value: boolean) => {
                resolve(!err && value);
              });
            });

            await Promise.all([connectionPromise, connectPromise]);
            await sleep(500);

            const sendPromise = new Promise<boolean>((resolve) => {
              client.send("hello server", (err: BusinessError, value: boolean) => {
                resolve(!err && value);
              });
            });

            await Promise.all([messagePromise, sendPromise]);
            await sleep(500);

            resultData = { testPassed: messageReceived && receivedData === "hello server" };
            success = messageReceived && receivedData === "hello server";

            await server.stop();

            if (!success) {
              errorMsg = 'Message event listening fail';
            }
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            errorMsg = `webSocketServerOnMessage fail: ${businessError.message}`;
          }
          break;
        }

        case 'webSocketServerOffMessageSpecific': {
          try {
            const server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
            const port = data.port || 8088;
            const serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: data.serverIP || "0.0.0.0",
              serverPort: port,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            };

            const startResult = await server.start(serverConfig);
            if (!startResult) {
              errorMsg = 'WebSocketServer start fail';
              break;
            }

            let messageReceived = false;
            const callback = (message: webSocket.WebSocketMessage) => {
              console.info(`${data.workerName} should not received: ${message.data}`);
              messageReceived = true;
            };
            server.on('messageReceive', callback);
            server.off('messageReceive', callback);

            const connectionPromise = new Promise<webSocket.WebSocketConnection>((resolve) => {
              const connectCallback = (connection: webSocket.WebSocketConnection) => {
                server.off('connect', connectCallback);
                resolve(connection);
              };
              server.on('connect', connectCallback);
            });

            const client: webSocket.WebSocket = webSocket.createWebSocket();
            const connectPromise = new Promise<boolean>((resolve) => {
              client.connect(`ws://127.0.0.1:${port}`, (err: BusinessError, value: boolean) => {
                resolve(!err && value);
              });
            });

            await Promise.all([connectionPromise, connectPromise]);
            await sleep(500);

            const sendPromise = new Promise<boolean>((resolve) => {
              client.send("test message", (err: BusinessError, value: boolean) => {
                resolve(!err && value);
              });
            });

            await sendPromise;
            await sleep(500);

            resultData = { testPassed: !messageReceived };
            success = !messageReceived;

            await server.stop();

            if (!success) {
              errorMsg = 'Unsubscribe from message specified callback fail';
            }
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            errorMsg = `webSocketServerOffMessageSpecific fail: ${businessError.message}`;
          }
          break;
        }

        case 'webSocketServerOffMessageAll': {
          try {
            const server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
            const port = data.port || 8088;
            const serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: data.serverIP || "0.0.0.0",
              serverPort: port,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            };

            const startResult = await server.start(serverConfig);
            if (!startResult) {
              errorMsg = 'WebSocketServer start fail';
              break;
            }

            let messageReceived = false;
            const callback1 = (message: webSocket.WebSocketMessage) => {
              messageReceived = true;
            };
            const callback2 = (message: webSocket.WebSocketMessage) => {
              messageReceived = true;
            };
            server.on('messageReceive', callback1);
            server.on('messageReceive', callback2);
            server.off('messageReceive');

            const connectionPromise = new Promise<webSocket.WebSocketConnection>((resolve) => {
              const connectCallback = (connection: webSocket.WebSocketConnection) => {
                server.off('connect', connectCallback);
                resolve(connection);
              };
              server.on('connect', connectCallback);
            });

            const client: webSocket.WebSocket = webSocket.createWebSocket();
            const connectPromise = new Promise<boolean>((resolve) => {
              client.connect(`ws://127.0.0.1:${port}`, (err: BusinessError, value: boolean) => {
                resolve(!err && value);
              });
            });

            await Promise.all([connectionPromise, connectPromise]);
            await sleep(500);

            const sendPromise = new Promise<boolean>((resolve) => {
              client.send("test message", (err: BusinessError, value: boolean) => {
                resolve(!err && value);
              });
            });

            await sendPromise;
            await sleep(500);

            resultData = { testPassed: !messageReceived };
            success = !messageReceived;

            await server.stop();

            if (!success) {
              errorMsg = 'Unsubscribe from all message callbacks fail';
            }
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            errorMsg = `webSocketServerOffMessageAll fail: ${businessError.message}`;
          }
          break;
        }

        case 'webSocketServerOnError': {
          try {
            const server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
            const port = data.port || 8088;
            const serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: data.serverIP || "0.0.0.0",
              serverPort: port,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            };


            const startResult = await server.start(serverConfig);
            if (!startResult) {
              errorMsg = 'WebSocketServer start fail';
              break;
            }

            let errorReceived = false;
            let errorCode = 0;

            console.info('check WebSocketServer Supported event types');

            const possibleErrorEvents = ['error', 'exception', 'serverError', 'connectError'];

            for (const eventName of possibleErrorEvents) {
              try {
                // @ts-ignore
                server.on(eventName, (err: BusinessError) => {
                  console.info(`${data.workerName}Pass${eventName} Error in receiving the event:
                   ${JSON.stringify(err)}`);
                  errorReceived = true;
                  errorCode = err.code;
                });
                console.info(`Successfully registered ${eventName} event listener`);
              } catch (e) {
                console.info(`Unable to register ${eventName} event: ${e.message}`);
              }
            }

            try {
              server.on('connect', (client: webSocket.WebSocketConnection) => {
                console.info('server connect:', client);
              });

              // @ts-ignore
              server.on('message', (message: string | ArrayBuffer, client: webSocket.WebSocketConnection) => {
                console.info('received message:', message);
              });
            } catch (e) {
              console.info('Standard event registration fail:', e.message);
            }

            const wrongConnection: webSocket.WebSocketConnection = {
              clientIP: '1.1.1.1',
              clientPort: 8888
            };

            let sendSuccess = false;
            try {
              sendSuccess = await server.send("hi", wrongConnection);
              console.info(`${data.workerName} send result: ${sendSuccess}`);
            } catch (err) {
              const businessError: BusinessError = err as BusinessError;
              console.info(`${data.workerName} send throw error: ${JSON.stringify(businessError)}`);
              errorReceived = true;
              errorCode = businessError.code;
              sendSuccess = false;
            }

            await sleep(2000);

            if (!errorReceived) {
              try {
                const duplicateResult = await server.start(serverConfig);
                console.info(`Results of repeatedly starting the server: ${duplicateResult}`);
              } catch (err) {
                const businessError: BusinessError = err as BusinessError;
                console.info(`Repeated startup triggers an error: ${JSON.stringify(businessError)}`);
              }
            }

            resultData = {
              testPassed: errorReceived && errorCode === 2302006
            };
            success = errorReceived && errorCode === 2302006;

            await server.stop();

            if (!success) {
              console.info(`${data.workerName} Debug information:`, {
                errorReceived,
                errorCode,
                expectedErrorCode: 2302006,
                sendSuccess
              });
              errorMsg = `Error event monitoring fail，errorCode: ${errorCode}`;
            }
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            errorMsg = `webSocketServerOnError fail: ${businessError.message}`;
          }
          break;
        }

        case 'webSocketServerOffErrorSpecific': {
          try {
            const server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
            const port = data.port || 8088;
            const serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: data.serverIP || "0.0.0.0",
              serverPort: port,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            };


            const startResult = await server.start(serverConfig);
            if (!startResult) {
              errorMsg = 'WebSocketServer start fail';
              break;
            }

            let errorReceived = false;
            const callback = (err: BusinessError) => {
              console.info(`${data.workerName} should not received an error: ${JSON.stringify(err)}`);
              errorReceived = true;
            };
            server.on('error', callback);
            server.off('error', callback);

            const wrongConnection: webSocket.WebSocketConnection = {
              clientIP: '1.1.1.1',
              clientPort: 8888
            };

            await server.send("hi", wrongConnection).catch(() => {
            });
            await sleep(500);

            resultData = { testPassed: !errorReceived };
            success = !errorReceived;


            await server.stop();

            if (!success) {
              errorMsg = 'Unsubscribing from error-specified callbacks fail';
            }
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            errorMsg = `webSocketServerOffErrorSpecific fail: ${businessError.message}`;
          }
          break;
        }

        case 'webSocketServerOffErrorAll': {
          try {
            const server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
            const port = data.port || 8088;
            const serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: data.serverIP || "0.0.0.0",
              serverPort: port,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            };

            const startResult = await server.start(serverConfig);
            if (!startResult) {
              errorMsg = 'WebSocketServer start fail';
              break;
            }

            let errorReceived = false;
            const callback1 = (err: BusinessError) => {
              errorReceived = true;
            };
            const callback2 = (err: BusinessError) => {
              errorReceived = true;
            };
            server.on('error', callback1);
            server.on('error', callback2);
            server.off('error');

            const wrongConnection: webSocket.WebSocketConnection = {
              clientIP: '1.1.1.1',
              clientPort: 8888
            };

            await server.send("hi", wrongConnection).catch(() => {
            });
            await sleep(500);

            resultData = { testPassed: !errorReceived };
            success = !errorReceived;

            await server.stop();

            if (!success) {
              errorMsg = 'Unsubscribe from all error callbacks fail';
            }
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            errorMsg = `webSocketServerOffErrorAll fail: ${businessError.message}`;
          }
          break;
        }

        case 'webSocketServerOnClose': {
          try {
            const server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
            const port = data.port || 8088;
            const serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: data.serverIP || "0.0.0.0",
              serverPort: port,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            };

            const startResult = await server.start(serverConfig);
            if (!startResult) {
              errorMsg = 'WebSocketServer start fail';
              break;
            }

            let closeReceived = false;
            const closePromise = new Promise<boolean>((resolve) => {
              const callback =
                (clientConnection: webSocket.WebSocketConnection, closeReason: webSocket.CloseResult) => {
                  console.info(`${data.workerName} Received a close event`);
                  closeReceived = true;
                  resolve(true);
                };
              server.on('close', callback);
            });

            let serverConnection: webSocket.WebSocketConnection | null = null;
            const connectionPromise = new Promise<webSocket.WebSocketConnection>((resolve) => {
              const connectCallback = (connection: webSocket.WebSocketConnection) => {
                server.off('connect', connectCallback);
                serverConnection = connection;
                resolve(connection);
              };
              server.on('connect', connectCallback);
            });

            const client: webSocket.WebSocket = webSocket.createWebSocket();
            const connectPromise = new Promise<boolean>((resolve) => {
              client.connect(`ws://127.0.0.1:${port}`, (err: BusinessError, value: boolean) => {
                resolve(!err && value);
              });
            });

            await Promise.all([connectionPromise, connectPromise]);
            await sleep(500);

            if (serverConnection) {
              const closeOption: webSocket.WebSocketCloseOptions = {
                code: 1000,
                reason: "normal"
              };
              await server.close(serverConnection, closeOption);
            }

            await Promise.race([closePromise]);
            await sleep(500);

            resultData = { testPassed: closeReceived };
            success = closeReceived;

            await server.stop();

            if (!success) {
              errorMsg = 'Close event listening fail';
            }
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            errorMsg = `webSocketServerOnClose fail: ${businessError.message}`;
          }
          break;
        }

        case 'webSocketServerOffCloseSpecific': {
          try {
            const server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
            const port = data.port || 8088;
            const serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: data.serverIP || "0.0.0.0",
              serverPort: port,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            };

            const startResult = await server.start(serverConfig);
            if (!startResult) {
              errorMsg = 'WebSocketServer start fail';
              break;
            }

            let closeReceived = false;
            const callback = (clientConnection: webSocket.WebSocketConnection, closeReason: webSocket.CloseResult) => {
              console.info(`${data.workerName} should notReceived a close event`);
              closeReceived = true;
            };
            server.on('close', callback);
            server.off('close', callback);

            let serverConnection: webSocket.WebSocketConnection | null = null;
            const connectionPromise = new Promise<webSocket.WebSocketConnection>((resolve) => {
              const connectCallback = (connection: webSocket.WebSocketConnection) => {
                server.off('connect', connectCallback);
                serverConnection = connection;
                resolve(connection);
              };
              server.on('connect', connectCallback);
            });

            const client: webSocket.WebSocket = webSocket.createWebSocket();
            const connectPromise = new Promise<boolean>((resolve) => {
              client.connect(`ws://127.0.0.1:${port}`, (err: BusinessError, value: boolean) => {
                resolve(!err && value);
              });
            });

            await Promise.all([connectionPromise, connectPromise]);
            await sleep(500);

            if (serverConnection) {
              const closeOption: webSocket.WebSocketCloseOptions = {
                code: 1000,
                reason: "normal"
              };
              await server.close(serverConnection, closeOption);
            }

            await sleep(500);

            resultData = { testPassed: !closeReceived };
            success = !closeReceived;


            await server.stop();

            if (!success) {
              errorMsg = 'Unsubscribe to close the specified callback fail';
            }
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            errorMsg = `webSocketServerOffCloseSpecific fail: ${businessError.message}`;
          }
          break;
        }

        case 'webSocketServerOffCloseAll': {
          try {
            const server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
            const port = data.port || 8088;
            const serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: data.serverIP || "0.0.0.0",
              serverPort: port,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            };

            const startResult = await server.start(serverConfig);
            if (!startResult) {
              errorMsg = 'WebSocketServer start fail';
              break;
            }

            let closeReceived = false;
            const callback1 = (clientConnection: webSocket.WebSocketConnection, closeReason: webSocket.CloseResult) => {
              closeReceived = true;
            };
            const callback2 = (clientConnection: webSocket.WebSocketConnection, closeReason: webSocket.CloseResult) => {
              closeReceived = true;
            };
            server.on('close', callback1);
            server.on('close', callback2);
            server.off('close');

            let serverConnection: webSocket.WebSocketConnection | null = null;
            const connectionPromise = new Promise<webSocket.WebSocketConnection>((resolve) => {
              const connectCallback = (connection: webSocket.WebSocketConnection) => {
                server.off('connect', connectCallback);
                serverConnection = connection;
                resolve(connection);
              };
              server.on('connect', connectCallback);
            });

            const client: webSocket.WebSocket = webSocket.createWebSocket();
            const connectPromise = new Promise<boolean>((resolve) => {
              client.connect(`ws://127.0.0.1:${port}`, (err: BusinessError, value: boolean) => {
                resolve(!err && value);
              });
            });

            await Promise.all([connectionPromise, connectPromise]);
            await sleep(500);

            if (serverConnection) {
              const closeOption: webSocket.WebSocketCloseOptions = {
                code: 1000,
                reason: "normal"
              };
              await server.close(serverConnection, closeOption);
            }

            await sleep(500);

            resultData = { testPassed: !closeReceived };
            success = !closeReceived;


            await server.stop();

            if (!success) {
              errorMsg = 'Unsubscribing turns off all callbacks. fail';
            }
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            errorMsg = `webSocketServerOffCloseAll fail: ${businessError.message}`;
          }
          break;
        }

        case 'webSocketServerEventMixed': {
          try {
            const server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
            const port = data.port || 8088;
            const serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: data.serverIP || "0.0.0.0",
              serverPort: port,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            };


            const startResult = await server.start(serverConfig);
            if (!startResult) {
              errorMsg = 'WebSocketServer start fail';
              break;
            }

            let connectReceived = false;
            let messageReceived = false;
            let closeReceived = false;

            const connectCallback = (connection: webSocket.WebSocketConnection) => {
              console.info(`${data.workerName}  received connect`);
              connectReceived = true;
            };

            const messageCallback = (message: webSocket.WebSocketMessage) => {
              console.info(`${data.workerName} Message received event: ${message.data}`);
              messageReceived = true;
            };

            const closeCallback = (clientConnection: webSocket.WebSocketConnection,
              closeReason: webSocket.CloseResult) => {
              console.info(`${data.workerName} Received a close event`);
              closeReceived = true;
            };

            server.on('connect', connectCallback);
            server.on('messageReceive', messageCallback);
            server.on('close', closeCallback);


            const client: webSocket.WebSocket = webSocket.createWebSocket();

            const connectResult = await new Promise<boolean>((resolve) => {
              client.connect(`ws://127.0.0.1:${port}`, (err: BusinessError, value: boolean) => {
                resolve(!err && value);
              });
            });

            if (!connectResult) {
              errorMsg = 'server connect fail';
              await server.stop();
              break;
            }

            await sleep(500);

            const sendResult = await new Promise<boolean>((resolve) => {
              client.send("test message", (err: BusinessError, value: boolean) => {
                resolve(!err && value);
              });
            });

            if (!sendResult) {
              errorMsg = 'Message sent fail';
              await server.stop();
              break;
            }

            await sleep(500);

            const connections = await server.listAllConnections();
            if (connections && connections.length > 0) {
              await server.close(connections[0]);
              await sleep(500);
            }

            resultData = {
              testPassed: connectReceived && messageReceived && closeReceived
            };
            success = connectReceived && messageReceived && closeReceived;


            await server.stop();

            if (!success) {
              errorMsg = `Hybrid event listening fail: connect=${connectReceived},
              message=${messageReceived}, close=${closeReceived}`;
            }
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            errorMsg = `webSocketServerEventMixed fail: ${businessError.message}`;
          }
          break;
        }

        case 'webSocketServerEventUnsubscribeStress': {
          try {
            const server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
            const port = data.port || 8088;
            const serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: data.serverIP || "0.0.0.0",
              serverPort: port,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            };


            const startResult = await server.start(serverConfig);
            if (!startResult) {
              errorMsg = 'WebSocketServer start fail';
              break;
            }

            const callbacks: Array<(connection: webSocket.WebSocketConnection) => void> = [];
            let receivedCount = 0;

            for (let i = 0; i < 10; i++) {
              const callback = (connection: webSocket.WebSocketConnection) => {
                receivedCount++;
                console.info(`${data.workerName} callback ${i} be called`);
              };
              callbacks.push(callback);
              server.on('connect', callback);
            }

            for (let i = 0; i < 10; i += 2) {
              server.off('connect', callbacks[i]);
            }

            const client: webSocket.WebSocket = webSocket.createWebSocket();
            const connectPromise = new Promise<boolean>((resolve) => {
              client.connect(`ws://127.0.0.1:${port}`, (err: BusinessError, value: boolean) => {
                resolve(!err && value);
              });
            });

            await connectPromise;
            await sleep(500);

            resultData = { testPassed: receivedCount === 5 };
            success = receivedCount === 5;

            await server.stop();

            if (!success) {
              errorMsg = `Unsubscribe from the stress test fail，Actual number of calls: ${receivedCount}`;
            }
          } catch (err) {
            const businessError: BusinessError = err as BusinessError;
            errorMsg = `webSocketServerEventUnsubscribeStress fail: ${businessError.message}`;
          }
          break;
        }

        default:
          errorMsg = `Unknown test type: ${data.testType}`;
          break;
      }

      const response: ResultMessage = {
        type: 'testResult',
        testId: data.testId,
        success: success,
        data: success ? resultData : undefined,
        error: !success ? errorMsg : undefined,
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
        error: `Test execution exception: ${businessError.message}`,
        workerName: data.workerName,
        testName: data.testName
      };
      workerPort.postMessage(response);
    }
  }
};