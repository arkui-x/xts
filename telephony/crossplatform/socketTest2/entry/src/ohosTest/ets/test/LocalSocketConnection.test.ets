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

import { describe, it, expect, Level, TestType, Size, beforeEach, afterEach } from '@ohos/hypium';
import { socket } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { common } from '@kit.AbilityKit';

const ERR_NET_BAD_FILE_DESCRIPTOR = 2301009;

function sleep(ms: number) {
  return new Promise<ESObject>(resolve => setTimeout(resolve, ms));
}

export default function LocalSocketConnectionTest() {
  describe('LocalSocketConnectionTest', () => {
    afterEach(async () => {
      await sleep(3000);
    });

    /**
     * @tc.number ArKUIX_LocalSocketConnection_GetLocalAddress_0100
     * @tc.name ArKUIX_LocalSocketConnection_GetLocalAddress_0100
     * @tc.desc Test the functionality of the getLocalAddress interface function
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_LocalSocketConnection_GetLocalAddress_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_LocalSocketConnection_GetLocalAddress_0100';
        try {
          let server: socket.LocalSocketServer = socket.constructLocalSocketServerInstance();
          const context = AppStorage.get<common.UIAbilityContext>("Context") as common.Context;
          let randomSuffix = Math.random().toString(36).substring(2, 10);
          let sandboxPath: string = context.filesDir + randomSuffix;
          let localAddr: socket.LocalAddress = {
            address: sandboxPath
          };

          await new Promise<void>((resolve, reject) => {
            (async () => {
              try {
                await server.listen(localAddr);
                console.info('listen success');

                let client: socket.LocalSocket = socket.constructLocalSocketInstance();
                let connectOpt: socket.LocalConnectOptions = {
                  address: localAddr,
                  timeout: 6000
                };

                await client.connect(connectOpt);
                console.info('connect success');

                let localPath: string = await server.getLocalAddress();
                console.info("getLocalAddress success, localPath is: " + JSON.stringify(localPath));
                expect(localPath != null).assertTrue();
                await client.close();
                await server.close();
                resolve();
              } catch (err) {
                reject(err);
              }
            })();
          });
        } catch (err) {
          console.error(`${caseName} fail: ${JSON.stringify(err)}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_LocalSocketConnection_GetLocalAddress_0200
     * @tc.name ArKUIX_LocalSocketConnection_GetLocalAddress_0200
     * @tc.desc Test for invalid file descriptors in getLocalAddress
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_LocalSocketConnection_GetLocalAddress_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_LocalSocketConnection_GetLocalAddress_0200';
        try {
          let server: socket.LocalSocketServer = socket.constructLocalSocketServerInstance();
          const context = AppStorage.get<common.UIAbilityContext>("Context") as common.Context;
          let randomSuffix = Math.random().toString(36).substring(2, 10);
          let sandboxPath: string = context.filesDir + '/' + randomSuffix;
          let localAddr: socket.LocalAddress = {
            address: sandboxPath
          };
          await server.listen(localAddr);

          server.on('connect', (connection: socket.LocalSocketConnection) => {
            if (connection) {
              console.info('accept a client');
              server.close()
              server.getLocalAddress().then((localPath: string) => {
                console.info("success, localPath is" + JSON.stringify(localPath));
                expect().assertFail();
              }).catch((err: BusinessError) => {
                const errCode = Number(err.code);
                expect(errCode === ERR_NET_BAD_FILE_DESCRIPTOR).assertTrue();
              })
            }
          });

          let client: socket.LocalSocket = socket.constructLocalSocketInstance();
          let connectOpt: socket.LocalConnectOptions = {
            address: localAddr,
            timeout: 6000
          };
          await client.connect(connectOpt);
          sleep(1000)
        } catch (err) {
          console.error(`${caseName} fail: ${JSON.stringify(err)}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_LocalSocketConnection_GetSocketFd_0100
     * @tc.name ArKUIX_LocalSocketConnection_GetSocketFd_0100
     * @tc.desc Test the functionality of the getSocketFd interface function
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_LocalSocketConnection_GetSocketFd_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_LocalSocketConnection_GetSocketFd_0100';
        try {
          let server: socket.LocalSocketServer = socket.constructLocalSocketServerInstance();
          const context = AppStorage.get<common.UIAbilityContext>("Context") as common.Context;
          let randomSuffix = Math.random().toString(36).substring(2, 10);
          let sandboxPath: string = context.filesDir + randomSuffix;
          let listenAddr: socket.LocalAddress = {
            address: sandboxPath
          };

          await new Promise<void>((resolve, reject) => {
            server.listen(listenAddr)
              .then(() => {
                console.info('listen success');
                server.on('connect', (connection: socket.LocalSocketConnection) => {
                  connection.getSocketFd()
                    .then((fd: number) => {
                      console.info(`Socket FD：${fd}`);
                      expect(fd != -1).assertTrue();
                      connection.close();
                    })
                    .catch((err: Object) => {
                      console.error(`getSocketFd fail: ${JSON.stringify(err)}`);
                      connection.close();
                      resolve();
                    });
                });
                resolve();
              })
              .catch((err: BusinessError) => {
                console.error(`${caseName} listen failed, error: ${err.code}, ${err.message}`);
                reject(err);
              });
          });

          let client: socket.LocalSocket = socket.constructLocalSocketInstance();
          let connectOpt: socket.LocalConnectOptions = {
            address: listenAddr,
            timeout: 6000
          };
          await client.connect(connectOpt);
          await client.close();
          await server.close();
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      });

  })
}