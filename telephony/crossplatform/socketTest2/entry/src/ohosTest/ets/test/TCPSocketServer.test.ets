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
import deviceInfo from '@ohos.deviceInfo';


const ERR_CODE_PARAMETER_ERROR = 401;
const ERR_ADDRESS_NOT_AVAILABLE = 2303199;
const ERR_EIO = 2303105;
const ERR_BAD_FILE_DESCRIPTOR = 2303109;
const ERR_ADDRESS_NOT_SUPPORT = 2303197;
const ERR_NET_BAD_FILE_DESCRIPTOR = 2301009;

let platform: string = deviceInfo.osFullName.split(' ')[0];
let isAndroid: boolean = platform.includes("Android");
let isiOS: boolean = platform.includes("iOS");
let isOH: boolean = platform.includes("OpenHarmony");

function sleep(ms: number) {
  return new Promise<ESObject>(resolve => setTimeout(resolve, ms));
}

export default function TCPSocketServerTest() {
  describe('TCPSocketServerTest', () => {
    beforeEach(async () => {
      await sleep(500);
    });

    /**
     * @tc.number ArKUIX_TCPSocketServer_GetState_0100
     * @tc.name ArKUIX_TCPSocketServer_GetState_0100
     * @tc.desc Obtain the TCP Socket Server status after listening; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_GetState_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_GetState_0100';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }
        await tcpServer.listen(listenAddr).then(() => {
          console.info('GetState listen success');
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });

        try {
          tcpServer.getState((err: BusinessError, data: socket.SocketStateBase) => {
            console.info('getState success' + JSON.stringify(data));
            expect(data != null).assertTrue();
            tcpServer.close();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_GetState_0200
     * @tc.name ArKUIX_TCPSocketServer_GetState_0200
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_GetState_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_GetState_0200';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        try {
          tcpServer.getState(undefined);
          expect().assertFail();
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          done();
        } finally {
          tcpServer.close();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_GetState_0300
     * @tc.name ArKUIX_TCPSocketServer_GetState_0300
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_GetState_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_GetState_0300';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        try {
          tcpServer.getState(null);
          expect().assertFail();
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          done();
        } finally {
          tcpServer.close();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_GetState_0400
     * @tc.name ArKUIX_TCPSocketServer_GetState_0400
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_GetState_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_GetState_0400';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8081,
          family: 1
        }

        await tcpServer.listen(listenAddr).then(() => {
          console.info('GetState listen success');
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });

        try {
          tcpServer.getState().then((data: socket.SocketStateBase) => {
            console.info('getState success' + JSON.stringify(data));
            expect(data != null).assertTrue();
            tcpServer.close();
            done();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
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
     * @tc.number ArKUIX_TCPSocketServer_GetState_0500
     * @tc.name ArKUIX_TCPSocketServer_GetState_0500
     * @tc.desc Obtain the TCP Socket Server status after listening; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_GetState_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_GetState_0500';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8082,
          family: 1
        }

        await tcpServer.listen(listenAddr).then(() => {
          console.info('GetState listen success');
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });

        tcpServer.getState().then((data: socket.SocketStateBase) => {
          console.info('getState success' + JSON.stringify(data));
          expect(data != null).assertTrue();
          tcpServer.close();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_GetState_0600
     * @tc.name ArKUIX_TCPSocketServer_GetState_0600
     * @tc.desc Obtain TCPSocketService status without listening; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_GetState_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_GetState_0600';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        try {
          tcpServer.getState((err: BusinessError, data: socket.SocketStateBase) => {
            console.info('getState success' + JSON.stringify(data));
            expect(data != null).assertTrue();
            tcpServer.close();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_GetState_0700
     * @tc.name ArKUIX_TCPSocketServer_GetState_0700
     * @tc.desc Obtain TCPSocketService status without listening; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_GetState_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_GetState_0700';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        tcpServer.getState().then((data: socket.SocketStateBase) => {
          console.info('getState success' + JSON.stringify(data));
          expect(data != null).assertTrue();
          tcpServer.close();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_GetState_0800
     * @tc.name ArKUIX_TCPSocketServer_GetState_0800
     * @tc.desc Obtain the TCP Socket Server status after connect; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_GetState_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_GetState_0800';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8083,
          family: 1
        }

        tcpServer.listen(listenAddr).then(() => {
          console.info('GetState listen success');
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
        });

        let testClient: socket.TCPSocket = socket.constructTCPSocketInstance();
        const clientOpts: socket.TCPConnectOptions = {
          address: { address: '127.0.0.1', port: 8083, family: 1 } as socket.NetAddress,
        };

        testClient.connect(clientOpts, (err: BusinessError) => {
          if (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            return;
          }
          console.info('GetState connect success');
        });

        setTimeout(() => {
          try {
            tcpServer.getState((err: BusinessError, data: socket.SocketStateBase) => {
              console.info('GetState success' + JSON.stringify(data));
              expect(data != null).assertTrue();
              tcpServer.close();
            })
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
          done();
        }, 500);
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_GetState_0900
     * @tc.name ArKUIX_TCPSocketServer_GetState_0900
     * @tc.desc Obtain the TCP Socket Server status after connect; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_GetState_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_GetState_0900';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8084,
          family: 1
        }

        await tcpServer.listen(listenAddr).then(() => {
          console.info('GetState listen success');
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
        });

        let testClient: socket.TCPSocket = socket.constructTCPSocketInstance();
        const clientOpts: socket.TCPConnectOptions = {
          address: { address: '127.0.0.1', port: 8084, family: 1 } as socket.NetAddress,
        };

        testClient.connect(clientOpts, (err: BusinessError) => {
          if (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            return;
          }
          console.info('GetState connect success');
        });

        setTimeout(() => {
          tcpServer.getState().then((data: socket.SocketStateBase) => {
            console.info('GetState success' + JSON.stringify(data));
            expect(data != null).assertTrue();
            tcpServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          done();
        }, 500);
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_0100
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_0100
     * @tc.desc Set other properties of the TCP Socket Server connection after listening; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_0100';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8085,
          family: 1
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: true,
            OOBInline: true,
            TCPNoDelay: true,
            socketLinger: { on: true, linger: 10 } as SocketLinger,
            receiveBufferSize: 8192,
            sendBufferSize: 8192,
            reuseAddress: true,
            socketTimeout: 3000
          }
          let setExtraOptions = false;
          tcpServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
            tcpServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_0200
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_0200
     * @tc.desc Set other properties of the TCP Socket Server connection,keepAlive is false; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_0200';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8086,
          family: 1
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: false,
            OOBInline: true,
            TCPNoDelay: true,
            socketLinger: { on: true, linger: 10 } as SocketLinger,
            receiveBufferSize: 8192,
            sendBufferSize: 8192,
            reuseAddress: true,
            socketTimeout: 3000
          }
          let setExtraOptions = false;
          tcpServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
            tcpServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_0300
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_0300
     * @tc.desc Set other properties of the TCP Socket Server connection,keepAlive is undefined; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_0300';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: undefined,
            OOBInline: true,
            TCPNoDelay: true,
            socketLinger: { on: true, linger: 10 } as SocketLinger,
            receiveBufferSize: 8192,
            sendBufferSize: 8192,
            reuseAddress: true,
            socketTimeout: 3000
          }
          try {
            tcpServer.setExtraOptions(tcpExtraOptions).then(() => {
            }).catch((err: BusinessError) => {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
              done();
            });
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect(err.code == undefined).assertTrue();
            tcpServer.close();
            done();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_0400
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_0400
     * @tc.desc Set other properties of the TCP Socket Server connection,OOBlnLine is false; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_0400';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: true,
            OOBInline: false,
            TCPNoDelay: true,
            socketLinger: { on: true, linger: 10 } as SocketLinger,
            receiveBufferSize: 8192,
            sendBufferSize: 8192,
            reuseAddress: true,
            socketTimeout: 3000
          }
          let setExtraOptions = false;
          tcpServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
            tcpServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_0500
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_0500
     * @tc.desc Set other properties of the TCP Socket Server connection,OOBlnLine is undefined; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_0500';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: true,
            OOBInline: undefined,
            TCPNoDelay: true,
            socketLinger: { on: true, linger: 10 } as SocketLinger,
            receiveBufferSize: 8192,
            sendBufferSize: 8192,
            reuseAddress: true,
            socketTimeout: 3000
          }
          try {
            tcpServer.setExtraOptions(tcpExtraOptions).then(() => {
            }).catch((err: BusinessError) => {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
              done();
            });
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect(err.code == undefined).assertTrue();
            tcpServer.close();
            done();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_0600
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_0600
     * @tc.desc Set other properties of the TCP Socket Server connection,TCPNoDelay is false; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_0600';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: true,
            OOBInline: true,
            TCPNoDelay: false,
            socketLinger: { on: true, linger: 10 } as SocketLinger,
            receiveBufferSize: 8192,
            sendBufferSize: 8192,
            reuseAddress: true,
            socketTimeout: 3000
          }
          let setExtraOptions = false;
          tcpServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
            tcpServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }).finally(() => {
            done();
          });
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_0700
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_0700
     * @tc.desc Set other properties of the TCP Socket Server connection,TCPNoDelay is undefined; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_0700';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: true,
            OOBInline: true,
            TCPNoDelay: undefined,
            socketLinger: { on: true, linger: 10 } as SocketLinger,
            receiveBufferSize: 8192,
            sendBufferSize: 8192,
            reuseAddress: true,
            socketTimeout: 3000
          }
          try {
            tcpServer.setExtraOptions(tcpExtraOptions).then(() => {
            }).catch((err: BusinessError) => {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
              done();
            });
            expect().assertFail();
            done();
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect(err.code == undefined).assertTrue();
            tcpServer.close();
            done();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_0800
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_0800
     * @tc.desc Set other properties of the TCP Socket Server connection,linger is -1; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_0800';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: true,
            OOBInline: true,
            TCPNoDelay: true,
            socketLinger: { on: true, linger: -1 } as SocketLinger,
            receiveBufferSize: 8192,
            sendBufferSize: 8192,
            reuseAddress: true,
            socketTimeout: 3000
          }
          let setExtraOptions = false;
          tcpServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
            tcpServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_0900
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_0900
     * @tc.desc Set other properties of the TCP Socket Server connection,linger is 65536; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_0900';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: true,
            OOBInline: true,
            TCPNoDelay: true,
            socketLinger: { on: true, linger: 65536 } as SocketLinger,
            receiveBufferSize: 8192,
            sendBufferSize: 8192,
            reuseAddress: true,
            socketTimeout: 3000
          }
          let setExtraOptions = false;
          tcpServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
            tcpServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_1000
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_1000
     * @tc.desc Set other properties of the TCP Socket Server connection,on is false; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_1000';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: true,
            OOBInline: true,
            TCPNoDelay: true,
            socketLinger: { on: false, linger: 10 } as SocketLinger,
            receiveBufferSize: 8192,
            sendBufferSize: 8192,
            reuseAddress: true,
            socketTimeout: 3000
          }
          let setExtraOptions = false;
          tcpServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
            tcpServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_1100
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_1100
     * @tc.desc Set other properties of TCPSocketService connection in listen,input parameters are undefined;promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_1100';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }
        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: true,
            OOBInline: true,
            TCPNoDelay: true,
            socketLinger: undefined,
            receiveBufferSize: 8192,
            sendBufferSize: 8192,
            reuseAddress: true,
            socketTimeout: 3000
          }
          let setExtraOptions = false;
          tcpServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
            tcpServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_1200
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_1200
     * @tc.desc Set other properties of TCPSocketService connection in listen, input parameters are null; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_1200';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        try {
          tcpServer.setExtraOptions(null);
          console.info(`${caseName} setExtraOptions with null succeeded (unexpected)`);
          expect().assertFail();
          done();
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
          const errCode = Number(error.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          done();
        } finally {
          tcpServer.close();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_1300
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_1300
     * @tc.desc Set other properties of TCPSocketService connection in listen,input parameters are undefined;prommise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_1300';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();

        try {
          tcpServer.setExtraOptions(undefined);
          console.info(`${caseName} setExtraOptions with null succeeded (unexpected)`);
          expect().assertFail();
          done();
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
          const errCode = Number(error.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          done();
        } finally {
          tcpServer.close();
        }
      });

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_1500
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_1500
     * @tc.desc Set other properties of the TCP Socket Server connection after listening; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_1500';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 9090,
          family: 1
        }
        try {
          await (async (): Promise<void> => {
              tcpServer.listen(listenAddr, (err: BusinessError) => {
                if (err) {
                  console.info('listen fail');
                  return;
                }
                console.info('listen success');
              });
          })().then(async () => {
            interface SocketLinger {
              on: boolean;
              linger: number;
            }

            let tcpExtraOptions: socket.TCPExtraOptions = {
              keepAlive: true,
              OOBInline: true,
              TCPNoDelay: true,
              socketLinger: { on: true, linger: 10 } as SocketLinger,
              receiveBufferSize: 8192,
              sendBufferSize: 8192,
              reuseAddress: true,
              socketTimeout: 3000
            };

            await (async (): Promise<void> => {
                tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
                  if (err) {
                    console.error(`${caseName} setExtraOptions failed, error: ${err.code}, ${err.message}`);
                    return;
                  }
                  console.info(`${caseName} setExtraOptions success`);
                  expect(err == null).assertTrue();
                  tcpServer.close();
                  done();
                });
            })();
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
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_1600
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_1600
     * @tc.desc Set other properties of the TCP Socket Server connection,keepAlive is false; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_1600';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }
        try {
          await new Promise<void>((resolve, reject) => {
            tcpServer.listen(listenAddr, (err: BusinessError) => {
              if (err) {
                console.info('listen fail');
                reject(err);
                return;
              }
              console.info('listen success');
              resolve();
            });
          });

          interface SocketLinger {
            on: boolean;
            linger: number;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: false,
            OOBInline: true,
            TCPNoDelay: true,
            socketLinger: { on: true, linger: 10 } as SocketLinger,
            receiveBufferSize: 8192,
            sendBufferSize: 8192,
            reuseAddress: true,
            socketTimeout: 3000
          }

          await new Promise<void>((resolve, reject) => {
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
              if (err) {
                console.error(`${caseName} setExtraOptions failed, error: ${err.code}, ${err.message}`);
                reject(err);
                return;
              }
              console.info(`${caseName} setExtraOptions success`);
              expect(true).assertTrue();
              resolve();
            });
          });
        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test failed, error: ${error.code}, ${error.message}`);
          expect().assertFail();
        } finally {
          tcpServer.close();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_1700
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_1700
     * @tc.desc Set other properties of TCPSocketService connection in listen,input parameters are undefined;callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_1700';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }
        try {
          await (async (): Promise<void> => {
            return new Promise<void>((resolve, reject) => {
              tcpServer.listen(listenAddr, (err: BusinessError) => {
                if (err) {
                  console.info('listen fail');
                  reject(err);
                  return;
                }
                console.info('listen success');
                resolve();
              });
            });
          })().then(async () => {
            interface SocketLinger {
              on: boolean;
              linger: number;
            }

            let tcpExtraOptions: socket.TCPExtraOptions = {
              keepAlive: undefined,
              OOBInline: true,
              TCPNoDelay: true,
              socketLinger: { on: true, linger: 10 } as SocketLinger,
              receiveBufferSize: 8192,
              sendBufferSize: 8192,
              reuseAddress: true,
              socketTimeout: 3000
            }

            try {
              tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
              });
              expect().assertFail();

            } catch (err) {
              const error = err as BusinessError;
              console.error(`${caseName} failed, error: ${error.code}, ${error.message}`);
              expect(error.code == undefined).assertTrue();
            }
          }).catch((err: BusinessError) => {
            console.error(`${caseName} listen failed: ${JSON.stringify(err)}`);
            done();
          });

        } catch (err) {
          const error = err as BusinessError;
          console.error(`${caseName} test error: ${error.message}`);
          expect().assertFail();
          done();
        } finally {
          tcpServer.close();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_1800
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_1800
     * @tc.desc Set other properties of the TCP Socket Server connection,OOBlnLine is false; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_1800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_1800';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address:  '0.0.0.0',
          port: 8080,
          family: 1
        }
        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.info('listen fail');
            return;
          }

          interface SocketLinger {
            on: boolean;
            linger: number;
          }
          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: true,
            OOBInline: false,
            TCPNoDelay: true,
            socketLinger: { on: true, linger: 10 } as SocketLinger,
            receiveBufferSize: 8192,
            sendBufferSize: 8192,
            reuseAddress: true,
            socketTimeout: 3000
          }
          try{
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
              expect(err == null).assertTrue();
              tcpServer.close();
            });
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
            tcpServer.close();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_1900
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_1900
     * @tc.desc Set other properties of TCPSocketService connection in listen,input parameters are undefined;callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_1900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_1900';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address:  '0.0.0.0',
          port: 8080,
          family: 1
        }
        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.info('listen fail');
            return;
          }

          interface SocketLinger {
            on: boolean;
            linger: number;
          }
          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: true,
            OOBInline: undefined,
            TCPNoDelay: true,
            socketLinger: { on: true, linger: 10 } as SocketLinger,
            receiveBufferSize: 8192,
            sendBufferSize: 8192,
            reuseAddress: true,
            socketTimeout: 3000
          }
          try{
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {});
            expect().assertFail();
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect(err.code == undefined).assertTrue();
            tcpServer.close();
            done();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_2000
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_2000
     * @tc.desc Set other properties of the TCP Socket Server connection,TCPNoDelay is false; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_2000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_2000';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address:  '0.0.0.0',
          port: 8080,
          family: 1
        }
        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.info('listen fail');
            return;
          }

          interface SocketLinger {
            on: boolean;
            linger: number;
          }
          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: true,
            OOBInline: true,
            TCPNoDelay: false,
            socketLinger: { on: true, linger: 10 } as SocketLinger,
            receiveBufferSize: 8192,
            sendBufferSize: 8192,
            reuseAddress: true,
            socketTimeout: 3000
          }
          try{
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
              expect(err == null).assertTrue();
              tcpServer.close();
            });
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_2100
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_2100
     * @tc.desc Set other properties of TCPSocketService connection in listen,input parameters are undefined;callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_2100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_2100';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address:  '0.0.0.0',
          port: 8080,
          family: 1
        }
        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.info('listen fail');
            return;
          }

          interface SocketLinger {
            on: boolean;
            linger: number;
          }
          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: true,
            OOBInline: true,
            TCPNoDelay: undefined,
            socketLinger: { on: true, linger: 10 } as SocketLinger,
            receiveBufferSize: 8192,
            sendBufferSize: 8192,
            reuseAddress: true,
            socketTimeout: 3000
          }
          try{
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {});
            expect().assertFail();
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect(err.code == undefined).assertTrue();
            tcpServer.close();
            done();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_2200
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_2200
     * @tc.desc Set other properties of the TCP Socket Server connection,linger is -1; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_2200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_2200';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address:  '0.0.0.0',
          port: 8080,
          family: 1
        }
        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.info('listen fail');
            return;
          }

          interface SocketLinger {
            on: boolean;
            linger: number;
          }
          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: true,
            OOBInline: true,
            TCPNoDelay: true,
            socketLinger: { on: true, linger: -1 } as SocketLinger,
            receiveBufferSize: 8192,
            sendBufferSize: 8192,
            reuseAddress: true,
            socketTimeout: 3000
          }
          try{
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
              expect(err == null).assertTrue();
              tcpServer.close();
            });
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_2300
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_2300
     * @tc.desc Set other properties of the TCP Socket Server connection,linger is 65536; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_2300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_2300';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address:  '0.0.0.0',
          port: 8080,
          family: 1
        }
        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.info('listen fail');
            return;
          }

          interface SocketLinger {
            on: boolean;
            linger: number;
          }
          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: true,
            OOBInline: true,
            TCPNoDelay: true,
            socketLinger: { on: true, linger: 65536 } as SocketLinger,
            receiveBufferSize: 8192,
            sendBufferSize: 8192,
            reuseAddress: true,
            socketTimeout: 3000
          }
          try{
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
              expect(err == null).assertTrue();
              tcpServer.close();
            });
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_2400
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_2400
     * @tc.desc Set other properties of the TCP Socket Server connection,on is false; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_2400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_2400';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address:  '0.0.0.0',
          port: 8080,
          family: 1
        }
        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.info('listen fail');
            return;
          }

          interface SocketLinger {
            on: boolean;
            linger: number;
          }
          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: true,
            OOBInline: true,
            TCPNoDelay: true,
            socketLinger: { on: false, linger: 10 } as SocketLinger,
            receiveBufferSize: 8192,
            sendBufferSize: 8192,
            reuseAddress: true,
            socketTimeout: 3000
          }
          try{
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
              expect(err == null).assertTrue();
              tcpServer.close();
            });
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_2500
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_2500
     * @tc.desc Set other properties of TCPSocketService connection in listen,input parameters are undefined;callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_2500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_2500';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address:  '0.0.0.0',
          port: 8080,
          family: 1
        }
        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.info('listen fail');
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: true,
            OOBInline: true,
            TCPNoDelay: true,
            socketLinger: undefined,
            receiveBufferSize: 8192,
            sendBufferSize: 8192,
            reuseAddress: true,
            socketTimeout: 3000
          }
          try{
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
              expect(err == null).assertTrue();
              tcpServer.close();
            });
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_2600
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_2600
     * @tc.desc Set other properties of TCPSocketService connection in listen, input parameters are null;callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_2600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_2600';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        try {
          tcpServer.setExtraOptions(null, (err: BusinessError) => {
          });
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          tcpServer.close();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_2700
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_2700
     * @tc.desc Set other properties of TCPSocketService connection in listen,input parameters are undefined;callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_2700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_2700';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        try {
          tcpServer.setExtraOptions(undefined, (err: BusinessError) => {
          });
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          tcpServer.close();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_2800
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_2800
     * @tc.desc Set other properties of TCPSocketService connection in listen,input parameters are undefined;callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_2800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_2800';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address:  '0.0.0.0',
          port: 8080,
          family: 1
        }
        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.info('listen fail');
            return;
          }

          interface SocketLinger {
            on: boolean;
            linger: number;
          }
          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: true,
            OOBInline: true,
            TCPNoDelay: true,
            socketLinger: { on: true, linger: 10 } as SocketLinger,
            receiveBufferSize: 8192,
            sendBufferSize: 8192,
            reuseAddress: true,
            socketTimeout: 3000
          }
          let setExtraOptions = false;
          try{
            tcpServer.setExtraOptions(tcpExtraOptions,).then(() => {
              setExtraOptions = true;
              expect(setExtraOptions).assertTrue();
              tcpServer.close();
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
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_2900
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_2900
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_2900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_2900';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();

          interface SocketLinger {
            on: boolean;
            linger: number;
          }
          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: true,
            OOBInline: true,
            TCPNoDelay: true,
            socketLinger: { on: true, linger: 10 } as SocketLinger,
            receiveBufferSize: 8192,
            sendBufferSize: 8192,
            reuseAddress: true,
            socketTimeout: 3000
          }
          try{
            tcpServer.setExtraOptions(tcpExtraOptions, undefined);
            expect().assertFail();
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            const errCode = Number(err.code);
            expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
            tcpServer.close();
          }
          done();
        })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_3000
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_3000
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_3000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_3000';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();

          interface SocketLinger {
            on: boolean;
            linger: number;
          }
          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: true,
            OOBInline: true,
            TCPNoDelay: true,
            socketLinger: { on: true, linger: 10 } as SocketLinger,
            receiveBufferSize: 8192,
            sendBufferSize: 8192,
            reuseAddress: true,
            socketTimeout: 3000
          }
          try{
            tcpServer.setExtraOptions(tcpExtraOptions, null);
            expect().assertFail();
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            const errCode = Number(err.code);
            expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
            tcpServer.close();
          }
          done();
        })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_3100
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_3100
     * @tc.desc Set other properties of the TCP Socket Server connection,before listen; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_3100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_3100';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: true,
          OOBInline: true,
          TCPNoDelay: true,
          socketLinger: { on: true, linger: 10 } as SocketLinger,
          receiveBufferSize: 8192,
          sendBufferSize: 8192,
          reuseAddress: true,
          socketTimeout: 3000
        }

        try{
          tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
            if(err){
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_BAD_FILE_DESCRIPTOR).assertTrue();
              tcpServer.close();
            }else{
              expect().assertFail();
              done();
            }
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_3200
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_3200
     * @tc.desc Set other properties of the TCP Socket Server connection,before listen; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_3200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_3200';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();

        interface SocketLinger {
          on: boolean;
          linger: number;
        }

        let tcpExtraOptions: socket.TCPExtraOptions = {
          keepAlive: true,
          OOBInline: true,
          TCPNoDelay: true,
          socketLinger: { on: true, linger: 10 } as SocketLinger,
          receiveBufferSize: 8192,
          sendBufferSize: 8192,
          reuseAddress: true,
          socketTimeout: 3000
        }
        tcpServer.setExtraOptions(tcpExtraOptions).then(() => {
          expect().assertFail();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_BAD_FILE_DESCRIPTOR).assertTrue();
          tcpServer.close();
        });
        done();
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_3300
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_3300
     * @tc.desc Set other properties of the TCP Socket Server connection,keepAlive is true; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_3300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_3300';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address:  '0.0.0.0',
          port: 8080,
          family: 1
        }
        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: true,
          }

          try{
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
              expect(err == null).assertTrue();
              tcpServer.close();
            });
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_3400
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_3400
     * @tc.desc Set other properties of the TCP Socket Server connection,OOBlnLine is true; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_3400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_3400';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address:  '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            OOBInline: true,
          }

          try{
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
              expect(err == null).assertTrue();
              tcpServer.close();
            });
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_3500
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_3500
     * @tc.desc Set other properties of the TCP Socket Server connection,TCPNoDelay is true; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_3500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_3500';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address:  '0.0.0.0',
          port: 8080,
          family: 1
        }
        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            TCPNoDelay: true,
          }

          try{
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
              expect(err == null).assertTrue();
              tcpServer.close();
            });
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_3600
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_3600
     * @tc.desc Set other properties of the TCP Socket Server connection,keepAlive is true; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_3600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_3600';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address:  '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            keepAlive: true,
          }

          let setExtraOptions = false;
          tcpServer.setExtraOptions(tcpExtraOptions,).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
            tcpServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_3700
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_3700
     * @tc.desc Set other properties of the TCP Socket Server connection,OOBlnLine is true; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_3700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_3700';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address:  '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            OOBInline: true,
          }

          let setExtraOptions = false;
          tcpServer.setExtraOptions(tcpExtraOptions,).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
            tcpServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_3800
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_3800
     * @tc.desc Set other properties of the TCP Socket Server connection,TCPNoDelay is true; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_3800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_3800';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address:  '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            TCPNoDelay: true,
          }

          let setExtraOptions = false;
          tcpServer.setExtraOptions(tcpExtraOptions,).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
            tcpServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_3900
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_3900
     * @tc.desc Set other properties of the TCP Socket Server connection,receiveBufferSize is -1; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_3900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_3900';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address:  '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            receiveBufferSize: -1,
          }

          try{
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
              expect(err == null).assertTrue();
              tcpServer.close();
            });
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_4000
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_4000
     * @tc.desc Set other properties of the TCP Socket Server connection,receiveBufferSize is 0; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_4000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_4000';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address:  '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            receiveBufferSize: 0,
          }
          try{
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
              expect(err == null).assertTrue();
              tcpServer.close();
            });
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_4100
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_4100
     * @tc.desc Set other properties of the TCP Socket Server connection,receiveBufferSize is 100; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_4100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_4100';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address:  '0.0.0.0',
          port: 8080,
          family: 1
        }
        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            receiveBufferSize: 100,
          }

          try{
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
              expect(err == null).assertTrue();
              tcpServer.close();
            });
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_4200
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_4200
     * @tc.desc Set other properties of the TCP Socket Server connection,sendBufferSize is -1; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_4200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_4200';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address:  '0.0.0.0',
          port: 8080,
          family: 1
        }
        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            sendBufferSize: -1,
          }

          try{
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
              expect(err == null).assertTrue();
              tcpServer.close();
            });
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_4300
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_4300
     * @tc.desc Set other properties of the TCP Socket Server connection,sendBufferSize is 0; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_4300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_4300';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address:  '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            sendBufferSize: 0,
          }
          try{
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
              expect(err == null).assertTrue();
              tcpServer.close();
            });
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_4400
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_4400
     * @tc.desc Set other properties of the TCP Socket Server connection,sendBufferSize is 100; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_4400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_4400';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            sendBufferSize: 100,
          }

          try {
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
              expect(err == null).assertTrue();
              tcpServer.close();
            });
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_4500
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_4500
     * @tc.desc Set other properties of the TCP Socket Server connection,reuseAddress is true; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_4500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_4500';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            reuseAddress: true,
          }

          try {
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
              expect(err == null).assertTrue();
              tcpServer.close();
            });
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_4600
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_4600
     * @tc.desc Set other properties of the TCP Socket Server connection,reuseAddress is false; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_4600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_4600';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        await tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            reuseAddress: false,
          }

          try {
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
              expect(err == null).assertTrue();
              tcpServer.close();
              done();
            });
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
            done();
          }
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_4700
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_4700
     * @tc.desc Set other properties of the TCP Socket Server connection,socketTimeout is -1; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_4700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_4700';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            socketTimeout: -1,
          }

          try {
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
              expect(err == null).assertTrue();
              tcpServer.close();
            });
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_4800
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_4800
     * @tc.desc Set other properties of the TCP Socket Server connection,socketTimeout is 0; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_4800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_4800';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            socketTimeout: 0,
          }

          try {
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
              expect(err == null).assertTrue();
              tcpServer.close();
            });
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_4900
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_4900
     * @tc.desc Set other properties of the TCP Socket Server connection,socketTimeout is 100; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_4900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_4900';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            socketTimeout: 100,
          }

          try {
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
              expect(err == null).assertTrue();
              tcpServer.close();
            });
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_5000
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_5000
     * @tc.desc Set other properties of the TCP Socket Server connection,linger is 0; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_5000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_5000';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          interface SocketLinger {
            on: boolean;
            linger: number;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            socketLinger: { on: true, linger: 0 } as SocketLinger,
          }

          try {
            tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
              expect(err == null).assertTrue();
              tcpServer.close();
            });
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          }
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_5100
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_5100
     * @tc.desc Set other properties of the TCP Socket Server connection,linger is 65535; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_5100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_5100';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, (listenErr: BusinessError) => {
          if (listenErr) {
            console.error("listen failed:", listenErr.code, listenErr.message);
            expect().assertFail();
            tcpServer.close();
            done();
            return;
          }

          interface SocketLinger {
            on: boolean;
            linger: number;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            socketLinger: { on: true, linger: 65535 } as SocketLinger,
          };

          tcpServer.setExtraOptions(tcpExtraOptions, (err: BusinessError) => {
            try {
              expect(err == null).assertTrue();
            } catch (e) {
              console.error(`${caseName} setExtraOptions failed:`, err?.code, err?.message);
              expect().assertFail();
            } finally {
              tcpServer.close();
              done();
            }
          });
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_5200
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_5200
     * @tc.desc Set other properties of the TCP Socket Server connection,receiveBufferSize is -1; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_5200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_5200';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            receiveBufferSize: -1,
          }

          let setExtraOptions = false;
          tcpServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
            tcpServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_5300
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_5300
     * @tc.desc Set other properties of the TCP Socket Server connection,receiveBufferSize is 0; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_5300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_5300';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            receiveBufferSize: 0,
          }

          let setExtraOptions = false;
          tcpServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
            tcpServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_5400
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_5400
     * @tc.desc Set other properties of the TCP Socket Server connection,receiveBufferSize is 100; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_5400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_5400';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, async (listenErr: BusinessError) => {
          if (listenErr) {
            console.error("listen failed:", listenErr.code, listenErr.message);
            expect().assertFail();
            tcpServer.close();
            done();
            return;
          }
          let tcpExtraOptions: socket.TCPExtraOptions = {
            receiveBufferSize: 100,
          };
          try {
            await tcpServer.setExtraOptions(tcpExtraOptions);
            expect(true).assertTrue();
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          } finally {
            tcpServer.close();
            done();
          }
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_5500
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_5500
     * @tc.desc Set other properties of the TCP Socket Server connection,sendBufferSize is -1; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_5500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_5500';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            sendBufferSize: -1,
          }

          let setExtraOptions = false;
          tcpServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
            tcpServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_5600
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_5600
     * @tc.desc Set other properties of the TCP Socket Server connection,sendBufferSize is 0; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_5600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_5600';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }
          let tcpExtraOptions: socket.TCPExtraOptions = {
            sendBufferSize: 0,
          }
          let setExtraOptions = false;
          tcpServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
            tcpServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_5700
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_5700
     * @tc.desc Set other properties of the TCP Socket Server connection,sendBufferSize is 100; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_5700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_5700';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            sendBufferSize: 100,
          }

          let setExtraOptions = false;
          tcpServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
            tcpServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_5800
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_5800
     * @tc.desc Set other properties of the TCP Socket Server connection,reuseAddress is true; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_5800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_5800';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            reuseAddress: true,
          }

          let setExtraOptions = false;
          tcpServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
            tcpServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_5900
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_5900
     * @tc.desc Set other properties of the TCP Socket Server connection,reuseAddress is false; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_5900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_5900';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            reuseAddress: false,
          }

          let setExtraOptions = false;
          tcpServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
            tcpServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_6000
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_6000
     * @tc.desc Set other properties of the TCP Socket Server connection,socketTimeout is -1; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_6000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_6000';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            socketTimeout: -1
          }

          let setExtraOptions = false;
          tcpServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
            tcpServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_6100
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_6100
     * @tc.desc Set other properties of the TCP Socket Server connection,socketTimeout is 0; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_6100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_6100';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, async (listenErr: BusinessError) => {
          if (listenErr) {
            console.error("listen failed:", listenErr.code, listenErr.message);
            expect().assertFail();
            tcpServer.close();
            done();
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            socketTimeout: 0
          };

          try {
            await tcpServer.setExtraOptions(tcpExtraOptions);
            expect(true).assertTrue();
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          } finally {
            tcpServer.close();
            done();
          }
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_6200
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_6200
     * @tc.desc Set other properties of the TCP Socket Server connection,socketTimeout is 100; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_6200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_6200';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            socketTimeout: 100
          }

          let setExtraOptions = false;
          tcpServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
            tcpServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_6300
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_6300
     * @tc.desc Set other properties of the TCP Socket Server connection,linger is 0; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_6300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_6300';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        await tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          interface SocketLinger {
            on: boolean;
            linger: number;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            socketLinger: { on: true, linger: 0 } as SocketLinger,
          }

          let setExtraOptions = false;
          tcpServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
            tcpServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_SetExtraOptions_6400
     * @tc.name ArKUIX_TCPSocketServer_SetExtraOptions_6400
     * @tc.desc Set other properties of the TCP Socket Server connection,linger is 65535; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_SetExtraOptions_6400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_SetExtraOptions_6400';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }

        await tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.error("listen fail");
            return;
          }

          interface SocketLinger {
            on: boolean;
            linger: number;
          }

          let tcpExtraOptions: socket.TCPExtraOptions = {
            socketLinger: { on: true, linger: 65535 } as SocketLinger,
          }

          let setExtraOptions = false;
          tcpServer.setExtraOptions(tcpExtraOptions).then(() => {
            setExtraOptions = true;
            expect(setExtraOptions).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
          done();
        })
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_GetLocalAddress_0100
     * @tc.name ArKUIX_TCPSocketServer_GetLocalAddress_0100
     * @tc.desc Test the functionality of the getLocalAdress interface function
     * using the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_GetLocalAddress_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_GetLocalAddress_0100';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }
        try {
          await tcpServer.listen(listenAddr).then(() => {
            tcpServer.getLocalAddress().then((localAddress: socket.NetAddress) => {
              console.info("getLocalAddress success Address:" + JSON.stringify(localAddress));
              expect(localAddress != null).assertTrue();
            }).catch((err: BusinessError) => {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            })
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } finally {
          tcpServer.close();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_GetLocalAddress_0200
     * @tc.name ArKUIX_TCPSocketServer_GetLocalAddress_0200
     * @tc.desc Test for invalid file descriptors in getLocalAdress
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_GetLocalAddress_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_GetLocalAddress_0200';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }
        await tcpServer.listen(listenAddr).then(() => {
          if (tcpServer) {
            tcpServer.close();
            console.info("getLocalAddress tcpServer close success");
          } else {
            console.info('getLocalAddress TCPSocketServer is null');
            return;
          }
          setTimeout(() => {
            tcpServer.getLocalAddress().then((localAddress: socket.NetAddress) => {
              console.info("getLocalAddress success Address:" + JSON.stringify(localAddress));
              expect().assertFail();
            }).catch((err: BusinessError) => {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_NET_BAD_FILE_DESCRIPTOR).assertTrue();
              tcpServer.close();
            })
            done();
          }, 500);
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        });
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_GetSocketFd_0100
     * @tc.name ArKUIX_TCPSocketServer_GetSocketFd_0100
     * @tc.desc Test the functionality of the getSocketFd interface function
     * using the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_GetSocketFd_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_GetSocketFd_0100';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 11121,
          family: 1
        }
        await tcpServer.listen(listenAddr).then(() => {
          tcpServer.getSocketFd().then((data: number) => {
            console.info("getSocketFd success:" + JSON.stringify(data));
            expect(data >= 0).assertTrue();
            tcpServer.close();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
            tcpServer.close();
          })
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          tcpServer.close();
        });
        done();
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_On_Connect_0100
     * @tc.name ArKUIX_TCPSocketServer_On_Connect_0100
     * @tc.desc Test the functionality of the on interface function using the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_On_Connect_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_On_Connect_0100';
        try {
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 5022,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let callback: Callback<socket.TCPSocketConnection> = (data: socket.TCPSocketConnection) => {
            console.info(`${caseName} success data:${JSON.stringify(data)}`);
            expect(data.clientId !== null).assertTrue;
            tcp.close();
            tcpServer.close();
            done();
          };
          tcpServer.on('connect', callback);
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.info(`${caseName} fail ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TCPSocketServer_On_Connect_0200
     * @tc.name ArKUIX_TCPSocketServer_On_Connect_0200
     * @tc.desc When the test type is null, use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_On_Connect_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_On_Connect_0200';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        const listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        };

        await tcpServer.listen(listenAddr).then(() => {
          try {
            tcpServer.on(null, (data: socket.TCPSocketConnection) => {
              console.info(`on_connect success` + JSON.stringify(data));
            })
            expect().assertFail();
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            const errCode = Number(err.code);
            expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
            tcpServer.close();
          }
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        });
        done();
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_On_Connect_0300
     * @tc.name ArKUIX_TCPSocketServer_On_Connect_0300
     * @tc.desc When the test type is undefined, use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_On_Connect_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_On_Connect_0300';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        const listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        };

        await tcpServer.listen(listenAddr).then(() => {
          try {
            tcpServer.on(undefined, (data: socket.TCPSocketConnection) => {
              console.info(`on_connect success` + JSON.stringify(data));
            })
            expect().assertFail();
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            const errCode = Number(err.code);
            expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
            tcpServer.close();
          }
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        });
        done();
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_On_Connect_0400
     * @tc.name ArKUIX_TCPSocketServer_On_Connect_0400
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_On_Connect_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_On_Connect_0400';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        const listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        };

        await tcpServer.listen(listenAddr).then(() => {
          try {
            tcpServer.on('connect', undefined);
            expect().assertFail();
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            const errCode = Number(err.code);
            expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
            tcpServer.close();
          }
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        });
        done();
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_On_Connect_0500
     * @tc.name ArKUIX_TCPSocketServer_On_Connect_0500
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_On_Connect_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_On_Connect_0500';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        const listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        };

        await tcpServer.listen(listenAddr).then(() => {
          try {
            tcpServer.on('connect', null);
            expect().assertFail();
          } catch (err) {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            const errCode = Number(err.code);
            expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
            tcpServer.close();
          }
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        });
        done();
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Off_Connect_0100
     * @tc.name ArKUIX_TCPSocketServer_Off_Connect_0100
     * @tc.desc Test the functionality of the off interface function using the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Off_Connect_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Off_Connect_0100';

        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        expect(tcpServer).assertInstanceOf('Object');
        let listenAddress: socket.NetAddress = {
          address: '127.0.0.1',
          port: 8081,
          family: 1
        };
        try {
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let callback: Callback<socket.TCPSocketConnection> = (data: socket.TCPSocketConnection) => {
            console.info(`${caseName} success data:${JSON.stringify(data)}`);
            expect().assertFail();
            done();
          }
          tcpServer.on('connect', callback);
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.off('connect', callback);
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
          expect(true).assertTrue();
          done();
        } catch (err) {
          console.info(`${caseName} fail ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        } finally {
          tcp.close();
          tcpServer.close();
        }
      });

    /**
     * @tc.number ArKUIX_TCPSocketServer_Off_Connect_0200
     * @tc.name ArKUIX_TCPSocketServer_Off_Connect_0200
     * @tc.desc When the test type is null, use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Off_Connect_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Off_Connect_0200';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let connectCallback1 = () => {
          console.info('Off_Connect connectCallback1 success');
        }
        try {
          tcpServer.off(null, connectCallback1);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          tcpServer.close();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Off_Connect_0300
     * @tc.name ArKUIX_TCPSocketServer_Off_Connect_0300
     * @tc.desc When the test type is undefined, use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Off_Connect_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Off_Connect_0300';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let connectCallback1 = () => {
          console.info('Off_Connect connectCallback1 success');
        }
        try {
          tcpServer.off(undefined, connectCallback1);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          tcpServer.close();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Off_Connect_0400
     * @tc.name ArKUIX_TCPSocketServer_Off_Connect_0400
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Off_Connect_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Off_Connect_0400';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        try {
          tcpServer.off('connect', undefined);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          tcpServer.close();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Off_Connect_0500
     * @tc.name ArKUIX_TCPSocketServer_Off_Connect_0500
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Off_Connect_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Off_Connect_0500';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        try {
          tcpServer.off('connect', null);
          expect().assertFail();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          tcpServer.close();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Off_Connect_0600
     * @tc.name ArKUIX_TCPSocketServer_Off_Connect_0600
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Off_Connect_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Off_Connect_0600';
        try {
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          expect(tcpServer).assertInstanceOf('Object');
          let listenAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: 8081,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let callback: Callback<socket.TCPSocketConnection> = (data: socket.TCPSocketConnection) => {
            console.info(`${caseName} success data:${JSON.stringify(data)}`);
            expect().assertFail();
            done();
          }
          tcpServer.on('connect', callback);
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.off('connect');
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
          expect(true).assertTrue();
          done();
        } catch (err) {
          console.info(`${caseName} fail ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        }
      });

    /**
     * @tc.number ArKUIX_TCPSocketServer_Off_Connect_0700
     * @tc.name ArKUIX_TCPSocketServer_Off_Connect_0700
     * @tc.desc Test the functionality of the off special interface function using the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Off_Connect_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Off_Connect_0700';
        try {
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          expect(tcpServer).assertInstanceOf('Object');
          let listenAddress: socket.NetAddress = {
            address: '0.0.0.0',
            port: 8081,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let callback_1: Callback<socket.TCPSocketConnection> = (data: socket.TCPSocketConnection) => {
            console.info(`${caseName} success data:${JSON.stringify(data)}`);
            expect().assertFail();
            done();
          }
          let callback_2: Callback<socket.TCPSocketConnection> = (data: socket.TCPSocketConnection) => {
            console.info(`${caseName} success data:${JSON.stringify(data)}`);
            expect().assertFail();
            done();
          }
          tcpServer.on('connect', callback_1);
          tcpServer.on('connect', callback_2);
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.off('connect',);
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
          expect(true).assertTrue();
          done();
        } catch (err) {
          console.info(`${caseName} fail ${JSON.stringify(err)}`);
          expect().assertFail();
          done();
        }
      });
    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_0100
     * @tc.name ArKUIX_TCPSocketServer_Listen_0100
     * @tc.desc Test the functionality of the listen interface function using the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_0100';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }
        try {
          tcpServer.listen(listenAddr, (err: BusinessError) => {
            expect(err == null).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        } finally {
          tcpServer.close();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_0200
     * @tc.name ArKUIX_TCPSocketServer_Listen_0200
     * @tc.desc Bind IP address and port, bad address; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_0200';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '',
          port: 8080,
          family: 1
        }
        try {
          tcpServer.listen(listenAddr, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            } else {
              expect().assertFail();
              done();
            }
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        } finally {
          tcpServer.close();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_0300
     * @tc.name ArKUIX_TCPSocketServer_Listen_0300
     * @tc.desc Bind IP address and port, bad address; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_0300';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '11111',
          port: 8080,
          family: 1
        }
        try {
          tcpServer.listen(listenAddr, (err: BusinessError) => {
            if (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_ADDRESS_NOT_AVAILABLE || errCode === ERR_EIO).assertTrue();
              done();
            } else {
              expect().assertFail();
              done();
            }
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        } finally {
          tcpServer.close();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_0400
     * @tc.name ArKUIX_TCPSocketServer_Listen_0400
     * @tc.desc Bind IP address and port,Port  is undefined; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_0400';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: undefined,
          family: 1
        }
        try {
          tcpServer.listen(listenAddr, (err: BusinessError) => {
            expect(err == null).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        } finally {
          tcpServer.close();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_0500
     * @tc.name ArKUIX_TCPSocketServer_Listen_0500
     * @tc.desc Bind IP address and port,bad family; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_0500';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: undefined
        }
        try {
          tcpServer.listen(listenAddr, (err: BusinessError) => {
            expect(err == null).assertTrue();
            tcpServer.close();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_0600
     * @tc.name ArKUIX_TCPSocketServer_Listen_0600
     * @tc.desc Bind IP address and port, bad address; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_0600';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        try {
          tcpServer.listen(null, (err: BusinessError) => {
            expect().assertFail();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          tcpServer.close();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_0700
     * @tc.name ArKUIX_TCPSocketServer_Listen_0700
     * @tc.desc Bind IP address and port, bad address; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_0700';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        try {
          tcpServer.listen(undefined, (err: BusinessError) => {
            expect().assertFail();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          tcpServer.close();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_0800
     * @tc.name ArKUIX_TCPSocketServer_Listen_0800
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_0800';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 0,
          family: 1
        }
        let listen = false;
        tcpServer.listen(listenAddr).then(() => {
          listen = true;
          expect(listen).assertTrue();
          setTimeout(() => {
            tcpServer.close()
          }, 500);
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_0900
     * @tc.name ArKUIX_TCPSocketServer_Listen_0900
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_0900';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8088,
          family: 1
        }
        try {
          tcpServer.listen(listenAddr, undefined);
          expect().assertFail();
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          tcpServer.close();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_1000
     * @tc.name ArKUIX_TCPSocketServer_Listen_1000
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_1000';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8088,
          family: 1
        }
        try {
          tcpServer.listen(listenAddr, null);
          expect().assertFail();
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          tcpServer.close();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_1200
     * @tc.name ArKUIX_TCPSocketServer_Listen_1200
     * @tc.desc Test that listen cannot allocate the address of the request,
     * and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_1200';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '192.168.100.200',
          port: 8080,
          family: 1
        }
        tcpServer.listen(listenAddr, (err: BusinessError) => {
          if (err) {
            console.info(`${caseName} failed, error: ${err.message}`);
            const errCode = Number(err.code);
            expect(errCode === ERR_ADDRESS_NOT_AVAILABLE || errCode === ERR_EIO).assertTrue();
            tcpServer.close();
            done();
          } else {
            expect().assertFail();
            done();
          }
        })
        done();
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_1300
     * @tc.name ArKUIX_TCPSocketServer_Listen_1300
     * @tc.desc Test the functionality of the listen interface function using the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_1300';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8088,
          family: 1
        }
        let listen = false;
        await tcpServer.listen(listenAddr).then(() => {
          listen = true;
          expect(listen).assertTrue();
          tcpServer.close();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_1400
     * @tc.name ArKUIX_TCPSocketServer_Listen_1400
     * @tc.desc Bind IP address and port, bad address; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_1400';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '',
          port: 8088,
          family: 1
        }
        tcpServer.listen(listenAddr).then(() => {
          expect().assertFail();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          tcpServer.close();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_1500
     * @tc.name ArKUIX_TCPSocketServer_Listen_1500
     * @tc.desc Bind IP address and port, bad address; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_1500';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '11111',
          port: 8080,
          family: 1
        }
        tcpServer.listen(listenAddr).then(() => {
          expect().assertFail();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          if (isiOS) {
            expect(errCode === ERR_ADDRESS_NOT_SUPPORT || errCode == ERR_EIO).assertTrue();
          } else {
            expect(errCode === ERR_ADDRESS_NOT_AVAILABLE).assertTrue();
          }
          tcpServer.close();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_1600
     * @tc.name ArKUIX_TCPSocketServer_Listen_1600
     * @tc.desc Bind IP address and port,Port  is undefined; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_1600';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: undefined,
          family: 1
        }
        let listen = false;
        await tcpServer.listen(listenAddr).then(() => {
          listen = true;
          expect(listen).assertTrue();
          tcpServer.close();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });

      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_1700
     * @tc.name ArKUIX_TCPSocketServer_Listen_1700
     * @tc.desc Bind IP address and port,bad family; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_1700';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8088,
          family: undefined
        }
        let listen = false;
        await tcpServer.listen(listenAddr).then(() => {
          listen = true;
          expect(listen).assertTrue();
          tcpServer.close();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_1800
     * @tc.name ArKUIX_TCPSocketServer_Listen_1800
     * @tc.desc Bind IP address and port, bad address; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_1800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_1800';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        try {
          tcpServer.listen(null);
          expect().assertFail();
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          tcpServer.close();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_1900
     * @tc.name ArKUIX_TCPSocketServer_Listen_1900
     * @tc.desc Bind IP address and port, bad address; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_1900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_1900';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        try {
          tcpServer.listen(undefined);
          expect().assertFail();
          done();
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          tcpServer.close();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_2100
     * @tc.name ArKUIX_TCPSocketServer_Listen_2100
     * @tc.desc Test that listen cannot allocate the address of the request,
     * and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_2100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_2100';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '192.168.100.200',
          port: 8080,
          family: 1
        }
        await tcpServer.listen(listenAddr).then(() => {
          expect().assertFail();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          if (isiOS) {
            expect(errCode === ERR_ADDRESS_NOT_SUPPORT || errCode === ERR_EIO).assertTrue();
          } else {
            expect(errCode === ERR_ADDRESS_NOT_AVAILABLE).assertTrue();
          }
          tcpServer.close();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_2200
     * @tc.name ArKUIX_TCPSocketServer_Listen_2200
     * @tc.desc Bind IP address and port,Only fill in the address for IPV4; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_2200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_2200';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
        }
        try {
          tcpServer.listen(listenAddr, (err: BusinessError) => {
            expect(err == null).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        } finally {
          tcpServer.close();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_2300
     * @tc.name ArKUIX_TCPSocketServer_Listen_2300
     * @tc.desc Bind IP address and port,The address and protocol are both IPV6; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_2300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_2300';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '::',
          port: 8080,
          family: 2
        }
        try {
          tcpServer.listen(listenAddr, (err: BusinessError) => {
            expect(err == null).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        } finally {
          tcpServer.close();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_2400
     * @tc.name ArKUIX_TCPSocketServer_Listen_2400
     * @tc.desc Bind IP address and port,Port number is -1; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_2400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_2400';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: -1,
          family: 1
        }
        try {
          tcpServer.listen(listenAddr, (err: BusinessError) => {
            expect(err == null).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        } finally {
          tcpServer.close();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_2500
     * @tc.name ArKUIX_TCPSocketServer_Listen_2500
     * @tc.desc Bind IP address and port,Port number is 0; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_2500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_2500';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 0,
          family: 1
        }
        try {
          tcpServer.listen(listenAddr, (err: BusinessError) => {
            expect(err == null).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        } finally {
          tcpServer.close();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_2600
     * @tc.name ArKUIX_TCPSocketServer_Listen_2600
     * @tc.desc Bind IP address and port,Port number is 65535; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_2600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_2600';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 65535,
          family: 1
        }
        try {
          tcpServer.listen(listenAddr, (err: BusinessError) => {
            expect(err == null).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        } finally {
          tcpServer.close();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_2700
     * @tc.name ArKUIX_TCPSocketServer_Listen_2700
     * @tc.desc Bind IP address and port,Port number is 65536; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_2700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_2700';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 65536,
          family: 1
        }
        try {
          tcpServer.listen(listenAddr, (err: BusinessError) => {
            expect(err == null).assertTrue();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        } finally {
          tcpServer.close();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_2800
     * @tc.name ArKUIX_TCPSocketServer_Listen_2800
     * @tc.desc Bind IP address and port,Only fill in the address for IPV4; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_2800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_2800';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
        }
        let listen = false;
        tcpServer.listen(listenAddr).then(() => {
          listen = true;
          expect(listen).assertTrue();
          tcpServer.close();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_2900
     * @tc.name ArKUIX_TCPSocketServer_Listen_2900
     * @tc.desc Bind IP address and port,The address and protocol are both IPV6; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_2900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_2900';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '::',
          port: 8080,
          family: 2
        }
        let listen = false;
        tcpServer.listen(listenAddr).then(() => {
          listen = true;
          expect(listen).assertTrue();
          tcpServer.close();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_3000
     * @tc.name ArKUIX_TCPSocketServer_Listen_3000
     * @tc.desc Bind IP address and port,Port number is -1; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_3000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_3000';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: -1,
          family: 1
        }
        let listen = false;
        tcpServer.listen(listenAddr).then(() => {
          listen = true;
          expect(listen).assertTrue();
          tcpServer.close();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_3100
     * @tc.name ArKUIX_TCPSocketServer_Listen_3100
     * @tc.desc Bind IP address and port,Port number is 0; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_3100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_3100';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 0,
          family: 1
        }
        let listen = false;
        tcpServer.listen(listenAddr).then(() => {
          listen = true;
          expect(listen).assertTrue();
          tcpServer.close();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_3200
     * @tc.name ArKUIX_TCPSocketServer_Listen_3200
     * @tc.desc Bind IP address and port,Port number is 65535; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_3200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_3200';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 65535,
          family: 1
        }
        let listen = false;
        tcpServer.listen(listenAddr).then(() => {
          listen = true;
          expect(listen).assertTrue();
          tcpServer.close();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_3300
     * @tc.name ArKUIX_TCPSocketServer_Listen_3300
     * @tc.desc Bind IP address and port,Port number is 65536; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_3300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_3300';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 65536,
          family: 1
        }
        let listen = false;
        tcpServer.listen(listenAddr).then(() => {
          listen = true;
          expect(listen).assertTrue();
          tcpServer.close();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_3400
     * @tc.name ArKUIX_TCPSocketServer_Listen_3400
     * @tc.desc Bind IP address and port,Address and protocol inversion; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_3400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_3400';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 65536,
          family: 3
        }
        tcpServer.listen(listenAddr).then(() => {
          expect().assertFail();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          const errCode = Number(err.code);
          expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
          tcpServer.close();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_3500
     * @tc.name ArKUIX_TCPSocketServer_Listen_3500
     * @tc.desc Bind IP address and port, bad family; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_3500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_3500';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 4
        }
        try {
          tcpServer.listen(listenAddr, (err: BusinessError) => {
            expect(err == null).assertTrue();
            tcpServer.close();
            done();
          })
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
        } finally {
          tcpServer.close();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_3600
     * @tc.name ArKUIX_TCPSocketServer_Listen_3600
     * @tc.desc Bind IP address and port, bad family; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_3600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_3600';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8081,
          family: 4
        }
        let listen_1 = false;
        try {
          tcpServer.listen(listenAddr).then(() => {
            listen_1 = true;
            expect(listen_1).assertTrue();
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
          });
        } finally {
          tcpServer.close();
          done();
        }
        done();
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Listen_3700
     * @tc.name ArKUIX_TCPSocketServer_Listen_3700
     * @tc.desc Bind IP address and port,Only fill in the address for IPV6; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Listen_3700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Listen_3700';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '::',
        }
        tcpServer.listen(listenAddr).then(() => {
          expect().assertFail();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect(err.code === ERR_CODE_PARAMETER_ERROR).assertTrue();
          tcpServer.close();
          done();
        });
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Close_0100
     * @tc.name ArKUIX_TCPSocketServer_Close_0100
     * @tc.desc Test the functionality of the close interface function and then call the close method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Close_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Close_0100';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }
        await tcpServer.listen(listenAddr).then(() => {
          console.info('Close listen success');
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });

        tcpServer.getState().then((data: socket.SocketStateBase) => {
          console.info('Close getState success' + JSON.stringify(data));
        }).catch((err: BusinessError) => {
          console.info('getState fail' + JSON.stringify(err));
          expect().assertFail();
          done();
        });
        let close = false;
        tcpServer.close().then(() => {
          tcpServer.getState().then((data: socket.SocketStateBase) => {
            console.info('Close getState success' + JSON.stringify(data));
          }).catch((err: BusinessError) => {
            console.info('getState fail' + JSON.stringify(err));
            expect().assertFail();
            done();
          });
          close = true;
          expect(close).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
        sleep(500)
      })

    /**
     * @tc.number ArKUIX_TCPSocketServer_Close_0200
     * @tc.name ArKUIX_TCPSocketServer_Close_0200
     * @tc.desc Test by calling the listen method multiple times and then the close method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketServer_Close_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketServer_Close_0200';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let listenAddr: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8080,
          family: 1
        }
        let listenAddr1: socket.NetAddress = {
          address: '0.0.0.0',
          port: 8081,
          family: 1
        }
        await tcpServer.listen(listenAddr).then(() => {
          tcpServer.getLocalAddress().then((localAddress: socket.NetAddress) => {
            console.error("Close SUCCESS! Address:" + JSON.stringify(localAddress));
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
            done();
          })
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });

        await tcpServer.listen(listenAddr1).then(() => {
          tcpServer.getLocalAddress().then((localAddress: socket.NetAddress) => {
            console.error("Close SUCCESS! Address:" + JSON.stringify(localAddress));
          }).catch((err: BusinessError) => {
            console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
            expect().assertFail();
            done();
          })
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });

        let close = false;
        tcpServer.close().then(() => {
          tcpServer.getState().then((data: socket.SocketStateBase) => {
            console.error('Close getState success' + JSON.stringify(data));
          }).catch((err: BusinessError) => {
            console.error('getState fail' + JSON.stringify(err));
            expect().assertFail();
            done();
          });
          close = true;
          expect(close).assertTrue();
          done();
        }).catch((err: BusinessError) => {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        });
      })
  })
}