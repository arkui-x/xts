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

export default function TLSSocketServerTest1() {
  describe('TLSSocketServerTest1', () => {
    beforeEach(async () => {
      await sleep(500);
    });
    beforeAll(() => {
      PortManager.reset();
    });

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetLocalAddress_0100
     * @tc.name ArKUIX_TLSSocketServer_GetLocalAddress_0100
     * @tc.desc Test the functionality of the getLocalAddress interface function
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetLocalAddress_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetLocalAddress_0100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        await tlsServer.getLocalAddress().then((localAddress: socket.NetAddress) => {
          console.info("Get success: " + JSON.stringify(localAddress));
          expect(localAddress != null).assertTrue();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        })
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetSocketFd_0100
     * @tc.name ArKUIX_TLSSocketServer_GetSocketFd_0100
     * @tc.desc Test the functionality of the getSocketFd interface function
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetSocketFd_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetSocketFd_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        const netAddress: socket.NetAddress = {
          address: '0.0.0.0',
          port: getNextPort()
        };
        const tlsConnectOptions: socket.TLSConnectOptions = {
          address: netAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["spdy/1", "http/1.1"],
        };
        await tlsServer.listen(tlsConnectOptions);
        try {
          tlsServer.getSocketFd().then((data: number) => {
            console.info("Get success: " + JSON.stringify(data));
            expect(data >= 0).assertTrue();
            tlsServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error1: ${err.code}, ${err.message}`);
            expect().assertFail();
            tlsServer.close();
          })
        } catch (err) {
          console.error(`${caseName} failed, error2: ${err.code}, ${err.message}`);
          expect().assertFail();
          tlsServer.close();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetProtocol_0100
     * @tc.name ArKUIX_TLSSocketServer_GetProtocol_0100
     * @tc.desc Get the communication protocol version,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetProtocol_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetProtocol_0100';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        await tlsServer.getProtocol((err: BusinessError, data: string) => {
          try {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              console.info(`${caseName} getProtocol result: ${data}`);
              expect(data == 'TLSv1.2').assertTrue();
            }
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
          ;
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetProtocol_0200
     * @tc.name ArKUIX_TLSSocketServer_GetProtocol_0200
     * @tc.desc Get the communication protocol version,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetProtocol_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetProtocol_0200';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        await tlsServer.getProtocol().then((protocol: string) => {
          console.info(`${caseName} getProtocol result: ${protocol}`);
          expect(protocol == 'TLSv1.2').assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        })
      });


    /**
     * @tc.number ArKUIX_TLSSocketServer_GetProtocol_0300
     * @tc.name ArKUIX_TLSSocketServer_GetProtocol_0300
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetProtocol_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetProtocol_0300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        try {
          await tlsServer.getProtocol(undefined);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
        }
        done();
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetProtocol_0400
     * @tc.name ArKUIX_TLSSocketServer_GetProtocol_0400
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetProtocol_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetProtocol_0400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        try {
          await tlsServer.getProtocol(null);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
        }
        done();
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetProtocol_0500
     * @tc.name ArKUIX_TLSSocketServer_GetProtocol_0500
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetProtocol_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetProtocol_0500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        try {
          const getProtocol: string = await tlsServer.getProtocol();
          console.info(`${caseName} getProtocol result: ${getProtocol}`);
          expect(getProtocol == 'TLSv1.2').assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      });

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetProtocol_0600
     * @tc.name ArKUIX_TLSSocketServer_GetProtocol_0600
     * @tc.desc Verify that other ip can obtain the protocol version successfully,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetProtocol_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetProtocol_0600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '127.1.1.1333', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        };
        await tlsServer.listen(listenOptions).then(() => {
          console.info("listen callback success");
          (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              try {
                tlsServer?.getProtocol((err: BusinessError, data: string) => {
                  if (PlatformDetector.isIOS() && err.code === 2303105) {
                    expect().assertTrue();
                    return;
                  }
                  if (err) {
                    console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
                    expect().assertFail();
                    done();
                  } else {
                    console.info(`${caseName} getProtocol result: ${data}`);
                    expect(data == 'TLSv1.2').assertTrue();
                    done();
                  }
                }
                )
              } catch (err) {
                console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
                expect().assertFail();
                done();
              }
            });
          })().then(async () => {
            console.info(`${caseName} success: got expected error code ${SocketErrorCodes.ERR_NET_BAD_FILE_DESCRIPTOR}`);
          }).catch((err: BusinessError) => {
            console.error(`${caseName} fail:` + JSON.stringify(err));
            expect().assertFail();
            done();
          });
        }).catch((err: BusinessError) => {
          console.error("failed: " + JSON.stringify(err));
        });
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetProtocol_0700
     * @tc.name ArKUIX_TLSSocketServer_GetProtocol_0700
     * @tc.desc Do not configure the protocol version,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetProtocol_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetProtocol_0700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const tlsSecureConfigWithoutProtocol: socket.TLSSecureOptions = {
          key: tlsSecureConfig.key,
          cert: tlsSecureConfig.cert,
          ca: tlsSecureConfig.ca,
          password: tlsSecureConfig.password,
          protocols: undefined,
          useRemoteCipherPrefer: tlsSecureConfig.useRemoteCipherPrefer,
          signatureAlgorithms: tlsSecureConfig.signatureAlgorithms,
          cipherSuite: tlsSecureConfig.cipherSuite
        };
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfigWithoutProtocol,
          ALPNProtocols: ["http/1.1"],
        };
        await tlsServer.listen(listenOptions);
        try {
          await tlsServer.getProtocol((err: BusinessError, data: string) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              console.info(`${caseName} getProtocol result: ${data}`);
              expect(data === 'TLSv1.3').assertTrue();
            }
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetCertificate_0100
     * @tc.name ArKUIX_TLSSocketServer_GetCertificate_0100
     * @tc.desc Test to obtain a certificate,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetCertificate_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetCertificate_0100';
        try {
          let tlsServer: socket.TLSSocketServer | null = null;
          tlsServer = socket.constructTLSSocketServerInstance();
          const listenOptions: socket.TLSConnectOptions = {
            address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["http/1.1"],
          }
          await tlsServer.listen(listenOptions);
          const data = await new Promise<socket.X509CertRawData>((resolve, reject) => {
            tlsServer!.getCertificate((err: BusinessError, data: socket.X509CertRawData) => {
              if (err) {
                reject(new Error(`${caseName} failed, error: ${err.code}, ${err.message}`));
              } else {
                resolve(data);
              }
            });
          });

          console.info(`${caseName} getCertificate result: ${data}`);
          expect(data != null).assertTrue();
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetCertificate_0200
     * @tc.name ArKUIX_TLSSocketServer_GetCertificate_0200
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetCertificate_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetCertificate_0200';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        try {
          await tlsServer.getCertificate(undefined);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetCertificate_0300
     * @tc.name ArKUIX_TLSSocketServer_GetCertificate_0300
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetCertificate_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetCertificate_0300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        try {
          await tlsServer.getCertificate(null);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetCertificate_0400
     * @tc.name ArKUIX_TLSSocketServer_GetCertificate_0400
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetCertificate_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetCertificate_0400';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        try {
          const getCertificate: socket.X509CertRawData = await tlsServer.getCertificate();
          expect(getCertificate != null).assertTrue();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetCertificate_0500
     * @tc.name ArKUIX_TLSSocketServer_GetCertificate_0500
     * @tc.desc Test to obtain a certificate,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetCertificate_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetCertificate_0500';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        await tlsServer.getCertificate().then((data: socket.X509CertRawData) => {
          console.info(`${caseName} getCertificate result: ${data}`);
          expect(data != null).assertTrue();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        });
        done()
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetCertificate_0600
     * @tc.name ArKUIX_TLSSocketServer_GetCertificate_0600
     * @tc.desc The test returned an error code 401,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetCertificate_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetCertificate_0600';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        let ca_common3: string[] = [];

        interface TLSSecureOptions {
          ca: string[];
          key: string;
          password: string;
          cert: string;
          protocols: socket.Protocol[];
          useRemoteCipherPrefer: boolean;
          signatureAlgorithms: string;
          cipherSuite: string;
        }

        let tlsConnectOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: {
            ca: ca_common3,
            key: '',
            password: '12345',
            cert: '',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          } as TLSSecureOptions,
          ALPNProtocols: ["spdy/1", "http/1.1"]
        };
        await tlsServer.listen(tlsConnectOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
          expect().assertFail();
          done();
        });
        try {
          await tlsServer.getCertificate().then((data: socket.X509CertRawData) => {
            expect().assertFail();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          console.error('result' + JSON.stringify(err.code));
          const errCode = Number(err.code);
          expect(errCode === SocketErrorCodes.ERR_CODE_CERT_ERROR).assertTrue();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetCertificate_0700
     * @tc.name ArKUIX_TLSSocketServer_GetCertificate_0700
     * @tc.desc Other port interface testing,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetCertificate_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetCertificate_0700';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
          expect().assertFail();
          done();
        });
        await tlsServer.getCertificate((err: BusinessError, data: socket.X509CertRawData) => {
          try {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              expect(data !== null).assertTrue();
            }
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
        });
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetCertificate_0800
     * @tc.name ArKUIX_TLSSocketServer_GetCertificate_0800
     * @tc.desc Open on and off before testing,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetCertificate_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetCertificate_0800';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        let callback: Callback<socket.TLSSocketConnection> = (data: socket.TLSSocketConnection) => {
        }
        tlsServer.on('connect', callback);
        tlsServer.off('connect');
        await tlsServer.getCertificate().then((data: socket.X509CertRawData) => {
          expect(data !== null).assertTrue();
          console.info('result' + JSON.stringify(data))
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        })
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetCertificate_0900
     * @tc.name ArKUIX_TLSSocketServer_GetCertificate_0900
     * @tc.desc Do not monitor the service,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetCertificate_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetCertificate_0900';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        await tlsServer.getCertificate().then((data: socket.X509CertRawData) => {
          expect(data != null).assertFail();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === SocketErrorCodes.ERR_CODE_BIND_ERROR).assertTrue();
        })
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_GetCertificate_1000
     * @tc.name ArKUIX_TLSSocketServer_GetCertificate_1000
     * @tc.desc Set other configuration items,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_GetCertificate_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_GetCertificate_1000';
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
          OOBInline: true,
          TCPNoDelay: true,
          socketLinger: {
            on: true, linger: 10
          } as SocketLinger,
          receiveBufferSize: 1000,
          sendBufferSize: 1000,
          reuseAddress: true,
          socketTimeout: 30000
        };
        await tlsServer.listen(listenOptions).catch((err: BusinessError) => {
          console.error('fail to listen' + err.code.toString());
          expect().assertFail();
          done();
        });
        await tlsServer.setExtraOptions(tcpExtraOptions).catch((err: BusinessError) => {
          console.error('fail to setExtraOptions' + err.code.toString());
          expect().assertFail();
          done();
        });
        await tlsServer.getCertificate((err: BusinessError, data: socket.X509CertRawData) => {
          try {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } else {
              console.info(`${caseName} getCertificate result: ${data}`);
              expect(data !== null).assertTrue();
            }
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
        })
        done();
      })

    /**
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_0100
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_0100
     * @tc.desc Set other properties of the TLSSocketServer connection,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_0100';
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
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_0200
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_0200
     * @tc.desc Set other properties of the TLSSocketServer connection,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_0200';
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
     * @tc.number ArKUIX_TLSSocketServer_SetExtraOptions_0300
     * @tc.name ArKUIX_TLSSocketServer_SetExtraOptions_0300
     * @tc.desc Test Options to null and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketServer_SetExtraOptions_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketServer_SetExtraOptions_0300';
        let tlsServer: socket.TLSSocketServer | null = null;
        tlsServer = socket.constructTLSSocketServerInstance();
        const listenOptions: socket.TLSConnectOptions = {
          address: { address: '0.0.0.0', port: getNextPort() } as socket.NetAddress,
          secureOptions: tlsSecureConfig,
          ALPNProtocols: ["http/1.1"],
        }
        await tlsServer.listen(listenOptions);
        try {
          await tlsServer.setExtraOptions(undefined, (err: BusinessError) => {
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
  })
}