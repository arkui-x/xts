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

import { describe, it, expect, Level, TestType, Size, beforeEach } from '@ohos/hypium';
import { socket } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { common } from '@kit.AbilityKit';

import deviceInfo from '@ohos.deviceInfo';

let platform: string = deviceInfo.osFullName.split(' ')[0];
let isiOS: boolean = platform.includes("iOS");

const ERR_NET_BAD_FILE_DESCRIPTOR = 2301009;
const ERR_NET_BAD_FILE_DESCRIPTOR_IOS = 2301005;

function sleep(ms: number) {
  return new Promise<ESObject>(resolve => setTimeout(resolve, ms));
}

export default function LocalSocketServerTest() {
  describe('LocalSocketServerTest', () => {
    beforeEach(async () => {
      await sleep(500);
    });

    /**
     * @tc.number ArKUIX_LocalSocketServer_GetLocalAddress_0100
     * @tc.name ArKUIX_LocalSocketServer_GetLocalAddress_0100
     * @tc.desc Test the functionality of the getLocalAddress interface function
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_LocalSocketServer_GetLocalAddress_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_LocalSocketServer_GetLocalAddress_0100';
        try {
          let server: socket.LocalSocketServer = socket.constructLocalSocketServerInstance();
          const context = AppStorage.get<common.UIAbilityContext>("Context") as common.Context;
          let randomSuffix = Math.random().toString(36).substring(2, 10);
          let sandboxPath: string = context.filesDir + '/' + randomSuffix;
          let listenAddr: socket.LocalAddress = {
            address: sandboxPath
          }
          server.listen(listenAddr).then(() => {
            server.getLocalAddress().then((localPath: string) => {
              console.info("getLocalAddress success, localPath: " + JSON.stringify(localPath));
              expect(localPath != null).assertTrue();
              server.close();
            }).catch((err: BusinessError) => {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            })
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          })
        } finally {
          done();
        }
      })

    /**
     * @tc.number ArKUIX_LocalSocketServer_GetLocalAddress_0200
     * @tc.name ArKUIX_LocalSocketServer_GetLocalAddress_0200
     * @tc.desc Test for invalid file descriptors in getLocalAddress
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_LocalSocketServer_GetLocalAddress_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_LocalSocketServer_GetLocalAddress_0200';
        let server: socket.LocalSocketServer;
        try {
          server = socket.constructLocalSocketServerInstance();
          const context = AppStorage.get<common.UIAbilityContext>("Context") as common.Context;
          let randomSuffix = Math.random().toString(36).substring(2, 10);
          let sandboxPath: string = context.filesDir + '/' + randomSuffix;
          console.log(sandboxPath);
          let listenAddr: socket.LocalAddress = {
            address: sandboxPath
          }
          await server.listen(listenAddr);
          console.info("listen success");
          await server.close();
          console.info("server closed, file descriptor becomes invalid");
          try {
            await server.getLocalAddress();
            console.error(`${caseName} failed`);
            expect().assertFail();
          } catch (err) {
            if (isiOS) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_NET_BAD_FILE_DESCRIPTOR_IOS).assertTrue();
            } else {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_NET_BAD_FILE_DESCRIPTOR).assertTrue();
            }
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        } finally {
          done();
        }
      })

    /**
     * @tc.number ArKUIX_LocalSocketServer_Close_0100
     * @tc.name ArKUIX_LocalSocketServer_Close_0100
     * @tc.desc Test the functionality of the close interface function under LocalSocketServer
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_LocalSocketServer_Close_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_LocalSocketServer_Close_0100';
        try {
          let localserver: socket.LocalSocketServer = socket.constructLocalSocketServerInstance();
          const context = AppStorage.get<common.UIAbilityContext>("Context") as common.Context;
          let randomSuffix = Math.random().toString(36).substring(2, 10);
          let sandboxPath: string = context.filesDir + '/' + randomSuffix;

          let addr: socket.LocalAddress = {
            address: sandboxPath
          };
          await localserver.listen(addr).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
            expect().assertFail();
          });

          let closeOperationSuccess = false;
          await localserver.close().then(() => {
            closeOperationSuccess = true;
            expect(closeOperationSuccess).assertTrue();
            console.info(`${caseName} success`);
          }).catch((closeErr: BusinessError) => {
            console.error(`close failed: ${closeErr.code}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        } finally {
          done();
        }
      })

    /**
     * @tc.number ArKUIX_LocalSocketServer_GetSocketFd_0100
     * @tc.name ArKUIX_LocalSocketServer_GetSocketFd_0100
     * @tc.desc Test the functionality of the getSocketFd interface function
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_LocalSocketServer_GetSocketFd_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_LocalSocketServer_GetSocketFd_0100';
        try {
          let server: socket.LocalSocketServer = socket.constructLocalSocketServerInstance();
          const context = AppStorage.get<common.UIAbilityContext>("Context") as common.Context;
          let randomSuffix = Math.random().toString(36).substring(2, 10);
          let sandboxPath: string = context.filesDir + '/' + randomSuffix;

          let listenAddr: socket.LocalAddress = {
            address: sandboxPath
          }
          server.listen(listenAddr).then(() => {
            server.getSocketFd().then((data: number) => {
              console.info("getSocketFd success, Fd: " + JSON.stringify(data));
              expect(data >= 0).assertTrue();
              server.close();
              done();
            }).catch((err: BusinessError) => {
              console.error(`${caseName} getSocketFd failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
              server.close();
              done();
            })
          }).catch((err: BusinessError) => {
            console.error(`${caseName} listen failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
            server.close();
            done();
          })
        } catch (err) {
          console.error(`${caseName} unknown error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

  })
}