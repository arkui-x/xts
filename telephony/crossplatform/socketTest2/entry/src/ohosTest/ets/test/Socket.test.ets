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
import { getNextPort, PortManager, SocketErrorCodes } from './TCPSocketServer.test';

function sleep(ms: number) {
  return new Promise<ESObject>(resolve => setTimeout(resolve, ms));
}

export default function SocketTest() {
  describe('SocketTest', () => {
    beforeEach(async () => {
      await sleep(1000);
    });
    beforeAll(() => {
      PortManager.reset();
    });

    /**
     * @tc.number ArKUIX_Socket_ConstructTCPSocketServerInstance_0100
     * @tc.name ArKUIX_Socket_ConstructTCPSocketServerInstance_0100
     * @tc.desc Function test constructTCPSocketServerInstance interface function
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_Socket_ConstructTCPSocketServerInstance_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_Socket_ConstructTCPSocketServerInstance_0100';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          expect(tcpServer != null).assertTrue();
          console.info(`${caseName} success`);
          tcpServer.close();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_Socket_ConstructTLSSocketInstance_0100
     * @tc.name ArKUIX_Socket_ConstructTLSSocketInstance_0100
     * @tc.desc Function test constructTLSSocketInstance interface function
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_Socket_ConstructTLSSocketInstance_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_Socket_ConstructTLSSocketInstance_0100';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        const port = getNextPort();
        let listenAddr: socket.NetAddress = {
          address: "127.0.0.1",
          port: port,
          family: 1
        }
        let listenAddrSer: socket.NetAddress = {
          address: "0.0.0.0",
          port: port,
          family: 1
        }
        let options: socket.TCPConnectOptions = {
          address: listenAddr,
          timeout: 6000
        }
        try {
          await new Promise<void>((resolve, reject) => {
            tcpServer!.listen(listenAddrSer, (err: BusinessError) => {
              if (err) {
                reject(err);
              } else {
                setTimeout(resolve, 500);
              }
            });
          });
          const connectPromise = new Promise<void>((resolve, reject) => {
            tcpServer!.on('connect', () => {
              try {
                let tls: socket.TLSSocket = socket.constructTLSSocketInstance(tcp!);
                expect(tls != null).assertTrue();
                resolve();
              } catch (err) {
                reject(err);
              }
            });
            setTimeout(() => reject(new Error('connect timeout')), 7000);
          });

          await new Promise<void>((resolve, reject) => {
            tcp!.connect(options, (err: BusinessError) => {
              if (err) {
                reject(err);
              } else {
                setTimeout(resolve, 500);
              }
            });
          });
          await connectPromise;
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        } finally {
          if (tcp) {
            tcp.close();
          }
          if (tcpServer) {
            tcpServer.close();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_Socket_ConstructTLSSocketInstance_0200
     * @tc.name ArKUIX_Socket_ConstructTLSSocketInstance_0200
     * @tc.desc Test tcpSocket to be null
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_Socket_ConstructTLSSocketInstance_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_Socket_ConstructTLSSocketInstance_0200';
        try {
          let tls: socket.TLSSocket = socket.constructTLSSocketInstance(null);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_Socket_ConstructTLSSocketInstance_0300
     * @tc.name ArKUIX_Socket_ConstructTLSSocketInstance_0300
     * @tc.desc Test tcpSocket to be undefined
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_Socket_ConstructTLSSocketInstance_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_Socket_ConstructTLSSocketInstance_0300';
        try {
          let tls: socket.TLSSocket = socket.constructTLSSocketInstance(undefined);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_Socket_ConstructTLSSocketInstance_0400
     * @tc.name ArKUIX_Socket_ConstructTLSSocketInstance_0400
     * @tc.desc Test constructTLSSocketInstance - socket error
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_Socket_ConstructTLSSocketInstance_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_Socket_ConstructTLSSocketInstance_0400';
        try {
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let tls: socket.TLSSocket = socket.constructTLSSocketInstance(tcp);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === SocketErrorCodes.ERR_TCPSOCKET_INVALID_FD).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_Socket_ConstructTLSSocketInstance_0500
     * @tc.name ArKUIX_Socket_ConstructTLSSocketInstance_0500
     * @tc.desc Test constructTLSSocketInstance - the socket is not connected
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_Socket_ConstructTLSSocketInstance_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_Socket_ConstructTLSSocketInstance_0500';
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        const bindAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: getNextPort()
        };
        tcp.bind(bindAddr, (err: BusinessError) => {
          if (err) {
            expect().assertFail();
            return;
          }
          try {
            let tls: socket.TLSSocket = socket.constructTLSSocketInstance(tcp);
            expect().assertFail();
            tcp.close();
            tls.close();
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            const errCode = Number(err.code);
            expect(errCode === SocketErrorCodes.ERR_TCPSOCKET_NOT_CONNECTED).assertTrue();
            tcp.close();
          }
        });
        done();
      })


    /**
     * @tc.number ArKUIX_Socket_ConstructTLSSocketServerInstance_0100
     * @tc.name ArKUIX_Socket_ConstructTLSSocketServerInstance_0100
     * @tc.desc Function test constructTLSSocketServerInstance interface function
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_Socket_ConstructTLSSocketServerInstance_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_Socket_ConstructTLSSocketServerInstance_0100';
        try {
          let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
          expect(tlsServer != null).assertTrue();
          console.info(`${caseName} success`);
          tlsServer.close();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

  })
}