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
import { serverKey, serverCert, serverCa, clientKey, clientCert, clientCa, getNextPort, PortManager, SocketErrorCodes, sleep, netAddress, PlatformDetector} from './public_util'

const tlsSecureConfig: socket.TLSSecureOptions = {
  key: serverKey,
  cert: serverCert,
  ca: [serverCa],
  password: '88888888',
  protocols: [socket.Protocol.TLSv12],
  useRemoteCipherPrefer: true,
  signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
  cipherSuite: "AES256-SHA256",
};

const tlsConnectOptions: socket.TLSConnectOptions = {
  address: netAddress,
  secureOptions: tlsSecureConfig,
  ALPNProtocols: ["spdy/1", "http/1.1"],
};

const TlsClientOptions: socket.TLSSecureOptions = {
  key: clientKey,
  cert: clientCert,
  ca: [clientCa],
  password: '88888888',
  protocols: [socket.Protocol.TLSv12],
  useRemoteCipherPrefer: true,
  signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
  cipherSuite: "AES256-SHA256",
};

const connectAddr: socket.NetAddress = {
  address: '127.0.0.1',
  port: 8080
};

const connectOptions: socket.TLSConnectOptions = {
  address: connectAddr,
  secureOptions: TlsClientOptions,
  ALPNProtocols: ["spdy/1", "http/1.1"],
  skipRemoteValidation: true
};

