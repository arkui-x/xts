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

export default function TLSSocketConnection_1Test() {
  describe('TLSSocketConnection_1Test', () => {
    beforeEach(async () => {
      await sleep(500);
    });
    beforeAll(() => {
      PortManager.reset();
    });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_Send_0100
     * @tc.name ArKUIX_TLSSocketConnection_Send_0100
     * @tc.desc Sending data through TLSSocketServer connection .Use the callback method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  let send = false;
                  clientConn.send('Hello, TLSSocket Client!', (err: BusinessError) => {
                    if (err) {
                      console.error(`${caseName} send data failed, callback error: ${err.code} - ${err.message}`);
                      expect().assertFail();
                      rejectInner(err);
                    } else {
                      console.info(`${caseName} send data success: data:"Hello, TLSSocket Client!"`);
                      send = true;
                      expect(send).assertTrue();
                      resolveInner();
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send failed: ${JSON.stringify(err)}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_0200
     * @tc.name ArKUIX_TLSSocketConnection_Send_0200
     * @tc.desc Sending data through TLSSocketServer connection. Use the callback method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_0200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        const sendArray = new Uint8Array([72, 101, 108, 108, 111, 32, 65, 114, 114, 97, 121]);
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);

              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  let send = false;
                  const dataToSend = sendArray.buffer;
                  clientConn.send(dataToSend, (err: BusinessError) => {
                    if (err) {
                      console.error(`${caseName} send data failed, callback error: ${err.code} - ${err.message}`);
                      expect().assertFail();
                      rejectInner(err);
                    } else {
                      console.info(`${caseName} send data success: data:
                      "72, 101, 108, 108, 111, 32, 65, 114, 114, 97, 121"`);
                      send = true;
                      expect(send).assertTrue();
                      resolveInner();
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send failed: ${JSON.stringify(err)}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_0300
     * @tc.name ArKUIX_TLSSocketConnection_Send_0300
     * @tc.desc When the test data is null, use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_0300';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  const emptyData = null;
                  clientConn.send(emptyData, (err: BusinessError) => {
                    if (err) {
                      console.error(`${caseName} send null fail,error: ${err.code} - ${err.message}`);
                      const errCode = Number(err.code);
                      expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
                      rejectInner(err);
                    } else {
                      console.info(`${caseName} send null success`);
                      expect().assertFail();
                      rejectInner(new Error('Should have failed'));
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send null failed: ${JSON.stringify(err)}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_0400
     * @tc.name ArKUIX_TLSSocketConnection_Send_0400
     * @tc.desc When the test data is undefined, use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_0400';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  const emptyData = undefined;
                  clientConn.send(emptyData, (err: BusinessError) => {
                    if (err) {
                      console.error(`${caseName} send null fail,error: ${err.code} - ${err.message}`);
                      const errCode = Number(err.code);
                      expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
                      rejectInner(err);
                    } else {
                      console.info(`${caseName} send null success`);
                      expect().assertFail();
                      rejectInner(new Error('Should have failed'));
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send null failed: ${JSON.stringify(err)}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_0500
     * @tc.name ArKUIX_TLSSocketConnection_Send_0500
     * @tc.desc Sending data through TLSSocketServer connection(data is '')
     * Use the callback method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_0500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);

              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  const emptyData = '';
                  let send = false;
                  clientConn.send(emptyData, (err: BusinessError) => {
                    if (err) {
                      console.error(`${caseName} send empty data fail,error: ${err.code} - ${err.message}`);
                      const errCode = Number(err.code);
                      expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
                      rejectInner(err);
                    } else {
                      console.info(`${caseName} send empty data success`);
                      expect().assertFail();
                      resolveInner();
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send empty data failed: ${JSON.stringify(err)}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_0600
     * @tc.name ArKUIX_TLSSocketConnection_Send_0600
     * @tc.desc Sending data through TLSSocketServer connection(send long message)
     * Use the callback method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_0600';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  let send = false;
                  clientConn.send('11111', (err: BusinessError) => {
                    if (err) {
                      console.error(`${caseName} send data failed, callback error: ${err.code} - ${err.message}`);
                      expect().assertFail();
                      rejectInner(err);
                    } else {
                      console.info(`${caseName} send data success: data:"11111"`);
                      send = true;
                      expect(send).assertTrue();
                      resolveInner();
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send failed: ${JSON.stringify(err)}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_0700
     * @tc.name ArKUIX_TLSSocketConnection_Send_0700
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_0700';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  let send = false;
                  try {
                    clientConn.send('Hello, TLSSocket Client!', null);
                    console.error(`${caseName} ERROR: Should have thrown exception when second param is null`);
                    send = true;
                    expect(send).assertTrue();
                    done();
                  } catch (err) {
                    console.error(`${caseName} Got expected exception: ${err.code} - ${err.message}`);
                    expect().assertFail();
                    done();
                  }
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send null failed: ${JSON.stringify(err)}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_0800
     * @tc.name ArKUIX_TLSSocketConnection_Send_0800
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_0800';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  let send = false;
                  try {
                    clientConn.send('Hello, TLSSocket Client!', undefined);
                    console.error(`${caseName} ERROR: Should have thrown exception when second param is undefined`);
                    send = true;
                    expect(send).assertTrue();
                    done();
                  } catch (err) {
                    console.error(`${caseName} Got expected exception: ${err.code} - ${err.message}`);
                    expect().assertFail();
                    done();
                  }
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send null failed: ${JSON.stringify(err)}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_0900
     * @tc.name ArKUIX_TLSSocketConnection_Send_0900
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_0900';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  let send = false;
                  try {
                    clientConn.send('Hello, TLSSocket Client!');
                    console.error(`${caseName} Should have thrown exception when second param is empty`);
                    send = true;
                    expect(send).assertTrue();
                    done();
                  } catch (err) {
                    console.error(`${caseName} Got expected exception: ${err.code} - ${err.message}`);
                    expect().assertFail();
                    done();
                  }
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send null failed: ${JSON.stringify(err)}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_1000
     * @tc.name ArKUIX_TLSSocketConnection_Send_1000
     * @tc.desc Sending data through TLSSocketServer connection. Use the promise method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_1000';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              let send = false;
              clientConn.send('Hello, TLSSocket Client!').then(() => {
                console.info(`${caseName} send data success，Promise then trigger:"Hello, TLSSocket Client!"`);
                send = true;
                expect(send).assertTrue();
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} send data fail，Promise catch error: ${err.code} - ${err.message}`);
                expect().assertFail();
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_1100
     * @tc.name ArKUIX_TLSSocketConnection_Send_1100
     * @tc.desc Sending data through TLSSocketServer connection.Use the promise method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_1100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        const sendArray = new Uint8Array([72, 101, 108, 108, 111, 32, 65, 114, 114, 97, 121]);
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  let send = false;
                  const dataToSend = sendArray.buffer;
                  clientConn.send(dataToSend).then(() => {
                    console.info(`${caseName} send Array，Promise then trigger: Array data:${Array.from(sendArray)}`);
                    send = true;
                    expect(send).assertTrue();
                    done();
                  }).catch((err: BusinessError) => {
                    console.error(`${caseName} send Array fail，Promise catch error: ${err.code} - ${err.message}`);
                    expect().assertFail();
                    done();
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send failed: ${JSON.stringify(err)}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_1200
     * @tc.name ArKUIX_TLSSocketConnection_Send_1200
     * @tc.desc When the test data is null, use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_1200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              try {
                clientConn.send(null).then(() => {
                  console.info(`${caseName} send null data success，Promise then promise`);
                  expect().assertFail();
                  done();
                })
              } catch (err) {
                console.error(`${caseName} send call exception:${err.code} - ${err.message}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_1300
     * @tc.name ArKUIX_TLSSocketConnection_Send_1300
     * @tc.desc When the test data is undefined, use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_1300';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              try {
                clientConn.send(undefined).then(() => {
                  console.info(`${caseName} send null data success，Promise then promise`);
                  expect().assertFail();
                  done();
                })
              } catch (err) {
                console.error(`${caseName} send call exception:${err.code} - ${err.message}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_1400
     * @tc.name ArKUIX_TLSSocketConnection_Send_1400
     * @tc.desc Sending data through TLSSocketServer connection(data is '')
     * Use the promise method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_1400';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);

              clientConn.send('').then(() => {
                console.info(`${caseName} send data success，Promise then trigger:" "`);
                expect().assertFail();
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} send data fail，Promise catch error: ${err.code} - ${err.message}`);
                const errCode = Number(err.code);
                expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_1500
     * @tc.name ArKUIX_TLSSocketConnection_Send_1500
     * @tc.desc Sending data through TLSSocketServer connection(send long message)
     * Use the promise method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_1500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              let send = false;
              clientConn.send('11111').then(() => {
                console.info(`${caseName} send data success，Promise then trigger:"11111"`);
                send = true;
                expect(send).assertTrue();
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} send data fail，Promise catch error: ${err.code} - ${err.message}`);
                expect().assertFail();
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_1600
     * @tc.name ArKUIX_TLSSocketConnection_Send_1600
     * @tc.desc Sending data through TLSSocketServer connection(Send the normal data again after
     * the send content is empty) Use the callback method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_1600';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              const emptyData = '';
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  clientConn.send(emptyData, (err: BusinessError) => {
                    if (err) {
                      console.error(`${caseName} first send empty data fail,error: ${err.code} - ${err.message}`);
                      const errCode = Number(err.code);
                      expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
                    } else {
                      console.info(`${caseName} first send empty data success,data is empty`);
                      expect().assertFail();
                    }
                    resolveInner();
                  });
                });
              })().then(() => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  const normalData = 'Hello, TLSSocket Client!';
                  clientConn.send(normalData, (err: BusinessError) => {
                    let send = false;
                    if (err) {
                      console.error(`${caseName} second send empty data fail,error: ${err.code} - ${err.message}`);
                      expect().assertFail();
                      rejectInner(err);
                    } else {
                      console.info(`${caseName} second send empty data success,data is empty"${normalData}"`);
                      send = true;
                      expect(send).assertTrue();
                      resolveInner();
                    }
                  });
                });
              }).then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send failed: ${JSON.stringify(err)}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_1700
     * @tc.name ArKUIX_TLSSocketConnection_Send_1700
     * @tc.desc Sending data through TLSSocketServer connection(repetition send long message)
     * Use the callback method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_1700';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              const firstData = 'Hello, TLSSocket Client!';
              (async (): Promise<void> => {
                clientConn.send(firstData, (err: BusinessError) => {
                  if (err) {
                    console.error(`${caseName} first send empty data fail,error: ${err.code} - ${err.message}`);
                  } else {
                    console.info(`${caseName} first send empty data success,data is empty`);
                  }
                });
              })().then(() => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  const secondData = 'again:Hello, TLSSocket Client!';
                  clientConn.send(secondData, (err: BusinessError) => {
                    let send = false;
                    if (err) {
                      console.error(`${caseName} second send empty data fail,error: ${err.code} - ${err.message}`);
                      expect().assertFail();
                      rejectInner(err);
                    } else {
                      console.info(`${caseName} second send empty data success,data is empty"${secondData}"`);
                      send = true;
                      expect(send).assertTrue();
                      resolveInner();
                    }
                  });
                });
              }).then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send failed: ${JSON.stringify(err)}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_1800
     * @tc.name ArKUIX_TLSSocketConnection_Send_1800
     * @tc.desc Sending data through TLSSocketServer connection(Send the normal data again after the send
     * content is empty) Use the promise method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_1800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_1800';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              const emptyData = '';
              const normalData = 'Hello,TLSSocketClient!';
              (async (): Promise<void> => {
                await clientConn.send(emptyData);
                console.info(`${caseName} first send empty data success,Promise then trigger:data is empty`);

                await clientConn.send(normalData);
                console.info(`${caseName} second send normal data success,Promise then,data：${normalData}`);
              })().catch((err: BusinessError) => {
                console.error(`${caseName} send data fail,Promise catch error: ${err.code} - ${err.message}`);
                const errCode = Number(err.code);
                expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_1900
     * @tc.name ArKUIX_TLSSocketConnection_Send_1900
     * @tc.desc Sending data through TLSSocketServer connection(twice Send)
     * Use the promise method as the asynchronous method.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_1900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_1900';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              const firstData = 'Hello, TLSSocket Client!';
              const secondData = 'again:Hello, TLSSocket Client!';
              let send = false;
              (async (): Promise<void> => {
                await clientConn.send(firstData);
                console.info(`${caseName} first send empty data success,Promise then trigger:data is empty`);

                await clientConn.send(secondData);
                console.info(`${caseName} second send normal data success,Promise then,data：${secondData}`);
                send = true;
                expect(send).assertTrue();
                done();
              })().catch((err: BusinessError) => {
                console.error(`${caseName} send data fail,Promise catch error: ${err.code} - ${err.message}`);
                expect().assertFail();
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
     * @tc.number ArKUIX_TLSSocketConnection_Send_2000
     * @tc.name ArKUIX_TLSSocketConnection_Send_2000
     * @tc.desc Do not monitor the service for testing,Use Callback asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_2000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_2000';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
          const port = getNextPort();
          const netAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: port
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
            port: port
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: connectAddr,
            secureOptions: TlsClientOptions,
            ALPNProtocols: ["spdy/1", "http/1.1"],
            skipRemoteValidation: true
          };
          tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
            console.info(`${caseName} Client connection detected (this should not happen)`);
            const testData = 'Hello, TLSSocket Client!';
            clientConn.send(testData).then(() => {
              console.info(`${caseName} send data success (unexpected)`);
              expect().assertFail();
              done();
            }).catch((err: BusinessError) => {
              console.error(`${caseName} send data fail: ${err.code} - ${err.message}`);
              expect().assertFail();
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
            try {
              await tlsClient.connect(connectOptions);
              console.info(`${caseName} connect successfully (unexpected)`);
            } catch (err) {
              const error = err as BusinessError;
              console.error(`${caseName} connect fail: ${error.code} - ${error.message}`);
              const errCode = Number(err.code);
              expect(errCode === 2303501).assertTrue;
              done();
            }
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
        }
      });

    /**
     * @tc.number ArKUIX_TLSSocketConnection_Send_2100
     * @tc.name ArKUIX_TLSSocketConnection_Send_2100
     * @tc.desc Send an empty ip,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Send_2100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Send_2100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
          const port = getNextPort();
          const netAddress: socket.NetAddress = {
            address: '',
            port: port
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
            port: port
          };
          const connectOptions: socket.TLSConnectOptions = {
            address: connectAddr,
            secureOptions: TlsClientOptions,
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  let send = false;
                  clientConn.send('Hello, TLSSocket Client!', (err: BusinessError) => {
                    if (err) {
                      console.error(`${caseName} send data failed, callback error: ${err.code} - ${err.message}`);
                      expect().assertFail();
                      rejectInner(err);
                    } else {
                      console.info(`${caseName} send data success: data:"Hello, TLSSocket Client!"`);
                      send = true;
                      expect(send).assertTrue();
                      resolveInner();
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Send failed: ${JSON.stringify(err)}`);
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
                  expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
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
     * @tc.number ArKUIX_TLSSocketConnection_Close_0100
     * @tc.name ArKUIX_TLSSocketConnection_Close_0100
     * @tc.desc Test the functionality of the close interface function using the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Close_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Close_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              let close = false;
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  clientConn.close((err: BusinessError) => {
                    if (err) {
                      console.error(`${caseName} connect close fail,error: ${err.code} - ${err.message}`);
                      expect().assertFalse();
                      rejectInner(err);
                    } else {
                      console.info(`${caseName} connect close success,callback trigger`);
                      close = true;
                      expect(close).assertTrue();
                      resolveInner();
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Connect close failed: ${JSON.stringify(err)}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_Close_0200
     * @tc.name ArKUIX_TLSSocketConnection_Close_0200
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Close_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Close_0200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              clientConn.on('error', (err: BusinessError) => {
                console.error(`${caseName} abnormal connection operation: ${err.code} - ${err.message}`);
                expect().assertFail();
                done();
              });
              try {
                clientConn.close(null);
              } catch (err) {
                const error = err as BusinessError;
                console.error(`${caseName} close method threw error: ${error.code} - ${error.message}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_Close_0300
     * @tc.name ArKUIX_TLSSocketConnection_Close_0300
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Close_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Close_0300';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              clientConn.on('error', (err: BusinessError) => {
                console.error(`${caseName} abnormal connection operation: ${err.code} - ${err.message}`);
                expect().assertFail();
                done();
              });
              try {
                clientConn.close(undefined);
              } catch (err) {
                const error = err as BusinessError;
                console.error(`${caseName} close method threw error: ${error.code} - ${error.message}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_Close_0400
     * @tc.name ArKUIX_TLSSocketConnection_Close_0400
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Close_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Close_0400';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              clientConn.on('error', (err: BusinessError) => {
                console.error(`${caseName} abnormal connection operation: ${err.code} - ${err.message}`);
                expect().assertFail();
                done();
              });
              let close = false;
              try {
                clientConn.close();
                close = true;
                expect(close).assertTrue();
                done();
              } catch (err) {
                const error = err as BusinessError;
                console.error(`${caseName} close method threw error: ${error.code} - ${error.message}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_Close_0500
     * @tc.name ArKUIX_TLSSocketConnection_Close_0500
     * @tc.desc Test the functionality of the close interface function using the prommise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_Close_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_Close_0500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
              console.info(`${caseName} Client connection detected: ${JSON.stringify(clientConn.getRemoteAddress)}`);
              (async (): Promise<void> => {
                return new Promise<void>((resolveInner, rejectInner) => {
                  let close = false;
                  clientConn.close().then(() => {
                    console.info(`${caseName} connect close success,callback trigger`);
                    close = true;
                    expect(close).assertTrue();
                    resolveInner();
                  }).catch((err: BusinessError) => {
                    console.error(`${caseName} connect close fail,error: ${err.code} - ${err.message}`);
                    expect().assertFail();
                    rejectInner(err);
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} Connect close failed: ${JSON.stringify(err)}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteAddress_0100
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteAddress_0100
     * @tc.desc Test the functionality of the getRemoteAddress interface function
     * using the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteAddress_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteAddress_0100';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
                  clientConn.getRemoteAddress((err: BusinessError, remoteAddr: socket.NetAddress) => {
                    if (err) {
                      console.error(`${caseName} Failed to obtain the remote address,error:
                      ${err.code} - ${err.message}`);
                      expect().assertFail();
                      reject(err);
                    } else {
                      console.info(`${caseName} remote address was successfully obtained，address:
                      ${JSON.stringify(remoteAddr)}`);
                      expect(remoteAddr != undefined).assertTrue();
                      resolve();
                    }
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} GetRemoteAddress failed: ${JSON.stringify(err)}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteAddress_0200
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteAddress_0200
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteAddress_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteAddress_0200';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
                try {
                  clientConn.getRemoteAddress(undefined);
                  console.info(`${caseName} no error`);
                  expect().assertFail();
                  done();
                } catch (err) {
                  const error = err as BusinessError;
                  console.error(`${caseName} error: ${error.code} - ${error.message}`);
                  const errCode = Number(error.code);
                  expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
                  done();
                }
              })();
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
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteAddress_0300
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteAddress_0300
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteAddress_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteAddress_0300';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
                try {
                  clientConn.getRemoteAddress(null);
                  console.info(`${caseName} no error`);
                  expect().assertFail();
                  done();
                } catch (err) {
                  const error = err as BusinessError;
                  console.error(`${caseName} error: ${error.code} - ${error.message}`);
                  const errCode = Number(error.code);
                  expect(errCode === SocketErrorCodes.ERR_CODE_PARAMETER_ERROR).assertTrue();
                  done();
                }
              })();
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
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteAddress_0400
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteAddress_0400
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteAddress_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteAddress_0400';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
                let getRemoteAddress = false;
                try {
                  clientConn.getRemoteAddress();
                  console.info(`${caseName} no error`);
                  getRemoteAddress = true;
                  expect(getRemoteAddress).assertTrue();
                  done();
                } catch (err) {
                  const error = err as BusinessError;
                  console.error(`${caseName} error: ${error.code} - ${error.message}`);
                  expect().assertFail();
                  done();
                }
              })();
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
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteAddress_0500
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteAddress_0500
     * @tc.desc Test the functionality of the getRemoteAddress interface function
     * using the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteAddress_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteAddress_0500';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
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
                  clientConn.getRemoteAddress().then((remoteAddr: socket.NetAddress) => {
                    console.info(`${caseName} remote address is obtained successfully. Promise then triggered,address:
                    ${JSON.stringify(remoteAddr)}`);
                    expect(remoteAddr != undefined).assertTrue();
                    resolve();
                  }).catch((err: BusinessError) => {
                    console.error(`${caseName} fail to obtain remote address,promise catch error:
                    ${err.code} - ${err.message}`);
                    expect(true).assertFalse();
                    reject(err);
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} GetRemoteAddress failed: ${JSON.stringify(err)}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteAddress_0600
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteAddress_0600
     * @tc.desc Test the interface before listen,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteAddress_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteAddress_0600';
        let tlsServer: socket.TLSSocketServer = socket.constructTLSSocketServerInstance();
        let tlsClient: socket.TLSSocket = socket.constructTLSSocketInstance();
        try {
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tlsServer.on('connect', (clientConn: socket.TLSSocketConnection) => {
                console.info(`${caseName} Client connection detected`);
                (async (): Promise<void> => {
                  return new Promise<void>((resolve, reject) => {
                    clientConn.getRemoteAddress().then((remoteAddr: socket.NetAddress) => {
                      console.info(`${caseName} remote address is obtained successfully. Promise then triggered,address:
                       ${JSON.stringify(remoteAddr)}`);
                      expect().assertFail();
                      resolve();
                    }).catch((err: BusinessError) => {
                      console.error(`${caseName} fail to obtain remote address,promise catch error:
                       ${err.code} - ${err.message}`);
                      expect().assertFail();
                      reject(err);
                    });
                  });
                })().then(() => {
                  done();
                }).catch((err: BusinessError) => {
                  console.error(`${caseName} GetRemoteAddress failed: ${JSON.stringify(err)}`);
                  done();
                });
              });

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
              expect(errCode === 2303501 || errCode === 2303600).assertTrue();
              done();
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
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
     * @tc.number ArKUIX_TLSSocketConnection_GetRemoteAddress_0700
     * @tc.name ArKUIX_TLSSocketConnection_GetRemoteAddress_0700
     * @tc.desc Ca is empty,Use Promise asynchronous callback.
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TLSSocketConnection_GetRemoteAddress_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TLSSocketConnection_GetRemoteAddress_0700';
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
                return new Promise<void>((resolveInner, rejectInner) => {
                  clientConn.getRemoteAddress().then((remoteAddr: socket.NetAddress) => {
                    console.info(`${caseName} remote address is obtained successfully. Promise then triggered,address:
                     ${JSON.stringify(remoteAddr)}`);
                    resolveInner();
                  }).catch((err: BusinessError) => {
                    console.error(`${caseName} fail to obtain remote address,promise catch error:
                    ${err.code} - ${err.message}`);
                    rejectInner(err);
                  });
                });
              })().then(() => {
                done();
              }).catch((err: BusinessError) => {
                console.error(`${caseName} GetRemoteAddress failed: ${JSON.stringify(err)}`);
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
                expect(errCode === 2303501 || errCode === 2303600).assertTrue();
                done();
              });
            });
          }).catch((err: BusinessError) => {
            console.error(`${caseName} operation failed: ${JSON.stringify(err)}`);
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
  })
}