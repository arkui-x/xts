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

import { describe, beforeEach, it, expect, Level, Size, TestType } from '@ohos/hypium';
import { webSocket } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import deviceInfo from '@ohos.deviceInfo';

let platform: string = deviceInfo.osFullName.split(' ')[0];
let isAndroid: boolean = platform.includes("Android");
let isiOS: boolean = platform.includes("iOS");
let isOH: boolean = platform.includes("OpenHarmony");

const ERR_CODE_PERMISSION_ERROR = 201;

let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();

function sleep(time: number): Promise<string> {
  return new Promise<string>((resolve) => {
    setTimeout(() => {
      resolve('ok')
    }, time)
  });
}

export default function websocket_permissiontest() {
  describe('websocket_permissiontest', () => {
    beforeEach(async () => {
      await sleep(500);
    });

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_2400
     * @tc.name ArKUIX_WebSocketServer_Start_2400
     * @tc.desc Start a WebSocketServer(Permission denied)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_2400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_2400';
        if (platform == 'iOS') {
          done();
          return;
        }
        try {
          let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8087,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            }
            server.start(serverConfig).then((success: boolean) => {
              expect().assertFail();
              done();
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              const errCode = Number(error.code);
              expect(errCode === ERR_CODE_PERMISSION_ERROR).assertTrue();
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
     * @tc.number ArKUIX_WebSocketServer_ListAllConnections_0200
     * @tc.name ArKUIX_WebSocketServer_ListAllConnections_0200
     * @tc.desc WebSocketServer list all connections(permission denied)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_ListAllConnections_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_ListAllConnections_0200';
        if (platform == 'iOS') {
          done();
          return;
        }
        try {
          let connections = await server.listAllConnections();
          console.info(`${caseName} connections: ${JSON.stringify(connections)}`);
          expect().assertFail();
          done();
        } catch (err) {
          const error = err as BusinessError;
          console.info(`${caseName} listAllConnections failed: ${error.code}`);
          const errCode = Number(error.code);
          expect(errCode === ERR_CODE_PERMISSION_ERROR).assertTrue();
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Close_1400
     * @tc.name ArKUIX_WebSocketServer_Close_1400
     * @tc.desc WebSocketServer close a connection( Permission denied)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Close_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Close_1400';
        if (platform == 'iOS') {
          done();
          return;
        }
        try {
          let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
          const fakeConnection: webSocket.WebSocketConnection = {
            clientIP: '127.0.0.1',
            clientPort: 9636,
            socketFd: -1,
          } as webSocket.WebSocketConnection;
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                server.close(fakeConnection).then((success: boolean) => {
                  console.info(`${caseName} close success (unexpected): ${success}`);
                  expect().assertFail();
                  done();
                  resolve();
                }).catch((error: BusinessError) => {
                  console.info(`${caseName} close failed as expected: ${error.code} - ${error.message}`);
                  const errCode = Number(error.code);
                  expect(errCode === ERR_CODE_PERMISSION_ERROR).assertTrue();
                  done();
                });
              });
            })();
          }
        } catch (error) {
          const err = error as BusinessError;
          console.info(`${caseName} test result error ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        } finally {
          server.stop();
        }
      });

    /**
     * @tc.number ArKUIX_WebSocketServer_Send_0800
     * @tc.name ArKUIX_WebSocketServer_Send_0800
     * @tc.desc WebSocketServer send a massage(Permission denied)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Send_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Send_0800';
        if (platform == 'iOS') {
          done();
          return;
        }
        try {
          let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            await (async (): Promise<void> => {
            })().then(async () => {
              await sleep(500);
              let connections = await server.listAllConnections();
              if (!connections || connections.length == 0) {
                console.info(`${caseName} get connections fail`);
              } else {
                await (async (): Promise<void> => {
                  return new Promise<void>((resolve, reject) => {
                    server.send("hello client", connections[0]).then((success: boolean) => {
                      expect().assertFail();
                      resolve();
                    }).catch((error: BusinessError) => {
                      console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
                      reject(error);
                    });
                  });
                })();
              }
            }).catch((err: BusinessError) => {
              console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PERMISSION_ERROR).assertTrue();
              done();
            });
          }
        } catch (error) {
          const err = error as BusinessError;
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          done();
        } finally {
          server.stop();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Stop_0200
     * @tc.name ArKUIX_WebSocketServer_Stop_0200
     * @tc.desc Stop WebSocketServer(Permission denied)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Stop_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Stop_0200';
        if (platform == 'iOS') {
          done();
          return;
        }
        try {
          let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                server.stop().then((success: boolean) => {
                  console.log(`${caseName} webSocketServer stop success`);
                  expect().assertFail();
                  resolve();
                }).catch((error: BusinessError) => {
                  console.info(`${caseName} test result error ${JSON.stringify(error)}`);
                  reject(error);
                });
              });
            })();
          }
        } catch (err) {
          const error = err as BusinessError;
          console.info(`${caseName} catch error ${JSON.stringify(error)}`);
          const errCode = Number(error.code);
          expect(errCode === ERR_CODE_PERMISSION_ERROR).assertTrue();
          done();
        }
      })
  })
}