export default function TLSSocketServerTest2() {
  describe('TLSSocketServerTest2', () => {
    beforeEach(async () => {
      await sleep(500);
    });
    beforeAll(() => {
      PortManager.reset();
    });

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_0400
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_0400
     * @tc.desc Test Options to undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_0400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        try {
          await tlsServer.setExtraOptions(null, (err: BusinessError) => {
            expect().assertFail();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_0500
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_0500
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_0500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions);
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, undefined);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_0600
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_0600
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_0600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions);
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, null);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_0700
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_0700
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_0700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done()
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_0800
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_0800
     * @tc.desc Test Options to null and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_0800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(null).then(() => {
            expect().assertFail();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_0900
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_0900
     * @tc.desc Test Options to undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_0900';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(undefined).then(() => {
            expect().assertFail();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_1000
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_1000
     * @tc.desc Test and modify keepAlive,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_1000';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: true,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              expect(err == null).assertTrue();
            }

          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_1100
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_1100
     * @tc.desc Test and modify keepAlive,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_1100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              expect(err == null).assertTrue();
            }

          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_1200
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_1200
     * @tc.desc Test after modifying OOBInline,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_1200';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: true,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              expect(err == null).assertTrue();
            }

          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_1300
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_1300
     * @tc.desc Test after modifying OOBInline,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_1300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: true,
          OOBInline: false,
          TCPNoDelay: true,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              expect(err == null).assertTrue();
            }

          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_1400
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_1400
     * @tc.desc Test and modify TCPNoDelay,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_1400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: true,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              expect(err == null).assertTrue();
            }

          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_1500
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_1500
     * @tc.desc Test and modify TCPNoDelay,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_1500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              expect(err == null).assertTrue();
            }

          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_1600
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_1600
     * @tc.desc Test and modify socketLinger,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_1600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 100
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              expect(err == null).assertTrue();
            }

          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_1700
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_1700
     * @tc.desc Test and modify keepAlive,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_1700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        };

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        await tlsServer.listen(listenOptions);
        const tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: undefined,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: { on: true, linger: 10 } as SocketLinger,
          receiveBufferSize: -100,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };

        try {
          tlsServer.setExtraOptions(tcpExtraOptions, async () => {
          });
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName}: err.code = ${err.code}, msg = ${err.message}`);
          expect(err.code == undefined).assertTrue();
          tlsServer.close()
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_1800
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_1800
     * @tc.desc Test after modifying OOBInline,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_1800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_1800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: undefined,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        try {
          tlsServer.setExtraOptions(tcpExtraOptions, () => {
          });
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName}: err.code = ${err.code}, msg = ${err.message}`);
          expect(err.code == undefined).assertTrue();
          tlsServer.close()
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_1900
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_1900
     * @tc.desc Test and modify socketLinger,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_1900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_1900';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: false, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: undefined
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              expect(err == null).assertTrue();
            }

          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_2000
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_2000
     * @tc.desc Test and modify TCPNoDelay,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_2000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_2000';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: undefined,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        try {
          tlsServer.setExtraOptions(tcpExtraOptions, () => {
          });
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName}: err.code = ${err.code}, msg = ${err.message}`);
          expect(err.code == undefined).assertTrue();
          tlsServer.close()
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_2100
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_2100
     * @tc.desc Test and modify socketLinger,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_2100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_2100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: -1
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              expect(err == null).assertTrue();
            }
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_2200
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_2200
     * @tc.desc Test and modify socketLinger,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_2200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_2200';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 65536
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              expect(err == null).assertTrue();
            }
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_2300
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_2300
     * @tc.desc Test and modify socketLinger,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_2300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_2300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: undefined,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          tlsServer.setExtraOptions(tcpExtraOptions, () => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          });
        } catch (err) {
          console.error(`${caseName}: err.code = ${err.code}, msg = ${err.message}`);
          expect().assertFail();
          tlsServer.close()
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_2400
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_2400
     * @tc.desc Test after modifying keepAlive,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_2400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_2400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: true,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_2500
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_2500
     * @tc.desc Test after modifying keepAlive,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_2500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_2500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_2600
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_2600
     * @tc.desc Test after modifying OOBInline,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_2600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_2600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: true,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_2700
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_2700
     * @tc.desc Test after modifying OOBInline,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_2700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_2700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_2800
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_2800
     * @tc.desc Test and modify TCPNoDelay,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_2800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_2800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: true,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_2900
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_2900
     * @tc.desc Test and modify TCPNoDelay,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_2900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_2900';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_3000
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_3000
     * @tc.desc Test and modify socketLinger,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_3000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_3000';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 100
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_3100
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_3100
     * @tc.desc Test after modifying keepAlive,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_3100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_3100';

        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        };

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        await tlsServer.listen(listenOptions);
        const tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: undefined,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: { on: true, linger: 10 } as SocketLinger,
          receiveBufferSize: -100,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName}: err.code = ${err.code}, msg = ${err.message}`);
          expect(err.code == undefined).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_3200
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_3200
     * @tc.desc Test after modifying OOBInline,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_3200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_3200';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: undefined,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName}: err.code = ${err.code}, msg = ${err.message}`);
          expect(err.code == undefined).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_3300
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_3300
     * @tc.desc Test and modify TCPNoDelay,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_3300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_3300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: undefined,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName}: err.code = ${err.code}, msg = ${err.message}`);
          expect(err.code == undefined).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_3400
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_3400
     * @tc.desc Test and modify socketLinger,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_3400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_3400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: -1
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_3500
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_3500
     * @tc.desc Test and modify socketLinger,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_3500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_3500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 65536
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_3600
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_3600
     * @tc.desc Test and modify socketLinger,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_3600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_3600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: undefined,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions);
          setExtraOptions = true;
          expect(setExtraOptions).assertTrue();
        } catch (err) {
          console.error(`${caseName}: err.code = ${err.code}, msg = ${err.message}`);
          expect().assertFail();
          done();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_3700
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_3700
     * @tc.desc Test and modify socketLinger,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_3700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_3700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: false, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 3000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_3800
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_3800
     * @tc.desc Test and modify socketimeout,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_3800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_3800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 0
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_3900
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_3900
     * @tc.desc Test and modify reuseAddress,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_3900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_3900';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: false,
          OOBInline: false,
          TCPNoDelay: false,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 0
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        let setExtraOptions = false;
        try {
          await tlsServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetState_0100
     * @tc.name ArKUIX_TLSSocketServer_GetState_0100
     * @tc.desc After the listen of TLSSocketServer is successful, get the TLSSocketServer status,
     * Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetState_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetState_0100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.getState((err: BusinessError, data: socket.SocketStateBase) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              console.info(`${caseName} state:`, JSON.stringify(data));
              expect(data != null).assertTrue();
            }
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetState_0200
     * @tc.name ArKUIX_TLSSocketServer_GetState_0200
     * @tc.desc Test the functionality of the GetState interface using the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetState_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetState_0200';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.getState().then((data: socket.SocketStateBase) => {
            console.info(`${caseName} state:`, JSON.stringify(data));
            expect(data != null).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetState_0300
     * @tc.name ArKUIX_TLSSocketServer_GetState_0300
     * @tc.desc The test callback parameter type is incorrect
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetState_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetState_0300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        try {
          await tlsServer.getState(undefined);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code},${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetState_0400
     * @tc.name ArKUIX_TLSSocketServer_GetState_0400
     * @tc.desc The test callback parameter type is incorrect
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetState_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetState_0400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        try {
          await tlsServer.getState(null);
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code},${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetState_0500
     * @tc.name ArKUIX_TLSSocketServer_GetState_0500
     * @tc.desc The test did not pass in the callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetState_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetState_0500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        try {
          const data: socket.SocketStateBase = await tlsServer.getState();
          console.info(`${caseName} state:`, JSON.stringify(data));
          expect(data != null).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error:${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetState_0600
     * @tc.name ArKUIX_TLSSocketServer_GetState_0600
     * @tc.desc Get link status when key is empty,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetState_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetState_0600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const tlsSecureConfigWithoutkey: socket.TLSSecureOptions = {
          key: '',
          cert: tlsSecureConfig.cert,
          ca: tlsSecureConfig.ca,
          password: tlsSecureConfig.password,
          protocols: tlsSecureConfig.protocols,
          useRemoteCipherPrefer: tlsSecureConfig.useRemoteCipherPrefer,
          signatureAlgorithms: tlsSecureConfig.signatureAlgorithms,
          cipherSuite: tlsSecureConfig.cipherSuite
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfigWithoutkey,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.getState((err: BusinessError, data: socket.SocketStateBase) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              console.info(`${caseName} state:`, JSON.stringify(data));
              expect(data != null).assertTrue();
            }
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetState_0700
     * @tc.name ArKUIX_TLSSocketServer_GetState_0700
     * @tc.desc Get additional ip link status,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetState_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetState_0700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '127.0.0.1', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        try {
          tlsServer.getState((err: BusinessError, data: socket.SocketStateBase) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              console.info(`${caseName} state:`, JSON.stringify(data));
              expect(data != null).assertTrue();
            }
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetState_0800
     * @tc.name ArKUIX_TLSSocketServer_GetState_0800
     * @tc.desc Get TLSSocketServer link status (onconnect),Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetState_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetState_0800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.getState().then((data: socket.SocketStateBase) => {
            console.info(`${caseName} state:`, JSON.stringify(data));
            expect(data != null).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          tlsServer.on('connect', (data: socket.TLSSocketConnection) => {
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetState_0900
     * @tc.name ArKUIX_TLSSocketServer_GetState_0900
     * @tc.desc Get TLSSocketServer link status (ca is empty),Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetState_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetState_0900';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const tlsSecureConfigWithoutca: socket.TLSSecureOptions = {
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          ca: [],
          password: tlsSecureConfig.password,
          protocols: tlsSecureConfig.protocols,
          useRemoteCipherPrefer: tlsSecureConfig.useRemoteCipherPrefer,
          signatureAlgorithms: tlsSecureConfig.signatureAlgorithms,
          cipherSuite: tlsSecureConfig.cipherSuite
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfigWithoutca,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        try {
          await tlsServer.getState().then((data: socket.SocketStateBase) => {
            console.info(`${caseName} state:`, JSON.stringify(data));
            expect(data != null).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetState_1000
     * @tc.name ArKUIX_TLSSocketServer_GetState_1000
     * @tc.desc Get TLSSocketServer link status (listen is not set),Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetState_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetState_1000';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        try {
          await tlsServer.getState().then((data: socket.SocketStateBase) => {
            console.info(`${caseName} state:`, JSON.stringify(data));
            expect(data != null).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Close_0100
     * @tc.name ArKUIX_TLSSocketServer_Close_0100
     * @tc.desc Test the functionality of the close interface function
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Close_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Close_0100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        let close = false;
        try {
          await tlsServer.close().then(() => {
            console.info(`close success`);
            close = true;
            expect(close).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error(`close fail,code=${err.code}，message=${err.message}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Close_0300
     * @tc.name ArKUIX_TLSSocketServer_Close_0300
     * @tc.desc Call close after testing listen multiple times
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Close_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Close_0300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const port = getNextPort();
        const listenOptions_1: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: port } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        const listenOptions_2: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: port } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions_1).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        await tlsServer.listen(listenOptions_2).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
        });
        let close = false;
        try {
          await tlsServer.close().then(() => {
            console.info(`close success`);
            close = true;
            expect(close).assertTrue();
            done();
          }).catch((err: BusinessError) => {
            console.error(`close fail,code=${err.code}，message=${err.message}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_0100
     * @tc.name ArKUIX_TLSSocketServer_Listen_0100
     * @tc.desc Test the normal scenario of the listen function and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_0100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_0200
     * @tc.name ArKUIX_TLSSocketServer_Listen_0200
     * @tc.desc Test the normal scenario of the listen function and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_0200';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_0300
     * @tc.name ArKUIX_TLSSocketServer_Listen_0300
     * @tc.desc Test Options to null and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_0300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        try {
          await tlsServer.listen(null, (err: BusinessError) => {
            expect().assertFail();
            done();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_0400
     * @tc.name ArKUIX_TLSSocketServer_Listen_0400
     * @tc.desc Test Options to undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_0400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        try {
          await tlsServer.listen(undefined, (err: BusinessError) => {
            expect().assertFail();
            done();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_0500
     * @tc.name ArKUIX_TLSSocketServer_Listen_0500
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_0500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        try {
          await tlsServer.listen(listenOptions, undefined);
          expect().assertFail();
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_0600
     * @tc.name ArKUIX_TLSSocketServer_Listen_0600
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_0600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        try {
          await tlsServer.listen(listenOptions, null);
          expect().assertFail();
          done();
        } catch (err) {
          console.error(`${caseName} failed, error:  ${err.code} ${err.message}`);
          const errCode = Number(err.code)
          expect(errCode == SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_0700
     * @tc.name ArKUIX_TLSSocketServer_Listen_0700
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_0700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_0800
     * @tc.name ArKUIX_TLSSocketServer_Listen_0800
     * @tc.desc Test Options to null and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_0800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        try {
          await tlsServer.listen(null).then(() => {
            expect().assertFail();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code)
          expect(errCode == SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_0900
     * @tc.name ArKUIX_TLSSocketServer_Listen_0900
     * @tc.desc Test Options to undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_0900';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        try {
          await tlsServer.listen(undefined).then(() => {
            expect().assertFail();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code)
          expect(errCode == SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_1000
     * @tc.name ArKUIX_TLSSocketServer_Listen_1000
     * @tc.desc The test address is "", and the callback asynchronous callback method is used
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_1000';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        const invalidNetAddress: socket.NetAddress = {
          address: "",
          port: getNextPort(),
          family: 1
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: invalidNetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: false,
          timeout: undefined,
        };

        let listen = false;
        try {
          await new Promise<void>((resolve, reject) => {
            tlsServer.listen(listenOptions, (err: BusinessError) => {
              if (err) {
                console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
                done();
                if (PlatformDetector.isAndroid()) {
                  expect().assertFail();
                } else {
                  const errCode = Number(err.code);
                  expect(errCode === 2303197 || errCode === 2303105).assertTrue();
                }
                reject(err);
              } else {
                listen = true;
                expect(listen).assertTrue();
                resolve();
              }
            });
          });
          done();
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
          if (PlatformDetector.isAndroid()) {
            expect().assertFail();
          } else {
            const errCode = Number(error.code);
            expect(errCode === 2303197 || errCode === 2303105).assertTrue();
          }
          done();
        }
        setTimeout(() => {
          tlsServer.close();
        }, 100);
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_1100
     * @tc.name ArKUIX_TLSSocketServer_Listen_1100
     * @tc.desc The test address is "11111", and the callback asynchronous callback method is used
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_1100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidNetAddress: socket.NetAddress = {
          address: "11111",
          port: getNextPort(),
          family: 1
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: invalidNetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: false,
          timeout: undefined,
        };
        tlsServer.listen(listenOptions, (err: BusinessError) => {
          if (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            const errCode = Number(err.code);
            expect(errCode === SocketErrorCodes.ERR_REQUEST_ADDRESS_ERROR || errCode === SocketErrorCodes.ERR_EIO)
              .assertTrue();
            tlsServer?.close();
            done();
          } else {
            expect().assertFail();
            done();
          }
        })
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_1200
     * @tc.name ArKUIX_TLSSocketServer_Listen_1200
     * @tc.desc When the test port is undefined, use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_1200';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidNetAddress: socket.NetAddress = {
          address: "127.0.0.1",
          port: undefined,
          family: 1
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: invalidNetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: false,
          timeout: undefined,
        };
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_1300
     * @tc.name ArKUIX_TLSSocketServer_Listen_1300
     * @tc.desc To test that family is undefined, use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_1300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidNetAddress: socket.NetAddress = {
          address: "127.0.0.1",
          port: getNextPort(),
          family: undefined
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: invalidNetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: false,
          timeout: undefined,
        };
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_1400
     * @tc.name ArKUIX_TLSSocketServer_Listen_1400
     * @tc.desc The test address is "", and the promise asynchronous callback method is used
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_1400';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        const invalidNetAddress: socket.NetAddress = {
          address: "",
          port: getNextPort(),
          family: 1
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: invalidNetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: false,
          timeout: undefined,
        };
        let listen = false;
        try {
          await new Promise<void>((resolve, reject) => {
            tlsServer.listen(listenOptions).then(() => {
              listen = true;
              expect(listen).assertTrue();
              resolve();
            }).catch((err: BusinessError) => {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              done();
              if (PlatformDetector.isAndroid()) {
                expect().assertFail();
              } else {
                const errCode = Number(err.code);
                expect(errCode === 2303197 || errCode === 2303105).assertTrue();
              }
              reject(err);
            });
          });
          done();
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
          if (PlatformDetector.isAndroid()) {
            expect().assertFail();
          } else {
            const errCode = Number(error.code);
            expect(errCode === 2303197 || errCode === 2303105).assertTrue();
          }
          done();
        }
        setTimeout(() => {
          tlsServer.close();
        }, 100);
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_1500
     * @tc.name ArKUIX_TLSSocketServer_Listen_1500
     * @tc.desc The test address is "11111", and the promise asynchronous callback method is used
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_1500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        const invalidNetAddress: socket.NetAddress = {
          address: "11111",
          port: getNextPort(),
          family: 1
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: invalidNetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: false,
          timeout: undefined,
        };
        tlsServer.listen(listenOptions).then(() => {
          expect().assertFail();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === SocketErrorCodes.ERR_REQUEST_ADDRESS_ERROR || errCode === SocketErrorCodes.ERR_EIO)
            .assertTrue();
          done();
        }).finally(() => {
          if (tlsServer) {
            tlsServer.close();
          }
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_1600
     * @tc.name ArKUIX_TLSSocketServer_Listen_1600
     * @tc.desc Test port as undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_1600';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        const invalidNetAddress: socket.NetAddress = {
          address: "0.0.0.0",
          port: undefined,
          family: 1
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: invalidNetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: false,
          timeout: undefined,
        };

        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_1700
     * @tc.name ArKUIX_TLSSocketServer_Listen_1700
     * @tc.desc To test that family is undefined, use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_1700';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        const invalidNetAddress: socket.NetAddress = {
          address: "0.0.0.0",
          port: getNextPort(),
          family: undefined
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: invalidNetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: false,
          timeout: undefined,
        };
        let listen = false;
        tlsServer.listen(listenOptions).then(() => {
          listen = true;
          expect(listen).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_1800
     * @tc.name ArKUIX_TLSSocketServer_Listen_1800
     * @tc.desc When the test ca is undefined, use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_1800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_1800';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: undefined,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_1900
     * @tc.name ArKUIX_TLSSocketServer_Listen_1900
     * @tc.desc Test ca as undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_1900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_1900';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: undefined,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        };
        let listen = false;
        tlsServer.listen(listenOptions).then(() => {
          listen = true;
          expect(listen).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_2000
     * @tc.name ArKUIX_TLSSocketServer_Listen_2000
     * @tc.desc Test that cert is undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_2000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_2000';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.key,
          key: tlsSecureConfig.key,
          cert: undefined,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_2100
     * @tc.name ArKUIX_TLSSocketServer_Listen_2100
     * @tc.desc Test that cert is undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_2100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_2100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: undefined,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        };
        let listen = false;
        tlsServer.listen(listenOptions).then(() => {
          listen = true;
          expect(listen).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_2200
     * @tc.name ArKUIX_TLSSocketServer_Listen_2200
     * @tc.desc Test that key is undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_2200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_2200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: undefined,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_2300
     * @tc.name ArKUIX_TLSSocketServer_Listen_2300
     * @tc.desc Test that key is undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_2300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_2300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: undefined,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        };
        let listen = false;
        tlsServer.listen(listenOptions).then(() => {
          listen = true;
          expect(listen).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_2400
     * @tc.name ArKUIX_TLSSocketServer_Listen_2400
     * @tc.desc Test that password is undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_2400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_2400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: undefined,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_2500
     * @tc.name ArKUIX_TLSSocketServer_Listen_2500
     * @tc.desc Test that password is undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_2500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_2500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: undefined,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        };
        let listen = false;
        tlsServer.listen(listenOptions).then(() => {
          listen = true;
          expect(listen).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_2600
     * @tc.name ArKUIX_TLSSocketServer_Listen_2600
     * @tc.desc Test protocols is TLSv12 using the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_2600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_2600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_2700
     * @tc.name ArKUIX_TLSSocketServer_Listen_2700
     * @tc.desc Test protocols is TLSv13 using the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_2700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_2700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv13,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_2800
     * @tc.name ArKUIX_TLSSocketServer_Listen_2800
     * @tc.desc Test protocol is undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_2800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_2800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: undefined,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_2900
     * @tc.name ArKUIX_TLSSocketServer_Listen_2900
     * @tc.desc The test protocols are TLSv12, and the promise asynchronous callback method is used
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_2900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_2900';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        };
        let listen = false;
        tlsServer.listen(listenOptions).then(() => {
          listen = true;
          expect(listen).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_3000
     * @tc.name ArKUIX_TLSSocketServer_Listen_3000
     * @tc.desc The test protocols are TLSv13, and the promise asynchronous callback method is used
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_3000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_3000';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv13,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        };
        let listen = false;
        tlsServer.listen(listenOptions).then(() => {
          listen = true;
          expect(listen).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_3100
     * @tc.name ArKUIX_TLSSocketServer_Listen_3100
     * @tc.desc Test protocols as undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_3100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_3100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: undefined,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        };
        let listen = false;
        tlsServer.listen(listenOptions).then(() => {
          listen = true;
          expect(listen).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_3200
     * @tc.name ArKUIX_TLSSocketServer_Listen_3200
     * @tc.desc Test that useRemoteCipherPrefer is true and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_3200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_3200';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_3300
     * @tc.name ArKUIX_TLSSocketServer_Listen_3300
     * @tc.desc Test that useRemoteCipherPrefer is false and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_3300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_3300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: false,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_3400
     * @tc.name ArKUIX_TLSSocketServer_Listen_3400
     * @tc.desc Test that useRemoteCipherPrefer is undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_3400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_3400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: undefined,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
          })
          expect().assertFail();
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect(err.code === undefined).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_3500
     * @tc.name ArKUIX_TLSSocketServer_Listen_3500
     * @tc.desc Test that useRemoteCipherPrefer is true and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_3500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_3500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        };
        let listen = false;
        tlsServer.listen(listenOptions).then(() => {
          listen = true;
          expect(listen).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_3600
     * @tc.name ArKUIX_TLSSocketServer_Listen_3600
     * @tc.desc Test that useRemoteCipherPrefer is false and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_3600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_3600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: false,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        };
        let listen = false;
        tlsServer.listen(listenOptions).then(() => {
          listen = true;
          expect(listen).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_3700
     * @tc.name ArKUIX_TLSSocketServer_Listen_3700
     * @tc.desc Test that useRemoteCipherPrefer is undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_3700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_3700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: undefined,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }
        try {
          await tlsServer.listen(listenOptions).then(() => {
            expect().assertFail();
            done();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect(err.code === undefined).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_3800
     * @tc.name ArKUIX_TLSSocketServer_Listen_3800
     * @tc.desc Test that signatureAlgorithms is undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_3800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_3800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: undefined,
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_3900
     * @tc.name ArKUIX_TLSSocketServer_Listen_3900
     * @tc.desc Test that signatureAlgorithms is undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_3900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_3900';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: undefined,
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        };
        let listen = false;
        tlsServer.listen(listenOptions).then(() => {
          listen = true;
          expect(listen).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_4000
     * @tc.name ArKUIX_TLSSocketServer_Listen_4000
     * @tc.desc Test that cipherSuite is undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_4000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_4000';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: undefined,
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_4100
     * @tc.name ArKUIX_TLSSocketServer_Listen_4100
     * @tc.desc Test that cipherSuite is undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_4100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_4100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: undefined,
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        };
        let listen = false;
        tlsServer.listen(listenOptions).then(() => {
          listen = true;
          expect(listen).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_4200
     * @tc.name ArKUIX_TLSSocketServer_Listen_4200
     * @tc.desc Test the two-way authentication as true and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_4200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_4200';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: true
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_4300
     * @tc.name ArKUIX_TLSSocketServer_Listen_4300
     * @tc.desc Test the two-way authentication as false and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_4300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_4300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_4400
     * @tc.name ArKUIX_TLSSocketServer_Listen_4400
     * @tc.desc Test the two-way authentication as undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_4400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_4400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: undefined
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
          })
          expect().assertFail();
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect(err.code == undefined).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_4500
     * @tc.name ArKUIX_TLSSocketServer_Listen_4500
     * @tc.desc Test the two-way authentication as true and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_4500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_4500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: true
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        };
        let listen = false;
        tlsServer.listen(listenOptions).then(() => {
          listen = true;
          expect(listen).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_4600
     * @tc.name ArKUIX_TLSSocketServer_Listen_4600
     * @tc.desc Test the two-way authentication as false and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_4600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_4600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        };
        let listen = false;
        tlsServer.listen(listenOptions).then(() => {
          listen = true;
          expect(listen).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_4700
     * @tc.name ArKUIX_TLSSocketServer_Listen_4700
     * @tc.desc Test the two-way authentication as undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_4700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_4700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: undefined
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
        }
        try {
          await tlsServer.listen(listenOptions).then(() => {
            expect().assertFail();
            done();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect(err.code == undefined).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_4800
     * @tc.name ArKUIX_TLSSocketServer_Listen_4800
     * @tc.desc Test that ALPNProtocols is undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_4800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_4800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: undefined,
        }
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
          })
          expect().assertFail();
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect(err.code === undefined).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_4900
     * @tc.name ArKUIX_TLSSocketServer_Listen_4900
     * @tc.desc Test that ALPNProtocols is undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_4900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_4900';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: undefined,
        }
        try {
          await tlsServer.listen(listenOptions).then(() => {
            expect().assertFail();
            done();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          expect(err.code === undefined).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_5000
     * @tc.name ArKUIX_TLSSocketServer_Listen_5000
     * @tc.desc Test that skipRemoteValidation is true and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_5000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_5000';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true,
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_5100
     * @tc.name ArKUIX_TLSSocketServer_Listen_5100
     * @tc.desc Test that skipRemoteValidation is false and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_5100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_5100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: false,
        }
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_5200
     * @tc.name ArKUIX_TLSSocketServer_Listen_5200
     * @tc.desc Test that skipRemoteValidation is undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_5200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_5200';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: undefined
        }
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
          })
          expect().assertFail();
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect(err.code === undefined).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_5300
     * @tc.name ArKUIX_TLSSocketServer_Listen_5300
     * @tc.desc Test that skipRemoteValidation is true and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_5300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_5300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: true
        };
        let listen = false;
        tlsServer.listen(listenOptions).then(() => {
          listen = true;
          expect(listen).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_5400
     * @tc.name ArKUIX_TLSSocketServer_Listen_5400
     * @tc.desc Test that skipRemoteValidation is false and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_5400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_5400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: false
        };
        let listen = false;
        tlsServer.listen(listenOptions).then(() => {
          listen = true;
          expect(listen).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_5500
     * @tc.name ArKUIX_TLSSocketServer_Listen_5500
     * @tc.desc Test that skipRemoteValidation is undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_5500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_5500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          skipRemoteValidation: undefined
        }
        try {
          await tlsServer.listen(listenOptions).then(() => {
            expect().assertFail();
            done();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          expect(err.code === undefined).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_5600
     * @tc.name ArKUIX_TLSSocketServer_Listen_5600
     * @tc.desc Test the timeout to be 1000(a valid value) and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_5600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_5600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          timeout: 1000
        };
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_Listen_5700
     * @tc.name ArKUIX_TLSSocketServer_Listen_5700
     * @tc.desc Test timeout to -1(illegal value) and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_Listen_5700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_Listen_5700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const invalidSecureOptions: socket.TLSSecureOptions = {
          ca: tlsSecureConfig.ca,
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          password: tlsSecureConfig.password,
          protocols: socket.Protocol.TLSv12,
          useRemoteCipherPrefer: true,
          signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
          cipherSuite: "AES256-SHA256",
          isBidirectionalAuthentication: false
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: invalidSecureOptions,
          ALPNProtocols: ["http/1.1"],
          timeout: -1
        };
        let listen = false;
        try {
          await tlsServer.listen(listenOptions, (err: BusinessError) => {
            if (err) {
              expect().assertFail();
              done();
            }
            listen = true;
            expect(listen).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })
  })
}