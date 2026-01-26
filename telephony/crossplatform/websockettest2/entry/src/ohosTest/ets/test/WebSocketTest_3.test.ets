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
const WEB_SOCKET_ERROR_CONNECTION_NOT_EXIST = 2302006;
const MIN_DATA_SIZE = 5242864;
const DATA_SIZE = MIN_DATA_SIZE + 1024;

let serverConfig: webSocket.WebSocketServerConfig = {
  serverIP: "0.0.0.0",
  serverPort: 8088,
  maxConcurrentClientsNumber: 10,
  maxConnectionsForOneClient: 4,
}

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

export default function WebSocketTest_3() {
  describe('WebSocketTest_3', () => {
    afterEach(async () => {
      await sleep(500);
    });

    /**
     * @tc.number ArKUIX_WebSocketServer_Close_1100
     * @tc.name ArKUIX_WebSocketServer_Close_1100
     * @tc.desc WebSocketServer close a connection(options reason is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Close_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Close_1100';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            await server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`);
              } else {
                console.log(`${caseName} client connect to server`);
                expect().assertFail();
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              expect().assertFail();
              done();
            });
            let client: webSocket.WebSocket = webSocket.createWebSocket();
            client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
                expect().assertFail();
                done();
              }
            });
            await sleep(500);
            let connections = await server.listAllConnections();
            if (!connections || connections.length == 0) {
              console.info(`${caseName} get connections fail`);
              done();
            } else {
              let closeOptions: webSocket.WebSocketCloseOptions = {
                code: 1000,
                reason: undefined
              };
              server.close(connections[0], closeOptions).then((success: boolean) => {
                expect().assertFail();
                done();
                server.stop();
              }).catch((error: BusinessError) => {
                console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
                const errCode = Number(error.code);
                expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              })
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Close_1200
     * @tc.name ArKUIX_WebSocketServer_Close_1200
     * @tc.desc WebSocketServer close a connection(options is null)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Close_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Close_1200';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            await server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`);
              } else {
                console.log(`${caseName} client connect to server`);
                expect().assertFail();
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              expect().assertFail();
              done();
            });
            let client: webSocket.WebSocket = webSocket.createWebSocket();
            client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
                expect().assertFail();
                done();
              }
            });
            await sleep(500);
            let connections = await server.listAllConnections();
            if (!connections || connections.length == 0) {
              console.info(`${caseName} get connections fail`);
              done();
            } else {
              server.close(connections[0], null).then((success: boolean) => {
                expect().assertFail();
                done();
                server.stop();
              }).catch((error: BusinessError) => {
                console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
                const errCode = Number(error.code);
                expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              })
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Close_1300
     * @tc.name ArKUIX_WebSocketServer_Close_1300
     * @tc.desc WebSocketServer close a connection(options is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Close_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Close_1300';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            await server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`);
              } else {
                console.log(`${caseName} client connect to server`);
                expect().assertFail();
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              expect().assertFail();
              done();
            });
            let client: webSocket.WebSocket = webSocket.createWebSocket();
            client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
                expect().assertFail();
                done();
              }
            });
            await sleep(500);
            let connections = await server.listAllConnections();
            if (!connections || connections.length == 0) {
              console.info(`${caseName} get connections fail`);
              done();
            } else {
              server.close(connections[0], undefined).then((success: boolean) => {
                expect().assertFail();
                done();
                server.stop();
              }).catch((error: BusinessError) => {
                console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
                const errCode = Number(error.code);
                expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              })
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Close_1500
     * @tc.name ArKUIX_WebSocketServer_Close_1500
     * @tc.desc WebSocketServer close a connection(errorCode:2302006)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Close_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Close_1500';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let wrongConnection: webSocket.WebSocketConnection = {
              clientIP: '1.1.1.1',
              clientPort: 8888
            }
            server.close(wrongConnection).then((success: boolean) => {
              expect().assertFail();
              done();
              server.stop();
            }).catch((error: BusinessError) => {
              console.error(`${caseName} failed, error111: ${error.code}, ${error.message}`);
              const errCode = Number(error.code);
              expect(errCode === WEB_SOCKET_ERROR_CONNECTION_NOT_EXIST).assertTrue();
              server.stop();
              done();
            })
          }
        } catch (error) {
          console.error(`${caseName} failed, error222: ${error.code}, ${error.message}`);
          const errCode = Number(error.code);
          expect(errCode === WEB_SOCKET_ERROR_CONNECTION_NOT_EXIST).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Send_0100
     * @tc.name ArKUIX_WebSocketServer_Send_0100
     * @tc.desc WebSocketServer send a massage
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Send_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Send_0100';
        console.info(`${caseName} test start`);
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            await server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`);
              } else {
                console.info(`${caseName} webSocketServer start fail`);
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              done();
            })
            let client: webSocket.WebSocket = webSocket.createWebSocket();
            client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
                done();
              }
            });
            await sleep(500);
            let connections = await server.listAllConnections();
            if (!connections || connections.length == 0) {
              console.info(`${caseName} get connections fail`);
              done();
            } else {
              server.send("hello client", connections[0]).then((success: boolean) => {
                if (success) {
                  console.info(`${caseName} send success`);
                  expect(success).assertTrue();
                  done();
                } else {
                  console.info(`${caseName} send fail`);
                  expect().assertFail();
                  done();
                }
              }).catch((error: BusinessError) => {
                console.info(`${caseName} test send fail ${JSON.stringify(error)}`);
                expect().assertFail();
                server.stop();
                done();
              })
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Send_0200
     * @tc.name ArKUIX_WebSocketServer_Send_0200
     * @tc.desc WebSocketServer send a massage(errorCode:2302006)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Send_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Send_0200';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            await server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`);
              } else {
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              done()
            })
            let client: webSocket.WebSocket = webSocket.createWebSocket();
            client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
                done();
              }
            });
            await sleep(20);
            let wrongConnection: webSocket.WebSocketConnection = {
              clientIP: '1.1.1.1',
              clientPort: 8888
            }
            server.send("hello client", wrongConnection).then((success: boolean) => {
              expect().assertFail();
              done();
            }).catch((error: BusinessError) => {
              console.error(`${caseName} failed, error111: ${error.code}, ${error.message}`);
              const errCode = Number(error.code);
              expect(errCode === WEB_SOCKET_ERROR_CONNECTION_NOT_EXIST).assertTrue();
              server.stop();
              done();
            })
          }
        } catch (error) {
          console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Send_0300
     * @tc.name ArKUIX_WebSocketServer_Send_0300
     * @tc.desc WebSocketServer send a massage(data is null)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Send_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Send_0300';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            await server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`);
              } else {
                console.info(`${caseName} webSocketServer start fail`);
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              done();
            })
            let client: webSocket.WebSocket = webSocket.createWebSocket();
            client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
                done();
              }
            });
            await sleep(500);
            let connections = await server.listAllConnections();
            if (!connections || connections.length == 0) {
              console.info(`${caseName} get connections fail`);
              done();
            } else {
              server.send(null, connections[0]).then((success: boolean) => {
                expect().assertFail();
                done();
              }).catch((error: BusinessError) => {
                console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
                const errCode = Number(error.code);
                expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              })
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Send_0400
     * @tc.name ArKUIX_WebSocketServer_Send_0400
     * @tc.desc WebSocketServer send a massage(data is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Send_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Send_0400';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            await server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`);
              } else {
                console.info(`${caseName} webSocketServer start fail`);
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              done();
            })
            let client: webSocket.WebSocket = webSocket.createWebSocket();
            client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
                done();
              }
            });
            await sleep(500);
            let connections = await server.listAllConnections();
            if (!connections || connections.length == 0) {
              console.info(`${caseName} get connections fail`);
              done();
            } else {
              server.send(undefined, connections[0]).then((success: boolean) => {
                expect().assertFail();
                done();
              }).catch((error: BusinessError) => {
                console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
                const errCode = Number(error.code);
                expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              })
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Send_0500
     * @tc.name ArKUIX_WebSocketServer_Send_0500
     * @tc.desc WebSocketServer send a massage(data over 5242864)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Send_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Send_0500';
        console.info(`${caseName} test start`);
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            await server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`);
              } else {
                console.info(`${caseName} webSocketServer start fail`);
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              done();
            })
            let client: webSocket.WebSocket = webSocket.createWebSocket();
            client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
                done();
              }
            });
            await sleep(500);
            let connections = await server.listAllConnections();
            if (!connections || connections.length == 0) {
              console.info(`${caseName} get connections fail`);
              done();
            } else {
              const largeData: ArrayBuffer = new ArrayBuffer(DATA_SIZE);
              server.send(largeData, connections[0]).then((success: boolean) => {
                expect().assertFail();
                done();
              }).catch((error: BusinessError) => {
                console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
                const errCode = Number(error.code);
                expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              })
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Send_0600
     * @tc.name ArKUIX_WebSocketServer_Send_0600
     * @tc.desc WebSocketServer send a massage(data is empty)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Send_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Send_0600';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            await server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`);
              } else {
                console.info(`${caseName} webSocketServer start fail`);
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              done();
            })
            let client: webSocket.WebSocket = webSocket.createWebSocket();
            client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
                done();
              }
            });
            await sleep(500);
            let connections = await server.listAllConnections();
            if (!connections || connections.length == 0) {
              console.info(`${caseName} get connections fail`);
              done();
            } else {
              server.send("", connections[0]).then((success: boolean) => {
                if (success) {
                  console.info(`${caseName} send success`);
                  expect(success).assertTrue();
                  done();
                } else {
                  console.info(`${caseName} send fail`);
                  expect().assertFail();
                  done();
                }
              }).catch((error: BusinessError) => {
                console.info(`${caseName} test send fail ${JSON.stringify(error)}`);
                expect().assertFail();
                server.stop();
                done();
              })
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Send_0700
     * @tc.name ArKUIX_WebSocketServer_Send_0700
     * @tc.desc WebSocketServer send a massage(data is 11111)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Send_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Send_0700';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            await server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`);
              } else {
                console.info(`${caseName} webSocketServer start fail`);
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              done();
            })
            let client: webSocket.WebSocket = webSocket.createWebSocket();
            client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
                done();
              }
            });
            await sleep(500);
            let connections = await server.listAllConnections();
            if (!connections || connections.length == 0) {
              console.info(`${caseName} get connections fail`);
              done();
            } else {
              server.send("11111", connections[0]).then((success: boolean) => {
                if (success) {
                  console.info(`${caseName} send success`);
                  expect(success).assertTrue();
                  done();
                } else {
                  console.info(`${caseName} send fail`);
                  expect().assertFail();
                  done();
                }
              }).catch((error: BusinessError) => {
                console.info(`${caseName} test send fail ${JSON.stringify(error)}`);
                expect().assertFail();
                server.stop();
                done();
              })
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Send_0900
     * @tc.name ArKUIX_WebSocketServer_Send_0900
     * @tc.desc WebSocketServer send a massage(connection is null)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Send_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Send_0900';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            server.send("hello client", null).then((success: boolean) => {
              expect().assertFail();
              done();
            }).catch((error: BusinessError) => {
              console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
              const errCode = Number(error.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Send_1000
     * @tc.name ArKUIX_WebSocketServer_Send_1000
     * @tc.desc WebSocketServer send a massage(connection is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Send_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Send_1000';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            server.send("hello client", undefined).then((success: boolean) => {
              expect().assertFail();
              done();
            }).catch((error: BusinessError) => {
              console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
              const errCode = Number(error.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Stop_0100
     * @tc.name ArKUIX_WebSocketServer_Stop_0100
     * @tc.desc Stop WebSocketServer
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Stop_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Stop_0100';
        try {
          let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
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
            await server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`)
              } else {
                expect().assertFail();
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              expect().assertFail();
              done()
            })
            await server.stop().then((success: boolean) => {
              if (success) {
                expect(true).assertTrue();
                done();
              } else {
                expect().assertFail();
                done();
              }
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        }
        done();
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_On_Error_0100
     * @tc.name ArKUIX_WebSocketServer_On_Error_0100
     * @tc.desc Subscript to websocket server error event
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_On_Error_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_On_Error_0100';
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
                done()
              }
            })
            let callback = (err: BusinessError) => {
              console.info(`${caseName} err,errcode == ${err.code}`)
              expect().assertFail();
              done()
            }
            server.on("error", callback);
            await sleep(100)
            let wrongConnection: webSocket.WebSocketConnection = {
              clientIP: '1.1.1.1',
              clientPort: 8888
            }
            await server.send("hi", wrongConnection).then((success: boolean) => {
              if (success) {
                console.info(`${caseName} send success`)
              } else {
                console.info(`${caseName} send fail`);
              }
            })
            await sleep(100);
            done()
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect(err.code === 2302006).assertTrue();
          done();
        } finally {
          if (server) {
            server.off("error");
          }
          await server.stop();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_On_Error_0200
     * @tc.name ArKUIX_WebSocketServer_On_Error_0200
     * @tc.desc Subscript to websocket server error event(Parameter error, type is null)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_On_Error_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_On_Error_0200';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let callback = (err: BusinessError) => {
              console.info(`${caseName} err,errcode == ${err.code}`)
              expect().assertFail();
              done();
            }
            try {
              server.on(null, callback)
            } catch (err) {
              addTestResult(`The Error event for subscribing to the WebSocketServer failed,
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
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_On_Error_0300
     * @tc.name ArKUIX_WebSocketServer_On_Error_0300
     * @tc.desc Subscript to websocket server error event(Parameter error, type is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_On_Error_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_On_Error_0300';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let callback = (err: BusinessError) => {
              console.info(`${caseName} err,errcode == ${err.code}`)
              expect().assertFail();
              done();
            }
            try {
              server.on(undefined, callback)
            } catch (err) {
              addTestResult(`The Error event for subscribing to the WebSocketServer failed,
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
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_Error_0100
     * @tc.name ArKUIX_WebSocketServer_Off_Error_0100
     * @tc.desc UnSubscript to websocket server error event
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_Error_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_Error_0100';
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
              serverPort: 8089,
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
            })
            let callback = (err: BusinessError) => {
              console.info(`${caseName} err,errcode == ${err.code}`)
              expect().assertFail();
              done();
            }
            server.on("error", callback);
            server.off("error", callback);
            await sleep(100);
            let wrongConnection: webSocket.WebSocketConnection = {
              clientIP: '127.0.0.1',
              clientPort: 8080,
            }
            await server.send("hi", wrongConnection).then((success: boolean) => {
              if (success) {
                console.info(`${caseName} send success`)
              } else {
                console.info(`${caseName} send fail`);
              }
            })
            await sleep(100);
            expect().assertFail();
            done();
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect(err.code === 2302006).assertTrue();
          done();
        } finally {
          if (server) {
            server.off("error");
            await server.stop();
          }
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_Error_0200
     * @tc.name ArKUIX_WebSocketServer_Off_Error_0200
     * @tc.desc UnSubscript to websocket server error event(Parameter error, type is null)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_Error_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_Error_0200';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let callback = (err: BusinessError) => {
              console.info(`${caseName} err,errcode == ${err.code}`)
              expect().assertFail();
              done();
            }
            server.on('error', callback)
            try {
              server.off(null, callback)
            } catch (err) {
              addTestResult(`The Error event for subscribing to the WebSocketServer failed,
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
            server.off("error");
            await server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_Error_0300
     * @tc.name ArKUIX_WebSocketServer_Off_Error_0300
     * @tc.desc UnSubscript to websocket server error event(Parameter error, type is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_Error_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_Error_0300';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let callback = (err: BusinessError) => {
              console.info(`${caseName} err,errcode == ${err.code}`)
              expect().assertFail();
              done();
            }
            try {
              server.off(undefined, callback)
            } catch (err) {
              addTestResult(`The Error event for subscribing to the WebSocketServer failed,
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
            server.off("error");
            await server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_Error_0400
     * @tc.name ArKUIX_WebSocketServer_Off_Error_0400
     * @tc.desc UnSubscript to websocket server error event(Parameter error, callback is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_Error_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_Error_0400';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let callback = (err: BusinessError) => {
              console.info(`${caseName} err,errcode == ${err.code}`)
              expect().assertFail();
              done();
            }
            server.on('error', callback)
            try {
              server.off('error', undefined)
            } catch (err) {
              addTestResult(`The Error event for subscribing to the WebSocketServer failed,
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
            server.off("error");
            await server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Off_Error_0500
     * @tc.name ArKUIX_WebSocketServer_Off_Error_0500
     * @tc.desc UnSubscript to websocket server error event(Multiple subscriptions do not specify callbacks,
     * cancel all subscriptions)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Off_Error_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Off_Error_0500';
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
              serverPort: 30000,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            }
            await server.start(serverConfig).then((value: boolean) => {
              if (value) {
              } else {
                console.info(`${caseName} server start fail`)
                expect().assertFail();
                done();
              }
            })
            server.off("error");
            await sleep(50);
            let callback_1 = (err: BusinessError) => {
              console.info(`${caseName} err,errcode == ${err.code}`);
              expect().assertFail();
              done();
            }
            let callback_2 = (err: BusinessError) => {
              console.info(`${caseName} err,errcode == ${err.code}`);
              expect().assertFail();
              done();
            }
            server.on("error", callback_1);
            server.on("error", callback_2);
            server.off("error");
            await sleep(100)
            let wrongConnection: webSocket.WebSocketConnection = {
              clientIP: '127.0.0.1',
              clientPort: 8082,
            }
            await server.send("hi", wrongConnection).then((success: boolean) => {
              if (success) {
                console.info(`${caseName} send success`)
              } else {
                console.info(`${caseName} send fail`);
              }
            })
            console.info(`${caseName} Server is nullptr`);
            await sleep(1000)
            expect().assertFail();
            done();
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect(err.code === 2302006).assertTrue();
          done();
        } finally {
          if (server) {
            server.off("error");
            await server.stop();
          }
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_On_MessageReceive_0100
     * @tc.name ArKUIX_WebSocketServer_On_MessageReceive_0100
     * @tc.desc Subscribe to the receiving client message event of WebSocketServer
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_On_MessageReceive_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_On_MessageReceive_0100';
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
              serverPort: 8083,
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
              if (massage.data == "hello server") {
                console.info(`${caseName} test onMassage success. connection is ${massage.clientConnection}`)
                expect(massage.data === "hello server").assertTrue();
                done();
              } else {
                expect().assertFail();
                done();
              }
            }
            server.on('messageReceive', callback)
            await sleep(1000)

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
                  done();
                }
              })
            })
            await sleep(1000)
            client.connect('ws://127.0.0.1:8083', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
              }
            });
            await sleep(1000)
            done();
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        } finally {
          server.stop();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_On_MessageReceive_0200
     * @tc.name ArKUIX_WebSocketServer_On_MessageReceive_0200
     * @tc.desc Subscribe to the receiving client message event of WebSocketServer(type is null)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_On_MessageReceive_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_On_MessageReceive_0200';
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
              server.on(null, callback);
            } catch (err) {
              addTestResult(`The event of subscribing to the WebSocketServer to receive client messages failed,
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
     * @tc.number ArKUIX_WebSocketServer_On_MessageReceive_0300
     * @tc.name ArKUIX_WebSocketServer_On_MessageReceive_0300
     * @tc.desc Subscribe to the receiving client message event of WebSocketServer(type is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_On_MessageReceive_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_On_MessageReceive_0300';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let callback = (massage: webSocket.WebSocketMessage) => {
              if (massage.data == "hello server") {
                expect().assertFail();
                done();
              }
            }
            try {
              server.on(undefined, callback);
            } catch (err) {
              addTestResult(`The event of subscribing to the WebSocketServer to receive client messages failed,
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

  })
}
