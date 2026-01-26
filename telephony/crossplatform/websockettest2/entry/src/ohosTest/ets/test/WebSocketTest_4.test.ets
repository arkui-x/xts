/*
 * Copyright (c) Huawei Technologies Co., Ltd. 2026-2026. All rights reserved.
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

import { hilog } from '@kit.PerformanceAnalysisKit';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, Size, TestType } from '@ohos/hypium';
import { socket, webSocket } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import assertNull from '@ohos/hypium/src/main/module/assert/assertNull';
import { data } from '@kit.TelephonyKit';

const ERR_CODE_PARAMETER_ERROR = 401;
const MIN_DATA_SIZE = 5242864;

let testResults: string[] = [];

function sleep(time: number): Promise<string> {
  return new Promise<string>((resolve) => {
    setTimeout(() => {
      resolve('ok')
    }, time)
  });
}

function addTestResult(result: string): void {
  testResults = [...testResults, result];
  console.info(`result: ${result}`);
}

export default function WebSocketTest_4() {
  describe('WebSocketTest_4', () => {
    afterEach(async () => {
      await sleep(500);
    });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_MessageReceive_0100
     * @tc.name ArKUIX_WebSocketServer_Off_MessageReceive_0100
     * @tc.desc Unsubscribe from the event of receiving client messages on WebSocketServer
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_MessageReceive_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_MessageReceive_0100';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            console.info(`${caseName} --> ${server}`);
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8088,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            }
            await server.start(serverConfig).then((value: boolean) => {
              if (value) {
                console.info(`${caseName} server start`)
              } else {
                console.info(`${caseName} server start fail`)
                expect().assertFail();
                done();
              }
            }).catch((err: BusinessError) => {
              console.info(`${caseName} catch error ${JSON.stringify(err)}`);
              expect().assertFail();
              done();
            })
            let callback = (massage: webSocket.WebSocketMessage) => {
              expect().assertFail();
              done();
            }
            server.on('messageReceive', callback)
            try {
              server.off('messageReceive', callback);
            } catch (err) {
              addTestResult(`The event of unsubscribing to the receiving client messages of WebSocketServer failed,
            code: ${err.code}, message: ${err.message}`);
              expect().assertFail();
              done();
            }
            await sleep(100)

            let client: webSocket.WebSocket = webSocket.createWebSocket()
            console.info(`${caseName}client-- >${client}`)

            class OutValue {
              status: number = 0
              message: string = ""
            }

            await client.on('open', (err: BusinessError, value: Object) => {
              console.info(`${caseName} onopen err is ${JSON.stringify(err)} and value is ${JSON.stringify(value)}`);
              const status: number = (value as OutValue).status;
              console.info(`${JSON.stringify(status)}`);

              client.send('hello server', (err: BusinessError, value: boolean) => {
                if (!err) {
                  console.info(`${caseName} client send message successfully`)
                } else {
                  console.info(`${caseName} Failed to send the message. Err:` + JSON.stringify(err));
                  expect().assertFail();
                  done()
                }
              })
            })
            await sleep(100)
            client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
              }
            });
            await sleep(100)
            expect(true).assertTrue();
            done();
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_MessageReceive_0200
     * @tc.name ArKUIX_WebSocketServer_Off_MessageReceive_0200
     * @tc.desc Unsubscribe from the event of receiving client messages on WebSocketServer(type is null)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_MessageReceive_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_MessageReceive_0200';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let callback = (massage: webSocket.WebSocketMessage) => {
              expect().assertFail();
              done();
            }
            try {
              server.off(null, callback);
            } catch (err) {
              addTestResult(`The event of unsubscribing to the receiving client messages of WebSocketServer failed,
            code: ${err.code}, message: ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_MessageReceive_0300
     * @tc.name ArKUIX_WebSocketServer_Off_MessageReceive_0300
     * @tc.desc Unsubscribe from the event of receiving client messages on WebSocketServer(type is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_MessageReceive_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_MessageReceive_0300';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let callback = (massage: webSocket.WebSocketMessage) => {
              expect().assertFail();
              done();
            }
            try {
              server.off(undefined, callback);
            } catch (err) {
              addTestResult(`The event of unsubscribing to the receiving client messages of WebSocketServer failed,
            code: ${err.code}, message: ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_MessageReceive_0400
     * @tc.name ArKUIX_WebSocketServer_Off_MessageReceive_0400
     * @tc.desc Unsubscribe from the event of receiving client messages on WebSocketServer(callback is null)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_MessageReceive_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_MessageReceive_0400';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            try {
              server.off('messageReceive', null);
            } catch (err) {
              addTestResult(`The event of unsubscribing to the receiving client messages of WebSocketServer failed,
              code: ${err.code}, message: ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_MessageReceive_0500
     * @tc.name ArKUIX_WebSocketServer_Off_MessageReceive_0500
     * @tc.desc Unsubscribe from the event of receiving client messages on WebSocketServer(callback is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_MessageReceive_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_MessageReceive_0500';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            try {
              server.off('messageReceive', undefined);
            } catch (err) {
              addTestResult(`The event of unsubscribing to the receiving client messages of WebSocketServer failed,
              code: ${err.code}, message: ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_MessageReceive_0600
     * @tc.name ArKUIX_WebSocketServer_Off_MessageReceive_0600
     * @tc.desc Unsubscribe from the event of receiving client messages on WebSocketServer
     * (Subscribe multiple times and cancel all without specifying a callback)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_MessageReceive_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_MessageReceive_0600';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            console.info(`${caseName} --> ${server}`);
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8088,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            }
            await server.start(serverConfig).then((value: boolean) => {
              if (value) {
                console.info(`${caseName} server start`)
              } else {
                console.info(`${caseName} server start fail`)
                expect().assertFail();
                done();
              }
            }).catch((err: BusinessError) => {
              console.info(`${caseName} catch error ${JSON.stringify(err)}`);
              expect().assertFail();
              done();
            })
            let callback_1 = (massage: webSocket.WebSocketMessage) => {
              expect().assertFail();
              done();
            }
            let callback_2 = (massage: webSocket.WebSocketMessage) => {
              expect().assertFail();
              done();
            }
            server.on('messageReceive', callback_1);
            server.on('messageReceive', callback_2);
            try {
              server.off('messageReceive');
            } catch (err) {
              addTestResult(`The event of unsubscribing to the receiving client messages of WebSocketServer failed,
            code: ${err.code}, message: ${err.message}`);
              expect().assertFail();
              done();
            }
            await sleep(100)

            let client: webSocket.WebSocket = webSocket.createWebSocket()
            console.info(`${caseName}client-- >${client}`)

            class OutValue {
              status: number = 0
              message: string = ""
            }

            await client.on('open', (err: BusinessError, value: Object) => {
              console.info(`${caseName} onopen err is ${JSON.stringify(err)} and value is ${JSON.stringify(value)}`);
              const status: number = (value as OutValue).status;
              console.info(`${JSON.stringify(status)}`);

              client.send('hello server', (err: BusinessError, value: boolean) => {
                if (!err) {
                  console.info(`${caseName} client send message successfully`)
                } else {
                  console.info(`${caseName} Failed to send the message. Err:` + JSON.stringify(err));
                  expect().assertFail();
                  done()
                }
              })
            })
            await sleep(100)
            client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
              }
            });
            await sleep(100)
            expect(true).assertTrue();
            done();
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_On_Connect_0100
     * @tc.name ArKUIX_WebSocketServer_On_Connect_0100
     * @tc.desc Subscript to websocket server connect event
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_On_Connect_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_On_Connect_0100';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8888,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            }
            await server.start(serverConfig).then((value: boolean) => {
              if (value) {
                console.info(`${caseName} server start`)
              } else {
                console.info(`${caseName} server start fail`)
                expect().assertFail();
                done()
              }
            }).catch((err: BusinessError) => {
              console.info(`${caseName} catch error ${JSON.stringify(err)}`);
              expect().assertFail();
              done();
            })
            let callback = (connection: webSocket.WebSocketConnection) => {
              console.info(`${caseName} connections-->+ ${JSON.stringify(connection)}`);
              expect(connection != undefined).assertTrue();
              done();
            }
            await server.on('connect', callback)
            await sleep(100);

            let client = await webSocket.createWebSocket()
            await client.connect('ws://127.0.0.1:8888', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} connect success`)
              } else {
                console.info(`${caseName} connect fail`)
              }
            })
            await sleep(100)
            done();
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_On_Connect_0200
     * @tc.name ArKUIX_WebSocketServer_On_Connect_0200
     * @tc.desc Subscript to websocket server connect event(type is null)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_On_Connect_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_On_Connect_0200';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let callback = (connection: webSocket.WebSocketConnection) => {
              console.info(`${caseName} connections-->+ ${JSON.stringify(connection)}`);
              expect().assertFail();
              done();
            }
            try {
              server.on(null, callback)
            } catch (err) {
              addTestResult(`on connect fail，code: ${err.code}, message: ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_On_Connect_0300
     * @tc.name ArKUIX_WebSocketServer_On_Connect_0300
     * @tc.desc Subscript to websocket server connect event(type is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_On_Connect_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_On_Connect_0300';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let callback = (connection: webSocket.WebSocketConnection) => {
              console.info(`${caseName} connections-->+ ${JSON.stringify(connection)}`);
              expect().assertFail();
              done();
            }
            try {
              server.on(undefined, callback)
            } catch (err) {
              addTestResult(`on connect fail，code: ${err.code}, message: ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_Connect_0100
     * @tc.name ArKUIX_WebSocketServer_Off_Connect_0100
     * @tc.desc Unsubscript to websocket server connect event
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_Connect_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_Connect_0100';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8088,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            }
            await server.start(serverConfig).then((value: boolean) => {
              if (value) {
                console.info(`${caseName} server start`)
              } else {
                console.info(`${caseName} server start fail`)
                expect().assertFail();
                done()
              }
            }).catch((err: BusinessError) => {
              console.info(`${caseName} catch error ${JSON.stringify(err)}`);
              expect().assertFail();
              done();
            })
            let callback = (connection: webSocket.WebSocketConnection) => {
              console.info(`${caseName} connections-->+ ${JSON.stringify(connection)}`);
              expect().assertFail();
              done();
            }
            await server.on('connect', callback);
            await server.off('connect', callback);
            await sleep(100);

            let client = await webSocket.createWebSocket()
            await client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} connect success`)
              } else {
                console.info(`${caseName} connect fail`)
              }
            })
            await sleep(100)
            expect(true).assertTrue();
            done();
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_Connect_0200
     * @tc.name ArKUIX_WebSocketServer_Off_Connect_0200
     * @tc.desc Unsubscript to websocket server connect event(type is null)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_Connect_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_Connect_0200';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let callback = (connection: webSocket.WebSocketConnection) => {
              console.info(`${caseName} connections-->+ ${JSON.stringify(connection)}`);
              expect().assertFail();
              done();
            }
            try {
              server.off(null, callback);
            } catch (err) {
              addTestResult(`Failed to unsubscribe from the connection event of WebSocketServer.
              code: ${err.code}, message: ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_Connect_0300
     * @tc.name ArKUIX_WebSocketServer_Off_Connect_0300
     * @tc.desc Unsubscript to websocket server connect event(type is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_Connect_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_Connect_0300';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let callback = (connection: webSocket.WebSocketConnection) => {
              console.info(`${caseName} connections-->+ ${JSON.stringify(connection)}`);
              expect().assertFail();
              done();
            }
            try {
              server.off(undefined, callback);
            } catch (err) {
              addTestResult(`Failed to unsubscribe from the connection event of WebSocketServer.
              code: ${err.code}, message: ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_Connect_0400
     * @tc.name ArKUIX_WebSocketServer_Off_Connect_0400
     * @tc.desc Unsubscript to websocket server connect event(callback is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_Connect_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_Connect_0400';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            try {
              await server.off('connect', undefined);
            } catch (err) {
              addTestResult(`Failed to unsubscribe from the connection event of WebSocketServer.
            code: ${err.code}, message: ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_Connect_0500
     * @tc.name ArKUIX_WebSocketServer_Off_Connect_0500
     * @tc.desc Unsubscript to websocket server connect event
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_Connect_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_Connect_0500';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8088,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            }
            await server.start(serverConfig).then((value: boolean) => {
              if (value) {
                console.info(`${caseName} server start`)
              } else {
                console.info(`${caseName} server start fail`)
                expect().assertFail();
                done()
              }
            }).catch((err: BusinessError) => {
              console.info(`${caseName} catch error ${JSON.stringify(err)}`);
              expect().assertFail();
              done();
            })
            let callback = (connection: webSocket.WebSocketConnection) => {
              console.info(`${caseName} connections-->+ ${JSON.stringify(connection)}`);
              expect().assertFail();
              done();
            }
            await server.on('connect', callback);
            await server.off('connect');
            await sleep(100);

            let client = await webSocket.createWebSocket()
            await client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} connect success`)
              } else {
                console.info(`${caseName} connect fail`)
              }
            })
            await sleep(100);
            expect(true).assertTrue();
            done();
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_Connect_0600
     * @tc.name ArKUIX_WebSocketServer_Off_Connect_0600
     * @tc.desc Unsubscript to websocket server connect event(Subscribe multiple times
     * and cancel all without specifying a callback)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_Connect_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_Connect_0600';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8088,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            }
            await server.start(serverConfig).then((value: boolean) => {
              if (value) {
                console.info(`${caseName} server start`)
              } else {
                console.info(`${caseName} server start fail`)
                expect().assertFail();
                done()
              }
            }).catch((err: BusinessError) => {
              console.info(`${caseName} catch error ${JSON.stringify(err)}`);
              expect().assertFail();
              done();
            })
            let callback_1 = (connection: webSocket.WebSocketConnection) => {
              console.info(`${caseName} connections-->+ ${JSON.stringify(connection)}`);
              expect().assertFail();
              done();
            }
            let callback_2 = (connection: webSocket.WebSocketConnection) => {
              console.info(`${caseName} connections-->+ ${JSON.stringify(connection)}`);
              expect().assertFail();
              done();
            }
            await server.on('connect', callback_1);
            await server.on('connect', callback_2);
            await server.off('connect');
            await sleep(100);

            let client = await webSocket.createWebSocket()
            await client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} connect success`)
              } else {
                console.info(`${caseName} connect fail`)
              }
            })
            await sleep(100);
            expect(true).assertTrue();
            done();
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_On_Close_0100
     * @tc.name ArKUIX_WebSocketServer_On_Close_0100
     * @tc.desc Subscript to websocket server close event
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_On_Close_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_On_Close_0100';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer()
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8099,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            }
            await server.start(serverConfig).then((value: boolean) => {
              if (value) {
                console.info(`${caseName} server start`)
              } else {
                console.info(`${caseName} server start fail`)
                expect().assertFail();
                done()
              }
            }).catch((err: BusinessError) => {
              console.info(`${caseName} catch error ${JSON.stringify(err)}`);
              expect().assertFail();
              done();
            })

            let closeCallback =
              (clientConnection: webSocket.WebSocketConnection, closeReason: webSocket.CloseResult) => {
                console.info(`${caseName} onclose connection is ${JSON.stringify(clientConnection)}
            and closeReason is ${JSON.stringify(closeReason)}`);
                expect(clientConnection != undefined).assertTrue();
                done();
              }
            server.on('close', closeCallback);
            server.on('connect', (connection: webSocket.WebSocketConnection) => {
              console.info(`${caseName} connections-->+ ${JSON.stringify(connection)}`);

              let closeOption: webSocket.WebSocketCloseOptions = {
                code: 1000,
                reason: "normal"
              }
              server.close(connection, closeOption).then((value: boolean) => {
                console.info(`${caseName} close value is ${JSON.stringify(value)}`)
              })
            })
            await sleep(100)
            let client = await webSocket.createWebSocket()
            await client.connect('ws://127.0.0.1:8099', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} connect success`)
              } else {
                console.info(`${caseName} connect fail`)
                expect().assertFail();
                done();
              }
            })
            await sleep(1500);
            done();
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_On_Close_0200
     * @tc.name ArKUIX_WebSocketServer_On_Close_0200
     * @tc.desc Subscript to websocket server close event(type is null)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_On_Close_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_On_Close_0200';
        try {
          let server: webSocket.WebSocketServer = webSocket.createWebSocketServer()
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let closeCallback =
              (clientConnection: webSocket.WebSocketConnection, closeReason: webSocket.CloseResult) => {
                console.info(`${caseName} onclose connection is ${JSON.stringify(clientConnection)}
            and closeReason is ${JSON.stringify(closeReason)}`);
                expect().assertFail();
                done();
              }
            try {
              server.on(null, closeCallback);
            } catch (err) {
              addTestResult(`The closure event for subscribing to WebSocketServer failed,
              code: ${err.code}, message: ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_On_Close_0300
     * @tc.name ArKUIX_WebSocketServer_On_Close_0300
     * @tc.desc Subscript to websocket server close event(type is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_On_Close_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_On_Close_0300';
        try {
          let server: webSocket.WebSocketServer = webSocket.createWebSocketServer()
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let closeCallback =
              (clientConnection: webSocket.WebSocketConnection, closeReason: webSocket.CloseResult) => {
                console.info(`${caseName} onclose connection is ${JSON.stringify(clientConnection)}
              and closeReason is ${JSON.stringify(closeReason)}`);
                expect().assertFail();
                done();
              }
            try {
              server.on(undefined, closeCallback);
            } catch (err) {
              addTestResult(`The closure event for subscribing to WebSocketServer failed,
              code: ${err.code}, message: ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_On_Close_0400
     * @tc.name ArKUIX_WebSocketServer_On_Close_0400
     * @tc.desc Subscript to websocket server close event(callback is null)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_On_Close_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_On_Close_0400';
        try {
          let server: webSocket.WebSocketServer = webSocket.createWebSocketServer()
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            try {
              server.on('close', null);
            } catch (err) {
              addTestResult(`The closure event for subscribing to WebSocketServer failed,
              code: ${err.code}, message: ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_On_Close_0500
     * @tc.name ArKUIX_WebSocketServer_On_Close_0500
     * @tc.desc Subscript to websocket server close event(callback is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_On_Close_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_On_Close_0500';
        try {
          let server: webSocket.WebSocketServer = webSocket.createWebSocketServer()
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            try {
              server.on('close', undefined);
            } catch (err) {
              addTestResult(`The closure event for subscribing to WebSocketServer failed,
              code: ${err.code}, message: ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_Close_0100
     * @tc.name ArKUIX_WebSocketServer_Off_Close_0100
     * @tc.desc UnSubscript to websocket server close event
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_Close_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_Close_0100';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer()
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8088,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            }
            await server.start(serverConfig).then((value: boolean) => {
              if (value) {
                console.info(`${caseName} server start`)
              } else {
                console.info(`${caseName} server start fail`)
                expect().assertFail();
                done()
              }
            }).catch((err: BusinessError) => {
              console.info(`${caseName} catch error ${JSON.stringify(err)}`);
              expect().assertFail();
              done();
            })

            let closeCallback = (clientConnection: webSocket.WebSocketConnection,
              closeReason: webSocket.CloseResult) => {
              console.info(`${caseName} onclose connection is ${JSON.stringify(clientConnection)}
              and closeReason is ${JSON.stringify(closeReason)}`);
              expect().assertFail();
              done();
            }
            server.on('close', closeCallback);
            try {
              server.off('close', closeCallback);
            } catch (err) {
              addTestResult(`The closure event for subscribing to WebSocketServer failed,
              code: ${err.code}, message: ${err.message}`);
              expect().assertFail();
            }

            server.on('connect', (connection: webSocket.WebSocketConnection) => {
              console.info(`${caseName} connections-->+ ${JSON.stringify(connection)}`);

              let closeOption: webSocket.WebSocketCloseOptions = {
                code: 1000,
                reason: "normal"
              }
              server.close(connection, closeOption).then((value: boolean) => {
                console.info(`${caseName} close value is ${JSON.stringify(value)}`)
              })
            })
            await sleep(100)
            let client = await webSocket.createWebSocket()
            await client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} connect success`)
              } else {
                console.info(`${caseName} connect fail`)
                expect().assertFail();
                done();
              }
            })
            await sleep(100);
            expect(true).assertTrue();
            done();
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_Close_0200
     * @tc.name ArKUIX_WebSocketServer_Off_Close_0200
     * @tc.desc UnSubscript to websocket server close event(type is null)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_Close_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_Close_0200';
        try {
          let server: webSocket.WebSocketServer = webSocket.createWebSocketServer()
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let closeCallback = (clientConnection: webSocket.WebSocketConnection,
              closeReason: webSocket.CloseResult) => {
              console.info(`${caseName} onclose connection is ${JSON.stringify(clientConnection)}
              and closeReason is ${JSON.stringify(closeReason)}`);
              expect().assertFail();
              done();
            }
            try {
              server.off(null, closeCallback);
            } catch (err) {
              addTestResult(`The closure event for subscribing to WebSocketServer failed,
              code: ${err.code}, message: ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              server.stop();
              done();
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_Close_0300
     * @tc.name ArKUIX_WebSocketServer_Off_Close_0300
     * @tc.desc UnSubscript to websocket server close event(type is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_Close_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_Close_0300';
        try {
          let server: webSocket.WebSocketServer = webSocket.createWebSocketServer()
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let closeCallback = (clientConnection: webSocket.WebSocketConnection,
              closeReason: webSocket.CloseResult) => {
              console.info(`${caseName} onclose connection is ${JSON.stringify(clientConnection)}
              and closeReason is ${JSON.stringify(closeReason)}`);
              expect().assertFail();
              done();
            }
            try {
              server.off(undefined, closeCallback);
            } catch (err) {
              addTestResult(`The closure event for subscribing to WebSocketServer failed,
              code: ${err.code}, message: ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              server.stop();
              done();
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_Close_0400
     * @tc.name ArKUIX_WebSocketServer_Off_Close_0400
     * @tc.desc UnSubscript to websocket server close event(callback is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_Close_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_Close_0400';
        try {
          let server: webSocket.WebSocketServer = webSocket.createWebSocketServer()
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            try {
              server.off('close', undefined);
            } catch (err) {
              addTestResult(`The closure event for subscribing to WebSocketServer failed,
              code: ${err.code}, message: ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_Close_0500
     * @tc.name ArKUIX_WebSocketServer_Off_Close_0500
     * @tc.desc UnSubscript to websocket server close event(no callback)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_Close_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_Close_0500';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer()
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8088,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            }
            await server.start(serverConfig).then((value: boolean) => {
              if (value) {
                console.info(`${caseName} server start`)
              } else {
                console.info(`${caseName} server start fail`)
                expect().assertFail();
                done()
              }
            }).catch((err: BusinessError) => {
              console.info(`${caseName} catch error ${JSON.stringify(err)}`);
              expect().assertFail();
              done();
            })

            let closeCallback = (clientConnection: webSocket.WebSocketConnection,
              closeReason: webSocket.CloseResult) => {
              console.info(`${caseName} onclose connection is ${JSON.stringify(clientConnection)}
              and closeReason is ${JSON.stringify(closeReason)}`);
              expect().assertFail();
              done();
            }
            server.on('close', closeCallback);
            try {
              server.off('close');
            } catch (err) {
              addTestResult(`The closure event for subscribing to WebSocketServer failed,
              code: ${err.code}, message: ${err.message}`);
              expect().assertFail();
            }

            server.on('connect', (connection: webSocket.WebSocketConnection) => {
              console.info(`${caseName} connections-->+ ${JSON.stringify(connection)}`);

              let closeOption: webSocket.WebSocketCloseOptions = {
                code: 1000,
                reason: "normal"
              }
              server.close(connection, closeOption).then((value: boolean) => {
                console.info(`${caseName} close value is ${JSON.stringify(value)}`)
              })
            })
            await sleep(100)
            let client = await webSocket.createWebSocket()
            await client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} connect success`)
              } else {
                console.info(`${caseName} connect fail`)
                expect().assertFail();
                done();
              }
            })
            await sleep(100);
            expect(true).assertTrue();
            done();
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_Close_0600
     * @tc.name ArKUIX_WebSocketServer_Off_Close_0600
     * @tc.desc UnSubscript to websocket server close event(Subscribe multiple times and
     * cancel all without specifying a callback)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_Close_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_Close_0600';
        try {
          let server: webSocket.WebSocketServer = webSocket.createWebSocketServer()
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8088,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            }
            await server.start(serverConfig).then((value: boolean) => {
              if (value) {
                console.info(`${caseName} server start`)
              } else {
                console.info(`${caseName} server start fail`)
                expect().assertFail();
                done()
              }
            }).catch((err: BusinessError) => {
              console.info(`${caseName} catch error ${JSON.stringify(err)}`);
              expect().assertFail();
              done();
            })

            let closeCallback_1 = (clientConnection: webSocket.WebSocketConnection,
              closeReason: webSocket.CloseResult) => {
              console.info(`${caseName} onclose connection is ${JSON.stringify(clientConnection)}
              and closeReason is ${JSON.stringify(closeReason)}`);
              expect().assertFail();
              done();
            }
            let closeCallback_2 = (clientConnection: webSocket.WebSocketConnection,
              closeReason: webSocket.CloseResult) => {
              console.info(`${caseName} onclose connection is ${JSON.stringify(clientConnection)}
              and closeReason is ${JSON.stringify(closeReason)}`);
              expect().assertFail();
              done();
            }
            server.on('close', closeCallback_1);
            server.on('close', closeCallback_2);
            try {
              server.off('close');
            } catch (err) {
              addTestResult(`The closure event for subscribing to WebSocketServer failed,
              code: ${err.code}, message: ${err.message}`);
              expect().assertFail();
            }

            server.on('connect', (connection: webSocket.WebSocketConnection) => {
              console.info(`${caseName} connections-->+ ${JSON.stringify(connection)}`);

              let closeOption: webSocket.WebSocketCloseOptions = {
                code: 1000,
                reason: "normal"
              }
              server.close(connection, closeOption).then((value: boolean) => {
                console.info(`${caseName} close value is ${JSON.stringify(value)}`)
              })
            })
            await sleep(100)
            let client = await webSocket.createWebSocket()
            await client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} connect success`)
              } else {
                console.info(`${caseName} connect fail`)
                expect().assertFail();
                done();
              }
            })
            await sleep(100);
            expect(true).assertTrue();
            done();
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        }
      });

  })
}
