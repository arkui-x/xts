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

import { describe, it, expect, Level, TestType, Size, beforeEach, beforeAll } from '@ohos/hypium';
import { socket } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { common } from '@kit.AbilityKit';
import { getNextPort, PortManager, SocketErrorCodes } from './TCPSocketServer.test';

function sleep(ms:number) {
  return new Promise<ESObject>(resolve => setTimeout(resolve, ms));
}

export default function UdpSocketTest() {
  describe('UdpSocketTest', () => {
    beforeEach(async () => {
      await sleep(500);
    });
    beforeAll(() => {
      PortManager.reset();
    });

    /**
     * @tc.number ArKUIX_UDPSocket_GetLocalAddress_0100
     * @tc.name ArKUIX_UDPSocket_GetLocalAddress_0100
     * @tc.desc Test the functionality of the getLocalAddress interface function
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_UDPSocket_GetLocalAddress_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_UDPSocket_GetLocalAddress_0100';
        let udp: socket.UDPSocket = socket.constructUDPSocketInstance();
        let bindAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: getNextPort()
        }

        await udp.bind(bindAddr).then(async () => {
          await udp.getLocalAddress().then((localAddress: socket.NetAddress) => {
            console.info(`${caseName} success`);
            expect(localAddress != null).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          })
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }).finally(() => {
          udp.close();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_UDPSocket_GetLocalAddress_0200
     * @tc.name ArKUIX_UDPSocket_GetLocalAddress_0200
     * @tc.desc Test for invalid file descriptors in getLocalAddress
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_UDPSocket_GetLocalAddress_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName = 'ArKUIX_UDPSocket_GetLocalAddress_0200';
        let udp: socket.UDPSocket;
        try {
          udp = socket.constructUDPSocketInstance();
          await udp.bind({
            address: '0.0.0.0',
            port: getNextPort()
          });
          await udp.close();
          try {
            await udp.getLocalAddress();
            console.error(`${caseName} failed`);
            expect().assertFail();
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            const errCode = Number(err.code);
            expect(errCode === SocketErrorCodes.ERR_NET_BAD_FILE_DESCRIPTOR).assertTrue();
          }
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArKUIX_UDPSocket_GetSocketFd_0100
     * @tc.name ArKUIX_UDPSocket_GetSocketFd_0100
     * @tc.desc Test the functionality of the getSocketFd interface function
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_UDPSocket_GetSocketFd_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_UDPSocket_GetSocketFd_0100';
        let udp: socket.UDPSocket = socket.constructUDPSocketInstance();
        let bindAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: getNextPort()
        }
        await udp.bind(bindAddr).then(async () => {
          await udp.getSocketFd().then((fd: number) => {
            console.info(`${caseName} success`);
            expect(fd >= 0).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          })
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }).finally(() => {
          udp.close();
          done();
        });
      })
  })
}