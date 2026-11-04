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
import { serverKey, serverCert, serverCa, clientKey, clientCert, clientCa, getNextPort, PortManager, SocketErrorCodes, sleep, netAddress} from './public_util'

const tlsSecureConfig: socket.TLSSecureOptions = {
  key: serverKey,
  cert: serverCert,
  ca: [serverCa],
  password: '88888888',
  protocols: [socket.Protocol.TLSv12],
  useRemoteCipherPrefer: true,
  signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
  cipherSuite: "AES256-SHA256",
  isBidirectionalAuthentication: true,
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
  isBidirectionalAuthentication: true,
};

const connectAddr: socket.NetAddress = {
  address: '127.0.0.1',
  port: 14586
};

const connectOptions: socket.TLSConnectOptions = {
  address: connectAddr,
  secureOptions: TlsClientOptions,
  ALPNProtocols: ["spdy/1", "http/1.1"],
};

export default function TLSSocketConnectionTest_2() {
  describe('TLSSocketConnectionTest_2', () => {
    beforeEach(async () => {
      await sleep(500);
    });
    beforeAll(() => {
      PortManager.reset();
    });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteCertificate_0100
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteCertificate_0100
     * @tc.desc Test the functionality of the getRemoteCertificate interface function
     * using the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteCertificate_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteCertificate_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        let testCompleted = false;
        const cleanResources = () => {
          if (testCompleted) {
            return;
          }
          try {
            tlsServer.close();
            tlsClient.close();
          } catch (err) {
          }
          testCompleted = true;
        };
        try {
          const port = getNextPort();
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: port
          };
          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: port
          };
          await tlsClient.bind(netAddress);
          console.info(`${caseName} bind success`);

          await tlsServer.listen(tlsConnectOptions);
          console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);

          tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
            console.info(`${caseName} Client connection detected`);
            clientConn.getRemoteCertificate((err: BusinessError, certData: socket.X509CertRawData) => {
              if (err) {
                console.error(`${caseName} Failed to obtain the remote certificate,error:
            ${err.code} - ${err.message}`);
                cleanResources();
                done();
                return;
              } else {
                console.info(`${caseName} success to obtain the remote certificate ${JSON.stringify(certData)}`);
                expect(certData != undefined).assertTrue();
                cleanResources();
                done();
              }
            });
          });

          await tlsClient.connect(connectOptions);
          console.info(`${caseName} connect successfully`);
        } catch (err) {
          if ((err as BusinessError).code) {
            const error = err as BusinessError;
            if (error.message.includes('listen')) {
              console.error(`${caseName} listen fail: ${error.code} - ${error.message}`);
            } else if (error.message.includes('bind')) {
              console.error(`${caseName} bind err: ${error.code} - ${error.message}`);
            } else if (error.message.includes('connect')) {
              console.error(`${caseName} connect fail: ${error.code} - ${error.message}`);
            } else {
              console.error(`${caseName} operation failed: ${JSON.stringify(error)}`);
            }
          } else {
            const error = err as BusinessError;
            console.error(`${caseName} test error: ${error.message}`);
            expect().assertFail();
          }
          cleanResources();
          done();
        } finally {
          setTimeout(() => {
            if (!testCompleted) {
              cleanResources();
              done();
            }
          }, 5000);
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteCertificate_0200
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteCertificate_0200
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteCertificate_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteCertificate_0200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const port = getNextPort();
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: port
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: port
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);
              (async (): Promise<void> => {
                return new Promise<void>((resolve, reject) => {
                  try {
                    clientConn.getRemoteCertificate(undefined);
                  } catch (err) {
                    const errCode = Number(err.code);
                    expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
                    reject(err);
                  }
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Failed to obtain the remote certificate,error: ${JSON.stringify(err)}`);
                done();
              });
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then(() => {
                console.info(`${caseName} connect successfully`);
              }).catch((err: BusinessError) => {
                console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            done();
          });

        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteCertificate_0300
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteCertificate_0300
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteCertificate_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteCertificate_0300';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const port = getNextPort();
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: port
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: port
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);
              (async (): Promise<void> => {
                return new Promise<void>((resolve, reject) => {
                  try {
                    clientConn.getRemoteCertificate(null);
                  } catch (err) {
                    const errCode = Number(err.code);
                    expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
                    reject(err);
                  }
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Failed to obtain the remote certificate,error: ${JSON.stringify(err)}`);
                done();
              });
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then(() => {
                console.info(`${caseName} connect successfully`);
              }).catch((err: BusinessError) => {
                console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            done();
          });

        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteCertificate_0400
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteCertificate_0400
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteCertificate_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteCertificate_0400';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const port = getNextPort();
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: port
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: port
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);
              (async (): Promise<void> => {
                return new Promise<void>((resolve, reject) => {
                  let getRemoteCertificate = false;
                  try {
                    clientConn.getRemoteCertificate();
                    getRemoteCertificate = true;
                    expect(getRemoteCertificate).assertTrue();
                    resolve();
                  } catch (err) {
                    const errCode = Number(err.code);
                    expect().assertFail();
                    reject(err);
                  }
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Failed to obtain the remote certificate,error: ${JSON.stringify(err)}`);
                done();
              });
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then(() => {
                console.info(`${caseName} connect successfully`);
              }).catch((err: BusinessError) => {
                console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            done();
          });

        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteCertificate_0500
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteCertificate_0500
     * @tc.desc Test the functionality of the getRemoteCertificate interface function
     * using the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteCertificate_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteCertificate_0500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const port = getNextPort();
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: port
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: port
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);
              setTimeout(() => {
                clientConn.getRemoteCertificate().then((certData: socket.X509CertRawData) => {
                  console.info(`${caseName} Success to obtain the remote certificate:${JSON.stringify(certData)}`);
                  expect(certData != undefined).assertTrue();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} Failed to obtain the remote certificate,promise catch error:
                ${err.code} - ${err.message}`);
                  expect().assertFail();
                });
              }, 2000);
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(connectAddr).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then(() => {
                console.info(`${caseName} connect successfully`);
                sleep(1000);
              }).catch((err: BusinessError) => {
                console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          });

        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteCertificate_0600
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteCertificate_0600
     * @tc.desc Ca is an empty test interface,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteCertificate_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteCertificate_0600';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const port = getNextPort();
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: port
          };
          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: port
          };

          const tlsSecureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: '',
            password: '88888888',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };

          const secureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: '',
            password: '88888888',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const connectOptions: socket.TLSConnectOptions = {
            address: connectAddr,
            secureOptions: secureOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(connectAddr)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);

              (async (): Promise<void> => {
                return new Promise<void>((resolve, reject) => {
                  clientConn.getRemoteCertificate((err: BusinessError, certData: socket.X509CertRawData) => {
                    if (err) {
                      console.error(`${caseName} Failed to obtain the remote certificate,error:
                      ${err.code} - ${err.message}`);
                      reject(err);
                    } else {
                      console.info(`${caseName} success to obtain the remote certificate${JSON.stringify(certData)}`);
                      expect().assertFail();
                      resolve();
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} GetRemoteCertificate failed: ${JSON.stringify(err)}`);
                done();
              });
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then(() => {
                console.info(`${caseName} connect successfully`);
              }).catch((err: BusinessError) => {
                console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
                const errCode = Number(err.code);
                expect(errCode === 2303501).assertTrue();
                done();
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            done();
          });

        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteCertificate_0700
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteCertificate_0700
     * @tc.desc Key is an empty test interface,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteCertificate_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteCertificate_0700';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const port = getNextPort();
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: port
          };

          const tlsSecureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
            password: '88888888',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };

          const secureOptions: socket.TLSSecureOptions = {
            key: '',
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
            password: '88888888',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: port
          };

          const connectOptions: socket.TLSConnectOptions = {
            address: connectAddr,
            secureOptions: secureOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(connectAddr)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);

              (async (): Promise<void> => {
                return new Promise<void>((resolve, reject) => {
                  clientConn.getRemoteCertificate((err: BusinessError, certData: socket.X509CertRawData) => {
                    if (err) {
                      console.error(`${caseName} Failed to obtain the remote certificate,error:
              ${err.code} - ${err.message}`);
                      reject(err);
                    } else {
                      console.info(`${caseName} success to obtain the remote certificate${JSON.stringify(certData)}`);
                      expect().assertFail();
                      resolve();
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} GetRemoteCertificate failed: ${JSON.stringify(err)}`);
                done();
              });
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  const errCode = Number(err.code);
                  expect(errCode === 2303505).assertTrue();
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then(() => {
                console.info(`${caseName} connect successfully`);
              }).catch((err: BusinessError) => {
                console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            done();
          });

        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteCertificate_0800
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteCertificate_0800
     * @tc.desc cert is an empty test interface,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteCertificate_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteCertificate_0800';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const port = getNextPort();
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: port
          };

          const tlsSecureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
            password: '88888888',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };

          const secureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: '',
            ca: tlsSecureConfig.ca,
            password: '88888888',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: port
          };

          const connectOptions: socket.TLSConnectOptions = {
            address: connectAddr,
            secureOptions: secureOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);

              (async (): Promise<void> => {
                return new Promise<void>((resolve, reject) => {
                  clientConn.getRemoteCertificate().then((certData: socket.X509CertRawData) => {
                    console.info(`${caseName} Success to obtain the remote certificate:${JSON.stringify(certData)}`);
                    expect().assertFail();
                    resolve();
                  }).catch((err: BusinessError) => {
                    console.error(`${caseName} Failed to obtain the remote certificate,promise catch error:
                ${err.code} - ${err.message}`);
                    const errCode = Number(err.code);
                    expect(errCode === 2303505 || errCode === 2303501).assertTrue();
                    reject(err);
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} GetRemoteCertificate failed: ${JSON.stringify(err)}`);
                done();
              });
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then(() => {
                console.info(`${caseName} connect successfully`);
              }).catch((err: BusinessError) => {
                console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            done();
          });

        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteCertificate_0900
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteCertificate_0900
     * @tc.desc password is an empty test interface,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteCertificate_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteCertificate_0900';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const port = getNextPort();
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: port
          };

          const tlsSecureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
            password: '',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };

          const secureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
            password: '',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: port
          };

          const connectOptions: socket.TLSConnectOptions = {
            address: connectAddr,
            secureOptions: secureOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);

              (async (): Promise<void> => {
                return new Promise<void>((resolve, reject) => {
                  clientConn.getRemoteCertificate((err: BusinessError, certData: socket.X509CertRawData) => {
                    if (err) {
                      console.error(`${caseName} Failed to obtain the remote certificate,error:
                      ${err.code} - ${err.message}`);
                      const errCode = Number(err.code);
                      expect(errCode === 2303505).assertTrue();
                      done();
                    } else {
                      console.info(`${caseName} success to obtain the remote certificate${JSON.stringify(certData)}`);
                      expect().assertFail();
                      resolve();
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} GetRemoteCertificate failed: ${JSON.stringify(err)}`);
                done();
              });
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then(() => {
                console.info(`${caseName} connect successfully`);
              }).catch((err: BusinessError) => {
                console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            done();
          });

        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_GetCipherSuite_0100
     * @tc.name ArKUIX_TLSSocketConnection_GetCipherSuite_0100
     * @tc.desc Get the cipher suite negotiated by both parties, Use the callback method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetCipherSuite_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetCipherSuite_0100';
        console.info(`${caseName} test start`);
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const port = getNextPort();
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: port
          };
          const tlsSecureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
            password: '',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };

          const secureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
            password: '',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: port
          };

          const connectOptions: socket.TLSConnectOptions = {
            address: connectAddr,
            secureOptions: secureOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);
              (async (): Promise<void> => {
                return new Promise<void>((resolve, reject) => {
                  clientConn.getCipherSuite((err: BusinessError, cipherSuiteList: Array<string>) => {
                    if (err) {
                      console.error(`${caseName} GetCipherSuite failed,error: ${err.code} - ${err.message}`);
                      expect(true).assertFalse();
                      reject(err);
                      done();
                    } else {
                      console.info(`${caseName} GetCipherSuite success:${JSON.stringify(cipherSuiteList)}`);
                      expect(cipherSuiteList != undefined).assertTrue();
                      resolve();
                      done();
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} GetCipherSuite failed: ${JSON.stringify(err)}`);
                done();
              });
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then(() => {
                console.info(`${caseName} connect successfully`);
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
                done();
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            done();
          });

        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_GetCipherSuite_0200
     * @tc.name ArKUIX_TLSSocketConnection_GetCipherSuite_0200
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetCipherSuite_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetCipherSuite_0200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const port = getNextPort();
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: port
          };
          const tlsSecureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
            password: '',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };

          const secureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
            password: '',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: port
          };

          const connectOptions: socket.TLSConnectOptions = {
            address: connectAddr,
            secureOptions: secureOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);

              try {
                clientConn.getCipherSuite(undefined);
                console.info(`${caseName} getCipherSuite(undefined) success`);
                expect().assertFail();
                done();
              } catch (err) {
                console.error(`${caseName} GetCipherSuite error(undefined parameter): ${err.code} - ${err.message}`);
                const errCode = Number(err.code);
                expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then(() => {
                console.info(`${caseName} connect successfully`);
              }).catch((err: BusinessError) => {
                console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            done();
          });

        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_GetCipherSuite_0300
     * @tc.name ArKUIX_TLSSocketConnection_GetCipherSuite_0300
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetCipherSuite_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetCipherSuite_0300';
        console.info(`${caseName} test start`);
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const port = getNextPort();
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: port
          };
          const tlsSecureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
            password: '',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };

          const secureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
            password: '',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: port
          };

          const connectOptions: socket.TLSConnectOptions = {
            address: connectAddr,
            secureOptions: secureOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);

              try {
                clientConn.getCipherSuite(null);
                console.info(`${caseName} getCipherSuite(undefined) success`);
                expect().assertFail();
                done();
              } catch (err) {
                console.error(`${caseName} GetCipherSuite error(undefined parameter): ${err.code} - ${err.message}`);
                const errCode = Number(err.code);
                expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then(() => {
                console.info(`${caseName} connect successfully`);
              }).catch((err: BusinessError) => {
                console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            done();
          });

        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_GetCipherSuite_0400
     * @tc.name ArKUIX_TLSSocketConnection_GetCipherSuite_0400
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetCipherSuite_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetCipherSuite_0400';
        console.info(`${caseName} test start`);
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const port = getNextPort();
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: port
          };
          const tlsSecureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
            password: '',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };

          const secureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
            password: '',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: port
          };

          const connectOptions: socket.TLSConnectOptions = {
            address: connectAddr,
            secureOptions: secureOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);
              let getCipherSuite = false;
              try {
                clientConn.getCipherSuite();
                console.info(`${caseName} getCipherSuite(undefined) success`);
                getCipherSuite = true;
                expect(getCipherSuite).assertTrue();
                done();
              } catch (err) {
                console.error(`${caseName} GetCipherSuite error(undefined parameter): ${err.code} - ${err.message}`);
                expect().assertFail();
                done();
              }
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then(() => {
                console.info(`${caseName} connect successfully`);
              }).catch((err: BusinessError) => {
                console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            done();
          });

        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_GetCipherSuite_0500
     * @tc.name ArKUIX_TLSSocketConnection_GetCipherSuite_0500
     * @tc.desc Get the cipher suite negotiated by both parties, Use the Promise method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetCipherSuite_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetCipherSuite_0500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: getNextPort()
          };
          const tlsSecureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
            password: '',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };

          const secureOptions: socket.TLSSecureOptions = {
            key: tlsSecureConfig.key,
            cert: tlsSecureConfig.cert,
            ca: tlsSecureConfig.ca,
            password: '',
            protocols: [socket.Protocol.TLSv12],
            useRemoteCipherPrefer: true,
            signatureAlgorithms: "rsa_pss_rsae_sha256:ECDSA+SHA256",
            cipherSuite: "AES256-SHA256"
          };

          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: secureOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);

              try {
                clientConn.getCipherSuite().then((cipherSuiteList: Array<string>) => {
                  console.info(`${caseName} GetCipherSuite success,promise: ${JSON.stringify(cipherSuiteList)}`);
                  expect(cipherSuiteList != undefined).assertTrue();
                  done();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} GetCipherSuite failed,error: ${err.code} - ${err.message}`);
                  expect().assertFail();
                  done();
                });
              } catch (err) {
                console.error(`${caseName} GetCipherSuite failed,error:
              ${(err as BusinessError).code} - ${(err as BusinessError).message}`);
                expect(true).assertFalse();
                done();
              }
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then(() => {
                console.info(`${caseName} connect successfully`);
              }).catch((err: BusinessError) => {
                console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            done();
          });

        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect(true).assertFalse();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_On_Close_0100
     * @tc.name ArKUIX_TLSSocketConnection_On_Close_0100
     * @tc.desc The test type is set to close, and the callback asynchronous callback method is adopted
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_On_Close_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_On_Close_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: getNextPort()
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          let on_close = false;
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} listen fail:${err.code}-${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info('connect success');

              clientConn.on('close', () => {
                console.info(`${caseName} on close success`);
                on_close = true;
                expect(on_close).assertTrue();
                done();
              });
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve) => {
                tlsClient.bind(netAddress).then((): Promise<void> => {
                  return tlsClient.connect(connectOptions);
                }).then((): void => {
                  setTimeout(() => {
                    tlsClient.close().then(() => {
                      console.info(`${caseName} close success`);
                      setTimeout(() => {
                        if (!on_close) {
                          console.info(`${caseName} close event not received but connection was closed`);
                          expect(true).assertTrue();
                          done();
                        }
                        resolve();
                      }, 500);
                    }).catch(() => {
                      console.error(`${caseName} close error`);
                      resolve();
                    });
                  }, 100);
                }).catch((): void => {
                  console.error(`${caseName} client connect error`);
                  resolve();
                });
              });
            })();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_On_Close_0200
     * @tc.name ArKUIX_TLSSocketConnection_On_Close_0200
     * @tc.desc The test type is null, the callback asynchronous callback method is adopted
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_On_Close_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_On_Close_0200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const port = getNextPort();
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: port
          };
          const netAddressServer: socket.NetAddress = {
            address: '0.0.0.0',
            port: port
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddressServer,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);
              try {
                clientConn.on(null, () => {
                  expect().assertFail();
                  done();
                });
              } catch (err) {
                console.error(`${caseName} on close fail: ${(err as BusinessError).code}
              - ${(err as BusinessError).message}`);
                expect(err.code == SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then(() => {
                console.info(`${caseName} connect successfully`);
              }).catch((err: BusinessError) => {
                console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
              });
              setTimeout(() => {
                tlsClient.close();
              }, 500);
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} operation fail: ${error.code} - ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_On_Close_0300
     * @tc.name ArKUIX_TLSSocketConnection_On_Close_0300
     * @tc.desc The test type is undefined, and the callback asynchronous callback method is adopted
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_On_Close_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_On_Close_0300';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const port = getNextPort();
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: port
          };
          const netAddressServer: socket.NetAddress = {
            address: '0.0.0.0',
            port: port
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddressServer,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);
              try {
                clientConn.on(undefined, () => {
                  expect().assertFail();
                  done();
                });
              } catch (err) {
                console.error(`${caseName} on close fail: ${(err as BusinessError).code}
              - ${(err as BusinessError).message}`);
                expect(err.code == SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then(() => {
                console.info(`${caseName} connect successfully`);
              }).catch((err: BusinessError) => {
                console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
              });
              setTimeout(() => {
                tlsClient.close();
              }, 500);
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} operation fail: ${error.code} - ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_On_CLose_0400
     * @tc.name ArKUIX_TLSSocketConnection_On_CLose_0400
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_On_CLose_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_On_CLose_0400';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const port = getNextPort();
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: port
          };
          const netAddressServer: socket.NetAddress = {
            address: '0.0.0.0',
            port: port
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddressServer,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);
              try {
                clientConn.on('close', undefined);
                expect().assertFail();
                done();
              } catch (err) {
                console.error(`${caseName} on close fail: ${(err as BusinessError).code}
              - ${(err as BusinessError).message}`);
                expect(err.code == SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then(() => {
                console.info(`${caseName} connect successfully`);
              }).catch((err: BusinessError) => {
                console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
              });
              setTimeout(() => {
                tlsClient.close();
              }, 500);
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} operation fail: ${error.code} - ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_On_CLose_0500
     * @tc.name ArKUIX_TLSSocketConnection_On_CLose_0500
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_On_CLose_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_On_CLose_0500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const port = getNextPort();
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: port
          };
          const netAddressServer: socket.NetAddress = {
            address: '0.0.0.0',
            port: port
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddressServer,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);
              try {
                clientConn.on('close', null);
                expect().assertFail();
                done();
              } catch (err) {
                console.error(`${caseName} on close fail: ${(err as BusinessError).code}
              - ${(err as BusinessError).message}`);
                expect(err.code == SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then(() => {
                console.info(`${caseName} connect successfully`);
              }).catch((err: BusinessError) => {
                console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
              });
              setTimeout(() => {
                tlsClient.close();
              }, 500);
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} operation fail: ${error.code} - ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_Off_Close_0100
     * @tc.name ArKUIX_TLSSocketConnection_Off_Close_0100
     * @tc.desc The test type is set to close, and the callback asynchronous callback method is adopted
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Off_Close_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Off_Close_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: getNextPort()
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };
          let on_close = false;
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} listen fail:${err.code}-${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info('connect success');
              const callback = () => {
                console.info(`${caseName} on close success`);
                expect().assertFail();
                done();
              }
              clientConn.on('close', callback);
              clientConn.off('close', callback);
              expect(true).assertTrue();
              done();
            });
            await (async (): Promise<void> => {
              return new Promise<void>((resolve) => {
                tlsClient.bind(netAddress).then((): Promise<void> => {
                  return tlsClient.connect(connectOptions);
                }).then((): void => {
                  setTimeout(() => {
                    tlsClient.close().then(() => {
                      console.info(`${caseName} close success`);
                      setTimeout(() => {
                        if (!on_close) {
                          console.info(`${caseName} close event not received but connection was closed`);
                          expect(true).assertTrue();
                          done();
                        }
                        resolve();
                      }, 500);
                    }).catch(() => {
                      console.error(`${caseName} close error`);
                      resolve();
                    });
                  }, 100);
                }).catch((): void => {
                  console.error(`${caseName} client connect error`);
                  resolve();
                });
              });
            })();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_Off_Close_0200
     * @tc.name ArKUIX_TLSSocketConnection_Off_Close_0200
     * @tc.desc When the test type is null, the callback asynchronous callback method is adopted
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Off_Close_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Off_Close_0200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: getNextPort()
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info('connect success');
              const callback = () => {
                console.info(`${caseName} on close success`);
                expect().assertFail();
                done();
              }
              clientConn.on('close', callback);
              try {
                clientConn.off(null, callback);
                expect().assertFail();
                done();
              } catch (err) {
                console.error(`${caseName} on close fail: ${(err as BusinessError).code}
              - ${(err as BusinessError).message}`);
                expect(err.code == SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
            });
            await tlsClient.bind(netAddress);
            await tlsClient.connect(connectOptions);

            await new Promise<void>((resolve) => {
              setTimeout(() => {
                tlsClient.close();
                resolve();
              }, 2000);
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_Off_Close_0300
     * @tc.name ArKUIX_TLSSocketConnection_Off_Close_0300
     * @tc.desc The test type is undefined, and the callback asynchronous callback method is adopted
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Off_Close_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Off_Close_0300';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: getNextPort()
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info('connect success');
              const callback = () => {
                console.info(`${caseName} on close success`);
                expect().assertFail();
                done();
              }
              clientConn.on('close', callback);
              try {
                clientConn.off(undefined, callback);
                expect().assertFail();
                done();
              } catch (err) {
                console.error(`${caseName} on close fail: ${(err as BusinessError).code}
              - ${(err as BusinessError).message}`);
                expect(err.code == SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
            });
            await tlsClient.bind(netAddress);
            await tlsClient.connect(connectOptions);

            await new Promise<void>((resolve) => {
              setTimeout(() => {
                tlsClient.close();
                resolve();
              }, 2000);
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_Off_Close_0400
     * @tc.name ArKUIX_TLSSocketConnection_Off_Close_0400
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Off_Close_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Off_Close_0400';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: getNextPort()
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info('connect success');
              const callback = () => {
                console.info(`${caseName} on close success`);
                expect().assertFail();
                done();
              }
              clientConn.on('close', callback);
              try {
                clientConn.off('close', undefined);
                expect().assertFail();
                done();
              } catch (err) {
                console.error(`${caseName} on close fail: ${(err as BusinessError).code}
              - ${(err as BusinessError).message}`);
                expect(err.code == SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
            });
            await tlsClient.bind(netAddress);
            await tlsClient.connect(connectOptions);

            await new Promise<void>((resolve) => {
              setTimeout(() => {
                tlsClient.close();
                resolve();
              }, 2000);
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_Off_Close_0500
     * @tc.name ArKUIX_TLSSocketConnection_Off_Close_0500
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Off_Close_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Off_Close_0500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: getNextPort()
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info('connect success');
              const callback = () => {
                console.info(`${caseName} on close success`);
                expect().assertFail();
                done();
              }
              clientConn.on('close', callback);
              try {
                clientConn.off('close', null);
                expect().assertFail();
                done();
              } catch (err) {
                console.error(`${caseName} on close fail: ${(err as BusinessError).code}
              - ${(err as BusinessError).message}`);
                expect(err.code == SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              }
            });
            await tlsClient.bind(netAddress);
            await tlsClient.connect(connectOptions);

            await new Promise<void>((resolve) => {
              setTimeout(() => {
                tlsClient.close();
                resolve();
              }, 2000);
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_Off_Close_0600
     * @tc.name ArKUIX_TLSSocketConnection_Off_Close_0600
     * @tc.desc The test did not pass the callback parameter and adopted the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Off_Close_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Off_Close_0600';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: getNextPort()
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          let on_close = false;
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} listen fail:${err.code}-${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info('connect success');
              const callback = () => {
                console.info(`${caseName} on close success`);
                expect().assertFail();
                done();
              }
              clientConn.on('close', callback);
              clientConn.off('close');
              expect(true).assertTrue();
              done();
            });
            await (async (): Promise<void> => {
              return new Promise<void>((resolve) => {
                tlsClient.bind(netAddress).then((): Promise<void> => {
                  return tlsClient.connect(connectOptions);
                }).then((): void => {
                  setTimeout(() => {
                    tlsClient.close().then(() => {
                      console.info(`${caseName} close success`);
                      setTimeout(() => {
                        if (!on_close) {
                          console.info(`${caseName} close event not received but connection was closed`);
                          expect(true).assertTrue();
                          done();
                        }
                        resolve();
                      }, 500);
                    }).catch(() => {
                      console.error(`${caseName} close error`);
                      resolve();
                    });
                  }, 100);
                }).catch((): void => {
                  console.error(`${caseName} client connect error`);
                  resolve();
                });
              });
            })();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_Off_Close_0700
     * @tc.name ArKUIX_TLSSocketConnection_Off_Close_0700
     * @tc.desc After testing multiple subscriptions, off clears all closed subscriptions
     * and uses the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Off_Close_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Off_Close_0700';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: getNextPort()
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          let on_close = false;
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} listen fail:${err.code}-${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info('connect success');
              const callback_1 = () => {
                console.info(`${caseName} on close success`);
                expect().assertFail();
                done();
              }
              const callback_2 = () => {
                console.info(`${caseName} on close success`);
                expect().assertFail();
                done();
              }
              clientConn.on('close', callback_1);
              clientConn.on('close', callback_2);
              clientConn.off('close');
              expect(true).assertTrue();
              done();
            });
            await (async (): Promise<void> => {
              return new Promise<void>((resolve) => {
                tlsClient.bind(netAddress).then((): Promise<void> => {
                  return tlsClient.connect(connectOptions);
                }).then((): void => {
                  setTimeout(() => {
                    tlsClient.close().then(() => {
                      console.info(`${caseName} close success`);
                      setTimeout(() => {
                        if (!on_close) {
                          console.info(`${caseName} close event not received but connection was closed`);
                          expect(true).assertTrue();
                          done();
                        }
                        resolve();
                      }, 500);
                    }).catch(() => {
                      console.error(`${caseName} close error`);
                      resolve();
                    });
                  }, 100);
                }).catch((): void => {
                  console.error(`${caseName} client connect error`);
                  resolve();
                });
              });
            })();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_getLocalAddress_0100
     * @tc.name ArKUIX_TLSSocketConnection_getLocalAddress_0100
     * @tc.desc Test the functionality of the getLocalAddress function interface under TLSSocketConnection
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_getLocalAddress_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_getLocalAddress_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: getNextPort()
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then((): void => {
                console.info(`${caseName} TLS server listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} TLS server listen failed:${err.code}-${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection): void => {
              clientConn.getLocalAddress().then((localAddress: socket.NetAddress) => {
                console.info(`${caseName} Get local address success: ${JSON.stringify(localAddress)}`);
                expect(localAddress != undefined).assertTrue();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Get local address failed: ${err.code} - ${err.message}`);
              });
            });

            tlsClient.bind(netAddress).then((): Promise<void> => {
              console.info(`${caseName} TLS client bind local address success`);
              return tlsClient.connect(connectOptions);
            }).then((): void => {
              console.info(`${caseName} Client connect to server success`);
            }).catch((err: BusinessError): void => {
              console.error(`${caseName} Client bind erred: ${err.code}`);
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          });

        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_GetSocketFd_0100
     * @tc.name ArKUIX_TLSSocketConnection_GetSocketFd_0100
     * @tc.desc Test the functionality of the getSocketFd function interface under TLSSocketConnection
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetSocketFd_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetSocketFd_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: getNextPort()
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then((): void => {
                console.info(`${caseName} TLS server listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} TLS server listen failed:${err.code}-${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection): void => {
              clientConn.getSocketFd().then((data: number) => {
                console.info(`${caseName} getSocketFd success: ${JSON.stringify(data)}`);
                expect(data >= 0).assertTrue();
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} getSocketFd failed: ${err.code} - ${err.message}`);
                expect().assertFail();
                done();
              });
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then((): void => {
                  console.info(`${caseName} TLS client bind local address success`);
                  resolve();
                }).catch((err: BusinessError): void => {
                  console.error(`${caseName} Client bind erred: ${err.code}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then((): void => {
                console.info(`${caseName} Client connect to server success`);
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} Client connect erred: ${err.code}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} Test case execution exception:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0100
     * @tc.name ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0100
     * @tc.desc Get the signature algorithms negotiated by both parties,
     * Use the callback method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const port = getNextPort();
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: port
          };

          const connectAddr: socket.NetAddress = {
            address: '127.0.0.1',
            port: port
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then(() => {
                console.info(`${caseName} TLSServer listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} listen fail: ${err.code} - ${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
              console.info(`${caseName} Client connection detected`);
              clientConn.getSignatureAlgorithms((err: BusinessError | null, sigAlgos: Array<string>) => {
                if (err) {
                  console.error(`${caseName} Get signature algorithms failed: ${err.code} - ${err.message}`);
                  return;
                } else {
                  console.info(`${caseName} Get signature algorithms success: ${JSON.stringify(sigAlgos)}`);
                  expect(sigAlgos !== undefined).assertTrue();
                }
              });
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then(() => {
                  console.info(`${caseName} bind success`);
                  resolve();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} bind err: ${err.code} - ${err.message}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then(() => {
                console.info(`${caseName} connect successfully`);
                setTimeout(() => {
                }, 500);
              }).catch((err: BusinessError) => {
                console.error(`${caseName} connect fail: ${err.code} - ${err.message}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0200
     * @tc.name ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0200
     * @tc.desc Test callback parameter type error.Use the callback method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: getNextPort()
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then((): void => {
                console.info(`${caseName} TLS server listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} TLS server listen failed:${err.code}-${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection): void => {
              clientConn.getSignatureAlgorithms((err: BusinessError | null, sigAlgos: Array<string>) => {
                try {
                  clientConn.getSignatureAlgorithms(undefined);
                  console.info(`${caseName} Call getSignatureAlgorithms with undefined callback
                  no exception (unexpected)`);
                  expect().assertFail();
                  done();
                } catch (err) {
                  console.error(`${caseName} Call getSignatureAlgorithms with undefined callback throw exception
                  (expected): ${(err as BusinessError).code}`);
                  expect((err as BusinessError).code == SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
                  done();
                }
              });
            });
            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then((): void => {
                  console.info(`${caseName} TLS client bind local address success`);
                  resolve();
                }).catch((err: BusinessError): void => {
                  console.error(`${caseName} Client bind erred: ${err.code}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then((): void => {
                console.info(`${caseName} Client connect to server success`);
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} Client connect erred: ${err.code}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} Test case execution exception:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0300
     * @tc.name ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0300
     * @tc.desc Test callback parameter type error.Use the callback method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0300';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: getNextPort()
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then((): void => {
                console.info(`${caseName} TLS server listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} TLS server listen failed:${err.code}-${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection): void => {
              clientConn.getSignatureAlgorithms((err: BusinessError | null, sigAlgos: Array<string>) => {
                try {
                  clientConn.getSignatureAlgorithms(null);
                  console.info(`${caseName} Call getSignatureAlgorithms with undefined callback
                  no exception (unexpected)`);
                  expect().assertFail();
                  done();
                } catch (err) {
                  console.error(`${caseName} Call getSignatureAlgorithms with undefined callback throw exception
                  (expected): ${(err as BusinessError).code}`);
                  expect((err as BusinessError).code == SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
                  done();
                }
              });
            });
            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then((): void => {
                  console.info(`${caseName} TLS client bind local address success`);
                  resolve();
                }).catch((err: BusinessError): void => {
                  console.error(`${caseName} Client bind erred: ${err.code}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then((): void => {
                console.info(`${caseName} Client connect to server success`);
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} Client connect erred: ${err.code}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} Test case execution exception:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0400
     * @tc.name ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0400
     * @tc.desc Test the scenario where the callback parameter is not passed.
     * Use the callback method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0400';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: getNextPort()
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then((): void => {
                console.info(`${caseName} TLS server listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} TLS server listen failed:${err.code}-${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection): void => {
              clientConn.getSignatureAlgorithms((err: BusinessError | null, sigAlgos: Array<string>) => {
                let getSignatureAlgorithms = false;
                try {
                  clientConn.getSignatureAlgorithms();
                  console.info(`${caseName} Call getSignatureAlgorithms with undefined callback
                  no exception (unexpected)`);
                  getSignatureAlgorithms = true;
                  expect(getSignatureAlgorithms).assertTrue();
                  done();
                } catch (err) {
                  console.error(`${caseName} Call getSignatureAlgorithms with undefined callback throw exception
                  (expected): ${(err as BusinessError).code}`);
                  expect().assertFail();
                  done();
                }
              });
            });

            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then((): void => {
                  console.info(`${caseName} TLS client bind local address success`);
                  resolve();
                }).catch((err: BusinessError): void => {
                  console.error(`${caseName} Client bind erred: ${err.code}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then((): void => {
                console.info(`${caseName} Client connect to server success`);
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} Client connect erred: ${err.code}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} Test case execution exception:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0500
     * @tc.name ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0500
     * @tc.desc Get the signature algorithms negotiated by both parties,
     * Use the Promise method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_getSignatureAlgorithms_0500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          const netAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: getNextPort()
          };
          const tlsConnectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: tlsSecureConfig,
            ALPNProtocols: ["spdy/1", "http/1.1"],
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: netAddress,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };

          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.listen(tlsConnectOptions).then((): void => {
                console.info(`${caseName} TLS server listen success: ${JSON.stringify(netAddress)}`);
                resolve();
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} TLS server listen failed:${err.code}-${err.message}`);
                reject(err);
              });
            });
          })().then(async () => {
            tlsServer.on('connect', (clientConn: socket.TLSSocketConnection): void => {
              clientConn.getSignatureAlgorithms().then((data: Array<string>) => {
                console.info(`${caseName} getSignatureAlgorithms success: ${JSON.stringify(data)}`);
                expect(data != undefined).assertTrue();
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} getSignatureAlgorithms failed: ${err.code} - ${err.message}`);
                expect().assertFail();
                done();
              });
            });
            await (async (): Promise<void> => {
              return new Promise<void>((resolve, reject) => {
                tlsClient.bind(netAddress).then((): void => {
                  console.info(`${caseName} TLS client bind local address success`);
                  resolve();
                }).catch((err: BusinessError): void => {
                  console.error(`${caseName} Client bind erred: ${err.code}`);
                  reject(err);
                });
              });
            })().then(async () => {
              tlsClient.connect(connectOptions).then((): void => {
                console.info(`${caseName} Client connect to server success`);
              }).catch((err: BusinessError): void => {
                console.error(`${caseName} Client connect erred: ${err.code}`);
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
            expect().assertFail();
            done();
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} Test case execution exception:${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tlsServer.close();
          tlsClient.close();
          done();
        }
      });
  })
}