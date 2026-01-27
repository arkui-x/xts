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

import { hilog } from '@kit.PerformanceAnalysisKit';
import { describe, beforeAll, beforeEach, afterEach, afterAll, it, expect, Level, Size, TestType } from '@ohos/hypium';
import { socket, webSocket } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import assertNull from '@ohos/hypium/src/main/module/assert/assertNull';
import { data } from '@kit.TelephonyKit';

const WEB_SOCKET_ERROR_FILE_NOT_EXIST = 2302002;
const WEB_SOCKET_ERROR_UNKNOWN = 2302999;
const ERR_CODE_PARAMETER_ERROR = 401;
const WEB_SOCKET_ERROR_BIND_PORT_FAILED = 2302005;

let serverConfig: webSocket.WebSocketServerConfig = {
  serverIP: "0.0.0.0",
  serverPort: 8088,
  maxConcurrentClientsNumber: 10,
  maxConnectionsForOneClient: 4,
}

function sleep(time: number): Promise<string> {
  return new Promise<string>((resolve) => {
    setTimeout(() => {
      resolve('ok')
    }, time)
  });
}

export default function WebSocketTest_2() {
  describe('WebSocketTest_2', () => {
    afterEach(async () => {
      await sleep(500);
    });

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_0600
     * @tc.name ArKUIX_WebSocketServer_Start_0600
     * @tc.desc Start a WebSocketServer(CertPath is empty)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_0600';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            let serverCert: webSocket.ServerCert = {
              certPath: "",
              keyPath: "/etc/certs/server.key"
            }
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8087,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
              protocol: "my-protocol",
              serverCert: serverCert,
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
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_0700
     * @tc.name ArKUIX_WebSocketServer_Start_0700
     * @tc.desc Start a WebSocketServer(errorCode:2302002)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_0700';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            let serverCert: webSocket.ServerCert = {
              certPath: "11111",
              keyPath: "/etc/certs/server.key"
            }
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8087,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
              protocol: "my-protocol",
              serverCert: serverCert,
            }
            server.start(serverConfig).then((success: boolean) => {
              expect().assertFail();
              done();
            }).catch((error: BusinessError) => {
              console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
              const errCode = Number(error.code);
              expect(errCode === WEB_SOCKET_ERROR_FILE_NOT_EXIST).assertTrue();
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_0800
     * @tc.name ArKUIX_WebSocketServer_Start_0800
     * @tc.desc Start a WebSocketServer(errorCode:2302002)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_0800';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            let serverCert: webSocket.ServerCert = {
              certPath: "/etc/certs/server.key",
              keyPath: ""
            }
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8087,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
              protocol: "my-protocol",
              serverCert: serverCert,
            }
            server.start(serverConfig).then((success: boolean) => {
              expect().assertFail();
              done();
            }).catch((error: BusinessError) => {
              console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
              const errCode = Number(error.code);
              expect(errCode === WEB_SOCKET_ERROR_FILE_NOT_EXIST).assertTrue();
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_0900
     * @tc.name ArKUIX_WebSocketServer_Start_0900
     * @tc.desc Start a WebSocketServer(errorCode:2302002)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_0900';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            let serverCert: webSocket.ServerCert = {
              certPath: "/etc/certs/server.key",
              keyPath: "11111"
            }
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8087,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
              protocol: "my-protocol",
              serverCert: serverCert,
            }
            server.start(serverConfig).then((success: boolean) => {
              expect().assertFail();
              done();
            }).catch((error: BusinessError) => {
              console.error(`${caseName} failed, error111: ${error.code}, ${error.message}`);
              const errCode = Number(error.code);
              expect(errCode === WEB_SOCKET_ERROR_FILE_NOT_EXIST).assertTrue();
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error222 ${JSON.stringify(err)}`);
          const errCode = Number(err.code);
          expect(errCode === WEB_SOCKET_ERROR_FILE_NOT_EXIST).assertTrue();
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_1000
     * @tc.name ArKUIX_WebSocketServer_Start_1000
     * @tc.desc Start a WebSocketServer(ServerCert is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_1000';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8087,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
              serverCert: undefined,
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
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_1100
     * @tc.name ArKUIX_WebSocketServer_Start_1100
     * @tc.desc Start a WebSocketServer(protocol is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_1100';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8087,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
              protocol: undefined,
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
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_1200
     * @tc.name ArKUIX_WebSocketServer_Start_1200
     * @tc.desc Start a WebSocketServer(protocol is empty)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_1200';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8087,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
              protocol: "",
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
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_1300
     * @tc.name ArKUIX_WebSocketServer_Start_1300
     * @tc.desc Start a WebSocketServer(protocol is 11111)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_1300';
        console.info(`${caseName} test start`);
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8087,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
              protocol: "11111",
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
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_1400
     * @tc.name ArKUIX_WebSocketServer_Start_1400
     * @tc.desc Start a WebSocketServer(maxConcurrentClientsNumber is 0)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_1400';
        console.info(`${caseName} test start`);
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8087,
              maxConcurrentClientsNumber: 0,
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
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_1500
     * @tc.name ArKUIX_WebSocketServer_Start_1500
     * @tc.desc Start a WebSocketServer(maxConcurrentClientsNumber is 10)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_1500';
        console.info(`${caseName} test start`);
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
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_1600
     * @tc.name ArKUIX_WebSocketServer_Start_1600
     * @tc.desc Start a WebSocketServer (errorCode:2302999)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_1600';
        console.info(`${caseName} test start`);
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8087,
              maxConcurrentClientsNumber: -1,
              maxConnectionsForOneClient: 4,
            }
            server.start(serverConfig).then((success: boolean) => {
              expect().assertFail();
              done();
            }).catch((error: BusinessError) => {
              console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
              const errCode = Number(error.code);
              expect(errCode === WEB_SOCKET_ERROR_UNKNOWN).assertTrue();
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_1700
     * @tc.name ArKUIX_WebSocketServer_Start_1700
     * @tc.desc Start a WebSocketServer (errorCode:2302999)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_1700';
        console.info(`${caseName} test start`);
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8087,
              maxConcurrentClientsNumber: 11,
              maxConnectionsForOneClient: 4,
            }
            server.start(serverConfig).then((success: boolean) => {
              expect().assertFail();
              done();
            }).catch((error: BusinessError) => {
              console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
              const errCode = Number(error.code);
              expect(errCode === WEB_SOCKET_ERROR_UNKNOWN).assertTrue();
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_1800
     * @tc.name ArKUIX_WebSocketServer_Start_1800
     * @tc.desc Start a WebSocketServer(maxConnectionsForOneClient is 0)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_1800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_1800';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8087,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 0,
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
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_1900
     * @tc.name ArKUIX_WebSocketServer_Start_1900
     * @tc.desc Start a WebSocketServer(maxConnectionsForOneClient is 10)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_1900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_1900';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8087,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 10,
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
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_2000
     * @tc.name ArKUIX_WebSocketServer_Start_2000
     * @tc.desc Start a WebSocketServer (errorCode:2302999)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_2000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_2000';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8087,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: -1,
            }
            server.start(serverConfig).then((success: boolean) => {
              expect().assertFail();
              done();
            }).catch((error: BusinessError) => {
              console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
              const errCode = Number(error.code);
              expect(errCode === WEB_SOCKET_ERROR_UNKNOWN).assertTrue();
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_2100
     * @tc.name ArKUIX_WebSocketServer_Start_2100
     * @tc.desc Start a WebSocketServer (errorCode:2302999)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_2100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_2100';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8087,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 11,
            }
            server.start(serverConfig).then((success: boolean) => {
              expect().assertFail();
              done();
            }).catch((error: BusinessError) => {
              console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
              const errCode = Number(error.code);
              expect(errCode === WEB_SOCKET_ERROR_UNKNOWN).assertTrue();
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_2200
     * @tc.name ArKUIX_WebSocketServer_Start_2200
     * @tc.desc Start a WebSocketServer(config Parameter error)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_2200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_2200';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            server.start(null).then((success: boolean) => {
              expect().assertFail();
              done();
            }).catch((error: BusinessError) => {
              console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
              const errCode = Number(error.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_2300
     * @tc.name ArKUIX_WebSocketServer_Start_2300
     * @tc.desc Start a WebSocketServer( config Parameter error)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_2300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_2300';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            server.start(undefined).then((success: boolean) => {
              expect().assertFail();
              done();
            }).catch((error: BusinessError) => {
              console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
              const errCode = Number(error.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_2500
     * @tc.name ArKUIX_WebSocketServer_Start_2500
     * @tc.desc Start a WebSocketServer (serverConfig contain protocol)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_2500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_2500';
        console.info(`${caseName} test start`);
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8087,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
              protocol: "my-protocol",
            }
            server.start(serverConfig).then((success: boolean) => {
              if (success) {
                expect(success).assertTrue();
                done();
                server.stop();
              } else {
                expect().assertFail();
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_2600
     * @tc.name ArKUIX_WebSocketServer_Start_2600
     * @tc.desc Start a WebSocketServer (serverConfig contain protocol and cert)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_2600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_2600';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            let serverCert: webSocket.ServerCert = {
              certPath: "/etc/certs/server.key",
              keyPath: "/etc/certs/server.key"
            }
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8087,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
              protocol: "my-protocol",
              serverCert: serverCert,
            }
            server.start(serverConfig).then((success: boolean) => {
              if (success) {
                expect(success).assertTrue();
                done();
                server.stop();
              } else {
                expect().assertFail();
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        } finally {
          if (server) {
            server.stop();
          }
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Start_2700
     * @tc.name ArKUIX_WebSocketServer_Start_2700
     * @tc.desc Start a WebSocketServer(errorCode:2302005)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Start_2700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Start_2700';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 65536,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
              protocol: "my-protocol",
            }
            await server.start(serverConfig).then((success: boolean) => {
              expect().assertFail();
              done();
            }).catch((error: BusinessError) => {
              console.info(`${caseName} failed, error: ${error.code}, ${error.message}`);
              const errCode = Number(error.code);
              expect(errCode === WEB_SOCKET_ERROR_BIND_PORT_FAILED).assertTrue();
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
     * @tc.number ArKUIX_WebSocketServer_ListAllConnections_0100
     * @tc.name ArKUIX_WebSocketServer_ListAllConnections_0100
     * @tc.desc WebSocketServer list all connections
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_ListAllConnections_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_ListAllConnections_0100';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8089,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            }
            await server.start(serverConfig).then((value: boolean) => {
              if (value) {
                console.info(`${caseName} server start`)
              } else {
                console.info(`${caseName} server start fail`)
                expect().assertFail();
                done()
              }
            }).catch((err: BusinessError) => {
              console.info(`${caseName} catch error ${JSON.stringify(err)}`);
              expect().assertFail();
              done();
            })
            let callback = (connection: webSocket.WebSocketConnection) => {
              console.info(`${caseName} connections-->+ ${JSON.stringify(connection)}`);
            }
            await server.on('connect', callback)
            await sleep(100)
            let client: webSocket.WebSocket = webSocket.createWebSocket()
            console.info(`${caseName}client-- >${client}`)
            await client.connect('ws://127.0.0.1:8089', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
                expect().assertFail();
                done()
              }
            })
            await sleep(1000)
            let connections = await server.listAllConnections()
            console.info(`${caseName} connections1-->+ ${JSON.stringify(connections)}`);
            if (connections) {
              console.info(`${caseName} connections2-->+ ${JSON.stringify(connections[0])}`)
              console.info(`${caseName} connections.length-->+ ${JSON.stringify(connections.length)}`);
              expect(connections.length > 0).assertTrue();
              server.stop()
              done()
            } else {
              expect().assertFail();
              server.stop()
              done()
            }
          }
        } catch (error) {
          console.info(`${caseName} error--${error}`)
          expect().assertFail();
          server.stop()
          done()
        }
        done();
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_ListAllConnections_0300
     * @tc.name ArKUIX_WebSocketServer_ListAllConnections_0300
     * @tc.desc WebSocketServer list all connections(null array)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_ListAllConnections_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_ListAllConnections_0300';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            expect().assertFail();
            done();
          } else {
            let serverConfig: webSocket.WebSocketServerConfig = {
              serverIP: "0.0.0.0",
              serverPort: 8089,
              maxConcurrentClientsNumber: 10,
              maxConnectionsForOneClient: 4,
            }
            await server.start(serverConfig).then((value: boolean) => {
              if (value) {
                console.info(`${caseName} server start`)
              } else {
                console.info(`${caseName} server start fail`)
                expect().assertFail();
                done();
              }
            }).catch((err: BusinessError) => {
              console.info(`${caseName} catch error ${JSON.stringify(err)}`);
              expect().assertFail();
              done();
            })
            let callback = (connection: webSocket.WebSocketConnection) => {
              console.info(`${caseName} connections-->+ ${JSON.stringify(connection)}`);
            }
            await server.on('connect', callback)
            await sleep(500)
            let client: webSocket.WebSocket = webSocket.createWebSocket()
            console.info(`${caseName}client-- >${client}`)
            client.connect('ws://127.0.0.1:8089', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
                expect().assertFail();
                done();
              }
            })
            await sleep(500);
            let connections = await server.listAllConnections()
            if (!connections) {
              expect().assertFail();
              done();
            } else {
              console.info(`${caseName} connections1-->+ ${JSON.stringify(connections[0])}`)
              await server.close(connections[0]).then((success: boolean) => {
                if (!success) {
                  expect().assertFail();
                  server.stop();
                  done();
                }
              })
              await sleep(200)
              connections = await server.listAllConnections()
              if (connections) {
                console.info(`${caseName} connections2-->+ ${JSON.stringify(connections[0])}`);
                console.info(`${caseName} connections.length-->+ ${JSON.stringify(connections.length)}`);
                expect(connections.length == 0).assertTrue();
                server.stop();
                done();
              } else {
                expect().assertFail();
                server.stop();
                done();
              }
            }
          }
        } catch (error) {
          expect().assertFail();
          done();
        } finally {
          if (server) {
            server.stop();
          }
        }
        done();
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Close_0100
     * @tc.name ArKUIX_WebSocketServer_Close_0100
     * @tc.desc WebSocketServer close a connection
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Close_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Close_0100';
        console.info(`${caseName} test start`);
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            await server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`);
              } else {
                console.log(`${caseName} client connect to server`);
                expect().assertFail();
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              expect().assertFail();
              done();
            });
            let client: webSocket.WebSocket = webSocket.createWebSocket();
            client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
                expect().assertFail();
                done();
              }
            });
            await sleep(500);
            let connections = await server.listAllConnections();
            if (!connections || connections.length == 0) {
              console.info(`${caseName} get connections fail`);
              done();
            } else {
              server.close(connections[0]).then((success: boolean) => {
                if (success) {
                  expect(success).assertTrue();
                  console.info(`${caseName} server close success`)
                  done();
                  server.stop();
                } else {
                  expect().assertFail();
                  done();
                  server.stop();
                }
              })
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Close_0200
     * @tc.name ArKUIX_WebSocketServer_Close_0200
     * @tc.desc WebSocketServer close a connection(Connection is null)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Close_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Close_0200';
        console.info(`${caseName} test start`);
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            await server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`);
              } else {
                console.log(`${caseName} client connect to server`);
                expect().assertFail();
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              expect().assertFail();
              done();
            });
            let client: webSocket.WebSocket = webSocket.createWebSocket();
            client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
                expect().assertFail();
                done();
              }
            });
            await sleep(500);
            server.close(null).then((success: boolean) => {
              expect().assertFail();
              done();
              server.stop();
            }).catch((error: BusinessError) => {
              console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
              const errCode = Number(error.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Close_0300
     * @tc.name ArKUIX_WebSocketServer_Close_0300
     * @tc.desc WebSocketServer close a connection(Connection is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Close_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Close_0300';
        console.info(`${caseName} test start`);
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            server.close(undefined).then((success: boolean) => {
              expect().assertFail();
              done();
              server.stop();
            }).catch((error: BusinessError) => {
              console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
              const errCode = Number(error.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            })
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Close_0400
     * @tc.name ArKUIX_WebSocketServer_Close_0400
     * @tc.desc WebSocketServer close a connection(options code is 1000)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Close_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Close_0400';
        console.info(`${caseName} test start`);
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            await server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`);
              } else {
                console.log(`${caseName} client connect to server`);
                expect().assertFail();
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              expect().assertFail();
              done();
            });
            let client: webSocket.WebSocket = webSocket.createWebSocket();
            client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
                expect().assertFail();
                done();
              }
            });
            await sleep(500);
            let connections = await server.listAllConnections();
            if (!connections || connections.length == 0) {
              console.info(`${caseName} get connections fail`);
              done();
            } else {
              let closeOptions: webSocket.WebSocketCloseOptions = {
                code: 1000,
                reason: "normal"
              };
              server.close(connections[0], closeOptions).then((success: boolean) => {
                if (success) {
                  expect(success).assertTrue();
                  console.info(`${caseName} server close success`);
                  done();
                  server.stop();
                } else {
                  expect().assertFail();
                  done();
                  server.stop();
                }
              })
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Close_0500
     * @tc.name ArKUIX_WebSocketServer_Close_0500
     * @tc.desc WebSocketServer close a connection(options code is 1001)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Close_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Close_0500';
        console.info(`${caseName} test start`);
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            await server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`);
              } else {
                expect().assertFail();
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              expect().assertFail();
              done();
            });
            let client: webSocket.WebSocket = webSocket.createWebSocket();
            client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
                expect().assertFail();
                done();
              }
            });
            await sleep(500);
            let connections = await server.listAllConnections();
            if (!connections || connections.length == 0) {
              console.info(`${caseName} get connections fail`);
              done();
            } else {
              let closeOptions: webSocket.WebSocketCloseOptions = {
                code: 1001,
                reason: "normal"
              };
              server.close(connections[0], closeOptions).then((success: boolean) => {
                if (success) {
                  expect(success).assertTrue();
                  done();
                  server.stop();
                } else {
                  expect().assertFail();
                  done();
                  server.stop();
                }
              })
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Close_0600
     * @tc.name ArKUIX_WebSocketServer_Close_0600
     * @tc.desc WebSocketServer close a connection(options code is -1)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Close_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Close_0600';
        console.info(`${caseName} test start`);
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            done();
          } else {
            await server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`);
              } else {
                console.log(`${caseName} client connect to server`);
                expect().assertFail();
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              expect().assertFail();
              done();
            });
            let client: webSocket.WebSocket = webSocket.createWebSocket();
            client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
                expect().assertFail();
                done();
              }
            });
            await sleep(500);
            let connections = await server.listAllConnections();
            if (!connections || connections.length == 0) {
              console.info(`${caseName} get connections fail`);
              done();
            } else {
              let closeOptions: webSocket.WebSocketCloseOptions = {
                code: -1,
                reason: "normal"
              };
              server.close(connections[0], closeOptions).then((success: boolean) => {
                if (success) {
                  expect(success).assertTrue();
                  console.info(`${caseName} server close success`);
                  done();
                  server.stop();
                } else {
                  expect().assertFail();
                  done();
                  server.stop();
                }
              })
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Close_0700
     * @tc.name ArKUIX_WebSocketServer_Close_0700
     * @tc.desc WebSocketServer close a connection(options code is 0)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Close_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Close_0700';
        console.info(`${caseName} test start`);
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            await server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`);
              } else {
                console.log(`${caseName} client connect to server`);
                expect().assertFail();
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              expect().assertFail();
              done();
            });
            let client: webSocket.WebSocket = webSocket.createWebSocket();
            client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
                expect().assertFail();
                done();
              }
            });
            await sleep(500);
            let connections = await server.listAllConnections();
            if (!connections || connections.length == 0) {
              console.info(`${caseName} get connections fail`);
              done();
            } else {
              let closeOptions: webSocket.WebSocketCloseOptions = {
                code: 0,
                reason: "normal"
              };
              server.close(connections[0], closeOptions).then((success: boolean) => {
                if (success) {
                  expect(success).assertTrue();
                  done();
                  server.stop();
                } else {
                  expect().assertFail();
                  done();
                  server.stop();
                }
              })
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Close_0800
     * @tc.name ArKUIX_WebSocketServer_Close_0800
     * @tc.desc WebSocketServer close a connection(options code is undefined)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Close_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Close_0800';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            await server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`);
              } else {
                expect().assertFail();
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              expect().assertFail();
              done();
            });
            let client: webSocket.WebSocket = webSocket.createWebSocket();
            client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
                expect().assertFail();
                done();
              }
            });
            await sleep(500);
            let connections = await server.listAllConnections();
            if (!connections || connections.length == 0) {
              console.info(`${caseName} get connections fail`);
              done();
            } else {
              let closeOptions: webSocket.WebSocketCloseOptions = {
                code: undefined,
                reason: "normal"
              };
              server.close(connections[0], closeOptions).then((success: boolean) => {
                expect().assertFail();
                done();
                server.stop();
              }).catch((error: BusinessError) => {
                console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
                const errCode = Number(error.code);
                expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
                done();
              })
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Close_0900
     * @tc.name ArKUIX_WebSocketServer_Close_0900
     * @tc.desc WebSocketServer close a connection(options reason is empty)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Close_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Close_0900';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            await server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`);
              } else {
                console.log(`${caseName} client connect to server`);
                expect().assertFail();
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              expect().assertFail();
              done();
            });
            let client: webSocket.WebSocket = webSocket.createWebSocket();
            client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
                expect().assertFail();
                done();
              }
            });
            await sleep(500);
            let connections = await server.listAllConnections();
            if (!connections || connections.length == 0) {
              console.info(`${caseName} get connections fail`);
              done();
            } else {
              let closeOptions: webSocket.WebSocketCloseOptions = {
                code: 1000,
                reason: ""
              };
              server.close(connections[0], closeOptions).then((success: boolean) => {
                if (success) {
                  expect(success).assertTrue();
                  done();
                  server.stop();
                } else {
                  expect().assertFail();
                  done();
                  server.stop();
                }
              })
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        }
      })

    /**
     * @tc.number ArKUIX_WebSocketServer_Close_1000
     * @tc.name ArKUIX_WebSocketServer_Close_1000
     * @tc.desc WebSocketServer close a connection(options reason is 11111)
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_WebSocketServer_Close_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_WebSocketServer_Close_1000';
        let server: webSocket.WebSocketServer = webSocket.createWebSocketServer();
        try {
          if (!server) {
            console.info(`${caseName} Server is nullptr`);
            done();
          } else {
            await server.start(serverConfig).then((success: boolean) => {
              if (success) {
                console.log(`${caseName} webSocketServer start success`);
              } else {
                console.log(`${caseName} client connect to server`);
                expect().assertFail();
                done();
              }
            }).catch((error: BusinessError) => {
              console.info(`${caseName} test result error ${JSON.stringify(error)}`);
              expect().assertFail();
              done();
            });
            let client: webSocket.WebSocket = webSocket.createWebSocket();
            client.connect('ws://127.0.0.1:8088', (err: BusinessError, value: boolean) => {
              if (value) {
                console.info(`${caseName} test connect success and value is ${value}`);
              } else {
                console.info(`${caseName} test connect fail ${JSON.stringify(err)}`);
                expect().assertFail();
                done();
              }
            });
            await sleep(500);
            let connections = await server.listAllConnections();
            if (!connections || connections.length == 0) {
              console.info(`${caseName} get connections fail`);
              done();
            } else {
              let closeOptions: webSocket.WebSocketCloseOptions = {
                code: 1000,
                reason: "11111"
              };
              server.close(connections[0], closeOptions).then((success: boolean) => {
                if (success) {
                  expect(success).assertTrue();
                  done();
                  server.stop();
                } else {
                  expect().assertFail();
                  done();
                  server.stop();
                }
              })
            }
          }
        } catch (err) {
          console.info(`${caseName} catch error ${JSON.stringify(err)}`);
          done();
        }
      })

  })
}
