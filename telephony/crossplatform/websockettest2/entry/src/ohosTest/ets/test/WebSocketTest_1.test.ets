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

import { describe, afterEach, it, expect, Level, Size, TestType } from '@ohos/hypium';
import { webSocket } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';

const NET_ERROR_CANT_LISTEN_ON_NIC = 2302004;
const ERR_CODE_PARAMETER_ERROR = 401;

let serverConfig: webSocket.WebSocketServerConfig = {
  serverIP: "0.0.0.0",
  serverPort: 8088,
  maxConcurrentClientsNumber: 10,
  maxConnectionsForOneClient: 4,
}

const ws = webSocket.createWebSocket();
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

export default function WebSocketTest_1() {
  describe('WebSocketTest_1', () => {
    afterEach(async () => {
      await sleep(500);
    });
    /**
     * @tc.number ArKUIX_WebSocket_On_HeaderReceive_0100
     * @tc.name ArKUIX_WebSocket_On_HeaderReceive_0100
     * @tc.desc Subscribe to the headerReceive event of WebSocket(on_HeaderReceive)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocket_On_HeaderReceive_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocket_On_HeaderReceive_0100';
        let ws = webSocket.createWebSocket();
        try {
          ws.on('headerReceive', (data) => {
            console.info(`${caseName} on headerReceive"+${JSON.stringify(data)}`);
            expect(data != null).assertTrue();
            done();
          });
          try {
            const url = `ws://127.0.0.1:8080`;
            ws.connect(url);
          } catch (err) {
            console.error('Connection failed：', (err as Error).message);
            expect().assertFail();
            done();
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        } finally {
          if (ws) {
            ws.close();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocket_On_HeaderReceive_0200
     * @tc.name ArKUIX_WebSocket_On_HeaderReceive_0200
     * @tc.desc Subscribe to the headerReceive event of WebSocket(on_HeaderReceive callback is null)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocket_On_HeaderReceive_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocket_On_HeaderReceive_0200';
        let ws = webSocket.createWebSocket();
        try {
          ws.on('headerReceive', null);
          expect().assertFalse();
          done();
          try {
            const url = `ws://127.0.0.1:8080`;
            ws.connect(url);
          } catch (err) {
            console.error('Connection failed：', (err as Error).message);
            expect().assertFail();
            done();
          }
        } catch (err) {
          addTestResult(`err.code:[${err.code}]，err.message:${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          done();
        } finally {
          if (ws) {
            ws.close();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocket_On_HeaderReceive_0300
     * @tc.name ArKUIX_WebSocket_On_HeaderReceive_0300
     * @tc.desc Subscribe to the headerReceive event of WebSocket(on_HeaderReceive callback is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocket_On_HeaderReceive_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocket_On_HeaderReceive_0300';
        const ws = webSocket.createWebSocket();
        try {
          ws.on('headerReceive', undefined);
          expect().assertFail();
          try {
            const url = `ws://127.0.0.1:8080`;
            ws.connect(url);
          } catch (err) {
            console.error('Connection failed：', (err as Error).message);
            expect().assertFail();
            done();
          }
        } catch (err) {
          addTestResult(`err.code:[${err.code}]，err.message:${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          done();
        } finally {
          if (ws) {
            ws.close();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocket_Off_HeaderReceive_0100
     * @tc.name ArKUIX_WebSocket_Off_HeaderReceive_0100
     * @tc.desc Subscribe to the headerReceive event of WebSocket(off_HeaderReceive)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocket_Off_HeaderReceive_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocket_Off_HeaderReceive_0100';
        const ws = webSocket.createWebSocket();
        try {
          let callback = (data: webSocket.ResponseHeaders) => {
            console.info(`${caseName} on headerReceive"+${JSON.stringify(data)}`);
            expect().assertFail();
            done();
          };
          ws.off('headerReceive', callback);
          try {
            const url = `ws://127.0.0.1:8080`;
            ws.connect(url);
          } catch (err) {
            console.error('Connection failed：', (err as Error).message);
            expect().assertFail();
            done();
          }
          addTestResult(`Unsubscribe HTTP Response Header event was successful.`);
          expect(true).assertTrue();
        } catch (err) {
          addTestResult(`err.code:[${err.code}]，err.message:${err.message}`);
          expect().assertFail();
        } finally {
          if (ws) {
            ws.close();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocket_Off_HeaderReceive_0200
     * @tc.name ArKUIX_WebSocket_Off_HeaderReceive_0200
     * @tc.desc Subscribe to the headerReceive event of WebSocket(off_HeaderReceive Parameter error(null))
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocket_Off_HeaderReceive_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocket_Off_HeaderReceive_0200';
        const ws = webSocket.createWebSocket();
        try {
          try {
            ws.off(null);
          } catch (err) {
            addTestResult(`err.code:[${err.code}]，err.message:${err.message}`);
            const errCode = Number(err.code);
            expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
            done();
          }
        } catch (err) {
          addTestResult(`err.code:[${err.code}]，err.message:${err.message}`);
          expect().assertFail();
          done();
        } finally {
          if (ws) {
            ws.close();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocket_Off_HeaderReceive_0300
     * @tc.name ArKUIX_WebSocket_Off_HeaderReceive_0300
     * @tc.desc Subscribe to the headerReceive event of WebSocket(off_HeaderReceive Parameter error(undefined))
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocket_Off_HeaderReceive_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocket_Off_HeaderReceive_0300';
        const ws = webSocket.createWebSocket();
        try {
          try {
            ws.off(undefined);
          } catch (err) {
            addTestResult(`err.code:[${err.code}]，err.message:${err.message}`);
            const errCode = Number(err.code);
            expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
            done();
          }
        } catch (err) {
          addTestResult(`err.code:[${err.code}]，err.message:${err.message}`);
          expect().assertFail();
          done();
        } finally {
          if (ws) {
            ws.close();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocket_Off_HeaderReceive_0400
     * @tc.name ArKUIX_WebSocket_Off_HeaderReceive_0400
     * @tc.desc Subscribe to the headerReceive event of WebSocket(off_HeaderReceive callback is null)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocket_Off_HeaderReceive_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocket_Off_HeaderReceive_0400';
        const ws = webSocket.createWebSocket();
        try {
          try {
            ws.off('headerReceive', null);
          } catch (err) {
            addTestResult(`err.code:[${err.code}]，err.message:${err.message}`);
            const errCode = Number(err.code);
            expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
            done();
          }
        } catch (err) {
          addTestResult(`err.code:[${err.code}]，err.message:${err.message}`);
          expect().assertFail();
          done();
        } finally {
          if (ws) {
            ws.close();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocket_Off_HeaderReceive_0500
     * @tc.name ArKUIX_WebSocket_Off_HeaderReceive_0500
     * @tc.desc Subscribe to the headerReceive event of WebSocket(off_HeaderReceive callback is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocket_Off_HeaderReceive_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocket_Off_HeaderReceive_0500';
        const ws = webSocket.createWebSocket();
        try {
          try {
            ws.off('headerReceive', undefined);
          } catch (err) {
            addTestResult(`err.code:[${err.code}]，err.message:${err.message}`);
            const errCode = Number(err.code);
            expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
            done();
          }
        } catch (err) {
          addTestResult(`err.code:[${err.code}]，err.message:${err.message}`);
          expect().assertFail();
          done();
        } finally {
          if (ws) {
            ws.close();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocket_Off_HeaderReceive_0600
     * @tc.name ArKUIX_WebSocket_Off_HeaderReceive_0600
     * @tc.desc Subscribe to the headerReceive event of WebSocket(off_HeaderReceive no callback )
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocket_Off_HeaderReceive_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocket_Off_HeaderReceive_0600';
        const ws = webSocket.createWebSocket();
        try {
          let callback = (data: webSocket.ResponseHeaders) => {
            console.info(`${caseName} on headerReceive"+${JSON.stringify(data)}`);
            expect().assertFail();
            done();
          };
          ws.on('headerReceive', callback);
          ws.off('headerReceive');
          try {
            const url = `ws://127.0.0.1:8080`;
            ws.connect(url);
          } catch (err) {
            console.error('Connection failed：', (err as Error).message);
            expect().assertFail();
            done();
          }
          addTestResult(`Unsubscribe HTTP Response Header event was successful.`);
          expect(true).assertTrue();
        } catch (err) {
          addTestResult(`err.code:[${err.code}]，err.message:${err.message}`);
          expect().assertFail();
        } finally {
          if (ws) {
            ws.close();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocket_Off_HeaderReceive_0700
     * @tc.name ArKUIX_WebSocket_Off_HeaderReceive_0700
     * @tc.desc Subscribe to the headerReceive event of WebSocket(off_HeaderReceive Multiple
     * "on" does not specify a callback)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocket_Off_HeaderReceive_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocket_Off_HeaderReceive_0700';
        const ws = webSocket.createWebSocket();
        try {
          let callback_1 = (data: webSocket.ResponseHeaders) => {
            console.info(`${caseName} on headerReceive"+${JSON.stringify(data)}`);
            expect().assertFail();
            done();
          };
          let callback_2 = (data: webSocket.ResponseHeaders) => {
            console.info(`${caseName} on headerReceive"+${JSON.stringify(data)}`);
            expect().assertFail();
            done();
          };
          ws.on('headerReceive', callback_1);
          ws.on('headerReceive', callback_2);
          ws.off('headerReceive');
          try {
            const url = `ws://127.0.0.1:8080`;
            ws.connect(url);
          } catch (err) {
            console.error('Connection failed：', (err as Error).message);
            expect().assertFail();
            done();
          }
          addTestResult(`Unsubscribe HTTP Response Header event was successful.`);
          expect(true).assertTrue();
        } catch (err) {
          addTestResult(`err.code:[${err.code}]，err.message:${err.message}`);
          expect().assertFail();
        } finally {
          if (ws) {
            ws.close();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocket_Off_HeaderReceive_0800
     * @tc.name ArKUIX_WebSocket_Off_HeaderReceive_0800
     * @tc.desc Subscribe to the headerReceive event of WebSocket(off twice)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocket_Off_HeaderReceive_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocket_Off_HeaderReceive_0800';
        const ws = webSocket.createWebSocket();
        try {
          let callback = (data: webSocket.ResponseHeaders) => {
            console.info(`${caseName} on headerReceive"+${JSON.stringify(data)}`);
            expect().assertFail();
            done();
          };
          ws.on('headerReceive', callback);
          ws.off('headerReceive', callback);
          ws.off('headerReceive', callback);
          try {
            const url = `ws://127.0.0.1:8080`;
            ws.connect(url);
          } catch (err) {
            console.error('Connection failed：', (err as Error).message);
            expect().assertFail();
            done();
          }
          addTestResult(`Unsubscribe HTTP Response Header event was successful.`);
          expect(true).assertTrue();
        } catch (err) {
          addTestResult(`err.code:[${err.code}]，err.message:${err.message}`);
          expect().assertFail();
        } finally {
          if (ws) {
            ws.close();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocket_Off_HeaderReceive_0900
     * @tc.name ArKUIX_WebSocket_Off_HeaderReceive_0900
     * @tc.desc Subscribe to the headerReceive event of WebSocket(off-->on)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocket_Off_HeaderReceive_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocket_Off_HeaderReceive_0900';
        const ws = webSocket.createWebSocket();
        try {
          let callback = (data: webSocket.ResponseHeaders) => {
            console.info(`${caseName} on headerReceive"+${JSON.stringify(data)}`);
            expect(data != null).assertTrue();
            done();
          };
          ws.off('headerReceive');
          ws.on('headerReceive', callback);
          try {
            const url = `ws://127.0.0.1:8080`;
            ws.connect(url);
          } catch (err) {
            console.error('Connection failed：', (err as Error).message);
            expect().assertFail();
            done();
          }
        } catch (err) {
          addTestResult(`err.code:[${err.code}]，err.message:${err.message}`);
          expect().assertFail();
        } finally {
          if (ws) {
            ws.close();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocket_Off_HeaderReceive_1000
     * @tc.name ArKUIX_WebSocket_Off_HeaderReceive_1000
     * @tc.desc Subscribe to the headerReceive event of WebSocket(on-->off)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocket_Off_HeaderReceive_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocket_Off_HeaderReceive_1000';
        const ws = webSocket.createWebSocket();
        try {
          let callback = (data: webSocket.ResponseHeaders) => {
            console.info(`${caseName} on headerReceive"+${JSON.stringify(data)}`);
            expect().assertFail();
            done();
          };
          ws.on('headerReceive', callback);
          ws.off('headerReceive');
          try {
            const url = `ws://127.0.0.1:8080`;
            ws.connect(url);
          } catch (err) {
            console.error('Connection failed：', (err as Error).message);
            expect().assertFail();
            done();
          }
          addTestResult(`Unsubscribe HTTP Response Header event was successful.`);
          expect(true).assertTrue();
        } catch (err) {
          addTestResult(`err.code:[${err.code}]，err.message:${err.message}`);
          expect().assertFail();
        } finally {
          if (ws) {
            ws.close();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocket_CreateWebSocketServer_0100
     * @tc.name ArKUIX_WebSocket_CreateWebSocketServer_0100
     * @tc.desc Create a WebSocketServer
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocket_CreateWebSocketServer_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocket_CreateWebSocketServer_0100';
        try {
          let ws: webSocket.WebSocketServer = webSocket.createWebSocketServer();
          expect(ws != null).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        } finally {
          if (ws) {
            ws.close();
          }
        }
        done();
      })

    /**
     * @tc.number ArKUIX_WebSocket_CreateWebSocketServer_0200
     * @tc.name ArKUIX_WebSocket_CreateWebSocketServer_0200
     * @tc.desc Create two WebSocketServers
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocket_CreateWebSocketServer_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocket_CreateWebSocketServer_0200';
        try {
          let ws_1: webSocket.WebSocketServer = webSocket.createWebSocketServer();
          if (!ws_1) {
            expect().assertFail();
          } else {
            let ws_2: webSocket.WebSocketServer = webSocket.createWebSocketServer();
            expect(ws_1 != ws_2).assertTrue();
            ws_1.stop();
            ws_2.stop();
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_0100
     * @tc.name ArKUIX_WebSocketServer_Start_0100
     * @tc.desc Start a WebSocketServer (serverConfig without cert and protocol)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_0100';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        let serverConfig: webSocket.WebSocketServerConfig = {
          serverIP: "0.0.0.0",
          serverPort: 8088,
          maxConcurrentClientsNumber: 10,
          maxConnectionsForOneClient: 4,
        }
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let start = false;
            server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`);
                start = true;
                expect(start).assertTrue();
                done();
              } else {
                console.info(`${caseName} webSocketServer start fail`);
                expect().assertFail();
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              expect().assertFail();
              done();
            })
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
     * @tc.number ArKUIX_WebSocketServer_Start_0200
     * @tc.name ArKUIX_WebSocketServer_Start_0200
     * @tc.desc Start a WebSocketServer(WebServer_IP is 0.0.0.0)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_0200';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`);
                expect(success).assertTrue();
                done();
                server.stop();
              } else {
                console.info(`${caseName} webSocketServer start fail`);
                expect().assertFail();
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              expect().assertFail();
              done();
            })
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
     * @tc.number ArKUIX_WebSocketServer_Start_0300
     * @tc.name ArKUIX_WebSocketServer_Start_0300
     * @tc.desc Start a WebSocketServer(WebServer_IP is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_0300';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: undefined,
              serverPort: 8087,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            }
            server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`);
                expect(success).assertTrue();
                done();
                server.stop();
              } else {
                console.info(`${caseName} webSocketServer start fail`);
                expect().assertFail();
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              expect().assertFail();
              done();
            })
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
     * @tc.number ArKUIX_WebSocketServer_Start_0400
     * @tc.name ArKUIX_WebSocketServer_Start_0400
     * @tc.desc Start a WebSocketServer(WebServer_IP is empty)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_0400';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "",
              serverPort: 8087,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            }
            server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`);
                expect(success).assertTrue();
                done();
                server.stop();
              } else {
                console.info(`${caseName} webSocketServer start fail`);
                expect().assertFail();
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              expect().assertFail();
              done();
            })
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
     * @tc.number ArKUIX_WebSocketServer_Start_0500
     * @tc.name ArKUIX_WebSocketServer_Start_0500
     * @tc.desc Start a WebSocketServer (errorCode:2302004)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_0500';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "11111",
              serverPort: 8087,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            }
            server.start(serverConfig).then((success: boolean) => {
              expect().assertFail();
              done();
            }).catch((error: BusinessError) => {
              console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
              const errCode = Number(error.code);
              expect(errCode === NET_ERROR_CANT_LISTEN_ON_NIC).assertTrue();
              done();
            })
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
  })
}
