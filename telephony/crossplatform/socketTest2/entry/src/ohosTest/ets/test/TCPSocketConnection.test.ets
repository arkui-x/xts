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

import { describe, it, expect, Level, TestType, Size ,beforeEach } from '@ohos/hypium';
import { socket } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { common } from '@kit.AbilityKit';

const ERR_CODE_PARAMETER_ERROR = 401;
const ERR_NET_BAD_FILE_DESCRIPTOR = 2301009;

function sleep(ms:number) {
  return new Promise<ESObject>(resolve => setTimeout(resolve, ms));
}

export default function TCPSocketConnectionTest() {
  describe('TCPSocketConnectionTest', () => {
    beforeEach(async () => {
      await sleep(500);
    });

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_0100
     * @tc.name ArKUIX_TCPSocketConnection_Send_0100
     * @tc.desc Sending data through TCP Socket Connection connection,Sending data as a string;callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_0100';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14000,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: 'Hello, client!'
            };
            client.send(tcpSendOption, (err: BusinessError) => {
              if (err) {
                console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info(`${caseName} success`);
                expect(err == null).assertTrue();
                tcp.close();
                tcpServer.close();
                done();
              }
              tcpServer.off('connect');
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_0200
     * @tc.name ArKUIX_TCPSocketConnection_Send_0200
     * @tc.desc Sending data through TCP Socket Connection connection,Sending data as " ";callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_0200';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14001,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: " "
            };
            client.send(tcpSendOption, (err: BusinessError) => {
              if (err) {
                console.info(`${caseName} fail err:${JSON.stringify(err)}`);
                expect().assertFail();
                done();
              } else {
                console.info(`${caseName} success`);
                expect(tcpSendOption.data == " ").assertTrue();
                done();
              }
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_0300
     * @tc.name ArKUIX_TCPSocketConnection_Send_0300
     * @tc.desc Sending data through TCP Socket Connection connection,Sending data as "11111";callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_0300';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14002,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: "11111"
            };
            client.send(tcpSendOption, (err: BusinessError) => {
              if (err) {
                console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info(`${caseName} success`);
                expect(tcpSendOption.data == "11111").assertTrue();
                done();
              }
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_0400
     * @tc.name ArKUIX_TCPSocketConnection_Send_0400
     * @tc.desc Sending data through TCP Socket Connection connection,Encoding format is UTF-8; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_0400';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14003,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: 'Hello, client!',
              encoding: 'UTF-8'
            };
            client.send(tcpSendOption, (err: BusinessError) => {
              if (err) {
                console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info(`${caseName} success`);
                expect(err == null).assertTrue();
                done();
              }
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_0500
     * @tc.name ArKUIX_TCPSocketConnection_Send_0500
     * @tc.desc Sending data through TCP Socket Connection connection,Encoding format is UTF-16BE; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_0500';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14004,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: 'Hello, client!',
              encoding: 'UTF-16BE'
            };
            client.send(tcpSendOption, (err: BusinessError) => {
              if (err) {
                console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info(`${caseName} success`);
                expect(err == null).assertTrue();
                done();
              }
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_0600
     * @tc.name ArKUIX_TCPSocketConnection_Send_0600
     * @tc.desc Sending data through TCP Socket Connection connection,Encoding format is UTF-16LE; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_0600';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14005,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: 'Hello, client!',
              encoding: 'UTF-16LE'
            };
            client.send(tcpSendOption, (err: BusinessError) => {
              if (err) {
                console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info(`${caseName} success`);
                expect(err == null).assertTrue();
                done();
              }
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_0700
     * @tc.name ArKUIX_TCPSocketConnection_Send_0700
     * @tc.desc Sending data through TCP Socket Connection connection,Encoding format is UTF-16; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_0700';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14006,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: 'Hello, client!',
              encoding: 'UTF-16'
            };
            client.send(tcpSendOption, (err: BusinessError) => {
              if (err) {
                console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info(`${caseName} success`);
                expect(err == null).assertTrue();
                done();
              }
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_0800
     * @tc.name ArKUIX_TCPSocketConnection_Send_0800
     * @tc.desc Sending data through TCP Socket Connection connection,Encoding format is US-AECII; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_0800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_0800';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14007,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: 'Hello, client!',
              encoding: 'US-AECII'
            };
            client.send(tcpSendOption, (err: BusinessError) => {
              if (err) {
                console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info(`${caseName} success`);
                expect(err == null).assertTrue();
                done();
              }
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_0900
     * @tc.name ArKUIX_TCPSocketConnection_Send_0900
     * @tc.desc Sending data through TCP Socket Connection connection,Encoding format is ISO-8859-1; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_0900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_0900';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14008,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: 'Hello, client!',
              encoding: 'ISO-8859-1'
            };
            client.send(tcpSendOption, (err: BusinessError) => {
              if (err) {
                console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info(`${caseName} success`);
                expect(err == null).assertTrue();
                done();
              }
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_1000
     * @tc.name ArKUIX_TCPSocketConnection_Send_1000
     * @tc.desc Sending data through TCP Socket Connection connection,Encoding format is undefined; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_1000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_1000';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14009,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: 'Hello, client!',
              encoding: undefined
            };
            client.send(tcpSendOption, (err: BusinessError) => {
              if (err) {
                console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info(`${caseName} success`);
                expect(err == null).assertTrue();
                done();
              }
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_1100
     * @tc.name ArKUIX_TCPSocketConnection_Send_1100
     * @tc.desc Sending data through TCP Socket Connection connection,Encoding format is an empty string; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_1100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_1100';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14010,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: 'Hello, client!',
              encoding: ''
            };
            client.send(tcpSendOption, (err: BusinessError) => {
              if (err) {
                console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info(`${caseName} success`);
                expect(err == null).assertTrue();
                done();
              }
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_1200
     * @tc.name ArKUIX_TCPSocketConnection_Send_1200
     * @tc.desc Sending data through TCP Socket Connection connection,Encoding format is "11111"; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_1200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_1200';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14011,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: 'Hello, client!',
              encoding: '11111'
            };
            client.send(tcpSendOption, (err: BusinessError) => {
              if (err) {
                console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
                expect().assertFail();
                done();
              } else {
                console.info(`${caseName} success`);
                expect(err == null).assertTrue();
                done();
              }
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_1300
     * @tc.name ArKUIX_TCPSocketConnection_Send_1300
     * @tc.desc Test options as null and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_1300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_1300';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14012,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            try {
              client.send(null, (err: BusinessError) => {
              });
            } catch (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_1400
     * @tc.name ArKUIX_TCPSocketConnection_Send_1400
     * @tc.desc Test options as undefined and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_1400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_1400';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14013,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            try {
              client.send(undefined, (err: BusinessError) => {
              });
            } catch (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_1500
     * @tc.name ArKUIX_TCPSocketConnection_Send_1500
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_1500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_1500';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14014,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          let tcpSendOption: socket.TCPSendOptions = {
            data: 'Hello, client!'
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            try {
              client.send(tcpSendOption, undefined);
            } catch (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_1600
     * @tc.name ArKUIX_TCPSocketConnection_Send_1600
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_1600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_1600';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14015,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          let tcpSendOption: socket.TCPSendOptions = {
            data: 'Hello, client!'
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            try {
              client.send(tcpSendOption, null);
            } catch (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_1700
     * @tc.name ArKUIX_TCPSocketConnection_Send_1700
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_1700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_1700';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14016,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: 'Hello, client!'
            };
            let send = false;
            try{
              client.send(tcpSendOption)
              console.info(`${caseName} success`);
              send = true;
              expect(send).assertTrue();
            } catch(err){
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
            } finally {
              tcpServer.off('connect');
              done();
            }
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_1900
     * @tc.name ArKUIX_TCPSocketConnection_Send_1900
     * @tc.desc Sending data through TCP Socket Connection connection,Sending data as a string;promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_1900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_1900';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14018,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: 'Hello, client!'
            };
            let send = false;
            client.send(tcpSendOption).then(() => {
              console.info(`${caseName} success`);
              send = true;
              expect(send).assertTrue();
              done();
            }).catch((err: BusinessError) => {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
              done();
            }).finally(() => {
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_2000
     * @tc.name ArKUIX_TCPSocketConnection_Send_2000
     * @tc.desc Sending data through TCP Socket Connection connection,Sending data as " ";promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_2000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_2000';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14019,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: " "
            };
            let send = false;
            client.send(tcpSendOption).then(() => {
              console.info(`${caseName} success`);
              send = true;
              expect(send).assertTrue();
              done();
            }).catch((err: BusinessError) => {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
              done();
            }).finally(() => {
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_2100
     * @tc.name ArKUIX_TCPSocketConnection_Send_2100
     * @tc.desc Sending data through TCP Socket Connection connection,Sending data as "11111";promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_2100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_2100';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14020,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: "11111"
            };
            let send = false;
            client.send(tcpSendOption).then(() => {
              console.info(`${caseName} success`);
              send = true;
              expect(send).assertTrue();
              done();
            }).catch((err: BusinessError) => {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
              done();
            }).finally(() => {
              tcpServer.off('connect');
              done();
            });
          });
          tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_2200
     * @tc.name ArKUIX_TCPSocketConnection_Send_2200
     * @tc.desc Sending data through TCP Socket Connection connection,Encoding format is UTF-8; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_2200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_2200';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14021,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: 'Hello, client!',
              encoding: 'UTF-8'
            };
            let send = false;
            client.send(tcpSendOption).then(() => {
              console.info(`${caseName} success`);
              send = true;
              expect(send).assertTrue();
              done();
            }).catch((err: BusinessError) => {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
              done();
            }).finally(() => {
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_2300
     * @tc.name ArKUIX_TCPSocketConnection_Send_2300
     * @tc.desc Sending data through TCP Socket Connection connection,Encoding format is UTF-16BE; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_2300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_2300';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14022,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: 'Hello, client!',
              encoding: 'UTF-16BE'
            };
            let send = false;
            client.send(tcpSendOption).then(() => {
              console.info(`${caseName} success`);
              send = true;
              expect(send).assertTrue();
              done();
            }).catch((err: BusinessError) => {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
              done();
            }).finally(() => {
              tcpServer.off('connect');
              done();
            });
          });
          tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_2400
     * @tc.name ArKUIX_TCPSocketConnection_Send_2400
     * @tc.desc Sending data through TCP Socket Connection connection,Encoding format is UTF-16LE; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_2400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_2400';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14023,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: 'Hello, client!',
              encoding: 'UTF-16LE'
            };
            let send = false;
            client.send(tcpSendOption).then(() => {
              console.info(`${caseName} success`);
              send = true;
              expect(send).assertTrue();
              done();
            }).catch((err: BusinessError) => {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
              done();
            }).finally(() => {
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_2500
     * @tc.name ArKUIX_TCPSocketConnection_Send_2500
     * @tc.desc Sending data through TCP Socket Connection connection,Encoding format is UTF-16; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_2500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_2500';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14024,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: 'Hello, client!',
              encoding: 'UTF-16'
            };
            let send = false;
            client.send(tcpSendOption).then(() => {
              console.info(`${caseName} success`);
              send = true;
              expect(send).assertTrue();
              done();
            }).catch((err: BusinessError) => {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
              done();
            }).finally(() => {
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_2600
     * @tc.name ArKUIX_TCPSocketConnection_Send_2600
     * @tc.desc Sending data through TCP Socket Connection connection,Encoding format is US-AECII; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_2600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_2600';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14025,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: 'Hello, client!',
              encoding: 'US-AECII'
            };
            let send = false;
            client.send(tcpSendOption).then(() => {
              console.info(`${caseName} success`);
              send = true;
              expect(send).assertTrue();
              done();
            }).catch((err: BusinessError) => {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
              done();
            }).finally(() => {
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_2700
     * @tc.name ArKUIX_TCPSocketConnection_Send_2700
     * @tc.desc Sending data through TCP Socket Connection connection,Encoding format is ISO-8859-1; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_2700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_2700';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14026,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: 'Hello, client!',
              encoding: 'ISO-8859-1'
            };
            let send = false;
            client.send(tcpSendOption).then(() => {
              console.info(`${caseName} success`);
              send = true;
              expect(send).assertTrue();
              done();
            }).catch((err: BusinessError) => {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
              done();
            }).finally(() => {
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_2800
     * @tc.name ArKUIX_TCPSocketConnection_Send_2800
     * @tc.desc Sending data through TCP Socket Connection connection,Encoding format is undefined; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_2800', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_2800';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14027,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: 'Hello, client!',
              encoding: undefined
            };
            let send = false;
            client.send(tcpSendOption).then(() => {
              console.info(`${caseName} success`);
              send = true;
              expect(send).assertTrue();
              done();
            }).catch((err: BusinessError) => {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
              done();
            }).finally(() => {
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_2900
     * @tc.name ArKUIX_TCPSocketConnection_Send_2900
     * @tc.desc Sending data through TCP Socket Connection connection,Encoding format is an empty string; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_2900', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_2900';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14028,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: 'Hello, client!',
              encoding: ''
            };
            let send = false;
            client.send(tcpSendOption).then(() => {
              console.info(`${caseName} success`);
              send = true;
              expect(send).assertTrue();
              client.close();
              tcpServer.close();
              tcp.close();
              done();
            }).catch((err: BusinessError) => {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              expect().assertFail();
              done();
            }).finally(() => {
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_3000
     * @tc.name ArKUIX_TCPSocketConnection_Send_3000
     * @tc.desc Sending data through TCP Socket Connection connection,Encoding format is "11111"; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_3000', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_3000';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14029,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: 'Hello, client!',
              encoding: "11111"
            };
            let send = false;
            client.send(tcpSendOption).then(() => {
              console.info(`${caseName} success`);
              send = true;
              expect(send).assertTrue();
              done();
            }).catch((err: BusinessError) => {
              console.info(`${caseName} fail err:${JSON.stringify(err)}`);
              expect().assertFail();
              done();
            }).finally(() => {
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_3100
     * @tc.name ArKUIX_TCPSocketConnection_Send_3100
     * @tc.desc Test options as null and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_3100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_3100';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        try {
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14030,
            family: 1
          };
          await tcpServer.listen(listenAddress);
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            try {
              client.send(null).then(() => {
                expect().assertFail();
                done();
              });
            } catch (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          });
          await tcp.connect({ address: listenAddress });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_3200
     * @tc.name ArKUIX_TCPSocketConnection_Send_3200
     * @tc.desc Test options as undefined and use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_3200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_3200';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        try {
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14031,
            family: 1
          };
          await tcpServer.listen(listenAddress);
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            try {
              client.send(undefined).then(() => {
                expect().assertFail();
                done();
              });
            } catch (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              tcp.close();
              tcpServer.close();
              done();
            }
          });
          await tcp.connect({ address: listenAddress });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_3400
     * @tc.name ArKUIX_TCPSocketConnection_Send_3400
     * @tc.desc Sending data through TCP Socket Connection connection,Encoding format is GB2312; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_3400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_3400';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14033,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: 'Hello, client!',
              encoding: 'GB2312'
            };
            client.send(tcpSendOption, (err: BusinessError) => {
              if (err) {
                console.info(`${caseName} fail err:${JSON.stringify(err)}`);
                expect().assertFail();
                done();
              } else {
                console.info(`${caseName} success`);
                expect(err == null).assertTrue();
                tcp.close();
                tcpServer.close();
                done();
              }
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_3500
     * @tc.name ArKUIX_TCPSocketConnection_Send_3500
     * @tc.desc Sending data through TCP Socket Connection connection,input parameter type is arrayBuffer; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_3500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_3500';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14034,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: new ArrayBuffer(234)
            };
            client.send(tcpSendOption, (err: BusinessError) => {
              if (err) {
                console.info(`${caseName} fail err:${JSON.stringify(err)}`);
                expect().assertFail();
                done();
              } else {
                console.info(`${caseName} success`);
                expect(err == null).assertTrue();
                tcp.close();
                tcpServer.close();
                done();
              }
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Send_3600
     * @tc.name ArKUIX_TCPSocketConnection_Send_3600
     * @tc.desc Sending data through TCP Socket Connection connection,input parameter type is arrayBuffer; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Send_3600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Send_3600';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14035,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            let tcpSendOption: socket.TCPSendOptions = {
              data: new ArrayBuffer(234)
            };
            let send = false;
            client.send(tcpSendOption).then(() => {
              console.info(`${caseName} success`);
              send = true;
              expect(send).assertTrue();
              done();
            }).catch((err: BusinessError) => {
              console.info(`${caseName} fail err:${JSON.stringify(err)}`);
              expect().assertFail();
              done();
            }).finally(() => {
              tcpServer.off('connect');
              client.close();
              tcp.close();
              tcpServer.close();
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Close_0100
     * @tc.name ArKUIX_TCPSocketConnection_Close_0100
     * @tc.desc Close a connection established with TCP Socket; callback
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Close_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Close_0100';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14036,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            client.close((err: BusinessError) => {
              if (err) {
                console.info(`${caseName} fail err:${JSON.stringify(err)}`);
                expect().assertFail();
                done();
              } else {
                console.info(`${caseName} success`);
                expect(err == null).assertTrue();
                tcp.close();
                tcpServer.close();
                done();
              }
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Close_0200
     * @tc.name ArKUIX_TCPSocketConnection_Close_0200
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Close_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Close_0200';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14037,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            try {
              client.close(undefined);
            } catch (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              client.close();
              tcp.close();
              tcpServer.close();
              done();
            }
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Close_0300
     * @tc.name ArKUIX_TCPSocketConnection_Close_0300
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Close_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Close_0300';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14038,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            try {
              client.close(null);
            } catch (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              client.close();
              tcp.close();
              tcpServer.close();
              done();
            }
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Close_0400
     * @tc.name ArKUIX_TCPSocketConnection_Close_0400
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Close_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Close_0400';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14039,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            let close = false;
            client.close().then(() => {
              console.info(`${caseName} success`);
              close = true;
              expect(close).assertTrue();
              done();
            }).catch((err: BusinessError) => {
              console.info(`${caseName} fail err:${JSON.stringify(err)}`);
              expect().assertFail();
              done();
            }).finally(() => {
              tcpServer.off('connect');
              tcp.close();
              tcpServer.close();
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Close_0600
     * @tc.name ArKUIX_TCPSocketConnection_Close_0600
     * @tc.desc Close a connection established with TCP Socket; promise
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Close_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Close_0600';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14041,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            let close = false;
            client.close().then(() => {
              console.info(`${caseName} success`);
              close = true;
              expect(close).assertTrue();
              done();
            }).catch((err: BusinessError) => {
              console.info(`${caseName} fail err:${JSON.stringify(err)}`);
              expect().assertFail();
              done();
            }).finally(() => {
              tcpServer.off('connect');
              tcp.close();
              tcpServer.close();
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_GetRemoteAddress_0100
     * @tc.name ArKUIX_TCPSocketConnection_GetRemoteAddress_0100
     * @tc.desc Test the functionality of the getRemoteAddress interface function
     * using the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_GetRemoteAddress_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_GetRemoteAddress_0100';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let listenAddress: socket.NetAddress = {
          address: '127.0.0.1',
          port: 14043,
          family: 1
        };
        try {
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            client.getRemoteAddress((err: BusinessError, data: socket.NetAddress) => {
              if (err) {
                console.info(`${caseName} fail err:${JSON.stringify(err)}`);
                expect().assertFail();
                done();
              } else {
                console.info(`${caseName} success`);
                expect(data != null).assertTrue();
                done();
              }
              tcpServer.off('connect');
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        } finally {
          tcp.close();
          tcpServer.close();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_GetRemoteAddress_0200
     * @tc.name ArKUIX_TCPSocketConnection_GetRemoteAddress_0200
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_GetRemoteAddress_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_GetRemoteAddress_0200';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let listenAddress: socket.NetAddress = {
          address: '127.0.0.1',
          port: 14044,
          family: 1
        };
        try {
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            try {
              client.getRemoteAddress(undefined);
            } catch (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        } finally {
          tcp.close();
          tcpServer.close();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_GetRemoteAddress_0300
     * @tc.name ArKUIX_TCPSocketConnection_GetRemoteAddress_0300
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_GetRemoteAddress_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_GetRemoteAddress_0300';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let listenAddress: socket.NetAddress = {
          address: '127.0.0.1',
          port: 14045,
          family: 1
        };
        try {
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            try {
              client.getRemoteAddress(null);
            } catch (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            } finally {
              client.close();
            }
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        } finally {
          tcp.close();
          tcpServer.close();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_GetRemoteAddress_0400
     * @tc.name ArKUIX_TCPSocketConnection_GetRemoteAddress_0400
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_GetRemoteAddress_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_GetRemoteAddress_0400';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let listenAddress: socket.NetAddress = {
          address: '127.0.0.1',
          port: 14046,
          family: 1
        };
        try {
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            client.getRemoteAddress().then((data: socket.NetAddress) => {
              console.info(`${caseName} success`);
              expect(data != null).assertTrue();
              done();
            }).catch((err: BusinessError) => {
              console.info(`${caseName} fail err:${JSON.stringify(err)}`);
              expect().assertFail();
              done();
            }).finally(() => {
              tcpServer.off('connect');
              client.close();
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        } finally {
          tcp.close();
          tcpServer.close();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_GetRemoteAddress_0600
     * @tc.name ArKUIX_TCPSocketConnection_GetRemoteAddress_0600
     * @tc.desc Test the functionality of the getRemoteAddress interface function
     * using the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_GetRemoteAddress_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_GetRemoteAddress_0600';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        let listenAddress: socket.NetAddress = {
          address: '127.0.0.1',
          port: 14048,
          family: 1
        };
        try {
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            client.getRemoteAddress().then((data: socket.NetAddress) => {
              console.info(`${caseName} success`);
              expect(data != null).assertTrue();
              done();
            }).catch((err: BusinessError) => {
              console.info(`${caseName} fail err:${JSON.stringify(err)}`);
              expect().assertFail();
              done();
            }).finally(() => {
              tcpServer.off('connect');
              client.close();
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        } finally {
          tcp.close();
          tcpServer.close();
          done()
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_GetLocalAddress_0100
     * @tc.name ArKUIX_TCPSocketConnection_GetLocalAddress_0100
     * @tc.desc Test the functionality of the getLocalAddress interface function
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_GetLocalAddress_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_GetLocalAddress_0100';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14050,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            client.getLocalAddress().then((localAddress: socket.NetAddress) => {
              console.info(`${caseName} success`+ JSON.stringify(localAddress));
              expect(localAddress != null).assertTrue();
              tcp.close();
              tcpServer.close();
              done();
            }).catch((err: BusinessError) => {
              console.info(`${caseName} fail err:${JSON.stringify(err)}`);
              expect().assertFail();
              tcp.close();
              tcpServer.close();
              done();
            }).finally(() => {
              tcpServer.off('connect');
              tcp.close();
              tcpServer.close();
              done();
            });
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_GetLocalAddress_0200
     * @tc.name ArKUIX_TCPSocketConnection_GetLocalAddress_0200
     * @tc.desc The test file descriptor is invalid. Use the promise asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_GetLocalAddress_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_GetLocalAddress_0200';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14051,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            try {
              await client.close();
              await client.getLocalAddress();
              console.info(`${caseName} fail`);
              expect().assertFail();
              tcp.close();
              tcpServer.close();
              done();
            } catch (err) {
              await tcp.off('connect');
              await tcpServer.off('connect');
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_NET_BAD_FILE_DESCRIPTOR).assertTrue();
              tcp.close();
              tcpServer.close();
              done();
            }
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_GetSocketFd_0100
     * @tc.name ArKUIX_TCPSocketConnection_GetSocketFd_0100
     * @tc.desc Test the functionality of the getSocketFd interface function
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_GetSocketFd_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_GetSocketFd_0100';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14055,
            family: 1
          };
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };

          tcpServer.on('connect', (client: socket.TCPSocketConnection) => {
            console.info('TCP server received connection');
            client.getSocketFd().then((fd: number) => {
              console.info(`Socket FD：${fd}`);
              expect(fd >= 0).assertTrue();
              client.close();
              tcp.close();
              tcpServer.close();
              done();
            }).catch((err: BusinessError) => {
              console.error(`getSocketFd fail: ${err ? err.message : 'unknown error'},
              errorCode: ${err ? err.code : -1}`);
              client.close();
              tcp.close();
              tcpServer.close();
              expect().assertFail();
              done();
            });
          });

          tcpServer.on('error', (err: BusinessError) => {
            console.error(`Server error: ${err ? err.message : 'unknown error'}`);
            tcp.close();
            tcpServer.close();
            expect().assertFail();
            done();
          });

          tcpServer.listen(listenAddress, (err?: BusinessError) => {
            if (err) {
              console.error(`TCP server listen failed: ${err.message}, errorCode: ${err.code}`);
              tcp.close();
              tcpServer.close();
              expect().assertFail();
              done();
              return;
            }

            setTimeout(() => {
              tcp.connect(tcpConnectOptions).then(() => {
                console.info('TCP client connected successfully');
              }).catch((connectErr: BusinessError) => {
                console.error(`TCP client connect failed: ${connectErr ? connectErr.message : 'unknown error'},
                errorCode: ${connectErr ? connectErr.code : -1}`);
                tcp.close();
                tcpServer.close();
                expect().assertFail();
                done();
              });
            }, 100);
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err ? err.message : 'unknown error'}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_On_Close_0100
     * @tc.name ArKUIX_TCPSocketConnection_On_Close_0100
     * @tc.desc Subscription to the closure event of TCPSocketConnection
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_On_Close_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_On_Close_0100';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14052,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            let close = false;
            const callback: Callback<void> = () => {
              close = true;
              expect(close).assertTrue();
              tcpServer.off('connect');
              done();
            };
            client.on('close', callback);
            await client.close().catch((err: BusinessError) => {
              console.info('fail to close' + err.code.toString());
            });
            done();
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_On_Close_0200
     * @tc.name ArKUIX_TCPSocketConnection_On_Close_0200
     * @tc.desc The test type is null
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_On_Close_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_On_Close_0200';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14053,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            try {
              const callback: Callback<void> = () => {
              };
              client.on(null, callback);
              expect().assertFail();
              done();
            } catch (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            } finally {
              tcpServer.off('connect');
              await client.close().catch((err: BusinessError) => {
                console.info('fail to close' + err.code.toString());
              });
              tcp.close();
              tcpServer.close();
              done();
            }
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_On_Close_0300
     * @tc.name ArKUIX_TCPSocketConnection_On_Close_0300
     * @tc.desc The test type is undefined
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_On_Close_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_On_Close_0300';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        try {
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14054,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            try {
              const callback: Callback<void> = () => {
              };
              client.on(undefined, callback);
              expect().assertFail();
              done();
            } catch (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        } finally {
          tcp.close();
          tcpServer.close();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_On_Close_0400
     * @tc.name ArKUIX_TCPSocketConnection_On_Close_0400
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_On_Close_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_On_Close_0400';
        let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
        let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
        try {
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14055,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            try {
              client.on('close', undefined);
              expect().assertFail();
              done();
            } catch (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            }
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        } finally {
          tcp.close();
          tcpServer.close();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_On_Close_0500
     * @tc.name ArKUIX_TCPSocketConnection_On_Close_0500
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_On_Close_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_On_Close_0500';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14056,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            try {
              client.on('close', null);
              expect().assertFail();
              done();
            } catch (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            } finally {
              tcpServer.off('connect');
              await client.close().catch((err: BusinessError) => {
                console.info('fail to close' + err.code.toString());
              });
              tcp.close();
              tcpServer.close();
              done();
            }
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Off_Close_0100
     * @tc.name ArKUIX_TCPSocketConnection_Off_Close_0100
     * @tc.desc UnSubscription to the closure event of TCPSocketConnection
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Off_Close_0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Off_Close_0100';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14057,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            const callback: Callback<void> = () => {
              expect().assertFail();
              tcpServer.off('connect');
              done();
            };
            client.on('close', callback);
            client.off('close', callback);
            await client.close().catch((err: BusinessError) => {
              console.info('fail to close' + err.code.toString());
            });
            expect(true).assertTrue();
            done();
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Off_Close_0200
     * @tc.name ArKUIX_TCPSocketConnection_Off_Close_0200
     * @tc.desc The test type is null
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Off_Close_0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Off_Close_0200';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14058,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            try {
              const callback: Callback<void> = () => {
                expect().assertFail();
                done();
              };
              client.on('close', callback);
              client.off(null, callback);
              expect().assertFail();
              done();
            } catch (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            } finally {
              await client.close().catch((err: BusinessError) => {
                console.info('fail to close' + err.code.toString());
              });
              tcp.close();
              tcpServer.close();
              done();
            }
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Off_Close_0300
     * @tc.name ArKUIX_TCPSocketConnection_Off_Close_0300
     * @tc.desc The test type is undefined
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Off_Close_0300', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Off_Close_0300';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14059,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            try {
              const callback: Callback<void> = () => {
                expect().assertFail();
                done();
              };
              client.on('close', callback);
              client.off(undefined, callback);
              expect().assertFail();
              done();
            } catch (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            } finally {
              await client.close().catch((err: BusinessError) => {
                console.info('fail to close' + err.code.toString());
              });
              tcp.close();
              tcpServer.close();
              done();
            }
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Off_Close_0400
     * @tc.name ArKUIX_TCPSocketConnection_Off_Close_0400
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Off_Close_0400', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Off_Close_0400';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14060,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            try {
              const callback: Callback<void> = () => {
                expect().assertFail();
                done();
              };
              client.on('close', callback);
              client.off('close', undefined);
              expect().assertFail();
              done();
            } catch (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            } finally {
              await client.close().catch((err: BusinessError) => {
                console.info('fail to close' + err.code.toString());
              });
              tcp.close();
              tcpServer.close();
              done();
            }
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Off_Close_0500
     * @tc.name ArKUIX_TCPSocketConnection_Off_Close_0500
     * @tc.desc Test for error in the callback parameter type and use the callback asynchronous callback method
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 2
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Off_Close_0500', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Off_Close_0500';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14061,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            try {
              const callback: Callback<void> = () => {
                expect().assertFail();
                done();
              };
              client.on('close', callback);
              client.off('close', null);
              expect().assertFail();
              done();
            } catch (err) {
              console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
              const errCode = Number(err.code);
              expect(errCode === ERR_CODE_PARAMETER_ERROR).assertTrue();
              done();
            } finally {
              await client.close().catch((err: BusinessError) => {
                console.info('fail to close' + err.code.toString());
              });
              tcp.close();
              tcpServer.close();
              done();
            }
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Off_Close_0600
     * @tc.name ArKUIX_TCPSocketConnection_Off_Close_0600
     * @tc.desc The test did not pass the callback parameter
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Off_Close_0600', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Off_Close_0600';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14062,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            const callback: Callback<void> = () => {
              expect().assertFail();
              tcpServer.off('connect');
              done();
            };
            client.on('close', callback);
            client.off('close');
            await client.close().catch((err: BusinessError) => {
              console.info('fail to close' + err.code.toString());
            });
            expect(true).assertTrue();
            done();
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

    /**
     * @tc.number ArKUIX_TCPSocketConnection_Off_Close_0700
     * @tc.name ArKUIX_TCPSocketConnection_Off_Close_0700
     * @tc.desc Cancel multiple subscriptions to the TCP Socket Connection shutdown event
     * @tc.size MediumTest
     * @tc.type Function
     * @tc.level level 0
     * @tc.require
     */
    it('ArKUIX_TCPSocketConnection_Off_Close_0700', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL0,
      async (done: Function) => {
        const caseName: string = 'ArKUIX_TCPSocketConnection_Off_Close_0700';
        try {
          let tcpServer: socket.TCPSocketServer = socket.constructTCPSocketServerInstance();
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          let listenAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 14063,
            family: 1
          };
          await tcpServer.listen(listenAddress).catch((err: BusinessError) => {
            console.info('fail to listen' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: listenAddress
          };
          tcpServer.on('connect', async (client: socket.TCPSocketConnection) => {
            const callback1: Callback<void> = () => {
              expect().assertFail();
              tcpServer.off('connect');
              done();
            };
            const callback2: Callback<void> = () => {
              expect().assertFail();
              tcpServer.off('connect');
              done();
            };
            client.on('close', callback1);
            client.on('close', callback2);
            client.off('close', callback1);
            client.off('close');
            await client.close().catch((err: BusinessError) => {
              console.info('fail to close' + err.code.toString());
            });
            expect(true).assertTrue();
            done();
          });
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
        } catch (err) {
          console.error(`${caseName} failed, error: ${err.code}, ${err.message}`);
          expect().assertFail();
          done();
        }
      })

  })
}