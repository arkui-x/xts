/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

import { describe, it, expect, Level, Size, TestType } from '@ohos/hypium';
import socket from "@ohos.net.socket";
import { BusinessError, Callback } from '@ohos.base';

function expectSuccess(): void {
  expect(true).assertTrue();
}

function expectFail(info: string = ''): void {
  try {
    expect(false).assertTrue();
  } catch (err) {
    console.info(`${info} test failed`);
  }
};

export default function TCPSocketTest() {
  describe('ActsTCPSocketTest', () => {

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_TCPSOCKET_OFFMESSAGE_0100
     * @tc.name   : testNetworkMgrSocketTCPSocketOffMessage0100
     * @tc.desc   : Unsubscribe from receiving message events for TCPSocket connections,After a subscription
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : level 2
     */
    it('testNetworkMgrSocketTCPSocketOffMessage0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketTCPSocketOffMessage0100';
        try {
          console.info(`${caseName} test start`);
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          expect(tcp).assertInstanceOf('Object');
          let bindAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 4094
          };
          await tcp.bind(bindAddress).catch((err: BusinessError) => {
            console.info('fail to bind' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: bindAddress,
          };
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
          let tcpSendOptions: socket.TCPSendOptions = {
            data: 'Hello, client!',
            encoding: 'UTF-8'
          };
          let callback: Callback<socket.SocketMessageInfo> = () => {
            expectFail();
            console.info(`${caseName} test end`);
            done();
          };
          tcp.on('message', callback);
          tcp.off('message', callback);
          await tcp.send(tcpSendOptions).catch((err: BusinessError) => {
            console.info('fail to send' + err.code.toString());
          });
          await tcp.close().catch((err: BusinessError) => {
            console.info('fail to close' + err.code.toString());
          });
          expectSuccess();
          done();
        } catch (err) {
          console.info(`${caseName}_catch fail err:${JSON.stringify(err)}`);
          expectFail();
          console.info(`${caseName} test end`);
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_TCPSOCKET_OFFMESSAGE_0200
     * @tc.name   : testNetworkMgrSocketTCPSocketOffMessage0200
     * @tc.desc   : Unsubscribe from receiving message events for TCPSocket connections,After Subscribing multiple times
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : level 2
     */
    it('testNetworkMgrSocketTCPSocketOffMessage0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketTCPSocketOffMessage0200';
        try {
          console.info(`${caseName} test start`);
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          expect(tcp).assertInstanceOf('Object');
          let bindAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 4095
          };
          await tcp.bind(bindAddress).catch((err: BusinessError) => {
            console.info('fail to bind' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: bindAddress,
          };
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
          let tcpSendOptions: socket.TCPSendOptions = {
            data: 'Hello, client!',
            encoding: 'UTF-8'
          };
          let callback1: Callback<socket.SocketMessageInfo> = () => {
            expectFail();
            console.info(`${caseName} callback1 test end`);
            done();
          };
          let callback2: Callback<socket.SocketMessageInfo> = () => {
            expectFail();
            console.info(`${caseName} callback2 test end`);
            done();
          };
          tcp.on('message', callback1);
          tcp.on('message', callback2);
          tcp.off('message');
          await tcp.send(tcpSendOptions).catch((err: BusinessError) => {
            console.info('fail to send' + err.code.toString());
          });
          expectSuccess();
          await tcp.close().catch((err: BusinessError) => {
            console.info('fail to close' + err.code.toString());
          });
          done();
        } catch (err) {
          console.info(`${caseName}_catch fail err:${JSON.stringify(err)}`);
          expectFail();
          console.info(`${caseName} test end`);
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_TCPSOCKET_OFFCONNECT_0100
     * @tc.name   : testNetworkMgrSocketTCPSocketOffConnect0100
     * @tc.desc   : Unsubscribe from TCP Socket connection events,After a subscription
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : level 2
     */
    it('testNetworkMgrSocketTCPSocketOffConnect0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketTCPSocketOffConnect0100';
        try {
          console.info(`${caseName} test start`);
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          expect(tcp).assertInstanceOf('Object');
          let bindAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 4098
          };
          await tcp.bind(bindAddress).catch((err: BusinessError) => {
            console.info('fail to bind' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: bindAddress,
          };
          let callback: Callback<void> = async () => {
            expectFail();
            console.info(`${caseName} test end`);
            done();
          };
          tcp.on('connect', callback);
          tcp.off('connect', callback);
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
          expectSuccess();
          console.info(`${caseName} test end`);
          done();
        } catch (err) {
          console.info(`${caseName}_catch fail err:${JSON.stringify(err)}`);
          expectFail();
          console.info(`${caseName} test end`);
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_TCPSOCKET_OFFCONNECT_0200
     * @tc.name   : testNetworkMgrSocketTCPSocketOffConnect0200
     * @tc.desc   :  Unsubscribe from TCP Socket connection events,After Subscribing multiple times
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : level 2
     */
    it('testNetworkMgrSocketTCPSocketOffConnect0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketTCPSocketOffConnect0200';
        try {
          console.info(`${caseName} test start`);
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          expect(tcp).assertInstanceOf('Object');
          let bindAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 4099
          };
          await tcp.bind(bindAddress).catch((err: BusinessError) => {
            console.info('fail to bind' + err.code.toString());
          });
          let tcpConnectOptions: socket.TCPConnectOptions = {
            address: bindAddress,
          };
          let callback1: Callback<void> = async () => {
            expectFail();
            console.info(`${caseName} test end`);
            done();
          };
          let callback2: Callback<void> = async () => {
            expectFail();
            console.info(`${caseName} test end`);
            done();
          };
          tcp.on('connect', callback1);
          tcp.on('connect', callback2);
          tcp.off('connect');
          await tcp.connect(tcpConnectOptions).catch((err: BusinessError) => {
            console.info('fail to connect' + err.code.toString());
          });
          expectSuccess();
          console.info(`${caseName} test end`);
          done();
        } catch (err) {
          console.info(`${caseName}_catch fail err:${JSON.stringify(err)}`);
          expectFail();
          console.info(`${caseName} test end`);
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_TCPSOCKET_OFFCLOSE_0100
     * @tc.name   : testNetworkMgrSocketTCPSocketOffClose0100
     * @tc.desc   : Unsubscribe from the closing event of TCPSocket,After a subscription
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : level 2
     */
    it('testNetworkMgrSocketTCPSocketOffClose0100', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketTCPSocketOffClose0100';
        try {
          console.info(`${caseName} test start`);
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          expect(tcp).assertInstanceOf('Object');
          let bindAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 4102
          };
          await tcp.bind(bindAddress).catch((err: BusinessError) => {
            console.info('fail to bind' + err.code.toString());
          });
          let callback: Callback<void> = async () => {
            expectFail();
            console.info(`${caseName} test end`);
            done();
          };
          tcp.on('close', callback);
          tcp.off('close', callback);
          await tcp.close().catch((err: BusinessError) => {
            console.info('fail to close' + err.code.toString());
          });
          expectSuccess();
          console.info(`${caseName} test end`);
          done();
        } catch (err) {
          console.info(`${caseName}_catch fail err:${JSON.stringify(err)}`);
          expectFail();
          console.info(`${caseName} test end`);
          done();
        }
      });

    /**
     * @tc.number : SUB_NETWORKMGR_SOCKET_TCPSOCKET_OFFCLOSE_0200
     * @tc.name   : testNetworkMgrSocketTCPSocketOffClose0200
     * @tc.desc   : Unsubscribe from the closing event of TCPSocket,After Subscribing multiple times
     * @tc.size   : MediumTest
     * @tc.type   : Function
     * @tc.level  : level 2
     */
    it('testNetworkMgrSocketTCPSocketOffClose0200', TestType.FUNCTION | Size.MEDIUMTEST | Level.LEVEL2,
      async (done: Function) => {
        let caseName: string = 'testNetworkMgrSocketTCPSocketOffClose0200';
        try {
          console.info(`${caseName} test start`);
          let tcp: socket.TCPSocket = socket.constructTCPSocketInstance();
          expect(tcp).assertInstanceOf('Object');
          let bindAddress: socket.NetAddress = {
            address: '127.0.0.1',
            port: 4103
          };
          await tcp.bind(bindAddress).catch((err: BusinessError) => {
            console.info('fail to bind' + err.code.toString());
          });
          let callback1: Callback<void> = async () => {
            expectFail();
            console.info(`${caseName} test end`);
            done();
          };
          let callback2: Callback<void> = async () => {
            expectFail();
            console.info(`${caseName} test end`);
            done();
          };
          tcp.on('close', callback1);
          tcp.on('close', callback2);
          tcp.off('close');
          await tcp.close().catch((err: BusinessError) => {
            console.info('fail to close' + err.code.toString());
          });
          expectSuccess();
          console.info(`${caseName} test end`);
          done();
        } catch (err) {
          console.info(`${caseName}_catch fail err:${JSON.stringify(err)}`);
          expectFail();
          console.info(`${caseName} test end`);
          done();
        }
      });
  })
}